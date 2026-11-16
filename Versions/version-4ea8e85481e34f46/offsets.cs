public static class AttrOffsets
{
    public static class Attribute
    {
        public const long ArrayField = 0x8;
        public const long CountField = 0x10;
        public const long Hops = 0x3;
        public const long Step = 0x20;

        public static class Element
        {
            public const long StringCap = 0x30;
            public const long StringSize = 0x28;
            public const long TypeID = 0x8;
            public const long Value = 0x18;
        }

        public static class KeyPtr
        {
            public const long Data = 0x0;
            public const long Size = 0x10;
        }
    }

    public static class Instance
    {
        public const long Attributes = 0x38;
    }

    public static class TypeIds
    {
        public const long Bool = 0x8F02E80;
        public const long Color3 = 0x8F03060;
        public const long Double = 0x8F02FC0;
        public const long String = 0x8F03010;
        public const long Vector3 = 0x8F030B0;
    }
}
