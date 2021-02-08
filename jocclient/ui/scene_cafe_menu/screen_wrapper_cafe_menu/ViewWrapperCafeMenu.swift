import UIKit

class ViewWrapperCafeMenu:BaseTabBarController
{
    let vm_wrapper_cafe_menu:VmWrapperCafeMenu
    
    init(vm_wrapper_cafe_menu:VmWrapperCafeMenu)
    {
        self.vm_wrapper_cafe_menu = vm_wrapper_cafe_menu
        super.init(nibName: nil, bundle: nil)
        delegate = self
        setBaseVmAction(base_vm: vm_wrapper_cafe_menu)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setEvents()
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setEvents()
    {
        vm_wrapper_cafe_menu
        .br_badge_text
            .subscribe(onNext:
                { text in
                    
                    if let tab_item_basket = self.tabBar.items?.last
                    {
                        tab_item_basket.badgeValue = text
                    }
            })
        .disposed(by: dispose_bag)
        
    }
}

extension ViewWrapperCafeMenu:UITabBarControllerDelegate
{
    
}
