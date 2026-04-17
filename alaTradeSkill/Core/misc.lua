--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;


StackSplitFrame:SetFrameStrata("TOOLTIP");

if not _G.ALA_HOOK_ChatEdit_InsertLink then
	local tremove = table.remove;
	local ChatEdit_GetActiveWindow = ChatEdit_GetActiveWindow;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;

	local handlers_name = {  };
	local handlers_link = {  };
	function _G.ALA_INSERT_LINK(link, ...)
		if not link then return; end
		local num = #handlers_link;
		if num > 0 then
			for index = 1, num do
				if handlers_link[index](link, ...) then
					return true;
				end
			end
		end
	end
	function _G.ALA_INSERT_NAME(name, ...)
		if not name then return; end
		local num = #handlers_name;
		if num > 0 then
			for index = 1, num do
				if handlers_name[index](name, ...) then
					return true;
				end
			end
		end
	end
	function _G.ALA_HOOK_ChatEdit_InsertName(func)
		for index = 1, #handlers_name do
			if func == handlers_name[index] then
				return;
			end
		end
		handlers_name[#handlers_name + 1] = func;
	end
	function _G.ALA_UNHOOK_ChatEdit_InsertName(func)
		for index = 1, #handlers_name do
			if func == handlers_name[index] then
				tremove(handlers_name, i);
				return;
			end
		end
	end
	function _G.ALA_HOOK_ChatEdit_InsertLink(func)
		for index = 1, #handlers_link do
			if func == handlers_link[index] then
				return;
			end
		end
		handlers_link[#handlers_link + 1] = func;
	end
	function _G.ALA_UNHOOK_ChatEdit_InsertLink(func)
		for index = 1, #handlers_link do
			if func == handlers_link[index] then
				tremove(handlers_link, index);
				return;
			end
		end
	end
	hooksecurefunc("ChatEdit_InsertLink", function(link, addon, ...)
		if ChatEdit_GetActiveWindow() then
			return false;
		end
		if MacroFrameText and MacroFrameText:HasFocus() then
			return false;
		end
		if CommunitiesFrame and CommunitiesFrame.ChatEditBox:HasFocus() then
			return false;
		end
		if addon == false or MT.IsOverridedByAuction() then
			return false;
		end
		if _G.ALA_INSERT_LINK(link, addon, ...) then
			return true;
		end
		return false;
	end)
	--[==[
	local __ChatEdit_InsertLink = _G.ChatEdit_InsertLink;
	function _G.ChatEdit_InsertLink(link, addon, ...)
		if not link then return; end
		if addon == false or MT.IsOverridedByAuction() then
			return __ChatEdit_InsertLink(link, addon, ...);
		end
		local editBox = ChatEdit_ChooseBoxForSend();
		if not editBox:HasFocus() then
			if _G.ALA_INSERT_LINK(link, addon, ...) then
				return true;
			end
		end
		return __ChatEdit_InsertLink(link, addon, ...);
	end
	--]==]
end
