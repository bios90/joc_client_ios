import UIKit

class FactoryMap
{
    let vc:BaseViewController
    
    let btn_location:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_m)
        btn.br_text.accept(FawString.location_arrow.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.layer.cornerRadius = 22
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.orange
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        return btn
    }()
    
    let btn_clear_route:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_font.accept(MyFonts.gi.faw_solid_l)
        btn.br_text.accept(FawString.times.rawValue)
        btn.br_text_color.accept(MyColors.gi.white)
        btn.layer.cornerRadius = 22
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.orange
        btn.contentEdgeInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        btn.alpha = 0
        return btn
    }()
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = .cyan
        self.vc.view.addSubview(btn_location)
        self.vc.view.addSubview(btn_clear_route)
        
        self.btn_location.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(44)
                let padding_right = 44 + 12 + 10
                make.right.equalToSuperview().offset(-(padding_right))
                let padding_bottom = 49 + 12 + getBottomSafeInset()
                make.bottom.equalToSuperview().offset(-padding_bottom)
        })
        
        self.btn_clear_route.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(44)
                make.right.equalToSuperview().offset(-12)
                let padding_top = 12 + getStatusBarHeight()
                make.top.equalToSuperview().offset(padding_top)
        })
    }
}
