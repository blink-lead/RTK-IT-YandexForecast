import Foundation

struct Location {
    var name: String
    var lat: Double
    var lon: Double
    
    internal init(_ name: String, lat: Double, lon: Double) {
        self.name = name
        self.lat = lat
        self.lon = lon
    }
}

extension Location: Equatable {
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.name == rhs.name &&
            lhs.lat == rhs.lat &&
            lhs.lon == rhs.lon
    }
}
