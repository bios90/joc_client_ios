import Foundation
import RxSwift
import RxCocoa

class BaseVm
{
    var dispose_bag = DisposeBag()
    var ps_dissmiss_vc : PublishSubject<Bool> = PublishSubject.init()
    var ps_show_image_scroll: PublishSubject<([ObjWithImage],pos:Int)>  = PublishSubject.init()
    var base_netwoker :BaseNetworker!
    
    init()
    {
        base_netwoker = BaseNetworker(base_vm: self)
        
        BusMainEvents.gi.ps_finish_vm_of_type.subscribe(onNext:
            { types in
                
                types.forEach(
                    { type in
                        
                        let type_str = String(describing: type)
                        let self_str = String(describing: self)
                        
                        if (self_str.contains(type_str))
                        {
                            self.ps_dissmiss_vc.onNext(true)
                            return
                        }
                })
        }).disposed(by: dispose_bag)
    }
}
