import UIKit.UIColor

public func Color(_ name: String) -> UIColor {
    return UIColor(named: name) ?? UIColor.red
}
