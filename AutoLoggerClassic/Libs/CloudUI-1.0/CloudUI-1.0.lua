-- Constants.
local MAJOR = "CloudUI-1.0"
local MINOR = "1"

assert(LibStub, MAJOR .. " requires LibStub")
local CUI = LibStub:NewLibrary(MAJOR, MINOR)
if not CUI then
    -- Newer or same version already exists.
    return
end

-- Variables.
local widgetVersions = {}

-- Returns an enum with the given values.
local function Enum(t)
    for i = 1, #t do
        t[t[i]] = i
    end
    return t
end

-- Initializes enums.
local function InitEnums()
    CUI.templates = Enum({
        "DisableableFrameTemplate",
        "BackgroundFrameTemplate",
        "BorderedFrameTemplate",
        "HighlightFrameTemplate",
        "PushableFrameTemplate"
    })
end

-- Initialize the library.
local function Init()
    InitEnums()
end

-- Returns the current version of the given widget type. Returns 0 if no widget of that type has been registered.
function CUI:GetWidgetVersion(type)
    return widgetVersions[type] or 0
end

-- Registers the given version for the given widget type.
function CUI:RegisterWidgetVersion(type, version)
    widgetVersions[type] = version
end

Init()
