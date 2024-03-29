import Foundation

class ModelBasketItem:NSObject,Codable
{
    var product:ModelProduct
    var sugar = 0
    var weight:ModelAddableValue? = nil
    var milk:ModelAddableValue? = nil
    var addables:[ModelAddableValue] = []
    
    init(product:ModelProduct)
    {
        self.product = product
        self.weight = product.weights?[safe:0]
    }
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.product = try! container.decodeObject(type: ModelProduct.self, from: .product)!
        self.sugar = (try? container.decodeInt(from: .sugar)) ?? 0
        self.weight = try? container.decodeObject(type: ModelAddableValue.self, from: .weight)
        self.milk = try? container.decodeObject(type: ModelAddableValue.self, from: .milk)
        self.addables = (try? container.decodeArray(type: ModelAddableValue.self, from: .addables)) ?? []
    }
    
    enum CodingKeys: String, CodingKey
    {
        case product
        case sugar
        case weight
        case milk
        case addables = "additive"
    }
    
    func getSelectedAddablesPoses()->[Int]
    {
        var posses:[Int] = []
        
        addables.forEach(
            { selected in
                
                if let pos = product.addables?.firstIndex(where: {$0.value == selected.value} )
                {
                    posses.append(pos)
                }
        })
        
        return posses
    }
    
    func getSum()->Double
    {
        var sum = 0.0
       
        if let price_weight = weight?.price
        {
            sum += price_weight
        }
        
        if let price_milk = milk?.price
        {
            sum += price_milk
        }
        
        addables.forEach(
            { addable in
                
                if let addable_price = addable.price
                {
                    sum += addable_price
                }
        })

        return sum
    }
    
    func toServerBasketValue()->[ModelServerBasketValue]
    {
        var items:[ModelServerBasketValue] = []
        
        if let weight_id = self.weight?.id
        {
            items.append(ModelServerBasketValue(property_id: weight_id, sugar: self.sugar))
        }
        
        if let milk_id = self.milk?.id
        {
            items.append(ModelServerBasketValue(property_id: milk_id, sugar: sugar))
        }
        
        self.addables.forEach(
            { addable in
                
                if let addable_id = addable.id
                {
                    items.append(ModelServerBasketValue(property_id: addable_id, sugar: sugar))
                }
        })
        
        if items.count == 0
        {
            fatalError("*** Error no items in product ***")
        }
        
        return items
    }
}

class ModelServerBasketValue:Encodable
{
    var property_id:Int
    var sugar:Int
    let quantity = 1
    
    init(property_id:Int,sugar:Int?)
    {
        self.property_id = property_id
        self.sugar = sugar ?? 0
    }
}

extension Array where Element: ModelBasketItem
{
    func toServerBaksetItems()->[[ModelServerBasketValue]]
    {
        var items:[[ModelServerBasketValue]] = []
        
        self.forEach(
            { basket_item in
                
                items.append(basket_item.toServerBasketValue())
        })
        
        return items
    }
}
