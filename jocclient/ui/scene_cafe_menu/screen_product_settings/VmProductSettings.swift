import Foundation
import RxSwift
import RxCocoa

class VmProductSettings:BaseVm
{
    let br_product:BehaviorRelay<ModelProduct>
    let br_basket_item:BehaviorRelay<ModelBasketItem>
    let br_is_edit_mode:BehaviorRelay<Bool> = BehaviorRelay.init(value: false)
    
    init(product:ModelProduct)
    {
        br_product = BehaviorRelay.init(value: product)
        br_basket_item = BehaviorRelay.init(value: product.toBaksetItem())
        super.init()
    }
}

//MARK: -Listenes
extension VmProductSettings
{
    func clickedAdd()
    {
        let item = getItem()
        guard item.weight != nil else { return }
        
        if br_is_edit_mode.value
        {
            BusMainEvents.gi.ps_basket_item_updated.onNext(item)
        }
        else
        {
            BusMainEvents.gi.ps_basket_item_added.onNext(item)
        }
        
        ps_dissmiss_vc.onNext(true)
    }
    
    private func getItem()->ModelBasketItem
    {
        return br_basket_item.value
    }
    
    private func resetItem(item:ModelBasketItem)
    {
        br_basket_item.accept(item)
    }
    
    func changedShugar(shugar:Int)
    {
        let item = getItem()
        item.sugar = shugar
        resetItem(item: item)
    }
    
    func changedWeight(pos:Int)
    {
        guard let weight = br_product.value.weights?[safe:pos] else { return }
        let item = getItem()
        item.weight = weight
        resetItem(item: item)
    }
    
    func changedMilk(pos:Int?)
    {
        let item = getItem()
        item.milk = nil
        if let pos = pos, let milk = br_product.value.milks?[safe:pos]
        {
            item.milk = milk
        }
        resetItem(item: item)
    }
    
    func changedAddables(poses:[Int])
    {
        let item = getItem()
        item.addables.removeAll()
        poses.forEach(
            { pos in
                
                if let addable = br_product.value.addables?[safe:pos]
                {
                    item.addables.append(addable)
                }
        })
        
        resetItem(item: item)
    }
}

