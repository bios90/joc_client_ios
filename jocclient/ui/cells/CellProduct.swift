import UIKit
import Cosmos

class CellProduct:UITableViewCell
{
    static let reuse_id = "CellProduct"
    static let circle_size = 64
    static let card_height = 116
    static let right_width = 78
    
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
        lbl.font = MyFonts.gi.bold_m
        return lbl
    }()
    
    let lbl_description:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .left
        lbl.numberOfLines = 4
        
        return lbl
    }()
    
    
    let view_right:UIView =
    {
        let view = UIView()
        let grad_view = MyColors.gi.getGreenGradient(horizontal: true)
        grad_view.frame = CGRect.init(x: 0, y: 0, width: CellProduct.right_width, height: CellProduct.card_height)
        view.layer.insertSublayer(grad_view,at: 0)
        return view
    }()
    
    let lbl_price:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_m
        lbl.numberOfLines = 0
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
        root_btn.addSubview(view_right)
        view_right.addSubview(lbl_price)
        root_btn.addSubview(lbl_name)
        root_btn.addSubview(lbl_description)
        
        view_root.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
                make.height.equalTo(CellCafe.card_height)
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
                make.width.height.equalTo(CellCafe.circle_size)
        })
        
        view_right.snp.makeConstraints(
            { make in
                
                make.right.top.bottom.equalToSuperview()
                make.width.equalTo(CellProduct.right_width)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(12)
                make.left.equalTo(view_logo.snp.right).offset(6)
                make.right.equalTo(view_right.snp.left).offset(-6)
        })
        
        lbl_description.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_name.snp.bottom).offset(4)
                make.left.equalTo(view_logo.snp.right).offset(6)
                make.right.equalTo(view_right.snp.left).offset(-6)
        })
        
        lbl_price.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(6)
                make.right.equalToSuperview().offset(-6)
                make.centerY.equalToSuperview()
        })
    }
    
    func bindProduct(product:ModelProduct)
    {
        if let url = product.image?.url_m
        {
            view_logo.img.loadImageMy(url_str: url)
        }
        
        lbl_name.text = product.name
        lbl_description.text = product.description
        let price_text = "От\n\(product.getMinPrice().formatWithPattern(format: .formatForPrice))"
        lbl_price.text = price_text
        
//        view_right.myla()
//        let grad_view = MyColors.gi.getOrangeGradient(horizontal: true)
//        grad_view.frame = view_right.bounds
//        view_right.layer.insertSublayer(grad_view,at: 0)
    }
}
