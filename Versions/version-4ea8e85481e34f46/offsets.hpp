#pragma once
#include <cstdint>
#include <string>

namespace AttrOffsets {
    inline std::string ClientVersion = "version-4ea8e85481e34f46";

    namespace Attribute {
        inline constexpr uintptr_t ArrayField = 0x8;
        inline constexpr uintptr_t CountField = 0x10;
        inline constexpr uintptr_t Hops = 0x3;
        inline constexpr uintptr_t Step = 0x58;

        namespace Element {
            inline constexpr uintptr_t StringCap = 0x30;
            inline constexpr uintptr_t StringSize = 0x28;
            inline constexpr uintptr_t TypeID = 0x8;
            inline constexpr uintptr_t Value = 0x18;
        }

        namespace KeyPtr {
            inline constexpr uintptr_t Data = 0x0;
            inline constexpr uintptr_t Size = 0x10;
        }
    }

    namespace Instance {
        inline constexpr uintptr_t Attributes = 0x38;
    }

    namespace TypeIds {
        inline constexpr uintptr_t Bool = 0x8F02E80;
        inline constexpr uintptr_t Color3 = 0x8F03060;
        inline constexpr uintptr_t Double = 0x8F030B0;
        inline constexpr uintptr_t String = 0x8F03010;
        inline constexpr uintptr_t Vector3 = 0x8F02FC0;
    }
}
