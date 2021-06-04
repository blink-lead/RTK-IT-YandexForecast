import UIKit

final class WeatherScreenWireframe: BaseWireframe {
    
    // MARK: - Private properties -
    
    private let storyboard = UIStoryboard(name: "WeatherScreen", bundle: nil)
    private weak var presenter: WeatherScreenPresenterInterface!
    
    // MARK: - Module setup -
    
    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: WeatherScreenViewController.self)
        super.init(viewController: moduleViewController)
        
        let interactor = WeatherScreenInteractor()
        let presenter = WeatherScreenPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
        self.presenter = moduleViewController.presenter
    }
}

// MARK: - Extensions -

extension WeatherScreenWireframe: WeatherScreenWireframeInterface {
    
    func setModel(with model: WeatherModel) {
        presenter.configurator(with: model)
    }
    
    func setRoot() {
        navigationController?.setRootWireframe(self)
    }
    
    func navigate(to option: WeatherScreenNavigationOption) {
        switch option {
        default:
            break
        }
    }
}
