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
