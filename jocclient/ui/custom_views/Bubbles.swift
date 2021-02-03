import UIKit
import SnapKit

class Bubble:BtnRipple
{
    let text:String
    let is_empty:Bool
    
    var is_active:Bool = false
    
    init(text:String,is_empty:Bool = false)
    {
        self.text = text
        self.is_empty = is_empty
        super.init()
        
        self.clipsToBounds = true
        self.backgroundColor = .clear
        self.setRippleColor(color: MyColors.gi.orange.withAlphaComponent(0.3))
        br_font.accept(MyFonts.gi.reg_m)
        br_text.accept(text)
        
        if is_empty
        {
            br_text_color.accept(MyColors.gi.gray4)
        }
        else
        {
            br_text_color.accept(MyColors.gi.orange)
        }
    }
    
    
    func setActive(_ is_active:Bool)
    {
        self.is_active = is_active
        if(is_active)
        {
            if(is_empty)
            {
                self.br_font.accept(MyFonts.gi.bold_m)
                self.br_text_color.accept(MyColors.gi.orange)
                self.backgroundColor = MyColors.gi.transparent
                self.layer.borderColor = MyColors.gi.orange.cgColor
                self.layer.borderWidth = 1
            }
            else
            {
                self.br_text_color.accept(MyColors.gi.white)
                self.backgroundColor = MyColors.gi.orange
            }
            //            self.addGradientView(grad_view: MyColors.gi.getOrangeGradient(horizontal: true))
        }
        else
        {
            if(is_empty)
            {
                self.br_font.accept(MyFonts.gi.reg_m)
                self.br_text_color.accept(MyColors.gi.gray4)
                self.backgroundColor = MyColors.gi.transparent
                self.layer.borderColor = MyColors.gi.orange.cgColor
                self.layer.borderWidth = 0
            }
            else
            {
                self.br_text_color.accept(MyColors.gi.gray4)
                self.backgroundColor = MyColors.gi.transparent
            }
            //            self.removeAllSublayers()
        }
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        super.layoutSubviews()
        let radius = min(self.frame.width, self.frame.height) / 2
        self.layer.cornerRadius = radius
    }
    
}

class ProductBubbles:UIView
{
    let lbl_title : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.reg_m
        lbl.textColor = MyColors.gi.gray5
        return lbl
    }()
    
    let lbl_price : UILabel =
    {
        let lbl = UILabel()
        lbl.font = MyFonts.gi.bold_s
        lbl.textColor = MyColors.gi.green
        return lbl
    }()
    
    let bubbles_view:BubblesView =
    {
        let bubbles_view = BubblesView()
        return bubbles_view
    }()
    
    let divider : UIView =
    {
        let view = UIView()
        view.backgroundColor = MyColors.gi.gray2
        return view
    }()
    
    init()
    {
        super.init(frame: .zero)
        
        self.addSubview(lbl_title)
        self.addSubview(lbl_price)
        self.addSubview(bubbles_view)
        self.addSubview(divider)
        
        lbl_title.snp.makeConstraints(
            { make in
                
                make.left.equalToSuperview().offset(12)
                make.top.equalToSuperview().offset(12)
        })
        
        lbl_price.snp.makeConstraints(
            { make in
                
                make.left.equalTo(lbl_title.snp.right).offset(12)
                make.bottom.equalTo(lbl_title)
        })
        
        bubbles_view.snp.makeConstraints(
            { make in
                
                make.top.equalTo(lbl_title.snp.bottom).offset(6)
                make.left.right.equalToSuperview()
                make.height.equalTo(36)
        })
        
        divider.snp.makeConstraints(
            { make in
                
                make.height.equalTo(1)
                make.right.left.equalToSuperview()
                make.bottom.equalTo(bubbles_view.snp.bottom).offset(16)
        })
        
        self.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(divider)
        })
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindBubbles(addables:[ModelAddableValue])
    {
        var bubbles:[Bubble] = []
        addables.forEach(
            { addable in
                
                let bubble = Bubble(text: addable.value ?? " - ", is_empty: true)
                bubbles.append(bubble)
        })
        
        bubbles_view.setBubblesInScroll(bubbles: bubbles)
        
        var need_to_reset_scroll = false
        bubbles.forEach(
            { bubble in
                
                bubble.myla()
                if(bubble.frame.width < 80)
                {
                    bubble.snp.makeConstraints(
                        { make in
                            
                            make.width.equalTo(80)
                    })
                    need_to_reset_scroll = true
                }
        })
        
        if(need_to_reset_scroll)
        {
            bubbles_view.scroll.resizeContentToFitHorizontal(offset: CGFloat(bubbles_view.bubbles_padding))
        }
    }
}
