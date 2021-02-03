import Foundation

class RespCafeSingle:BaseResponse
{
    var cafe:ModelCafe?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cafe = try? values.decode(ModelCafe.self, forKey: .cafe)
    }

    private enum CodingKeys: String, CodingKey
    {
        case cafe = "data"
    }
}
