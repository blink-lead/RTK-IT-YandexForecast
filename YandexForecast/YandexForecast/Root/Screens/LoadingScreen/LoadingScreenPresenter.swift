import UIKit

final class LoadingScreenPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: LoadingScreenViewInterface
    private let interactor: LoadingScreenInteractorInterface
    private let wireframe: LoadingScreenWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(view: LoadingScreenViewInterface, interactor: LoadingScreenInteractorInterface, wireframe: LoadingScreenWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension LoadingScreenPresenter: LoadingScreenPresenterInterface {
    
    func viewDidLoad() {
        view.setupView()
        view.showIndicator()
        loader()
    }
    
    fileprivate func loader() {
        let dispatchGroup = DispatchGroup()
        let semaphore = DispatchSemaphore(value: 0)
        dispatchGroup.enter()
        interactor.loadWeater({ (result) -> (Void) in
            do {
                let model = try result.get()
                self.wireframe.config(with: model)
                _ = semaphore.wait(timeout: .now() + 1)
                dispatchGroup.leave()
            } catch {
                print("loadWeater_error:", error.localizedDescription)
            }
        })
        dispatchGroup.notify(queue: .main) {
            self.wireframe.navigate(to: .weather) // main thread
        }
    }
}
