import Foundation

class ViewProfileEdit:BaseViewController
{
    var vm_profile_edit:VmProfileEdit!
    var factory_profile_edit:FactoryProfileEdit!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        factory_profile_edit = FactoryProfileEdit(vc: self)
        setBaseVmAction(base_vm: vm_profile_edit)
        
        setEvents()
        setListeners()
    }
    
    private func setEvents()
    {
        vm_profile_edit.br_image_to_display
        .subscribe(onNext: { obj in
                
            self.factory_profile_edit.img_avatar.loadImageObj(obj: obj)
        })
        .disposed(by: dispose_bag)
        
        (factory_profile_edit.tf_name <-> vm_profile_edit.br_name).disposed(by: dispose_bag)
        (factory_profile_edit.tf_phone <-> vm_profile_edit.br_phone).disposed(by: dispose_bag)
        (factory_profile_edit.tf_email <-> vm_profile_edit.br_email).disposed(by: dispose_bag)
    }
    
    private func setListeners()
    {
        factory_profile_edit.btn_back.addAction {
            self.vm_profile_edit.clickedBack()
        }
        
        factory_profile_edit.btn_save.addAction {
            self.vm_profile_edit.clickedSave()
        }
        
        factory_profile_edit.btn_avatar.addAction {
            self.vm_profile_edit.clickedImage()
        }
    }
}
