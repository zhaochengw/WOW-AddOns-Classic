-- This file is WoW exclusive, so no need for WoW versus non-WoW tests

assert(LibStub, "LibStub is not loaded")
local sha1 = LibStub("LibSHA1")
assert(sha1, "LibSHA1 is not initialized. Please load using the LibSHA1.xml file (for use as a library) or LibSHA1.toc (if validating and benchmarking).")

-- Check if this file has already been processed
if sha1.ops then return end

sha1.DebugPrint("Starting wow-bit-ops.lua")

local bit = bit

local ops = {}

local band = bit.band
local bor = bit.bor
local bxor = bit.bxor

-- bit.rol is not defined in WoW - it's not documented in the Wiki, and verified not to exist in game:
-- https://wow.gamepedia.com/Lua_functions#Bit_Functions
ops.uint32_lrot = bit.rol or function(a, bits)
      local power = 2 ^ bits
      local inv_power = 4294967296 / power
      local lower_bits = a % inv_power
      return (lower_bits * power) + ((a - lower_bits) / inv_power)
   end
ops.byte_xor = bxor
ops.uint32_xor_3 = bxor
ops.uint32_xor_4 = bxor

function ops.uint32_ternary(a, b, c)
   -- c ~ (a & (b ~ c)) has less bitwise operations than (a & b) | (~a & c).
   return bxor(c, band(a, bxor(b, c)))
end

function ops.uint32_majority(a, b, c)
   -- (a & (b | c)) | (b & c) has less bitwise operations than (a & b) | (a & c) | (b & c).
   return bor(band(a, bor(b, c)), band(b, c))
end

-- This file is only used for WoW, so no need to return as a general Lua module
sha1.ops = ops
sha1.DebugPrint("Ending wow-bit-ops.lua")
