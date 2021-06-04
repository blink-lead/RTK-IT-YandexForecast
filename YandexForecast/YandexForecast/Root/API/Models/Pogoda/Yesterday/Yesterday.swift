import Foundation

struct Yesterday: Codable {
    
    let temp: Double?
    
    internal init(temp: Double? = nil) {
        self.temp = temp
    }
    
    internal init?(_ dict: [String:Any?]?) {
        guard let dict = dict else { return nil }
        temp = dict["temp"] as? Double
    }
    
    private enum CodingKeys: String, CodingKey {
        case temp = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decodeIfPresent(Double.self, forKey: .temp)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(temp, forKey: .temp)
    }
}

extension Yesterday {
    func toDictionary() -> [String:Any?] {
        var jsonDict = [String:Any?]()
        jsonDict["temp"] = temp
        return jsonDict
    }
}
