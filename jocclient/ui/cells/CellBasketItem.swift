import UIKit

class CellBasketItem:UITableViewCell
{
    static let reuse_id = "CellBasketItem"
    static let circle_size = 56
    static let card_height = 98
    static let right_width = 72
    
    let view_root:UIView =
    {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let root_btn : BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept("")
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.white
        btn.layer.backgroundColor = MyColors.gi.white.cgColor
        
        return btn
    }()
    
    let view_logo:ImgInRoundShadow =
    {
        let view = ImgInRoundShadow()
        return view
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let lbl_price:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_m
        return lbl
    }()
    
    let view_for_data:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let lbl_title_weight: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray3
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = MyStrings.weight.localized()
        return lbl
    }()
    
    let lbl_title_sugar: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray3
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = MyStrings.sugar.localized()
        return lbl
    }()
    
    let lbl_title_milk: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray3
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = MyStrings.milk.localized()
        return lbl
    }()
    
    let lbl_text_weight: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    let lbl_text_sugar: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    let lbl_text_milk: UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout_subviews_my()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout_subviews_my()
    {
        self.addShadowMin()
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.backgroundColor = .clear
        
        self.contentView.addSubview(view_root)
        view_root.addSubview(root_btn)
        root_btn.addSubview(view_logo)
        root_btn.addSubview(lbl_price)
        root_btn.addSubview(lbl_name)
        root_btn.addSubview(view_for_data)
        
        view_for_data.addSubview(lbl_title_weight)
        view_for_data.addSubview(lbl_title_sugar)
        view_for_data.addSubview(lbl_title_milk)
        view_for_data.addSubview(lbl_text_weight)
        view_for_data.addSubview(lbl_text_sugar)
        view_for_data.addSubview(lbl_text_milk)
        
        view_root.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
                make.height.equalTo(CellBasketItem.card_height)
        })
        
        root_btn.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalToSuperview()
        })
        
        view_logo.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CellBasketItem.circle_size)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_logo.snp.right).offset(8)
                make.top.equalToSuperview().offset(12)
        })
        
        lbl_price.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview()
                make.width.equalTo(CellBasketItem.right_width)
                make.centerY.equalToSuperview()
        })
        
        view_for_data.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_logo.snp.right).offset(8)
                make.right.equalTo(lbl_price.snp.left).offset(-8)
                make.top.equalTo(lbl_name.snp.bottom).offset(8)
        })
        
        lbl_title_weight.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
                make.left.equalToSuperview()
        })
        
        lbl_title_sugar.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
                make.centerX.equalToSuperview()
        })
        
        lbl_title_milk.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
                make.right.equalToSuperview()
        })
        
        lbl_text_weight.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title_weight.snp.bottom)
                make.width.equalToSuperview().dividedBy(3)
                make.left.equalToSuperview()
        })
        
        lbl_text_sugar.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title_weight.snp.bottom)
                make.width.equalToSuperview().dividedBy(3)
                make.centerX.equalToSuperview()
        })
        
        lbl_text_milk.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title_weight.snp.bottom)
                make.width.equalToSuperview().dividedBy(3)
                make.right.equalToSuperview()
        })
    }
    
    func bindItem(item:ModelBasketItem)
    {
        if let url = item.product.image?.url_m
        {
            view_logo.img.loadImageMy(url_str: url)
        }
        
        lbl_name.text = item.product.name
        lbl_price.text = item.getSum().formatWithPattern(format: .formatForPrice) + " р"
        
        lbl_text_weight.text  = item.weight?.value
        lbl_text_milk.text = item.milk?.value
        
        if item.product.type != TypeProduct.Snack
        {
            var text_shugar = String(item.sugar)
            if item.sugar == 0
            {
                text_shugar = MyStrings.no_sugar.localized()
            }
            
            lbl_text_sugar.text = text_shugar
        }
    }
}
