import Foundation

/// This struct describes the elements inside a `ResourceLayout`.
public struct ResourceLayoutDescription {
    
    /// The layout elements.
    public var elements: [LayoutElementDescription]
    
    /// The number of dynamic constant buffers.
    public private(set) var dynamicConstantBufferCount: Int
    
    /// Initializes a new instance of the `ResourceLayoutDescription` struct.
    /// - Parameter elements: The elements descriptions.
    public init(elements: LayoutElementDescription...) {
        self.elements = elements
        self.dynamicConstantBufferCount = elements.filter { $0.allowDynamicOffset }.count
    }
}
