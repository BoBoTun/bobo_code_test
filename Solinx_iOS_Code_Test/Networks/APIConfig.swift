
import Foundation
import UIKit

struct APIConfig {
    
    #if DEBUG
    
    static private let url = "staging.z-waka.com"
    
    #else
    
    static private let url = "staging.z-waka.com"
    
    #endif

    static var baseUrl: String {
        return  url
    }

}

extension APIConfig {
    enum Login {
        case tryToLogin
        
        func urlString() -> String{
            return "/api/v2/doctor_account.sign_in_email"
        }
    }
    
    enum ConnectionList {
        case getConnectionList
        
        func urlString() -> String{
            return "/api/v2/doctor.get_connection_list"
        }
    }
}
