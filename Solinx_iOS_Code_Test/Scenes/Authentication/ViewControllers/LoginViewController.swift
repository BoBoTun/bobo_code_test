
import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSigin: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var passwordBgView: UIView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var userNameBgView: UIView!
    let viewModel = AuthenticationModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func setupUI() {
        super.setupUI()
        btnSigin.roundCorners(.allCorners, radius: self.btnSigin.frame.height / 2)
        userNameBgView.roundCorners(.allCorners, radius: self.userNameBgView.frame.height / 2)
        passwordBgView.roundCorners(.allCorners, radius: self.passwordBgView.frame.height / 2)
        hideNavigationBar()
        txtPassword.isSecureTextEntry = true
    }
    
    override func bindData() {
        super.bindData()
        
//        btnSigin.tapPublisher.sink {
//            AuthenticationScreen.LoginVC.navigateToHomeVC.show()
//        }.store(in: &bindings)
//        
//        btnSignUp.tapPublisher.sink {
//            AuthenticationScreen.LoginVC.navigateToRegisterVC.show()
//        }.store(in: &bindings)
    }
    @IBAction func onClickSigin(_ sender: Any) {
        //AuthenticationScreen.LoginVC.navigateToHomeVC.show()
        viewModel.getAllUser()
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        AuthenticationScreen.LoginVC.navigateToRegisterVC.show()
    }
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
    }
}
