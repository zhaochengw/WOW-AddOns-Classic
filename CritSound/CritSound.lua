
local directory = "Interface\\AddOns\\CritSound\\Sounds\\";

local sounds = {
	--spell damage
	spell = {
			"CriticalDamage.ogg",	--first time
			"Dominating.ogg",		--second time
			"Unstoppable.ogg",		--etc.
			"Wickedsick.ogg",
			"Godlike.ogg",
		},
	--magic shield
	shield = {
			"Shield.ogg",
		},
	--melee damage
	swing = {
			"Fight.ogg",
			"Swing.ogg",
			"SoulShatter.ogg",
		},
	--range damage, such as shooting, wand
	range = {
			"Gun1.ogg",
			"Gun2.ogg",
			"Gun3.ogg",
		},
	--healing spells
	heal = {
			"CritHeal.ogg",
		},
}

local records = {
	spell	= {times = 0, lasttime = 0},
	shield	= {times = 0, lasttime = 0},
	swing	= {times = 0, lasttime = 0},
	range	= {times = 0, lasttime = 0},
	heal	= {times = 0, lasttime = 0},
}

function CritSound_BlackListCheck(spellname)
	local id = 1;
	while ( CritSoundBlackList[id]) do
		if CritSoundBlackList[id] ~= spellname then
			id = id + 1;
		else
			return true;
		end
	end
	return false;
end

function CritSound_OnEvent(self, event)
	local timestamp, combatevent, hideCaster, sourceGUID, sourceName, sourceFlags, sourceRaidFlags, destGUID, destName, destFlags, destRaidFlags = CombatLogGetCurrentEventInfo();
	if CombatLog_Object_IsA(sourceFlags, COMBATLOG_FILTER_MINE) then
		local tobeskip = false;
		if (combatevent == "SPELL_DAMAGE") then
			if (CritSoundSwitch["spell"] == 1) then
				local _, spellname, _, _, _, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo());
				if critical then
					tobeskip = CritSound_BlackListCheck(spellname);
					if tobeskip == false then
						CritSound_UpdateTable("spell");
						CritSound_Announce("spell");
					end
				else
					CritSound_WipeTable("spell");
				end
			end
		elseif (combatevent == "DAMAGE_SHIELD") then
			if (CritSoundSwitch["shield"] == 1) then
				local critical = select(21, CombatLogGetCurrentEventInfo());
				if critical then
					CritSound_UpdateTable("shield");
					CritSound_Announce("shield");
				else
					CritSound_WipeTable("shield");
				end
			end
		elseif (combatevent == "SWING_DAMAGE") then
			if (CritSoundSwitch["swing"] == 1) then
				local critical = select(18, CombatLogGetCurrentEventInfo());
				if critical then
					CritSound_UpdateTable("swing");
					CritSound_Announce("swing");
				else
					CritSound_WipeTable("swing");
				end
			end
		elseif (combatevent == "RANGE_DAMAGE") then
			if (CritSoundSwitch["range"] == 1) then
				local critical = select(21, CombatLogGetCurrentEventInfo());
				if critical then
					CritSound_UpdateTable("range");
					CritSound_Announce("range");
				else
					CritSound_WipeTable("range");
				end
			end
		elseif (combatevent == "SPELL_HEAL") then
			if (CritSoundSwitch["heal"] == 1) then
				local _, spellname, _, _, _, _, critical = select(12, CombatLogGetCurrentEventInfo());
				if critical then
					tobeskip = CritSound_BlackListCheck(spellname);
					if tobeskip == false then
						CritSound_UpdateTable("heal");
						CritSound_Announce("heal");
					end
				else
					CritSound_WipeTable("heal");
				end
			end
		end
	end
end

--clean up the records
function CritSound_WipeTable(tpye)
	records[tpye]["times"] = 0;
end

--update the records when critical hits happen
function CritSound_UpdateTable(tpye)
	local timenow = GetTime();
	if (timenow - records[tpye]["lasttime"] < CritSoundAgingTime) then
		records[tpye]["times"] = records[tpye]["times"] + 1;
	else
		records[tpye]["times"] = 1;
	end

	records[tpye]["lasttime"] = timenow;
end

--play sounds when critical hits happen
function CritSound_Announce(tpye)
	local num = records[tpye]["times"];
	local len = table.getn(sounds[tpye]);
	if (CritSoundMode == 1) then
		PlaySoundFile(directory..sounds[tpye][1]);
	elseif (CritSoundMode == 2) then
		if (num <= len) then
			PlaySoundFile(directory..sounds[tpye][num]);
		else
			PlaySoundFile(directory..sounds[tpye][len]);
		end
	elseif (CritSoundMode == 3) then
		PlaySoundFile(directory..sounds[tpye][math.random(1,len)]);
	end
end

function CritSound_Options_Init()
	if not CritSoundAgingTime then 
		CritSoundAgingTime = 10; --the aging time for cleaning up records.
	end
	if not CritSoundMode then 
		CritSoundMode = 1; --1: single mode, 2: sequence mode, 3: random mode.
	end
	if not CritSoundSwitch then 
		CritSoundSwitch = {spell = 1, shield = 1, swing = 1, range = 1, heal = 1};
	end
	if not CritSoundBlackList then
		CritSoundBlackList = {};
	end
end

local cs = CreateFrame("Frame");
cs:RegisterEvent("ADDON_LOADED");
cs:RegisterEvent("VARIABLES_LOADED");
cs:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
cs:SetScript("OnEvent", function(self, event)
	if event == "ADDON_LOADED" then
		CritSound_Options_Init();
	elseif event == "VARIABLES_LOADED" then
		print("|cFFFFFF99CritSound loaded. Type /cs or /critsound to open the option panel.|R");
	elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
		CritSound_OnEvent(self, event);
	end
end)

--option panel fix
local function CritSound_OpenInterfacePanel(panel)
	-- if not fixed then
		local panelName = panel.name;
		if not panelName then return end
		local t = {};
		for i, p in pairs(INTERFACEOPTIONS_ADDONCATEGORIES) do
			if p.name == panelName then
				p.collapsed = true;
				t.element = p;
				InterfaceOptionsListButton_ToggleSubCategories(t);
			end
		end
		-- fixed = true;
	-- end
	InterfaceOptionsFrame_OpenToCategory(panel);
end

function CritSound_LoadOptionPanel()
	if not IsAddOnLoaded("CritSound_Options") then
		local playerName = UnitName("player");
		local enabled = GetAddOnEnableState(playerName, "CritSound_Options")
		if enabled == 0 then
			EnableAddOn("CritSound_Options");
		end
		local loaded = LoadAddOn("CritSound_Options");
		if not loaded then
			print("|cFFFF0000The option panel can't be loaded.|R");
			return false;
		end
	end
end

--slash command
SlashCmdList["CritSound"] = function()
	local result = CritSound_LoadOptionPanel();
	if result == false then return end;
	CritSound_OpenInterfacePanel(CritSound_OptionsFrame);
end;
SLASH_CritSound1 = "/critsound";
SLASH_CritSound2 = "/cs";
