import UIKit

enum FontName:String
{
    case fa_solid = "FontAwesome5Pro-Solid"
    case fa_reg = "FontAwesome5Pro-Regular"
    case fa_light = "FontAwesome5Pro-Light"
    case fa_brands = "FontAwesome5Brands-Regular"
    case exo_bold = "Exo2-Bold"
    case exo_reg = "Exo2-Medium"
    case exo_light = "Exo2-ExtraLight"
}

enum FontSize:CGFloat
{
    case xxxs = 9
    case xxs = 10
    case xs = 12
    case s = 14
    case m = 16
    case l = 20
    case xl = 23
    case xxl = 25
}

class MyFonts
{
    static let gi = MyFonts()
    
    let reg_xxxs = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.xxxs.rawValue)!
    let reg_xxs = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.xxs.rawValue)!
    let reg_xs = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.xs.rawValue)!
    let reg_s = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.s.rawValue)!
    let reg_m = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.m.rawValue)!
    let reg_l = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.l.rawValue)!
    let reg_xl = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.xl.rawValue)!
    let reg_xxl = UIFont(name: FontName.exo_reg.rawValue, size: FontSize.xxl.rawValue)!
    
    let bold_xxxs = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.xxxs.rawValue)!
    let bold_xxs = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.xxs.rawValue)!
    let bold_xs = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.xs.rawValue)!
    let bold_s = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.s.rawValue)!
    let bold_m = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.m.rawValue)!
    let bold_l = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.l.rawValue)!
    let bold_xl = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.xl.rawValue)!
    let bold_xxl = UIFont(name: FontName.exo_bold.rawValue, size: FontSize.xxl.rawValue)!
    
    let light_xxxs = UIFont(name: FontName.exo_light.rawValue, size: FontSize.xxxs.rawValue)!
    let light_xxs = UIFont(name: FontName.exo_light.rawValue, size: FontSize.xxs.rawValue)!
    let light_xs = UIFont(name: FontName.exo_light.rawValue, size: FontSize.xs.rawValue)!
    let light_s = UIFont(name: FontName.exo_light.rawValue, size: FontSize.s.rawValue)!
    let light_m = UIFont(name: FontName.exo_light.rawValue, size: FontSize.m.rawValue)!
    let light_l = UIFont(name: FontName.exo_light.rawValue, size: FontSize.l.rawValue)!
    let light_xl = UIFont(name: FontName.exo_light.rawValue, size: FontSize.xl.rawValue)!
    let light_xxl = UIFont(name: FontName.exo_light.rawValue, size: FontSize.xxl.rawValue)!
    
    
    let faw_light_xxxs = UIFont(name: FontName.fa_light.rawValue, size: FontSize.xxxs.rawValue)!
    let faw_light_xxs = UIFont(name: FontName.fa_light.rawValue, size: FontSize.xxs.rawValue)!
    let faw_light_xs = UIFont(name: FontName.fa_light.rawValue, size: FontSize.xs.rawValue)!
    let faw_light_s = UIFont(name: FontName.fa_light.rawValue, size: FontSize.s.rawValue)!
    let faw_light_m = UIFont(name: FontName.fa_light.rawValue, size: FontSize.m.rawValue)!
    let faw_light_l = UIFont(name: FontName.fa_light.rawValue, size: FontSize.l.rawValue)!
    let faw_light_xl = UIFont(name: FontName.fa_light.rawValue, size: FontSize.xl.rawValue)!
    let faw_light_xxl = UIFont(name: FontName.fa_light.rawValue, size: FontSize.xxl.rawValue)!
    
    let faw_solid_xxxs = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.xxxs.rawValue)!
    let faw_solid_xxs = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.xxs.rawValue)!
    let faw_solid_xs = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.xs.rawValue)!
    let faw_solid_s = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.s.rawValue)!
    let faw_solid_m = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.m.rawValue)!
    let faw_solid_l = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.l.rawValue)!
    let faw_solid_xl = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.xl.rawValue)!
    let faw_solid_xxl = UIFont(name: FontName.fa_solid.rawValue, size: FontSize.xxl.rawValue)!
}
