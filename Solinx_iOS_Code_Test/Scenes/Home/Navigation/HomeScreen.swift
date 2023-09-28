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
        case navigateToBookDetailVC(_ book : Book)
        func show() {
            switch self {
            case .navigateToLoginVC:
                AppScreens.shared.navigateToLoginVC()
            case .navigateToBookDetailVC(let book):
                AppScreens.shared.navigateToBookDetailVC(book: book)
            }
        }
    }
}
