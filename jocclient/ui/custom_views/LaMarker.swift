import UIKit

class LaMarker:UIView
{
    let cafe:ModelCafe
    
    let lbl:UILabel =
    {
        let lbl = UILabel()
        lbl.textColor = MyColors.gi.white
        lbl.font = MyFonts.gi.reg_xs
        lbl.textAlignment = .center
        lbl.numberOfLines = 1
        return lbl
    }()
    
    let img:UIImageView =
    {
        let img = UIImageView()
        img.image = MyImage.img_marker.getImage()
        return img
    }()
    
    init(cafe:ModelCafe)
    {
        self.cafe = cafe
        let rect = CGRect(x: 0, y: 0, width: 98, height: 36)
        super.init(frame:rect)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        self.addSubview(img)
        self.addSubview(lbl)
        
        img.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        lbl.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(8)
                make.left.right.equalToSuperview()
        })
        
        lbl.text = cafe.name
    }
}
