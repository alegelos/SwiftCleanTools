import Foundation

public protocol StoreProductsRequests: AnyObject {
    
    func products() async throws -> ContiguousArray<StoreProduct>
    
}


