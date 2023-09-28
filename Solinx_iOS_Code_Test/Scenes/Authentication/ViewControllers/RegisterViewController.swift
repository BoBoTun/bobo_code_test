//
//  RegisterViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit

class RegisterViewController: BaseViewController {
    @IBOutlet weak var userNameBgView: UIView!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var txtConfirmPass: UITextField!
    @IBOutlet weak var confirmPassBgView: UIView!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var passwordBgView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    let viewModel = AuthenticationModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func setupUI() {
        showNavigationBar()
        btnSignUp.roundCorners(.allCorners, radius: self.btnSignUp.frame.height / 2)
        userNameBgView.roundCorners(.allCorners, radius: self.userNameBgView.frame.height / 2)
        passwordBgView.roundCorners(.allCorners, radius: self.passwordBgView.frame.height / 2)
        confirmPassBgView.roundCorners(.allCorners, radius: self.confirmPassBgView.frame.height / 2)
        
        addBackButton(color: UIColor.secondary_color, image: UIImage(named: "ic_back_arrow")?.imageWithColor(color: UIColor.secondary_color) ?? UIImage(), backgroundColor: UIColor.clear)
        setupNavigationTitle(title: "Registration")
        txtUserName.placeholder = "User Name"
        txtPassword.placeholder = "Password"
        txtConfirmPass.placeholder = "Confirm Password"
        txtPassword.isSecureTextEntry = true
        txtConfirmPass.isSecureTextEntry = true
    }

    override func bindData() {
        super.bindData()
    }
    
    @IBAction func onClickSignUp(_ sender: Any) {
        
        viewModel.tryToRegister(name: self.txtUserName.text ?? "", password: self.txtPassword.text ?? "")
    }
    

}
