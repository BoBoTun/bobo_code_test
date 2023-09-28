
import UIKit

enum Direction {
    case leftToRight
    case rightToLeft
    case topToBottom
    case bottomToTop
}

enum iOSDeviceSizes {
    case tabletSize
    case miniSize
    case plusSize
    case maxSize
    
    func getBool() -> Bool {
        switch self {
        case .miniSize:
            return UIDevice.is_iPhoneMiniDevices()
        case .tabletSize:
            return UIDevice.is_iPadDevice()
        case .plusSize:
            return UIDevice.is_iPhonePlusDevices()
        case .maxSize:
            return UIDevice.is_iPhoneMaxDevices()
        }
    }
}

enum DragDirection {
    case Up
    case Down
}

// Error Type
enum ErrorType: Error {
    case NoInterntError
    case NoDataError
    case SeverError
    case KnownError(_ errorMessage: String)
    case UnKnownError
    case TokenExpireError(_ code : Int)
}

public enum NetworkError: Error {
    case badInput
    case noData
    case forbidden
    case notAuthorized
    case severError
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .badInput:
            return NSLocalizedString("Bad input", comment: "")
        case .noData:
            return NSLocalizedString("No data", comment: "")
        case .forbidden:
            return NSLocalizedString("Forbiddden", comment: "")
        case .notAuthorized:
            return NSLocalizedString("Not authorized", comment: "")
        case .severError:
            return NSLocalizedString("Server Error", comment: "")
        }
    }
}

enum ServiceError: Error {
    case url(URLError)
    case urlRequest
    case decode
}

enum LanguageType: String {
    case english = "en"
    case burmese = "my-MM"
    case chinese = "zh-Hans"
    
    func getIcons() -> UIImage {
        switch self {
        case .english:
            return UIImage(named: "ic_flag_english")!
        case .burmese:
            return UIImage(named: "ic_flag_myanmar")!
        case .chinese:
            return UIImage(named: "ic_flag_china")!
        }
    }
    
    func getTitle() -> String {
        switch self {
        case .english:
            return "English"
        case .burmese:
            return "Myanmar"
        case .chinese:
            return "Chinese"
        }
    }
    
    func getContentLanguage() -> String {
        switch self {
        case .english :
            return "en-US"
        case .burmese :
            return "mm"
        case .chinese:
            return "zh"
        }
    }
}

enum TextFieldType {
    case email
    case password
    
    func getTitle() -> String {
        switch self {
        case .email:
            return "Email"
        case .password:
            return "Password"
        }
    }
    
    func getPlaceholder() -> String {
        switch self {
        case .email:
            return "Enter Email"
        case .password:
            return "Enter Password"
        }
    }
    
    func isSecureTextField() -> Bool {
        switch self {
        case .password :
            return true
        default:
            return false
        }
    }
}

enum FilterKey : String{

    case status = "status"
    
    func getString() -> String {
        return rawValue
    }
}
