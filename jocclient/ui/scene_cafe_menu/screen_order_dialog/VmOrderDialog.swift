import Foundation
import RxSwift
import RxCocoa

class VmOrderDialog:BaseVm
{
    let br_cafe:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    let br_price:BehaviorRelay<Double> = BehaviorRelay.init(value: 0)
    let br_date:BehaviorRelay<Date> = BehaviorRelay.init(value: Date().addingTimeInterval(TimeInterval(15 * 60.0)))
    let br_comment:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        
        guard let cafe = BasketManager.gi.br_cafe.value else
        {
            fatalError("**** Error no cafe to make order ****")
        }
        
        br_cafe.accept(cafe)
        
        br_price.accept(BasketManager.gi.getSum())
    }
}

//MARK: -Listeners
extension VmOrderDialog
{
    func clickedMakeOrder()
    {
        let date = br_date.value
        let comment = br_comment.value
        
        PaymentManager.gi.createOrder(base_vm: self, date: date, comment: comment, action_success:
            { order_id in
                
                BasketManager.gi.clearBasket()
                BusMainEvents.gi.ps_order_created.onNext(order_id)
                self.ps_dissmiss_vc.onNext(true)
        })
    }
}
