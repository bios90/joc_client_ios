import UIKit

protocol ObjectWithId
{
    var id:Int? { get set }
}

protocol ObjectWithDates
{
    var created: Date? { get set }
    var updated: Date? { get set }
    var deleted: Date? { get set }
}


class FeedDisplayInfo<T>
{
    let behaviour:LoadBehaviour
    let items:[T]
    
    init(items:[T], behaviour:LoadBehaviour)
    {
        self.behaviour = behaviour
        self.items = items
    }
}

protocol ObjWithImage
{
    var url:String? { get set }
    var image:UIImage? { get set }
}

class ObjWithImageImpl:ObjWithImage
{
    var url: String?
    var image: UIImage?
    
    init(url:String?,image:UIImage?)
    {
        self.url = url
        self.image = image
    }
}

extension ObjWithImage
{
    static func initFromUrl(url:String)->ObjWithImage
    {
        return ObjWithImageImpl(url: url, image: nil)
    }
}

