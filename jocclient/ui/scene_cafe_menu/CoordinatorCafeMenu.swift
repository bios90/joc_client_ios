import UIKit
import RxSwift
import RxCocoa

class CoordinatorCafeMenu:BaseCoordinator
{
    static let ps_clicked_arrow_back:PublishSubject<Void> = PublishSubject.init()
    
    let vm_cafe_page:VmCafePage
    let vm_categ_hot:VmCateg!
    let vm_categ_cold:VmCateg!
    let vm_categ_snacks:VmCateg!
    let vm_basket:VmBasket!
    
    let vm_wrapper_cafe_menu = VmWrapperCafeMenu()
    let vc_wrapper_cafe_menu:ViewWrapperCafeMenu
    
    override init(nav_controller: BaseNavController)
    {
        vc_wrapper_cafe_menu = ViewWrapperCafeMenu(vm_wrapper_cafe_menu: vm_wrapper_cafe_menu)
        
        vm_cafe_page = VmCafePage(vm_wrapper_cafe_menu:vm_wrapper_cafe_menu)
        vm_categ_hot = VmCateg(vm_wrapper_cafe_menu:vm_wrapper_cafe_menu)
        vm_categ_cold = VmCateg(vm_wrapper_cafe_menu:vm_wrapper_cafe_menu)
        vm_categ_snacks = VmCateg(vm_wrapper_cafe_menu:vm_wrapper_cafe_menu)
        vm_basket = VmBasket(vm_wrapper_cafe_menu:vm_wrapper_cafe_menu)
        super.init(nav_controller: nav_controller)
        setEvents()
    }
    
    func startMain(cafe_id:Int,order_id:Int?)
    {
        vc_wrapper_cafe_menu.tabBar.barTintColor = MyColors.gi.white
        let tab_bar = vc_wrapper_cafe_menu.tabBar
        //        tab_bar.removeLine()
        tab_bar.addShadowMin()
        tab_bar.barTintColor = MyColors.gi.white
        
        navigation_controller.pushViewController(vc_wrapper_cafe_menu, animated: true)
        
        vm_wrapper_cafe_menu.br_cafe_id.accept(cafe_id)
        
        if let order_id = order_id
        {
            vm_wrapper_cafe_menu.br_order_id_to_repeat.accept(order_id)
        }
    }
    
    private func setEvents()
    {
        CoordinatorCafeMenu.ps_clicked_arrow_back
            .subscribe(onNext:
                {
                    BusMainEvents.gi.ps_finish_vm_of_type.onNext([VmOrderDialog.self, VmWrapperCafeMenu.self])
            })
            .disposed(by: dispose_bag)
        
        vm_wrapper_cafe_menu.br_initial_cafe_loaded
            .subscribe(onNext:
                { cafe in
                    guard let cafe = cafe else { return }
                    self.setViewsForTabs(cafe: cafe)
            })
            .disposed(by: dispose_bag)
        
        vm_categ_hot.ps_clicked_product.subscribe(onNext:
            { product in
                
                self.toProductShow(product: product)
        })
            .disposed(by: dispose_bag)
        
        vm_categ_cold.ps_clicked_product.subscribe(onNext:
            { product in
                
                self.toProductShow(product: product)
        })
            .disposed(by: dispose_bag)
        
        vm_categ_snacks.ps_clicked_product.subscribe(onNext:
            { product in
                
                self.toProductShow(product: product)
        })
            .disposed(by: dispose_bag)
        
        vm_basket.ps_clicked_edit_basket_item
            .subscribe(onNext:
                { item in
                    
                    self.toProductShow(product: item.product, basket_item: item)
            })
            .disposed(by: dispose_bag)
        
        vm_basket.ps_clicked_regiter
            .subscribe(onNext:
                {
                    BusMainEvents.gi.ps_scroll_to_tab.onNext(.profile)
                    self.vc_wrapper_cafe_menu.removeOrDismiss()
            })
            .disposed(by: dispose_bag)
        
        vm_basket.ps_clicked_order
            .subscribe(onNext:
                {
                    self.toOrderDialog()
            })
            .disposed(by: dispose_bag)
    }
    
    private func setViewsForTabs(cafe:ModelCafe)
    {
        var controllers:[UIViewController] = []
        
        let vc_cafe_page = ViewCafePage()
        vc_cafe_page.vm_cafe_page = vm_cafe_page
        vc_cafe_page.tabBarItem = getBottomIcon(img: MyImage.ic_info_circle.getImage(), title: "")
        controllers.append(vc_cafe_page)
        
        if let hot = cafe.menu?.hot_drinks, hot.count > 0
        {
            vm_categ_hot.br_products.accept(hot)
            let vc_hot = ViewCateg()
            vc_hot.vm_categ = vm_categ_hot
            vc_hot.tabBarItem = getBottomIcon(img: MyImage.ic_cup_hot.getImage(), title: "")
            controllers.append(vc_hot)
        }
        
        if let cold = cafe.menu?.cold_drinks, cold.count > 0
        {
            vm_categ_cold.br_products.accept(cold)
            let vc_cold = ViewCateg()
            vc_cold.vm_categ = vm_categ_cold
            vc_cold.tabBarItem = getBottomIcon(img: MyImage.ic_cup_to_go.getImage(), title: "")
            controllers.append(vc_cold)
        }
        
        if let snacks = cafe.menu?.snacks, snacks.count > 0
        {
            vm_categ_snacks.br_products.accept(snacks)
            let vc_snacks = ViewCateg()
            vc_snacks.vm_categ = vm_categ_snacks
            vc_snacks.tabBarItem = getBottomIcon(img: MyImage.ic_cookies.getImage(), title: "")
            controllers.append(vc_snacks)
        }
        
        if cafe.can_order == true
        {
            let vc_basket = ViewBasket()
            vc_basket.vm_basket = vm_basket
            vc_basket.tabBarItem = getBottomIcon(img: MyImage.ic_bag.getImage(), title: "")
            
            controllers.append(vc_basket)
        }
        
        
        vc_wrapper_cafe_menu.viewControllers = controllers
        vc_wrapper_cafe_menu.preloadAllControllers()
    }
}

//MARK: -Navigation
extension CoordinatorCafeMenu
{
    func toProductShow(product:ModelProduct,basket_item:ModelBasketItem? = nil)
    {
        let view_product_settings = ViewProductSettings()
        let vm_product_settings = VmProductSettings(product: product)
        view_product_settings.vm_product_settings = vm_product_settings
        view_product_settings.modalPresentationStyle = .pageSheet
        
        let can_order = vm_cafe_page.br_cafe.value?.can_order == true
        vm_product_settings.br_can_order.accept(can_order)
        
        if let basket_item = basket_item
        {
            vm_product_settings.br_basket_item.accept(basket_item)
            vm_product_settings.br_is_edit_mode.accept(true)
        }
        
        getTopViewController().present(view_product_settings, animated: true)
    }
    
    func toOrderDialog()
    {
        let vc_order = ViewOrderDialog()
        let vm_order_dialog = VmOrderDialog()
        
        vc_order.vm_order_dialog = vm_order_dialog
        getTopViewController().present(vc_order, animated: true)
    }
}
