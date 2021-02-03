import UIKit

class FactoryProfile
{
    let vc:BaseViewController
    
    let img_top:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.bg_overlapped.getImage()
        img.layer.shadowColor = MyColors.gi.gray5.cgColor
        img.layer.shadowOpacity = 0.4
        img.layer.shadowRadius = 20
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        return img
    }()
    
    let btn_edit : BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_m)
        btn.br_text.accept(FawString.pencil.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.4))
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        return btn
    }()
    
    let img_info:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_info_circle.getImage().setColorMy(MyColors.gi.white)
        return img
    }()
    
    let img_avatar:ImgInRoundShadow =
    {
        let img = ImgInRoundShadow()
        img.backgroundColor = MyColors.gi.white
        img.img.image = MyImage.img_info_circle.getImage()
        return img
    }()
    
    let lbl_user_name:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textColor = MyColors.gi.white
        lbl.text = "Mike penzz"
        return lbl
    }()
    
    let lbl_phone:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.light_s
        lbl.textColor = MyColors.gi.white
        lbl.text = "+78124323423"
        return lbl
    }()
    
    let lbl_cups_title : UILabel =
    {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        lbl.textColor = MyColors.gi.white
        lbl.text = "Cuppps"
        return lbl
    }()
    
    let lbl_orders_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "Ordarsss"
        return lbl
    }()
    
    let lbl_reviews_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "Reviuuws"
        return lbl
    }()
    
    
    let lbl_cups_count : UILabel =
    {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_l
        lbl.textColor = MyColors.gi.white
        lbl.text = "12"
        return lbl
    }()
    
    let lbl_orders_count : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "34"
        return lbl
    }()
    
    let lbl_reviews_count : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "45"
        return lbl
    }()
    
    var view_auth :LaAuth =
    {
        let view = LaAuth()
        return view
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = .white
        
        self.vc.view.addSubview(img_top)
        self.vc.view.addSubview(btn_edit)
        self.vc.view.addSubview(img_info)
        self.vc.view.addSubview(img_avatar)
        self.vc.view.addSubview(lbl_user_name)
        self.vc.view.addSubview(lbl_phone)
        self.vc.view.addSubview(lbl_cups_title)
        self.vc.view.addSubview(lbl_orders_title)
        self.vc.view.addSubview(lbl_reviews_title)
        self.vc.view.addSubview(lbl_cups_count)
        self.vc.view.addSubview(lbl_orders_count)
        self.vc.view.addSubview(lbl_reviews_count)
        self.vc.view.addSubview(view_auth)
        
        img_top.snp.makeConstraints(
            { make in
                
                make.top.left.right.equalToSuperview()
                make.height.equalTo(212)
        })
        
        btn_edit.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 8)
                make.height.width.equalTo(24)
        })
        
        img_info.snp.makeConstraints(
            { make in
                
                make.right.equalTo(btn_edit.snp.left).offset(-8)
                make.top.equalTo(btn_edit.snp.top)
                make.height.width.equalTo(24)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 16)
                make.width.height.equalTo(84)
        })
        
        lbl_user_name.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(img_avatar.snp.centerY)
                make.left.equalTo(img_avatar.snp.right).offset(8)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_phone.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_avatar.snp.centerY)
                make.left.equalTo(img_avatar.snp.right).offset(8)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_cups_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_avatar.snp.bottom).offset(12)
                make.left.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_orders_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_cups_title)
                make.left.equalTo(lbl_cups_title.snp.right)
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_reviews_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_cups_title)
                make.left.equalTo(lbl_orders_title.snp.right)
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_cups_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_cups_title)
                make.top.equalTo(lbl_cups_title.snp.bottom)
        })
        
        lbl_orders_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_orders_title)
                make.top.equalTo(lbl_orders_title.snp.bottom)
        })
        
        lbl_reviews_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_reviews_title)
                make.top.equalTo(lbl_reviews_title.snp.bottom)
        })
        
        view_auth.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
    }
}
