import Foundation
import RxSwift
import RxCocoa
import CoreLocation

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
            .take(2)
            .subscribe(onNext:
                { _ in
                    
                    self.reloadCafes()
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.br_current_map_location
            .subscribe(onNext:
                { data in
                    
                    if data != nil
                    {
                        self.reloadCafes()
                    }
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
                    
                    print("Will reload cafes in distance to reload is \(req.distance)")
                    print("Will reload cafes in vm_list")
                    self.base_netwoker.getCafes(req: req)
            })
            .disposed(by: dispose_bag)
    }
    
    private func getLocationForReload()->CLLocationCoordinate2D
    {
        let location:CLLocationCoordinate2D
        if let map_location = BusMainEvents.gi.br_current_map_location.value
        {
            location = CLLocationCoordinate2D.init(latitude: map_location.0, longitude: map_location.1)
        }
        else if let user_location = BusMainEvents.gi.br_current_location.value
        {
            location = CLLocationCoordinate2D.init(latitude: user_location.latitude, longitude: user_location.longitude)
        }
        else
        {
            location = CLLocationCoordinate2D.init(latitude: 55.751244, longitude: 37.618423)
        }
        
        return location
    }
    
    private func reloadCafes()
    {
        print("Will reload cafeees 111")
        let location = getLocationForReload()
        
        let radius = 20
        let filter_data = BusMainEvents.gi.br_current_filter_data.value
        
        let req = ReqCafesList(lat: location.latitude, lon: location.longitude, distance: radius, filter: filter_data, order: .Distance, sort: .Asc, action_success:
        { cafes in
            
            print("Will reload cafeees 222 count is \(cafes.count) ")
            
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
