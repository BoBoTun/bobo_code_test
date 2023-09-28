

import Foundation

class UserDefaultModel {
    
    static let shared = UserDefaultModel()
    
    /* User login state */
    func isUserLoggedIn() -> Bool{
        return UserDefaultManager.retrieveBoolFromNSUserDefault(key: UserDefaultManager.Key.IS_USER_LOGGED_IN.getKey())
    }
    
    func setUserLoggedInState(isLoggedIn : Bool) {
        UserDefaultManager.saveBoolToNSUserDefault(value: isLoggedIn,
                                                   key: UserDefaultManager.Key.IS_USER_LOGGED_IN.getKey())
    }
    
    /* User access token */
    func setAuthToken(accessToken : String, completion : (() -> Void)? = nil){
        UserDefaultManager.saveStringToNSUserDefault(value: accessToken,
                                                     key: UserDefaultManager.Key.AUTH_TOKEN.getKey())
        if let completion = completion {
            completion()
        }
    }
    
    func getAuthToken() -> String {
        UserDefaultManager.retrieveStringFromNSUserDefault(key: UserDefaultManager.Key.AUTH_TOKEN.getKey())
    }
    
    func setUserName(userName : String, completion : (() -> Void)? = nil){
        UserDefaultManager.saveStringToNSUserDefault(value: userName,
                                                     key: UserDefaultManager.Key.USER_NAME.getKey())
        if let completion = completion {
            completion()
        }
    }
    
    func getUserName() -> String {
        UserDefaultManager.retrieveStringFromNSUserDefault(key: UserDefaultManager.Key.USER_NAME.getKey())
    }
    
    func setUserImage(userImage : String, completion : (() -> Void)? = nil){
        UserDefaultManager.saveStringToNSUserDefault(value: userImage,
                                                     key: UserDefaultManager.Key.USER_IMG.getKey())
        if let completion = completion {
            completion()
        }
    }
    
    func getUserImage() -> String {
        UserDefaultManager.retrieveStringFromNSUserDefault(key: UserDefaultManager.Key.USER_IMG.getKey())
    }
    
    /* Firebase access token */
    func setFCMToken(fCMToken : String, completion : (() -> Void)? = nil){
        UserDefaultManager.saveStringToNSUserDefault(value: fCMToken,
                                                     key: UserDefaultManager.Key.FCM_TOKEN.getKey())
        if let completion = completion {
            completion()
        }
    }
    
    func getFCMToken() -> String {
        UserDefaultManager.retrieveStringFromNSUserDefault(key: UserDefaultManager.Key.FCM_TOKEN.getKey())
    }
    
    func setFCMUserId(fcMUserID : String, completion : (() -> Void)? = nil){
        UserDefaultManager.saveStringToNSUserDefault(value: fcMUserID,
                                                     key: UserDefaultManager.Key.FCM_USER_ID.getKey())
        if let completion = completion {
            completion()
        }
    }
    
    func getFCMUserID() -> String {
        UserDefaultManager.retrieveStringFromNSUserDefault(key: UserDefaultManager.Key.FCM_USER_ID.getKey())
    }
    
    func clearSession(){
        
        let keyList : [String] = [UserDefaultManager.Key.IS_USER_LOGGED_IN.getKey(),
                                  UserDefaultManager.Key.AUTH_TOKEN.getKey()
        ]
        
        keyList.forEach { key in
            UserDefaultManager.removeObj(key: key)
        }
        
    }
}
