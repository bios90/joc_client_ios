import Foundation

enum TypeTab
{
    case profile
    case map
    case list
    
    func getPos()->Int
    {
        switch self
        {
        case .profile:
            return 0
        case .map:
            return 1
        case .list:
            return 2
        }
    }
}
