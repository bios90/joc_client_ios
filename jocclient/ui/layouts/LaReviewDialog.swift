import UIKit
import Cosmos

class LaReviewDialog:UIView
{
    static let dialog_name = "ReviewDialog"
    
    var action_clicked:((Int,String?) -> Void)?
    
    let lbl_order_number:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.text = MyStrings.dear_guests.localized()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_xl
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let lbl_line_1:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.text = "В Москве усилен контроль за ношением масок и перчаток."
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let tv_comment:UITextView =
    {
        let tv = UITextView()
        tv.layer.backgroundColor = MyColors.gi.gray1.cgColor
        tv.layer.borderColor = MyColors.gi.gray3.cgColor
        tv.layer.borderWidth = 1
        tv.layer.cornerRadius = 4
        tv.textColor = MyColors.gi.gray7
        tv.font = MyFonts.gi.reg_m
        tv.textContainerInset = UIEdgeInsets.init(top: 10, left: 10, bottom: 10, right: 10)
        return tv
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStars()
        cosmos.settings.starSize = 28
        cosmos.settings.updateOnTouch = true
        cosmos.settings.fillMode = .full
        cosmos.rating = 5
        return cosmos
    }()
    
    let btn_ok :BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.reg_m)
        btn.br_text.accept(MyStrings.save.localized())
        btn.br_text_color.accept(MyColors.gi.gray5)
        return btn
    }()
    
    let btn_cancel :BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.reg_m)
        btn.br_text.accept(MyStrings.cancel.localized())
        btn.br_text_color.accept(MyColors.gi.gray5)
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
        
        self.addSubview(lbl_order_number)
        self.addSubview(lbl_line_1)
        self.addSubview(tv_comment)
        self.addSubview(rating)
        self.addSubview(btn_ok)
        self.addSubview(btn_cancel)
        
        self.snp.makeConstraints(
            { make in
                
                make.width.equalTo(getScreenWidth() - 32)
                make.bottom.equalTo(btn_ok)
                make.top.equalTo(lbl_order_number).offset(-12)
        })
        
        lbl_order_number.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.top.equalToSuperview().offset(12)
        })
        
        lbl_line_1.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(lbl_order_number.snp.bottom).offset(6)
        })
        
        tv_comment.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_line_1.snp.bottom).offset(12)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(140)
        })
        
        rating.snp.makeConstraints(
            { make in
                
                make.top.equalTo(tv_comment.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
        })
        
        btn_ok.snp.makeConstraints(
            { make in
                
                make.top.equalTo(rating.snp.bottom).offset(20)
                make.width.equalToSuperview().multipliedBy(0.5)
                make.height.equalTo(44)
                make.right.equalToSuperview()
        })
        
        btn_cancel.snp.makeConstraints(
            { make in
                
                make.top.equalTo(rating.snp.bottom).offset(20)
                make.width.equalToSuperview().multipliedBy(0.5)
                make.height.equalTo(44)
                make.left.equalToSuperview()
        })
        
        
        btn_cancel.addAction {
            MessagesManager.dismissDialogWithName(name: LaReviewDialog.dialog_name)
        }
        
        btn_ok.addAction {
            
            let rate = Int(self.rating.rating)
            let text = self.tv_comment.text
            
            self.action_clicked?(rate,text)
        }
    }
    
    func bindOrder(order:ModelOrder)
    {
        lbl_order_number.text = "Заказ \(order.id ?? 0)"
        let text = "\(order.cafe?.name ?? "") - \(order.date?.formatToString() ?? "") - \(order.sum?.formatWithPattern(format: .formatForPrice) ?? "") р. \n\(order.cafe?.address ?? "")"
        lbl_line_1.text = text
    }
}
