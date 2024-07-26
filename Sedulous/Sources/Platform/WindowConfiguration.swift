public struct WindowConfiguration
{
    public var title: String;
    public var width: UInt32; 
    public var height: UInt32;

    public init(title: String, width: UInt32, height: UInt32) {
        self.title = title
        self.width = width
        self.height = height
    }
}