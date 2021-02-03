import UIKit

class ImgSquareStroked:UIView
{
    var corner_radius = CGFloat(4)
    
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
        self.layer.borderColor = MyColors.gi.white.cgColor
        self.layer.borderWidth = 1
        self.clipsToBounds = false
        self.addShadowMin()
        
        self.layer.cornerRadius = corner_radius
        img.layer.cornerRadius = corner_radius
        
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
    
}
