Abstract Lua VM Memory Structure Dumper
A lightweight, passive Lua utility designed for scanning, analyzing, and documenting object alignment patterns and MSVC container structures within custom Lua virtual machine (VM) environments.

This script is intended exclusively for reverse engineering your own Lua modifications, mapping out memory layouts, and building custom programming languages based on Lua.

⚠️ Disclaimer & Technical Notice
Environment Agnostic: This project is designed strictly for generic, custom-built Lua VM environments that expose low-level memory inspection APIs.

No Third-Party Affiliation: This repository and its source code are NOT associated, affiliated, or connected with any commercial video games, proprietary gaming platforms, or specific anti-cheat software. It is an independent tool for general reverse engineering and virtual machine research.

No Exploitation Capabilities: This script contains absolutely no code for process injection, memory patching, hook bypassing, or unauthorized access. It is a purely passive analytical tool that relies entirely on host-provided functions.

Educational Purpose: Provided strictly "as-is" for computer science research, static analysis, and understanding data layout structures in memory.

Overview
The script automates pattern recognition within an active runtime to locate structural offsets and type definitions:

Heuristic Pointer Validation: Evaluates memory boundaries and pointer validity to avoid segmentation faults.

MSVC String Parsing: Automatically detects and reconstructs MSVC-style string layouts (Small String Optimization vs. Heap allocations) from raw memory.

Container Brute-Forcing: Analyzes map/vector headers to dynamically determine element step sizes (ATTR_STEP) and object offsets (ATTR_OFF). Supports multiple internal engine layouts (e.g., std::unordered_map and std::vector variations).

Multi-Format Export: Parses the discovered container structure and TypeID maps directly into structured C#, JSON, and C++ (HPP) configuration blocks for easy integration into your project.

Features
Layout Auto-Detection: Differentiates between contiguous vector arrays and hash-map bucket arrays based on size/capacity metadata.

TypeID Classification: Identifies primitives (Double, Bool, String, Vector2/3, CFrame, Color3, UDim, etc.) by analyzing raw byte patterns and pointer dereferences.

RVA Calculation: Automatically calculates Relative Virtual Addresses (RVA) by subtracting the module base address from absolute pointers, ensuring the output survives ASLR.

Zero Hardcoding: Discovers Attribute.Container, Attribute.Step, and TypeID mappings dynamically based on the provided memory API.
