import SDL2
import CSDL2
import SedulousPlatform

public final class SDL2Window : Window
{
    private var window: UnsafeMutablePointer<SDL_Window>;

    public init(_ title: String, _ width: UInt32, _ height: UInt32)
    {
        let flags: SDL_WindowFlags = SDL_WINDOW_SHOWN;

        window = SDL2Native.SDL_CreateWindow(title, Int32(SDL_WINDOWPOS_UNDEFINED_MASK | 0), Int32(SDL_WINDOWPOS_UNDEFINED_MASK | 0), Int32(width), Int32(height), flags);

        if(window.pointee == nil)
        {
            fatalError("Failed to create window");
        }
    }

    deinit {
        SDL2Native.SDL_DestroyWindow(window);
    }
}