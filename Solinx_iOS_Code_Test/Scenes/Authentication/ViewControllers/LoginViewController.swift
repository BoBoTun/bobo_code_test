
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
        viewModel.loginSuccess.sink {
            AuthenticationScreen.LoginVC.navigateToHomeVC($0).show()
        }.store(in: &bindings)
        
        viewModel.errorMessage.sink {
            self.showToast(message: $0)
        }.store(in: &bindings)
    }
    @IBAction func onClickSigin(_ sender: Any) {
        //AuthenticationScreen.LoginVC.navigateToHomeVC.show()
        var userName = ""
        var passWord = ""
        if let uName = self.txtUserName.text {
            if uName.isEmpty || uName == "" {
                self.showToast(message: "Please enter user name!")
            }else{
                userName = uName
                if let pWord = self.txtPassword.text {
                    if pWord.isEmpty || pWord == "" {
                        self.showToast(message: "Please enter your password!")
                    }else{
                        passWord = pWord
                        
                        viewModel.tryToLogin(name: userName, password: passWord)
                    }
                }
            }
        }
        
    }
    
    @IBAction func onClickRegister(_ sender: Any) {
        AuthenticationScreen.LoginVC.navigateToRegisterVC.show()
    }
    override func bindViewModel() {
        super.bindViewModel()
        viewModel.bindViewModel(in: self)
    }
}
