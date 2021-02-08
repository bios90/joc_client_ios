import UIKit

class CellOrder:UITableViewCell
{
    static let reuse_id = "CellOrder"
    static let circle_size = 74
    static let card_height = 116
    static let right_width = 78
    
    let gradient_layer_right:CAGradientLayer =
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = TypeOrderStatus.wait.getGradientColor().map({ $0.cgColor })
        gradientLayer.locations = [0, 1]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = CGRect.init(x: 0, y: 0, width: CellOrder.right_width, height: CellOrder.card_height)
        return gradientLayer
    }()
    
    let view_root:UIView =
    {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let lbl_order_date:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray5
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.reg_m
        lbl.text = "22 ss 1234"
        return lbl
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
    
    let lbl_order_id:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.orange
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    let lbl_cafe_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_l
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let lbl_adress:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray4
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.numberOfLines = 2
        return lbl
    }()
    
    let lbl_menu:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.textAlignment = .left
        lbl.font = MyFonts.gi.reg_s
        return lbl
    }()
    
    let view_right:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let lbl_time_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = MyStrings.time.localized()
        return lbl
    }()
    
    let lbl_time:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_s
        return lbl
    }()
    
    let lbl_sum_title:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = MyStrings.sum.localized()
        return lbl
    }()
    
    let lbl_sum:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_s
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
        view_root.addSubview(lbl_order_date)
        view_root.addSubview(root_btn)
        
        root_btn.addSubview(view_logo)
        root_btn.addSubview(view_right)
        root_btn.addSubview(lbl_order_id)
        root_btn.addSubview(lbl_cafe_name)
        root_btn.addSubview(lbl_adress)
        root_btn.addSubview(lbl_menu)
        view_right.addSubview(lbl_time_title)
        view_right.addSubview(lbl_time)
        view_right.addSubview(lbl_sum_title)
        view_right.addSubview(lbl_sum)
        
        view_root.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
                make.bottom.equalTo(root_btn.snp.bottom)
        })
        
        lbl_order_date.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(24)
                make.top.equalToSuperview().offset(6)
        })
        
        root_btn.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_order_date.snp.bottom).offset(4)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(CellOrder.card_height)
        })
        
        view_logo.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(CellOrder.circle_size)
                make.centerY.equalToSuperview()
                make.left.equalToSuperview().offset(12)
        })
        
        view_right.snp.makeConstraints(
            { make in
                
                make.right.top.bottom.equalToSuperview()
                make.width.equalTo(CellOrder.right_width)
        })
        view_right.layer.insertSublayer(gradient_layer_right,at: 0)
        
        
        lbl_order_id.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(10)
                make.left.equalTo(view_logo.snp.right).offset(4)
                make.right.equalTo(view_right.snp.left).offset(-8)
        })
        
        lbl_cafe_name.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_order_id.snp.bottom).offset(4)
                make.left.equalTo(view_logo.snp.right).offset(4)
                make.right.equalTo(view_right.snp.left).offset(-8)
        })
        
        lbl_adress.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_cafe_name.snp.bottom).offset(4)
                make.left.equalTo(view_logo.snp.right).offset(4)
                make.right.equalTo(view_right.snp.left).offset(-8)
        })
        
        lbl_menu.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_adress.snp.bottom).offset(4)
                make.left.equalTo(view_logo.snp.right).offset(4)
                make.right.equalTo(view_right.snp.left).offset(-8)
        })
        
        lbl_time_title.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(8)
                make.centerX.equalToSuperview()
        })
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_time_title.snp.bottom)
                make.centerX.equalToSuperview()
        })
        
        lbl_sum_title.snp.makeConstraints(
            { make in
                
                make.bottom.equalToSuperview().offset(-8)
                make.centerX.equalToSuperview()
        })
        
        lbl_sum.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(lbl_sum_title.snp.top)
                make.centerX.equalToSuperview()
        })
    }
    
    func bindOrder(order:ModelOrder, need_to_show_date:Bool)
    {
        if need_to_show_date
        {
            lbl_order_date.text = order.date?.formatToString()
        }
        else
        {
            lbl_order_date.text = ""
        }
        
        if let url = order.cafe?.logo?.url_m
        {
            view_logo.img.loadImageMy(url_str: url)
        }
        
        lbl_order_id.text = MyStrings.order_number.localized() + " : \(order.id ?? 0)"
        lbl_cafe_name.text = order.cafe?.name
        lbl_adress.text = order.cafe?.address
        
        let products_str = order.items?.map({ ($0.product.name ?? "") }).joined(separator: ", ")
        lbl_menu.text = products_str
        
        lbl_time.text = order.date?.formatToString(format: DateManager.FORMAT_TIME)
        lbl_sum.text = (order.sum ?? 0).formatWithPattern(format: .formatForPrice) + " р."
        
        view_right.layer.insertSublayer(gradient_layer_right,at: 0)
        if let colors = order.status?.getGradientColor()
        {
            gradient_layer_right.colors = colors.map({ $0.cgColor })
        }
    }
    
}
