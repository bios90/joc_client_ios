import CoreLocation
import Foundation

class ModelCafe:Codable,ObjectWithId,ObjectWithDates
{
    var id:Int?
    var created: Date?
    var updated: Date?
    var deleted: Date?
    
    var name:String?
    var lat:String?
    var lon:String?
    var logo:BaseImage?
    var rating:Double?
    var address:String?
    var distance:Int?
    var working_hours_str:String?
    var description:String?
    var images:[BaseImage]?
    var menu:ModelMenu?
    var can_order:Bool?
    var reviews:[ModelReview]? = []
    
    var social_instagram:String?
    var social_vk:String?
    var social_facebook:String?
    var social_twitter:String?
    var social_whatsapp:String?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try? container.decodeInt(from: .id)
        self.created = try? container.decodeDate(from: .created)
        self.updated = try? container.decodeDate(from: .updated)
        self.deleted = try? container.decodeDate(from: .deleted)
        
        self.name = try? container.decodeString(from: .name)
        self.lat = try? container.decodeString(from: .lat)
        self.lon = try? container.decodeString(from: .lon)
        self.logo = try? container.decodeObject(type: BaseImage.self, from: .logo)
        self.rating = try? container.decodeDouble(from: .rating)
        self.address = try? container.decodeString(from: .address)
        self.working_hours_str = try? container.decodeString(from: .working_hours_str)
        self.description = try? container.decodeString(from: .description)
        self.images = try? container.decodeArray(type: BaseImage.self, from: .images)
        let can_order_str = try? container.decodeString(from: .can_order)
        self.can_order = can_order_str?.toBool()
        self.menu = try? container.decodeObject(type: ModelMenu.self, from: .menu)
        self.reviews = try? container.decodeArray(type: ModelReview.self, from: .reviews)
        
        self.social_instagram = try? container.decodeString(from: .social_instagram)
        self.social_vk = try? container.decodeString(from: .social_vk)
        self.social_facebook = try? container.decodeString(from: .social_facebook)
        self.social_twitter = try? container.decodeString(from: .social_twitter)
        self.social_whatsapp = try? container.decodeString(from: .social_whatsapp)
        
        if(social_instagram?.isEmpty == true)
        {
            social_instagram = nil
        }
        
        if(social_vk?.isEmpty == true)
        {
            social_vk = nil
        }
        if(social_facebook?.isEmpty == true)
        {
            social_facebook = nil
        }

        if(social_twitter?.isEmpty == true)
        {
            social_twitter = nil
        }
        if(social_whatsapp?.isEmpty == true)
        {
            social_whatsapp = nil
        }
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case created
        case deleted
        case updated
        
        case name
        case lat
        case lon = "lng"
        case logo
        case rating
        case address
        case working_hours_str = "working_hours"
        case description
        case images = "photo"
        case can_order
        
        case menu
        case reviews
        
        case social_instagram
        case social_vk
        case social_facebook
        case social_twitter
        case social_whatsapp
    }
}

//MARK: - Some dummy data
extension ModelCafe
{
    static func getDummyData()->[ModelCafe]
    {
        let data_image : [String:Any] =
            [
                "width": 100,
                "height": 100,
                "src":"https://i.pinimg.com/originals/87/5d/8f/875d8fb456511689c8f1d46ed626235f.png",
                "url_s":"https://i.pinimg.com/originals/87/5d/8f/875d8fb456511689c8f1d46ed626235f.png",
                "url_m":"https://i.pinimg.com/originals/87/5d/8f/875d8fb456511689c8f1d46ed626235f.png",
                "url_l":"https://i.pinimg.com/originals/87/5d/8f/875d8fb456511689c8f1d46ed626235f.png"
        ]
        //        let image = BaseImage(dictionary: data_image)
        
        let data:[String:Any] =
            [
                "id" : 1,
                "name" : "TestCafeName",
                "lat" : "55.751244",
                "lng" : "37.618423",
                "adress" : "Esenin moisenina 1234578",
                "working_hours" : "20:00 - 23:00",
                "rating" : 5.0,
                "description" : "description description description description description description description description description",
                "logo":data_image
        ]
        
        var cafes:[ModelCafe] = []
        for i in 0...1
        {
            if let cafe = ModelCafe(dictionary: data)
            {
                cafes.append(cafe)
            }
        }
        
        return cafes
    }
    
    func recountDistance()
    {
        if let user_location = BusMainEvents.gi.br_current_location.value
        {
            print("Count distance Yes have location will recount")
            self.countDistanceFromLocation(user_lat: user_location.latitude, user_lon: user_location.longitude)
        }
        else
        {
            print("Count distance noooo")
        }
    }
    
    func countDistanceFromLocation(user_lat:Double,user_lon:Double)
    {
        guard let lat =  self.lat?.toDouble(), let lon = self.lon?.toDouble() else
        {
            self.distance = 0
            return
        }
        
        let self_location = CLLocation(latitude: lat , longitude: lon)
        let user_location = CLLocation(latitude: user_lat, longitude: user_lon)
        let distance = user_location.distance(from: self_location).toMeters()
        self.distance = distance
    }
    
    func getDistanseText()->String
    {
        //Todo change later
//        guard let distance = self.distance else { return "-" }
//
        let distance = (100...400).randomElement()!
        return "\(distance) м."
    }
    
    func getCafeLocation()->CLLocationCoordinate2D?
    {
        guard let lat_str = lat, let lon_str = lon,
            let lat_double = Double(lat_str),let lon_double = Double(lon_str)
            else { return nil }
        
        return CLLocationCoordinate2D(latitude: lat_double, longitude: lon_double)
    }
    
    func getSocials()->[FawString:String?]
    {
        let url_whatsapp:String?
        if social_whatsapp.isNullOrEmpty()
        {
            url_whatsapp = nil
        }
        else if social_whatsapp?.starts(with: "https://") == true
        {
            url_whatsapp = social_whatsapp
        }
        else
        {
            url_whatsapp = "https://wa.me/"+social_whatsapp!.filter({ $0.isNumber})
        }
        
        return [
            FawString.instagram:social_instagram,
            FawString.vk:social_vk,
            FawString.facebook:social_facebook,
            FawString.whatsapp:url_whatsapp,
            FawString.twitter:social_twitter]
    }
}

extension Array where Element == ModelCafe
{
    func countDistanceToLocation(user_lat:Double,user_lon:Double)
    {
        self.forEach({ $0.countDistanceFromLocation(user_lat: user_lat, user_lon: user_lon) })
    }
}


