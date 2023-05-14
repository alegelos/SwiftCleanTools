import Foundation

public protocol ViewModelDelegateProtocol: AnyObject {

    associatedtype Action = Never
    associatedtype Field = Never
    associatedtype Event = Never

    /// Executes a specified UI action.
    /// - Parameter action: The UI action to carry out. Examples could be:
    ///     - Navigating to the next view
    ///     - Displaying an alert
    ///     - Navigating back to the previous view
    ///     - Refreshing a table view
    ///     - Enabling or disabling user interaction
    ///     - Displaying a loading indicator
    func doAction(_ action: Action)

    /// Modifies a specific UI component's properties.
    /// - Parameter field: The UI component to modify. Examples could be:
    ///     - Updating a label's text
    ///     - Changing a view's background color
    ///     - Adjusting a progress bar's current progress
    ///     - Changing an image view's image
    ///     - Setting a slider's current value
    ///     - Turning a switch on or off
    func update(field: Field)

    /// Instructs the delegate to propagate a given event, usually to a super view.
    /// - Parameter event: The event to be communicated upwards. Examples include:
    ///     - Going back (causing the super view to be removed)
    ///     - Reloading data (triggering a data reload in the super view)
    ///     - Resuming video (resuming a video player in the super view)
    ///     - Pausing audio (pausing an audio player in the super view)
    ///     - Refreshing UI (triggering a refresh of the super view's user interface)
    ///     - Showing error (displaying an error message on the super view)
    ///     - Updating status (updating a status label or icon in the super view)
    func propagate(event: Event)
    
}

public extension ViewModelDelegateProtocol {

    func doAction(_ action: Action) { }
    func update(field: Field) { }
    func propagate(event: Event) { }

}
