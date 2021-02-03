import Foundation
import RxSwift
import RxCocoa
import GoogleMaps

class VmMap:BaseVm
{
    let br_cafes:BehaviorRelay<[ModelCafe]> = BehaviorRelay.init(value: [])
    let br_map:BehaviorRelay<GMSMapView?> = BehaviorRelay.init(value: nil)
    let ps_clicked_cafe:PublishSubject<Int> = PublishSubject.init()
    
    override init()
    {
        super.init()
        setEvents()
        
        
        runActionWithDelay(milliseconds: 3000, action:
            {
//                self.br_cafes.accept(ModelCafe.getDummyData())
        })
    }
    
    private func setEvents()
    {
        BusMainEvents.gi.br_current_location
            .subscribe(onNext:
                { location in
                    
                    guard let location = location else { return }
                    guard var radius = self.br_map.value?.getRadius().toKm() else { return }
                    
                    let req = ReqCafesList(lat: location.latitude, lon: location.longitude, distance: radius, filter: nil, order: .Distance, sort: .Asc, action_success:
                    { cafes in
                        
                        cafes.countDistanceToLocation(user_lat: location.latitude, user_lon: location.longitude)
                        self.br_cafes.accept(cafes)
                    })
                    
                    self.base_netwoker.getCafes(req: req)
            })
            .disposed(by: dispose_bag)
    }
}

//MARK: -Listeners
extension VmMap
{
    func clickedCafe(cafe:ModelCafe)
    {
        MessagesManager.showCafeDialog(cafe: cafe, action_clicked:
            { cafe in
                
                MessagesManager.dismissDialogWithName(name: "CafePopup")
                guard let cafe_id = cafe.id else { return }
                self.ps_clicked_cafe.onNext(cafe_id)
        })
    }
}
