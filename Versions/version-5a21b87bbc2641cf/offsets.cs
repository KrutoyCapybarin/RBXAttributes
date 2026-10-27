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
            public const long Bool_96        = 0x8C8F850;
            public const long Bool_36        = 0x8C88280;
            public const long Color3         = 0x8C87A30;
            public const long Double         = 0x8C883C0;
            public const long String         = 0x8C88410;
            public const long Vector3_48     = 0x8C87B20;
            public const long Vector3_96     = 0x8C884B0;
            public const long Vector3_16     = 0x8C88460;
            public const long Vector3_52     = 0x8C877A0;
            public const long Vector3_28     = 0x8C87B70;
            public const long Vector3_56     = 0x8C886E0;
            public const long Vector3_0      = 0x8BD63E0;
            public const long Vector3_76     = 0x8C88690;
            public const long Vector3_52     = 0x8C88A60;
    }
}
