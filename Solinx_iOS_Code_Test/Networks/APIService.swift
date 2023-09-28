
import Foundation
import Combine

protocol APIServiceProtocol {
    func requestCombine(url : String,
             method : APIMethod,
             parameters : [String : Any],
             headers : [String : String]) -> AnyPublisher<Data, APIError>
}

final class APIService: APIServiceProtocol {
    
    static let shared = APIService()
    
    func requestCombine(url : String,
             method : APIMethod = .get,
             parameters : [String : Any] = [:],
             headers : [String : String] = [:]) -> AnyPublisher<Data, APIError> {
        
        if !InternetConnectionManager.isInternetAvailable() {
            return Fail(error: .noNetwork)
                .eraseToAnyPublisher()
        }
        
        var dataTask: URLSessionDataTask?
        
        let onSubscription: (Subscription) -> Void = { _ in dataTask?.resume() }
        let onCancel: () -> Void = { dataTask?.cancel() }

        return Future<Data, APIError> { [weak self] promise in
            if let escapedURLString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                guard let urlRequest = self?.getUrlRequest(url: escapedURLString, parameters: parameters, method: method, headers: headers) else {
                    promise(.failure(APIError.invalidURL))
                    return
                }
                
                dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                    
                    guard let data = data else {
                        if let error = error as? APIError {
                            promise(.failure(error))
                        }
                        return
                    }
                    if let error = error as? APIError {
                        
                        promise(.failure(error))
                    }
                    promise(.success(data as Any as! Data))
                }
            }
            
            
            
        }
        .handleEvents(receiveSubscription: onSubscription, receiveCancel: onCancel)
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    func getUrlRequest(url : String,
                       parameters : [String : Any] = [:] ,
                       method : APIMethod = .get,
                       headers : [String : String] = [:]) -> URLRequest? {
        
       var components = URLComponents()
       components.scheme = "https"
        components.host = APIConfig.baseUrl
        components.path = url
        
        if parameters.isEmpty == false {
            components.queryItems = [URLQueryItem(name: "", value: "")]
        }
        
        guard let url1 = components.url else { return nil }
        
        var urlRequest = URLRequest(url: url1)
        urlRequest.timeoutInterval = 10.0
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("15100", forHTTPHeaderField: "Api-Version")
        let username = "z-w@kaU$eR"
        let password = "87f73hHL93G!@773it4"
        let loginString = "\(username):\(password)"
        let loginData = loginString.data(using: String.Encoding.utf8)
        urlRequest.setValue("staging.z-waka.com", forHTTPHeaderField: "Host")
        let base64LoginString = loginData?.base64EncodedString()
        urlRequest.setValue("Basic \(base64LoginString ?? "")", forHTTPHeaderField: "Authorization")
        urlRequest.setValue(LocalizationManager.sharedInstance.getLocale().getContentLanguage(), forHTTPHeaderField: "Accept-Language")
        if UserDefaultModel.shared.isUserLoggedIn() {
            urlRequest.setValue(UserDefaultModel.shared.getAuthToken(), forHTTPHeaderField: "Auth-Token")
            urlRequest.setValue("accepted", forHTTPHeaderField: "Connection-Status")
            urlRequest.setValue("doctor", forHTTPHeaderField: "User-Type")
        } else {
            urlRequest.setValue("pwd", forHTTPHeaderField: "Security-Type")
        }
        
        return urlRequest
    }
}
