import UIKit

class HelperImages
{
    static func getImgPairForTabs(img:UIImage) -> (img_normal:UIImage,img_selected:UIImage)
    {
        let img_normal = get_img_for_tab(img: img, color: MyColors.gi.gray5)
        let img_selected = get_img_for_tab(img: img, color: MyColors.gi.orange)
        return (img_normal,img_selected)
    }

    static func get_img_for_tab(img:UIImage,color:UIColor)->UIImage
    {
        var img_scaled_and_colored = img.scaled_to_size(def_tab_bar_icon_size)
        img_scaled_and_colored = img_scaled_and_colored.setColorMy(color)

        return img_scaled_and_colored.withRenderingMode(.alwaysOriginal)
    }
}

var def_tab_bar_icon_size = CGSize(
    width: CGFloat(18),
    height: CGFloat(18)
)
