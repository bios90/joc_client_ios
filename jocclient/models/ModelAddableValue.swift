import Foundation

class ModelAddableValue:NSObject, Codable,ObjectWithId
{
    var id:Int?
    var value:String?
    var price:Double?
    
    init(id:Int?,value:String?,price:Double?)
    {
        self.id = id
        self.value = value
        self.price = price
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.value = try? container.decodeString(from: .value)
        let price_str = try? container.decodeString(from: .price)
        self.price = price_str?.toDouble()
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case value
        case price
    }
    
    static func getSugars()->[ModelAddableValue]
    {
        let shugar_0 = ModelAddableValue(id: -1, value: MyStrings.no_sugar.localized(), price: 0)
        let shugar_1 = ModelAddableValue(id: -1, value: "1", price: 0)
        let shugar_2 = ModelAddableValue(id: -1, value: "2", price: 0)
        let shugar_3 = ModelAddableValue(id: -1, value: "3", price: 0)
        
        return [shugar_0,shugar_1,shugar_2,shugar_3]
    }
}
