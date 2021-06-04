import Foundation

final class LoadingScreenInteractor {
    
    private let api: API!
    private let json: JSONHandler!
    
    private let locations: [Location] = [
        .init("Санкт-Петербург", lat: 59.9339, lon: 30.3061)
    ]
    
    func loadWeater(_ completion: @escaping ((Result<WeatherModel,Error>)->Void)) {
        api.weatherData(for: locations[0], { result in
            do {
                let data = try result.get() // OK
                self.json.decoder(data, completion)
            } catch {
                print("weatherData_error: \(error.localizedDescription)")
            }
        })
    }
    
    init() {
        self.api = API()
        self.json = JSONHandler()
    }
}

// MARK: - Extensions -

extension LoadingScreenInteractor: LoadingScreenInteractorInterface {
    
}
