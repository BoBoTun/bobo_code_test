//
//  UserRo.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
import RealmSwift

@objcMembers final class UserRo: Object {
    dynamic var id : Int = 0
    dynamic var name : String?
    dynamic var password  : String?
    
    convenience init(id: Int?, name: String? , password : String?) {
        self.init()
        self.id = id ?? 0
        self.name = name
        self.password = password
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }

}
