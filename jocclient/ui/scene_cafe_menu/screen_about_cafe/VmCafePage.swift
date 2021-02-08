import Foundation
import RxSwift
import RxCocoa

class VmCafePage:BaseVm
{
    let vm_wrapper:VmWrapperCafeMenu
    let br_cafe:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    
    init(vm_wrapper_cafe_menu:VmWrapperCafeMenu)
    {
        self.vm_wrapper = vm_wrapper_cafe_menu
        super.init()
        setEvents()
    }
    
    private func setEvents()
    {
        vm_wrapper.br_initial_cafe_loaded
            .subscribe(onNext:
                { cafe in
                    
                    self.br_cafe.accept(cafe)
            })
            .disposed(by: dispose_bag)
    }
}

extension VmCafePage
{
    func clickedArrowBack()
    {
        CoordinatorCafeMenu.ps_clicked_arrow_back.onNext(())
    }
    
    func clickedImage(image:ObjWithImage)
    {
        guard var images = self.br_cafe.value?.images else { return }
        
        var pos = images.firstIndex(where: { $0.url == image.url }) ?? 0
        if(pos < 0)
        {
            pos = 0
        }
        
        if let logo = br_cafe.value?.logo
        {
            images.insert(logo, at: 0)
            pos+=1
        }
        
        ps_show_image_scroll.onNext((images,pos))
    }
}
