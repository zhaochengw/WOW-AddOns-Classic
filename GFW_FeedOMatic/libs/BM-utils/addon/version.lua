_G['BMUtils-Version'] = {}
---@class BMUtils_version
local lib = _G['BMUtils-Version']
lib.version = 'v1.10'

function lib.parse_version(version)
    assert(version, 'Version is nil')
    local major, minor = version:match('v(%d+).(%d+)')
    if major ~= nil then
        major = tonumber(major)
    else
        major = 0
    end
    if minor ~= nil then
        minor = tonumber(minor)
    else
        minor = 0
    end
    return major, minor
end

function lib.version_check(version, wanted_major, wanted_minor)
    local major, minor = lib.parse_version(version)

    if wanted_major ~= major then
        return false, ('Required major version %s, loaded is %s'):format(wanted_major, major)
    elseif wanted_minor > minor then
        return false, ('Required at least version %d.%d, loaded version is %d.%d (%s)'):format(
                wanted_major, wanted_minor, major, minor, version)
    else
        return true
    end
end