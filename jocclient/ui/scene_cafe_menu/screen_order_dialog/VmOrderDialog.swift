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
        
        
        br_comment.subscribe(onNext:
            { text in
                
                print(text ?? "")
        })
        .disposed(by: dispose_bag)
        
        br_date.subscribe(onNext:
            { date in
                
                print("DAte is \(date.formatToString(format: DateManager.FORMAT_FOR_SERVER))")
        })
        .disposed(by: dispose_bag)
    }
}

//MARK: -Listeners
extension VmOrderDialog
{
    func clickedMakeOrder()
    {
        let date = Date()
        let comment = "Test commmmment"
        PaymentManager.gi.createOrder(base_vm: self, date: date, comment: comment, action_success:
            { order_id in
                
                print("Got successss on paymentttt")
        })
    }
}
