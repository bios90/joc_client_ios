import Foundation
import RxSwift
import RxCocoa

class VmCafePage:BaseVm
{
    let vm_wrapper:VmWrapperCafeMenu
    let vm_cafe:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    
    init(vm_wrapper_cafe_menu:VmWrapperCafeMenu)
    {
        self.vm_wrapper = vm_wrapper_cafe_menu
        super.init()
        setEvents()
    }
    
    private func setEvents()
    {
        vm_wrapper.br_initial_cafe_loaded
            .subscribe(onNext:
                { cafe in
                    
                    self.vm_cafe.accept(cafe)
            })
            .disposed(by: dispose_bag)
    }
}
