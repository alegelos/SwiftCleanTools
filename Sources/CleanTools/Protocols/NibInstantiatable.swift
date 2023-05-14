import UIKit

// A protocol that ensures a UIView can be instantiated from a Nib.
public protocol NibInstantiatable {
    
    // Returns the name of the Nib file.
    static func nibName() -> String
    
}

public extension NibInstantiatable {
    
    // By default, we'll assume the Nib file has the same name as the class that's implementing this protocol.
    static func nibName() -> String {
        return String(describing: self)
    }
    
}

public extension NibInstantiatable where Self: UIView {
    
    /// Instantiates a UIView from a nib.
    ///
    /// This method allows you to create an instance of a UIView subclass from a nib file. The nib file should be located in the specified bundle and have the same name as the subclass. The method returns the view that is at the specified index in the nib file.
    ///
    /// - Parameters:
    ///   - bundle: The bundle in which to look for the nib file. The default value is the bundle in which the UIView subclass is defined.
    ///   - index: The index of the view in the nib file. The default value is 0.
    ///
    /// - Returns: The instantiated UIView.
    ///
    /// - Throws: An error of type `NibInstantiatableError` if the nib file could not be loaded, if the specified index is out of bounds, or if the view at the specified index in the nib file could not be cast to the UIView subclass.
    static func initFromNib(bundle: Bundle = Bundle(for: Self.self),
                            index: Int = .zero) throws -> Self {
        // Load the Nib.
        guard let nibObjects = bundle.loadNibNamed(nibName(),
                                                   owner: self,
                                                   options: nil) else {
            throw NibInstantiatableError.nibNotFound
        }
        
        // Ensure the index is not out of bounds
        guard index >= .zero,
              index < nibObjects.count else {
            throw NibInstantiatableError.indexOutOfBounds
        }
        
        // Try to cast the Nib's object at the given index as 'Self' (the class type that's implementing this protocol).
        guard let instantiatedView = nibObjects[index] as? Self else {
            throw NibInstantiatableError.failedToInstantiate
        }
        return instantiatedView
    }
    
}

// The error to throw when the nib can't be loaded or instantiation from the nib fails.
public enum NibInstantiatableError: Error {
    case nibNotFound
    case failedToInstantiate
    case indexOutOfBounds
}
