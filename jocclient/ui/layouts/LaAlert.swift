import UIKit
import SnapKit

class LaAlert:UIView
{
    let color_bg : UIColor
    let text:String
    
    static let img_size:CGFloat = 32
    static let bottom_offset:CGFloat = 20
    static let top_offset:CGFloat = 12
    
    let img:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.ic_bell.getImage()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    let lbl_text : UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 0
        
        lbl.font = MyFonts.gi.reg_m
        return lbl
    }()
    
    init(text:String,color:UIColor)
    {
        self.text = text
        self.color_bg = color
        super.init(frame: CGRect.zero)
        customInit()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func customInit()
    {
        self.backgroundColor = color_bg
        self.addSubview(lbl_text)
        self.addSubview(img)
        
        lbl_text.snp.makeConstraints(
            { make in
                
                let lbl_width = UIScreen.main.bounds.width - LaAlert.img_size-16-16-16
                make.width.equalTo(lbl_width)
                make.left.equalToSuperview().offset(LaAlert.img_size+16+16)
                make.bottom.equalToSuperview().offset(-LaAlert.bottom_offset)
                
        })
        lbl_text.text = text
        lbl_text.sizeToFit()
        
        img.setImageColor(color: MyColors.gi.white)
        
        img.snp.makeConstraints(
            { make in
            
                make.width.height.equalTo(LaAlert.img_size)
                make.centerY.equalTo(lbl_text.snp.centerY)
                make.left.equalToSuperview().offset(16)
        })
        
        img.layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.0,
            animations: {
        }, completion:
            { _ in
                UIView.animate(
                    withDuration: 0.8,
                    delay: 0.0,
                    options: [.autoreverse, .repeat],
                    animations:
                    {
                        let scale = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        self.img.transform = scale
                }, completion: nil)
        })
    }
    
    func getLaHeight() -> CGFloat
    {
        lbl_text.layoutIfNeeded()
        lbl_text.sizeToFit()
        lbl_text.layoutIfNeeded()
        
        let height = lbl_text.frame.height +  LaAlert.bottom_offset + LaAlert.top_offset
            + getStatusBarHeight()
        return  height
    }
}
