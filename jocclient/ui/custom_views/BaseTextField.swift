import UIKit

class BaseTextField:UITextField
{
    init()
    {
        super.init(frame: .zero)
        self.font = MyFonts.gi.reg_m
        self.setLeftPaddingPoints(12)
        self.setRightPaddingPoints(12)
        self.tintColor = MyColors.gi.red
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
