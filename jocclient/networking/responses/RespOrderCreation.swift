import Foundation

class RespOrderCreation:BaseResponse
{
    var order_data:ModelOrderIdData?
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order_data = try? values.decodeObject(type: ModelOrderIdData.self, from: .order_data)
    }
    
    private enum CodingKeys: String, CodingKey
    {
        case order_data = "data"
    }
}

class ModelOrderIdData:Codable
{
    var id:Int?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id_str = try? container.decodeString(from: .id)
        if let id_str = id_str
        {
            self.id = Int(id_str)
        }
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
    }
}
