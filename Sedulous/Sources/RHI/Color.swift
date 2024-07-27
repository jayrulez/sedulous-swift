public struct Color: Hashable, Equatable {
    public var red: Float
    public var green: Float
    public var blue: Float
    public var alpha: Float
    
    public static var cornflowerBlue: Color {
        return Color(red: 0.392, green: 0.584, blue: 0.929, alpha: 1.0)
    }
    
    public func toVector4() -> SIMD4<Float> {
        return SIMD4<Float>(red, green, blue, alpha)
    }

    public static func ==(lhs: Color, rhs: Color) -> Bool {
        return lhs.red == rhs.red &&
               lhs.green == rhs.green &&
               lhs.blue == rhs.blue &&
               lhs.alpha == rhs.alpha
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(red)
        hasher.combine(green)
        hasher.combine(blue)
        hasher.combine(alpha)
    }
}