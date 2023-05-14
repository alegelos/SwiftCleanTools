import UIKit

public extension UIViewController {
    
    /// Presents an alert on the view controller.
    ///
    /// This method presents an alert dialog with a series of options.
    /// The options are presented as buttons in the alert dialog.
    /// When a button is tapped, the provided completion handler is called with the index of the tapped button.
    ///
    /// - Parameters:
    ///   - title: The title of the alert.
    ///   - message: The message of the alert.
    ///   - options: The titles of the buttons in the alert. Default value is ["OK"].
    ///   - completion: The completion handler to call when an option is selected. Default value does nothing.
    @MainActor
    func presentAlert(withTitle title: String,
                      message: String,
                      options: [String] = [NSLocalizedString("ok", comment: "confirmation")],
                      completion: @escaping ((Int) -> Void) = { _ in } ) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            let action = UIAlertAction(title: option,
                                       style: .default,
                                       handler: { _ in completion(index) })
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
}
