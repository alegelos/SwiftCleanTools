import UIKit

public extension UIViewController {
    
    /// Displays a LoadingView on top of the current view controller's view.
    ///
    /// - Returns: The LoadingView instance that is being displayed.
    ///
    /// - Throws: An error if the LoadingView couldn't be created.
    func showLoadingView() throws -> LoadingView {
        do {
            let loadingView = try LoadingView.initFromNib()
            
            view.addSubview(loadingView)
            
            // Set AutoLayout constraints
            loadingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                loadingView.topAnchor.constraint(equalTo: view.topAnchor),
                loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
            
            // Animate the loading view's appearance
            UIView.animate(withDuration: 0.3) {
                loadingView.alpha = 1
            }
            
            return loadingView
        } catch {
            //TODO: report error
            throw error
        }
    }
    
    /// Removes the provided LoadingView from the current view controller's view.
    ///
    /// - Parameter loadingView: The LoadingView instance to be removed.
    func hideLoadingView(_ loadingView: LoadingView?) {
        guard let loadingView = loadingView else {
            //TODO: handle case when loadingView is nil
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            loadingView.alpha = 0
        }, completion: { _ in
            loadingView.removeFromSuperview()
        })
    }
    
}
