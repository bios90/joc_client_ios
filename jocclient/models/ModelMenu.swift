import Foundation

class ModelMenu:Codable
{
    var hot_drinks:[ModelProduct]?
    var cold_drinks:[ModelProduct]?
    var snacks:[ModelProduct]?

    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.hot_drinks = try? container.decodeArray(type: ModelProduct.self, from: .hot_drinks)
        self.cold_drinks = try? container.decodeArray(type: ModelProduct.self, from: .cold_drinks)
        self.snacks = try? container.decodeArray(type: ModelProduct.self, from: .snacks)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case hot_drinks = "hot"
        case cold_drinks = "cold"
        case snacks = "dessert"
    }
}
