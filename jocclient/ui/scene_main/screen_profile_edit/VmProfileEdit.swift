import UIKit
import RxSwift
import RxCocoa

class VmProfileEdit:BaseVm
{
    var br_image_to_display:BehaviorRelay<ObjWithImage> = BehaviorRelay.init(value: MyImage.ic_bell.getImage())
    var br_name:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var br_phone:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    var br_email:BehaviorRelay<String?> = BehaviorRelay.init(value: nil)
    
    override init()
    {
        super.init()
        
        reloadUser()
    }
    
    func reloadUser()
    {
        base_netwoker.loadUser(action_success:
            { user in
                
                if let avater_url = user.image?.url_l
                {
                    let obj = ObjWithImageImpl.initFromUrl(url: avater_url)
                    self.br_image_to_display.accept(obj)
                }
                
                self.br_name.accept(user.name)
                self.br_phone.accept(user.phone)
                self.br_email.accept(user.email)
        })
    }
}

//MARK: - Listeners
extension VmProfileEdit
{
    func clickedBack()
    {
        ps_dissmiss_vc.onNext(true)
    }
    
    func clickedSave()
    {
        //TODO later add phone if needed
        let name = br_name.value
        let email = br_email.value
        let image = (br_image_to_display.value as? UIImage)?.toBase64()
        let push_token = LocalData.getPushToken()
        
        base_netwoker.updateUser(name: name, email: email, avatar: image, push_token: push_token, action_success:
            { user in
                
                BusMainEvents.gi.ps_user_updated.onNext(user)
                self.ps_dissmiss_vc.onNext(true)
        })
    }
    
    func clickedImage()
    {
        ImagesGetterManager.getGalleyCameraImage(action_success:
            { data in
                
                self.br_image_to_display.accept(data.image)
        })
    }
}
