import Foundation

class API: NetworkService {
    
    private lazy var urlComponents: URLComponents = {
        let comp = NSURLComponents()
        comp.scheme = "https"
        comp.host = "api.weather.yandex.ru"
        return comp as URLComponents
    }()
    
    private var baseURL: URL {
        return urlComponents.url!
    }
    
    // X-Yandex-API-Key
    private let APIKey = ""; #warning("DON'T FORGET TO ENTER YOUR APIKEY!")
    
    func weatherData(for location: Location, _ completion: @escaping ((Result<Data,Error>)->Void)) {
        let lat = location.lat, lon = location.lon
        var comp = urlComponents
        comp.path = "/v2/forecast"
        comp.queryItems = [
            .init(name: "lat", value: "\(lat)"),
            .init(name: "lon", value: "\(lon)"),
            .init(name: "lang", value: "ru_RU"),
            .init(name: "extra", value: "true")
        ]
        
        let request = NSMutableURLRequest(url: comp.url!)
        request.httpMethod = HTTPMethod.get
        request.networkServiceType = .default
        request.cachePolicy = .returnCacheDataElseLoad
        request.timeoutInterval = 60
        
        // Request headers
        let headers: [String:String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "X-Yandex-API-Key": APIKey,
            "Cache-Control": "max-age=7200, must-revalidate, private"
        ]
        request.allHTTPHeaderFields = headers
        load(request, { result in
            do {
                guard let data = try result.get() else { return }
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
        })
    }
}
