import Foundation

/// Product from the store
final public class StoreProduct {
    
    /// Product code should not change and be unique
    public let code: String
    public var name: String
    public var price: Double
    
    /// Creates a store product
    /// - Parameters:
    ///   - code: unique product code
    ///   - name: product name
    ///   - price: product price
    public init(code: String,
                name: String,
                price: Double) {
        self.code = code
        self.name = name
        //The price should have only two decimal point
        self.price = Double(Int(price * 100)) / 100.0
    }
    
}
