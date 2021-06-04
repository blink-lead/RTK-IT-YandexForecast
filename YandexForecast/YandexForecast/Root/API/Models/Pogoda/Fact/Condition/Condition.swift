import Foundation

enum Condition: String, Codable {
    case clear = "clear"
    case cloudy = "cloudy"
    case heavyRain = "heavy-rain"
    case lightRain = "light-rain"
    case overcast = "overcast"
    case partlyCloudy = "partly-cloudy"
    case rain = "rain"
}
