import UIKit

class FactoryProfileEdit
{
    let vc:BaseViewController
    
    let view_dialog:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let btn_avatar : BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.white
        btn.setRippleColor(color: MyColors.gi.orange.withAlphaComponent(0.5))
        btn.clipsToBounds = true
        return btn
    }()
    
    let img_avatar:UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let view_divider:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray3
        return view
    }()
    
    let btn_back:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_m)
        btn.br_text.accept(FawString.back_arrow.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.backgroundColor = MyColors.gi.black.withAlphaComponent(0.4)
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.4))
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        return btn
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.name.localized()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let tf_name:UITextField =
    {
        let tf = ViewsHelper.getGrayTf()
        tf.textAlignment = .center
        return tf
    }()
    
    let lbl_phone:UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.phone.localized()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let tf_phone:UITextField =
    {
        let tf = ViewsHelper.getGrayTf()
        tf.keyboardType = .phonePad
        tf.isEnabled = false
        tf.textAlignment = .center
        return tf
    }()
    
    let lbl_email:UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.email.localized()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let tf_email:UITextField =
    {
        let tf = ViewsHelper.getGrayTf()
        tf.keyboardType = .emailAddress
        tf.textAlignment = .center
        return tf
    }()
    
    let btn_save:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.save.localized())
        btn.br_text_color.accept(MyColors.gi.white)
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.black.withAlphaComponent(0.6)
        
        self.vc.view.addSubview(view_dialog)
        view_dialog.addSubview(btn_avatar)
        btn_avatar.addSubview(img_avatar)
        view_dialog.addSubview(btn_back)
        view_dialog.addSubview(view_divider)
        view_dialog.addSubview(lbl_name)
        view_dialog.addSubview(tf_name)
        view_dialog.addSubview(lbl_phone)
        view_dialog.addSubview(tf_phone)
        view_dialog.addSubview(lbl_email)
        view_dialog.addSubview(tf_email)
        view_dialog.addSubview(btn_save)
        
        view_dialog.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview().offset(-32)
                make.center.equalToSuperview()
                make.top.equalTo(btn_avatar.snp.top)
                make.bottom.equalTo(btn_save.snp.bottom).offset(12)
        })
        
        btn_avatar.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview()
                make.height.equalTo(250)
                make.top.centerX.equalToSuperview()
        })
        
        btn_back.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(32)
                make.top.equalToSuperview().offset(12)
                make.left.equalToSuperview().offset(12)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_divider.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview()
                make.top.equalTo(btn_avatar.snp.bottom)
                make.height.equalTo(1)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalTo(view_divider.snp.bottom).offset(12)
        })
        
        tf_name.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_name.snp.bottom).offset(6)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(36)
        })
        
        lbl_phone.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalTo(tf_name.snp.bottom).offset(12)
        })
        
        tf_phone.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_phone.snp.bottom).offset(6)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(36)
        })
        
        lbl_email.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalTo(tf_phone.snp.bottom).offset(12)
        })
        
        tf_email.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_email.snp.bottom).offset(6)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(36)
        })
        
        btn_save.snp.makeConstraints(
            { make in
            
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalTo(tf_email.snp.bottom).offset(24)
                make.height.equalTo(36)
        })
    }
}
