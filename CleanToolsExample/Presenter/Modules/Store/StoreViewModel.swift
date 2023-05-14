import Foundation
import Domain
import Data
import CleanTools

protocol StoreViewModelDelegate: ViewModelDelegateProtocol {
    
    func doAction(_ action: StoreViewModel.Action)
    
}

final class StoreViewModel {
    
    weak var delegate: (any StoreViewModelDelegate)?
    
    private let provider: StoreProductsRequests
    
    init(_ provider: StoreProductsRequests = SampleApiProductsRequets()) {
        self.provider = provider
    }
    
    /// Call when controller has loaded it's view hierarchy into memory
    @MainActor
    func viewDidLoad() async {
        do {
            self.delegate?.doAction(.showLoadingView())
            let storeProducts = try await provider.products()
            let storeCellsData = storeProducts.map { StoreCellViewModel.Model($0) }
            
            self.delegate?.doAction(.showLoadingView(false))
            self.delegate?.doAction(.reloadTableView(storeCellsData))
        } catch {
            self.delegate?.doAction(.showLoadingView(false))
            self.delegate?.doAction(.show(.friendlyError))
        }
    }
    
    func didPressCheckout(_ storeItems: ContiguousArray<CellDataProtocol>) async {
        //Checkout view expect CartItems
        //So we cast all CellDataProtocol with amount > 0 to CartItem
        var checkoutItems = ContiguousArray<CartItem>()
        
        for storeItem in storeItems {
            switch storeItem {
                
            case let storeCellData as StoreCellViewModel.Model:
                await addCheckOutItem(storeCellData.cartItem, to: &checkoutItems)
                
            default:
                //TODO: report error
                break
            }
        }
        let sendableCheckoutItems = checkoutItems
        await MainActor.run {
            //isEmpty is more performance than count > 0
            guard !sendableCheckoutItems.isEmpty else {
                delegate?.doAction(.show(.emptyCart))
                return
            }
            
            delegate?.doAction(.goTo(.checkout(sendableCheckoutItems)))
        }
    }

}

// MARK: - Private

extension StoreViewModel {

    private func addCheckOutItem(_ cartItem: CartItem,
                                 to checkOutItems: inout ContiguousArray<CartItem>) async {
        guard await cartItem.amount > 0 else {
            return
        }
        checkOutItems.append(cartItem)
    }
    
}

// MARK: - Helping structures

extension StoreViewModel {
    
    enum Action {
        case reloadTableView([CellDataProtocol])
        case show(Alert)
        case goTo(View)
        case showLoadingView(Bool = true)
        
        enum Alert {
            case friendlyError
            case emptyCart
        }
        
        enum View {
            case checkout(ContiguousArray<CartItem>)
        }
        
    }
    
}
