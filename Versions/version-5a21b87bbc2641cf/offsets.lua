local AttrOffsets = {}

AttrOffsets.Instance = {
    Attributes = 0x38,
}

AttrOffsets.Attribute = {
    Step = 0x58,

    Element = {
        TypeID     = 0x08,
        Value      = 0x18,
        StringSize = 0x28,
        StringCap  = 0x30,
    },

    KeyPtr = {
        Data = 0x00,
        Size = 0x10,
    },
}

AttrOffsets.TypeIds = {
    Bool_96     = 0x8C8F850,
    Bool_36     = 0x8C88280,
    Color3      = 0x8C87A30,
    Double      = 0x8C883C0,
    String      = 0x8C88410,
    Vector3_48  = 0x8C87B20,
    Vector3_96  = 0x8C884B0,
    Vector3_16  = 0x8C88460,
    Vector3_52  = 0x8C877A0,
    Vector3_28  = 0x8C87B70,
    Vector3_56  = 0x8C886E0,
    Vector3_0   = 0x8BD63E0,
    Vector3_76  = 0x8C88690,
    Vector3_52b = 0x8C88A60,
}

return AttrOffsets
