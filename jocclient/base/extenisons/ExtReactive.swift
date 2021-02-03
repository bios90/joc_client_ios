import Foundation
import RxSwift
import RxCocoa
import Alamofire

public extension Observable
{
    func doFinally(_ action:@escaping()->())->Observable
    {
        return self.do(afterError:
            { _ in
                action()
        },afterCompleted:
            {
                action()
        })
    }
    
    func addScreenDisabling() ->  Observable
    {
        return self.do(onSubscribed:
            {
                MessagesManager.disableScreenTouches()
        }).doFinally(
            {
                MessagesManager.enableScreenTouches()
        })
    }
    
    func mainThreated()->Observable
    {
        return self
            .observeOn(MainScheduler.instance)
    }
    
    func addProgressDialog() -> Observable
    {
        return self.do(onSubscribed:
            {
                MessagesManager.showProgressNewDelayed()
        })
            .doFinally(
                {
                    MessagesManager.dismissProgressNewDelayed()
            })
    }
    
    func subscribeMy(_ action_success:@escaping(Element)->Void,_ action_error:((Error)->())? = nil)->Disposable
    {
        return self.subscribe(onNext:
            { element in
                
                action_success(element);
        },onError:
            { error in
                action_error?(error)
        })
    }
    
    func addMyErrorChecker() -> Observable
    {
        self.do(onError:
            { error in
                
                switch error
                {
                case RequestError.ErrConnection:
                    MessagesManager.showNoInternet()
                case RequestError.ErrServerFailed(let message):
                    MessagesManager.showRedAlerter(text: message)
                case RequestError.ErrJsonDecode:
                    MessagesManager.showRedAlerter(text: MyStrings.error_parsing.localized())
                case RequestError.ErrServer:
                    print("**** Got Error on Server Size with no message ****")
                    fallthrough
                default:
                    MessagesManager.showRedAlerter(text: MyStrings.error_default.localized())
                }
        })
    }
    
    func addParsingFilter(_ check:@escaping(Element)->Bool)->Observable
    {
        return self.map(
            { element in
                
                if(!check(element))
                {
                    throw RequestError.ErrJsonDecode
                }
                
                return element
        })
    }
}

extension Observable where Element == AFDataResponse<Data?>
{
    func addMyParser<T:BaseResponse>(type:T.Type) -> Observable<T>
    {
        self.map(
            { response in
                
                if let err = response.error
                {
                    if  let url_err = err as? URLError, url_err.code  == URLError.Code.notConnectedToInternet
                    {
                        throw RequestError.ErrConnection
                    }
                    
                    throw err
                }
                
                print("***** here1111 *****")
                
                guard let data = response.data else
                {
                    throw RequestError.ErrUnknown
                }
                
                print("***** here2222 *****")
                let str = String(decoding: data, as: UTF8.self)
                print(str)
                
                
                guard let base_response = try? JSONDecoder().decode(BaseResponse.self, from: data) else { throw RequestError.ErrJsonDecode }
                
                print("***** here2222 *****")
                if let error = base_response.getError()
                {
                    throw error
                }
                
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else { throw RequestError.ErrJsonDecode }
                
                return obj
        })
    }
}

