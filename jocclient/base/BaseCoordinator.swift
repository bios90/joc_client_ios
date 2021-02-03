import UIKit
import RxSwift
import RxCocoa

class BaseCoordinator
{
    let dispose_bag = DisposeBag()
    let navigation_controller:BaseNavController
    
    init(nav_controller:BaseNavController)
    {
        self.navigation_controller = nav_controller
    }
    
    func finishAll()
    {
        self.navigation_controller.viewControllers.removeAll()
    }
}
