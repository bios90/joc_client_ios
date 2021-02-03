import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    
    var window: UIWindow?
    var nav_controller:BaseNavController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        IQKeyboardManager.shared.enable = true
        
        initGoogleMaps()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        nav_controller = BaseNavController()
        window!.rootViewController = nav_controller
        window!.makeKeyAndVisible()
        
        var coordinator_main = CoordinatorMain(nav_controller: nav_controller)
        coordinator_main.startMain()
        
        return true
    }
    
    private func initGoogleMaps()
    {
        GMSServices.provideAPIKey("AIzaSyAM2KVBocv1fj_Q5Rk0bbmJ4fl_u3ZEqp0")
        GMSPlacesClient.provideAPIKey("AIzaSyAM2KVBocv1fj_Q5Rk0bbmJ4fl_u3ZEqp0")
    }


}

