local addon = ...
local util = MountsJournalUtil
local mapValidTypes = {
	[Enum.UIMapType.World] = true,
	[Enum.UIMapType.Continent] = true,
	[Enum.UIMapType.Zone] = true,
}
local function isMapValidForNavBarDropDown(mapInfo)
	if mapValidTypes[mapInfo.mapType] then
		local children = C_Map.GetMapChildrenInfo(mapInfo.parentMapID)
		return type(children) == "table" and #children > 1
	end
end


MJNavBarMixin = util.createFromEventsMixin()


function MJNavBarMixin:onLoad()
	self.overlay:SetFrameLevel(self:GetFrameLevel() + 50)
	self.defMapID = MountsJournal.defMountsListID

	self.dropDown = LibStub("LibSFDropDown-1.4"):SetMixin({})
	self.dropDown:ddHideWhenButtonHidden(self)
	self.dropDown:ddSetInitFunc(function(...) self:dropDownInit(...) end)
	self.dropDown:ddSetDisplayMode(addon)

	self.navBtnClick = function(_, mapID)
		self:setMapID(mapID or self.defMapID)
	end
	local homeData = {
		name = WORLD,
		OnClick = function() self:setDefMap() end,
	}
	NavBar_Initialize(self, "MJNavButtonTemplate", homeData, self.home, self.overflow)
	self.overflow:SetScript("OnClick", function(btn) self:dropDownToggleClick(btn) end)
	self.overflow.listFunc = function(self)
		local navBar = self:GetParent()
		local list = {}
		for _, button in ipairs(navBar.navList) do
			if button:IsShown() then break end
			local data = {
				text = button:GetText(),
				id = button.id,
			}
			tinsert(list, data)
		end
		return list
	end
	self:setDefMap()
end


function MJNavBarMixin:refresh()
	local hierarchy = {}
	local mapInfo = C_Map.GetMapInfo(self.mapID)
	while mapInfo and mapInfo.mapID ~= self.defMapID do
		local btnData = {
			name = mapInfo.name,
			id = mapInfo.mapID,
			OnClick = function(self) self:GetParent():setMapID(self.data.id) end,
		}
		if isMapValidForNavBarDropDown(mapInfo) then
			btnData.listFunc = self.getDropDownList
		end
		tinsert(hierarchy, 1, btnData)
		mapInfo = C_Map.GetMapInfo(mapInfo.parentMapID)
	end

	NavBar_Reset(self)
	for _, btnData in ipairs(hierarchy) do
		NavBar_AddButton(self, btnData)
	end
end


function MJNavBarMixin:getDropDownList()
	local list = {}
	local mapInfo = C_Map.GetMapInfo(self.data.id)
	if mapInfo then
		local children = C_Map.GetMapChildrenInfo(mapInfo.parentMapID)
		if children then
			for i, childInfo in ipairs(children) do
				if isMapValidForNavBarDropDown(childInfo) then
					local data = {
						text = childInfo.name,
						id = childInfo.mapID,
					}
					tinsert(list, data)
				end
			end
			sort(list, function(a, b) return a.text < b.text end)
		end
	end
	return list
end


function MJNavBarMixin:dropDownToggleClick(btn)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON)
	self.dropDown:ddToggle(1, btn, btn, 20, 3)
end


function MJNavBarMixin:dropDownInit(btn, level, navButton)
	if not (navButton and navButton.listFunc) then return end

	local list = navButton:listFunc()
	if list then
		local info = {notCheckable = true}
		for i, entry in ipairs(list) do
			info.text = entry.text
			info.arg1 = entry.id
			info.func = self.navBtnClick
			btn:ddAddButton(info, level)
		end
	end
end


function MJNavBarMixin:setMapID(mapID)
	if mapID == self.mapID then return end
	self.mapID = mapID
	self:refresh()
	self:event("MAP_CHANGE")
end


function MJNavBarMixin:setDefMap()
	self:setMapID(self.defMapID)
end


function MJNavBarMixin:setCurrentMap()
	self:setMapID(C_Map.GetBestMapForUnit("player") or C_Map.GetFallbackWorldMapID())
end