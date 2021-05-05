import Foundation
import MaterialComponents.MDCRippleView

class BtnRipple:BaseBtn
{
    var rippleView:MDCRippleView!
    
    override var backgroundColor: UIColor?
        {
        willSet
        {
            if(newValue == nil || newValue == .clear)
            {
                rippleView.rippleColor = MyColors.gi.gray2.withAlphaComponent(0.5)
            }else
            {
                rippleView.rippleColor = newValue!.darker(by: 10)!.withAlphaComponent(0.4)
            }
        }
    }
    
    init()
    {
        super.init(frame: CGRect.zero)
        
        rippleView = MDCRippleView()
        rippleView.rippleColor = MyColors.gi.orange.withAlphaComponent(0.5)
        self.addSubview(rippleView)
        rippleView.layer.zPosition = 100
        
        self.addTarget(self, action: #selector(touchDown), for: .touchDown)
        self.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchUpOutside), for: .touchUpOutside)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func touchDown(sender:UIButton, event:UIEvent)
    {
        let touches = event.touches(for: self)
        let touch = touches?.first
        let touchPoint = touch?.location(in: self)
        
        rippleView.beginRippleTouchDown(at: CGPoint(x: touchPoint!.x, y: touchPoint!.y), animated: true, completion: nil)
    }
    
    @objc func touchUpOutside()
    {
        rippleView.beginRippleTouchUp(animated: true, completion: nil)
    }
    
    
    @objc func touchUpInside()
    {
        rippleView.beginRippleTouchUp(animated: true, completion: nil)
    }
    
    func setRippleColor(color:UIColor)
    {
        rippleView.rippleColor = color
    }
    
    func removeRipple()
    {
        rippleView.removeFromSuperview()
    }
    
    func setRippleCornerRadius(radius:CGFloat)
    {
        rippleView.layer.cornerRadius = radius
    }
}

extension BtnRipple
{
    static func getSocialBtn(str:FawString,action:@escaping ()->Void)->BtnRipple
    {
        let btn = BtnRipple()
        btn.backgroundColor = MyColors.gi.white
        btn.setRippleColor(color: MyColors.gi.gray1)
        btn.br_font.accept(MyFonts.gi.faw_brands_s)
        btn.br_text.accept(str.rawValue)
        btn.br_text_color.accept(MyColors.gi.orange_dark)
        btn.snp.makeConstraints(
            { make in
                
                make.width.height.equalTo(FactoryCafePage.social_icon_size)
        })
        btn.layer.cornerRadius = CGFloat(FactoryCafePage.social_icon_size/2)
        btn.setRippleCornerRadius(radius: CGFloat(FactoryCafePage.social_icon_size/2))
        btn.setEdgeInsets(left: 0, top: 0, right: 0, bottom: 0)
        btn.addAction(action)
        return btn
    }
}
