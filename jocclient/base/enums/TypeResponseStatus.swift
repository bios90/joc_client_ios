import Foundation

enum TypeResponseStatus:String, Decodable
{
    case Failed = "failed"
    case Error = "error"
    case Success = "success"
}
