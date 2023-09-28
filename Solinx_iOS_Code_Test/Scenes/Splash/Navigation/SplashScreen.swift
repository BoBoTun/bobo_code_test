//
//  SplashScreen.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import Foundation
class SplashScreen {
    enum SplashVC {
        
        case navigateToLoginVC
        
        func show() {
            switch self {
            case .navigateToLoginVC:
                AppScreens.shared.navigateToLoginVC()
            }
        }
    }
}
