import UIKit

class FactoryOrderDialog
{
    let vc:BaseViewController!
    static let circle_size = 86
    
    let view_container:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray0
        view.clipsToBounds = true
        return view
    }()
    
    let view_logo:ImgInRoundShadow =
    {
        let view = ImgInRoundShadow()
        return view
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_l
        return lbl
    }()
    
    let lbl_adress:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .left
        return lbl
    }()
    
    let lbl_clock:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.clock.rawValue
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    let lbl_time:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = "21:30 - 23:15"
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    let divider:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray2
        return view
    }()
    
    let lbl_title_time:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_m
        lbl.text = MyStrings.making_time.localized()
        return lbl
    }()
    
    let picker_time:UIDatePicker =
    {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.setValue(MyColors.gi.gray6, forKeyPath: "textColor")
        return picker
    }()
    
    let lbl_title_comment:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.font = MyFonts.gi.reg_m
        lbl.text = MyStrings.comment_to_order.localized()
        return lbl
    }()
    
    let tv_comment:UITextView =
    {
        let tv = UITextView()
        tv.layer.backgroundColor = MyColors.gi.white.cgColor
        tv.layer.borderColor = MyColors.gi.gray3.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 4
        tv.textColor = MyColors.gi.gray6
        tv.font = MyFonts.gi.reg_m
        tv.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    let view_bottom:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.addShadowMin()
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
    
    let btn_pay:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.pay.localized())
        btn.br_font.accept(MyFonts.gi.bold_m)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.orange_dark.withAlphaComponent(0.4))
        btn.addShadowMin()
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        self.setupViews()
    }

    
    private func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.transparent
        
        self.vc.view.addSubview(view_container)
        self.view_container.addSubview(view_logo)
        self.view_container.addSubview(lbl_adress)
        self.view_container.addSubview(lbl_name)
        self.view_container.addSubview(lbl_clock)
        self.view_container.addSubview(lbl_time)
        self.view_container.addSubview(divider)
        self.view_container.addSubview(lbl_title_time)
        self.view_container.addSubview(picker_time)
        self.view_container.addSubview(lbl_title_comment)
        self.view_container.addSubview(tv_comment)
        
        self.view_container.addSubview(view_bottom)
        view_bottom.addSubview(lbl_sum)
        view_bottom.addSubview(btn_pay)
        

        
        view_container.snp.makeConstraints(
            { make in
                
                make.height.equalTo(612)
                make.bottom.left.right.equalToSuperview()
        })
        
        view_logo.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(20)
                make.top.equalToSuperview().offset(16)
                make.height.width.equalTo(FactoryOrderDialog.circle_size)
        })
        
        lbl_adress.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_logo.snp.right).offset(12)
                make.right.equalToSuperview().offset(-12)
                make.centerY.equalTo(view_logo)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalTo(lbl_adress)
                make.bottom.equalTo(lbl_adress.snp.top)
        })
        
        lbl_clock.snp.makeConstraints(
            { make in
                
                make.left.equalTo(lbl_adress)
                make.top.equalTo(lbl_adress.snp.bottom).offset(4)
        })
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.left.equalTo(lbl_clock.snp.right).offset(8)
                make.centerY.equalTo(lbl_clock)
        })
        
        divider.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.height.equalTo(1)
                make.top.equalTo(view_logo.snp.bottom).offset(16)
        })
        
        lbl_title_time.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.top.equalTo(divider.snp.bottom).offset(8)
        })
        
        picker_time.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title_time.snp.bottom)
                make.left.right.equalToSuperview()
                make.height.equalTo(200)
        })
        
        lbl_title_comment.snp.makeConstraints(
            { make in
              
                make.left.equalToSuperview().offset(16)
                make.top.equalTo(picker_time.snp.bottom).offset(8)
        })
        
        tv_comment.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title_comment.snp.bottom).offset(6)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalTo(view_bottom.snp.top).offset(-16)
        })
        
        
        btn_pay.snp.makeConstraints(
            { make in
                
                make.height.equalTo(36)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-(8+getBottomSafeInset()))
        })
        
        lbl_sum.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(btn_pay.snp.top).offset(-8)
                make.centerX.equalToSuperview()
        })
        
        
        view_bottom.snp.makeConstraints(
            { make in
                
                make.bottom.left.right.equalToSuperview()
                make.top.equalTo(lbl_sum).offset(-16)
        })
        
        runActionWithDelay(milliseconds: 100, action:
             {
                 self.view_container.makeRoundCorners(corners: [.topLeft,.topRight], radius: 12.0)
         })
    }
}
