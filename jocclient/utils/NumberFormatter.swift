import Foundation

class MyNumberFormat
{
    static let formatForRating = MyNumberFormat(min_before_dot: 1, min_after_dot: 1, max_after_dot: 1)
    static let formatForPrice = MyNumberFormat(min_before_dot: 1, min_after_dot: 0, max_after_dot: 2)
    
    var min_before_dot:Int
    var min_after_dot:Int
    var max_after_dot:Int
    
    init(min_before_dot:Int,min_after_dot:Int,max_after_dot:Int)
    {
        self.min_before_dot = min_before_dot
        self.min_after_dot = min_after_dot
        self.max_after_dot = max_after_dot
    }
}

extension Double
{
    func formatWithPattern(format:MyNumberFormat)->String
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = format.min_after_dot
        formatter.maximumFractionDigits = format.max_after_dot
        formatter.minimumIntegerDigits = format.min_before_dot
        formatter.decimalSeparator = "."
        formatter.numberStyle = .decimal

        return formatter.string(from: self as NSNumber)!
    }
}

extension Int
{
    func formatWithPattern(format:MyNumberFormat)->String
    {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = format.min_after_dot
        formatter.maximumFractionDigits = format.max_after_dot
        formatter.minimumIntegerDigits = format.min_before_dot
        formatter.numberStyle = .decimal

        return formatter.string(from: self as NSNumber)!
    }
}
