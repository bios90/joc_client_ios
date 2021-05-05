import UIKit
import SwiftyAvatar
import Cosmos
import CoreLocation

class LaCafePopup:UIView
{
    static let circle_size = 96
    static let route_btn_height = 26
    let cafe:ModelCafe
    let action_clicked:(ModelCafe)->Void
    let action_clicked_route:(RouteInfoMy)->Void
    
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
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_location_arrow:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_light_s
        lbl.text = FawString.location_arrow.rawValue
        lbl.textColor = MyColors.gi.gray4
        return lbl
    }()
    
    let lbl_distance:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_s
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStars()
        return cosmos
    }()
    
    let btn_route:BtnRipple =
    {
        let btn = BtnRipple()
        btn.layer.cornerRadius = CGFloat(LaCafePopup.route_btn_height / 2)
        btn.clipsToBounds = true
        return btn
    }()
    
    let lbl_walk:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.faw_solid_xs
        lbl.textColor = MyColors.gi.white
        lbl.text = FawString.walk.rawValue
        return lbl
    }()
    
    let lbl_walk_time:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_xs
        lbl.textColor = MyColors.gi.white
        return lbl
    }()
    
    let lbl_description:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textColor = MyColors.gi.gray4
        lbl.numberOfLines = 12
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
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.br_text.accept(MyStrings.visit.localized())
        btn.br_text_color.accept(MyColors.gi.white)
        btn.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        return btn
    }()
    
    init(cafe:ModelCafe,action_clicked:@escaping (ModelCafe)->Void,action_clicked_route:@escaping (RouteInfoMy)->Void)
    {
        self.cafe = cafe
        self.action_clicked = action_clicked
        self.action_clicked_route = action_clicked_route
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
        
        lbl_walk_time.text = cafe.getDistanseText()
        
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
        self.addSubview(btn_route)
        btn_route.addSubview(lbl_walk)
        btn_route.addSubview(lbl_walk_time)
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
                
                make.left.equalTo(lbl_location_arrow.snp.right).offset(4)
                make.centerY.equalTo(lbl_location_arrow)
        })
        
        lbl_walk.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
        })
        
        lbl_walk_time.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-10)
                make.left.equalTo(lbl_walk.snp.right).offset(4)
                make.centerY.equalToSuperview()
        })
        
        btn_route.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-16)
                make.height.equalTo(LaCafePopup.route_btn_height)
                make.centerY.equalTo(rating)
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
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.makeRoundCorners(corners: [.topLeft,.topRight], radius: 12)
        
        loadRoute()
    }
    
    private func loadRoute()
    {
        guard let user_location = BusMainEvents.gi.br_current_location.value,
            let cafe_location = cafe.getCafeLocation() else { return }
        
        RoutesManager.gi.getRouteInfo(start: user_location, finish: cafe_location, action_success:
            { route_info in
                
                self.lbl_walk_time.text = route_info.getTimeText()
                self.lbl_distance.text = route_info.getDistanceText()
                
                self.btn_route.myla()
                self.btn_route.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
                
                self.btn_route.addAction {
                    self.action_clicked_route(route_info)
                }
        })
    }
}
