-------------------------------------------------------------------------
-- GTFO_Skada.lua 
--------------------------------------------------------------------------
--[[
GTFO & Skada Integration
 
Change Log:
    v4.6
        - Added Skada Integration
    v4.8.5
        - Fixed bug
    v4.8.6
        - Fixed bug (better fix!)
    v4.9.1
        - Fixed bug
    v4.9.2
        - Fixed the root cause bug (which actually fixes all the previous "bugs")
    v4.12.2
        - Fixed bug
    v5.6
        - Integrated Skada fixes from bKader
    v5.8
        - Integrated additional Skada fixes from bKader
]]--
 
local format = string.format
local GTFOLocal = _G.GTFOLocal
local GTFO_GetAlertIcon = _G.GTFO_GetAlertIcon
local GTFO_GetAlertByID = _G.GTFO_GetAlertByID
local GTFO_GetAlertType = _G.GTFO_GetAlertType
 
local function Setup_Skada(Skada, L)
    local mod = Skada:NewModule(GTFOLocal.Recount_Name)
    local playermod = Skada:NewModule(GTFOLocal.Skada_AlertList)
    local alertmod = Skada:NewModule(GTFOLocal.Skada_SpellList)
 
    L["Alerts"] = GTFOLocal.Skada_Category
 
    local function log_alert(set, data)
        -- Get the player.
        local player = Skada:get_player(set, data.playerID, data.playerName)
        if not player then return end
 
        -- alert count
        set.alertCount = (set.alertCount or 0) + 1
        player.alertCount = (player.alertCount or 0) + 1
 
        -- Also add to set total damage.
        set.alertDamage = (set.alertDamage or 0) + data.damage
        player.alertDamage = (player.alertDamage or 0) + data.damage
 
        if not data.alertID then return end
 
        local alert = player.alert and player.alert[data.alertID]
        if not alert then
            player.alert = player.alert or {}
            player.alert[data.alertID] = {name = data.alertID, alertCount = 0, alertDamage = 0}
            alert = player.alert[data.alertID]
        end
 
        alert.alertCount = alert.alertCount + 1
        alert.alertDamage = alert.alertDamage + data.damage
 
        if not data.spellName then return end
 
        local spell = alert.spell and alert.spell[data.spellName]
        if not spell then
            alert.spell = alert.spell or {}
            alert.spell[data.spellName] = {id = data.spellID, alertID = data.alertID, alertCount = 0, alertDamage = 0}
            spell = alert.spell[data.spellName]
        end
 
        spell.alertCount = spell.alertCount + 1
        spell.alertDamage = spell.alertDamage + data.damage
 
        if not spell.max or data.damage > spell.max then
            spell.max = data.damage
        end
        if not spell.min or data.damage < spell.min then
            spell.min = data.damage
        end
    end
 
    -- Alert overview.
    function mod:Update(win, set)
        local nr, maxvalue = 0, 0
 
        for i, player in ipairs(set.players) do
            if player.alertCount and player.alertCount > 0 then
                nr = nr + 1
 
                local d = win.dataset[nr] or {}
                win.dataset[nr] = d
                d.label = player.name
                d.valuetext = Skada:FormatValueText(
                    Skada:FormatNumber(player.alertDamage), self.metadata.columns.Damage,
                    player.alertCount, self.metadata.columns.Alerts
                )
                d.value = player.alertDamage
                d.id = player.id
                d.class = player.class
                if player.alertDamage > maxvalue then
                    maxvalue = player.alertDamage
                end
            end
        end
 
        win.metadata.maxvalue = maxvalue
    end
 
    function playermod:Enter(win, id, label)
        local player = Skada:find_player(win:get_selected_set(), id)
        playermod.playerid = id
        playermod.title = player.name .. L["'s "] .. " " .. GTFOLocal.Recount_Name
    end
 
    -- Detail view of a player.
    function playermod:Update(win, set)
        local player = Skada:find_player(set, self.playerid)
        if not player or not player.alert then return end
 
        local nr, maxvalue = 0, 0
 
        for alertID, alert in pairs(player.alert) do
            if alert.alertCount > 0 then
                nr = nr + 1
 
                local d = win.dataset[nr] or {}
                win.dataset[nr] = d
                d.label = alert.name
                d.id = alertID
                d.icon = GTFO_GetAlertIcon(GTFO_GetAlertByID(alertID))
                d.value = alert.alertDamage
                d.valuetext = Skada:FormatValueText(
                    Skada:FormatNumber(alert.alertDamage), self.metadata.columns.Damage,
                    alert.alertCount, self.metadata.columns.Alerts,
                    string.format("%02.1f%%", alert.alertDamage / player.alertDamage * 100), self.metadata.columns.Percent
                )
 
                if alert.alertDamage > maxvalue then
                    maxvalue = alert.alertDamage
                end
            end
        end
 
        win.metadata.maxvalue = maxvalue
    end
 
    function alertmod:Enter(win, id, label)
        local player = Skada:find_player(win:get_selected_set(), playermod.playerid)
        alertmod.playerid = playermod.playerid
        alertmod.alertType = label
        alertmod.title = player.name .. L["'s "] .. alertmod.alertType .. " " .. GTFOLocal.Recount_Name
    end
 
    function alertmod:Update(win, set)
        local player = Skada:find_player(set, alertmod.playerid)
        local alert = player and player.alert and player.alert[alertmod.alertType]
        if not alert then return end
 
        local nr, maxvalue = 0, 0
 
        for spellName, spell in pairs(alert.spell) do
            nr = nr + 1
 
            local d = win.dataset[nr] or {}
            win.dataset[nr] = d
            d.label = spellName
            d.id = spellName
            if (spell.id and spell.id > 0) then
                d.icon = select(3, GetSpellInfo(spell.id))
            else
                d.icon = "Interface\\Icons\\Spell_Fire_Fire"
            end
            d.value = spell.alertDamage
            d.valuetext = Skada:FormatValueText(
                Skada:FormatNumber(spell.alertDamage), self.metadata.columns.Damage,
                spell.alertCount, self.metadata.columns.Alerts,
                string.format("%02.1f%%", spell.alertDamage / player.alertDamage * 100), self.metadata.columns.Percent
            )
 
            if spell.alertDamage > max then
                max = spell.alertDamage
            end
        end
 
        win.metadata.maxvalue = max
    end
 
    local function spell_tooltip(win, id, label, tooltip)
        local player = Skada:find_player(win:get_selected_set(), alertmod.playerid)
        local alert = player and player.alert and player.alert[alertmod.alertType]
        local spell = alert and alert.spell and alert.spell[label]
        if not spell then return end
 
        tooltip:AddLine(player.name .. " - " .. label)
 
        if spell.max and spell.min then
            tooltip:AddDoubleLine(L["Minimum hit:"], Skada:FormatNumber(spell.min), 1, 1, 1, 1, 1, 1)
            tooltip:AddDoubleLine(L["Maximum hit:"], Skada:FormatNumber(spell.max), 1, 1, 1, 1, 1, 1)
        end
 
        tooltip:AddDoubleLine(L["Average hit:"], Skada:FormatNumber(spell.alertDamage / spell.alertCount), 1, 1, 1, 1, 1, 1)
    end
 
    function mod:OnEnable()
        self.metadata = {
            showspots = true,
            click1 = playermod,
            columns = {Damage = true, Alerts = true}
        }
        playermod.metadata = {
            showspots = true,
            click1 = alertmod,
            columns = {Damage = true, Alerts = true, Percent = true}
        }
        alertmod.metadata = {
            tooltip = spell_tooltip,
            columns = {Damage = true, Alerts = true, Percent = true}
        }
 
        Skada:AddMode(self)
    end
 
    function mod:OnDisable()
        Skada:RemoveMode(self)
    end
 
    function mod:AddToTooltip(set, tooltip)
        GameTooltip:AddDoubleLine(GTFOLocal.Recount_Name, set.alertCount, 1, 1, 1)
    end
 
    function mod:GetSetSummary(set)
        return Skada:FormatNumber(set.alertDamage) .. " (" .. set.alertCount .. ")"
    end
 
    -- Called by Skada when a new player is added to a set.
    function mod:AddPlayerAttributes(player)
        if not player.alertCount then
            player.alertCount = 0
            player.alertDamage = 0
            player.alert = player.alert or {}
        end
    end
 
    -- Called by Skada when a new set is created.
    function mod:AddSetAttributes(set)
        if not set.alertCount then
            set.alertCount = 0
            set.alertDamage = 0
        end
    end
 
    _G.GTFO_RecordSkada = function(sourceName, sourceID, alertID, spellID, spellName, damage)
        local alert = {
            alertID = GTFO_GetAlertType(alertID),
            damage = damage,
            spellID = spellID,
            spellName = spellName,
            playerID = sourceID,
            playerName = sourceName
        }
 
        if (alert.alertID) then
            if (Skada.current) then
                log_alert(Skada.current, alert)
            end
            if (Skada.total) then
                log_alert(Skada.total, alert)
            end
        end
    end
 
    GTFO_DebugPrint("Skada Classic integration loaded.");
    return true
