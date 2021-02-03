import UIKit

class BaseNavController:UINavigationController
{
    var status_bar_style:UIStatusBarStyle = .lightContent
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle
    {
        if let topVC = viewControllers.last
        {
            return topVC.preferredStatusBarStyle
        }
        
        return status_bar_style
    }
    
    func clearAndPush(vc:UIViewController)
    {
        self.pushViewController(vc, animated: true)
        self.setViewControllers([vc], animated: true)
    }
}
