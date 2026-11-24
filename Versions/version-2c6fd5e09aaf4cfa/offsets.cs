public static class AttrOffsets
{
    public static class Attribute
    {
        public const long ArrayField = 0x8;
        public const long CountField = 0x10;
        public const long Hops = 0x3;
        public const long Step = 0x58;

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
        public const long Color3 = 0x8D8A770;
        public const long String = 0x8D898D0;
        public const long String_68 = 0x8D8A900;
        public const long Vector3 = 0x8D8A9A0;
    }
}
