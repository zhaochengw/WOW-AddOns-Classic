local addon = ...
local type, select, strsplit, tremove = type, select, strsplit, tremove
local events, eventsMixin = {}, {}


function eventsMixin:on(event, func)
	if type(event) ~= "string" or type(func) ~= "function" then return end
	local event, name = strsplit(".", event, 2)

	if not events[event] then
		events[event] = {}
	end
	events[event][#events[event] + 1] = {
		name = name,
		func = func,
		self = self,
	}
	return self
end


function eventsMixin:off(event, func)
	if type(event) ~= "string" then return end
	local event, name = strsplit(".", event, 2)

	local handlerList = events[event]
	if handlerList then
		if name ~= nil or type(func) == "function" then
			local i = 1
			local handler = handlerList[i]
			while handler do
				if (not name or handler.name == name) and (not func or handler.func == func) then
					tremove(handlerList, i)
				else
					i = i + 1
				end
				handler = handlerList[i]
			end
			if #handlerList == 0 then
				events[event] = nil
			end
		else
			events[event] = nil
		end
	end
	return self
end


function eventsMixin:event(event, ...)
	local handlerList = events[event]
	if handlerList then
		for i = 1, #handlerList do
			local handler = handlerList[i]
			handler.func(handler.self, ...)
		end
	end
	return self
end


local scale = WorldFrame:GetWidth() / GetPhysicalScreenSize() / UIParent:GetScale()
local menuBackdrop = {
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true, edgeSize = 1 * scale, tileSize = 5 * scale,
}
local lsfdd = LibStub("LibSFDropDown-1.4")
lsfdd:CreateMenuStyle(addon, function(parent)
	local f = CreateFrame("FRAME", nil, parent, "BackdropTemplate")
	f:SetBackdrop(menuBackdrop)
	f:SetBackdropColor(.06, .06, .1, .9)
	f:SetBackdropBorderColor(.5, .5, .5, .8)
	return f
end)


MountsJournalUtil = {}
MountsJournalUtil.addonName = ("%s_ADDON_"):format(addon:upper())


MountsJournalUtil.filterButtonBackdrop = {
	edgeFile = "Interface/AddOns/MountsJournal/textures/border",
	edgeSize = 8 * scale,
}


MountsJournalUtil.optionsPanelBackdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	tile = true,
	tileEdge = true,
	tileSize = 14 * scale,
	edgeSize = 14 * scale,
	insets = {left = 4, right = 4, top = 4, bottom = 4}
}


MountsJournalUtil.editBoxBackdrop = {
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true, edgeSize = 1 * scale, tileSize = 5 * scale,
}


function MountsJournalUtil.setMixin(obj, mixin)
	for k, v in pairs(mixin) do
		obj[k] = v
	end
	return obj
end


function MountsJournalUtil.createFromEventsMixin()
	return MountsJournalUtil.setMixin({}, eventsMixin)
end


function MountsJournalUtil.setEventsMixin(frame)
	MountsJournalUtil.setMixin(frame, eventsMixin)
end


function MountsJournalUtil.inTable(tbl, item)
	for i = 1, #tbl do
		if tbl[i] == item then
			return i
		end
	end
	return false
end


function MountsJournalUtil.getMapFullNameInfo(mapID)
	local mapInfo = C_Map.GetMapInfo(mapID)

	local mapGroupID = C_Map.GetMapGroupID(mapID)
	if mapGroupID then
		local mapGroupInfo = C_Map.GetMapGroupMembersInfo(mapGroupID)
		if mapGroupInfo then
			for _, mapGroupMemberInfo in ipairs(mapGroupInfo) do
				if mapGroupMemberInfo.mapID == mapID then
					mapInfo.name = ("%s (%s)"):format(mapInfo.name, mapGroupMemberInfo.name)
					break
				end
			end
		end
	end

	return mapInfo
end


do
	local function setEnabledChilds(self)
		local checked = self:GetChecked()
		for _, child in ipairs(self.childs) do
			child:SetEnabled(checked)
		end
	end

	local function disableChilds(self)
		for _, child in ipairs(self.childs) do
			child:Disable()
		end
	end

	function MountsJournalUtil.setCheckboxChild(parent, child, lastChild)
		if not parent.childs then
			parent.childs = {}
			hooksecurefunc(parent, "SetChecked", setEnabledChilds)
			parent:HookScript("OnClick", setEnabledChilds)
			parent:HookScript("OnEnable", setEnabledChilds)
			parent:HookScript("OnDisable", disableChilds)
		end
		parent.childs[#parent.childs + 1] = child
		if lastChild then parent.lastChild = child end
	end
end


function MountsJournalUtil.createCheckboxChild(text, parent)
	local check = CreateFrame("CheckButton", nil, parent:GetParent(), "MJCheckButtonTemplate")
	if parent.lastChild then
		check:SetPoint("TOPLEFT", parent.lastChild, "BOTTOMLEFT", 0, -3)
	else
		check:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 20, -3)
	end
	if text then check.Text:SetText(text) end
	MountsJournalUtil.setCheckboxChild(parent, check, true)
	return check
end


do
	local function showTooltip(_,_, hyperLink)
		GameTooltip:SetOwner(UIParent, "ANCHOR_CURSOR")
		GameTooltip:SetHyperlink(hyperLink)
		GameTooltip:Show()
	end

	local function hideTooltip(self)
		GameTooltip:Hide()
	end

	function MountsJournalUtil.setHyperlinkTooltip(frame)
		frame:SetHyperlinksEnabled(true)
		frame:SetScript("OnHyperlinkEnter", showTooltip)
		frame:SetScript("OnHyperlinkLeave", hideTooltip)
	end
end


function MountsJournalUtil:copyTable(t)
	local n = {}
	for k, v in pairs(t) do
		n[k] = type(v) == "table" and self:copyTable(v) or v
	end
	return n
end


function MountsJournalUtil.getGroupType()
	return IsInRaid() and "raid" or IsInGroup() and "group"
end


function MountsJournalUtil.cleanText(text)
	return text:trim():lower()
end