import Foundation

extension String
{
    var htmlToAttributedString: NSAttributedString?
    {
        guard let data = data(using: .utf8) else { return nil }
        do
        {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        }
        catch
        {
            return nil
        }
    }
    
    var htmlToString: String
    {
        return htmlToAttributedString?.string ?? ""
    }
    
    
    func toDouble() -> Double?
    {
        return NumberFormatter().number(from: self)?.doubleValue
    }
    
    func toBool() -> Bool?
    {
        switch self.lowercased()
        {
        case "true", "t", "yes", "y", "1":
            return true
        case "false", "f", "no", "n", "0":
            return false
        default:
            return nil
        }
    }
    
}

extension Optional where Wrapped == String
{
    func getNullable() -> String?
    {
        if(self == nil)
        {
            return nil
        }
        
        let text = self?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text!.isEmpty)
        {
            return nil
        }
        
        return text
    }
    
    func getNullableAndTrimmed() -> String?
    {
        if(self == nil)
        {
            return nil
        }
        
        let text = self?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text!.isEmpty)
        {
            return nil
        }
        
        return text
    }
    
    func isNullOrEmpty()->Bool
    {
        let trimmed = self.getNullableAndTrimmed()
        return trimmed == nil
    }
}
