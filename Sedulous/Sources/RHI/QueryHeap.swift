import Foundation

/// This protocol represents a query heap resource.
public protocol QueryHeap: GraphicsResource {
    /// The query heap description.
    var description: QueryHeapDescription { get }

    /// Initializes a new instance of the `QueryHeap` class.
    /// - Parameters:
    ///   - context: The graphics context.
    ///   - description: The query heap description.
    init(context: GraphicsContext, description: QueryHeapDescription)

    /// Extract data from one or more queries.
    /// - Parameters:
    ///   - startIndex: Specifies the index of the first query to read.
    ///   - count: Specifies the number of queries to read.
    ///   - results: `UInt64` buffer with the extracted queries data.
    /// - Returns: Returns true if all queries to read are available and false if not.
    /// - Remarks: If the result is false, the results will contain the latest available results.
    func readData(startIndex: UInt, count: UInt, results: inout [UInt64]) -> Bool
}
