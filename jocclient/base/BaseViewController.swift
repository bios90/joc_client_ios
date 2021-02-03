import UIKit
import RxSwift
import RxCocoa

class BaseViewController:UIViewController
{
    let dispose_bag = DisposeBag()
    var base_vm:BaseVm?
    var show_navbar = false
    var status_bar_style:UIStatusBarStyle = .lightContent
    
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

//MARK: -Lifecycle
extension BaseViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return status_bar_style
    }
}
