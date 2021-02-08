import Foundation

class RespOrderSingle:BaseResponse
{
    var order:ModelOrder?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order = try? values.decode(ModelOrder.self, forKey: .order)
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case order = "data"
    }
}
