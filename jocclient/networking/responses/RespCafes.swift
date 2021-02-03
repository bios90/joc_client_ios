import Foundation

class RespCafes:BaseResponse
{
    var resp_cafes:RespCafesData? = nil
    
    required init(from decoder: Decoder) throws
    {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        resp_cafes = try? values.decodeObject(type: RespCafesData.self, from:.resp_cafes)
    }

    private enum CodingKeys: String, CodingKey
    {
        case resp_cafes = "data"
    }
}


class RespCafesData:Codable
{
    var cafes:[ModelCafe]? = []
    
    required init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        cafes = try? values.decodeArray(type: ModelCafe.self, from: .cafes)
    }

    private enum CodingKeys: String, CodingKey
    {
        case cafes = "data"
    }
}
