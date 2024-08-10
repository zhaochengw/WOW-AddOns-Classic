---------------------------
--Nova Spell Rank Checker--
---------------------------
--Novaspark/Venomisto-Arugal OCE (classic)
--https://www.curseforge.com/members/venomisto/projects
--Adds a button to spellbook when clicked will highlight any low spell ranks on your hotbars.

local spellData, highlighted = {}, {};
local defaultBars = {"Action", "MultiBarBottomLeft", "MultiBarBottomRight", "MultiBarRight", "MultiBarLeft"};

local function getSpelldata()
	spellData = {};
	for tab = 1, GetNumSpellTabs() do
		local name, texture, offset, numSlots, isGuild, offspecID = GetSpellTabInfo(tab);
		for i = offset + 1, offset + numSlots do
			local spellName, spellSubText, spellID = GetSpellBookItemName(i, BOOKTYPE_SPELL);
			local rank = strmatch(spellSubText, "%d+");
			if (rank) then
				rank = tonumber(rank);
				if (rank > 0 and not spellData[spellName] or rank > spellData[spellName]) then
					spellData[spellName] = rank;
				end
			end
		end
	end
	return spellData;
end

local function removeAllHighlighted()
	for k, v in pairs(highlighted) do
		ActionButton_HideOverlayGlow(v);
	end
	highlighted = {};
end

--Some of these addons also use default bars or whatever, this is made so multiple scan types can be run in one go.
local function scanDefaultUI(spellData, count)
	count = count or 0;
	for bar, barName in pairs(defaultBars) do
		for i = 1, 12 do
			local button = _G[barName .. "Button" .. i];
			if (button) then
				local slot = button.action or 0;
				if (slot and HasAction(slot)) then
					local spellID = 0;
					local actionType, id = GetActionInfo(slot);
					if (actionType == "macro") then
						spellID = GetMacroSpell(id);
					elseif (actionType == "spell") then
						spellID = id;
					end
					if (spellID and spellID > 0) then
						local spellName, rank = GetSpellInfo(spellID)
						local spell = Spell:CreateFromSpellID(spellID);
						spell:ContinueOnSpellLoad(function()
							local spellName = spell:GetSpellName();
							local spellSubText = spell:GetSpellSubtext();
							local rank = strmatch(spellSubText, "%d+");
							if (rank) then
								rank = tonumber(rank);
								if (rank and spellData[spellName] and rank < spellData[spellName]) then
									count = count + 1;
									ActionButton_ShowOverlayGlow(button);
									tinsert(highlighted, button);
									local text = "|cFFFFFF00Bar " .. bar .. " Slot " .. i .. ":|r " .. GetSpellLink(spellID) .. " |cFF9CD6DE(" .. RANK .. " " .. rank .. ")|r";
									text = text .. " |cFFFF6900Not Max Rank.|r";
									print(text);
								end
							end
						end);
					end
				end
			end
		end
	end
	return count;
end

local function scanBartender4(spellData, count)
	count = count or 0;
	for i = 1, 120 do
		local button = _G["BT4Button" .. i];
		if (button) then
			local slot = _G["BT4Button" .. i].id;
			if (slot and HasAction(slot)) then
				local spellID = 0;
				local actionType, id = GetActionInfo(slot);
				if (actionType == "macro") then
					spellID = GetMacroSpell(id);
				elseif (actionType == "spell") then
					spellID = id;
				end
				if (spellID and spellID > 0) then
					local spellName, rank = GetSpellInfo(spellID)
					local spell = Spell:CreateFromSpellID(spellID);
					spell:ContinueOnSpellLoad(function()
						local spellName = spell:GetSpellName();
						local spellSubText = spell:GetSpellSubtext();
						local rank = strmatch(spellSubText, "%d+");
						if (rank) then
							rank = tonumber(rank);
							if (rank and spellData[spellName] and rank < spellData[spellName]) then
								count = count + 1;
								local bar = ceil(i / 12);
								local slot = i % 12;
								if (slot == 0) then
									slot = 12;
								end
								ActionButton_ShowOverlayGlow(button);
								tinsert(highlighted, button);
								local text = "|cFFFFFF00Bar " .. bar .. " Slot " .. slot .. ":|r " .. GetSpellLink(spellID) .. " |cFF9CD6DE(" .. RANK .. " " .. rank .. ")|r";
								text = text .. " |cFFFF6900Not Max Rank.|r";
								print(text);
							end
						end
					end);
				end
			end
		end
	end
	return count;
end

