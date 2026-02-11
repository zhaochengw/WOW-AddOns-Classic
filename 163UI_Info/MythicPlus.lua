local addonName, private = ...
local addon = private.addon

local ns = select(2, ...)

local CONST_MAX_LOGLINES = 1000

---@class profile
---@field logs table
local defaultSettings = {
    logs = {},
}

addon.profile = {}

local function InitializeProfile()
    if not MythicArchive_CharacterDB then
        MythicArchive_CharacterDB = {}
    end

    local function deepCopy(orig)
        local copy
        if type(orig) == 'table' then
            copy = {}
            for k, v in pairs(orig) do
                copy[k] = deepCopy(v)
            end
        else
            copy = orig
        end
        return copy
    end

    for key, value in pairs(defaultSettings) do
        if MythicArchive_CharacterDB[key] == nil then
            MythicArchive_CharacterDB[key] = deepCopy(value)
        end
    end

    addon.profile = MythicArchive_CharacterDB
end

local function InitializeLogSystem()
    function private.log(...)
        local str = ""
        for i = 1, select("#", ...) do
            str = str .. tostring(select(i, ...)) .. " "
        end

        local logDate = date("%Y-%m-%d %H:%M:%S")
        str = logDate .. "| " .. str
        table.insert(addon.profile.logs, 1, str)

        while #addon.profile.logs > CONST_MAX_LOGLINES do
            table.remove(addon.profile.logs)
        end
    end

    function addon:Log(msg)
        if private and private.log then
            private.log(msg)
        end
    end
end

addon.TargetMapIds = {
    [2773] = true,
    [2649] = true,
    [2662] = true,
    [2660] = true,
    [2830] = true,
    [2287] = true,
    [2441] = true,
}

