-- This file is WoW exclusive, so no need for WoW versus non-WoW tests

-- Ensure LibStub is available.
local MAJOR, MINOR = "LibSHA1", 3
assert(LibStub, MAJOR .. " requires LibStub")

-- Create and register the library.
local sha1, oldversion = LibStub:NewLibrary(MAJOR, MINOR)
if not sha1 then return end


-- Set up debug functions and code
sha1.DEBUGMODE = false


function sha1.DebugPrint(...)
    if not sha1.DEBUGMODE then return end
    print (...)
end -- DebugPrint()
