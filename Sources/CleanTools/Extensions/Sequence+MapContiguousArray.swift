import Foundation

public extension Sequence {
    
    /// Transforms the elements of the sequence into an array with a contiguous block of memory,
    /// using the provided closure.
    ///
    /// This method is similar to the standard `map(_:)` function, but the result is a
    /// `ContiguousArray` instead of an `Array`. This can lead to performance benefits
    /// when the elements are a type that benefits from being stored in a contiguous block of memory.
    ///
    /// - Parameter transform: A mapping closure. `transform` accepts an element of this
    /// sequence as its parameter and returns a transformed value of the same or of a different type.
    ///
    /// - Returns: A `ContiguousArray` containing the transformed elements of this sequence.
    ///
    /// - Throws: An error if the provided closure throws an error.
    func mapContiguousArray<T>(_ transform: (Element) throws -> T) rethrows -> ContiguousArray<T> {
        let initialCapacity = underestimatedCount
        var result = ContiguousArray<T>()
        result.reserveCapacity(initialCapacity)
        
        var iterator = makeIterator()
        
        // Add elements up to the initial capacity without checking for regrowth.
        for _ in 0..<initialCapacity {
            guard let element = iterator.next() else { break }
            result.append(try transform(element))
        }
        // Add remaining elements, if any.
        while let element = iterator.next() {
            result.append(try transform(element))
        }
        return result
    }
}
