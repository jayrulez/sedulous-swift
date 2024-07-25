import CSDL2

internal class SDL2Implementation_Default : SDL2Implementation
{
    private var nativeLibrary: NativeLibrary;

    public init()
    {
        #if os(Windows)
        self.nativeLibrary = createNativeLibrary("Libs/win32-x64/SDL2.dll");
        #else
        fatalError("Only windows is currently supported.");
        #endif

        SDL_Init_Func_Delegate = nativeLibrary.loadFunction("SDL_Init")!;
        SDL_Quit_Func_Delegate = nativeLibrary.loadFunction("SDL_Quit")!;
        SDL_PollEvent_Func_Delegate = nativeLibrary.loadFunction("SDL_PollEvent")!;
        SDL_CreateWindow_Func_Delegate = nativeLibrary.loadFunction("SDL_CreateWindow")!;
        SDL_DestroyWindow_Func_Delegate = nativeLibrary.loadFunction("SDL_DestroyWindow")!;
        SDL_GetWindowID_Func_Delegate = nativeLibrary.loadFunction("SDL_GetWindowID")!;
    }

    private typealias SDL_Init_Func = @convention(c) (_ flags: UInt32) -> Int32;
    private var SDL_Init_Func_Delegate: SDL_Init_Func; 
    public func SDL_Init(_ flags: UInt32) -> Int32{
        return SDL_Init_Func_Delegate(flags);
    }

    private typealias SDL_Quit_Func = @convention(c) () -> Void;
    private var SDL_Quit_Func_Delegate: SDL_Quit_Func;
    public func SDL_Quit() -> Void
    {
        return SDL_Quit_Func_Delegate();
    }

    private typealias SDL_PollEvent_Func = @convention(c) (_ event: UnsafeMutablePointer<SDL_Event>) -> Int32;
    private var SDL_PollEvent_Func_Delegate: SDL_PollEvent_Func;
    public func SDL_PollEvent(_ event: UnsafeMutablePointer<SDL_Event>) -> Int32
    {
        return SDL_PollEvent_Func_Delegate(event);
    }

    private typealias SDL_CreateWindow_Func = @convention(c) (_ title: UnsafePointer<CChar>, _ x: Int32, _ y: Int32, _ w: Int32, _ h: Int32, _ flags: SDL_WindowFlags) -> UnsafeMutablePointer<SDL_Window>;
    private var SDL_CreateWindow_Func_Delegate: SDL_CreateWindow_Func;
    public func SDL_CreateWindow(_ title: UnsafePointer<CChar>, _ x: Int32, _ y: Int32, _ w: Int32, _ h: Int32, _ flags: SDL_WindowFlags) -> UnsafeMutablePointer<SDL_Window>{
        return SDL_CreateWindow_Func_Delegate(title, x, y, w, h, flags);
    }
    
    private typealias SDL_DestroyWindow_Func = @convention(c) (_ window: UnsafeMutablePointer<SDL_Window>) -> Void;
    private var SDL_DestroyWindow_Func_Delegate: SDL_DestroyWindow_Func;
    public func SDL_DestroyWindow(_ window: UnsafeMutablePointer<SDL_Window>) -> Void {
        return SDL_DestroyWindow_Func_Delegate(window);
    }

    private typealias SDL_GetWindowID_Func = @convention(c) (_ window: UnsafeMutablePointer<SDL_Window>) -> UInt32;
    private var SDL_GetWindowID_Func_Delegate: SDL_GetWindowID_Func;
    public func SDL_GetWindowID(_ window: UnsafeMutablePointer<SDL_Window>) -> UInt32{
        return SDL_GetWindowID_Func_Delegate(window);
    }
}