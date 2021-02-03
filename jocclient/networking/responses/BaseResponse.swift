import Foundation

class BaseResponse:Decodable
{
    var status:TypeResponseStatus = .Failed
    var message:[String]? = nil
    
    func isFailed()->Bool
    {
        return self.status == .Failed
    }
    
    func isSuccess() -> Bool
    {
        return status == .Success
    }
    
    func getErrorMessage()->String
    {
        if self.message == nil || self.message!.isEmpty
        {
            return "Неизвестная ошибка"
        }
        
        return listOfStringToSingle(strings: self.message!)
    }
    
    func getError()->RequestError?
    {
        if(self.isSuccess())
        {
            return nil
        }
        
        if let errors = self.message,errors.count > 0
        {
            print("Will return server error")
            let message = listOfStringToSingle(strings: errors)
            return RequestError.ErrServerFailed(message: message)
        }
        
        return RequestError.ErrUnknown
    }
}
