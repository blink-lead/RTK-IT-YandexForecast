import Foundation
import UIKit

final class WeatherScreenInteractor {
    
    private var model: WeatherModel?
    
    func cellContent(at indexPath: IndexPath, _ completion: @escaping ((TableViewCellContent)->())) {
        let cases = TableViewCases.allCases
        guard indexPath.row < cases.count, let fact = model?.fact else { return }
        let item = cases[indexPath.row]
        typealias Content = TableViewCellContent
        switch indexPath.row {
        case 0:
            guard let temp = fact.temp else { return }
            let content = Content(name: item.description,
                                  value: "\(temp)°C",
                                  image: item.image)
            completion(content)
        case 1:
            guard let val = fact.feelsLike else { return }
            let content = Content(name: item.description,
                                  value: "\(val)°C",
                                  image: item.image)
            completion(content)
        case 2:
            guard let val = fact.windSpeed else { return }
            let content = Content(name: item.description,
                                  value: "\(val) м/с",
                                  image: item.image)
            completion(content)
        case 3:
            guard let val = fact.pressureMm else { return }
            let content = Content(name: item.description,
                                  value: "\(val) мм",
                                  image: item.image)
            completion(content)
        case 4:
            guard let val = fact.humidity else { return }
            let content = Content(name: item.description,
                                  value: "\(val)%",
                                  image: item.image)
            completion(content)
        case 5:
            guard let val = model?.now else { return }
            forecastTime(now: val, { (time) -> (Void) in
                let content = Content(name: item.description,
                                      value: time,
                                      image: item.image)
                completion(content)
            })
        default: break
        }
    }
    
    func forecast(at indexPath: IndexPath, _ completion: @escaping ((ForecastTodayContent)->())) {
        let cases = ForecastCases.allCases
        guard indexPath.row < cases.count, let parts = model?.forecasts?.first?.parts else { return }
        func extractedFunc(_ temps: (Double,Double), _ feelsLike: Double) {
            let item = cases[indexPath.row]
            let content = ForecastTodayContent(part: item.description,
                                               temp: "\(temps.0)° – \(temps.1)°",
                                               feelsLike: "Ощущается \(feelsLike)°",
                                               image: item.image)
            completion(content)
        }
        switch indexPath.row {
        case 0:
            guard let part = parts.night else { return }
            extractedFunc((part.tempMin!,part.tempMax!), part.feelsLike!)
        case 1:
            guard let part = parts.morning else { return }
            extractedFunc((part.tempMin!,part.tempMax!), part.feelsLike!)
        case 2:
            guard let part = parts.day else { return }
            extractedFunc((part.tempMin!,part.tempMax!), part.feelsLike!)
        case 3:
            guard let part = parts.evening else { return }
            extractedFunc((part.tempMin!,part.tempMax!), part.feelsLike!)
        default: break
        }
    }
}

extension WeatherScreenInteractor {
    
    private enum TableViewCases: CaseIterable, CustomStringConvertible {
        case temp
        case feelsLike
        case windSpeed
        case pressureMm
        case humidity
        case time
        var description: String {
            switch self {
            case .temp: return "Температура"
            case .feelsLike: return "Ощущается как"
            case .windSpeed: return "Скорость ветра"
            case .pressureMm: return "Давление"
            case .humidity: return "Влажность"
            case .time: return "Время"
            }
        }
        var image: UIImage {
            switch self {
            case .temp: return #imageLiteral(resourceName: "temp")
            case .feelsLike: return #imageLiteral(resourceName: "temp")
            case .windSpeed: return #imageLiteral(resourceName: "wind_speed")
            case .pressureMm: return #imageLiteral(resourceName: "pressure_mm")
            case .humidity: return #imageLiteral(resourceName: "humidity")
            case .time: return #imageLiteral(resourceName: "time")
            }
        }
    }
    
    // MARK: Forecast
    
    private enum ForecastCases: CaseIterable, CustomStringConvertible {
        case night
        case morning
        case day
        case evening
        var description: String {
            switch self {
            case .night: return "Ночь"
            case .morning: return "Утро"
            case .day: return "День"
            case .evening: return "Вечер"
            }
        }
        var image: UIImage {
            switch self {
            case .night: return #imageLiteral(resourceName: "night")
            case .morning: return #imageLiteral(resourceName: "morning")
            case .day: return #imageLiteral(resourceName: "day")
            case .evening: return #imageLiteral(resourceName: "evening")
            }
        }
    }
}

// MARK: - Extensions -

extension WeatherScreenInteractor: WeatherScreenInteractorInterface {
    
    func config(with model: WeatherModel) {
        self.model = model
    }
    
    // MARK: - TABLE VIEW
    
    func numberOfCell() -> Int {
        return TableViewCases.allCases.count
    }
    
    // MARK: - TABLE VIEW HEADER: COLLECTION VIEW
    
    func numberOfItems() -> Int {
        return ForecastCases.allCases.count
    }
    
    // MARK: - TIME CONVERSION
    
    func forecastTime(now date_ts: Double?, _ completion: @escaping ((String)->())) {
        guard let time = date_ts else { return }
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let timeStr = formatter.string(from: date)
        completion(timeStr)
    }
    
    func forecastDate(_ completion: @escaping ((String) -> ())) {
        guard let time = model?.now else { return }
        let date = Date(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM"
        let dateStr = formatter.string(from: date)
        let result = "Погода на \(dateStr)"
        completion(result)
    }
}
