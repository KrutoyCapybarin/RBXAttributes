--[[
!!!HEADS UP!!!

Hey little skid, before skidding it you need to understand that this script-
- requires a ready-to-use enviroment, which you probably do not have.

This file has 90% chance of not being useful to you. 
Instead, check out 

]]
local hex = function(n) return string.format("0x%X", n) end
local rdP = function(a) return memory_read("uintptr_t", a) end
local rdU = function(a) return memory_read("uintptr_t", a) end
local rdS = function(a) return memory_read("string", a) end
local rdD = function(a) return memory_read("double", a) end
local rdf = function(a) return memory_read("float", a) end
local rdi = function(a) return memory_read("int", a) end
local isPtr = function(v) return v > 0x10000 and v < 0x7FFFFFFFFFFF end

local function addrOf(inst)
    if type(inst) ~= "table" then return 0 end
    local a = rawget(inst, "__addr")
    if type(a) ~= "number" then
        local ok, x = pcall(function() return inst.Address end)
        a = ok and x or 0
    end
    return type(a) == "number" and a or 0
end

local function readMsvcStr(a)
    local sz = rdU(a + 0x10)
    if sz > 4096 then return nil end
    local d
    if sz == 0 then d = ""
    elseif sz <= 15 then d = rdS(a) or ""
    else local p = rdP(a); if not isPtr(p) then return nil end; d = rdS(p) or "" end
    if #d ~= sz then return nil end
    return d
end

local function containerAt(addr, off)
    local p1 = rdP(addr + off); if not isPtr(p1) then return nil end
    local p2 = rdP(p1);          if not isPtr(p2) then return nil end
    local p3 = rdP(p2);          if not isPtr(p3) then return nil end
    local cntA = rdU(p3 + 0x10) % 0x100000000
    local arrA = rdP(p3 + 0x08)
    if cntA > 0 and cntA < 256 and isPtr(arrA) then return { count=cntA, arr=arrA } end
    local cntB = rdU(p3 + 0x08) % 0x100000000
    local arrB = rdP(p3 + 0x18)
    if cntB > 0 and cntB < 256 and isPtr(arrB) then return { count=cntB, arr=arrB } end
end

local function elemAt(e)
    local inn = rdP(e); if not isPtr(inn) then return nil end
    local k = readMsvcStr(inn)
    if not k or #k == 0 or #k > 256 then return nil end
    return { key = k, tid = rdU(e + 0x08) }
end

-- === АВТО-КЛАССИФИКАТОР ТИПОВ ===
local function classifyElem(e)
    -- 1. Проверяем на String (SSO или Heap)
    local sz = rdU(e + 0x28)
    if sz > 0 and sz <= 15 then
        local s = rdS(e + 0x18)
        if s and #s == sz then return "String" end
    elseif sz > 15 and sz < 4096 and isPtr(rdP(e + 0x18)) then
        return "String"
    end

    -- 2. Проверяем на Bool
    local raw = rdU(e + 0x18)
    if raw == 0 or raw == 1 then return "Bool" end

    -- 3. Проверяем на Vector3 / Color3 (3 float)
    local f1, f2, f3 = rdf(e+0x18), rdf(e+0x1C), rdf(e+0x20)
    if f1 == f1 and f2 == f2 and f3 == f3 and math.abs(f1) < 1e6 and math.abs(f2) < 1e6 and math.abs(f3) < 1e6 then
        if f1 >= 0 and f1 <= 1 and f2 >= 0 and f2 <= 1 and f3 >= 0 and f3 <= 1 then
            return "Color3"
        end
        return "Vector3"
    end

    -- 4. Checking for Vector2 (2 float)
    local f4 = rdf(e+0x24)
    if f1 == f1 and f2 == f2 and math.abs(f1) < 1e6 and math.abs(f2) < 1e6 and f4 ~= f4 then
        return "Vector2"
    end

    -- 5. Checking for Double
    local d = rdD(e + 0x18)
    if d == d and math.abs(d) < 1e15 and (d == 0 or math.abs(d) > 1e-30) then
        return "Double"
    end

    return "Unknown"
end

print("[CapyWareAttributeDump] waiting for game...")
task.wait(3)

