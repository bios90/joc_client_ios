import Foundation

enum TypeProduct:String
{
    case Hot = "hot"
    case Cold = "cold"
    case Snack = "dessert"
    
    func getNameForDisplay() -> String
    {
        switch self
        {
        case .Hot:
            return MyStrings.hot_drinks.localized()
        case .Cold:
            return MyStrings.cold_drinks.localized()
        case .Snack:
            return MyStrings.snacks.localized()
        }
    }
}

extension TypeProduct: Codable
{
    public init(from decoder: Decoder) throws
    {
        self = try TypeProduct(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .Hot
    }
}
