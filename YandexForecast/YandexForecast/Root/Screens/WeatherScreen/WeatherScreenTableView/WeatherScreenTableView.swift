import UIKit

class WeatherScreenTableView: UITableView {
    
    convenience init(_ frame: CGRect, _ style: UITableView.Style) {
        self.init(frame: frame, style: style)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
