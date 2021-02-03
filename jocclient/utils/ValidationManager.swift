import Foundation

class ValidationManager
{
    static func getPleaseFillStr(field:String)->String
    {
        let text = MyStrings.please_fill.localized() + " '\(field)'"
        return text
    }
}
