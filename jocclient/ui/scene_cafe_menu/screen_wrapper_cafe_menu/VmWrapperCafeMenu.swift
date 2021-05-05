import Foundation
import RxSwift
import RxCocoa

class VmWrapperCafeMenu:BaseVm
{
    var br_initial_cafe_loaded:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    var br_cafe_id:BehaviorRelay<Int?> = BehaviorRelay.init(value: nil)
    var br_order_id_to_repeat:BehaviorRelay<Int?> = BehaviorRelay.init(value: nil)
    var br_badge_text:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        setEvents()
    }
    
    private func setEvents()
    {
        BusMainEvents.gi.ps_order_created
            .subscribe(onNext:
                { _ in
                     
                    runActionWithDelay(milliseconds: 1000, action:
                        {
                            self.ps_dissmiss_vc.onNext(true)
                    })
            })
            .disposed(by: dispose_bag)
        
        br_cafe_id
            .subscribe(onNext:
                { cafe_id in
                    
                    guard let cafe_id = cafe_id else { return }
                    self.base_netwoker.loadCafe(cafe_id: cafe_id, action_success:
                        { cafe in
                            
                            self.br_initial_cafe_loaded.accept(cafe)
                            
                            if let order_to_repeat_id = self.br_order_id_to_repeat.value
                            {
                                self.loadOrderToRepeat(order_id: order_to_repeat_id)
                            }
                    })
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.ps_basket_item_added
            .subscribe(onNext:
                { item in
                    
                    BasketManager.gi.addItem(item: item)
                    MessagesManager.showGreenAlerter(text: MyStrings.product_added_to_basket.localized())
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.ps_basket_item_updated
            .subscribe(onNext:
                { item in
                    
                    BasketManager.gi.updateItem(item: item)
                    MessagesManager.showGreenAlerter(text: MyStrings.product_changed.localized())
            })
            .disposed(by: dispose_bag)
        
        BasketManager.gi
            .br_bakset_items
            .subscribe(onNext:
                { items in
                    
                    var text:String? = String(items.count)
                    if(items.count == 0)
                    {
                        text = nil
                    }
                    self.br_badge_text.accept(text)
            })
            .disposed(by: dispose_bag)
        
        br_initial_cafe_loaded
            .subscribe(onNext:
                { cafe in
                    
                    if let cafe = cafe
                    {
                        BasketManager.gi.setCafe(cafe: cafe)
                    }
            })
            .disposed(by: dispose_bag)
    }
    
    
    private func loadOrderToRepeat(order_id:Int)
    {
        base_netwoker.getOrderInfoById(order_id: order_id, action_success:
            { order in
                
                BasketManager.gi.setOrder(order: order)
        })
    }
}
