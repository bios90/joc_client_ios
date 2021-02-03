import UIKit

class ImgInRoundShadow:UIView
{
    var is_round  = true
    
    let btn:BtnRipple =
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.white
        btn.setRippleColor(color: MyColors.gi.red.withAlphaComponent(0.2))
        btn.clipsToBounds = true
        return btn
    }()
    
    let img : UIImageView =
    {
        let img = UIImageView()
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        self.backgroundColor = MyColors.gi.white
        self.clipsToBounds = false
        self.addShadowMin()
        
        self.addSubview(img)
        
        img.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        if(is_round)
        {
            let corner_radius = self.frame.width / 2
            self.layer.cornerRadius = corner_radius
            img.layer.cornerRadius = corner_radius
        }        
    }
}
