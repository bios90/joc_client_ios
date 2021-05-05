import UIKit

class ViewSlide:UIView
{
    let img: UIImageView =
    {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let lbl_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.orange
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let lbl_text : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textAlignment = .center
        lbl.textColor = MyColors.gi.gray5
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    init()
    {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews()
    {
        self.addSubview(img)
        self.addSubview(lbl_title)
        self.addSubview(lbl_text)
        
        img.snp.makeConstraints(
            { make in
                
                make.width.centerX.equalToSuperview()
                make.height.equalToSuperview().multipliedBy(0.6)
                make.top.equalToSuperview()
        })
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.top.equalTo(img.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
        
        lbl_text.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title.snp.bottom).offset(16)
                make.left.equalToSuperview().offset(16)
                make.right.equalToSuperview().offset(-16)
        })
    }
    
    func bindSlideData(data:ModelSlideData)
    {
        self.lbl_title.text = data.title
        self.lbl_text.text = data.text
        self.img.image = data.image.getImage()
    }
    
}
