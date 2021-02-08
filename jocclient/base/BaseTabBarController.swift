import UIKit
import RxSwift
import RxCocoa

class BaseTabBarController:UITabBarController
{
    var show_navbar = false
    var status_bar_style:UIStatusBarStyle = .lightContent
    let dispose_bag = DisposeBag()
    var base_vm:BaseVm!
    
    func preloadAllControllers()
    {
        if let viewControllers = self.viewControllers
        {
            for viewController in viewControllers
            {
                let _ = viewController.view
            }
        }
    }
    
    func setBaseVmAction(base_vm:BaseVm)
    {
        base_vm.ps_dissmiss_vc.subscribe(onNext:
            { animated in
               
                self.removeOrDismiss()
        })
            .disposed(by: dispose_bag)
        
        self.base_vm = base_vm
    }
}
