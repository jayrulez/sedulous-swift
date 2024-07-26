import SedulousRHI
//import Vulkan
import CVulkan

public final class VulkanGraphicsDevice : GraphicsDevice
{

    public let instance: VkInstance? = nil;
    public init() {
        var instanceVersion : UInt32 = 0
        var err: VkResult = VK_SUCCESS

        err = vkEnumerateInstanceVersion(&instanceVersion)

        print("Instance version: \(instanceVersion)")
    }
}