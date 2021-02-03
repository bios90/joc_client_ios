import UIKit
import MultiSlider
import Cosmos

class FactoryFilter
{
    let vc:BaseViewController
    
    let view_dialog:UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.white
        view.layer.cornerRadius = 4
        view.clipsToBounds = true
        return view
    }()
    
    let lbl_title : UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.filter.localized()
        lbl.textColor = MyColors.gi.gray6
        lbl.font = MyFonts.gi.bold_l
        return lbl
    }()
    
    let lbl_middle_price : UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.average_cup_price.localized()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let lbl_price_min:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.reg_m
        lbl.layer.cornerRadius = 4
        lbl.backgroundColor = MyColors.gi.gray2
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    let lbl_price_max:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.reg_m
        lbl.layer.cornerRadius = 4
        lbl.backgroundColor = MyColors.gi.gray2
        lbl.clipsToBounds = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    let lbl_type : UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.cafe_type.localized()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let bubbles_cafe_type:BubblesView =
    {
        let bubbles = BubblesView()        
        return bubbles
    }()
    
    let lbl_rating_title : UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.rating.localized()
        lbl.textColor = MyColors.gi.gray4
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let lbl_rating_from : UILabel =
    {
        let lbl = UILabel()
        lbl.text = MyStrings.from.localized()
        lbl.textColor = MyColors.gi.gray7
        lbl.textAlignment = .center
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    let lbl_rating_num: UILabel =
    {
        let lbl = UILabel()
        lbl.text = "4.0"
        lbl.textColor = MyColors.gi.gray7
        lbl.font = MyFonts.gi.reg_m
        lbl.textAlignment = .center
        return lbl
    }()
    
    let range_bar:MultiSlider =
    {
        let rb = MultiSlider()
        rb.minimumValue = 0
        rb.maximumValue = 100
        rb.orientation = .horizontal
        rb.value = [0,100]
        rb.tintColor = MyColors.gi.gray1
        rb.outerTrackColor = MyColors.gi.gray3
        rb.tintColor = MyColors.gi.orange
        rb.showsThumbImageShadow = false
        rb.trackWidth = 6
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        view.backgroundColor = MyColors.gi.white
        view.layer.borderWidth = 4
        view.layer.borderColor = MyColors.gi.orange.cgColor
        rb.thumbImage = UIImage.initFromView(view: view)
        
        return rb
    }()
    
    let view_for_labels:UIView =
    {
        let view = UIView()
        return view
    }()
    
    let rating_view:CosmosView =
    {
        let rating = ViewsHelper.getRatingStars()
        rating.settings.updateOnTouch = true
        rating.rating = 4.0
        return rating
    }()
    
    let view_divider_1 :UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray3
        return view
    }()
    
    let view_divider_2 :UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray3
        return view
    }()
    
    let btn_ok:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept(MyStrings.apply.localized())
        return btn
    }()
    
    let btn_cancel:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept(MyStrings.cancel.localized())
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.black.withAlphaComponent(0.6)
        
        self.vc.view.addSubview(view_dialog)
        view_dialog.addSubview(lbl_title)
        view_dialog.addSubview(lbl_middle_price)
        view_dialog.addSubview(lbl_price_min)
        view_dialog.addSubview(lbl_price_max)
        view_dialog.addSubview(lbl_type)
        view_dialog.addSubview(bubbles_cafe_type)
        view_dialog.addSubview(range_bar)
        view_dialog.addSubview(view_for_labels)
        view_dialog.addSubview(lbl_rating_title)
        view_dialog.addSubview(lbl_rating_from)
        view_dialog.addSubview(lbl_rating_num)
        view_dialog.addSubview(rating_view)
        view_dialog.addSubview(view_divider_1)
        view_dialog.addSubview(view_divider_2)
        view_dialog.addSubview(btn_ok)
        view_dialog.addSubview(btn_cancel)
        
        view_dialog.snp.makeConstraints(
            { make in
                
                make.width.equalToSuperview().offset(-32)
                make.center.equalToSuperview()
                //                make.height.equalTo(500)
                make.top.equalTo(lbl_title.snp.top)
                make.bottom.equalTo(btn_cancel.snp.bottom)
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(16)
        })
        
        lbl_middle_price.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(12)
        })
        
        lbl_price_min.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalTo(view_dialog.snp.centerX).offset(-6)
                make.height.equalTo(38)
                make.top.equalTo(lbl_middle_price.snp.bottom).offset(8)
        })
        
        lbl_price_max.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.left.equalTo(view_dialog.snp.centerX).offset(6)
                make.height.equalTo(38)
                make.top.equalTo(lbl_middle_price.snp.bottom).offset(8)
        })
        
        range_bar.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.height.equalTo(12)
                make.top.equalTo(lbl_price_min.snp.bottom).offset(12)
        })
        
        view_for_labels.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(4)
                make.right.equalToSuperview().offset(-4)
                make.top.equalTo(range_bar.snp.bottom).offset(8)
                make.height.equalTo(20)
        })
        
        addSliderLabels()
        lbl_type.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalTo(view_for_labels.snp.bottom).offset(16)
        })
        
        bubbles_cafe_type.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.top.equalTo(lbl_type.snp.bottom).offset(6)
                make.height.equalTo(30)
        })
        
        let bubble_1 = Bubble(text: MyStrings.all.localized())
        let bubble_2 = Bubble(text: MyStrings.cafe.localized())
        let bubble_3 = Bubble(text: MyStrings.coffee_spot.localized())
        bubbles_cafe_type.setBubbles(bubbles: [bubble_1,bubble_2,bubble_3])
        self.bubbles_cafe_type.setSelected(selected: [0])
        
        lbl_rating_title.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalTo(bubbles_cafe_type.snp.bottom).offset(16)
        })
        
        rating_view.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_rating_title.snp.bottom).offset(12)
                make.centerX.equalToSuperview()
        })
        
        lbl_rating_from.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.right.equalTo(rating_view.snp.left)
                make.centerY.equalTo(rating_view)
        })
        
        
        lbl_rating_num.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.left.equalTo(rating_view.snp.right)
                make.centerY.equalTo(rating_view)
        })
        
        view_divider_1.snp.makeConstraints(
            { make in
                
                make.left.right.equalToSuperview()
                make.height.equalTo(1)
                make.top.equalTo(rating_view.snp.bottom).offset(16)
        })
        
        btn_ok.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview()
                make.left.equalTo(view_dialog.snp.centerX)
                make.height.equalTo(38)
                make.top.equalTo(view_divider_1.snp.bottom)
        })
        
        view_divider_2.snp.makeConstraints(
            { make in
                
                make.centerX.equalToSuperview()
                make.top.equalTo(btn_ok)
                make.bottom.equalTo(btn_ok)
                make.width.equalTo(1)
        })
        
        btn_cancel.snp.makeConstraints(
            { make in
                
                
                make.left.equalToSuperview()
                make.right.equalTo(view_dialog.snp.centerX)
                make.height.equalTo(38)
                make.top.equalTo(view_divider_1.snp.bottom)
        })
    }
    
    private func addSliderLabels()
    {
        var left_anchor = view_for_labels.snp.left
        view_dialog.myla()
        let each_width = (view_dialog.frame.width - 8) / 11
        for var i in 0...10
        {
            let lbl = ViewsHelper.getRangeLabel(num: i*100)
            view_for_labels.addSubview(lbl)
            lbl.snp.makeConstraints(
                { make in
                    
                    make.width.equalTo(each_width)
                    make.top.height.equalToSuperview()
                    make.left.equalTo(left_anchor)
            })
            
            left_anchor = lbl.snp.right
        }
    }
}