local function scanElvUI(spellData, count)
	count = count or 0;
	for bar = 1, 12 do
		for slotNum = 1, 12 do
			local button = _G["ElvUI_Bar" .. bar .. "Button" .. slotNum];
			if (button) then
				local slot = _G["ElvUI_Bar" .. bar .. "Button" .. slotNum]._state_action;
                if (slot and HasAction(slot)) then
					local spellID = 0;
					local actionType, id = GetActionInfo(slot);
					if (actionType == "macro") then
						spellID = GetMacroSpell(id);
					elseif (actionType == "spell") then
						spellID = id;
					end
					if (spellID and spellID > 0) then
						local spellName, rank = GetSpellInfo(spellID)
						local spell = Spell:CreateFromSpellID(spellID);
						spell:ContinueOnSpellLoad(function()
							local spellName = spell:GetSpellName();
							local spellSubText = spell:GetSpellSubtext();
							local rank = strmatch(spellSubText, "%d+");
							if (rank) then
								rank = tonumber(rank);
								if (rank and spellData[spellName] and rank < spellData[spellName]) then
									count = count + 1;
									ActionButton_ShowOverlayGlow(button);
									tinsert(highlighted, button);
									local text = "|cFFFFFF00Bar " .. bar .. " Slot " .. slotNum .. ":|r " .. GetSpellLink(spellID) .. " |cFF9CD6DE(" .. RANK .. " " .. rank .. ")|r";
									text = text .. " |cFFFF6900Not Max Rank.|r";
									print(text);
								end
							end
						end);
					end
				end
			end
		end
	end
	return count;
end

local function scanDominos(spellData, count)
	count = count or 0;
	--For dominos we need to scan default bars too, it seems to use some.
	count = count + scanDefaultUI(spellData, count);
	for i = 1, 120 do
		local button = _G["DominosActionButton" .. i];
		if (button) then
			local slot = _G["DominosActionButton" .. i].action;
			if (slot and HasAction(slot)) then
				local spellID = 0;
				local actionType, id = GetActionInfo(slot);
				if (actionType == "macro") then
					spellID = GetMacroSpell(id);
				elseif (actionType == "spell") then
					spellID = id;
				end
				if (spellID and spellID > 0) then
					local spellName, rank = GetSpellInfo(spellID)
					local spell = Spell:CreateFromSpellID(spellID);
					spell:ContinueOnSpellLoad(function()
						local spellName = spell:GetSpellName();
						local spellSubText = spell:GetSpellSubtext();
						local rank = strmatch(spellSubText, "%d+");
						if (rank) then
							rank = tonumber(rank);
							if (rank and spellData[spellName] and rank < spellData[spellName]) then
								count = count + 1;
								local bar = ceil(i / 12);
								local slot = i % 12;
								if (slot == 0) then
									slot = 12;
								end
								ActionButton_ShowOverlayGlow(button);
								tinsert(highlighted, button);
								local text = "|cFFFFFF00Bar " .. bar .. " Slot " .. slot .. ":|r " .. GetSpellLink(spellID) .. " |cFF9CD6DE(" .. RANK .. " " .. rank .. ")|r";
								text = text .. " |cFFFF6900Not Max Rank.|r";
								print(text);
							end
						end
					end);
				end
			end
		end
	end
	return count;
end

local function scanHotbars()
	print("|cFF00C800Scanning hotbars for low rank spells:");
	removeAllHighlighted();
	local count;
	local spellData = getSpelldata();
	if (Bartender4) then
		count = scanBartender4(spellData)
	elseif (ElvUI) then
		count = scanElvUI(spellData)
	elseif (Dominos) then
		count = scanDominos(spellData);
	else
		count = scanDefaultUI(spellData);
	end
	if (count > 0) then
		print("|cFF00C800Finished, |cFFFF6900" .. count .. "|r slots found with low rank spells.");
	else
		print("|cFF00C800Finished, none found.");
	end
	spellData = {};
end

local function checkSingleSlot()
	---TODO: Recheck slot when we drag a new spell if slot is highlighted.
	---For now we just remove highlights when spellbook is closed.
end

SpellBookFrame:HookScript("OnHide", function(self, arg)
	removeAllHighlighted();
end)

local button = CreateFrame("Button", "$parentButton", SpellBookFrame, "UIPanelButtonTemplate");
button:SetFrameLevel(15);
if (ElvUI) then
	button:SetPoint("TOPRIGHT", SpellBookFrame, "TOPRIGHT", -72, -34);
else
	button:SetPoint("TOPRIGHT", SpellBookFrame, "TOPRIGHT", -56, -52);
end
button:SetWidth(140);
button:SetHeight(24);
button:SetScale(0.8);
button:SetText("Check Hotbar Ranks");
button:SetScript("OnClick", function(self, arg)
	scanHotbars();
end)