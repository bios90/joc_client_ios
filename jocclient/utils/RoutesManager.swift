import Foundation
import CoreLocation
import GoogleMaps

class RoutesManager
{
    static let gi = RoutesManager()
    
    func getRouteInfo(start:CLLocationCoordinate2D,finish:CLLocationCoordinate2D, action_success:@escaping(RouteInfoMy)->Void)
    {
        let origin = "\(start.latitude),\(start.longitude)"
        let destination = "\(finish.latitude),\(finish.longitude)"
        let api_key = "AIzaSyDGvaukwLZyj3jvJrWQ7fAFBxMHOWJKS2U"
        
        let url_string = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=walking&key=\(api_key)"
        
        print("url to find route is \(url_string)")
        
        let url = URL(string: url_string)
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler:
        {
            (data, response, error) in
            
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let jsonResult = try? JSONSerialization.jsonObject(with: data!, options:.allowFragments) as? [String: Any]
                else
            {
                return
            }
            
            let routes_my = self.getAllRoutes(result: jsonResult)
            
            let sorted = routes_my.sorted(by: { $0.distance_in_meters > $1.distance_in_meters })
            let best = sorted[safe: 0]
            
            if let best = best
            {
                DispatchQueue.main.async {
                    action_success(best)
                }
            }
        })
        
        task.resume()
    }
    
    private func getAllRoutes(result:[String:Any])->[RouteInfoMy]
    {
        var routes_my:[RouteInfoMy] = []
        
        guard let routes = result["routes"] as? [[String: Any]] else { return routes_my }
        
        for route in routes
        {
            guard let legs = route["legs"] as? [[String:Any]] else { continue }
            
            for route_leg in legs
            {
                
                guard let distance_obj = route_leg["distance"] as? [String:Any],
                    let distance = distance_obj["value"] as? Int
                    else { continue }
                
                guard let duration_obj = route_leg["duration"] as? [String:Any],
                    let duration = duration_obj["value"] as? Int
                    else { continue }
                
                guard let steps = route_leg["steps"] as? [[String:Any]]
                    else { continue }
                
                var points:[CLLocationCoordinate2D] = []
                var polylines_strs:[String] = []
                
                for step in steps
                {
                    if points.isEmpty
                    {
                        guard let start_step = step["start_location"] as? [String:Double]
                            , let start_lat = start_step["lat"], let start_lng = start_step["lng"]
                            else { continue }
                        
                        points.append(CLLocationCoordinate2D(latitude: start_lat, longitude: start_lng))
                    }
                    
                    guard let finish_step = step["end_location"] as? [String:Double]
                        , let finish_lat = finish_step["lat"], let finish_lng = finish_step["lng"]
                        else { continue }
                    
                    guard let poly_info = step["polyline"] as? [String:String]
                        ,let poly_str = poly_info["points"] else { continue }
                    polylines_strs.append(poly_str)
                    
                    points.append(CLLocationCoordinate2D(latitude: finish_lat, longitude: finish_lng))
                }
                
                let route_info = RouteInfoMy(points: points, time_in_seconds: duration, distance_in_meters: distance,polylines_strs: polylines_strs)
                
                routes_my.append(route_info)
            }
        }
        
        return routes_my
    }
}

class RouteInfoMy
{
    var points:[CLLocationCoordinate2D]!
    var polylines_strs:[String]!
    var time_in_seconds:Int!
    var distance_in_meters:Int!
    
    
    init(points:[CLLocationCoordinate2D],time_in_seconds:Int,distance_in_meters:Int,polylines_strs:[String])
    {
        self.points = points
        self.time_in_seconds = time_in_seconds
        self.distance_in_meters = distance_in_meters
        self.polylines_strs = polylines_strs
    }
    
    func getFullPath()->GMSMutablePath
    {
        let path = GMSMutablePath()
        
        for poly in polylines_strs
        {
            path.appendPath(path: GMSMutablePath(fromEncodedPath: poly))
        }
        
        return path
    }
    
    func getDistanceText()->String
    {
        if(distance_in_meters < 1000)
        {
            return "\(distance_in_meters ?? 0) м."
        }
        
        let distance_km = Double(distance_in_meters) / 1000.0
        let format = MyNumberFormat(min_before_dot: 1, min_after_dot: 0, max_after_dot: 0)
        return distance_km.formatWithPattern(format: format)+" км."
    }
    
    func getTimeText()->String
    {
        let hours = time_in_seconds / 3600
        let minutes = (time_in_seconds % 3600) / 60
        
        let format_hours = MyNumberFormat(min_before_dot: 1, min_after_dot: 0, max_after_dot: 0)
        let format_minutes = MyNumberFormat(min_before_dot: 2, min_after_dot: 0, max_after_dot: 0)
        
        if hours > 0
        {
            return "\(hours.formatWithPattern(format: format_hours)) ч. \(minutes.formatWithPattern(format: format_minutes)) м."
        }
        else
        {
            return "\(minutes) м."
        }
    }
}

extension GMSMutablePath
{
    func appendPath(path : GMSPath?)
    {
        if let path = path
        {
            for i in 0..<path.count()
            {
                self.add(path.coordinate(at: i))
            }
        }
    }
}
