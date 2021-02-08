import Foundation
import RxSwift
import RxCocoa
import CoreLocation

class BusMainEvents
{
    static let gi = BusMainEvents()
    
    let ps_user_logged:PublishSubject<Void> = PublishSubject.init()
    let ps_user_updated:PublishSubject<ModelUser> = PublishSubject.init()
    let ps_scroll_to_tab:PublishSubject<TypeTab> = PublishSubject.init()
    let br_current_filter_data:BehaviorRelay<ModelFilterData> = BehaviorRelay.init(value: ModelFilterData())
    let br_current_location:BehaviorRelay<CLLocationCoordinate2D?> = BehaviorRelay.init(value: nil)
    
    let ps_basket_item_added:PublishSubject<ModelBasketItem> = PublishSubject.init()
    let ps_basket_item_updated:PublishSubject<ModelBasketItem> = PublishSubject.init()
    
    let ps_order_created:PublishSubject<Int> = PublishSubject.init()
    let ps_finish_vm_of_type:PublishSubject<[Any.Type]>  = PublishSubject.init()
}
