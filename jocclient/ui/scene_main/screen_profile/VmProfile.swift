import Foundation
import RxSwift
import RxCocoa

enum TypeAuthMode
{
    case Phone
    case Code
}

class VmProfile:BaseVm
{
    let br_tf_auth_text:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    let br_auth_mode:BehaviorRelay<TypeAuthMode> = BehaviorRelay.init(value: .Phone)
    let br_offert_checked:BehaviorRelay<Bool> = BehaviorRelay.init(value: false)
    let br_reviews:BehaviorRelay<[ModelOrder]> = BehaviorRelay.init(value: [])
    let ps_clicked_repeat_order:PublishSubject<ModelOrder> = PublishSubject.init()
    
    var br_show_hide_auth:BehaviorRelay<Bool>!
    var br_user_to_display:BehaviorRelay<ModelUser?> = BehaviorRelay.init(value: nil)
    var last_entered_phone:String? = nil
    
    //Navigation events
    var ps_clicked_edit_profile:PublishSubject<Void> = PublishSubject.init()

    override init()
    {
        super.init()
        br_show_hide_auth = BehaviorRelay.init(value: LocalData.getCurrentUser() == nil)
        
        setEvents()
        checkForLogin()
        
        reloadOrders()
    }
    
    private func setEvents()
    {
        BusMainEvents.gi.ps_user_logged
            .subscribe(onNext:
                {
                    self.reloadUser()
            })
        .disposed(by: dispose_bag)
        
        BusMainEvents.gi.ps_user_updated
            .subscribe(onNext:
                { user in
                 
                    self.reloadUser()
            })
        .disposed(by: dispose_bag)
        
        BusMainEvents.gi.ps_order_created
            .subscribe(onNext:
                { order_id in
                    
                    BusMainEvents.gi.ps_scroll_to_tab.onNext(.profile)
                    self.reloadOrders()
                    self.reloadUser()
            })
        .disposed(by: dispose_bag)
    }
    
    
    private func checkForLogin()
    {
        let user = LocalData.getCurrentUser()
        self.br_show_hide_auth.accept(user == nil)
        
        reloadUser()
    }
    
    private func reloadUser()
    {
        if LocalData.getCurrentUser()?.api_token == nil
        {
            br_user_to_display.accept(nil)
        }
        else
        {
            base_netwoker.loadUser(action_success:
                { user in
                    
                    print("successl loadded user")
                    self.br_user_to_display.accept(user)
            })
        }
    }
    
    private func reloadOrders()
    {
        print("Reloading orders!!!")
        
        base_netwoker.getUserOrders(offset: 0, limit: 300, action_success:
            { orders in
                
                self.br_reviews.accept(orders)
        }, action_error:
            { error in
          
                print("Error on getting orders")
        })
    }
}

//MARK: -Listeners
extension VmProfile
{
    func clickedAuthSendBtn()
    {
        let offert_checked = br_offert_checked.value
        
        if offert_checked == false
        {
            MessagesManager.showRedAlerter(text: MyStrings.please_confirm_offert.localized())
            return
        }
        
        let tf_text = br_tf_auth_text.value
        let mode = br_auth_mode.value
        
        guard let text = tf_text else
        {
            let message :String
            
            switch mode
            {
                
            case .Phone:
                message = ValidationManager.getPleaseFillStr(field: "Телефон")
            case .Code:
                message = ValidationManager.getPleaseFillStr(field: "Код")
            }
            
            MessagesManager.showRedAlerter(text: message)
            return
        }
        
        switch mode
        {
            
        case .Phone:
            base_netwoker.makeRegister(phone: text, push_token: nil, action_success:
                {
                    self.last_entered_phone = text
                    self.br_auth_mode.accept(.Code)
            })
        case .Code:
            guard let phone = last_entered_phone else { return }
            base_netwoker.makeCodeConfirm(phone: phone, code: text, action_success:
                { user in
                    
                    LocalData.saveCurrentUser(user: user)
                    BusMainEvents.gi.ps_user_logged.onNext(())
            })
            break
        }
    }
    
    func clickedOffertText()
    {
        MessagesManager.showOffertDialog()
    }
    
    func clickedEditProfile()
    {
        ps_clicked_edit_profile.onNext(())
    }
    
    func swipedToRefreshOrders()
    {
        reloadOrders()
    }
    
    func clickedOrder(order:ModelOrder)
    {
        let btn_repeat = BtnAction(text: MyStrings.repeat_word.localized(), action:
        {_ in
            self.clickedOrderRepeat(order: order)
        })
        
        let btn_cancel = BtnAction(text: MyStrings.make_cancel.localized(), action:
        {_ in
            self.clickedOrderCancel(order: order)
        })
        let btn_review = BtnAction(text: MyStrings.review.localized(), action:
        {_ in
            self.clickedOrderReview(order: order)
        })
        
        var btns:[BtnAction] = []
        
        //Todo later make for real
        btns.append(btn_review)
        btns.append(btn_repeat)
        btns.append(btn_cancel)
        
        MessagesManager.showBottomDefault(title: nil, text: nil, btns: btns, vc: nil)
    }
    
    func clickedOrderRepeat(order:ModelOrder)
    {
        self.ps_clicked_repeat_order.onNext(order)
    }
    
    func clickedOrderCancel(order:ModelOrder)
    {
        
    }
    
    func clickedOrderReview(order:ModelOrder)
    {
        
    }
}
