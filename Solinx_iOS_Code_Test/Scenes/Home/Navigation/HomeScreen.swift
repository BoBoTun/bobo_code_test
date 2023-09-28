//
//  HomeScreen.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/28/23.
//

import Foundation
class HomeScreen {
    enum HomeVC {
        
        case navigateToLoginVC
        func show() {
            switch self {
            case .navigateToLoginVC:
                AppScreens.shared.navigateToLoginVC()
            }
        }
    }
}
