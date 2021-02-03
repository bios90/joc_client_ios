import UIKit

extension UIScrollView
{
    func resizeContentToFit(offset:CGFloat = 0)
    {
        self.myla()
        
        self.subviews.forEach(
            { view in
                view.myla()
        })
        
        var max_y:CGFloat = 0
        self.subviews.forEach(
            { view in
                view.layoutIfNeeded()
                
                if(view.frame.maxY > max_y)
                {
                    max_y = view.frame.maxY
                }
        })
        
        let content_size = CGSize(width: self.frame.width, height: max_y+offset)
        self.contentSize = content_size
        print("Final content height is \(content_size.height)")
        self.myla()
    }
    
    func resizeContentToFitHorizontal(offset:CGFloat = 0)
    {
        self.myla()
        
        self.subviews.forEach(
            { view in
                view.myla()
        })
        
        var max_x:CGFloat = 0
        self.subviews.forEach(
            { view in
                view.layoutIfNeeded()
                
                if(view.frame.maxX > max_x)
                {
                    max_x = view.frame.maxX
                }
        })
        
        let content_size = CGSize(width: max_x+offset, height: self.frame.height)
        self.contentSize = content_size
        self.myla()
    }
}
