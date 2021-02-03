import UIKit
import Kingfisher

extension UIImageView
{
    func setImageColor(color: UIColor)
    {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func loadImageObj(obj:ObjWithImage,action_load_finished:(()->Void)? = nil)
    {
        if let url = obj.url
        {
            loadImageMy(url_str: url,action_load_finished: action_load_finished)
        }
        else if let image = obj.image
        {
            loadImageMy(image: image,action_load_finished: action_load_finished)
        }
    }
    
    func loadImageMy(url_str:String,action_load_finished:(()->Void)? = nil)
    {
        self.kf.indicatorType = .activity
        if let url = URL(string: url_str)
        {
            self.kf.setImage(with: url,options:
                [
                    .transition(.fade(0.3))
                ],completionHandler:
                { _ in

                    action_load_finished?()
            })
        }
    }
    
    func loadImageMy(image:UIImage,action_load_finished:(()->Void)? = nil)
    {
        let image_provider = UIImageProvider(image: image)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: .provider(image_provider),options:
            [
                .transition(.fade(0.3))
        ],completionHandler:
            { _ in

                action_load_finished?()
        })
    }
    
    
    
}

enum ImageLoadError:Error
{
    case failed
}

struct UIImageProvider: ImageDataProvider
{
    let cacheKey: String
    let imageData: Data?
    
    init(image: UIImage)
    {
        cacheKey = image.sha256()
        imageData = image.pngData()
    }
    
    func data(handler: @escaping (Result<Data, Error>) -> Void)
    {
        if let data = imageData
        {
            handler(.success(data))
        }
        else
        {
            handler(.failure(ImageLoadError.failed))
        }
    }
}

