import UIKit

class CellTabView:UICollectionViewCell
{
    static let reuse_id = "CellTabView"
    
    init(view:UIView)
    {
        super.init(frame: CGRect.zero)
        setView(view: view)
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setView(view:UIView)
    {
        self.contentView.removeAllSubviews()
        self.contentView.addSubview(view)
        view.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
    }
}
