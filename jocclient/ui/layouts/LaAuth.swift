import UIKit
import SimpleCheckbox

class LaAuth:UIView
{
    let view_bg:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let view_dialog : UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.layer.cornerRadius = 4
        return view
    }()
    
    let lbl_title : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.bold_m
        lbl.textAlignment = .center
        lbl.text = MyStrings.authorization.localized()
        return lbl
    }()
    
    let lbl_text : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.light_s
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.text = MyStrings.authorization_allows_you.localized()
        return lbl
    }()
    
    let lbl_status_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.font = MyFonts.gi.reg_m
        lbl.textAlignment = .center
        return lbl
    }()
    
    let tf:BaseTextField =
    {
        let tf = BaseTextField()
        tf.layer.backgroundColor = MyColors.gi.gray2.cgColor
        tf.layer.cornerRadius = 4
        tf.textColor = MyColors.gi.gray8
        tf.textAlignment = .center
        return tf
    }()
    
    let check_box:Checkbox =
    {
        let cheb = Checkbox(frame: .zero)
        cheb.borderCornerRadius = 4
        cheb.checkmarkStyle = .tick
        cheb.borderLineWidth = 2
        cheb.checkmarkSize = 0.6
        cheb.checkmarkColor = MyColors.gi.orange
        cheb.checkedBorderColor = MyColors.gi.orange
        cheb.uncheckedBorderColor = MyColors.gi.gray3
        return cheb
    }()
    
    
    let btn_i_agree : BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.transparent
        btn.setRippleColor(color: MyColors.gi.gray4.withAlphaComponent(0.4))
        //        btn.br_text.accept("ASDfsadf ")
        btn.br_text_color.accept(MyColors.gi.gray6)
        btn.titleLabel?.textAlignment = .left
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        btn.setAttributedTitle(MyStrings.getIAgreeWithOffert(), for: .normal)
        return btn
    }()
    
    let btn_send:BtnRipple =
    {
        let btn = BtnRipple()
        //        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        btn.backgroundColor = MyColors.gi.orange
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.send_code.localized())
        btn.br_text_color.accept(MyColors.gi.white)
        return btn
    }()
    
    
    init()
    {
        super.init(frame: .zero)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        
        
        
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.addSubview(view_bg)
        
        self.addSubview(view_dialog)
        view_dialog.addSubview(lbl_title)
        view_dialog.addSubview(lbl_text)
        view_dialog.addSubview(lbl_status_title)
        view_dialog.addSubview(tf)
        view_dialog.addSubview(btn_send)
        view_dialog.addSubview(check_box)
        view_dialog.addSubview(btn_i_agree)
        
        view_bg.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        view_dialog.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview().offset(-40)
                make.center.equalToSuperview()
                make.bottom.equalTo(btn_send.snp.bottom).offset(12)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(12)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
        })
        
        lbl_text.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title.snp.bottom).offset(8)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
        })
        
        lbl_status_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_text.snp.bottom).offset(8)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
        })
        
        tf.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_status_title.snp.bottom).offset(8)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(38)
        })
        
        check_box.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.top.equalTo(tf.snp.bottom).offset(8)
                make.width.height.equalTo(28)
        })
        
        btn_send.snp.makeConstraints(
            { make in
                
                make.top.equalTo(check_box.snp.bottom).offset(12)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(38)
        })
        
        
        btn_i_agree.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.centerY.equalTo(check_box.snp.centerY)
                make.right.equalTo(check_box.snp.left).offset(-8)
        })
    }
    
    func bindMode(mode:TypeAuthMode)
    {
        switch mode
        {
        case .Phone:
            lbl_status_title.text = MyStrings.enter_phone_number.localized()
            btn_send.br_text.accept(MyStrings.send_code.localized())
            tf.keyboardType = .phonePad
        case .Code:
            lbl_status_title.text = MyStrings.enter_sms_code.localized()
            btn_send.br_text.accept(MyStrings.confirm.localized())
            tf.keyboardType = .numberPad
        }
        
        tf.text = ""
    }
}
