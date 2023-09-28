
import Foundation
import Combine

final class AuthenticationModel : BaseViewModel {

//    let accountResultPublisher = CurrentValueSubject<Account_resultVO?,Never>(nil)
//    let model = LoginDataProvider.shared
    let model = UserModel.shared
    deinit{
        
    }
}

extension AuthenticationModel {
    
    func tryToRegister(name: String, password : String) {
        loadingPublishSubject.send(true)
        
        model.saveUserToDB(userRo: UserRo(id: model.getAutoIncrementID(), name: name, password: password))
    }

    func getAllUser(){
        model.retrieveUser(condition: "")
    }
    func tryToLogin(name : String ,security_code : String ) {
        loadingPublishSubject.send(true)
        /*
        model.tryToLogin(email: email, security_code: security_code).sink(receiveCompletion: {[unowned self] in
            loadingPublishSubject.send(false)
            guard case .failure(let error) = $0 else {return}
            errorPublishSubject.send(error)
        }) { [unowned self] response in
            accountResultPublisher.send(response)
            loadingPublishSubject.send(false)
        }.store(in: &bindings)
         */
    }
}
