import UIKit

final class LoadingScreenViewController: UIViewController {
    
    // MARK: - Public properties -
    
    var presenter: LoadingScreenPresenterInterface!
    
    // MARK: - Private properties -
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var indicator: UIActivityIndicatorView!
    
    @IBOutlet private weak var dataProviderLabel: UILabel!
    @IBOutlet private weak var providerLogoImageView: UIImageView!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Extensions -

extension LoadingScreenViewController: LoadingScreenViewInterface {
    func setupView() {
        indicator.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func showIndicator() {
        indicator.isHidden = false
        indicator.startAnimating()
    }
}
