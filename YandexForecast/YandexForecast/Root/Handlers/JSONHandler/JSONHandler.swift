import Foundation

class JSONHandler {
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
    private lazy var decoderIsoSnake: JSONDecoder = {
        let decoder = JSONDecoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            decoder.dateDecodingStrategy = .iso8601
            decoder.keyDecodingStrategy = .convertFromSnakeCase
        }
        return decoder
    }()
    
    private lazy var encoderIsoSnake: JSONEncoder = {
        let encoder = JSONEncoder()
        if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
            encoder.dateEncodingStrategy = .iso8601
            encoder.keyEncodingStrategy = .convertToSnakeCase
        }
        return encoder
    }()
    
    /// Function for processing data
    /// - Parameter data: Data that needs to be processed for subsequent output
    func decoder<T:Decodable>(_ data: Data, _ completion: @escaping (Result<T,Error>) -> ()) {
        // Working with the received data
        if let data = data as? T { // If you want to get raw data
            completion(.success(data))
        } else { // Otherwise, try to decode the data through the required model
            do {
                let model = try decoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
