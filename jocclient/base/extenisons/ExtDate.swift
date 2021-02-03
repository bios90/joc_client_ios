import Foundation

extension Date
{
    func currentTimeMillis() -> Int64
    {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func formatToString(format:String = DateManager.FORMAT_FOR_DISPLAY)->String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale =  Locale(identifier: "ru-Ru")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
