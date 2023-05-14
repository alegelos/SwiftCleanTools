import UIKit
import CleanTools

extension UIViewController {
    
    /// Presents a friendly error alert on the view controller.
    ///
    /// This method presents a standard error dialog with a friendly message.
    /// When the button in the dialog is tapped, the provided completion handler is called.
    ///
    /// - Parameter completion: The completion handler to call when the button is tapped. Default value does nothing.
    func presentFriendlyErrorAlert(completion: @escaping ((Int) -> Void) = { _ in }) {
        let title = NSLocalizedString("friendly_error_alert_title", comment: "")
        let message = NSLocalizedString("friendly_error_alert_message", comment: "")
        
        presentAlert(withTitle: title,
                     message: message,
                     completion: completion)
    }
    
}
