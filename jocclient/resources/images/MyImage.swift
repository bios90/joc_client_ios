import UIKit

enum MyImage:String
{
    case uber
    case bg_overlapped
    case img_info_circle
    case ic_bell
    case star_empty
    case star_filled
    case img_marker
    case ic_user
    case ic_location
    case ic_globe
    case img_test
    case ic_bag
    case ic_info_circle
    case ic_cup_hot
    case ic_cup_to_go
    case ic_cookies
    case ic_arrow_left
    case img_face_mask
    case img_intro1
    case img_intro2
    case img_intro3
    case img_intro4
    case img_intro5
    
    func getImage() -> UIImage
    {
        return UIImage(named: self.rawValue)!
    }
}
