import Foundation

public extension ProcessInfo {

    /// Provides the raw value of the launch argument for sample data in UI tests.
    var uiTestSampleData: String {
        LaunchArgument.sampleData.rawValue
    }
    
    /// Provides the raw value of the launch argument for staging data in UI tests.
    var uiTestStagingData: String {
        LaunchArgument.stagingData.rawValue
    }
    
    /// Enumerates the launch arguments that the app recognizes.
    enum LaunchArgument: String {
        case sampleData // Represents the launch argument for sample data.
        case stagingData // Represents the launch argument for staging data.
        case none // Represents the absence of a recognized launch argument.
    }
    
    /// Returns the recognized launch argument that was passed to the app, if any.
    var launchArgument: LaunchArgument {
        if arguments.contains(uiTestSampleData) {
            return .sampleData
        }
        if arguments.contains(uiTestStagingData) {
            return .stagingData
        }
        return .none
    }
}
