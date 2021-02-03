import UIKit
import Cosmos

class FactoryCafePage
{
    let vc:BaseViewController!
    static let logo_size = 72
    static let image_top_margin = 8
    static let square_img_size = 98
    
    let scroll :UIScrollView =
    {
        let scroll = ViewsHelper.getDefScroll()
        scroll.backgroundColor = .blue
        return scroll
    }()
    
    let view_top:ViewForGradientBg =
    {
        let view = ViewForGradientBg()
        let grad_view = MyColors.gi.getOrangeGradient(horizontal: true)
        grad_view.frame = view.bounds
        view.layer.insertSublayer(grad_view,at: 0)
        return view
    }()
    
    let view_cafe_logo:ImgInRoundShadow =
    {
        let view = ImgInRoundShadow()
        view.img.image = MyImage.img_info_circle.getImage()
        return view
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.bold_m
        lbl.text = "Name test"
        return lbl
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStarsWhite()
        cosmos.settings.starSize = 16
        cosmos.rating = 4.5
        return cosmos
    }()
    
    let lbl_description:UITextView =
    {
        let lbl = UITextView()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.reg_xs
        lbl.backgroundColor = MyColors.gi.transparent
        lbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        lbl.isScrollEnabled = false
        lbl.isEditable = false
        //        lbl.numberOfLines = 0
        lbl.textContainerInset = UIEdgeInsets.zero
        lbl.textContainer.lineFragmentPadding = 0
        return lbl
    }()
    
    let scroll_image:UIScrollView =
    {
        let scroll = ViewsHelper.getDefScroll()
        scroll.clipsToBounds = false
        return scroll
    }()
    
    let lbl_adress:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .center
        return lbl
    }()
    
    let lbl_clock:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.clock.rawValue
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let lbl_time:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = "21:30 - 23:15"
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let lbl_location_arrow:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.location_arraw.rawValue
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let lbl_distance:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = "212m"
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        self.setupViews()
    }
    
    func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.green
        
        self.vc.view.addSubview(scroll)
        scroll.addSubview(view_top)
        view_top.addSubview(view_cafe_logo)
        view_top.addSubview(lbl_name)
        view_top.addSubview(rating)
        view_top.addSubview(lbl_description)
        view_top.addSubview(scroll_image)
        view_top.addSubview(lbl_adress)
        view_top.addSubview(lbl_clock)
        view_top.addSubview(lbl_time)
        view_top.addSubview(lbl_distance)
        view_top.addSubview(lbl_location_arrow)
        
        scroll.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_top.snp.makeConstraints(
            { make in
                
                make.centerX.width.equalToSuperview()
                make.top.equalToSuperview().offset(-getStatusBarHeight())
                make.bottom.equalTo(lbl_clock.snp.bottom).offset(36)
        })
        
//        view_top.fitHeightToLastChild(offset: 12)
        
        view_cafe_logo.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(12+getStatusBarHeight())
                make.right.equalToSuperview().offset(-12)
                make.width.height.equalTo(FactoryCafePage.logo_size)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalToSuperview().offset(12+getStatusBarHeight())
        })
        
        rating.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalTo(view_cafe_logo.snp.left).offset(-12)
                make.top.equalTo(lbl_name.snp.bottom).offset(4)
        })
        
        lbl_description.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                //                make.height.equalTo(120)
                make.top.equalTo(rating.snp.bottom).offset(8)
        })
        
        scroll_image.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_description.snp.bottom).offset(8)
                make.left.width.equalToSuperview()
                make.height.equalTo(FactoryCafePage.square_img_size)
        })
        
        lbl_adress.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalTo(scroll_image.snp.bottom).offset(10)
        })
        
        lbl_clock.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_adress.snp.bottom).offset(12)
                make.left.equalToSuperview().offset(12)
        })
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(lbl_clock)
                make.left.equalTo(lbl_clock.snp.right).offset(6)
        })
        
        lbl_location_arrow.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.centerY.equalTo(lbl_clock)
        })
        
        lbl_distance.snp.makeConstraints(
            { make in
                
                make.right.equalTo(lbl_location_arrow.snp.left).offset(-6)
                make.centerY.equalTo(lbl_location_arrow)
        })
        
        resetLabelImageCut()
    }
    
    private func resetLabelImageCut()
    {
        let x = Int(UIScreen.main.bounds.width) - (20 + FactoryCafePage.logo_size + 4)
        let y = -((FactoryCafePage.logo_size / 2) + (FactoryCafePage.image_top_margin ))
        
        let imageFrame = UIBezierPath(roundedRect: CGRect.init(x: x, y: y, width: FactoryCafePage.logo_size + 8, height: FactoryCafePage.logo_size + 8), cornerRadius:CGFloat(Double(FactoryCafePage.logo_size) / 2))
        lbl_description.textContainer.exclusionPaths = [imageFrame]
    }
}
