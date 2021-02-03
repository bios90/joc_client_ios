import UIKit
import Cosmos

class ViewsHelper
{
    static func getGrayTf()->BaseTextField
    {
        let tf = BaseTextField()
        tf.layer.cornerRadius = 4
        tf.clipsToBounds = true
        tf.textColor = MyColors.gi.gray7
        tf.backgroundColor = MyColors.gi.gray2
        return tf
    }
    
    static func getRangeLabel(num:Int? = nil)->UILabel
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray3
        lbl.font = MyFonts.gi.reg_xxs
        lbl.textAlignment = .center
        if let num = num
        {
            lbl.text = "\(num)"
        }
        
        return lbl
    }
    
    static func getRatingStars()->CosmosView
    {
        let cosmosView = CosmosView()
        cosmosView.settings.filledImage = MyImage.star_filled.getImage()
        cosmosView.settings.emptyImage = MyImage.star_empty.getImage()
        cosmosView.settings.fillMode = .precise
        cosmosView.settings.starSize = 26
        cosmosView.settings.starMargin = 2
        cosmosView.settings.updateOnTouch = false
        return cosmosView
    }
    
    static func getRatingStarsWhite()->CosmosView
    {
        let cosmosView = ViewsHelper.getRatingStars()
        
        let image_empty = MyImage.star_empty.getImage().setColorMy(MyColors.gi.white.withAlphaComponent(0.2))
        let image_filled = MyImage.star_filled.getImage().setColorMy(MyColors.gi.white)
        cosmosView.settings.emptyImage = image_empty
        cosmosView.settings.filledImage = image_filled
        return cosmosView
    }
    
    static func getDefScroll()->UIScrollView
    {
        let scroll = UIScrollView()
        scroll.bounces = false
        let content_size_default = CGSize(width: UIScreen.main.bounds.width, height: 0)
        scroll.contentSize = content_size_default
        scroll.showsHorizontalScrollIndicator = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }

}
