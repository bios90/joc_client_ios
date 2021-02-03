import UIKit

class CoordinatorMain:BaseCoordinator
{
    let vm_profile = VmProfile()
    let vm_map = VmMap()
    let vm_list = VmList()
    let vm_tab_wrapper = VmTabWrapper()
    
    override init(nav_controller: BaseNavController)
    {
        super.init(nav_controller: nav_controller)
        setEvents()
    }
    
    func startMain()
    {
        let vc_profile = ViewProfile()
        vc_profile.vm_profile = vm_profile
        let img_pair_profile = HelperImages.getImgPairForTabs(img: MyImage.ic_user.getImage())
        let tab_icon_profile = UITabBarItem(title: "",image: img_pair_profile.img_normal,selectedImage: img_pair_profile.img_selected)
        vc_profile.tabBarItem = tab_icon_profile
        
        let vc_map = ViewMap()
        vc_map.vm_map = vm_map
        let img_pair_map = HelperImages.getImgPairForTabs(img: MyImage.ic_globe.getImage())
        let tab_icon_map = UITabBarItem(title: "",image: img_pair_map.img_normal,selectedImage: img_pair_map.img_selected)
        vc_map.tabBarItem = tab_icon_map
        
        let vc_list = ViewList()
        vc_list.vm_list = vm_list
        let img_pair_list = HelperImages.getImgPairForTabs(img: MyImage.ic_location.getImage())
        let tab_icon_list = UITabBarItem(title: "",image: img_pair_list.img_normal,selectedImage: img_pair_list.img_selected)
        vc_list.tabBarItem = tab_icon_list
        
        let vc_wrapper = ViewTabWrapper()
        vc_wrapper.vm_tab_wrapper = vm_tab_wrapper
        vc_wrapper.viewControllers = [vc_profile,vc_map,vc_list]
        navigation_controller.clearAndPush(vc: vc_wrapper)
        
        
        vc_wrapper.tabBar.barTintColor = MyColors.gi.white
        let tab_bar = vc_wrapper.tabBar
        tab_bar.removeLine()
        tab_bar.addShadowMin()
        
        vc_wrapper.preloadAllControllers()
    }
    
    func startProfileEdit()
    {
        let vm_profile_edit = VmProfileEdit()
        let vc_profile_edit = ViewProfileEdit()
        vc_profile_edit.vm_profile_edit = vm_profile_edit
        vc_profile_edit.modalPresentationStyle = .overCurrentContext
        
        let vc = getTopViewController()
        vc.present(vc_profile_edit, animated: true, completion: nil)
    }
    
    func startFilter()
    {
        let vm_filter = VmFilter()
        let vc_filter = ViewFilter()
        vc_filter.vm_filter = vm_filter
        vc_filter.modalPresentationStyle = .overCurrentContext
        
        let vc = getTopViewController()
        vc.present(vc_filter, animated: true, completion: nil)
    }
    
    func toCafePage(cafe_id:Int)
    {
        let coordinator_cafe_menu = CoordinatorCafeMenu(nav_controller: self.navigation_controller)
        coordinator_cafe_menu.startMain(cafe_id: cafe_id)
    }
}


//MARK: - Set vms actions
extension CoordinatorMain
{
    private func setEvents()
    {
        vm_profile.ps_clicked_edit_profile
            .subscribe(onNext:
                {
                    self.startProfileEdit()
            })
            .disposed(by: dispose_bag)
        
        vm_tab_wrapper.ps_clicked_filter
            .subscribe(onNext:
                {
                    self.startFilter()
            })
            .disposed(by: dispose_bag)
        
        vm_map.ps_clicked_cafe
            .subscribe(onNext:
                { cafe_id in
                     
                    self.toCafePage(cafe_id: cafe_id)
            })
        .disposed(by: dispose_bag)
    }
}
