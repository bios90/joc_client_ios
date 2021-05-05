import UIKit
import Cosmos

class FactoryCafePage
{
    let vc:BaseViewController!
    static let logo_size = 72
    static let image_top_margin = 8
    static let square_img_size = 98
    static let route_btn_height = 26
    static let social_icon_size = 22

    
    let scroll :UIScrollView =
    {
        let scroll = ViewsHelper.getDefScroll()
        return scroll
    }()
    
    let view_top:UIView =
    {
        let view = UIView()
        view.backgroundColor = .random
        return view
    }()
    
    let img_arrow_back:BtnRipple =
    {
        let btn = ViewsHelper.getArrowBack()
        
        return btn
    }()
    
    let view_cafe_logo:ImgInRoundShadow =
    {
        let view = ImgInRoundShadow()
        view.img.image = MyImage.img_info_circle.getImage()
        return view
    }()
    
    let btn_name:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.bold_m)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.backgroundColor = MyColors.gi.transparent
        let ripple_color = MyColors.gi.white.withAlphaComponent(0.4)
        btn.setRippleColor(color: ripple_color)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStarsWhite()
        cosmos.settings.starSize = 16
        cosmos.rating = 4.5
        return cosmos
    }()
    
    let tf_description:UITextView =
    {
        let tv = UITextView()
        tv.textColor = MyColors.gi.white
        tv.textAlignment = .left
        tv.font = MyFonts.gi.reg_xs
        tv.backgroundColor = MyColors.gi.transparent
        tv.isScrollEnabled = false
        tv.isEditable = false
        tv.isSelectable = false
        tv.textContainerInset = UIEdgeInsets.zero
        tv.textContainer.lineFragmentPadding = 0
        return tv
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
        lbl.text = FawString.location_arrow.rawValue
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let btn_route:BtnRipple =
    {
        let btn = BtnRipple()
        btn.layer.borderWidth = 1
        btn.layer.borderColor = MyColors.gi.white.cgColor
        btn.layer.cornerRadius = CGFloat(FactoryCafePage.route_btn_height / 2)
        btn.setRippleCornerRadius(radius: CGFloat(FactoryCafePage.route_btn_height / 2))
        let ripple_color = MyColors.gi.white.withAlphaComponent(0.3)
        btn.setRippleColor(color: ripple_color)
        return btn
    }()
    
    let lbl_walk:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_solid_xs
        lbl.textColor = MyColors.gi.white
        lbl.text = FawString.location_arrow.rawValue
        return lbl
    }()
    
    let lbl_distance:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_xs
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let stack_socials:UIStackView =
    {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    
    let lbl_no_reviews:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.text = MyStrings.no_reviews_yet.localized()
        lbl.textColor = MyColors.gi.gray4
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let tb_reviews:UITableView =
    {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellReview.self, forCellReuseIdentifier: CellReview.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        tb.backgroundColor = .white
        tb.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 22, right: 0)
        return tb
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
        self.vc.view.addSubview(view_top)
        view_top.addSubview(view_cafe_logo)
        view_top.addSubview(btn_name)
        view_top.addSubview(rating)
        view_top.addSubview(tf_description)
        view_top.addSubview(img_arrow_back)
        view_top.addSubview(scroll_image)
        view_top.addSubview(lbl_adress)
        view_top.addSubview(lbl_clock)
        view_top.addSubview(lbl_time)
        view_top.addSubview(stack_socials)
        
        view_top.addSubview(btn_route)
        btn_route.addSubview(lbl_location_arrow)
        btn_route.addSubview(lbl_distance)
        
        self.vc.view.addSubview(tb_reviews)
        self.vc.view.addSubview(lbl_no_reviews)
        
        scroll.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_top.snp.makeConstraints(
            { make in
                
                make.centerX.width.equalToSuperview()
                make.top.equalToSuperview().offset(-getStatusBarHeight())
                //                make.bottom.equalTo(lbl_location_arrow.snp.bottom).offset(36)
        })
        
        view_top.fitHeightToLastChild(offset: 12)
        
        view_cafe_logo.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(12+(getStatusBarHeight()*2))
                make.right.equalToSuperview().offset(-12)
                make.width.height.equalTo(FactoryCafePage.logo_size)
        })
        
        img_arrow_back.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(28)
                make.left.equalToSuperview().offset(10)
                
                make.centerY.equalTo(btn_name)
        })
        
        btn_name.snp.makeConstraints(
            { make in
                
                make.left.equalTo(img_arrow_back.snp.right)
                make.right.equalTo(view_cafe_logo.snp.left).offset(-10)
                make.top.equalToSuperview().offset(12+(getStatusBarHeight()*2))
        })
        
        rating.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalTo(view_cafe_logo.snp.left).offset(-12)
                make.top.equalTo(btn_name.snp.bottom).offset(4)
        })
        
        tf_description.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                //                make.height.equalTo(120)
                make.top.equalTo(rating.snp.bottom).offset(8)
        })
        
        scroll_image.snp.makeConstraints(
            { make in
                
                make.top.equalTo(tf_description.snp.bottom).offset(8)
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
                
                make.top.equalTo(lbl_adress.snp.bottom).offset(18)
                make.left.equalToSuperview().offset(12)
        })
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(lbl_clock)
                make.left.equalTo(lbl_clock.snp.right).offset(6)
        })
        
        lbl_location_arrow.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
        })
        
        lbl_distance.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-10)
                make.left.equalTo(lbl_location_arrow.snp.right).offset(4)
                make.centerY.equalToSuperview()
        })
        
        btn_route.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.centerY.equalTo(lbl_clock)
                make.height.equalTo(FactoryCafePage.route_btn_height)
        })
        
        stack_socials.snp.makeConstraints(
            { make in
                
                make.height.equalTo(FactoryCafePage.social_icon_size)
                make.centerX.equalToSuperview()
                make.centerY.equalTo(lbl_clock)
        })
        

        resetLabelImageCut()
        
        tb_reviews.snp.makeConstraints(
            { make in
                
                make.top.equalTo(view_top.snp.bottom)
                make.left.right.bottom.equalToSuperview()
        })
        
        lbl_no_reviews.snp.makeConstraints(
            { make in
                
                make.top.equalTo(tb_reviews).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
    }
    
    private func resetLabelImageCut()
    {
        let x = Int(UIScreen.main.bounds.width) - (20 + FactoryCafePage.logo_size + 4)
        let y = -((FactoryCafePage.logo_size / 2) + (FactoryCafePage.image_top_margin ))
        
        let imageFrame = UIBezierPath(roundedRect: CGRect.init(x: x, y: y, width: FactoryCafePage.logo_size + 8, height: FactoryCafePage.logo_size + 8), cornerRadius:CGFloat(Double(FactoryCafePage.logo_size) / 2))
        tf_description.textContainer.exclusionPaths = [imageFrame]
    }
}
