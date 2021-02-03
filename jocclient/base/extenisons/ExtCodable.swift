import Foundation

extension KeyedDecodingContainer where Key: CodingKey
{
    func decodeObject<T:Codable>(type:T.Type, from key: Key) throws -> T?
    {
        let object = try decode(T.self, forKey: key)
        return object
    }
    
    func decodeArray<T:Codable>(type:T.Type, from key: Key) throws -> [T]?
    {
        let arr = try decode([T].self, forKey: key)
        return arr
    }
    
    func decodeSet<T:Codable>(type:T.Type, from key: Key) throws -> Set<T>?
    {
        let set = try decode(Set<T>.self, forKey: key)
        return set
    }
    
    func decodeDate(from key: Key, format: String = DateManager.FORMAT_FOR_SERVER) throws -> Date?
    {
        let dateAsString = try decode(String.self, forKey: key)
        let dateFormatter = DateFormatter()
        
        for i in 0..<DateManager.ALL_FORMATS.count
        {
            let format = DateManager.ALL_FORMATS[i]
            dateFormatter.dateFormat = format
            if let date = dateFormatter.date(from: dateAsString)
            {
                return date
            }
        }
        return nil
    }
    
    func decodeInt(from key: Key) throws -> Int?
    {
        let num = try? decode(Int.self, forKey: key)
        if(num != nil)
        {
            return num
        }else
        {
            let num_as_str = try? decode(String.self, forKey: key)
            if(num_as_str != nil)
            {
                return Int(num_as_str!)
            }
        }
        
        return nil
    }
    
    func decodeDouble(from key: Key) throws -> Double?
    {
        return try decode(Double.self, forKey: key)
    }
    
    func decodeString(from key: Key) throws -> String?
    {
        return try decode(String.self, forKey: key)
    }
    
    func decodeBool(from key: Key) throws -> Bool?
    {
        return try decode(Bool.self, forKey: key)
    }
}
