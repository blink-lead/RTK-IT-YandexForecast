import UIKit

final class WeatherScreenViewController: UIViewController {
    
    // MARK: - Private properties -
    private weak var forecastCollectionView: ForecastTodayCollectionView!
    private weak var tableView: WeatherScreenTableView!
    
    // MARK: - Public properties -
    
    var presenter: WeatherScreenPresenterInterface!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewReloadData()
    }
}

// MARK: - Extensions -

extension WeatherScreenViewController: WeatherScreenViewInterface {
    
    func tableViewHeader(with collectionView: ForecastTodayCollectionView) {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        collectionView.frame.size.height = 175
        tableView.tableHeaderView = collectionView
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async { [weak tableView] in
            tableView?.reloadData()
        }
    }
    
    func setupView() {
        view.backgroundColor = Color("WeatherScreenBackground")
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func titleSetup(text: String) {
        self.title = text
    }
    
    func tableViewSetup(with tableView: WeatherScreenTableView) {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 44.0
        self.tableView = tableView
    }
}

extension WeatherScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return presenter.titleHeader(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cell.id, for: indexPath) as! Cell
        presenter.cellContent(at: indexPath) { (content) in
            cell.configure(with: content)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return tableView.rowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return presenter.cellHeight(at: indexPath)
    }
}

extension WeatherScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

// MARK: - COLLECTION VIEW -

extension WeatherScreenViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ForecastCell.id, for: indexPath) as! ForecastCell
        presenter.forecastCell(at: indexPath, { (content) in
            cell.configure(with: content)
        })
        return cell
    }
}

extension WeatherScreenViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}

extension WeatherScreenViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return presenter.sizeForItem(in: collectionView.bounds)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return presenter.insetForSection(at: section)
    }
}
