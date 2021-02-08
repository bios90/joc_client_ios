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

//For stroke creation
public extension UIImage {
    
    /**
     Returns the flat colorized version of the image, or self when something was wrong
     
     - Parameters:
     - color: The colors to user. By defaut, uses the ``UIColor.white`
     
     - Returns: the flat colorized version of the image, or the self if something was wrong
     */
    func colorized(with color: UIColor = .white) -> UIImage
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        
        defer
        {
            UIGraphicsEndImageContext()
        }
        
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else { return self }
        
        
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        color.setFill()
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.clip(to: rect, mask: cgImage)
        context.fill(rect)
        
        guard let colored = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        
        return colored
    }
    
    /**
     Returns the stroked version of the fransparent image with the given stroke color and the thickness.
     
     - Parameters:
     - color: The colors to user. By defaut, uses the ``UIColor.white`
     - thickness: the thickness of the border. Default to `2`
     - quality: The number of degrees (out of 360): the smaller the best, but the slower. Defaults to `10`.
     
     - Returns: the stroked version of the image, or self if something was wrong
     */
    
    func stroked(with color: UIColor = .white, thickness: CGFloat = 2, quality: CGFloat = 10) -> UIImage
    {
        
        guard let cgImage = cgImage else { return self }
        
        // Colorize the stroke image to reflect border color
        let strokeImage = colorized(with: color)
        
        guard let strokeCGImage = strokeImage.cgImage else { return self }
        
        /// Rendering quality of the stroke
        let step = quality == 0 ? 10 : abs(quality)
        
        let oldRect = CGRect(x: thickness, y: thickness, width: size.width, height: size.height).integral
        let newSize = CGSize(width: size.width + 2 * thickness, height: size.height + 2 * thickness)
        let translationVector = CGPoint(x: thickness, y: 0)
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, scale)
        
        guard let context = UIGraphicsGetCurrentContext() else { return self }
        
        defer
        {
            UIGraphicsEndImageContext()
        }
        context.translateBy(x: 0, y: newSize.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.interpolationQuality = .high
        
        for angle: CGFloat in stride(from: 0, to: 360, by: step)
        {
            let vector = translationVector.rotated(around: .zero, byDegrees: angle)
            let transform = CGAffineTransform(translationX: vector.x, y: vector.y)
            
            context.concatenate(transform)
            
            context.draw(strokeCGImage, in: oldRect)
            
            let resetTransform = CGAffineTransform(translationX: -vector.x, y: -vector.y)
            context.concatenate(resetTransform)
        }
        
        context.draw(cgImage, in: oldRect)
        
        guard let stroked = UIGraphicsGetImageFromCurrentImageContext() else { return self }
        
        return stroked
    }
}


extension CGPoint
{
    /**
     Rotates the point from the center `origin` by `byDegrees` degrees along the Z axis.
     
     - Parameters:
     - origin: The center of he rotation;
     - byDegrees: Amount of degrees to rotate around the Z axis.
     
     - Returns: The rotated point.
     */
    func rotated(around origin: CGPoint, byDegrees: CGFloat) -> CGPoint
    {
        let dx = x - origin.x
        let dy = y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx) // in radians
        let newAzimuth = azimuth + byDegrees * .pi / 180.0 // to radians
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
}
