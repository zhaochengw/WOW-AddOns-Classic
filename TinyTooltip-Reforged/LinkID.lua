local LibEvent = LibStub:GetLibrary("LibEvent.7000")
local clientVer, clientBuild, clientDate, clientToc = GetBuildInfo()
local addon = TinyTooltipReforged

local function ParseHyperLink(link)
    local name, value = string.match(link or "", "|?H(%a+):(%d+):")
    if (name and value) then
        return name:gsub("^([a-z])", strupper), value
    end
end

local function ShowId(tooltip, name, value, noBlankLine)
    if (not name or not value) then return end
    local name = format("%s%s", addon.L[name] or name, " ID")
    if (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) then
        local line = addon:FindLine(tooltip, name)
        local idLine = format("%s: |cffffffff%s|r", name, value)
        if (not line) then
            if (not noBlankLine) then tooltip:AddLine(" ") end
            tooltip:AddLine(format(idLine, name, value), 0, 1, 0.8)
            tooltip:Show()
        else
            line:SetText(idLine)
        end
        if (clientToc < 100002) then
            LibEvent:trigger("tooltip.linkid", GameTooltip, name, value, noBlankLine)
        end 
    end
end

local function ShowLinkIdInfo(tooltip, data)
    if data and (data.type == Enum.TooltipDataType.Item) then
        local itemName, itemLink, itemID = TooltipUtil.GetDisplayedItem(tooltip)
        ShowId(tooltip, ParseHyperLink(itemLink))
    end
end

-- keystone (not working)
local function KeystoneAffixDescription(self, link)
--    link = link or select(2, self:GetItem())
--    local data, name, description, AffixID
--    if (link and strfind(link, "keystone:")) then
--        link = link:gsub("|H(keystone:.-)|.+", "%1")
--        data = {strsplit(":", link)}
--        self:AddLine(" ")
--         for i = 5, 8 do
--            AffixID = tonumber(data[i])
--            if (AffixID and AffixID > 0) then
--                name, description = C_ChallengeMode.GetAffixInfo(AffixID)
--                if (name and description) then
--                    self:AddLine(format("|cffffcc33%s:|r%s", name, description), 0.1, 0.9, 0.1, true)
--                end
--            end
--        end
--        self:Show()
--    end
end


if (clientToc>=100002) then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, KeystoneAffixDescription)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", KeystoneAffixDescription)
else 
    GameTooltip:HookScript("OnTooltipSetItem", KeystoneAffixDescription)
    hooksecurefunc(ItemRefTooltip, "SetHyperlink", KeystoneAffixDescription)
end

-- Item
hooksecurefunc(GameTooltip, "SetHyperlink", ShowLinkIdInfo)
hooksecurefunc(ItemRefTooltip, "SetHyperlink", ShowLinkIdInfo)
hooksecurefunc("SetItemRef", function(link) ShowLinkIdInfo(ItemRefTooltip, link) end)
if (clientToc>=100002) then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, ShowLinkIdInfo)
else
    GameTooltip:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefTooltip:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ShoppingTooltip1:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ShoppingTooltip2:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
    ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", ShowLinkIdInfo)
end

-- Spell
if (clientToc>=100002) then
    TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Spell, function(self)
      if not pcall(function() ShowId(self, "Spell", (select(2,self:GetSpell()))) end) then
         return 
      end
    end)
else
    GameTooltip:HookScript("OnTooltipSetSpell", function(self) ShowId(self, "Spell", (select(2,self:GetSpell()))) end)
end
hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...) 
	local aura = C_UnitAuras.GetAuraDataByIndex(...)
	if aura then
		ShowId(self, "Spell", aura.spellId) 
	end
end)
hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
	local aura = C_UnitAuras.GetBuffDataByIndex(...)
	if aura then
		ShowId(self, "Spell", aura.spellId) 
	end
end)
hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, ...)
	local aura = C_UnitAuras.GetDebuffDataByIndex(...)
	if aura then
		ShowId(self, "Spell", aura.spellId) 
	end
end)
if (GameTooltip.SetArtifactPowerByID) then
    hooksecurefunc(GameTooltip, "SetArtifactPowerByID", function(self, powerID)
        ShowId(self, "Power", powerID)
        ShowId(self, "Spell", C_ArtifactUI.GetPowerInfo(powerID).spellID, 1)
    end)
end

-- Quest
if (QuestMapLogTitleButton_OnEnter) then
    hooksecurefunc("QuestMapLogTitleButton_OnEnter", function(self)
        if (self.questID) then ShowId(GameTooltip, "Quest", self.questID) end
    end)
end

-- Achievement UI
local function ShowAchievementId(self)
    if ((IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) and self.id) then
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 0, -32)
        GameTooltip:SetText("|cffffdd22Achievement:|r " .. self.id, 0, 1, 0.8)
        GameTooltip:Show()
    end
end

if (HybridScrollFrame_CreateButtons) then
    hooksecurefunc("HybridScrollFrame_CreateButtons", function(self, buttonTemplate)
        if (buttonTemplate == "StatTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
            end
        elseif (buttonTemplate == "AchievementTemplate") then
            for _, button in pairs(self.buttons) do
                button:HookScript("OnEnter", ShowAchievementId)
                button:HookScript("OnLeave", GameTooltip_Hide)
            end
        end
    end)
end

-- adds caster of buffs/debuffs to their tooltips
hooksecurefunc(GameTooltip,"SetUnitAura",function(self,unit,index,filter)
	if (IsShiftKeyDown() or IsControlKeyDown() or IsAltKeyDown() or addon.db.general.alwaysShowIdInfo) then
		local aura = C_UnitAuras.GetAuraDataByIndex(unit,index,filter)
		local caster = aura and aura.sourceUnit or nil
		if caster and UnitExists(caster) then
				GameTooltip:AddLine(addon.L["Caster"]..": "..UnitName(caster),.65,.85,1,1)
				GameTooltip:Show()
		end
	end
end)