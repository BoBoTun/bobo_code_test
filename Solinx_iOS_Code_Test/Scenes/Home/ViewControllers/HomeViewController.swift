//
//  HomeViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit

class HomeViewController: BaseViewController {
    var btnLogout = RoundedCornerUIButton(type: .custom)
    var userName : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        showNavigationBar()
        setNavigationColor()
        btnLogout.setImage(UIImage(named: "ic_logout")?.imageWithColor(color: .secondary_color), for: .normal)
        setupRightBarButton(buttonList: [btnLogout])
        setupNavigationTitle(title: "Welcome \(self.userName ?? "")")
    }
    
    override func bindData() {
        super.bindData()
        btnLogout.tapPublisher.sink {
            AlertManager.showAlert("Logout", message: "Hello \(self.userName ?? "")! Are you sure to Logout?", confirmTitle: "OK", confirmAction: {[unowned self] in
                HomeScreen.HomeVC.navigateToLoginVC.show()
            }, cancelButtonTitle: "Cancel", cancelAction: nil, inViewController: self)
        }.store(in: &bindings)
    }
    
    
}
