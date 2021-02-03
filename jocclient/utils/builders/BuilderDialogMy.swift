import Foundation

class BuilderDialogMy
{
    var dialog_name:String!
    var title:String?
    var text:String?
    var btn_ok:BtnAction?
    var btn_cancel:BtnAction?
    var btn_left:BtnAction?
    var with_tf:Bool = false
    var with_tv:Bool = false
    var current_text:String?
    var dismiss_on_touch:Bool = false
    var is_in_scroll_mode:Bool = false
    var is_html_text:Bool = false
    
    func setDialogName(dialog_name:String)->BuilderDialogMy
    {
        self.dialog_name = dialog_name
        return self
    }
    
    func setTitle(title:String?)->BuilderDialogMy
    {
        self.title = title
        return self
    }
    
    func setText(text:String?)->BuilderDialogMy
    {
        self.text = text
        return self
    }
    
    func setBtnOk(btn:BtnAction)->BuilderDialogMy
    {
        self.btn_ok = btn
        return self
    }
    
    func setBtnCancel(btn:BtnAction)->BuilderDialogMy
    {
        self.btn_cancel = btn
        return self
    }
    
    func setBtnLeft(btn:BtnAction)->BuilderDialogMy
    {
        self.btn_left = btn
        return self
    }
    
    func setWithTf(with_tf:Bool)->BuilderDialogMy
    {
        self.with_tf = with_tf
        return self
    }
    
    func setWithTv(with_tv:Bool)->BuilderDialogMy
    {
        self.with_tv = with_tv
        return self
    }
    
    func setCurrentText(text:String?)->BuilderDialogMy
    {
        self.current_text = text
        return self
    }
    
    func setDismissOnTouch(dismiss_on_touch:Bool)->BuilderDialogMy
    {
        self.dismiss_on_touch = dismiss_on_touch
        return self
    }
    
    func setIsInScrollMode(is_in_scroll_mode:Bool)->BuilderDialogMy
    {
        self.is_in_scroll_mode = is_in_scroll_mode
        return self
    }
    
    func setIsHtml(is_html:Bool)->BuilderDialogMy
    {
        self.is_html_text = is_html
        return self
    }
    
    func build()
    {
        MessagesManager.showDialogMy(builder: self)
    }
}
