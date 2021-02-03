import Foundation

class ModelProduct:Codable,ObjectWithId
{
    var id:Int?
    var description:String?
    var name:String?
    var image:BaseImage?
    var price:Double?
    var milks:[ModelAddableValue]?
    var weights:[ModelAddableValue]?
    var addables:[ModelAddableValue]?
    var type:TypeProduct?
    //Todo later make type also here
    
    func getMinPrice() -> Double
    {
        guard (weights?.count ?? 0) > 0,
            let price = weights?[0].price
        else { return  0.0 }
        
        return price
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.description = try? container.decodeString(from: .description)
        self.name = try? container.decodeString(from: .name)
        self.image = try? container.decodeObject(type: BaseImage.self, from: .image)
        self.price = try? container.decodeDouble(from: .price)
        self.milks = try? container.decodeArray(type: ModelAddableValue.self, from: .milks)
        self.weights = try? container.decodeArray(type: ModelAddableValue.self, from: .weights)
        self.addables = try? container.decodeArray(type: ModelAddableValue.self, from: .addables)
        self.type = try? container.decodeObject(type: TypeProduct.self, from: .type)
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case description
        case name
        case image
        case price
        case milks = "milk"
        case weights = "weight"
        case addables = "additive"
        case type = "category"
    }
    
    func toBaksetItem()->ModelBasketItem
    {
        var item = ModelBasketItem(product: self)
        return item
    }
}
