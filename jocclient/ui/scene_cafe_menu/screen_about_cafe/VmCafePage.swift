import Foundation
import RxSwift
import RxCocoa

class VmCafePage:BaseVm
{
    let vm_wrapper:VmWrapperCafeMenu
    let br_cafe:BehaviorRelay<ModelCafe?> = BehaviorRelay.init(value: nil)
    let br_route_info:BehaviorRelay<RouteInfoMy?> = BehaviorRelay.init(value: nil)
    let ps_route_text:PublishSubject<String> = PublishSubject.init()
    
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
                    
                    cafe?.reviews = cafe?.reviews?.sorted(by: { ($0.date ?? Date()) > ($1.date ?? Date()) })
                    self.br_cafe.accept(cafe)
                    
                    self.loadRoute()
            })
            .disposed(by: dispose_bag)
        
        br_route_info
            .subscribe(onNext:
                { route_info in
                    
                    guard let text = route_info?.getDistanceText() else { return }
                    self.ps_route_text.onNext(text)
            })
        .disposed(by: dispose_bag)
    }
    
    private func loadRoute()
    {
        guard let user_location = BusMainEvents.gi.br_current_location.value,
            let cafe_location = br_cafe.value?.getCafeLocation() else { return }
        
        RoutesManager.gi.getRouteInfo(start: user_location, finish: cafe_location, action_success:
            { route_info in
                
                self.br_route_info.accept(route_info)
        })
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
    
    func clickedRoute()
    {
        guard let route = br_route_info.value else { return }
        BusMainEvents.gi.ps_clikced_cafe_route.onNext(route)
        vm_wrapper.ps_dissmiss_vc.onNext(true)
    }
}
