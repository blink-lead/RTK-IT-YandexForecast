import UIKit

typealias ForecastCell = ForecastTodayCollectionViewCell

class ForecastTodayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var timeOfDayLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var feelsLikeLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    func configure(with forecast: ForecastTodayContent) {
        partLabel(with: forecast.part)
        tempLabel(with: forecast.temp)
        feelsLikeLabel(with: forecast.feelsLike)
        imageSetup(with: forecast.image)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cornersAndShadow()
    }
}

extension ForecastTodayCollectionViewCell {
    fileprivate func partLabel(with text: String?) {
        timeOfDayLabel.text = text
        timeOfDayLabel.font = .systemFont(ofSize: bounds.height / 5, weight: .medium)
    }
    
    fileprivate func tempLabel(with text: String?) {
        tempLabel.text = text
        tempLabel.font = .systemFont(ofSize: bounds.height / 6)
        tempLabel.textColor = .systemGray2
    }
    
    fileprivate func feelsLikeLabel(with text: String?) {
        feelsLikeLabel.text = text
        feelsLikeLabel.font = .systemFont(ofSize: bounds.height / 8)
        feelsLikeLabel.textColor = .systemGray
    }
    
    fileprivate func imageSetup(with image: UIImage?) {
        iconImageView.image = image
    }
    
    fileprivate func cornersAndShadow() {
        let cornerRadius: CGFloat = 15.0
        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true
        layer.masksToBounds = false
        layer.shadowOffset = .zero
        layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = cornerRadius / 2
        layer.shouldRasterize = true
    }
}
