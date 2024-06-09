if WOW_PROJECT_ID == (WOW_PROJECT_CLASSIC or 2) then -- Added in WotLK
	return
end
local mod	= DBM:NewMod("z628", "DBM-PvP")

mod:SetRevision("20240203195924")
mod:SetZone(DBM_DISABLE_ZONE_DETECTION)
mod:RegisterEvents(
	"LOADING_SCREEN_DISABLED",
	"ZONE_CHANGED_NEW_AREA",
	"PLAYER_ENTERING_WORLD"
)

do
	local bgzone = false

	local function Init(self)
		local zoneID = DBM:GetCurrentArea()
		if not bgzone and zoneID == 628 then
			bgzone = true
			local generalMod = DBM:GetModByName("PvPGeneral")
			generalMod:SubscribeAssault(169, 5)
			if not self.tracker then
				self.tracker = generalMod:NewHealthTracker()
				self.tracker:TrackHealth(34924, "AllianceBoss", BLUE_FONT_COLOR)
				self.tracker:TrackHealth(34922, "HordeBoss", RED_FONT_COLOR)
			end
			-- TODO: Add gate health
		elseif bgzone and zoneID ~= 628 then
			bgzone = false
			if self.tracker then
				self.tracker:Cancel()
				self.tracker = nil
			end
		end
	end

	function mod:LOADING_SCREEN_DISABLED()
		self:Schedule(1, Init, self)
	end
	mod.ZONE_CHANGED_NEW_AREA	= mod.LOADING_SCREEN_DISABLED
	mod.PLAYER_ENTERING_WORLD	= mod.LOADING_SCREEN_DISABLED
	mod.OnInitialize			= mod.LOADING_SCREEN_DISABLED
end
