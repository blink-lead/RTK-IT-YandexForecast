import Foundation
import UIKit

extension UIViewController {
    func presentWireframe(_ wireframe: BaseWireframe, animated: Bool = true, completion: (()->())? = nil) {
        present(wireframe.viewController, animated: animated, completion: completion)
    }
}
