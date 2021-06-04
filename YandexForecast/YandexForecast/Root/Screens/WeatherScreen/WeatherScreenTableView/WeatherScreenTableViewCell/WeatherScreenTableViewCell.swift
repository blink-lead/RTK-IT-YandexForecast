import UIKit

typealias Cell = WeatherScreenTableViewCell

class WeatherScreenTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    func configure(with content: TableViewCellContent) {
        titleLabel.text = content.name
        valueLabel.text = content.value
        iconImageView.image = content.image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
