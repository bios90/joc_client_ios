import UIKit

@objc class ClosureSleeve: NSObject
{
    let closure: ()->()

    init (_ closure: @escaping ()->())
    {
        self.closure = closure
    }

    @objc func invoke ()
    {
        closure()
    }
}

extension UIControl
{
    struct Holder
    {
        static var sleeve:ClosureSleeve?
        static var key:String?
    }
    
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping ()->())
    {
        let sleeve = ClosureSleeve(closure)
        let key = "[\(arc4random())]"
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, key, sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        Holder.sleeve = sleeve
        Holder.key = key
    }
    
    func removeClickAction()
    {
        if let sleeve = Holder.sleeve
        {
            removeTarget(nil, action: #selector(ClosureSleeve.invoke), for: .allEvents)
        }
    }
    
    func remove_all_actions()
    {
        removeTarget(nil, action: nil, for: .allEvents)
    }
}

extension UIBarButtonItem
{
    func setColors(color_selected:UIColor,color_normal:UIColor)
    {
        self.setTitleTextAttributes([NSAttributedString.Key.font: color_normal], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.font: color_selected], for: .selected)
    }
}
