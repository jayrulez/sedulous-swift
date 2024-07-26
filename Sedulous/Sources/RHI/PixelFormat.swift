import Foundation

/// Pixel format type.
enum PixelFormat: Int {
    /// The format is not known.
    case Unknown
    /// A four-component, 128-bit typeless format that supports 32 bits per channel including alpha. 1
    case R32G32B32A32_Typeless
    /// A four-component, 128-bit floating-point format that supports 32 bits per channel including alpha. 1
    case R32G32B32A32_Float
    /// A four-component, 128-bit unsigned-integer format that supports 32 bits per channel including alpha. 1
    case R32G32B32A32_UInt
    /// A four-component, 128-bit signed-integer format that supports 32 bits per channel including alpha. 1
    case R32G32B32A32_SInt
    /// A three-component, 96-bit typeless format that supports 32 bits per color channel.
    case R32G32B32_Typeless
    /// A three-component, 96-bit floating-point format that supports 32 bits per color channel.
    case R32G32B32_Float
    /// A three-component, 96-bit unsigned-integer format that supports 32 bits per color channel.
    case R32G32B32_UInt
    /// A three-component, 96-bit signed-integer format that supports 32 bits per color channel.
    case R32G32B32_SInt
    /// A four-component, 64-bit typeless format that supports 16 bits per channel including alpha.
    case R16G16B16A16_Typeless
    /// A four-component, 64-bit floating-point format that supports 16 bits per channel including alpha.
    case R16G16B16A16_Float
    /// A four-component, 64-bit unsigned-normalized-integer format that supports 16 bits per channel including alpha.
    case R16G16B16A16_UNorm
    /// A four-component, 64-bit unsigned-integer format that supports 16 bits per channel including alpha.
    case R16G16B16A16_UInt
    /// A four-component, 64-bit signed-normalized-integer format that supports 16 bits per channel including alpha.
    case R16G16B16A16_SNorm
    /// A four-component, 64-bit signed-integer format that supports 16 bits per channel including alpha.
    case R16G16B16A16_SInt
    /// A two-component, 64-bit typeless format that supports 32 bits for the red channel and 32 bits for the green channel.
    case R32G32_Typeless
    /// A two-component, 64-bit floating-point format that supports 32 bits for the red channel and 32 bits for the green channel.
    case R32G32_Float
    /// A two-component, 64-bit unsigned-integer format that supports 32 bits for the red channel and 32 bits for the green channel.
    case R32G32_UInt
    /// A two-component, 64-bit signed-integer format that supports 32 bits for the red channel and 32 bits for the green channel.
    case R32G32_SInt
    /// A two-component, 64-bit typeless format that supports 32 bits for the red channel, 8 bits for the green channel, and 24 bits are unused.
    case R32G8X24_Typeless
    /// A 32-bit floating-point component, and two unsigned-integer components (with an additional 32 bits). This format supports 32-bit depth, 8-bit stencil, and 24 bits are unused.
    case D32_Float_S8X24_UInt
    /// A 32-bit floating-point component, and two typeless components (with an additional 32 bits). This format supports 32-bit red channel, 8 bits are unused, and 24 bits are unused.
    case R32_Float_X8X24_Typeless
    /// A 32-bit typeless component, and two unsigned-integer components (with an additional 32 bits). This format has 32 bits unused, 8 bits for green channel, and 24 bits are unused.
    case X32_Typeless_G8X24_UInt
    /// A four-component, 32-bit typeless format that supports 10 bits for each color and 2 bits for alpha.
    case R10G10B10A2_Typeless
    /// A four-component, 32-bit unsigned-normalized-integer format that supports 10 bits for each color and 2 bits for alpha.
    case R10G10B10A2_UNorm
    /// A four-component, 32-bit unsigned-integer format that supports 10 bits for each color and 2 bits for alpha.
    case R10G10B10A2_UInt
    /// Three partial-precision floating-point numbers encoded into a single 32-bit value (a variant of s10e5, which is sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There are no sign bits, and there is a 5-bit biased (15) exponent for each channel, 6-bit mantissa for R and G, and a 5-bit mantissa for B, as shown in the following illustration.
    case R11G11B10_Float
    /// A four-component, 32-bit typeless format that supports 8 bits per channel including alpha.
    case R8G8B8A8_Typeless
    /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits per channel including alpha.
    case R8G8B8A8_UNorm
    /// A four-component, 32-bit unsigned-normalized integer sRGB format that supports 8 bits per channel including alpha.
    case R8G8B8A8_UNorm_SRgb
    /// A four-component, 32-bit unsigned-integer format that supports 8 bits per channel including alpha.
    case R8G8B8A8_UInt
    /// A four-component, 32-bit signed-normalized-integer format that supports 8 bits per channel including alpha.
    case R8G8B8A8_SNorm
    /// A four-component, 32-bit signed-integer format that supports 8 bits per channel including alpha.
    case R8G8B8A8_SInt
    /// A two-component, 32-bit typeless format that supports 16 bits for the red channel and 16 bits for the green channel.
    case R16G16_Typeless
    /// A two-component, 32-bit floating-point format that supports 16 bits for the red channel and 16 bits for the green channel.
    case R16G16_Float
    /// A two-component, 32-bit unsigned-normalized-integer format that supports 16 bits each for the green and red channels.
    case R16G16_UNorm
    /// A two-component, 32-bit unsigned-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
    case R16G16_UInt
    /// A two-component, 32-bit signed-normalized-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
    case R16G16_SNorm
    /// A two-component, 32-bit signed-integer format that supports 16 bits for the red channel and 16 bits for the green channel.
    case R16G16_SInt
    /// A single-component, 32-bit typeless format that supports 32 bits for the red channel.
    case R32_Typeless
    /// A single-component, 32-bit floating-point format that supports 32 bits for depth.
    case D32_Float
    /// A single-component, 32-bit floating-point format that supports 32 bits for the red channel.
    case R32_Float
    /// A single-component, 32-bit unsigned-integer format that supports 32 bits for the red channel.
    case R32_UInt
    /// A single-component, 32-bit signed-integer format that supports 32 bits for the red channel.
    case R32_SInt
    /// A two-component, 32-bit typeless format that supports 24 bits for the red channel and 8 bits for the green channel.
    case R24G8_Typeless
    /// A 32-bit z-buffer format that supports 24 bits for depth and 8 bits for stencil.
    case D24_UNorm_S8_UInt
    /// A 32-bit format, that contains a 24 bit, single-component, unsigned-normalized integer, with an additional typeless 8 bits. This format has 24 bits red channel and 8 bits unused.
    case R24_UNorm_X8_Typeless
    /// A 32-bit format, that contains a 24 bit, single-component, typeless format, with an additional 8 bit unsigned integer component. This format has 24 bits unused and 8 bits green channel.
    case X24_Typeless_G8_UInt
    /// A two-component, 16-bit typeless format that supports 8 bits for the red channel and 8 bits for the green channel.
    case R8G8_Typeless
    /// A two-component, 16-bit unsigned-normalized-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
    case R8G8_UNorm
    /// A two-component, 16-bit unsigned-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
    case R8G8_UInt
    /// A two-component, 16-bit signed-normalized-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
    case R8G8_SNorm
    /// A two-component, 16-bit signed-integer format that supports 8 bits for the red channel and 8 bits for the green channel.
    case R8G8_SInt
    /// A single-component, 16-bit typeless format that supports 16 bits for the red channel.
    case R16_Typeless
    /// A single-component, 16-bit floating-point format that supports 16 bits for the red channel.
    case R16_Float
    /// A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for depth.
    case D16_UNorm
    /// A single-component, 16-bit unsigned-normalized-integer format that supports 16 bits for the red channel.
    case R16_UNorm
    /// A single-component, 16-bit unsigned-integer format that supports 16 bits for the red channel.
    case R16_UInt
    /// A single-component, 16-bit signed-normalized-integer format that supports 16 bits for the red channel.
    case R16_SNorm
    /// A single-component, 16-bit signed-integer format that supports 16 bits for the red channel.
    case R16_SInt
    /// A single-component, 8-bit typeless format that supports 8 bits for the red channel.
    case R8_Typeless
    /// A single-component, 8-bit unsigned-normalized-integer format that supports 8 bits for the red channel.
    case R8_UNorm
    /// A single-component, 8-bit unsigned-integer format that supports 8 bits for the red channel.
    case R8_UInt
    /// A single-component, 8-bit signed-normalized-integer format that supports 8 bits for the red channel.
    case R8_SNorm
    /// A single-component, 8-bit signed-integer format that supports 8 bits for the red channel.
    case R8_SInt
    /// A single-component, 8-bit unsigned-normalized-integer format for alpha only.
    case A8_UNorm
    /// A single-component, 1-bit unsigned-normalized integer format that supports 1 bit for the red channel. 2.
    case R1_UNorm
    /// Three partial-precision floating-point numbers encoded into a single 32-bit value all sharing the same 5-bit exponent (variant of s10e5, which is sign bit, 10-bit mantissa, and 5-bit biased (15) exponent). There is no sign bit, and there is a shared 5-bit biased (15) exponent and a 9-bit mantissa for each channel, as shown in the following illustration. 2.
    case R9G9B9E5_Sharedexp
    /// A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the UYVY format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are repeated, and the G8 values are unique to each pixel. 3 Width must be even.
    case R8G8_B8G8_UNorm
    /// A four-component, 32-bit unsigned-normalized-integer format. This packed RGB format is analogous to the YUY2 format. Each 32-bit block describes a pair of pixels: (R8, G8, B8) and (R8, G8, B8) where the R8/B8 values are repeated, and the G8 values are unique to each pixel. 3 Width must be even.
    case G8R8_G8B8_UNorm
    /// DXT1 typeless Four-component typeless block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC1_Typeless
    /// DXT 1 Four-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC1_UNorm
    /// Four-component block-compression format for sRGB data. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC1_UNorm_SRgb
    /// Four-component typeless block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC2_Typeless
    /// Four-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC2_UNorm
    /// Four-component block-compression format for sRGB data. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC2_UNorm_SRgb
    /// Four-component typeless block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC3_Typeless
    /// DXT 5 Four-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC3_UNorm
    /// Four-component block-compression format for sRGB data. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC3_UNorm_SRgb
    /// One-component typeless block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC4_Typeless
    /// One-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC4_UNorm
    /// One-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC4_SNorm
    /// Two-component typeless block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC5_Typeless
    /// Two-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC5_UNorm
    /// Two-component block-compression format. For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC5_SNorm
    /// A three-component, 16-bit unsigned-normalized-integer format that supports 5 bits for blue, 6 bits for green, and 5 bits for red. Direct3D 10 through Direct3D 11: This value is defined for DXGI. However, Direct3D 10, 10.1, or 11 devices do not support this format. Direct3D 11.1: This value is not supported until Windows 8.
    case B5G6R5_UNorm
    /// A four-component, 16-bit unsigned-normalized-integer format that supports 5 bits for each color channel and 1-bit alpha. Direct3D 10 through Direct3D 11: This value is defined for DXGI. However, Direct3D 10, 10.1, or 11 devices do not support this format. Direct3D 11.1: This value is not supported until Windows 8.
    case B5G5R5A1_UNorm
    /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8-bit alpha.
    case B8G8R8A8_UNorm
    /// A four-component, 32-bit unsigned-normalized-integer format that supports 8 bits for each color channel and 8 bits unused.
    case B8G8R8X8_UNorm
    /// A four-component, 32-bit 2.8-biased fixed-point format that supports 10 bits for each color channel and 2-bit alpha.
    case R10G10B10_Xr_Bias_A2_UNorm
    /// A four-component, 32-bit typeless format that supports 8 bits for each channel including alpha. 4
    case B8G8R8A8_Typeless
    /// A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each channel including alpha. 4
    case B8G8R8A8_UNorm_SRgb
    /// A four-component, 32-bit typeless format that supports 8 bits for each color channel, and 8 bits are unused. 4
    case B8G8R8X8_Typeless
    /// A four-component, 32-bit unsigned-normalized standard RGB format that supports 8 bits for each color channel, and 8 bits are unused. 4
    case B8G8R8X8_UNorm_SRgb
    /// A typeless block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC6H_Typeless
    /// A block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC6H_Uf16
    /// A block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC6H_Sf16
    /// A typeless block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC7_Typeless
    /// A block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC7_UNorm
    /// A block-compression format. 4 For information about block-compression formats, see Texture Block Compression in Direct3D 11.
    case BC7_UNorm_SRgb
    /// Most common YUV 4:4:4 video resource format. Valid view formats for this video resource format are R8G8B8A8_UNorm and R8G8B8A8_UInt. For UAVs, an additional valid view format is R32_UInt. By using R32_UInt for UAVs, you can both read and write as opposed to just write for R8G8B8A8_UNorm and R8G8B8A8_UInt. Supported view types are SRV, RTV, and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is V->R8, U->G8, Y->B8, and A->A8. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case AYUV
    /// 10-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are R10G10B10A2_UNorm and R10G10B10A2_UInt. For UAVs, an additional valid view format is R32_UInt. By using R32_UInt for UAVs, you can both read and write as opposed to just write for R10G10B10A2_UNorm and R10G10B10A2_UInt. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is U->R10, Y->G10, V->B10, and A->A2. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case Y410
    /// 16-bit per channel packed YUV 4:4:4 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNorm and R16G16B16A16_UInt. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is U->R16, Y->G16, V->B16, and A->A16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case Y416
    /// Most common YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R8_UNorm and R8_UInt. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R8G8_UNorm and R8G8_UInt. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R8. For chrominance data view, the mapping to the view channel is U->R8 and V->G8. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. Direct3D 11.1: This value is not supported until Windows 8.
    case NV12
    /// 10-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R16_UNorm and R16_UInt. The runtime does not enforce whether the lowest 6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required, application shader code would have to enforce this manually. From the runtime's point of view, P010 is no different than P016. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R16G16_UNorm and R16G16_UInt. For UAVs, an additional valid chrominance data view format is R32_UInt. By using R32_UInt for UAVs, you can both read and write as opposed to just write for R16G16_UNorm and R16G16_UInt. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R16. For chrominance data view, the mapping to the view channel is U->R16 and V->G16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. Direct3D 11.1: This value is not supported until Windows 8.
    case P010
    /// 16-bit per channel planar YUV 4:2:0 video resource format. Valid luminance data view formats for this video resource format are R16_UNorm and R16_UInt. Valid chrominance data view formats (width and height are each 1/2 of luminance view) for this video resource format are R16G16_UNorm and R16G16_UInt. For UAVs, an additional valid chrominance data view format is R32_UInt. By using R32_UInt for UAVs, you can both read and write as opposed to just write for R16G16_UNorm and R16G16_UInt. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R16. For chrominance data view, the mapping to the view channel is U->R16 and V->G16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. The first (SysMemPitch * height) bytes are the Y plane, the remaining (SysMemPitch * (height / 2)) bytes are the UV plane. Direct3D 11.1: This value is not supported until Windows 8.
    case P016
    /// 8-bit per channel planar YUV 4:2:0 video resource format. This format is subsampled where each pixel has its own Y value, but each 2x2 pixel block shares a single U and V value. The runtime requires that the width and height of all resources that are created with this format are multiples of 2. The runtime also requires that the left, right, top, and bottom members of any RECT that are used for this format are multiples of 2. This format differs from NV12 in that the layout of the data within the resource is completely opaque to applications. Applications cannot use the CPU to map the resource and then access the data within the resource. You cannot use shaders with this format. Because of this behavior, legacy hardware that supports a non-NV12 4:2:0 layout (for example, YV12, and so on) can be used. Also, new hardware that has a 4:2:0 implementation better than NV12 can be used when the application does not need the data to be in a standard layout. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width and height must be even. Direct3D 11 staging resources and initData parameters for this format use (rowPitch * (height + (height / 2))) bytes. Direct3D 11.1: This value is not supported until Windows 8.
    case Opaque420
    /// Most common YUV 4:2:2 video resource format. Valid view formats for this video resource format are R8G8B8A8_UNorm and R8G8B8A8_UInt. For UAVs, an additional valid view format is R32_UInt. By using R32_UInt for UAVs, you can both read and write as opposed to just write for R8G8B8A8_UNorm and R8G8B8A8_UInt. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R8, U0->G8, Y1->B8, and V0->A8. A unique valid view format for this video resource format is R8G8_B8G8_UNorm. With this view format, the width of the view appears to be twice what the R8G8B8A8_UNorm or R8G8B8A8_UInt view would be when hardware reconstructs RGBA automatically on read and before filtering. This Direct3D hardware behavior is legacy and is likely not useful any more. With this view format, the mapping to the view channel is Y0->R8, U0-> G8[0], Y1->B8, and V0-> G8[1]. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width must be even. Direct3D 11.1: This value is not supported until Windows 8.
    case YUY2
    /// 10-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNorm and R16G16B16A16_UInt. The runtime does not enforce whether the lowest 6 bits are 0 (given that this video resource format is a 10-bit format that uses 16 bits). If required, application shader code would have to enforce this manually. From the runtime's point of view, Y210 is no different than Y216. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R16, U->G16, Y1->B16, and V->A16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width must be even. Direct3D 11.1: This value is not supported until Windows 8.
    case Y210
    /// 16-bit per channel packed YUV 4:2:2 video resource format. Valid view formats for this video resource format are R16G16B16A16_UNorm and R16G16B16A16_UInt. Supported view types are SRV and UAV. One view provides a straightforward mapping of the entire surface. The mapping to the view channel is Y0->R16, U->G16, Y1->B16, and V->A16. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width must be even. Direct3D 11.1: This value is not supported until Windows 8.
    case Y216
    /// Most common planar YUV 4:1:1 video resource format. Valid luminance data view formats for this video resource format are R8_UNorm and R8_UInt. Valid chrominance data view formats (width and height are each 1/4 of luminance view) for this video resource format are R8G8_UNorm and R8G8_UInt. Supported view types are SRV, RTV, and UAV. For luminance data view, the mapping to the view channel is Y->R8. For chrominance data view, the mapping to the view channel is U->R8 and V->G8. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Width must be a multiple of 4. Direct3D11 staging resources and initData parameters for this format use (rowPitch * height * 2) bytes. The first (SysMemPitch * height) bytes are the Y plane, the next ((SysMemPitch / 2) * height) bytes are the UV plane, and the remainder is padding. Direct3D 11.1: This value is not supported until Windows 8.
    case NV11
    /// 4-bit palletized YUV format that is commonly used for DVD subpicture. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case AI44
    /// 4-bit palletized YUV format that is commonly used for DVD subpicture. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case IA44
    /// 8-bit palletized format that is used for palletized RGB data when the processor processes ISDB-T data and for palletized YUV data when the processor processes BluRay data. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case P8
    /// 8-bit palletized format with 8 bits of alpha that is used for palletized YUV data when the processor processes BluRay data. For more info about YUV formats for video rendering, see Recommended 8-Bit YUV Formats for Video Rendering. Direct3D 11.1: This value is not supported until Windows 8.
    case A8P8
    /// A four-component, 16-bit unsigned-normalized integer format that supports 4 bits for each channel including alpha. Direct3D 11.1: This value is not supported until Windows 8.
    case B4G4R4A4_UNorm
    /// Forces this enumeration to compile to 32 bits in size. Without this value, some compilers would allow this enumeration to compile to a size other than 32 bits. This value is not used.
    case P208
    /// No documentation.
    case V208
    /// No documentation.
    case V408
    /// 16-bit RGBA.
    case R4G4B4A4
    /// PVRTC 2bpp rgb.
    case PVRTC_2BPP_RGB
    /// PVRTC 4bpp rgb.
    case PVRTC_4BPP_RGB
    /// PVRTC 2bpp rgba.
    case PVRTC_2BPP_RGBA
    /// PVRTC 4bpp rgba.
    case PVRTC_4BPP_RGBA
    /// PVRTC 2bpp srgb.
    case PVRTC_2BPP_RGB_SRGB
    /// PVRTC 4bpp srgb.
    case PVRTC_4BPP_RGB_SRGB
    /// PVRTC 2bpp srgba.
    case PVRTC_2BPP_RGBA_SRGBA
    /// PVRTC 4bpp srgba.
    case PVRTC_4BPP_RGBA_SRGBA
    /// ETC1.
    case ETC1_RGB8
    /// ETC2.
    case ETC2_RGBA
    /// ETC2 sRgb.
    case ETC2_RGBA_SRGB
}
