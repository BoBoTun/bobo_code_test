//
//  UserModel.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
import Combine
class UserModel {
    static let shared  = UserModel()
    var bindings = Set<AnyCancellable>()
    let db = DBManager.sharedInstance
    private init() {}
    
}
extension UserModel {
 
    
    func saveUserToDB(userRo : UserRo) {
        
        db.saveData(data: userRo, value: UserRo.self) { error in
            print("Svae error >>>" , error)
            
        }
    }
    
    func retrieveAllUser() -> [UserRo] {
        let result = db.retrieveDataList(type: UserRo.self)
        return Array(result)
    }
    func getAutoIncrementID() -> Int {
        return db.nextUserID()
    }
    
}
