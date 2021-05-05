import Foundation
import Alamofire
import RxSwift
import RxCocoa

class MyRequest
{
    var base_url = Constants.Urls.URL_BASE
    var method:HTTPMethod = .get
    var path:String = ""
    var parameters: [String : String?] = [:]
    var file_download_url:String!
    
    func getParamsWithoutNil()->[String:String]
    {
        var parameters_filtered: [String:String] = [:]
        parameters.forEach{ if $1 != nil { parameters_filtered[$0] = $1! } }
        return parameters_filtered
    }
    
    static func getHeaders()->HTTPHeaders
    {
        let token = LocalData.getCurrentUser()?.api_token ?? "B1ZpaLlhBgMQ9onHc05oCG8GNbYyIvtd"
        
        let headers:HTTPHeaders =
            [
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded",
                "App-Env": "ios",
                "Authorization": "Bearer \(token)"
        ]
        
        return headers
    }
}

//MARK: -For Networking
extension MyRequest
{
    func toObservable() ->Observable<AFDataResponse<Data?>>
    {
        let url = self.base_url+self.path
        
        return Observable<AFDataResponse<Data?>>.create
            {  observer in
                
                let headers = MyRequest.getHeaders()
                let redirector = Redirector(behavior: Redirector.Behavior.modify(
                { (task, urlRequest, resp) in
                    var urlRequest = urlRequest
                    headers.forEach
                        { header in
                            urlRequest.addValue(header.value, forHTTPHeaderField: header.name)
                    }
                    return urlRequest
                }))
                
                let request = AF.request(url,method: self.method,parameters: self.getParamsWithoutNil(),headers: headers)
                    .response(completionHandler:
                        { response in
                            
                            //                            if let data = response.data
                            //                            {
                            //                                let str = String(decoding: data, as: UTF8.self)
                            //                            }
                            
                            observer.onNext(response)
                            observer.onCompleted()
                    })
                    .redirect(using: redirector)
//                    .cURLDescription(calling:
//                        { curl in
//                            
//                            print(curl)
//                    })
                
                
                return Disposables.create
                    {
                        request.cancel()
                }
        }
    }
    
    func toObservableFileDownload() -> Observable<String?>
    {
        let url = self.file_download_url!
        print("url to download is \(url)")
        
        let file_name = (url as NSString).lastPathComponent
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(file_name)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        return Observable<String?>.create
            {  observer in
                
                let request = AF.download(
                    url,
                    method: .get,
                    encoding: JSONEncoding.default,
                    headers: nil,
                    to: destination)
                    .downloadProgress(closure: { (progress) in
                        
                    }).response(completionHandler: { response in
                        
                        print("error is \(response.error)")
                        if let file_url = response.fileURL
                        {
                            observer.onNext(file_url.absoluteString)
                            observer.onCompleted()
                        }
                        else
                        {
                            observer.onError(RequestError.ErrUnknown)
                        }
                    })
                
                return Disposables.create {
                    request.cancel()
                }
        }
    }
}

//MARK: - requests list
extension MyRequest
{
    static func getReqRegister(phone:String,push_token:String?)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.REGISTER
        req.method = .post
        req.parameters =
            [
                "phone" : phone,
                "push_token" : push_token
        ]
        
        return req
    }
    
    static func getReqCodeConfirm(phone:String,code:String)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_PHONE_CONFIRM
        req.method = .put
        req.parameters =
            [
                "phone" : phone,
                "code" : code
        ]
        
        return req
    }
    
    static func getReqLoadUser()->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_USER_INFO
        req.method = .get
        
        return req
    }
    
    static func getReqEditUser(name:String?,email:String?,push_token:String?,image_str:String?)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_USER_UPDATE
        req.method = .put
        req.parameters =
            [
                "name" : name,
                "email" : email,
                "push_token" : push_token,
                "image" : image_str
        ]
        
        return req
    }
    
    static func getReqLoadCafeById(cafe_id:Int)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_GET_CAFE_SINGLE+"/\(cafe_id)"
        req.method = .get
        return req
    }
    
    static func getReqOrderCreate(date:String,cafe_id:Int,comment:String?,items:String)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_CREATE
        req.method = .post
        req.parameters =
            [
                "date" : date,
                "comment" : comment,
                "items" : items,
                "cafeId": String(cafe_id)
        ]
        
        return req
    }
    
    static func getReqLoadCafes(lat:Double,lon:Double,distance:Int,min_price:Int?,max_price:Int?,rating:Double?,sort_by:TypeCafeSort?,sort_direction:TypeSortDirection?)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_GET_CAFES
        req.method = .get
        req.parameters =
            [
                "lat" : String(lat),
                "lng" : String(lon),
                "distance" : String(distance)
        ]
        
        if let min_price = min_price
        {
            req.parameters["min_price"] = String(min_price)
        }
        
        if let max_price = max_price
        {
            req.parameters["max_price"] = String(max_price)
        }
        
        if let rating = rating
        {
            //Todo add rating later when loaded
//            req.parameters["rating"] = String(rating)
        }
        
        if let sort_by = sort_by
        {
            req.parameters["order"] = sort_by.rawValue
        }
        
        if let sort_direction = sort_direction
        {
            req.parameters["order_direction"] = sort_direction.rawValue
        }
        
        return req
    }
    
    static func getReqPayOrder(order_id:Int,token:String)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_PAY+"/\(String(order_id))"
        req.method = .post
        req.parameters =
            [
                "token" : token
        ]
        
        return req
    }
    
    
    static func getReqUserOrders(offset:Int,limit:Int,statuses:String = "paid,process,ready,done,canceled")->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_GET_USER_ORDERS
        req.method = .get
        req.parameters =
            [
                "offset" : String(offset),
                "limit" :String(limit),
                "status": statuses
        ]
        
        return req
    }
    
    static func getReqLoadOrderById(order_id:Int)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_GET_INFO+"/\(order_id)"
        req.method = .get
        req.parameters = [:]
        
        return req
    }
    
    static func getReqMakeOrderReview(order_id:Int,cafe_id:Int,text:String?,rating:Int)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_MAKE_REVIEW+"/\(cafe_id)"
        req.method = .put
        req.parameters =
            [
                "order_id" : String(order_id),
                "text": text,
                "rating": String(rating)
        ]
        
        return req
    }
    
    static func getReqCancelOrder(order_id:Int)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.URL_ORDER_CANCEL+"/\(order_id)"
        req.method = .put
        req.parameters =
            [
                "order_id" : String(order_id),
                "status": TypeOrderStatus.canceled.rawValue
        ]
        
        return req
    }
    
}