local function RegisterSlashCommands()
    SLASH_MYTHICARCHIVE1 = "/ddma"

    SlashCmdList["MYTHICARCHIVE"] = function(msg)
        msg = msg or ""
        msg = string.gsub(msg, "^%s*(.-)%s*$", "%1")
        local cmd = string.lower(msg)

        if cmd == "log" or cmd == "logs" then
            if addon.profile and addon.profile.logs then
                local count = math.min(#addon.profile.logs, 20)
                print("|cff00ff00=== MythicArchive 日志 (最近" .. count .. "条) ===|r")
                for i = 1, count do
                    print(addon.profile.logs[i])
                end
                print("|cff00ff00=== 日志结束 ===|r")
            else
                print("|cffff0000没有日志记录|r")
            end

        elseif cmd == "status" then
            print("|cff00ff00=== MythicArchive 状态 ===|r")
            local version = "未知"
            if C_AddOns and C_AddOns.GetAddOnMetadata then
                version = C_AddOns.GetAddOnMetadata("MythicArchive", "Version") or "未知"
            elseif GetAddOnMetadata then
                version = GetAddOnMetadata("MythicArchive", "Version") or "未知"
            end
            print("版本: " .. version)

            local _, instanceType, difficultyID, _, _, _, _, instanceID = GetInstanceInfo()
            print("当前副本: " .. (instanceID or "无") .. " (难度: " .. (difficultyID or "无") .. ")")

            local isActive = C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive and C_ChallengeMode.IsChallengeModeActive()
            print("大秘境状态: " .. (isActive and "激活" or "未激活"))

            print("战斗日志: " .. (LoggingCombat() and "开启" or "关闭"))

        elseif cmd == "clear" or cmd == "clearlogs" then
            if addon.profile and addon.profile.logs then
                addon.profile.logs = {}
                print("|cff00ff00日志已清空|r")
            end

        else
            print("|cff00ff00=== MythicArchive 命令帮助 ===|r")
            print("可用命令:")
            print("|cffffaa00/ddma log|r - 显示最近的日志")
            print("|cffffaa00/ddma status|r - 显示插件状态")
            print("|cffffaa00/ddma clear|r - 清空日志")
            print("|cffffaa00/ddma|r - 显示此帮助")
        end
    end
end

function addon.CheckAutoCombatLog()
    if not MythicArchiveDB or not MythicArchiveDB.auto_combat_log then
        return
    end
    local _, _, difficultyID, difficultyName, _, _, _, instanceID = GetInstanceInfo()
    local mapID = instanceID

    local isMythicDifficulty = (difficultyID == 23 or difficultyID == 8)
    -- print("Checking combat log. InstanceID:", mapID, "Difficulty:", difficultyName, "(ID:", difficultyID, ")")

    local isTargetMap = false
    if mapID and addon.TargetMapIds[mapID] then
        isTargetMap = true
    end

    if isTargetMap and isMythicDifficulty then
        SetCVar("advancedCombatLogging", 1)

        if not LoggingCombat() then
            private.log("Auto enabling advanced combat log (InstanceID: " .. tostring(mapID) .. ")")
        end
        LoggingCombat(true)

        addon.combatLogEnabledByMe = true
    end
end

local MythicDetector = {
    isInChallenge = false,
    currentMapID = nil,
}

function MythicDetector:Initialize()
    self:SetupNativeEvents()
    self:SetupZoneDetection()
end

function MythicDetector:SetupNativeEvents()
    local nativeFrame = CreateFrame("Frame")

    nativeFrame:RegisterEvent("CHALLENGE_MODE_START")
    nativeFrame:RegisterEvent("CHALLENGE_MODE_COMPLETED")
    nativeFrame:RegisterEvent("CHALLENGE_MODE_RESET")

    nativeFrame:SetScript("OnEvent", function(self, event, ...)
        if event == "CHALLENGE_MODE_START" then
            MythicDetector:OnNativeChallengeStart(...)
        elseif event == "CHALLENGE_MODE_COMPLETED" then
            private.log("CHALLENGE_MODE_COMPLETED Event")
        elseif event == "CHALLENGE_MODE_RESET" then
            private.log("CHALLENGE_MODE_RESET Event")
        end
    end)
end

function MythicDetector:SetupZoneDetection()
    local zoneFrame = CreateFrame("Frame")
    zoneFrame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
    zoneFrame:RegisterEvent("PLAYER_ENTERING_WORLD")

    zoneFrame:SetScript("OnEvent", function(self, event, ...)
        private.log("Zone Change Event")
        C_Timer.After(3, function()
            private.log("Zone Change Event Delayed!!")
            addon.CheckAutoCombatLog()
        end)
    end)
end


function MythicDetector:OnNativeChallengeStart(mapChallengeModeID)
    private.log("Native Challenge Start Event:", mapChallengeModeID)

    if self.isInChallenge then
        private.log("Already in challenge, ignoring duplicate start event")
        return
    end

    private.log("CHALLENGE_MODE_START, starting 10 seconds timer.")
    C_Timer.After(12, function()
        if self.isInChallenge then
            private.log("Challenge already started by another detector, skipping")
            return
        end

        private.log("CHALLENGE_MODE_START timer ended, starting the dungeon.")

        local zoneName, instanceType, difficultyID, difficultyName, maxPlayers, dynamicDifficulty, isDynamic, instanceMapID, instanceGroupSize = GetInstanceInfo()
        if difficultyID == 8 then
            private.log("Confirmed Mythic+ difficulty (ID=8), proceeding with dungeon start")

            local activeMapID = C_ChallengeMode.GetActiveChallengeMapID and C_ChallengeMode.GetActiveChallengeMapID()
            if activeMapID then
                self.isInChallenge = true
                self.currentMapID = activeMapID
                self:TriggerMythicStart(activeMapID)
            else
                private.log("Warning: No active challenge map ID found")
            end
        else
            private.log("Not a Mythic+ dungeon (difficultyID=" .. tostring(difficultyID) .. "), ignoring event")
        end
    end)
end

function MythicDetector:TriggerMythicStart(mapID)
    private.log("Mythic Dungeon Started (Independent Detection):", mapID)

    addon.OnMythicDungeonStart(mapID)
end

function MythicDetector:TriggerMythicEnd()
    if not self.isInChallenge then return end

    private.log("Mythic Dungeon Ended (Independent Detection):", self.currentMapID)

    local endedMapID = self.currentMapID
    self.isInChallenge = false
    self.currentMapID = nil

    addon.OnMythicDungeonEnd(endedMapID)
end

function addon.OnMythicDungeonStart(mapID)
    private.log("OnMythicDungeonStart:", mapID, "auto_combat_log:", MythicArchiveDB and MythicArchiveDB.auto_combat_log or "nil")

    local _, _, _, _, _, _, _, instanceID = GetInstanceInfo()

    if instanceID and addon.TargetMapIds[instanceID] then
        C_Timer.After(2, function()
            local cmLevel = 0
            if C_ChallengeMode and C_ChallengeMode.GetActiveKeystoneInfo then
                local level = C_ChallengeMode.GetActiveKeystoneInfo()
                cmLevel = level or 0
            end

            local dungeonName = "Unknown Dungeon"
            if C_ChallengeMode and C_ChallengeMode.GetMapUIInfo and mapID then
                local dName = C_ChallengeMode.GetMapUIInfo(mapID)
                if dName then
                    dungeonName = dName
                end
            end

            local finalMapID = instanceID
            if instanceID == 2441 then
                if mapID == 391 then
                    finalMapID = "2441_2031"
                elseif mapID == 392 then
                    finalMapID = "2441_2032"
                else
                    if dungeonName == "塔扎维什：琳彩天街" or dungeonName == "Tazavesh: Streets of Wonder" then
                        finalMapID = "2441_2031"
                    elseif dungeonName == "塔扎维什：索·莉亚的宏图" or dungeonName == "Tazavesh: So'leah's Gambit" then
                        finalMapID = "2441_2032"
                    end
                end
            else
                finalMapID = instanceID
            end

            local teamInfo = {}
            local units = {"player", "party1", "party2", "party3", "party4"}

            for _, unit in ipairs(units) do
                if UnitExists(unit) then
                    local name, server = UnitName(unit)
                    if name and name ~= "" and name ~= "Unknown" then
                        if not server or server == "" then
                            server = GetRealmName()
                        end

                        local _, classFileName, uintId = UnitClass(unit)
                        local specID = 0

                        if unit == "player" then
                            local currentSpec = GetSpecialization()
                            if currentSpec then
                                local id = GetSpecializationInfo(currentSpec)
                                specID = id or 0
                            end
                        else
                            specID = GetInspectSpecialization(unit) or 0
                        end

                        local role = UnitGroupRolesAssigned(unit)
                        if role == "NONE" and specID and specID > 0 then
                            role = GetSpecializationRoleByID(specID)
                        end

                        local ilevel = 0
                        if unit == "player" then
                            local _, avg = GetAverageItemLevel()
                            ilevel = math.floor(avg)
                        end

                        table.insert(teamInfo, {
                            name = name,
                            server = server,
                            class = classFileName,
                            spec = specID,
                            role = role,
                            ilevel = ilevel,
                            isSelf = (unit == "player"),
                            classId = uintId,
                        })
                    end
                end
            end

            local mythicTeamInfo = {
                dungeonStartTime = time(),
                dungeonLv = cmLevel,
                dungeonName = dungeonName,
                teamInfo = teamInfo,
                mapId = finalMapID
            }

            if ns and ns.PixelComm then
                ns.PixelComm:sendCommand('mythicTeamInfo', mythicTeamInfo)
                private.log("Sent mythicTeamInfo for map " .. instanceID)
            end
        end)
    end
end

function addon.OnMythicDungeonEnd(mapID)
    private.log("OnMythicDungeonEnd:", mapID)

    if addon.combatLogEnabledByMe then
        C_Timer.After(1, addon.CheckAutoCombatLog)
    end
end

function addon.InitializeMythicPlus()
    InitializeProfile()

    InitializeLogSystem()

    if MythicArchiveDB.auto_combat_log == nil then
        MythicArchiveDB.auto_combat_log = false
    end

    RegisterSlashCommands()

    MythicDetector:Initialize()

    private.log("Mythic+ module initialized. auto_combat_log:", MythicArchiveDB and MythicArchiveDB.auto_combat_log or "nil")
end
