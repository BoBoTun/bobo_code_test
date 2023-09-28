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
    /*
    func saveRecommendSearchToDB(recommendSearchVos : [RecommendSearchVO]) {
        var recommendSearchRos = [RecommendSearchRO]()
        recommendSearchVos.forEach {
            recommendSearchRos.append($0.toRO())
        }
        db.saveDataList(dataList: recommendSearchRos, value: RecommendSearchRO.self) { error in
            print("save error >>>>" , error)
        }
    }
     */
    
    func saveUserToDB(userRo : UserRo) {
        
        db.saveData(data: userRo, value: UserRo.self) { error in
            print("Svae error >>>" , error)
            
        }
        
        self.retrieveUser(condition: userRo.name ?? "")
    }
    /*
     func getRecommendSearchFromDB() -> Observable<[RecommendSearchRO]> {
         let list = db.retrieveDataList(value: RecommendSearchRO.self)
         return list
     }
     */
    
    func retrieveAllUser() -> [UserRo] {
        let result = db.retrieveDataList(type: UserRo.self)
        return Array(result)
    }
    func retrieveUser(condition: String) {
        
        let result = db.retrieveDataList(type: UserRo.self)//db.getObjectByName(name: condition)//db.getDataWith(type: UserRo.self, condition: "name == \(condition)")
        print("Result ::: \(result)")
    }
    
    func getAutoIncrementID() -> Int {
        return db.nextUserID()
    }
    
}
