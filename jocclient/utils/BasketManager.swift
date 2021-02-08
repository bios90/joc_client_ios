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
    
    func setItems(items:[ModelBasketItem])
    {
        order_id = nil
        br_bakset_items.accept(items)
    }
    
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
    
    func setOrder(order:ModelOrder)
    {
        self.order_id = nil
        guard let order_items = order.items,
            let cafe_menu = br_cafe.value?.menu,
            order_items.count > 0
            else { return }
        
        var items_to_set_in_basket:[ModelBasketItem] = []
        let items_in_cafe = cafe_menu.getAllItems()
        
        order_items.forEach(
            { item_order in
                
                guard let product_id = item_order.product.id,
                    let product = items_in_cafe.findById(id: product_id)
                else { return }
                
                let item = ModelBasketItem(product: product)
                item.sugar = item_order.sugar
                
                applyWeightFromOrder(new_item: item, old_item: item_order, product_in_menu: product)
                applyMilsFromOrder(new_item: item, old_item: item_order, product_in_menu: product)
                applyAddablesFromOrder(new_item: item, old_item: item_order, product_in_menu: product)
                
                items_to_set_in_basket.append(item_order)
        })
        
        setItems(items: items_to_set_in_basket)
    }
    
    private func applyWeightFromOrder(new_item: ModelBasketItem,old_item:ModelBasketItem,product_in_menu:ModelProduct)
    {
        if let selected_weight_id = old_item.weight?.id
        {
            if let weight = product_in_menu.weights?.findById(id: selected_weight_id)
            {
                new_item.weight = weight
            }
        }
    }
    
    private func applyMilsFromOrder(new_item: ModelBasketItem,old_item:ModelBasketItem,product_in_menu:ModelProduct)
    {
        if let selected_milk_id = old_item.milk?.id
        {
            if let milk = product_in_menu.milks?.findById(id: selected_milk_id)
            {
                new_item.milk = milk
            }
        }
    }
    
    
    
    private func applyAddablesFromOrder(new_item: ModelBasketItem,old_item:ModelBasketItem,product_in_menu:ModelProduct)
    {
        print("Item from order is \(old_item)")
        
        old_item.addables.forEach(
            { addable in
                
                
                if let selected_addable_id = addable.id
                {
                    if let addable_in_product = product_in_menu.addables?.findById(id: selected_addable_id)
                    {
                        new_item.addables.append(addable_in_product)
                    }
                }
        })
    }
}
