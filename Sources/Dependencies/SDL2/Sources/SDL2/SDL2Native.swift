import CSDL2;

public class SDL2Native
{
    private nonisolated(unsafe) static let impl : SDL2Implementation = SDL2Implementation_Default.init();

    private init()
    {
    }

    public static func SDL_Init(_ flags: SDL_InitFlags) -> Int32
    {
        return Self.impl.SDL_Init(flags.rawValue);
    }

    public static func SDL_Quit() -> Void
    {
        return Self.impl.SDL_Quit();
    }

    public static func SDL_PollEvent(_ event: inout SDL_Event) -> Int32
    {
        return Self.impl.SDL_PollEvent(&event);
    }

    public static func SDL_CreateWindow(_ title: String, _ x: Int32, _ y: Int32, _ w: Int32, _ h: Int32, _ flags: SDL_WindowFlags) -> UnsafeMutablePointer<SDL_Window>{
        return Self.impl.SDL_CreateWindow(title, x, y, w, h, flags);
    }
    
    public static func SDL_DestroyWindow(_ window: UnsafeMutablePointer<SDL_Window>) -> Void
    {
        return Self.impl.SDL_DestroyWindow(window);
    }
}