import Foundation

enum RequestError:Error
{
    case ErrConnection
    case ErrServer
    case ErrServerFailed(message:String)
    case ErrJsonDecode
    case ErrUnknown
    
    func getTextIfMyError()->String?
    {
        var text:String? = nil
        
        if case RequestError.ErrConnection = self
        {
            text =  MyStrings.no_internet_connection.localized()
        }
        else  if case RequestError.ErrServerFailed(let message) = self
        {
            text =  message
        }
        else  if case RequestError.ErrConnection = self
        {
            text =  "Возникла ошибка при выполнении запроса. Повторите позже."
        }
        else  if case RequestError.ErrJsonDecode = self
        {
            text =  "Возникла ошибка при обработке запроса."
        }
        
        return text
    }
}