local insts, seen = {}, {}
local function addInst(inst)
    local a = addrOf(inst)
    if a > 0 and not seen[a] then seen[a] = true; insts[#insts+1] = a end
end
local function walk(n, d)
    if #insts >= 3000 or d > 5 then return end
    addInst(n)
    local ok, kids = pcall(function() return n:GetChildren() end)
    if not ok then return end
    for _, c in ipairs(kids) do walk(c, d + 1) end
end
pcall(function() walk(workspace, 0) end)
pcall(function() walk(game:GetService("Players"), 0) end)

print("[CapyWareAttributeDump] scanning ATTR_OFF...")
local bestOff, bestScore = nil, 0
for _, off in ipairs({0x28,0x30,0x38,0x40,0x48,0x50,0x58,0x60,0x68,0x70,0x78}) do
    local withData = 0
    for _, a in ipairs(insts) do
        local c = containerAt(a, off)
        if c and c.count > 0 then withData = withData + 1 end
    end
    if withData > bestScore then bestScore, bestOff = withData, off end
end
if not bestOff or bestScore == 0 then print("[dump] FAIL: no ATTR_OFF"); return end
print("[CapyWareAttributeDump] ATTR_OFF = " .. hex(bestOff))

print("[CapyWareAttributeDump] scanning ATTR_STEP...")
local bestStep, bestRatio = nil, 0
for _, step in ipairs({0x20,0x28,0x30,0x38,0x40,0x48,0x50,0x58,0x60,0x68,0x70,0x78}) do
    local ck, okn = 0, 0
    for _, a in ipairs(insts) do
        local c = containerAt(a, bestOff)
        if c and c.count > 0 then
            for i = 0, math.min(c.count, 8) - 1 do
                ck = ck + 1
                if elemAt(c.arr + i * step) then okn = okn + 1 end
            end
            if ck > 500 then break end
        end
    end
    local r = ck > 0 and okn / ck or 0
    if r > bestRatio then bestRatio, bestStep = r, step end
end
if not bestStep or bestRatio < 0.5 then print("[CapyWareAttributeDump] FAIL: no ATTR_STEP"); return end
print("[CapyWareAttributeDump] ATTR_STEP = " .. hex(bestStep))

-- Collecting TID and its first values
local uniqueTids = {}
for _, a in ipairs(insts) do
    local c = containerAt(a, bestOff)
    if c and c.count > 0 then
        for i = 0, math.min(c.count, 32) - 1 do
            local e = c.arr + i * bestStep
            local s = elemAt(e)
            if s then
                if not uniqueTids[s.tid] then
                    uniqueTids[s.tid] = { name = classifyElem(e), elem = e }
                end
            end
        end
    end
end

local base = getbase()
local cs_types, json_types, hpp_types = "", "", ""

-- Table should look good yk
local sortedTids = {}
for tid, info in pairs(uniqueTids) do
    table.insert(sortedTids, { tid = tid, name = info.name })
end
table.sort(sortedTids, function(a, b) return a.name < b.name end)

for _, item in ipairs(sortedTids) do
    local rva = item.tid - base
    local name = item.name
    -- If theres multiple types with the same name we are adding a index
    local uniqueName = name
    local count = 0
    for _, t in ipairs(sortedTids) do if t.name == name then count = count + 1 end end
    if count > 1 then uniqueName = name .. "_" .. tostring(rva % 100) end

    cs_types = cs_types .. string.format("            public const long %-14s = 0x%X;\n", uniqueName, rva)
    json_types = json_types .. string.format("      \"%s\": \"0x%X\",\n", uniqueName, rva)
    hpp_types = hpp_types .. string.format("        constexpr uintptr_t %-14s = 0x%X;\n", uniqueName, rva)
end

-- Formating (Without empty commas in JSON)
json_types = json_types:gsub(",\n$", "\n")

local csharp_fmt = string.format([[
public static class AttrOffsets
{
    public static class Instance
    {
        public const long Attributes = 0x%X;
    }

    public static class Attribute
    {
        public const long Step = 0x%X;

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
%s    }
}]], bestOff, bestStep, cs_types)

local json_fmt = string.format([[
{
  "AttrOffsets": {
    "Instance": {
      "Attributes": "0x%X"
    },
    "Attribute": {
      "Step": "0x%X",
      "Element": {
        "TypeID": "0x08",
        "Value": "0x18",
        "StringSize": "0x28",
        "StringCap": "0x30"
      },
      "KeyPtr": {
        "Data": "0x00",
        "Size": "0x10"
      }
    },
    "TypeIds": {
%s    }
  }
}]], bestOff, bestStep, json_types)

local hpp_fmt = string.format([[
#pragma once
#include <cstdint>

namespace AttrOffsets {
    namespace Instance {
        constexpr uintptr_t Attributes = 0x%X;
    }

    namespace Attribute {
        constexpr uintptr_t Step = 0x%X;

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
%s    }
}]], bestOff, bestStep, hpp_types)

-- Печать
print("\n" .. string.rep("=", 60))
print("C# FORMAT")
print(string.rep("=", 60) .. "\n")
print(csharp_fmt)

print("\n" .. string.rep("=", 60))
print("JSON FORMAT")
print(string.rep("=", 60) .. "\n")
print(json_fmt)

print("\n" .. string.rep("=", 60))
print("HPP FORMAT")
print(string.rep("=", 60) .. "\n")
print(hpp_fmt)

print("CapyWareAttributeDump: I think we did a pretty good job so far - Mathieu Côté")
