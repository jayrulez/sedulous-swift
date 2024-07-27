import Foundation

/// Surface info struct.
public struct SurfaceInfo: Equatable, Hashable {
    /// Surface technologies.
    public enum SurfaceTypes {
        /// Window forms
        case forms
        /// Windows Presentation Foundation.
        case WPF
        /// Wayland window system
        case wayland
        /// Simple DirectMedia Layer
        case SDL
        /// Android System
        case android
        /// IOS System
        case IOS
        /// UWP System
        case UWP
        /// WinUI system.
        case WinUI
        /// Web System.
        case web
        /// Mixed Reality.
        case mixedReality
        /// Mac OS.
        case macOS
    }

    /// Surface type.
    public var type: SurfaceTypes

    /// Surface native handles.
    public var handles: [UnsafeRawPointer]

    /// Native surface objects.
    public var nativeSurfaceObjects: [Any]

    /// Initializes a new instance of the `SurfaceInfo` struct.
    /// - Parameters:
    ///   - handle: Surface native handle.
    ///   - type: Surface type.
    public init(handle: UnsafeRawPointer, type: SurfaceTypes) {
        self.init(handles: [handle], type: type)
    }

    /// Initializes a new instance of the `SurfaceInfo` struct.
    /// - Parameters:
    ///   - handles: Surface native handles.
    ///   - type: Surface type.
    ///   - nativeSurfaceObjects: Native surface objects.
    public init(handles: [UnsafeRawPointer], type: SurfaceTypes, nativeSurfaceObjects: Any...) {
        self.handles = handles
        self.type = type
        self.nativeSurfaceObjects = nativeSurfaceObjects
    }

    public static func ==(lhs: SurfaceInfo, rhs: SurfaceInfo) -> Bool {
        return lhs.handles == rhs.handles && lhs.type == rhs.type
    }

    public func hash(into hasher: inout Hasher) {
        for handle in handles {
            hasher.combine(UInt(bitPattern: handle))
        }
        hasher.combine(type)
    }
}
