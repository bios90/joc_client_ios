import Foundation

class ModelReview:Codable
{
    var id:Int?
    var user:ModelUser?
    var rating:Int?
    var date:Date?
    var text:String?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try? container.decodeInt(from: .id)
        self.user = try? container.decodeObject(type: ModelUser.self, from: .user)
        self.rating = try? container.decodeInt(from: .rating)
        self.date = try? container.decodeDate(from: .date)
        self.text = try? container.decodeString(from: .text)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case user = "client"
        case rating
        case date
        case text
    }
}
