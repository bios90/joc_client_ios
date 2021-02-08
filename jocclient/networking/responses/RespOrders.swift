import Foundation

class RespOrders:BaseResponse
{
    var orders:[ModelOrder]? = []
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        orders = try? values.decodeArray(type: ModelOrder.self, from: .orders)
    }

    private enum CodingKeys: String, CodingKey
    {
        case orders = "data"
    }
}
