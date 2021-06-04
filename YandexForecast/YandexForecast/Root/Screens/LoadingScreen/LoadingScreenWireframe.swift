import UIKit

final class LoadingScreenWireframe: BaseWireframe {
    
    // MARK: - Private properties -
    
    private let storyboard = UIStoryboard(name: "LoadingScreen", bundle: nil)
    
    private let weatherWireframe = WeatherScreenWireframe()
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: LoadingScreenViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = LoadingScreenInteractor()
        let presenter = LoadingScreenPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }
}

// MARK: - Extensions -

extension LoadingScreenWireframe: LoadingScreenWireframeInterface {
    func config(with model: WeatherModel) {
        weatherWireframe.setModel(with: model)
    }
    func navigate(to option: LoadingScreenNavigationOption) {
        switch option {
        case .weather:
            navigationController?.pushWireframe(weatherWireframe, animated: false)
        }
    }
}
