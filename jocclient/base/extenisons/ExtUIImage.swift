import UIKit
import CommonCrypto

extension UIImage
{
    static func initFromView(view:UIView)->UIImage
    {
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        return renderer.image { rendererContext in
            view.layer.render(in: rendererContext.cgContext)
        }
    }
    
    func toBase64() -> String?
    {
        guard let imageData = self.pngData() else { return nil }
        let prefix = "data:image/png;base64,"
        return prefix + imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    public func sha256() -> String
    {
        if let imageData = cgImage?.dataProvider?.data as? Data
        {
            return hexStringFromData(input: digest(input: imageData as NSData))
        }
        return ""
    }
    
    private func digest(input : NSData) -> NSData
    {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String
    {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes
        {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
    
    func scaled_to_size(_ newSize:CGSize) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func setColorMy(_ color1: UIColor) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}

extension UIImage:ObjWithImage
{
    var url: String?
    {
        get
        {
            return nil
        }
        set
        {
            
        }
    }
    
    var image: UIImage?
    {
        get
        {
            return self
        }
        set
        {
            
        }
    }
}
