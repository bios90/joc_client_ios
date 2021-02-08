import Foundation

class ModelOrder:Codable
{
    var id:Int?
    var created:Date?
    var updated:Date?
    var deleted:Date?
    var status:TypeOrderStatus?
    var date:Date?
    var cafe:ModelCafe?
    var sum:Double?
    var items:[ModelBasketItem]?
    var user:ModelUser?
   
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeInt(from: .id)
        self.created = try? container.decodeDate(from: .created)
        self.updated = try? container.decodeDate(from: .updated)
        self.deleted = try? container.decodeDate(from: .deleted)
        self.status = try? container.decodeObject(type: TypeOrderStatus.self, from: .status)
        self.date = try? container.decodeDate(from: .date)
        self.cafe = try? container.decodeObject(type: ModelCafe.self, from: .cafe)
        let sum_str = (try? container.decodeString(from: .sum)) ?? "0.0"
        self.sum = Double(sum_str)
        self.items = try? container.decodeArray(type: ModelBasketItem.self, from: .items)
        self.user = try? container.decodeObject(type: ModelUser.self, from: .cafe)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case created
        case updated
        case deleted
        case status
        case date
        case cafe
        case sum
        case items = "products"
        case user
    }
    
    func canBeCancelled()->Bool
    {
        return self.status == .new || self.status == .paid || self.status == .process
    }
}
