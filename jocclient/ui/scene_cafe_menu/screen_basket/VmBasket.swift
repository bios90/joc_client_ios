import Foundation
import RxSwift
import RxCocoa

enum TypeBasketPageStatus
{
    case cafe_not_active
    case need_to_register
    case can_buy
}

class VmBasket:BaseVm
{
    let vm_wrapper:VmWrapperCafeMenu
    let br_bakset_items:BehaviorRelay<[ModelBasketItem]> = BehaviorRelay.init(value: [])
    let ps_clicked_edit_basket_item:PublishSubject<ModelBasketItem> = PublishSubject.init()
    let ps_clicked_regiter:PublishSubject<Void> = PublishSubject.init()
    let ps_clicked_order:PublishSubject<Void> = PublishSubject.init()
    let ps_clicked_quick_order:PublishSubject<Void> = PublishSubject.init()
    
    let br_page_status:BehaviorRelay<TypeBasketPageStatus> = BehaviorRelay.init(value: .can_buy)
    
    init(vm_wrapper_cafe_menu:VmWrapperCafeMenu)
    {
        self.vm_wrapper = vm_wrapper_cafe_menu
        super.init()
        
        setEvents()
    }
    
    private func setEvents()
    {
        BasketManager.gi.br_bakset_items
            .subscribe(onNext:
                { items in
                    
                    self.br_bakset_items.accept(items)
        })
        .disposed(by: dispose_bag)
        
        vm_wrapper.br_initial_cafe_loaded
            .subscribe(onNext:
                { cafe in
                    
                    self.setStatus()
            })
        .disposed(by: dispose_bag)
    }
    
    private func setStatus()
    {
        guard let cafe = vm_wrapper.br_initial_cafe_loaded.value else { return }
        
        self.br_page_status.accept(.can_buy)
        return
        
        if cafe.can_order != true
        {
            self.br_page_status.accept(.cafe_not_active)
        }
        else if LocalData.getCurrentUser() == nil
        {
            self.br_page_status.accept(.need_to_register)
        }
        else
        {
            self.br_page_status.accept(.can_buy)
        }
        
    }
}

//MARK: -Listeners
extension VmBasket
{
    func clickedItem(item:ModelBasketItem)
    {
        let btn_delete = BtnAction(text: MyStrings.delete.localized(), action:
        {_ in
            BasketManager.gi.removeItem(item: item)
        })
        
        let btn_edit = BtnAction(text: MyStrings.edit.localized(), action:
        { _ in
            
            self.ps_clicked_edit_basket_item.onNext(item)
        })
        
        MessagesManager.showBottomDefault(title: item.product.name, text: nil, btns: [btn_delete,btn_edit], vc: nil)
    }
    
    func clickedRegister()
    {
        ps_clicked_regiter.onNext(())
    }
    
    func clickedOrder()
    {
        ps_clicked_order.onNext(())
    }
    
    func clickedQuickOrder()
    {
        ps_clicked_quick_order.onNext(())
    }
}
