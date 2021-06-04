import Foundation
import UIKit.UIView

public extension UIView {
    static var id: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: id, bundle: nil) }
}
