public static class AttrOffsets
{
    public static class Instance
    {
        public const long Attributes = 0x38;
    }

    public static class Attribute
    {
        public const long Step = 0x58;

        public static class Element
        {
            public const long TypeID     = 0x08;
            public const long Value      = 0x18;
            public const long StringSize = 0x28;
            public const long StringCap  = 0x30;
        }

        public static class KeyPtr
        {
            public const long Data = 0x00;
            public const long Size = 0x10;
        }
    }

    public static class TypeIds
    {
            public const long Bool           = 0x8EF48F0;
            public const long Color3_48      = 0x8EECAF0;
            public const long Color3_96      = 0x8E3E7A0;
            public const long Double         = 0x8EED480;
            public const long String         = 0x8EED4D0;
            public const long Vector3_36     = 0x8EED570;
            public const long Vector3_92     = 0x8EEDB20;
            public const long Vector3_56     = 0x8EED520;
            public const long Vector3_68     = 0x8EECC30;
            public const long Vector3_88     = 0x8EECBE0;
            public const long Vector3_76     = 0x8EED340;
            public const long Vector3_16     = 0x8EED750;
            public const long Vector3_92     = 0x8EEC860;
            public const long Vector3_96     = 0x8EED7A0;
    }
}
