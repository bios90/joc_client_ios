import Foundation
import RxSwift
import RxCocoa

class VmList:BaseVm
{
    let br_cafes:BehaviorRelay<[ModelCafe]> = BehaviorRelay.init(value: [])
    let ps_to_reload_cafes:PublishSubject<ReqCafesList> = PublishSubject.init()
    let ps_clicked_cafe:PublishSubject<Int> = PublishSubject.init()
    
    override init()
    {
        super.init()
        setEvents()

    }
    
    private func setEvents()
    {
        BusMainEvents.gi.br_current_location
            .subscribe(onNext:
                { _ in
                    
                    self.reloadCafes()
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.br_current_filter_data
            .subscribe(onNext:
                { _ in
                    
                    self.reloadCafes()
            })
            .disposed(by: dispose_bag)
        
        ps_to_reload_cafes
            .throttle(.milliseconds(1000), latest: true, scheduler: MainScheduler.instance)
            .subscribe(onNext:
                { req in
                    
                    self.base_netwoker.getCafes(req: req)
            })
            .disposed(by: dispose_bag)
    }
    
    private func reloadCafes()
    {
        guard let location = BusMainEvents.gi.br_current_location.value else { return }
        let radius = 1
        let filter_data = BusMainEvents.gi.br_current_filter_data.value
        
        let req = ReqCafesList(lat: location.latitude, lon: location.longitude, distance: radius, filter: filter_data, order: .Distance, sort: .Asc, action_success:
        { cafes in
            
            print("Cafes reloaded")
            cafes.countDistanceToLocation(user_lat: location.latitude, user_lon: location.longitude)
            self.br_cafes.accept(cafes)
        })
        
        ps_to_reload_cafes.onNext(req)
    }
}


//MARK: -Listeners
extension VmList
{
    func clickedCafe(cafe:ModelCafe)
    {
        guard let cafe_id = cafe.id else { return }
        self.ps_clicked_cafe.onNext(cafe_id)
    }
}
