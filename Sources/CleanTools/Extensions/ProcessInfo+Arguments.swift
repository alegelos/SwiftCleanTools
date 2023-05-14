import Foundation

public extension ProcessInfo {

    /// Provides the raw value of the launch argument for sample data in UI tests.
    public var uiTestSampleData: String {
        LaunchArgument.uiTestSampleData.rawValue
    }
    
    /// Provides the raw value of the launch argument for staging data in UI tests.
    public var uiTestStagingData: String {
        LaunchArgument.uiTestStagingData.rawValue
    }
    
    /// Enumerates the launch arguments that the app recognizes.
    public enum LaunchArgument: String {
        case uiTestSampleData // Represents the launch argument for sample data in UI tests.
        case uiTestStagingData // Represents the launch argument for staging data in UI tests.
        case none // Represents the absence of a recognized launch argument.
    }
    
    /// Returns the recognized launch argument that was passed to the app, if any.
    public var launchArgument: LaunchArgument {
        if arguments.contains(uiTestSampleData) {
            return .uiTestSampleData
        }
        if arguments.contains(uiTestStagingData) {
            return .uiTestStagingData
        }
        return .none
    }
}
