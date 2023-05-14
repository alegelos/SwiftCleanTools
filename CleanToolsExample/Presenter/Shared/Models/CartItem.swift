import Foundation
import Domain

final actor CartItem {
    
    /// Modify heap values, not the stack referece.
    nonisolated let storeProduct: StoreProduct
    private(set) var amount: Int
    
    init(storeProduct: StoreProduct, amount: Int) {
        self.storeProduct = storeProduct
        self.amount = amount
    }
    
    @discardableResult
    func increaseAmount() -> Int {
        amount += 1
        return amount
    }
    
    //Mainly reason why I'm an Actor 🎭 🔂
    @discardableResult
    func decreaseAmount() -> Int {
        guard amount > .zero else {
            return .zero
        }
        amount -= 1
        return amount
    }
    
}

// MARK: - Hashable

extension CartItem: Hashable {
    
    nonisolated var hashValue: Int {
        get {
            var hasher = Hasher()
            hash(into: &hasher)
            return hasher.finalize()
        }
    }
    
    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(storeProduct.code)
    }
    
}

// MARK: - Equatable

extension CartItem: Equatable {
    
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.storeProduct.code == rhs.storeProduct.code
    }
    
}
