
import Foundation
import Combine

final class AuthenticationModel : BaseViewModel {

    let model = UserModel.shared
    let errorMessage = PassthroughSubject<String,Never>()
    let loginSuccess = PassthroughSubject<String,Never>()
    let registerSuccess = PassthroughSubject<String,Never>()
    deinit{
        
    }
}

extension AuthenticationModel {
    
    func tryToRegister(name: String, password : String) {
        loadingPublishSubject.send(true)
        let allUser = model.retrieveAllUser()
        let matchingUsers = allUser.filter { item in
            return item.name == name && item.password == password
        }
        
        if matchingUsers.first != nil {
            errorMessage.send("User already exists.")
        } else {
            model.saveUserToDB(userRo: UserRo(id: model.getAutoIncrementID(), name: name, password: password))
            registerSuccess.send(name)
        }
        
        
    }

    func getAllUser(){
        model.retrieveUser(condition: "")
    }
    func tryToLogin(name : String ,password : String ) {
        loadingPublishSubject.send(true)
        let allUser = model.retrieveAllUser()
        
        loadingPublishSubject.send(false)
        let matchingUsers = allUser.filter { item in
            return item.name == name && item.password == password
        }
        
        if matchingUsers.first != nil {
            loginSuccess.send(name)
        } else {
            errorMessage.send("User not found.")
        }
    }
}
