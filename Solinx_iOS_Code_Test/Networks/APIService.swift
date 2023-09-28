
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
        guard let requestUrl = URL(string: url) else {return nil}
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.timeoutInterval = 10.0
        urlRequest.httpMethod = method.rawValue
        return urlRequest
    }
}
