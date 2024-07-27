import Foundation

/// This class represents the descriptions of vertex input layouts.
public class InputLayouts: Equatable, Hashable {
    private var elementsCache: [Int] = []
    private var isDirty = true

    /// The vertex input elements.
    public var layoutElements: [LayoutDescription]

    /// Initializes a new instance of the `InputLayouts` class.
    public init() {
        self.layoutElements = []
    }

    /// Try to get the attribute slot by semantic and semantic index.
    /// - Parameters:
    ///   - semantic: Attribute semantic type.
    ///   - semanticIndex: Attribute semantic index.
    ///   - slot: Attribute slot.
    /// - Returns: True if the attribute is found, false otherwise.
    public func tryGetSlot(semantic: ElementSemanticType, semanticIndex: UInt, slot: inout Int) -> Bool {
        slot = 0
        let elements = layoutElements[0].elements
        for (i, element) in elements.enumerated() {
            if element.semantic == semantic && element.semanticIndex == semanticIndex {
                slot = i
                return true
            }
        }
        return false
    }

    /// Finds a layout element description by its usage semantic.
    /// - Parameters:
    ///   - semantic: The element semantic.
    ///   - semanticIndex: The semantic index.
    ///   - elementDescription: The element description.
    ///   - vertexBufferIndex: The vertex buffer index.
    /// - Returns: True if the input layout contains an element with the specified semantic and index, false otherwise.
    public func findLayoutElementByUsage(semantic: ElementSemanticType, semanticIndex: Int, elementDescription: inout ElementDescription, vertexBufferIndex: inout Int) -> Bool {
        for (i, layoutDescription) in layoutElements.enumerated() {
            for element in layoutDescription.elements {
                if element.semantic == semantic && element.semanticIndex == UInt(semanticIndex) {
                    elementDescription = element
                    vertexBufferIndex = i
                    return true
                }
            }
        }
        elementDescription = ElementDescription(format: .uByte, semanticType: .position)
        vertexBufferIndex = 0
        return false
    }

    /// Adds a new layout.
    /// - Parameter layout: Layout description.
    /// - Returns: The updated instance of `InputLayouts`.
    @discardableResult
    public func add(layout: LayoutDescription) -> InputLayouts {
        layoutElements.append(layout)
        isDirty = true
        return self
    }

    /// Checks if the current layout is assignable to the parameter input layout.
    /// - Parameter inputLayouts: The input layouts.
    /// - Returns: True if the specified layout is compatible, false otherwise.
    public func isAssignable(inputLayouts: InputLayouts?) -> Bool {
        updateCache()
        if let inputLayouts = inputLayouts {
            inputLayouts.updateCache()
            for i in 0..<inputLayouts.elementsCache.count {
                if inputLayouts.elementsCache[i] > elementsCache[i] {
                    return false
                }
            }
        }
        return true
    }

    /// Cleans the object.
    public func clean() {
        layoutElements.removeAll()
    }

    /// Checks equality between two `InputLayouts` instances.
    public static func == (lhs: InputLayouts, rhs: InputLayouts) -> Bool {
        if lhs === rhs {
            return true
        }
        return lhs.layoutElements == rhs.layoutElements
    }

    /// Hash function for `InputLayouts`.
    public func hash(into hasher: inout Hasher) {
        layoutElements.forEach { hasher.combine($0) }
    }

    private func updateCache() {
        guard isDirty else { return }
        elementsCache = Array(repeating: -1, count: 8)
        for layoutDescription in layoutElements {
            for element in layoutDescription.elements {
                let semanticId = Int(element.semantic.rawValue)
                elementsCache[semanticId] = max(elementsCache[semanticId], Int(element.semanticIndex))
            }
        }
        isDirty = false
    }
}
