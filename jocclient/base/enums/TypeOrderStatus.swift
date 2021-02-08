import UIKit

enum TypeOrderStatus:String
{
    case new
    case wait
    case paid
    case process
    case ready
    case done
    case canceled
    
    func getGradientColor() -> [UIColor]
    {
        switch self
        {
        case .done:
            return [MyColors.gi.green_dark,MyColors.gi.green_light]
        case .canceled:
            return [MyColors.gi.gray_grad_dark,MyColors.gi.gray_grad_light]
        default:
            return [MyColors.gi.yellow_grad_dark,MyColors.gi.yellow_grad_light]
        }
    }
    
    func getGradientLayer() -> CAGradientLayer
    {
        let grad_colors = getGradientColor()
        return MyColors.gi.getGradient(color1: grad_colors[0], color2: grad_colors[1], horizontal: false,points: [0.0,1.0,1.0,0.0])
    }
}

extension TypeOrderStatus: Codable
{
    public init(from decoder: Decoder) throws
    {
        self = try TypeOrderStatus(rawValue: decoder.singleValueContainer().decode(RawValue.self))!
    }
}

