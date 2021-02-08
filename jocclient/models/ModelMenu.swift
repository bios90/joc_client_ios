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
    
    func getAllItems()->[ModelProduct]
    {
        var items:[ModelProduct] = []
        
        if let hot_drinks = self.hot_drinks, hot_drinks.count > 0
        {
            items.append(contentsOf: hot_drinks)
        }
        
        if let cold_drinks = self.cold_drinks, cold_drinks.count > 0
        {
            items.append(contentsOf: cold_drinks)
        }
        
        if let snacks = self.snacks, snacks.count > 0
        {
            items.append(contentsOf: snacks)
        }
        
        return items
    }
}
