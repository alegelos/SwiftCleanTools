import Foundation
import Moya
import Domain
import CleanTools

public final class SampleApiProductsRequets {
    
    private let provider: MoyaProvider<SampleDataApi>
    
    public init(provider: MoyaProvider<SampleDataApi> = MoyaProvider<SampleDataApi>()) {
        
        switch ProcessInfo.processInfo.launchArgument {
            
        case .uiTestSampleData:
            let provider = MoyaProvider<SampleDataApi>(stubClosure: MoyaProvider.immediatelyStub)
            self.provider = provider
            
        case .none, .uiTestStagingData:
            self.provider = provider
        }
    }
    
}

// MARK: - StoreProductsRequests

extension SampleApiProductsRequets: StoreProductsRequests {
    
    public func products() async throws -> ContiguousArray<Domain.StoreProduct> {
        return try await withCheckedThrowingContinuation { continuation in
            provider.request(.products) { result in
                switch result {
                case .failure(let error):
                    //TODO: report error
                    continuation.resume(throwing: error)
                case .success(let response):
                    do {
                        let dataProducts = try response.map(SampleDataApiProductsResponse.self).products
                        let products = dataProducts.mapContiguousArray({ StoreProduct($0) })
                        continuation.resume(returning: products)
                    } catch {
                        //TODO: report error
                        continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
}
