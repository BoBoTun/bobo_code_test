
import UIKit

class AlertManager {
    class func showAlert(_ title: String?,
                         message: String?,
                         confirmTitle : String? = nil,
                         confirmAction: (() -> Void)? = nil,
                         cancelButtonTitle: String? = nil,
                         cancelAction: (() -> Void)? = nil,
                         inViewController viewController: UIViewController?) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let confirmAction = confirmAction {
            let alertConfirmAction = UIAlertAction(title: confirmTitle, style: .default) { (action) in
                confirmAction()
            }
            alertController.addAction(alertConfirmAction)
        }
        
        if let cancelButtonTitle = cancelButtonTitle {
            let alertCancelAction = UIAlertAction(title: cancelButtonTitle, style: .cancel) { (action) in
                cancelAction?()
            }
            alertController.addAction(alertCancelAction)
        }
        
        DispatchQueue.main.async {
            alertController.modalPresentationStyle = .fullScreen
            viewController?.present(alertController, animated: true, completion: nil)
        }
    }
        
    class func showCommonError(title : String = "Warning", message : String, vc : BaseViewController) {
        showAlert(title, message: message, cancelButtonTitle: "Cancel", inViewController: vc)
    }
}