end
 
local function Setup_SkadaRev(Skada, L)
    local mode = Skada:NewModule("GTFO Alerts")
    local mode_actor = mode:NewModule("GTFO Alert Types")
    local mode_spell = mode_actor:NewModule("GTFO Spells")
    local mode_cols = nil
 
    local function format_valuetext(d, columns, total, count, metadata, subview)
        d.valuetext = Skada:FormatValueCols(
            columns.Damage and Skada:FormatNumber(d.value),
            columns.Count and count,
            columns[subview and "sPercent" or "Percent"] and Skada:FormatPercent(d.value, total)
        )
 
        if metadata and d.value > metadata.maxvalue then
            metadata.maxvalue = d.value
        end
    end
 
    local function log_alert(set, data)
        local actor = Skada:GetActor(set, data.actorname, data.actorid)
        if not actor then return end
 
        -- alerts count
        set.alertCount = (set.alertCount or 0) + 1
        actor.alertCount = (actor.alertCount or 0) + 1
 
        -- alerts damage
        set.alertDamage = (set.alertDamage or 0) + data.damage
        actor.alertDamage = (actor.alertDamage or 0) + data.damage
 
        local alertID = data.alertID
        if not alertID then return end
 
        local alert = actor.alert and actor.alert[alertID]
        if not alert then
            actor.alert = actor.alert or {}
            actor.alert[alertID] = {alertCount = 0, alertDamage = 0}
            alert = actor.alert[alertID]
        end
 
        alert.alertCount = alert.alertCount + 1
        alert.alertDamage = alert.alertDamage + data.alertDamage
 
        if not data.spellid then return end
 
        local spell = alert.spell and alert.spell[data.spellid]
        if not spell then
            alert.spell = alert.spell or {}
            alert.spell[data.spellid] = {alertCount = 0, alertDamage = 0}
            spell = alert.spell[data.spellid]
        end
 
        spell.alertCount = spell.alertCount + 1
        spell.alertDamage = spell.alertDamage + data.alertDamage
 
        if not spell.max or data.damage > spell.max then
            spell.max = data.damage
        end
        if not spell.min or data.damage < spell.min then
            spell.min = data.damage
        end
    end
 
    local function spell_tooltip(win, id, label, tooltip)
        local set = win.actorname and win.spellid and win:GetSelectedSet()
        local actor = set and set:GetActor(win.actorname, win.actorid)
        local alert = actor and actor.alert and actor.alert[win.spellid]
        local spell = alert and alert.spell and alert.spell[id]
        if not spell then return end
 
        tooltip:AddLine(format("%s - %s", actor.name, label))
 
        if spell.min then
            tooltip:AddDoubleLine(L["Minimum"], Skada:FormatNumber(spell.min), 1, 1, 1)
        end
        if spell.max then
            tooltip:AddDoubleLine(L["Maximum"], Skada:FormatNumber(spell.max), 1, 1, 1)
        end
 
        tooltip:AddDoubleLine(L["Average"], Skada:FormatNumber(spell.alertDamage / spell.alertCount), 1, 1, 1)
    end
 
    function mode_spell:Enter(win, id, label)
        win.spellid, win.spellname = id, label
        win.title = format("%s - %s - %s", win.actorname or L["Unknown"], label, L["GTFO Alerts"])
    end
 
    function mode_spell:Update(set, win)
        win.title = format("%s - %s - %s", win.actorname or L["Unknown"], win.spellname or "??", L["GTFO Alerts"])
        if not win.actorname or not win.spellid then return end
 
        local actor = set:GetActor(win.actorname, win.actorid)
        local alert = actor and actor.alert and actor.alert[win.spellid]
        local total = alert and alert.alertCount
        local spells = total and total > 0 and alert.spell
 
        if not spells then
            return
        elseif win.metadata then
            win.metadata.maxvalue = 0
        end
 
        local nr = 0
        for spellid, spell in pairs(spells) do
            nr = nr + 1
 
            local d = win:spell(nr, spellid)
            d.value = spell.alertDamage
            format_valuetext(d, mode_cols, total, spell.alertCount, win.metadata, true)
        end
    end
 
    function mode_actor:Enter(win, id, label)
        win.actorid, win.actorname = id, label
        win.title = format("%s - %s", label, L["GTFO Alerts"])
    end
 
    function mode_actor:Update(set, win)
        win.title = format("%s - %s", win.actorname or L["Unknown"], L["GTFO Alerts"])
        if not win.actorname then return end
 
        local actor = set:GetActor(win.actorname, win.actorid)
        local total = actor and actor.alertDamage
        local alerts = total and total > 0 and actor.alert
 
        if not alerts then
            return
        elseif win.metadata then
            win.metadata.maxvalue = 0
        end
 
        local nr = 0
        for alertID, alert in pairs(alerts) do
            if alert.alertCount > 0 then
                nr = nr + 1
 
                local d = win:nr(nr)
                d.id = alertID
                d.label = alertID
                d.icon = GTFO_GetAlertIcon(GTFO_GetAlertByID(alertID))
                d.value = alert.alertDamage
 
                format_valuetext(d, mode_cols, total, alert.alertCount, win.metadata, true)
            end
        end
    end
 
    function mode:Update(set, win)
        win.title = win.class and format("%s (%s)", L["GTFO Alerts"], L[win.class]) or L["GTFO Alerts"]
 
        local total = set and set.alertDamage
        if not total or total == 0 then
            return
        elseif win.metadata then
            win.metadata.maxvalue = 0
        end
 
        local nr = 0
        local actors = set.actors
 
        for actorname, actor in pairs(actors) do
            if win:show_actor(actor, set, true) and actor.alertCount then
                nr = nr + 1
 
                local d = win:actor(nr, actor, actor.enemy, actorname)
                d.value = actor.alertDamage
                format_valuetext(d, mode_cols, total, actor.alertCount, win.metadata)
            end
        end
    end
 
    function mode:AddToTooltip(set, tooltip)
        if not set then return end
        tooltip:AddDoubleLine(L["GTFO Alerts"], set.alertCount or 0, 1, 1, 1)
    end
 
    function mode:GetSetSummary(set, win)
        if not set then return end
 
        local classfilter = win and win.class or nil
        local damage = set:GetTotal(classfilter, "alertDamage") or 0
        local count = set:GetTotal(classfilter, "alertCount") or 0
 
        local valuetext =
            Skada:FormatValueCols(mode_cols.Damage and Skada:FormatNumber(damage), mode_cols.Count and count)
        return damage, valuetext
    end
 
    function mode:OnEnable()
        mode_spell.metadata = {tooltip = spell_tooltip}
        mode_actor.metadata = {click1 = mode_spell}
        self.metadata = {
            showspots = true,
            filterclass = true,
            click1 = mode_actor,
            columns = {Damage = true, Count = true, Percent = true, sPercent = true}
        }
 
        mode_cols = self.metadata.columns
 
        Skada:AddMode(self)
    end
 
    function mode:OnDisable()
        Skada:RemoveMode(self)
    end
 
    local data = {}
    _G.GTFO_RecordSkada = function(srcName, srcGUID, alertID, spellid, spellname, damage)
        alertID = GTFO_GetAlertType(alertID)
        if not alertID then return end
 
        wipe(data)
 
        data.alertID = alertID
        data.damage = damage
        data.spellid = spellid
        data.spellname = spellname
        data.actorid = srcGUID
        data.actorname = srcName
 
        Skada:DispatchSets(log_alert, data)
    end
 
    GTFO_DebugPrint("Skada Revisited integration loaded.");
    return true;
end
 
local function Setup_Locales()
    local AceLocale = LibStub("AceLocale-3.0")
 
    local L = AceLocale:NewLocale("Skada", GetLocale())
    if L then
        L["GTFO Alerts"] = GTFOLocal.Recount_Name
        L["GTFO Alert Types"] = GTFOLocal.Skada_AlertList
        L["GTFO Spells"] = GTFOLocal.Skada_SpellList
        L["Alerts"] = GTFOLocal.Skada_Category
        return AceLocale:GetLocale("Skada")
    end
 end
 
function GTFO_Skada()
    local Skada = _G.Skada
    if not Skada then
        return
    elseif Skada.revisited then
        return Setup_SkadaRev(Skada, Setup_Locales())
    else
        return Setup_Skada(Skada, LibStub("AceLocale-3.0"):GetLocale("Skada"))
    end
end
