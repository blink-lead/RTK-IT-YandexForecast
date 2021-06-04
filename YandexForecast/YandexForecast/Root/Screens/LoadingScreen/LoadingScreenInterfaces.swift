import UIKit

enum LoadingScreenNavigationOption {
    case weather
}

protocol LoadingScreenWireframeInterface: WireframeInterface {
    func config(with model: WeatherModel)
    func navigate(to option: LoadingScreenNavigationOption)
}

protocol LoadingScreenViewInterface: ViewInterface {
    func setupView()
    func showIndicator()
}

protocol LoadingScreenPresenterInterface: PresenterInterface {
    func viewDidLoad()
}

protocol LoadingScreenInteractorInterface: InteractorInterface {
    func loadWeater(_ completion: @escaping ((Result<WeatherModel,Error>)->Void))
}
