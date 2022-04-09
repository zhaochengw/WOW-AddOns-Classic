--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	喜欢加密和乱码的亲，请ALT+F4
--]]--
local ADDON, NS = ...;

local _G = _G;
do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("ain assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local function _noop_()
	return true;
end

local func = {  };
local var = {
};
local target_warn_sv = nil;
local pGUID = UnitGUID('player');


local board = CreateFrame("FRAME", nil, UIParent, "BackdropTemplate");
board:SetSize(320, 20);
board:SetBackdrop({
	bgFile = "Interface/ChatFrame/ChatFrameBackground",
	edgeFile = "Interface/ChatFrame/ChatFrameBackground",
	tile = true,
	edgeSize = 1,
	tileSize = 5,
});
board:SetPoint("TOP", 0, -200);
board:Show();
board:SetMovable(true);
-- board:EnableMouse(true);
-- board:RegisterForDrag("LeftButton");
board:SetClampedToScreen(true);

function func.lock()
	board:EnableMouse(false);
	board:SetBackdropColor(0.0, 0.0, 0.0, 0.0);
	board:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.0);
	target_warn_sv.locked = true;
end
function func.unlock()
	board:EnableMouse(true);
	board:SetBackdropColor(0.0, 0.0, 0.0, 0.5);
	board:SetBackdropBorderColor(0.0, 0.0, 0.0, 0.5);
	target_warn_sv.locked = false;
end
function func.reset_pos()
	board:ClearAllPoints();
	board:SetPoint("TOP", 0, -200);
end
function func.on()
	board:Show();
	target_warn_sv.enabled = true;
end
function func.off()
	board:Hide();
	target_warn_sv.enabled = false;
end

local drop_menu_table = {
	handler = _noop_,
	elements = {
		{
			handler = func.lock,
			para = {  },
			text = "锁定",
		},
		{
			handler = func.off,
			para = {  },
			text = "关闭",
		}
	},
};

board:SetScript("OnMouseDown", function(self, button)
	if button == "LeftButton" then
		self:StartMoving();
	else
		ALADROP(board, "BOTTOMLEFT", drop_menu_table);
	end
end);
board:SetScript("OnMouseUp", function(self, button)
	self:StopMovingOrSizing();
	target_warn_sv.pos = { self:GetPoint(), };
	for i, v in ipairs(target_warn_sv.pos) do
		if type(v) == 'table' then
			target_warn_sv.pos[i] = v:GetName();
		end
	end
end);

local lines = {  };
local units = {  };
local n_actually_units = 0;

function func.add_line(index)
	local line = board:CreateFontString(nil, "OVERLAY");
	line:SetFont(GameFontNormal:GetFont(), 18);
	line:SetPoint("TOP", board, "TOP", 0, - 18 * (index - 1));
	line:Show();
	line.id = index;
	lines[index] = line;
	return line;
end

function func.update_table()
	for i = #units, 1, -1 do
		if not UnitExists(units[i]) or UnitIsFriend(units[i], 'player') or not UnitIsUnit(units[i] .. 'target', 'player') then
			tremove(units, i);
		end
	end
	func.update_nameplate();
end

function func.update_nameplate()
	local i = 1;
	while true do
		local unit = 'nameplate' .. i;
		if UnitExists(unit) then
			if not UnitIsFriend(unit, 'player') and UnitIsUnit(unit .. 'target', 'player') then
				func.add_unit(unit);
			else
				func.del_unit(unit);
			end
		else
			func.del_unit(unit);
			break;
		end
		i = i + 1;
	end
end

