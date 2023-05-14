import UIKit

/// A protocol for UITableViewCell that can be loaded with data conforming to the `CellDataProviding` protocol.
/// Implement this protocol in all cells that load data.
public protocol TableViewCellProtocol where Self: UITableViewCell {
    /// Load cell with provided data and delegate.
    ///
    /// - Parameters:
    ///     - cellData: A `CellDataProtocol` object that provides the data for the cell.
    ///     - delegate: An optional delegate object.
    ///
    /// All cells should use this method to load their data. Each cell should know how to cast `CellDataProviding` to its own data type.
    func configure(with cellData: CellDataProtocol,
                   delegate: AnyObject?)
    
}
