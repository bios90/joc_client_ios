import UIKit
import SwiftEntryKit
import RxSwift
import RxCocoa

class BtnAction
{
    let text:String
    let action:(AnyObject?)->Void
    let faw_text:String?
    
    init(text:String,action:@escaping (AnyObject?)->Void,faw_text:String? = nil)
    {
        self.text = text
        self.action = action
        self.faw_text = faw_text
    }
}

class MessagesManager
{
    static func disableScreenTouches()
    {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    static func enableScreenTouches()
    {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    static func showBottomDefault(title:String?,text:String?,btns:[BtnAction],vc:UIViewController?)
    {
        let alertController = UIAlertController(title: title, message: text, preferredStyle: .actionSheet)
        
        btns.forEach(
            { btn in
                
                let alert_action = UIAlertAction(title: btn.text,style: .default, handler:
                { _ in
                    alertController.dismiss(animated: true, completion: nil)
                    btn.action(nil)
                })
                alertController.addAction(alert_action)
        })
        
        let cancel_action = UIAlertAction(title: MyStrings.cancel.localized(), style: .cancel, handler: nil)
        alertController.addAction(cancel_action)
        
        var vcc = vc
        if(vcc == nil)
        {
            vcc = getTopViewController()
        }
        
        
        if let popoverController = alertController.popoverPresentationController
        {
            popoverController.sourceView = vcc!.view
            popoverController.sourceRect = CGRect(x: vcc!.view.bounds.midX, y: vcc!.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        vcc!.present(alertController, animated: true, completion: nil)
    }
}

//MARK: -Alerter
extension MessagesManager
{
    static func showNoInternet()
    {
        let text = MyStrings.no_internet_connection.localized()
        showRedAlerter(text: text)
    }
    
    static func showGreenAlerter(text:String)
    {
        showAlerter(text: text, bg_color: MyColors.gi.green)
    }
    
    static func showRedAlerter(text:String)
    {
        showAlerter(text: text, bg_color: MyColors.gi.red)
    }
    
    static func showAlerter(text:String, bg_color:UIColor)
    {
        var name = ""
        if bg_color == MyColors.gi.red
        {
            name = "RedAlert"
        }
        else if bg_color == MyColors.gi.green
        {
            name = "GreenAlert"
        }
        
        if(SwiftEntryKit.isCurrentlyDisplaying(entryNamed: name)){ return }
        
        let view = LaAlert(text: text, color: bg_color)
        view.lbl_text.layoutIfNeeded()
        view.lbl_text.sizeToFit()
        
        var attrs = MessagesManager.getAlerterAttributes()
        attrs.name = name
        view.snp.makeConstraints(
            { make in
                
                let size = view.getLaHeight()
                make.height.equalTo(size)
        })
        
        SwiftEntryKit.display(entry: view, using: attrs)
    }
    
    private static func getAlerterAttributes()-> EKAttributes
    {
        var attributes = EKAttributes()
        
        attributes.name = "Alreter"
        attributes.windowLevel = .normal
        attributes.position = .top
        attributes.displayDuration = 4
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.intrinsic
        attributes.entranceAnimation = .init(
            translate: .init(duration: 0.3),
            scale: .init(from: 1.07, to: 1, duration: 0.3)
        )
        attributes.exitAnimation = .init(translate: .init(duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        attributes.statusBar = .light
        //        attributes.entryBackground = .color(color: EKColor.init(bgColor))
        attributes.positionConstraints.verticalOffset = -getStatusBarHeight()
        
        return attributes
    }
}

//Dialogs
extension MessagesManager
{
    static func dismissDialogWithName(name:String)
    {
        SwiftEntryKit.dismiss(.specific(entryName: name))
    }
    
    public static func showDialogMy(builder:BuilderDialogMy)
    {
        if(SwiftEntryKit.isCurrentlyDisplaying(entryNamed: builder.dialog_name))
        {
            return
        }
        
        var attributes = MessagesManager.getDefDialogAttributes()
        attributes.name = builder.dialog_name
        
        let dailog = LaDialogUniversal(builder: builder)
        
        SwiftEntryKit.display(entry: dailog, using: attributes,presentInsideKeyWindow: true)
    }
    
    static func getDefDialogAttributes()->EKAttributes
    {
        var attributes = EKAttributes()
        
        attributes.windowLevel = .normal
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        attributes.entranceAnimation = .init(fade: .init(from: 0.0, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(fade: .init(from: 1, to: 0, duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        
        return attributes
    }
    
    static func showOffertDialog()
    {
        BuilderDialogMy().setDialogName(dialog_name: "Offert")
            .setText(text: MyStrings.getOffertText())
            .setIsHtml(is_html: true)
            .setBtnOk(btn: BtnAction(text: MyStrings.its_clear.localized(), action: { _ in }))
            .setIsInScrollMode(is_in_scroll_mode: true)
            .build()
    }
}


//MARK: -New Progress rx
extension MessagesManager
{
    static var show_timeout = 700
    static var last_time_shown:Int64?
    static var progress_disposable : Disposable?
    
    static func showProgressNewDelayed(forced:Bool = false)
    {
        if(!forced && (SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "Progress") || progress_disposable != nil))
        {
            return
        }
        
        progress_disposable = Observable<Int>
            .timer(.milliseconds(show_timeout), scheduler: MainScheduler.instance)
            .subscribe(onNext:
                { value in
                    
                    last_time_shown = Date().currentTimeMillis()
                    show_progress()
            },onError:
                { err in
                    
            })
    }
    
    static func show_progress()
    {
        if(SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "Progress"))
        {
            return
        }
        
        var attributes = EKAttributes()
        
        attributes.name = "Progress"
        attributes.windowLevel = .statusBar
        attributes.position = .center
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.scroll = .disabled
        
        let widthConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        let heightConstraint = EKAttributes.PositionConstraints.Edge.ratio(value: 1)
        attributes.entranceAnimation = .init(fade: .init(from: 0.0, to: 1, duration: 0.3))
        attributes.exitAnimation = .init(fade: .init(from: 1, to: 0, duration: 0.3))
        attributes.positionConstraints.size = .init(width: widthConstraint, height: heightConstraint)
        
        let view = LaProgress()
        SwiftEntryKit.display(entry: view, using: attributes)
    }
    
    static func dismissProgressNewDelayed()
    {
        let action =
        {
            SwiftEntryKit.dismiss(.specific(entryName: "Progress"))
            progress_disposable?.dispose()
            progress_disposable = nil
            last_time_shown = nil
        }
        
        
        guard let last_time_shown = last_time_shown else {
            
            action()
            return
            
        }
        
        let current_time = Date().currentTimeMillis()
        let difference = current_time - last_time_shown
        if(difference > show_timeout)
        {
            action()
        }
        else
        {
            let delay = Int64(show_timeout) - difference
            runActionWithDelay(milliseconds: Int(delay), action:
                {
                    action()
            })
        }
    }
    
    static func showCafeDialog(cafe:ModelCafe,action_clicked:@escaping (ModelCafe)->Void)
    {
        if(SwiftEntryKit.isCurrentlyDisplaying(entryNamed: "CafePopup"))
        {
            return
        }
        
        var attributes = getBottomPopupAttributes()
        attributes.name = "CafePopup"
        
        let view = LaCafePopup(cafe: cafe, action_clicked: action_clicked)
    
        
        SwiftEntryKit.display(entry: view, using: attributes)
    }
}

//MARK: - Dialog attributes
extension MessagesManager
{
    static func getBottomPopupAttributes()->EKAttributes
    {
        var attributes = EKAttributes()
        
        attributes.statusBar = .light
        attributes.position = .bottom
        attributes.windowLevel = .normal
        attributes.displayDuration = .infinity
        attributes.entryInteraction = .absorbTouches
        attributes.screenInteraction = .dismiss
        attributes.entranceAnimation = .init(translate: .init(duration: 0.7, spring: .init(damping: 0.7, initialVelocity: 0)), scale: .init(from: 0.7, to: 1, duration: 0.4, spring: .init(damping: 1, initialVelocity: 0)))
        attributes.scroll = .disabled
        attributes.hapticFeedbackType = .success
        
        attributes.screenBackground = .color(color: .init( MyColors.gi.black.withAlphaComponent(0.5)))
        attributes.positionConstraints.verticalOffset = -getBottomSafeInset()
//        attributes.screenBackground = .color(color: .init(.orange))
        
        return attributes
    }
}


