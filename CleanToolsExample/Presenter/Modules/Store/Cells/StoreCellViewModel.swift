import Foundation
import Domain
import CleanTools

protocol StoreCellViewModelDelegate: ViewModelDelegateProtocol {
    
    func update(field: StoreCellViewModel.Field)
    
}

final class StoreCellViewModel {
    
    weak var delegate: (any StoreCellViewModelDelegate)?
    
    private var cartItem: CartItem?
    
    func assign(cellData: CellDataProtocol) async {
        guard let cellData = cellData as? Model else {
            //TODO: report error
            return
        }
        
        cartItem = cellData.cartItem
        
        let title = cellData.cartItem.storeProduct.name
        let price = cellData.cartItem.storeProduct.price
        let stringPrice = String(format: "%.2f", price) + " €"
        let amount = await "\(cellData.cartItem.amount)"
        
        await MainActor.run {
            self.delegate?.update(field: .title(title))
            self.delegate?.update(field: .price(stringPrice))
            self.delegate?.update(field: .amount(amount))
        }
    }
    
    func didPressRemoveItem() async {
        guard let cartItem = cartItem else {
            //TODO: report error
            return
        }
        let newAmount = await cartItem.decreaseAmount()
        let stringAmount = String(newAmount)
        
        await MainActor.run {
            self.delegate?.update(field: .amount(stringAmount))
        }
    }
    
    func didPressAddItem() async {
        guard let cartItem = cartItem else {
            //TODO: report error
            return
        }
        let newAmount = await cartItem.increaseAmount()
        let stringAmount = String(newAmount)
        
        await MainActor.run {
            self.delegate?.update(field: .amount(stringAmount))
        }
    }
    
}

// MARK: - Helping Structures

extension StoreCellViewModel {
    
    enum Field {
        case title(String)
        case price(String)
        case amount(String)
    }
    
    final class Model: CellDataProtocol {
        
        var cellIdentifier: String {
            String(describing: StoreCell.self)
        }
        
        let cartItem: CartItem
        
        init(_ product: StoreProduct) {
            cartItem = CartItem(storeProduct: product, amount: .zero)
        }
        
    }
    
}
