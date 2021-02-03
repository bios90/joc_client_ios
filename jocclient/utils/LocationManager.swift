import Foundation
import MapKit
import CoreLocation

class MyLocationManager:NSObject, CLLocationManagerDelegate
{
    static let gi = MyLocationManager()
    let location_manager = CLLocationManager()
    var is_getting_location = false
    
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
            print("Will start gettting")
            location_manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            location_manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("Got location somemee")
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        BusMainEvents.gi.br_current_location.accept(location)
    }
    
    func stopGettingLocation()
    {
        self.location_manager.stopUpdatingLocation()
    }
}
