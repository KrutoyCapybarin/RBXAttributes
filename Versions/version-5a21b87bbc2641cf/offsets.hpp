#pragma once
#include <cstdint>

namespace AttrOffsets {
    namespace Instance {
        constexpr uintptr_t Attributes = 0x38;
    }

    namespace Attribute {
        constexpr uintptr_t Step = 0x58;

        namespace Element {
            constexpr uintptr_t TypeID     = 0x08;
            constexpr uintptr_t Value      = 0x18;
            constexpr uintptr_t StringSize = 0x28;
            constexpr uintptr_t StringCap  = 0x30;
        }

        namespace KeyPtr {
            constexpr uintptr_t Data = 0x00;
            constexpr uintptr_t Size = 0x10;
        }
    }

    namespace TypeIds {
        constexpr uintptr_t Bool_96        = 0x8C8F850;
        constexpr uintptr_t Bool_36        = 0x8C88280;
        constexpr uintptr_t Color3         = 0x8C87A30;
        constexpr uintptr_t Double         = 0x8C883C0;
        constexpr uintptr_t String         = 0x8C88410;
        constexpr uintptr_t Vector3_48     = 0x8C87B20;
        constexpr uintptr_t Vector3_96     = 0x8C884B0;
        constexpr uintptr_t Vector3_16     = 0x8C88460;
        constexpr uintptr_t Vector3_52     = 0x8C877A0;
        constexpr uintptr_t Vector3_28     = 0x8C87B70;
        constexpr uintptr_t Vector3_56     = 0x8C886E0;
        constexpr uintptr_t Vector3_0      = 0x8BD63E0;
        constexpr uintptr_t Vector3_76     = 0x8C88690;
        constexpr uintptr_t Vector3_52     = 0x8C88A60;
    }
}
