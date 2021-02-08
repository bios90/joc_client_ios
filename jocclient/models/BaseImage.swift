import UIKit

class BaseImage:Codable,ObjWithImage
{
    //ObjWithImage
    var url: String?
    var image: UIImage? = nil
    //
    
    var width:Int?
    var height:Int?
    var src:String?
    var url_s:String?
    var url_m:String?
    var url_l:String?
    
    required public init(from decoder: Decoder) throws
    {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.width = try? container.decodeInt(from: .width)
        self.height = try? container.decodeInt(from: .height)
        self.src = try? container.decodeString(from: .src)
        self.url_s = try? container.decodeString(from: .url_s)
        self.url_m = try? container.decodeString(from: .url_m)
        self.url_l = try? container.decodeString(from: .url_l)
        
        self.url = url_l
    }
    
    enum CodingKeys: String, CodingKey
    {
        case width
        case height
        case src
        case url_s
        case url_m
        case url_l
    }
}
