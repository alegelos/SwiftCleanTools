import Foundation
import Domain


extension Domain.StoreProduct {
    
    convenience init(_ withProduct: SampleDataApiStoreProduct)  {
        self.init(code: withProduct.code,
                  name: withProduct.name,
                  price: withProduct.price)
    }
    
}



