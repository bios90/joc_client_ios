import UIKit

class FactoryProductSettings
{
    static let top_height = getScreenWidth()*0.50
    static let bottom_height = 96+getBottomSafeInset()
    let vc:BaseViewController!
    
    let view_container:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.clipsToBounds = true
        return view
    }()
    
    let scroll_bubbles :UIScrollView =
    {
        let scroll = ViewsHelper.getDefScroll()
        scroll.backgroundColor = MyColors.gi.white
        return scroll
    }()
    
    let view_top :UIView =
    {
        let view = UIView()
        return view
    }()
    
    let img_image:UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    let view_overlay:ViewForGradientBg =
    {
        let view = ViewForGradientBg()
        let grad_view = MyColors.gi.getGradient(color1: MyColors.gi.black, color2: MyColors.gi.transparent, horizontal: false)
        grad_view.frame = view.bounds
        view.layer.insertSublayer(grad_view,at: 0)
        return view
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let lbl_description:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let view_bottom:UIView =
    {
        let view = UIView()
        view.addShadowMin()
        view.backgroundColor = MyColors.gi.white
        return view
    }()
    
    let lbl_sum : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let btn_add:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getGreenGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.add.localized())
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.green_dark.withAlphaComponent(0.4))
        btn.addShadowMin()
        return btn
    }()
    
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        self.setupViews()
    }
    
    func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.transparent
        
        self.vc.view.addSubview(view_container)
        view_container.addSubview(view_top)
        view_container.addSubview(scroll_bubbles)
        view_container.addSubview(view_bottom)
        
        view_top.addSubview(img_image)
        view_top.addSubview(view_overlay)
        view_top.addSubview(lbl_name)
        view_top.addSubview(lbl_description)
        
        view_container.addSubview(scroll_bubbles)
        view_container.addSubview(view_bottom)
        
        view_bottom.addSubview(lbl_sum)
        view_bottom.addSubview(btn_add)
        
        view_container.snp.makeConstraints(
            { make in
                
                make.bottom.left.right.equalToSuperview()
                make.height.equalTo(500)
        })
        
        view_top.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview()
                make.width.centerX.equalToSuperview()
                make.height.equalTo(FactoryProductSettings.top_height)
        })
        
        img_image.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_overlay.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        lbl_description.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-12)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalTo(lbl_description.snp.top)
        })
        
        scroll_bubbles.snp.makeConstraints(
            { make in
                
                make.top.equalTo(view_top.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(view_bottom.snp.top)
        })
        
        view_bottom.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview()
                make.height.equalTo(FactoryProductSettings.bottom_height)
        })
        
        lbl_sum.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(16)
                make.centerX.equalToSuperview()
        })
        
        btn_add.snp.makeConstraints(
            { make in
                
                make.height.equalTo(36)
                make.right.equalToSuperview().offset(-16)
                make.left.equalToSuperview().offset(16)
                make.bottom.equalToSuperview().offset(-(16+getBottomSafeInset()))
        })
    }
}
