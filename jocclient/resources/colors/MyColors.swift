import UIKit

class MyColors
{
    static let gi = MyColors()
    
    let transparent = colorFromHex(hex: "#FFFFFF").withAlphaComponent(0)
    let white = colorFromHex(hex: "#FFFFFF")
    let black = colorFromHex(hex: "#000000")
    let gray0 = colorFromHex(hex: "#F9F9F9")
    let gray1 = colorFromHex(hex: "#F3F3F3")
    let gray2 = colorFromHex(hex: "#E9E9E9")
    let gray3 = colorFromHex(hex: "#D9D9D9")
    let gray4 = colorFromHex(hex: "#B9B9B9")
    let gray5 = colorFromHex(hex: "#8A8A8A")
    let gray6 = colorFromHex(hex: "#5A5A5A")
    let gray7 = colorFromHex(hex: "#383838")
    let gray8 = colorFromHex(hex: "#222222")
    
    let green = colorFromHex(hex: "#2AB398")
    let green_dark = colorFromHex(hex: "#11998E")
    let green_light = colorFromHex(hex: "#43CEA2")
    
    let red = colorFromHex(hex: "#F51C1C")
    let red_dark = colorFromHex(hex: "#DB0F0F")
    
    let orange = colorFromHex(hex:"#F94912")
    let orange_dark = colorFromHex(hex:"#F51C1C")
    let orange_light = colorFromHex(hex:"#FE8605")
    
    let gray_grad_dark = colorFromHex(hex:"#665B5B")
    let gray_grad_light = colorFromHex(hex:"#B3A9A9")
    
    let yellow_grad_dark = colorFromHex(hex:"#F7971E")
    let yellow_grad_light = colorFromHex(hex:"#FFD200")
    
    let biryza = colorFromHex(hex: "#255958")
    
    
    static func colorFromHex (hex:String) -> UIColor
    {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}

//MARK: - Gradients
extension MyColors
{
    
    
    
    func getGreenGradient(horizontal:Bool)->CAGradientLayer
    {
        return getGradient(color1: MyColors.gi.green_dark , color2: MyColors.gi.green_light, horizontal: horizontal)
    }
    
    func getOrangeGradient(horizontal:Bool)->CAGradientLayer
    {
        return getGradient(color1: MyColors.gi.orange_dark , color2: MyColors.gi.orange_light, horizontal: horizontal)
    }
    
    func getGradient(color1:UIColor,color2:UIColor, horizontal:Bool,points:([Double])? = nil)->CAGradientLayer
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.locations = [0, 1]
        if let points = points
        {
            gradientLayer.startPoint = CGPoint(x: points[0], y: points[1])
            gradientLayer.endPoint = CGPoint(x: points[2], y: points[3])
        }
        else if(horizontal)
        {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        }
        else
        {
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        }
        
        return gradientLayer
    }
}

class ViewForGradientBg:UIView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        self.fitLayers()
    }
}

extension CALayer
{
    func getParentView()->UIView?
    {
        if(self.superlayer?.delegate == nil)
        {
            return nil
        }
        else if(self.superlayer?.delegate is UIView)
        {
            return self.superlayer!.delegate as! UIView
        }
        else
        {
            let parent_layer = self.superlayer!.delegate as! CALayer
            return parent_layer.getParentView()
        }
    }
    
    func fitGradientSublayers(rect: CGRect)
    {
        frame = rect
        sublayers?.forEach(
            { sub_layer in
                
                if sub_layer is CAGradientLayer
                {
                    sub_layer.fitGradientSublayers(rect: rect)
                }
        })
    }
}
