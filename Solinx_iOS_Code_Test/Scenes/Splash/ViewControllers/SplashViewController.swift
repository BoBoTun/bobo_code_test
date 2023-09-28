//
//  SplashViewController.swift
//  Solinx_iOS_Code_Test
//
//  Created by MacBook Pro on 9/27/23.
//

import UIKit
import Lottie
class SplashViewController: UIViewController {

    @IBOutlet weak var animationView: LottieAnimationView!
    //var animationView: LottieAnimationView?
    override func viewDidLoad() {
        super.viewDidLoad()
          animationView!.frame = view.bounds
          
          animationView!.contentMode = .scaleAspectFit
          
          animationView!.loopMode = .loop
          animationView!.animationSpeed = 0.5
          view.addSubview(animationView!)
          
          animationView!.play()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {[unowned self] in
            gotoChooseTheme()
        }
    }

    private func gotoChooseTheme(){
        
        SplashScreen.SplashVC.navigateToLoginVC.show()
    }

}
