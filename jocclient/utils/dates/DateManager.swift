import Foundation

class DateManager
{
    static let FORMAT_FOR_SERVER = "dd.MM.yyyy HH:mm"
    static let FORMAT_FOR_SERVER_SHORT = "dd.MM.yyyy"
    static let FORMAT_FOR_SERVER_LONG = "dd.MM.yyyy HH:mm:ss"
    static let FORMAT_FOR_DISPLAY = "d MMM yyyy"
    static let FORMAT_TIME = "HH:mm"
    
    static let ALL_FORMATS =
        [
            FORMAT_FOR_SERVER,
            FORMAT_FOR_DISPLAY,
            FORMAT_FOR_SERVER_SHORT,
            FORMAT_FOR_SERVER_LONG,
            FORMAT_TIME
    ]
}
