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
        constexpr uintptr_t Bool           = 0x8EF48F0;
        constexpr uintptr_t Color3_48      = 0x8EECAF0;
        constexpr uintptr_t Color3_96      = 0x8E3E7A0;
        constexpr uintptr_t Double         = 0x8EED480;
        constexpr uintptr_t String         = 0x8EED4D0;
        constexpr uintptr_t Vector3_36     = 0x8EED570;
        constexpr uintptr_t Vector3_92     = 0x8EEDB20;
        constexpr uintptr_t Vector3_56     = 0x8EED520;
        constexpr uintptr_t Vector3_68     = 0x8EECC30;
        constexpr uintptr_t Vector3_88     = 0x8EECBE0;
        constexpr uintptr_t Vector3_76     = 0x8EED340;
        constexpr uintptr_t Vector3_16     = 0x8EED750;
        constexpr uintptr_t Vector3_92     = 0x8EEC860;
        constexpr uintptr_t Vector3_96     = 0x8EED7A0;
    }
}
