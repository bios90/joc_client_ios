import Foundation

enum LoadBehaviour
{
    case FULL_RELOAD
    case UPDATE
    case SCROLL_TO_ID(id:Int)
    case NONE
}
