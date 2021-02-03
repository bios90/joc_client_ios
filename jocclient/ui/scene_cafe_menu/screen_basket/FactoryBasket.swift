import UIKit

class FactoryBasket
{
    let vc:BaseViewController!
    let btns_height = 36
    
    let view_top:ViewForGradientBg =
    {
        let view = ViewForGradientBg()
        let grad_view = MyColors.gi.getOrangeGradient(horizontal: true)
        grad_view.frame = view.bounds
        view.layer.insertSublayer(grad_view,at: 0)
        return view
    }()
    
    let lbl_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_m
        lbl.text = MyStrings.basket.localized()
        return lbl
    }()
    
    let view_bottom  : UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.addShadowMin()
        
        return view
    }()
    
    let tb_bakset_items:UITableView =
    {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellBasketItem.self, forCellReuseIdentifier: CellBasketItem.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        tb.bounces = false
        tb.backgroundColor = .white
        return tb
    }()
    
    let view_offer  : UIView =
    {
        let view = UIView()
        return view
    }()
    
    let lbl_sum : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.text = "Suuumamama"
        return lbl
    }()
    
    let btn_order:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getGreenGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.make_offer.localized())
        btn.br_font.accept(MyFonts.gi.bold_m)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.green_dark.withAlphaComponent(0.4))
        btn.addShadowMin()
        return btn
    }()
    
    let btn_quick_order:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.quick_order.localized())
        btn.br_font.accept(MyFonts.gi.bold_m)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.orange_dark.withAlphaComponent(0.4))
        btn.addShadowMin()
        return btn
    }()
    
    let lbl_cafe_not_active : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.text = MyStrings.cafe_cant_take_payment.localized()
        return lbl
    }()
    
    let view_need_to_register  : UIView =
    {
        let view = UIView()
        return view
    }()
    
    let lbl_need_to_register:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        lbl.numberOfLines = 0
        lbl.text = MyStrings.need_register_to_make_order.localized()
        return lbl
    }()
    
    let btn_register:BtnRipple =
    {
        let btn = BtnRipple()
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.registration.localized())
        btn.backgroundColor = MyColors.gi.transparent
        btn.layer.borderWidth = 1
        btn.layer.borderColor = MyColors.gi.orange.cgColor
        btn.br_text_color.accept(MyColors.gi.orange)
        btn.setRippleColor(color: MyColors.gi.orange.withAlphaComponent(0.4))
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        self.setupViews()
    }
    
    func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.white
        
        self.vc.view.addSubview(view_top)
        view_top.addSubview(lbl_title)
        self.vc.view.addSubview(tb_bakset_items)
        self.vc.view.addSubview(view_bottom)
        
        view_top.snp.makeConstraints(
            { make in
                
                let height = 56 + getStatusBarHeight()
                make.centerX.width.equalToSuperview()
                make.top.equalToSuperview()
                make.height.equalTo(height)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.bottom.equalToSuperview().offset(-16)
        })
        
        view_bottom.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.bottom.equalToBottomWithSafe(parent: self.vc.view, offset: 0)
                make.height.equalTo(146)
        })
        
        tb_bakset_items.snp.makeConstraints(
            { make in
                
                make.top.equalTo(view_top.snp.bottom)
                make.left.right.equalToSuperview()
                make.bottom.equalTo(view_bottom.snp.top)
        })
        
        view_need_to_register.addSubview(btn_register)
        view_need_to_register.addSubview(lbl_need_to_register)
        
        lbl_need_to_register.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalTo(btn_register.snp.top).offset(-8)
        })
        
        btn_register.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(btns_height)
                make.bottom.equalToSuperview().offset(-16)
        })
        
        view_offer.addSubview(btn_quick_order)
        view_offer.addSubview(btn_order)
        view_offer.addSubview(lbl_sum)
        
        btn_quick_order.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(btns_height)
                make.bottom.equalToSuperview().offset(-16)
        })
        
        btn_order.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(btns_height)
                make.bottom.equalTo(btn_quick_order.snp.top).offset(-8)
        })
        
        lbl_sum.snp.makeConstraints(
            {make in
                
                make.bottom.equalTo(btn_order.snp.top).offset(-10)
                make.centerX.equalToSuperview()
        })

    }
}
