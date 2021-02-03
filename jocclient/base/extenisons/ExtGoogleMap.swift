import Foundation
import GoogleMaps

extension GMSMapView
{
    func getCenterCoordinate() -> CLLocationCoordinate2D
    {
        let centerPoint = self.center
        let centerCoordinate = self.projection.coordinate(for: centerPoint)
        return centerCoordinate
    }
    
    func getTopCenterCoordinate() -> CLLocationCoordinate2D
    {
        // to get coordinate from CGPoint of your map
        let topCenterCoor = self.convert(CGPoint(x: self.frame.size.width, y: 0), from: self)
        let point = self.projection.coordinate(for: topCenterCoor)
        return point
    }
    
    func getRadius() -> CLLocationDistance
    {
        let centerCoordinate = getCenterCoordinate()
        let centerLocation = CLLocation(latitude: centerCoordinate.latitude, longitude: centerCoordinate.longitude)
        let topCenterCoordinate = self.getTopCenterCoordinate()
        let topCenterLocation = CLLocation(latitude: topCenterCoordinate.latitude, longitude: topCenterCoordinate.longitude)
        let radius = CLLocationDistance(centerLocation.distance(from: topCenterLocation))
        return round(radius)
    }
}

extension CLLocationDistance
{
    func toKm()->Int
    {
        var radius = self / 1000.0
        let rounded = Int(radius.rounded())
        return rounded
    }
    
    func toMeters()->Int
    {
        var radius = self / 1.0
        let rounded = Int(radius.rounded())
        return rounded
    }
}
