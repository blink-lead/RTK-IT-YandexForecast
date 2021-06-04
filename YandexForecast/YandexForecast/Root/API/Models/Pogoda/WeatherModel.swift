import Foundation

struct WeatherModel: Codable {
    
    let now: Double?
    let nowDt: String?
    let info: Info?
    let geoObject: GeoObject?
    let yesterday: Yesterday?
    let fact: Fact?
    let forecasts: [Forecast]?
    
    internal init(now: Double? = nil,
                  nowDt: String? = nil,
                  info: Info? = nil,
                  geoObject: GeoObject? = nil,
                  yesterday: Yesterday? = nil,
                  fact: Fact? = nil,
                  forecasts: [Forecast]? = nil) {
        self.now = now
        self.nowDt = nowDt
        self.info = info
        self.geoObject = geoObject
        self.yesterday = yesterday
        self.fact = fact
        self.forecasts = forecasts
    }
    
    private enum CodingKeys: String, CodingKey {
        case now = "now"
        case nowDt = "now_dt"
        case info = "info"
        case geoObject = "geo_object"
        case yesterday = "yesterday"
        case fact = "fact"
        case forecasts = "forecasts"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
            now = try values.decodeIfPresent(Double.self, forKey: .now)
        } catch DecodingError.typeMismatch {
            let value = try values.decode(Int.self, forKey: .now)
            now = Double(value)
        }
        nowDt = try values.decodeIfPresent(String.self, forKey: .nowDt)
        info = try values.decodeIfPresent(Info.self, forKey: .info)
        geoObject = try values.decodeIfPresent(GeoObject.self, forKey: .geoObject)
        yesterday = try values.decodeIfPresent(Yesterday.self, forKey: .yesterday)
        fact = try values.decodeIfPresent(Fact.self, forKey: .fact)
        forecasts = try values.decodeIfPresent([Forecast].self, forKey: .forecasts)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(now, forKey: .now)
        try container.encodeIfPresent(nowDt, forKey: .nowDt)
        try container.encodeIfPresent(info, forKey: .info)
        try container.encodeIfPresent(geoObject, forKey: .geoObject)
        try container.encodeIfPresent(yesterday, forKey: .yesterday)
        try container.encodeIfPresent(fact, forKey: .fact)
        try container.encodeIfPresent(forecasts, forKey: .forecasts)
    }
}
