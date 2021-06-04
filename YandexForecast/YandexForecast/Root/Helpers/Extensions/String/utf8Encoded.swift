import Foundation

public extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
