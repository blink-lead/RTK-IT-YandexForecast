import UIKit

enum WeatherScreenNavigationOption {
    // case details()
}

protocol WeatherScreenWireframeInterface: WireframeInterface {
    func setModel(with model: WeatherModel)
    func setRoot()
    func navigate(to option: WeatherScreenNavigationOption)
}

protocol WeatherScreenViewInterface: ViewInterface {
    func setupView()
    func titleSetup(text: String)
    func tableViewSetup(with tableView: WeatherScreenTableView)
    func tableViewReloadData()
    func tableViewHeader(with collectionView: ForecastTodayCollectionView)
}

protocol WeatherScreenPresenterInterface: PresenterInterface {
    func viewDidLoad()
    func configurator(with model: WeatherModel)
    
    // MARK: Table View
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func titleHeader(in section: Int) -> String?
    func cellContent(at indexPath: IndexPath, _ completion: @escaping ((TableViewCellContent)->()))
    func cellHeight(at indexPath: IndexPath) -> CGFloat
    func didSelectRow(at indexPath: IndexPath)
    
    // MARK: Collection View
    func forecastCell(at indexPath: IndexPath, _ completion: @escaping ((ForecastTodayContent)->()))
    func numberOfItems(in section: Int) -> Int
    func sizeForItem(in bounds: CGRect) -> CGSize
    func insetForSection(at section: Int) -> UIEdgeInsets
    func didSelectItem(at indexPath: IndexPath)
}

protocol WeatherScreenInteractorInterface: InteractorInterface {
    func config(with model: WeatherModel)
    func forecastTime(now date_ts: Double?, _ completion: @escaping ((String)->()))
    func forecastDate(_ completion: @escaping ((String)->()))
    func cellContent(at indexPath: IndexPath, _ completion: @escaping ((TableViewCellContent)->()))
    func numberOfCell() -> Int
    func forecast(at indexPath: IndexPath, _ completion: @escaping ((ForecastTodayContent)->()))
    func numberOfItems() -> Int
}
