import Foundation

/// A protocol that provides a cell identifier for cell dequeuing.
/// Adhere to this protocol for all types that represent cell data.
public protocol CellDataProtocol {
    /// Identifier for dequeuing a cell.
    /// This identifier should be the same as the cell's identifier.
    var cellIdentifier: String { get }
}
