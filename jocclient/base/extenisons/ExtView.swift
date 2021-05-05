import UIKit

extension UIView
{
    func disableChildClicks()
    {
        self.subviews.forEach(
            { view in
                
                view.isUserInteractionEnabled = false
        })
    }
    
    func myla()
    {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    func myLaRecursevly()
    {
        self.myla()
        self.subviews.forEach({ $0.myLaRecursevly() })
        self.myla()
    }
    
    func addShadowMin()
    {
        self.layer.shadowColor = MyColors.gi.gray5.withAlphaComponent(0.25).cgColor
//        self.layer.shadowColor = MyColors.gi.green.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 12
    }
    
    func addGradientView(grad_view:CAGradientLayer)
    {
        runActionWithDelay(milliseconds: 50, action:
            {
                grad_view.frame = self.bounds
                self.layer.insertSublayer(grad_view,at: 0)
        })
        
    }
    
    func animateFadeOut(duration: TimeInterval = 0.5)
    {
        UIView.animate(withDuration: duration, animations:
            {
                self.alpha = 1.0
        })
    }
    
    func animateFadeIn(duration: TimeInterval = 0.5)
    {
        UIView.animate(withDuration: duration, animations:
            {
                self.alpha = 0.0
        })
    }
    
    func removeAllSublayers()
    {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    func removeAllSubviews()
    {
        self.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func makeRoundCorners(corners: UIRectCorner, radius: CGFloat)
    {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func fitLayers()
    {
        layer.fitGradientSublayers(rect: frame)
    }
    
    func fitHeightToLastChild(offset:Int = 0)
    {
        guard let last_child = self.subviews.last else { return }
        self.snp.makeConstraints(
            { make in
                
                make.bottom.equalTo(last_child.snp.bottom).offset(offset)
        })
    }
}

extension UIBezierPath
{
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){
        
        self.init()
        
        let path = CGMutablePath()
        
        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)
        
        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
            path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }
        
        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }
        
        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }
        
        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }
        
        path.closeSubpath()
        cgPath = path
    }
}

extension UINavigationBar
{
    func removeBottomLine()
    {
        self.setBackgroundImage(UIImage(), for:.default)
        self.shadowImage = UIImage()
        self.layoutIfNeeded()
    }
}

extension UITabBar
{
    func removeLine()
    {
        if #available(iOS 13, *)
        {
            let appearance = self.standardAppearance
            appearance.configureWithOpaqueBackground()
            appearance.shadowImage = nil
            appearance.shadowColor = nil
            self.standardAppearance = appearance
        }
        else
        {
            self.shadowImage = UIImage()
            self.backgroundImage = UIImage()
        }
    }
}


