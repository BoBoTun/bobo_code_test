
import Foundation

struct APIRequest {

    enum ParamKey : String {
        
        case email = "email"
        case security_code = "security_code"
        
        func getKey() -> String {
            return rawValue
        }
    }
    
    enum Login {
        case tryToLogin(_ email: String, _ security_code: String)
        
        func getParams() -> [String : Any] {
            switch self {
            case .tryToLogin(let email , let security_code):
                return [
                    APIRequest.ParamKey.email.getKey() : email as Any,
                    APIRequest.ParamKey.security_code.getKey() : security_code as Any
                ]
            }
        }
    }
}
