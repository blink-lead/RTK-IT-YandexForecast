import UIKit

final class WeatherScreenPresenter {
    
    // MARK: - Private properties -
    
    private unowned let view: WeatherScreenViewInterface
    private let interactor: WeatherScreenInteractorInterface
    private let wireframe: WeatherScreenWireframeInterface
    
    // MARK: - Lifecycle -
    
    init(view: WeatherScreenViewInterface, interactor: WeatherScreenInteractorInterface, wireframe: WeatherScreenWireframeInterface) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension WeatherScreenPresenter: WeatherScreenPresenterInterface {
    
    // MARK: - Lifecycle -
    
    func viewDidLoad() {
        view.setupView()
        wireframe.setRoot()
        interactor.forecastDate({ text in
            self.view.titleSetup(text: text)
        })
        tableViewInit()
        forecastInit()
    }
    
    // MARK: - Table View -
    
    func cellHeight(at indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        default:
            return 44.0
        }
    }
    
    func cellContent(at indexPath: IndexPath, _ completion: @escaping ((TableViewCellContent) -> Void)) {
        interactor.cellContent(at: indexPath, { completion($0) })
    }
    
    func titleHeader(in section: Int) -> String? {
        switch section {
        case 0:
            return "СЕЙЧАС"
        default:
            return nil
        }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0:
            return interactor.numberOfCell()
        default:
            return 0
        }
    }
    
    func numberOfItems(in section: Int) -> Int {
        switch section {
        case 0:
            return interactor.numberOfItems()
        default:
            return 0
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
    func configurator(with model: WeatherModel) {
        interactor.config(with: model)
    }
    
    fileprivate func tableViewInit() {
        let tableView = WeatherScreenTableView(.zero, .insetGrouped)
        tableView.register(Cell.nib, forCellReuseIdentifier: Cell.id)
        // tableView.alwaysBounceVertical = false
        // tableView.alwaysBounceHorizontal = false
        view.tableViewSetup(with: tableView)
    }
    
    // MARK: - Header: Collection View -
    
    func forecastCell(at indexPath: IndexPath, _ completion: @escaping ((ForecastTodayContent) -> ())) {
        interactor.forecast(at: indexPath, { completion($0) })
    }
    
    func sizeForItem(in bounds: CGRect) -> CGSize {
        let value = bounds.height * 0.8
        return CGSize(width: value * 2, height: value)
    }
    
    func insetForSection(at section: Int) -> UIEdgeInsets {
        switch section {
        case 0:
            return .init(top: 0, left: 16, bottom: 0, right: 16)
        default:
            return .zero
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        print(#function, indexPath)
    }
    
    fileprivate func forecastInit() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = .zero
        let header = ForecastTodayCollectionView(.zero, layout)
        header.register(ForecastCell.nib, forCellWithReuseIdentifier: ForecastCell.id)
        header.showsVerticalScrollIndicator = false
        header.showsHorizontalScrollIndicator = false
        header.backgroundColor = .clear
        view.tableViewHeader(with: header)
    }
}
