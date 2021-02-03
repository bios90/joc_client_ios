import UIKit
import SnapKit

class BubblesView : UIView
{
    var scroll:UIScrollView =
    {
        let scroll = ViewsHelper.getDefScroll()
        return scroll
    }()
    
    var bubbles_padding = 10
    var bubbles:[Bubble] = []
    
    var multi_selectable:Bool = false
    var can_zero_select:Bool = false
    
    private var selected:[Int] = []
    var my_listener:(([Int]) -> Void)?
    
    func setBubblesInScroll(bubbles:[Bubble])
    {
        self.bubbles = bubbles
        self.myla()
        
        scroll.removeFromSuperview()
        scroll.removeAllSubviews()
        
        self.addSubview(scroll)
        scroll.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        var previous_anchor = scroll.snp.left
        
        for i in 0..<bubbles.count
        {
            let bubble = bubbles[i]
            scroll.addSubview(bubble)
            
            setClicks(pos: i, bubble: bubble)
            
            bubble.layer.cornerRadius = self.frame.height / 2
            bubble.snp.makeConstraints(
                { make in
                    
                    make.height.top.equalToSuperview()
                    make.left.equalTo(previous_anchor).offset(bubbles_padding)
            })
            
            previous_anchor = bubble.snp.right
        }
        
        scroll.resizeContentToFitHorizontal(offset: CGFloat(bubbles_padding))
    }
    
    func setBubbles(bubbles:[Bubble])
    {
        self.bubbles = bubbles
        self.myla()
        let padding_minus = (bubbles.count - 1) * bubbles_padding
        let each_width = (self.frame.size.width - CGFloat(padding_minus)) / CGFloat(bubbles.count)
        
        self.removeAllSubviews()
        var previous_anchor : ConstraintRelatableTarget? = nil
        
        for i in 0..<bubbles.count
        {
            let bubble = bubbles[i]
            self.addSubview(bubble)
            
            setClicks(pos: i, bubble: bubble)
            
            bubble.layer.cornerRadius = self.frame.height / 2
            bubble.snp.makeConstraints(
                { make in
                    
                    make.height.top.equalToSuperview()
                    make.width.equalTo(each_width)
                    
                    if(previous_anchor == nil)
                    {
                        make.left.equalToSuperview()
                    }
                    else
                    {
                        make.left.equalTo(previous_anchor!).offset(bubbles_padding)
                    }
            })
            
            previous_anchor = bubble.snp.right
        }
    }
    
    private func setClicks(pos:Int,bubble:Bubble)
    {
        bubble.addAction {
            
            let is_selected = self.selected.firstIndex(of: pos) != nil
            if(is_selected)
            {
                print("Hereee2222")
                if(self.multi_selectable || self.can_zero_select)
                {
                    print("Will remove pos \(pos)")
                    self.selected.remove(object: pos)
                }
            }
            else
            {
                if( !self.multi_selectable)
                {
                    self.selected.removeAll()
                }
                
                self.selected.append(pos)
            }
            
            self.resetBubblesColors()
            self.notifyListeners()
        }
    }
    
    private func notifyListeners()
    {
        guard let listener = my_listener else { return }
        listener(selected)
    }
    
    private func resetBubblesColors()
    {        
        for i in 0..<bubbles.count
        {
            let bubble = bubbles[i]
            let need_to_select = selected.firstIndex(of: i) != nil
            bubble.setActive(need_to_select)
        }
    }
    
    func setSelected(selected:[Int])
    {
        self.selected = selected
        resetBubblesColors()
    }
    
    func getSelected()->[Int]
    {
        return selected
    }
    
    func getSelected()->Int?
    {
        if multi_selectable
        {
            fatalError("*** Should be called only for single select ***")
        }
        
        return selected[safe:0]
    }
}
