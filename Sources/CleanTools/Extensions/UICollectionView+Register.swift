import UIKit

public extension UICollectionView {
    
    /// Registers a nib-based cell for use in creating new collection view cells.
    ///
    /// Use this method when your cells are designed in Interface Builder as a .xib file.
    /// This method assumes that the .xib file and the cell identifier are both named
    /// the same as the class name of the cell.
    ///
    /// - Parameter cellType: The type of the cell. This should be the UICollectionViewCell subclass.
    func registerNibCell<T: UICollectionViewCell>(_ cellType: T.Type) {
        let identifier = String(describing: cellType)
        let nib = UINib(nibName: identifier, bundle: nil)
        
        register(nib, forCellWithReuseIdentifier: identifier)
    }
    
}
