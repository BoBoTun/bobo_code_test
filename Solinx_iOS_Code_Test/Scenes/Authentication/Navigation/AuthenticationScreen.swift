//
//  AuthenticationScreen.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import Foundation
class AuthenticationScreen {
    enum LoginVC {
        
        case navigateToHomeVC(_ userName : String)
        case navigateToRegisterVC
        func show() {
            switch self {
            case .navigateToHomeVC(let userName):
                AppScreens.shared.navigateToHomeVC(userName: userName)
            case .navigateToRegisterVC:
                AppScreens.shared.navigateToRegisterVC()
            }
        }
    }
}
