import Foundation

enum LocalKeys:String
{
    case PushToken
    case CurrentUser
    
}

class LocalData
{
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
