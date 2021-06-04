import UIKit

class ForecastTodayCollectionView: UICollectionView {
    
    convenience init(_ frame: CGRect, _ layout: UICollectionViewLayout) {
        self.init(frame: frame, collectionViewLayout: layout)
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
