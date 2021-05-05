import UIKit
import Cosmos

class CellCafe:UITableViewCell
{
    static let reuse_id = "CellCafe"
    static let circle_size = 76
    static let card_height = 116
    
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
    
    let view_for_avatar:ImgInRoundShadow =
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
    
    let lbl_adress:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .center
        return lbl
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStars()
        cosmos.settings.starSize = 18
        return cosmos
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
    
    let lbl_location_arrow:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.location_arrow.rawValue
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    let lbl_distance:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_xs
        lbl.text = "212m"
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
        root_btn.addSubview(view_for_avatar)
        root_btn.addSubview(lbl_name)
        root_btn.addSubview(lbl_adress)
        root_btn.addSubview(rating)
        root_btn.addSubview(lbl_clock)
        root_btn.addSubview(lbl_time)
        root_btn.addSubview(lbl_location_arrow)
        root_btn.addSubview(lbl_distance)
        
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
        
        view_for_avatar.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CellCafe.circle_size)
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(12)
                make.left.equalTo(view_for_avatar.snp.right).offset(12)
                make.right.equalToSuperview().offset(-12)
        })
        
        lbl_adress.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_name.snp.bottom)
                make.left.equalTo(view_for_avatar.snp.right).offset(12)
                make.right.equalToSuperview().offset(-12)
        })
        
        rating.snp.makeConstraints(
            { make in
                
                make.centerX.equalTo(lbl_adress)
                make.top.equalTo(lbl_adress.snp.bottom).offset(4)
        })
        
        lbl_clock.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_for_avatar.snp.right).offset(12)
                make.bottom.equalToSuperview().offset(-10)
        })
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(lbl_clock)
                make.left.equalTo(lbl_clock.snp.right).offset(6)
        })
        
        lbl_location_arrow.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalToSuperview().offset(-10)
        })
        
        lbl_distance.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(lbl_location_arrow)
                make.right.equalTo(lbl_location_arrow.snp.left).offset(-6)
        })
    }
    
    func bindCafe(cafe:ModelCafe)
    {
        if let url = cafe.logo?.url_m
        {
            view_for_avatar.img.loadImageMy(url_str: url)
        }
        
        lbl_name.text = cafe.name
        lbl_adress.text = cafe.address
        rating.rating = cafe.rating ?? 0.0
        lbl_time.text = cafe.working_hours_str
        lbl_distance.text = cafe.getDistanseText()
    }
    
}
