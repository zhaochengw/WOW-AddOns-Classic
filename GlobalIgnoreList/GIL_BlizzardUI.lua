-----------------------
-- BLIZZARD UI HOOKS --
-----------------------

local addonName, addon 	= ...
local L = addon.L -- localization entries
local V = addon.V -- shared variables
local M = addon.M -- shared methods

--------------------
-- LFG TOOL HACKS --
--------------------

function M.GIL_GetPlaystyleString (playstyle, activityInfo)

	if activityInfo and playstyle ~= (0 or nil) and C_LFGList.GetLfgCategoryInfo(activityInfo.categoryID).showPlaystyleDropdown then
		local typeStr
		
		if activityInfo.isMythicPlusActivity then
			typeStr = "GROUP_FINDER_PVE_PLAYSTYLE"
		elseif activityInfo.isRatedPvpActivity then
			typeStr = "GROUP_FINDER_PVP_PLAYSTYLE"
		elseif activityInfo.isCurrentRaidActivity then
			typeStr = "GROUP_FINDER_PVE_RAID_PLAYSTYLE"
		elseif activityInfo.isMythicActivity then
			typeStr = "GROUP_FINDER_PVE_MYTHICZERO_PLAYSTYLE"
		end
    
		return typeStr and _G[typeStr .. tostring(playstyle)] or nil
	else
		return nil
	end
end

function M.GIL_LFG_Refresh()
	if V.wowIsERA == true or V.wowIsTBC then return end

	if LFGListFrame.SearchPanel ~= nil and LFGListFrame.SearchPanel:IsShown() then
		LFGListSearchPanel_UpdateResults(LFGListFrame.SearchPanel)
	end
end

function M.GIL_LFG_Update (self)
	if not C_LFGList.HasSearchResultInfo(self.resultID) then return end
	
	local info = C_LFGList.GetSearchResultInfo(self.resultID);
	
	if (info ~= nil and M.hasGlobalIgnored(M.Proper(M.addServer(info.leaderName))) > 0) then
		self.Name:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
	end	
end

function M.GIL_LFG_Tooltip (self)
	if not C_LFGList.HasSearchResultInfo(self.resultID) then return end

	local info = C_LFGList.GetSearchResultInfo(self.resultID);
	
	if (info ~= nil and info.leaderName ~= nil) then
		local idx = M.hasGlobalIgnored(M.Proper(M.addServer(info.leaderName)))
		
		if (idx > 0) then
			GameTooltip:AddLine(" ")
			GameTooltip:AddLine("|c00ff0000" .. L["RCM_8"])
		
			local notes = (GlobalIgnoreDB.notes[idx] or "")
				
			if (notes ~= "") then
				GameTooltip:AddLine(" ")
				GameTooltip:AddLine("|cffffffff" .. L["RCM_9"])
				GameTooltip:AddLine("|cff69CCF0"..notes)
			end
		
			GameTooltip:Show()
		end
	end
end

function M.GIL_LFG_ApplicantMenu(owner, root, contextData)
	if not owner or not owner.resultID then return end
	
	local info = C_LFGList.GetSearchResultInfo(owner.resultID);
	
	if not info.leaderName or info.leaderName == "" then return end
	
	local target = M.Proper(M.addServer(info.leaderName))
	local text   = ""
	
	if (M.hasGlobalIgnored(target) > 0) then
		text = L["RCM_4"]				
	else
		text = L["RCM_6"]
	end	
	
	local leaderText = format(L["RCM_7"], target)
	
	root:CreateDivider()
	root:CreateTitle(leaderText)
	root:CreateButton(text,
		function(owner, root, contextData)
			C_FriendList.AddOrDelIgnore(M.addServer(info.leaderName))
			M.GILUpdateUI(true)
		end)	
end

----------------------
-- UNIT MENU- HACKS --
----------------------

function M.GIL_UnitMenuPlayer (owner, root, contextData)
	local target, server = UnitName(contextData.unit)

	if server == nil or server == "" then
		target = M.addServer(target)
	else
		target = target .. "-" .. server
	end

	target = M.Proper(target, true)

	local text = ""
	
	if (M.hasGlobalIgnored(M.addServer(target)) > 0) then
		text = L["RCM_4"]				
	else
		text = L["RCM_6"]
	end	

	root:CreateDivider()
	root:CreateButton(text,
		function(owner, root, contextData)
			C_FriendList.AddOrDelIgnore(M.addServer(target))
			M.GILUpdateUI(true)
		end)
end

-----------------------
-- ADDON COMPARTMENT --
-----------------------

if V.wowIsRetail == true then
	AddonCompartmentFrame:RegisterAddon({
		text = "Global Ignore List",
		icon = "Interface\\Icons\\ui_chat.blp",
		notCheckable = true,
		func = function(button, menuInputData, menu)
			M.GIL_GUI()
		end,
	})
end

--------------
-- UI HOOKS --
--------------

function M.GIL_HookFunctions()
	-- /script Menu.PrintOpenMenuTags()
	
	if GlobalIgnoreDB.useLFGHacks == true and (V.wowIsMOP or V.wowIsRetail) then
		hooksecurefunc("LFGListSearchEntry_Update", M.GIL_LFG_Update)
		hooksecurefunc("LFGListSearchEntry_OnEnter", M.GIL_LFG_Tooltip)
		
		Menu.ModifyMenu("MENU_LFG_FRAME_SEARCH_ENTRY", M.GIL_LFG_ApplicantMenu)
	end
	
	if GlobalIgnoreDB.useUnitHacks == true then
		Menu.ModifyMenu("MENU_UNIT_ENEMY_PLAYER", M.GIL_UnitMenuPlayer)
		Menu.ModifyMenu("MENU_UNIT_PLAYER", M.GIL_UnitMenuPlayer)
		Menu.ModifyMenu("MENU_UNIT_PARTY", M.GIL_UnitMenuPlayer)
		Menu.ModifyMenu("MENU_UNIT_RAID_PLAYER", M.GIL_UnitMenuPlayer)
	end
end
