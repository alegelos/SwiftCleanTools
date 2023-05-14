# SwiftCleanTools

SwiftCleanTools is a powerful and easy-to-use Swift framework that includes several utility classes and extensions to boost your development productivity.

## Features

- Provides ViewModelDelegateProtocol for streamlined communication between ViewModel and View.
- Extends UITableView and UICollectionView for easy cell registration and dequeuing.
- Includes protocols and extensions for easy nib loading.
- Offers useful extensions to UIViewController for handling alerts and loading views.
- Includes utility classes for working with launch arguments.
- And much more...

## Installation

To include SwiftCleanTools in your project, you need to add it as a dependency in your Swift Package Manager.

```swift
dependencies: [
.package(url: "https://github.com/alegelos/SwiftCleanTools.git", from: "1.0.0")
]



## Usage

### Managing Launch Arguments

SwiftCleanTools provides extensions to ProcessInfo to manage launch arguments in your UI tests. 

```swift
// Access the raw value of the launch argument for sample data in UI tests
print(ProcessInfo.processInfo.uiTestSampleData)

// Access the raw value of the launch argument for staging data in UI tests
print(ProcessInfo.processInfo.uiTestStagingData)

// Get the recognized launch argument that was passed to the app
print(ProcessInfo.processInfo.launchArgument)
```

### Registering Nib-Based Cells

SwiftCleanTools provides extensions to UICollectionView and UITableView to easily register nib-based cells.

```swift
// Register a nib-based cell for your UICollectionView
collectionView.registerNibCell(MyCollectionViewCell.self)

// Register a nib-based cell for your UITableView
tableView.registerNibCell(MyTableViewCell.self)
```

### Presenting Alerts

SwiftCleanTools provides extensions to UIViewController to easily present alerts on the view controller.

```swift
// Present an alert with title, message, and options
viewController.presentAlert(withTitle: "Title", message: "Message", options: ["OK", "Cancel"])
```

### Managing Loading Views

SwiftCleanTools provides extensions to UIViewController to display and hide LoadingViews.

```swift
// Show a loading view
let loadingView = try? viewController.showLoadingView()

// Hide a loading view
viewController.hideLoadingView(loadingView)
```

### Implementing Cell Data Protocol

SwiftCleanTools provides a protocol, CellDataProtocol, for implementing cell data and a protocol, CollectionViewCellProtocol and TableViewCellProtocol, for implementing UICollectionViewCell and UITableViewCell that can be loaded with data conforming to the CellDataProtocol.

```swift
struct MyCellData: CellDataProtocol {
    let cellIdentifier: String = "MyCell"
    let data: String
}

class MyCollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {
    func configure(with cellData: CellDataProtocol, delegate: AnyObject?) {
        guard let cellData = cellData as? MyCellData else { return }
        // configure cell with data
    }
}
```

### Instantiating UIView from a Nib

SwiftCleanTools provides a protocol, NibInstantiatable, for ensuring a UIView can be instantiated from a Nib.

```swift
class MyCustomView: UIView, NibInstantiatable {
    // ...
}

if let customView = try? MyCustomView.initFromNib() {
    // use customView
}
```

### Implementing ViewModel Delegate Protocol

SwiftCleanTools provides a protocol, ViewModelDelegateProtocol, for implementing a delegate protocol for a ViewModel.

```swift
class MyViewModel {
    weak var delegate: ViewModelDelegateProtocol?
    // ...
}
```

---

This library aims to help developers focus on what matters most - building the unique features of their apps. By taking care of common tasks
