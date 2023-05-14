local major, minor = _G['BMUtils-Version'].parse_version('v0.11')
---@class LibProfessionsCommon
local lib = _G.LibStub:NewLibrary("LibProfessions-" .. major, minor)
if not lib then
    -- luacov: disable
    return    -- already loaded and no upgrade necessary
    -- luacov: enable
end
_G['LibProfessions-v0.11'] = lib

lib.name = ...
lib.version = 'v0.11'
---@type BMUtils
lib.utils = _G.LibStub("BM-utils-1")
---@type boolean Is WoW Classic
lib.is_classic = lib.utils:IsWoWClassic()
lib.is_classic_era = lib.utils:IsWoWClassic(false)
lib.is_bcc = lib.is_classic ~= lib.is_classic_era

---@type LibProfessionsCurrentProfession
lib.currentProfession = {}
---@type LibProfessionAPI
lib.api = {}