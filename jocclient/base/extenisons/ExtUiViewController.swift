import UIKit
import Lightbox

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
    
    func showImageScroller(objects: [ObjWithImage], text: String? = nil, goToPage: Int? = nil)
    {
        LightboxConfig.CloseButton.text = MyStrings.close.localized()
        LightboxConfig.InfoLabel.ellipsisText = MyStrings.more.localized()
        LightboxConfig.PageIndicator.enabled = true
        LightboxConfig.hideStatusBar = true
        
        var light_box_images:[LightboxImage] = []
        
        var text_formatted = ""
        if let text = text {
            text_formatted = text.replacingOccurrences(of: "\n", with: " ")
        }
        
        objects.forEach({ obj in
            if let img = obj.image {
                light_box_images.append(LightboxImage(image: img, text: text_formatted))
            } else if let url = obj.url, let url_url = URL(string: url) {
                light_box_images.append(LightboxImage(imageURL: url_url, text: text_formatted))
            }
        })
        
        guard  light_box_images.count > 0 else { return }
        
        let controller = LightboxController(images: light_box_images)
        controller.modalPresentationStyle = .fullScreen
        controller.dynamicBackground = true
        
        if goToPage != nil {
            controller.goTo(goToPage!)
        }
        
        present(controller, animated: true, completion: nil)
    }
}

extension UICollectionView
{
    func getFirstVisiblePos()->Int?
    {
        guard self.indexPathsForVisibleItems.count > 0 else { return nil }
        let pos = self.indexPathsForVisibleItems[0].row
        return pos
    }
}
