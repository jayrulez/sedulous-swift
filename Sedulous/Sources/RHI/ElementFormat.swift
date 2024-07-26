import Foundation

/// Vertex element format.
enum ElementFormat: Int {
    /// One unsigned 8-bit value.
    case uByte
    /// Two unsigned 8-bit values.
    case uByte2
    /// Three unsigned 8-bit values.
    case uByte3
    /// Four unsigned 8-bit values.
    case uByte4
    /// One signed 8-bit value.
    case byte
    /// Two signed 8-bits values.
    case byte2
    /// Three signed 8-bit values.
    case byte3
    /// Four signed 8-bit values.
    case byte4
    /// One unsigned normalized 8-bit value.
    case uByteNormalized
    /// Two unsigned normalized 8-bit values.
    case uByte2Normalized
    /// Three unsigned normalized 8-bit values.
    case uByte3Normalized
    /// Four unsigned normalized 8-bit values.
    case uByte4Normalized
    /// One signed normalized 8-bit value.
    case byteNormalized
    /// Two signed normalized 8-bit values.
    case byte2Normalized
    /// Three signed normalized 8-bit values.
    case byte3Normalized
    /// Four signed normalized 8-bit values.
    case byte4Normalized
    /// One unsigned 16-bit value.
    case uShort
    /// Two unsigned 16-bit values.
    case uShort2
    /// Three unsigned 16-bit values.
    case uShort3
    /// Four unsigned 16-bit values.
    case uShort4
    /// One signed 16-bit value.
    case short
    /// Two signed 16-bit values.
    case short2
    /// Three signed 16-bit values.
    case short3
    /// Four signed 16-bit values.
    case short4
    /// One unsigned normalized 16-bit value.
    case uShortNormalized
    /// Two unsigned normalized 16-bit values.
    case uShort2Normalized
    /// Three unsigned normalized 16-bit values.
    case uShort3Normalized
    /// Four unsigned normalized 16-bit values.
    case uShort4Normalized
    /// One signed normalized 16-bit value.
    case shortNormalized
    /// Two signed normalized 16-bit values.
    case short2Normalized
    /// Three signed normalized 16-bit values.
    case short3Normalized
    /// Four signed normalized 16-bit values.
    case short4Normalized
    /// One half-precision floating-point value.
    case half
    /// Two half-precision floating-point value.
    case half2
    /// Three half-precision floating-point value.
    case half3
    /// Four half-precision floating-point value.
    case half4
    /// A single-component, 32-bit floating-point format that supports 32 bits for the red channel.
    case float
    /// A two-component, 64-bit floating-point format that supports 32 bits for the red channel and 32 bits for the green channel.
    case float2
    /// A three-component, 96-bit floating-point format that supports 32 bits per color channel.
    case float3
    /// A four-component, 128-bit floating-point format that supports 32 bits per channel including alpha.
    case float4
    /// One unsigned 32-bit integer values.
    case uInt
    /// Two unsigned 32-bit integer values.
    case uInt2
    /// Three unsigned 32-bit integer values.
    case uInt3
    /// Four unsigned 32-bit integer values.
    case uInt4
    /// One signed 32-bit integer value.
    case int
    /// Two signed 32-bit integer values.
    case int2
    /// Three signed 32-bit integer values.
    case int3
    /// Four signed 32-bit integer values.
    case int4
}
