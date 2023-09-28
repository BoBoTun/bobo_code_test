
import Foundation
import UIKit

struct APIConfig {
    
    #if DEBUG
    
    static private let url = "https://www.dbooks.org"
    
    #else
    
    static private let url = "https://www.dbooks.org"
    
    #endif

    static var baseUrl: String {
        return  url
    }

}
extension APIConfig {
    enum GetBooks {
        case getBooks
        
        func urlStringWithSearchKey(searchKey : String) -> String{
            return APIConfig.baseUrl + "/api/search/" + searchKey
        }
    }
}
