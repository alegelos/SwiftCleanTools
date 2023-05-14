import UIKit

public extension UIViewController {
    
    /// Displays a LoadingView on top of the current view controller's view.
    ///
    /// This method creates a new instance of LoadingView, adds it to the view controller's view, and then animates its appearance. The LoadingView is created from a nib file in the specified bundle.
    ///
    /// - Parameter bundle: The bundle from which to load the LoadingView nib file. The default value is the bundle in which the LoadingView class is defined.
    ///
    /// - Returns: The LoadingView instance that has been added to the view and is being displayed.
    ///
    /// - Throws: A Swift error if the LoadingView could not be created from the nib file in the specified bundle.
    ///
    /// - Note: If the LoadingView could not be created, this method throws a Swift error and does not modify the view controller's view.
    func showLoadingView(bundle: Bundle? = nil) throws -> LoadingView {
        do {
            let bundle = bundle ?? Bundle.module
            let loadingView = try LoadingView.initFromNib(bundle: bundle)
            
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
    /// 
    /// - Note: If the specified LoadingView is not a child of the view controller's view, this method does nothing.
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
