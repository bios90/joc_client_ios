import Foundation

class RespOrderPay:BaseResponse
{
    var pay_data:ModelOrderPayData?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pay_data = try? values.decodeObject(type: ModelOrderPayData.self, from: .pay_data)
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case pay_data = "data"
    }
}

class ModelOrderPayData:Codable
{
    var confirmation_url:String?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        confirmation_url = try? container.decodeString(from: .confirmation_url)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case confirmation_url
    }
}
