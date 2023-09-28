//
//  HomeViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        showNavigationBar()
        setNavigationColor()
        setupNavigationRightBarButton()
        setupNavigationTitle(title: "Books")
    }
}
