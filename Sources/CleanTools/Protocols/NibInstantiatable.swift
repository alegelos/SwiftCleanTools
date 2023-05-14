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
    
    // Allows the instantiation of a UIView from a Nib.
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
