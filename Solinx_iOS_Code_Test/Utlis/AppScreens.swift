//
//  AppScreens.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit

class AppScreens {
    static var shared = AppScreens()
    var currentVC : UIViewController?
    var previousVC : UIViewController?
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
}

extension AppScreens {
    func navigateToHomeVC(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let viewController = HomeViewController.init()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        
    }
    
    func navigateToLoginVC(){
        let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        let viewController = LoginViewController.init()
        let navigation = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
    }
    
    func navigateToRegisterVC(){
        let vc = RegisterViewController.init()
        currentVC?.navigationController?.pushViewController(vc, animated: true)
    }
}
