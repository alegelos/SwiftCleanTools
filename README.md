# SwiftCleanTools

SwiftCleanTools is a Swift framework packed with various utility protocols and extensions designed to enhance your development productivity and code clarity.

## Features

- `ViewModelDelegateProtocol` for a seamless interaction between ViewModel and View.
- Extended `UITableView` and `UICollectionView` for effortless cell registration and dequeuing.
- Protocols and extensions for smooth nib loading.
- Handy extensions to `UIViewController` for managing alerts and loading views.
- Utility classes for handling launch arguments.
- And many more...

## Installation

To incorporate SwiftCleanTools into your project, add it as a dependency in your Swift Package Manager.

```swift
dependencies: [
.package(url: "https://github.com/alegelos/SwiftCleanTools.git", from: "1.0.0")
]
```

# ViewModelDelegateProtocol Usage

ViewModelDelegateProtocol creates a structured bridge between a ViewModel and a ViewController. It ensures a clean separation of concerns, with the View handling UI elements and the ViewModel dealing with data and UI events.

## Protocol Definition

Firstly, create a custom protocol that conforms to `ViewModelDelegateProtocol`.

```swift
protocol YourViewModelDelegate: ViewModelDelegateProtocol {
    func doAction(_ action: YourViewModel.Action)
    func update(field: YourViewModel.Field)
    func propagate(event: YourViewModel.Event)  
}
```

## Enum Actions

Secondly, define `Action`, `Field`, and `Event` enums within your ViewModel to represent various actions that the View should perform:

```swift
extension YourViewModel {
    enum Action {
        case reloadTableView([CellDataProtocol])
        case show(Alert)
        case goTo(View)
        case showLoadingView(Bool = true)
        
        enum Alert {
            case friendlyError
            case emptyCart
        }
        
        enum View {
            case checkout([Item])
        }
    }

    enum Field { }
    
    enum Event { }
}
```

## ViewModel Implementation

In your ViewModel, invoke the delegate's method to notify the View about any updates:

```swift
delegate?.doAction(.showLoadingView(false))
delegate?.doAction(.reloadTableView([CellData]))
```

## ViewController Conformance

In your ViewController, conform to `YourViewModelDelegate`:

```swift
extension YourViewController: YourViewModelDelegate {
    typealias Action = YourViewModel.Action
    
    func doAction(_ action: Action) {
        switch action {
            case .show(let alert):
                handleShow(alert)
            case .goTo(let view):
                handleGoTo(view)
            case .showLoadingView(let show):
                if show {
                    loadingView = try? showLoadingView()
                } else {
                    hideLoadingView(loadingView)
                }
            case .reloadTableView(let updatedItems):
                items = updatedItems
                tableView.reloadData()
        }
    }
    
    func update(field: YourViewModel.Field) { }
    func propagate(event: YourViewModel.Event) { }
}
```

## Forward UI events to ViewModel

Forward any UI event from the ViewController to the ViewModel.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    
    //First setup UI
    setupView()
    
    //Then trigger functionality
    viewModel.viewDidLoad()
}
```

# TableViewCellProtocol Usage

TableViewCellProtocol simplifies UITableView coding by enabling different cell types to be loaded with identical dequeuing code. This keeps your codebase clean, simple, and easy to read. Each cell is responsible for casting the data to its own type.

## Conform Your Cell to TableViewCellProtocol

Your custom cell must conform to the TableViewCellProtocol. Implement the `configure(with:delegate:)` method to assign data to your cell's ViewModel.


```swift
extension YourCell: TableViewCellProtocol {
    func configure(with cellData: CellDataProtocol, delegate: AnyObject?) {
        viewModel.assign(cellData: cellData)
    }
}
```

## Create Table Data as an Array of CellDataProtocol

Your table data should be an array that conforms to `CellDataProtocol`. This approach allows you to store data for different cell types in the same array.

```swift
var items = [CellDataProtocol]()
```

## Dequeue and Configure Your Cells

In your TableView's data source, dequeue cells using the cellIdentifier from your `CellDataProtocol` object. Cast the dequeued cell to `TableViewCellProtocol` and configure it with the `CellDataProtocol` object.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellData = items[indexPath.row]
    
    let cell = tableView.dequeueReusableCell(withIdentifier: cellData.cellIdentifier, for: indexPath)
    guard let cell = cell as? TableViewCellProtocol else {
        //TODO: report error
        return UITableViewCell()
    }
    cell.configure(with: cellData, delegate: self)
    
    return cell
}
```

Following this methodology, you can manage various cell types in your TableView using the same dequeuing and configuration code, resulting in a cleaner and more readable codebase.

# Using CellDataProtocol

CellDataProtocol standardizes the way data is passed to your TableViewCells. Here's how you can utilize it:

## Create a Model Conforming to CellDataProtocol

First, create a model that conforms to `CellDataProtocol`. This model will contain all the necessary data for your cell.

```swift
extension YourCellViewModel {
    final class Model: CellDataProtocol {
        var cellIdentifier: String {
            String(describing: YourCell.self)
        }
        
        let itemData: YourItemType
        
        init(_ itemData: YourItemType) {
            self.itemData = itemData
        }
    }
}
```

The cellIdentifier is a computed property that returns the cell's class name as a String. This is used to dequeue the cell from the tableView. The cell identifier must match the class name of `YourCell`.
