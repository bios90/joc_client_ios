import Foundation
import GoogleMaps
import RxSwift

class ViewMap:BaseViewController
{
    var vm_map:VmMap!
    var factory_map:FactoryMap!
    var google_map_view:GMSMapView!
    var poly:GMSPolyline?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        status_bar_style = .default
        setBaseVmAction(base_vm: vm_map)
        setEvents()
        
        let camera = GMSCameraPosition.camera(withLatitude: 55.751244, longitude: 37.618423, zoom: 10)
      
        google_map_view = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        google_map_view.isMyLocationEnabled = true
//        google_map_view.settings.myLocationButton = true
        google_map_view.padding = UIEdgeInsets(top: 0, left: 0, bottom: -6, right: 54)
        
        self.view.addSubview(google_map_view)
        google_map_view.snp.makeConstraints(
            { make in
                
                make.edges.equalToSuperview()
        })
        
        google_map_view.delegate = self
        
        factory_map = FactoryMap(vc: self)
        vm_map.br_map.accept(google_map_view)
        
        factory_map.btn_location.addAction {
            self.vm_map.clickedMyLocation()
        }
        
        factory_map.btn_clear_route.addAction {
            self.vm_map.clickedClearRoute()
        }
    }
    
    private func setEvents()
    {
        vm_map.br_cafes
            .throttle(.milliseconds(3000), scheduler: MainScheduler.instance)
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
        
        vm_map.ps_to_move_camera
            .subscribe(onNext:
                { data in
                    
                    print("Called to move camera")
                    
                    let camera = GMSCameraPosition.camera(withLatitude: data[0], longitude: data[1], zoom: Float(data[2]))
                    self.google_map_view.animate(to: camera)
            })
        .disposed(by: dispose_bag)
        
        vm_map.ps_to_draw_polyline
            .subscribe(onNext:
                { path in
                    
                    self.poly?.map = nil
                    
                    self.poly = GMSPolyline(path: path)
                    let color = MyColors.gi.orange
                    self.poly?.strokeColor = color
                    self.poly?.strokeWidth = 5
                    self.poly?.map = self.google_map_view
                    
                    self.factory_map.btn_clear_route.animateFadeOut()
                    
            }).disposed(by: dispose_bag)
        
        vm_map.ps_to_clear_route
            .subscribe(onNext:
                {
                    self.poly?.map = nil
                    self.factory_map.btn_clear_route.animateFadeIn()
            })
        .disposed(by: dispose_bag)
    }
}


extension ViewMap :GMSMapViewDelegate
{
    
    func mapViewSnapshotReady(_ mapView: GMSMapView)
    {
        vm_map.onMapReady()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition)
    {
        vm_map.mapIdleAtPosition(camera_pos: position)
    }
    
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        
        if let cafe = (marker.iconView as? LaMarker)?.cafe
        {
            vm_map.clickedCafe(cafe: cafe)
        }
        
        return true
    }
}
