import Foundation

class RespUserSingle:BaseResponse
{
    var user:ModelUser?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try? values.decode(ModelUser.self, forKey: .user)
    }

    private enum CodingKeys: String, CodingKey
    {
        case user = "data"
    }
}
