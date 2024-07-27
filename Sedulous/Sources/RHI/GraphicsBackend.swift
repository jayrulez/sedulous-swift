/// The specify graphics low level API used by the `GraphicsContext`.
public enum GraphicsBackend: UInt8 {
    /// DirectX 11
    case directX11 = 0
    /// DirectX 12
    case directX12 = 1
    /// OpenGL 4
    case openGL = 2
    /// OpenGL ES 3.0
    case openGLES = 3
    /// Metal 2.0
    case metal = 4
    /// Vulkan 1.1
    case vulkan = 5
    /// WebGL 1.0
    case webGL1 = 6
    /// WebGL 2.0
    case webGL2 = 7
    /// WebGPU 1.0
    case webGPU = 8
}
