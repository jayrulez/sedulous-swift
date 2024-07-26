#if os(Windows)
import WinSDK
#endif

internal protocol NativeLibrary
{
    func loadFunction<T>(_ name: String) -> T?;
}

internal func createNativeLibrary(_ name: String) -> some NativeLibrary
{
    #if os(Windows)
    return Win32NativeLibrary.init(name);
    #else
    fatalError("NativeLibrary not implemented for the current OS.");
    #endif
}

#if os(Windows)
internal class Win32NativeLibrary : NativeLibrary
{
    private var library: HMODULE;

    public init(_ name: String)
    {
        let module: HMODULE? = LoadLibraryA(name);
        if(module == nil)
        {
            fatalError("Failed to load library \(name)");
        }

        self.library = module!;
    }

    deinit
    {
        FreeLibrary(library);
    }

    public func loadFunction<T>(_ name: String) -> T?
    {
        let proc: FARPROC? = GetProcAddress(library, name);
        if(proc == nil)
        {
            return nil;
        }

        return unsafeBitCast(proc, to: T.self);
    }
}
#endif