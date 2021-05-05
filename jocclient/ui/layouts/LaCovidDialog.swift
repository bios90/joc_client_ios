import UIKit

class LaCovidDialog:UIView
{
    static let dialog_name = "CovidDialog"
    
    let lbl_dear_guests:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.text = MyStrings.dear_guests.localized()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_l
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_line_1:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.text = "В Москве усилен контроль за ношением масок и перчаток."
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_line_2:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.text = "Если мы обслужим вас без них - нас могут оштрафовать или даже закрыть."
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let img_mask:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_face_mask.getImage()
        return img
    }()
    
    let lbl_line_3:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.text = "Нам бы очень хотелось продолжить радовать вас вкусными напитками, и мы просим поддержать нас."
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_line_4:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.text = "Пожалуйста, наденьте маску и перчатки перед входом в кафе и не снимайте их до конца пребывания."
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_line_5:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.text = "Спасибо за понимание!"
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btn_clear:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept(MyStrings.its_clear.localized())
        btn.setRippleColor(color: MyColors.gi.orange.withAlphaComponent(0.5))
        return btn
    }()
    
    init()
    {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.backgroundColor = MyColors.gi.white
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
        
        self.addSubview(lbl_dear_guests)
        self.addSubview(lbl_line_1)
        self.addSubview(lbl_line_2)
        self.addSubview(img_mask)
        self.addSubview(lbl_line_3)
        self.addSubview(lbl_line_4)
        self.addSubview(lbl_line_5)
        self.addSubview(btn_clear)
        
        self.snp.makeConstraints(
            { make in
                
                make.width.equalTo(getScreenWidth() - 16)
                make.height.equalTo(536)
        })
        
        lbl_dear_guests.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(22)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_line_1.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_dear_guests.snp.bottom).offset(10)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_line_2.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_line_1.snp.bottom)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        img_mask.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_line_2.snp.bottom).offset(12)
                make.width.height.equalTo(142)
                make.centerX.equalToSuperview()
        })
        
        lbl_line_3.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_mask.snp.bottom).offset(12)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        
        lbl_line_4.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_line_3.snp.bottom).offset(6)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_line_5.snp.makeConstraints(
             { make in
                 
                 make.top.equalTo(lbl_line_4.snp.bottom).offset(22)
                 make.left.equalToSuperview().offset(16)
                 make.right.equalToSuperview().offset(-16)
         })
        
        btn_clear.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview()
                make.height.equalTo(44)
                make.width.equalTo(112)
                make.bottom.equalToSuperview()
        })
        
        btn_clear.addAction {
            MessagesManager.dismissDialogWithName(name: LaCovidDialog.dialog_name)
        }
    }
}
