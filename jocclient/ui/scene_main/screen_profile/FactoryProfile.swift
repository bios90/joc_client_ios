import UIKit

class FactoryProfile
{
    let vc:BaseViewController
    
    let img_top:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.bg_overlapped.getImage()
        img.layer.shadowColor = MyColors.gi.gray5.cgColor
        img.layer.shadowOpacity = 0.4
        img.layer.shadowRadius = 20
        img.layer.shadowOffset = CGSize(width: 0, height: 0)
        img.layer.zPosition = 10
        return img
    }()
    
    let btn_edit : BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_m)
        btn.br_text.accept(FawString.pencil.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.4))
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        btn.layer.zPosition = 15
        return btn
    }()
    
    let btn_info:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept("")
        btn.setRippleColor(color: MyColors.gi.white.withAlphaComponent(0.4))
        
        let img = MyImage.img_info_circle.getImage().setColorMy(MyColors.gi.white)
        btn.addImage(image: img, size: 24)
        btn.layer.zPosition = 15
        return btn
    }()
    
    let img_avatar:ImgInRoundShadow =
    {
        let img = ImgInRoundShadow()
        img.backgroundColor = MyColors.gi.white
        img.img.image = MyImage.img_info_circle.getImage()
        return img
    }()
    
    let lbl_user_name:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textColor = MyColors.gi.white
        lbl.text = "Mike penzz"
        return lbl
    }()
    
    let lbl_phone:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.light_s
        lbl.textColor = MyColors.gi.white
        lbl.text = "+78124323423"
        return lbl
    }()
    
    let lbl_cups_title : UILabel =
    {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_s
        lbl.textColor = MyColors.gi.white
        lbl.text = MyStrings.cofe.localized()
        return lbl
    }()
    
    let lbl_orders_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = MyStrings.orders.localized()
        return lbl
    }()
    
    let lbl_reviews_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = MyStrings.reviews.localized()
        return lbl
    }()
    
    
    let lbl_cups_count : UILabel =
    {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.bold_l
        lbl.textColor = MyColors.gi.white
        lbl.text = "-"
        return lbl
    }()
    
    let lbl_orders_count : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "-"
        return lbl
    }()
    
    let lbl_reviews_count : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.white
        lbl.text = "-"
        return lbl
    }()
    
    var view_auth :LaAuth =
    {
        let view = LaAuth()
        view.layer.zPosition = 30
        return view
    }()
    
    let tb_orders_items:UITableView =
    {
        let tb = UITableView()
        tb.showsVerticalScrollIndicator = false
        tb.tableFooterView = UIView()
        tb.register(CellOrder.self, forCellReuseIdentifier: CellOrder.reuse_id)
        tb.rowHeight = UITableView.automaticDimension
        tb.estimatedRowHeight = 1000
        tb.separatorInset = UIEdgeInsets.zero
        tb.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tb.backgroundColor = .white
        tb.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 22, right: 0)
        
        return tb
    }()
    
    let refresh_control: UIRefreshControl =
    {
        let rc = ViewsHelper.getDefaultRefreshControl()
        rc.attributedTitle = NSAttributedString(string: MyStrings.refreshing.localized())
        rc.bounds = CGRect.init(x: 0, y: 0, width: 100, height: 100)
        return rc
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = .white
        
        self.vc.view.addSubview(img_top)
        self.vc.view.addSubview(btn_edit)
        self.vc.view.addSubview(btn_info)
        self.img_top.addSubview(img_avatar)
        self.img_top.addSubview(lbl_user_name)
        self.img_top.addSubview(lbl_phone)
        self.img_top.addSubview(lbl_cups_title)
        self.img_top.addSubview(lbl_orders_title)
        self.img_top.addSubview(lbl_reviews_title)
        self.img_top.addSubview(lbl_cups_count)
        self.img_top.addSubview(lbl_orders_count)
        self.img_top.addSubview(lbl_reviews_count)
        self.vc.view.addSubview(tb_orders_items)
        tb_orders_items.refreshControl = refresh_control
        tb_orders_items.addSubview(refresh_control)
        self.vc.view.addSubview(view_auth)
        
        img_top.snp.makeConstraints(
            { make in
                
                make.top.left.right.equalToSuperview()
                make.height.equalTo(184 + getStatusBarHeight())
        })
        
        btn_edit.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 8)
                make.height.width.equalTo(24)
        })
        
        btn_info.snp.makeConstraints(
            { make in
                
                make.right.equalTo(btn_edit.snp.left).offset(-8)
                make.top.equalTo(btn_edit.snp.top)
                make.height.width.equalTo(24)
        })
        
        img_avatar.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(16)
                make.top.equalToTopWithSafe(parent: self.vc.view, offset: 16)
                make.width.height.equalTo(84)
        })
        
        lbl_user_name.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(img_avatar.snp.centerY)
                make.left.equalTo(img_avatar.snp.right).offset(8)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_phone.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_avatar.snp.centerY)
                make.left.equalTo(img_avatar.snp.right).offset(8)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_cups_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_avatar.snp.bottom).offset(12)
                make.left.equalToSuperview()
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_orders_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_cups_title)
                make.left.equalTo(lbl_cups_title.snp.right)
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_reviews_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_cups_title)
                make.left.equalTo(lbl_orders_title.snp.right)
                make.width.equalToSuperview().dividedBy(3)
        })
        
        lbl_cups_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_cups_title)
                make.top.equalTo(lbl_cups_title.snp.bottom)
        })
        
        lbl_orders_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_orders_title)
                make.top.equalTo(lbl_orders_title.snp.bottom)
        })
        
        lbl_reviews_count.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalTo(lbl_reviews_title)
                make.top.equalTo(lbl_reviews_title.snp.bottom)
        })
        
        view_auth.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        tb_orders_items.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img_top.snp.bottom).offset(-22)
                make.left.right.bottom.equalToSuperview()
        })
        
    }
}
