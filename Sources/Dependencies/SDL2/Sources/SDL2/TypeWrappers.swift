import CSDL2

extension SDL_EventType : Equatable
{
    public static func == (lhs: SDL_EventType, rhs: SDL_EventType) -> Bool {
        return lhs.rawValue == rhs.rawValue;
    }
}