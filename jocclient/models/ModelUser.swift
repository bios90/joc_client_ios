import Foundation

class ModelUser:Codable,ObjectWithId,ObjectWithDates
{
    var id:Int?
    var created: Date?
    var updated: Date?
    var deleted: Date?
    
    var name:String?
    var email:String?
    var api_token:String?
    var phone:String?
    var image:BaseImage?
    var count_cups:Int?
    var count_orders:Int?
    var count_reviews:Int?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.created = try? container.decodeDate(from: .created)
        self.updated = try? container.decodeDate(from: .updated)
        self.deleted = try? container.decodeDate(from: .deleted)
        
        self.name = try? container.decodeString(from: .name)
        self.email = try? container.decodeString(from: .email)
        self.api_token = try? container.decodeString(from: .api_token)
        self.phone = try? container.decodeString(from: .phone)
        
        self.image = try? container.decodeObject(type: BaseImage.self, from: .image)
        self.count_cups = try? container.decodeInt(from: .count_cups)
        self.count_orders = try? container.decodeInt(from: .count_orders)
        self.count_reviews = try? container.decodeInt(from: .count_reviews)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case created
        case deleted
        case updated
        case name
        case email
        case api_token
        case phone
        case image
        case count_cups =  "cups_count"
        case count_orders = "orders_count"
        case count_reviews = "reviews_count"
    }
}
