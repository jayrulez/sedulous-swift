public struct SDL_InitFlags : OptionSet, Sendable
{
    public let rawValue: UInt32

    public static let timer           = Self(rawValue: 0x00000001);
    public static let audio           = Self(rawValue: 0x00000010);
    public static let video           = Self(rawValue: 0x00000020);
    public static let joystick        = Self(rawValue: 0x00000200);
    public static let haptic          = Self(rawValue: 0x00001000);
    public static let gamecontroller  = Self(rawValue: 0x00002000);
    public static let events          = Self(rawValue: 0x00004000);
    public static let sensor          = Self(rawValue: 0x00008000);
    public static let noparachute     = Self(rawValue: 0x00100000);

    public static let everything: Self = [
        .timer , 
        .audio , 
        .video , 
        .events , 
        .joystick , 
        .haptic , 
        .gamecontroller, 
        .sensor
    ]

    public init(rawValue: UInt32)
    {
        self.rawValue = rawValue;
    }
}