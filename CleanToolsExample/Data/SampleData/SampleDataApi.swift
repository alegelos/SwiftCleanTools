import Foundation
import Moya

public enum SampleDataApi {
    case products
}

// MARK: - TargetType

extension SampleDataApi: TargetType {
    
    public var baseURL: URL {
        guard let baseURL = URL(string: "https://Your_base_url.com/") else {
            fatalError("Fail to get StoreServices base URL")
        }
        return baseURL
    }
    
    public var path: String {
        switch self {
        case .products: return "path/to/Products.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .products: return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .products:
            return data(fromFile: "ProductsSample", ext: "json")
        }
    }
    
    public var task: Task {
        switch self {
        case .products: return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .products:
            return ["Content-Type": "application/json"]
        }
    }
    
}

// MARK: - Private

extension SampleDataApi {
    
    private func data(fromFile file: String, ext: String) -> Data {
        guard let url = Bundle(identifier: "None.Data")?.url(forResource: file, withExtension: ext),
              let data = try? Data(contentsOf: url) else {
            //TODO: report error
            return Data()
        }
        return data
    }
    
}
