import Foundation
import RxSwift
import RxCocoa

class BaseVm
{
    var dispose_bag = DisposeBag()
    var ps_dissmiss_vc : PublishSubject<Bool> = PublishSubject.init()
    var base_netwoker :BaseNetworker!
    
    init()
    {
        base_netwoker = BaseNetworker(base_vm: self)
    }
}
