import Foundation

protocol NetworkServiceable {
    typealias ExpectedResult = ((Result<Data?,Error>) -> ())
    func load(_ config: Any?, _ completion: @escaping ExpectedResult)
    func post(_ urlStr: String?, _ body: [String:Any], _ completion: @escaping ExpectedResult)
}

class NetworkService: NSObject, NetworkServiceable, URLSessionDelegate {
    
    enum HTTPMethod {
        static let post = "POST"
        static let get = "GET"
    }
    
    private lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.urlCache = urlCache
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    func load(_ config: Any?, _ completion: @escaping ExpectedResult) {
        let defaults = UserDefaults.standard
        let timestamp = Int(Date().timeIntervalSince1970) // время на момент запроса (В СЕКУНДАХ!)
        
        var task: URLSessionDataTask!
        
        switch config {
        case let urlStr as String:
            guard let url = URL(string: urlStr.urlEscaped) else {
                completion(.failure(URLError(.badURL))); return
            }
            task = session.dataTask(with: url, completionHandler: { handler($0,$1,$2) })
        case let url as URL:
            task = session.dataTask(with: url, completionHandler: { handler($0,$1,$2) })
        case let request as URLRequest:
            // если (время на момент запроса минус 2 часа) МЕНЬШЕ времени сохраненого в памяти (изначально 0),
            // то извлекаем данные из кеша, ИНАЧЕ загружаем новые данные и кэшируем их с пометкой времени
            if (timestamp - 7200) < defaults.integer(forKey: "timestamp") {
                guard let cached = urlCache.cachedResponse(for: request) else { return }
                handler(cached.data, cached.response, nil) // OK
                print("Cached data!")
            } else {
                defaults.set(timestamp, forKey: "timestamp")
                task = session.dataTask(with: request, completionHandler: { data, response, error in
                    if error == nil, let data = data, let resp = response {
                        let cachedURLResponse = CachedURLResponse(response: resp, data: data, storagePolicy: .allowed)
                        urlCache.storeCachedResponse(cachedURLResponse, for: request) // OK
                    }
                    handler(data,response,error) // OK
                })
                print("Load data...")
            }
        default:
            fatalError("Unknown config value!")
        }
        
        func handler(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
            if let error = error {
                self.handleClientError(error)
                completion(.failure(error))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                self.handleServerError(response)
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task?.resume()
    }
    
    func post(_ urlStr: String?, _ body: [String : Any], _ completion: @escaping ExpectedResult) {
        // configure when using
    }
}

private extension NetworkService {
    func handleServerError(_ response: URLResponse?) {
        guard let response = response else {
            print("\n! \(#function) -> value: \(String(describing: response))\n")
            return
        }
        print("\n! \(#function) -> response: \(response)\n")
    }
    
    func handleClientError(_ error: Error) {
        print("\n! \(#function) -> error: \(error)\n")
    }
}
