import UIKit
import RxSwift
import RxCocoa

class BaseTabBarController:UITabBarController
{
    var show_navbar = false
    var status_bar_style:UIStatusBarStyle = .lightContent
    let dispose_bag = DisposeBag()
    
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
}
