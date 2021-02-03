import Foundation

class FactoryMap
{
    let vc:BaseViewController
    
    init(vc:BaseViewController)
    {
        self.vc = vc
        setupViews()
    }
    
    private func setupViews()
    {
        self.vc.view.backgroundColor = .cyan
    }
}
