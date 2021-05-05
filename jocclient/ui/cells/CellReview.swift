import UIKit
import Cosmos

class CellReview:UITableViewCell
{
    static let reuse_id = "CellReview"
    static let circle_size = 64
    
    let view_root:UIView =
    {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let root_btn:BtnRipple =
    {
        let btn = BtnRipple()
        btn.br_text.accept("")
        btn.layer.cornerRadius = 4
        btn.clipsToBounds = true
        btn.backgroundColor = MyColors.gi.white
        btn.layer.backgroundColor = MyColors.gi.white.cgColor
        return btn
    }()
    
    let view_logo:ImgInRoundShadow =
    {
        let view = ImgInRoundShadow()
        return view
    }()
    
    let lbl_author:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_l
        lbl.textColor = MyColors.gi.gray7
        return lbl
    }()
    
    let lbl_date:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textColor = MyColors.gi.gray4
        return lbl
    }()
    
    let rating:CosmosView =
    {
        let cosmos = ViewsHelper.getRatingStars()
        cosmos.settings.starSize = 18
        return cosmos
    }()
    
    let lbl_text:UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_s
        lbl.textColor = MyColors.gi.gray5
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        layout_subviews_my()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func layout_subviews_my()
    {
        self.addShadowMin()
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.backgroundColor = .clear
        
        self.contentView.addSubview(view_root)
        view_root.addSubview(root_btn)
        
        root_btn.addSubview(view_logo)
        root_btn.addSubview(rating)
        root_btn.addSubview(lbl_author)
        root_btn.addSubview(lbl_date)
        root_btn.addSubview(lbl_text)
        
        view_root.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
                make.bottom.equalTo(root_btn.snp.bottom)
        })
        
        root_btn.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(10)
                make.left.equalToSuperview().offset(12)
                make.right.equalToSuperview().offset(-12)
                make.bottom.equalTo(lbl_text.snp.bottom).offset(10)
        })
        
        view_logo.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(10)
                make.centerY.equalToSuperview()
                make.width.height.equalTo(CellReview.circle_size)
        })
        
        rating.myla()
        let padding_left = (rating.frame.width + 12)+8
        
        rating.snp.makeConstraints(
            { make in
                
                make.right.equalToSuperview().offset(-12)
                make.top.equalToSuperview().offset(10)
        })
        
        lbl_author.snp.makeConstraints(
            { make in
                
                make.top.equalToSuperview().offset(10)
                make.left.equalTo(view_logo.snp.right).offset(8)
                make.right.equalToSuperview().offset(-padding_left)
        })
        
        lbl_date.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_logo.snp.right).offset(8)
                make.right.equalToSuperview().offset(-padding_left)
                make.top.equalTo(lbl_author.snp.bottom)
        })
        
        lbl_text.snp.makeConstraints(
            { make in
                
                make.left.equalTo(view_logo.snp.right).offset(8)
                make.right.equalToSuperview().offset(-12)
                make.top.equalTo(lbl_date.snp.bottom).offset(4)
        })
    }
    
    func bindReview(review:ModelReview)
    {
        if let url = review.user?.image?.url_m
        {
            view_logo.img.loadImageMy(url_str: url)
        }
        
        rating.rating = Double(review.rating ?? 0)
        lbl_author.text = review.user?.name
        lbl_date.text = review.date?.formatToString()
        lbl_text.text = review.text
    }
}
