import Foundation
import UIKit

public extension UIViewController {
    static var storyboard: Self? {
        let identifier = String(describing: self)
        let storyboardName = identifier.replacingOccurrences(of: "ViewController", with: "")
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller as? Self
    }
}
