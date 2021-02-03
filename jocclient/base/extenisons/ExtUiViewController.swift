import UIKit

extension UIViewController
{
    func removeOrDismiss(animated:Bool = true)
    {
        if let nav_controller = self.navigationController
        {
            if let index = nav_controller.viewControllers.firstIndex(of: self)
            {
                if index == (nav_controller.viewControllers.count - 1)
                {
                    
                    self.navigationController?.popViewController(animated: animated)
                }
                else
                {
                    
                    self.navigationController?.viewControllers.remove(at: index)
                }
            }
        }
        else
        {
            
            self.dismiss(animated: animated, completion: nil)
        }
    }
}
