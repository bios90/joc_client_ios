import UIKit
import SwiftyAvatar
import Cosmos

class LaCafePopup:UIView
{
    static let circle_size = 96
    let cafe:ModelCafe
    let action_clicked:(ModelCafe)->Void
    
    let view_for_avatar:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.layer.cornerRadius = CGFloat(circle_size / 2)
        view.clipsToBounds = false
        view.addShadowMin()
        return view
    }()
    
    let img_avatar :UIImageView =
    {
        let img = UIImageView()
        img.clipsToBounds = true
        img.layer.cornerRadius = CGFloat(circle_size / 2)
        img.image = MyImage.img_info_circle.getImage()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    let lbl_name:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray6
        lbl.text = "Nammemememememe"
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_l
        return lbl
    }()
    
    let lbl_adress:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_m
        lbl.textAlignment = .center
        lbl.text = "safsfnaskljfnkasnf"
        return lbl
    }()
    
    let lbl_location_arrow:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.location_arraw.rawValue
        lbl.textColor = MyColors.gi.gray4
        return lbl
    }()
    
    let lbl_distance:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_s
        lbl.textColor = MyColors.gi.gray4
        return lbl
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStars()
        return cosmos
    }()
    
    let lbl_description:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.text = "afgjn dskfjlgk sbdgkhdbsfg hkasdj fkldfsbg ks bdfgksdfhbg lbhw lkbhkhbsdf bhdjfbg sdjkfhblwhb lkbhlkbsfdlhb sfjhbg"
        lbl.textColor = MyColors.gi.gray4
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_clock:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.clock.rawValue
        lbl.textColor = MyColors.gi.gray4
        return lbl
    }()
    
    let lbl_time:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_s
        lbl.text = "21:30 - 23:15"
        lbl.textColor = MyColors.gi.gray6
        return lbl
    }()
    
    let btn_to_cafe:BtnRipple =
    {
        let btn = BtnRipple()
        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept("To cafeeee")
        btn.br_text_color.accept(MyColors.gi.white)
        return btn
    }()
    
    init(cafe:ModelCafe,action_clicked:@escaping (ModelCafe)->Void)
    {
        self.cafe = cafe
        self.action_clicked = action_clicked
        super.init(frame: .zero)
        setupViews()
        bindCafe()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bindCafe()
    {
        if let url = cafe.logo?.url_m
        {
             img_avatar.loadImageMy(url_str: url)
        }
        
        lbl_name.text = cafe.name
        lbl_adress.text = cafe.address
        rating.rating = cafe.rating ?? 0.0
        lbl_description.text = cafe.description
        lbl_time.text = cafe.working_hours_str
        
        lbl_distance.text = cafe.getDistanseText()
        
        btn_to_cafe.addAction {
            self.action_clicked(self.cafe)
        }
    }
    
    private func setupViews()
    {
        self.addSubview(view_for_avatar)
        view_for_avatar.addSubview(img_avatar)
        self.addSubview(lbl_name)
        self.addSubview(lbl_adress)
        self.addSubview(rating)
        self.addSubview(lbl_location_arrow)
        self.addSubview(lbl_distance)
        self.addSubview(lbl_description)
        self.addSubview(lbl_clock)
        self.addSubview(lbl_time)
        self.addSubview(btn_to_cafe)
        
        self.backgroundColor = MyColors.gi.white
//        self.layer.cornerRadius = 12
    
        self.snp.makeConstraints(
            { make in
                
                make.width.equalTo(getScreenWidth())
                let last_view = self.subviews.last!
                make.bottom.equalTo(last_view.snp.bottom).offset(16+getBottomSafeInset())
        })
        
        view_for_avatar.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(24)
                make.centerX.equalToSuperview()
                make.width.height.equalTo(LaCafePopup.circle_size)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        lbl_name.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(view_for_avatar.snp.bottom).offset(12)
        })
        
        lbl_adress.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(lbl_name.snp.bottom).offset(2)
        })
        
        rating.snp.makeConstraints(
            { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(lbl_adress.snp.bottom).offset(8)
        })
        
        lbl_location_arrow.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(rating)
                make.left.equalToSuperview().offset(16)
        })
        
        lbl_distance.snp.makeConstraints(
            { make in
                
                make.centerY.equalTo(rating)
                make.left.equalTo(lbl_location_arrow.snp.right).offset(8)
        })
        
        lbl_description.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.top.equalTo(rating.snp.bottom).offset(16)
        })
        
        lbl_clock.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(lbl_description.snp.bottom).offset(16)
        })
        
        
        lbl_time.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(lbl_clock.snp.bottom)
        })
        
        btn_to_cafe.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(36)
                make.top.equalTo(lbl_time.snp.bottom).offset(16)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.makeRoundCorners(corners: [.topLeft,.topRight], radius: 12)
    }
}
