import Foundation

enum TypeCafe
{
    case All
    case Cafe
    case CoffeeSpot
    
    func getPos() -> Int
    {
        switch self
        {
        case .All:
            return 0
        case .Cafe:
            return 1
        case .CoffeeSpot:
            return 2
        }
    }
    
    static func initFromPos(pos:Int)->TypeCafe
    {
        switch pos
        {
        case 0:
            return .All
        case 1:
            return .Cafe
        case 2:
            return CoffeeSpot
        default:
            fatalError("*** Error pos of unknown type ***")
        }
    }
}
