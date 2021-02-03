import Foundation

class ViewProfile:BaseViewController
{
    var vm_profile:VmProfile!
    var factory_profile:FactoryProfile!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setBaseVmAction(base_vm: vm_profile)
        factory_profile = FactoryProfile(vc: self)
        
        setEvents()
        setListeners()
    }
    
    private func setListeners()
    {
        (factory_profile.view_auth.tf <-> vm_profile.br_tf_auth_text).disposed(by: dispose_bag)
        
        factory_profile.view_auth.check_box.valueChanged =
            { is_checked in
                
                self.vm_profile.br_offert_checked.accept(is_checked)
        }
        
        factory_profile.view_auth.btn_send.addAction {
            self.vm_profile.clickedAuthSendBtn()
        }
        
        factory_profile.view_auth.btn_i_agree.addAction {
            self.vm_profile.clickedOffertText()
        }
        
        factory_profile.btn_edit.addAction {
            self.vm_profile.clickedEditProfile()
        }
    }
    
    private func setEvents()
    {
        vm_profile.br_auth_mode
            .subscribe(onNext:
            { mode in
                
                self.factory_profile.view_auth.bindMode(mode: mode)
        })
        .disposed(by: dispose_bag)
        
        vm_profile.br_show_hide_auth
            .subscribe(onNext:
                { show_auth in
                    
                    if(show_auth)
                    {
                        self.factory_profile.view_auth.animateFadeOut()
                    }
                    else
                    {
                        self.factory_profile.view_auth.animateFadeIn()
                    }
            })
        .disposed(by: dispose_bag)
        
        vm_profile.br_user_to_display
            .subscribe(onNext:
                { user in
                    
                    self.bindUser(user: user)
            })
        .disposed(by: dispose_bag)
    }
    
    private func bindUser(user:ModelUser?)
    {
        factory_profile.lbl_user_name.text = user?.name
        factory_profile.lbl_phone.text = user?.phone
        
        if let count_cups = user?.count_cups
        {
            factory_profile.lbl_cups_count.text = String(count_cups)
        }
        else
        {
            factory_profile.lbl_cups_count.text = "-"
        }
        
        if let count_orders = user?.count_orders
        {
            factory_profile.lbl_orders_count.text = String(count_orders)
        }
        else
        {
            factory_profile.lbl_orders_count.text = "-"
        }
        
        if let reviews_count = user?.count_reviews
        {
            factory_profile.lbl_reviews_count.text = String(reviews_count)
        }
        else
        {
            factory_profile.lbl_reviews_count.text = "-"
        }
        
        if let avatar_url = user?.image?.url_m
        {
            factory_profile.img_avatar.img.loadImageMy(url_str: avatar_url)
        }
    }
}
