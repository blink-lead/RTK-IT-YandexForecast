import Foundation
import UIKit

extension UIResponder {
    /// Initializes the start screen and set it to **root for UIWindow**
    static func startupScreen(for window: UIWindow?) {
        guard let window = window else { fatalError() }
        // MARK: Specify which controller to load
        let root = WeatherNavigationController()
        let wireframe = LoadingScreenWireframe()
        root.setRootWireframe(wireframe)
        window.rootViewController = root
        window.makeKeyAndVisible()
    }
}
