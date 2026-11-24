local AttrOffsets = {}

AttrOffsets.Attribute = {
    ArrayField = 0x8,
    CountField = 0x10,
    Hops = 0x3,
    Step = 0x58,

    Element = {
        StringCap = 0x30,
        StringSize = 0x28,
        TypeID = 0x8,
        Value = 0x18,
    },
    KeyPtr = {
        Data = 0x0,
        Size = 0x10,
    },
}

AttrOffsets.Instance = {
    Attributes = 0x38,
}

AttrOffsets.TypeIds = {
    Color3 = 0x8D8A770,
    String = 0x8D898D0,
    String_68 = 0x8D8A900,
    Vector3 = 0x8D8A9A0,
}

return AttrOffsets
