import Foundation
import RxSwift
import RxCocoa
import GoogleMaps

class VmMap:BaseVm
{
    let br_cafes:BehaviorRelay<[ModelCafe]> = BehaviorRelay.init(value: [])
    let br_map:BehaviorRelay<GMSMapView?> = BehaviorRelay.init(value: nil)
    let ps_clicked_cafe:PublishSubject<Int> = PublishSubject.init()
    let ps_to_move_camera:PublishSubject<[Double]> = PublishSubject.init()
    let ps_to_draw_polyline:PublishSubject<GMSPath> = PublishSubject.init()
    let ps_to_clear_route:PublishSubject<Void> = PublishSubject.init()
    var is_events_setted:Bool = false
    
    override init()
    {
        super.init()
    }
    
    private func setAfterMapReadyEvents()
    {
        BusMainEvents.gi.ps_clikced_cafe_route
            .subscribe(onNext:
                { route_info in
                    
                    BusMainEvents.gi.ps_scroll_to_tab.onNext(.map)
                    self.navigateToRoute(route: route_info)
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.br_current_map_location
            .subscribe(onNext:
                { data in
                    
                    guard let latitude = data?.0,
                        let longitude = data?.1
                        else
                    {
                        return
                    }
                    
                    let radius = self.br_map.value?.getRadius().toKm() ?? 10
                    
                    let req = ReqCafesList(lat: latitude, lon: longitude, distance: radius, filter: nil, order: .Distance, sort: .Asc, action_success:
                    { cafes in
                        
                        if let user_location = BusMainEvents.gi.br_current_location.value
                        {
                            cafes.countDistanceToLocation(user_lat: user_location.latitude, user_lon: user_location.longitude)
                        }
                        
                        self.br_cafes.accept(cafes)
                    })
                    
                    
                    self.base_netwoker.getCafes(req: req)
            })
            .disposed(by: dispose_bag)
        
        BusMainEvents.gi.br_current_location
            .take(2)
            .subscribe(onNext:
                { location in
                    
                    print("Update in location ")
                    
                    var location = location
                    
                    if(location == nil)
                    {
                        location = CLLocationCoordinate2D.init(latitude: 55.751244, longitude: 37.618423)
                    }
                    
                    guard let radius = self.br_map.value?.getRadius().toKm() else
                    {return}
                    //                    let radius = self.br_map.value?.getRadius().toKm() ?? 10
                    
                    let data = [location!.latitude,location!.longitude,10.0]
                    self.ps_to_move_camera.onNext(data)
                    
                    let req = ReqCafesList(lat: location!.latitude, lon: location!.longitude, distance: radius, filter: nil, order: .Distance, sort: .Asc, action_success:
                    { cafes in
                        
                        cafes.countDistanceToLocation(user_lat: location!.latitude, user_lon: location!.longitude)
                        self.br_cafes.accept(cafes)
                    })
                    
                    self.base_netwoker.getCafes(req: req)
            })
            .disposed(by: dispose_bag)
        
        is_events_setted = true
    }
}

//MARK: -Listeners
extension VmMap
{
    func clickedClearRoute()
    {
        ps_to_clear_route.onNext(())
    }
    
    func clickedMyLocation()
    {
        var disposable:Disposable? = nil
        disposable = BusMainEvents.gi.br_current_location
            .subscribe(onNext:
                { location in
                    
                    if let location = location
                    {
                        let data = [location.latitude,location.longitude,14]
                        self.ps_to_move_camera.onNext(data)
                        disposable?.dispose()
                    }
            })
        disposable?.disposed(by: dispose_bag)
    }
    
    func onMapReady()
    {
        if(!is_events_setted)
        {
            setAfterMapReadyEvents()
        } 
    }
    
    func clickedCafe(cafe:ModelCafe)
    {
        cafe.recountDistance()
        MessagesManager.showCafeDialog(cafe: cafe, action_clicked:
            { cafe in
                
                MessagesManager.dismissDialogWithName(name: "CafePopup")
                guard let cafe_id = cafe.id else { return }
                self.ps_clicked_cafe.onNext(cafe_id)
        }, action_clicked_route: { route_info in
            
            MessagesManager.dismissDialogWithName(name: "CafePopup")
            self.navigateToRoute(route: route_info)
        })
    }
    
    func mapIdleAtPosition(camera_pos:GMSCameraPosition)
    {
        guard let latitude = self.br_map.value?.camera.target.latitude,
            let longitude = self.br_map.value?.camera.target.longitude
            else
        {
            return
        }
        
        BusMainEvents.gi.br_current_map_location.accept((latitude,longitude))
    }
    
    func navigateToRoute(route:RouteInfoMy)
    {
        let path = route.getFullPath()
        self.ps_to_draw_polyline.onNext(path)
        
        if let location_start = route.points[safe:0]
        {
            let data = [location_start.latitude,location_start.longitude,15.0]
            ps_to_move_camera.onNext(data)
        }
    }
}
