import CSDL2

public typealias SDL_Window = OpaquePointer;

internal protocol SDL2Implementation
{
    func SDL_Init(_ flags: UInt32) -> Int32;
    func SDL_Quit() -> Void;
    func SDL_PollEvent(_ event: UnsafeMutablePointer<SDL_Event>) -> Int32;
    func SDL_CreateWindow(_ title: UnsafePointer<CChar>, _ x: Int32, _ y: Int32, _ w: Int32, _ h: Int32, _ flags: SDL_WindowFlags) -> UnsafeMutablePointer<SDL_Window>;
    func SDL_DestroyWindow(_ window: UnsafeMutablePointer<SDL_Window>) -> Void;
}