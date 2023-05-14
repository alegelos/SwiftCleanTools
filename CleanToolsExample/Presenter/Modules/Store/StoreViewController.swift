import UIKit
import Domain
import CleanTools

final class StoreViewController: UIViewController {
    
    @IBOutlet weak var storeTableView: UITableView!
    
    private let viewModel: StoreViewModel
    private var storeItems = ContiguousArray<CellDataProtocol>() // All store items
    private weak var loadingView: LoadingView?
    
    // MARK: - Inits
    
    static func storyboardInit(viewModel: StoreViewModel = StoreViewModel())
    -> StoreViewController {
        let identifier = String(describing: Self.self)
        let storyboard = UIStoryboard.init(name: identifier, bundle: nil)
        let storeVC = storyboard.instantiateViewController(
            identifier: identifier,
            creator: { coder in
                StoreViewController(coder: coder,
                                    viewModel: viewModel)
            })
        return storeVC
    }
    
    init?(coder: NSCoder,
          viewModel: StoreViewModel) {
        self.viewModel = viewModel
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init with storyboardInit(viewModel: StoreViewModel)")
    }
    
    // MARK: - View Events
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //First setup UI
        setupView()
        //Then trigger funtionality
        Task {
            await viewModel.viewDidLoad()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension StoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        //TODO: show item details
        //viewModel.didSelectRowAt(indexPath)
    }
    
}

// MARK: - UITableViewDataSource

extension StoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        storeItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = storeItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellData.cellIdentifier,
                                                 for: indexPath)
        guard let cell = cell as? TableViewCellProtocol else {
            //TODO: report error
            return UITableViewCell()
        }
        cell.configure(with: cellData, delegate: self)
        
        return cell
    }
}

// MARK: - StoreViewModelDelegate

extension StoreViewController: StoreViewModelDelegate {
    
    typealias Action = StoreViewModel.Action
    
    func doAction(_ action: Action) {
        switch action {

        case .show(let alert):
            handleShow(alert)

        case .goTo(let view):
            handleGoTo(view)

        case .showLoadingView(let show):
            switch show {
            case true:
                loadingView = try? showLoadingView()
            case false:
                hideLoadingView(loadingView)
            }

        case .reloadTableView(let updatedStoreItems):
            storeItems = ContiguousArray(updatedStoreItems)
            storeTableView.reloadData()
        }
    }

}

// MARK: - Private

extension StoreViewController {

    private func setupView() {
        //First setup UI
        title = NSLocalizedString("store_view_title", comment: "")
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
        addCheckoutButton()
        
        //Then trigger functionality
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        storeTableView.registerNibCell(StoreCell.self)

        storeTableView.delegate = self
        storeTableView.dataSource = self
    }
    
    private func addCheckoutButton() {
        let button = UIButton(type: .custom)
        let buttontitle = NSLocalizedString("checkout_button_title", comment: "")
        let buttonImage = UIImage(systemName: "wind.snow")
        button.setImage(buttonImage, for: .normal)
        button.setTitle(buttontitle, for: .normal)
        button.addTarget(self, action: #selector(didPressCheckout), for: .touchUpInside)

        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc private func didPressCheckout() {
        Task {
            await self.viewModel.didPressCheckout(storeItems)
        }
    }
    
    private func handleGoTo(_ view: StoreViewModel.Action.View) {
        switch view {
        case .checkout:
            //Go to checkout logic
            break
        }
    }
    
    private func handleShow(_ alert: StoreViewModel.Action.Alert) {
        switch alert {
            
        case .friendlyError:
            presentFriendlyErrorAlert()
            
        case .emptyCart:
            let title = NSLocalizedString("empty_cart_error_alert_title", comment: "")
            let message = NSLocalizedString("empty_cart_error_alert_message", comment: "")
            presentAlert(withTitle: title, message: message)
        }
    }
    
}
