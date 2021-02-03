import Foundation

class FactoryCateg
{
    let vc:BaseViewController!
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        self.setupViews()
    }
    
    func setupViews()
    {
        self.vc.view.backgroundColor = MyColors.gi.red
    }
}
