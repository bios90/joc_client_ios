import Foundation
import GoogleMaps

enum LocalKeys:String
{
    case PushToken
    case CurrentUser
    case ShowedCovidIntro
    case LastLat
    case LastLng
}

class LocalData
{
    static func getIntroShowed()->Bool
    {
        return UserDefaults.standard.bool(forKey: LocalKeys.ShowedCovidIntro.rawValue)
    }
    
    static func saveIntroShowed(is_showed:Bool = true)
    {
       UserDefaults.standard.set(is_showed, forKey: LocalKeys.ShowedCovidIntro.rawValue)
    }
    
    static func savePushToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func getPushToken()->String?
    {
        guard UserDefaults.standard.hasKey(key: LocalKeys.PushToken.rawValue)  else { return nil }
        
        return UserDefaults.standard.string(forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func clearPushToken()
    {
        UserDefaults.standard.removeObject(forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func saveCurrentUser(user:ModelUser)
    {
        let encoder = globalJsonEncoder
        if let encoded = try? encoder.encode(user)
        {
            UserDefaults.standard.set(encoded, forKey: LocalKeys.CurrentUser.rawValue)
        }
    }
    
    static func clearCurrentUser()
    {
        UserDefaults.standard.removeObject(forKey: LocalKeys.CurrentUser.rawValue)
    }
    
    static func saveUserLocation(location:CLLocationCoordinate2D)
    {
        UserDefaults.standard.set(location.latitude, forKey: LocalKeys.LastLat.rawValue)
        UserDefaults.standard.set(location.longitude, forKey: LocalKeys.LastLng.rawValue)
    }
    
    static func getUserLastLocation()->CLLocationCoordinate2D?
    {
        if UserDefaults.standard.hasKey(key: LocalKeys.LastLat.rawValue)
            ,UserDefaults.standard.hasKey(key: LocalKeys.LastLng.rawValue)
        {
            let lat = UserDefaults.standard.double(forKey: LocalKeys.LastLat.rawValue)
            let lng = UserDefaults.standard.double(forKey: LocalKeys.LastLng.rawValue)
            
            print("Will return saved locally location!")
            return CLLocationCoordinate2D(latitude: lat, longitude: lng)
        }
        
        return nil
    }
    
    static func getCurrentUser()->ModelUser?
    {
        if let data = UserDefaults.standard.object(forKey: LocalKeys.CurrentUser.rawValue) as? Data
        {
            let decoder = globalJsonDecoder
            
            if let user = try? decoder.decode(ModelUser.self, from: data)
            {
                return user
            }
        }
        
        return nil
    }
}
