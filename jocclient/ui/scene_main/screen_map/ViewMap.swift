import Foundation
import GoogleMaps
import RxSwift

class ViewMap:BaseViewController
{
    var vm_map:VmMap!
    var factory_map:FactoryMap!
    var google_map_view:GMSMapView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        status_bar_style = .default
        setBaseVmAction(base_vm: vm_map)
        setEvents()
        
        factory_map = FactoryMap(vc: self)
        
        let camera = GMSCameraPosition.camera(withLatitude: 55.751244, longitude: 37.618423, zoom: 8)
        google_map_view = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(google_map_view)
        google_map_view.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        google_map_view.delegate = self
        
        vm_map.br_map.accept(google_map_view)
    }
    
    private func setEvents()
    {
        vm_map.br_cafes
            .debounce(.milliseconds(2000), scheduler: MainScheduler.instance)
            .subscribe(onNext:
                { cafes in
                    
                    for cafe in cafes
                    {
                        let view_marker = LaMarker(cafe: cafe)
                        
                        let marker = GMSMarker()
                        marker.iconView = view_marker
                        let lat = Double(cafe.lat!)!
                        let lon = Double(cafe.lon!)!
                                              
                        marker.position = CLLocationCoordinate2D(latitude: lat, longitude:lon)
                        marker.map = self.google_map_view
                    }
                    
            })
        .disposed(by: dispose_bag)
    }
}


extension ViewMap :GMSMapViewDelegate
{
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        
        if let cafe = (marker.iconView as? LaMarker)?.cafe
        {
            vm_map.clickedCafe(cafe: cafe)
        }
        
        return true
    }
}
