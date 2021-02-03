import Foundation
import RxSwift
import RxCocoa

class BasketManager
{
    static let gi = BasketManager()
    let dispose_bag = DisposeBag()
    
    let br_bakset_items :BehaviorRelay<[ModelBasketItem]> = BehaviorRelay.init(value: [])
    let br_cafe:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    var order_id:Int? = nil
    
    func addItem(item:ModelBasketItem)
    {
        order_id = nil
        var items = br_bakset_items.value
        items.append(item)
        br_bakset_items.accept(items)
    }
    
    func removeItem(item:ModelBasketItem)
    {
        order_id = nil
        var items = br_bakset_items.value
        items.remove(object: item)
        br_bakset_items.accept(items)
    }
    
    func updateItem(item:ModelBasketItem)
    {
        order_id = nil
        var items = br_bakset_items.value
        
        if let index = items.firstIndex(of: item)
        {
            items[index] = item
        }
        else
        {
            items.append(item)
        }
        
        br_bakset_items.accept(items)
    }
    
    func setCafe(cafe:ModelCafe)
    {
        //TOTO later make checks!
        br_cafe.accept(cafe)
    }
    
    func getSum()->Double
    {
        var sum = 0.0
        
        br_bakset_items.value.forEach(
            { item in
                
                sum += item.getSum()
        })
        
        return sum
    }
}
