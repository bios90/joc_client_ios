import Foundation
import MapKit
import CoreLocation

class MyLocationManager:NSObject, CLLocationManagerDelegate
{
    static let gi = MyLocationManager()
    let location_manager = CLLocationManager()
    
    
    override init()
    {
        super.init()
        location_manager.delegate = self
    }
    
    func startGettingLocation()
    {
        self.location_manager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled()
        {
            location_manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
//            location_manager.desiredAccuracy = kCLLocationAccuracyBest
            location_manager.distanceFilter = 50
            location_manager.startUpdatingLocation()
        }
        
        if let last_location = LocalData.getUserLastLocation()
        {
            BusMainEvents.gi.br_current_location.accept(last_location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        BusMainEvents.gi.br_current_location.accept(location)
    }
    
    func stopGettingLocation()
    {
        self.location_manager.stopUpdatingLocation()
    }
}