function func.update_line()
	local index = 1;
	local prev_unit = 'player';
	n_actually_units = 0;
	for i = 1, #units do
		if not UnitIsUnit(prev_unit, units[i]) then
			local line = lines[index] or func.add_line(index);
			local r, g, b = UnitSelectionColor(units[i]);
			local n = UnitName(units[i]);
			if n then
				line:SetText(format("\124cff%.2x%.2x%.2x%s\124r 的目标是 \124cffff00ff>>\124r \124cff00ff00你\124r \124cffff00ff<<\124r", r * 255, g * 255, b * 255, n));
				prev_unit = units[i];
				index = index + 1;
				n_actually_units = n_actually_units + 1;
			end
		end
	end
	if n_actually_units < #lines then
		for i = n_actually_units + 1, #lines do
			lines[i]:SetText("");
		end
	end
end

function func.add_unit(unit)
	for i = 1, #units do
		if units[i] == unit then
			return;
		end
	end
	for i = 1, #units do
		if UnitIsUnit(units[i], unit) then
			tinsert(units, i, unit);
			-- print("ADD", unit);
			return;
		end
	end
	tinsert(units, unit);
	-- print("ADD", unit);
	func.update_line();
end

function func.del_unit(unit)
	for i = 1, #units do
		if units[i] == unit then
			tremove(units, i);
			-- print("DEL", unit);
			break;
		end
	end
	func.update_line();
end

function func.NAME_PLATE_UNIT_ADDED(unit)
	func.update_nameplate();
end
function func.NAME_PLATE_UNIT_REMOVED(unit)
	func.update_nameplate();
end
function func.UNIT_TARGET(unit)
	-- print("UNIT_TARGET", unit, not UnitIsFriend(unit, 'player'), UnitIsUnit(unit .. 'target', 'player'))
	if unit == 'player' then
		if UnitExists('target') and not UnitIsFriend('target', 'player') and UnitIsUnit('targettarget', 'player') then
			func.add_unit('target');
		else
			func.del_unit('target');
		end
	else
		if UnitIsFriend(unit, 'player') then
			func.del_unit(unit);
			unit = unit .. 'target';
			if not UnitExists(unit) then
				func.del_unit(unit);
				return;
			end
		end
		if not UnitIsFriend(unit, 'player') and UnitIsUnit(unit .. 'target', 'player') then
			func.add_unit(unit);
		else
			func.del_unit(unit);
		end
	end
end
function func.ADDON_LOADED(addon)
	if addon ~= ADDON then
		return;
	end
	board:UnregisterEvent("ADDON_LOADED");
	-- print(alaMiscSV)
	target_warn_sv = alaMiscSV.target_warn_sv[pGUID];
	if target_warn_sv.locked then
		func.lock();
	else
		func.unlock();
	end
	if target_warn_sv.enabled then
		func.on();
	else
		func.off();
	end
	if target_warn_sv.pos then
		board:ClearAllPoints();
		board:SetPoint(target_warn_sv.pos[1], target_warn_sv.pos[2], target_warn_sv.pos[3], target_warn_sv.pos[4], target_warn_sv.pos[5]);
	end
	C_Timer.NewTicker(0.667, func.update_table);
end

board:RegisterEvent("ADDON_LOADED");
board:RegisterEvent("UNIT_TARGET");
board:RegisterEvent("NAME_PLATE_UNIT_REMOVED");
board:RegisterEvent("NAME_PLATE_UNIT_ADDED");
function func.OnEvent(self, event, ...)
	func[event](...);
end
board:SetScript("OnEvent", func.OnEvent);

_G.SLASH_ALAUNITWARN1 = "/alaunitwarn";
_G.SLASH_ALAUNITWARN2 = "/alawarn";
_G.SLASH_ALAUNITWARN3 = "/auw";
SlashCmdList["ALAUNITWARN"] = function(msg)
	if strfind(msg, "^lock") then
		func.lock();
	elseif strfind(msg, "^unlock") then
		func.unlock();
	elseif strfind(msg, "^on") then
		func.on();
	elseif strfind(msg, "^off") then
		func.off();
	elseif strfind(msg, "^toggle_lock") then
		if target_warn_sv.locked then
			func.unlock();
		else
			func.lock();
		end
	elseif strfind(msg, "^reset_pos") then
		func.reset_pos();
	end
end
