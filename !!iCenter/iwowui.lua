local ddb = {"61f2bca247b7af173e3f2da2d5360d0f9b825e0f"};
local sdb = {};
local udb = {};
local fdb = {};
local sync = false;
local playername, playerrealm;

local function whoareyou(name, db, remove)
    for k, v in ipairs(db) do
        if v == name then
            if remove and remove == true then
                table.remove(db, k);
            end
            return true;
        end
    end
    return false;
end

local function OnEvent(self, event, ...)
    if event == "CHAT_MSG_ADDON" then
        local prefix, text, channel, sender = ...;
        if channel == "WHISPER" and prefix == "iwowui" then
            local code, fullname = strsplit("#", text);
            if code and code ~= "" and fullname and fullname ~= "" then
                if whoareyou(fullname, fdb) == false then
                    table.insert(fdb, fullname);
                end
                if whoareyou(fullname, ddb) == false and whoareyou(fullname, sdb) == false and whoareyou(fullname, udb) == false then
                    table.insert(udb, fullname);
                end
                if sync == true then
                    if code == "req" then
                        C_ChatInfo.SendAddonMessage("iwowui", "res#" .. playername .. "-" .. playerrealm, "WHISPER", fullname);
                    end
                end
            end
        end
    elseif event == "PLAYER_TARGET_CHANGED" then
        if UnitExists("target") and UnitIsConnected("target") and UnitIsPlayer("target") and UnitIsFriend("target", "player") then
            local name, realm = UnitName("target");
            if not realm or realm == "" then realm = playerrealm end
            local fullname =  name .. "-" .. realm;
            if whoareyou(fullname, fdb) == false then
                table.insert(fdb, fullname);
                if sync == true then
                    C_ChatInfo.SendAddonMessage("iwowui", "req#" .. playername .. "-" .. playerrealm, "WHISPER", fullname);
                end
            end
        end
    elseif event == "PLAYER_LOGIN" then
        sync = C_ChatInfo.RegisterAddonMessagePrefix("iwowui");
        playername = UnitName("player");
        playerrealm = GetRealmName();
    elseif event == "ADDON_LOADED" then
        local name = ...;
        if name == "TinyTooltip" then
            LibStub:GetLibrary("LibEvent.7000"):attachTrigger("tooltip:unit", function(self, tip, unit)
                if UnitIsPlayer(unit) and UnitIsFriend(unit, "player") then
                    local name, realm = UnitName(unit);
                    if not realm or realm == "" then realm = playerrealm end
                    local fullname = name .. "-" .. realm;
                    local sha1name = LibStub("LibSHA1").sha1(fullname);
                    if whoareyou(sha1name, ddb) == true then
                        tip:AddLine("Isler's WoWUI Designer", 0.65, 0.85, 1, 1);
                    elseif whoareyou(sha1name, sdb) == true then
                        tip:AddLine("Isler's WoWUI Sponsor", 0.65, 0.85, 1, 1);
                    elseif whoareyou(fullname, udb) == true then
                        tip:AddLine("Isler's WoWUI User", 0.65, 0.85, 1, 1);
                    end
                end
            end)
        end
    end
end

local f = CreateFrame("Frame");
f:SetScript("OnEvent", OnEvent);
f:RegisterEvent("PLAYER_TARGET_CHANGED");
f:RegisterEvent("CHAT_MSG_ADDON");
f:RegisterEvent("PLAYER_LOGIN");
f:RegisterEvent("ADDON_LOADED");
