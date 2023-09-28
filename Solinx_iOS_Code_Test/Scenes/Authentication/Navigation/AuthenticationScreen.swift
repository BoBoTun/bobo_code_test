//
//  AuthenticationScreen.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import Foundation
class AuthenticationScreen {
    enum LoginVC {
        
        case navigateToHomeVC
        case navigateToRegisterVC
        func show() {
            switch self {
            case .navigateToHomeVC:
                AppScreens.shared.navigateToHomeVC()
            case .navigateToRegisterVC:
                AppScreens.shared.navigateToRegisterVC()
            }
        }
    }
}
