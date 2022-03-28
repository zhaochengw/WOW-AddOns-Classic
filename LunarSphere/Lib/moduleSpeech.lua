-- /***********************************************
--  * Lunar Speech Module
--  *********************
--
--  Author	: Moongaze (Twisting Nether)
--  Description	: Handles the management of the speech library and the scripts that are
--                found within it. Also tracks spells that are linked to scripts for
--                speech output.
--
--  ***********************************************/

-- /***********************************************
--  * Module Setup
--  *********************

-- ~50k memory might be saved with memory management feature

-- Define Lunar and the Lunar Speech objects if they are not already defined

if (not Lunar) then
	Lunar = {};
end

if (not Lunar.Speech) then
	Lunar.Speech = {};
end

Lunar.Speech.version = 1.52;

-- The speech module uses the speechDatabase table and the LunarSphereGlobal.speechLibrary table
-- for tracking and storing scripts and speeches. Below is the description of what each table
-- holds, data wise, as a reference.

--[[

speechDatabase description:
============================
speechDatabase[ 0 ] = script name
speechDatabase[>1 ] = speech text. If nil, and the index is within range of the script count, the data will be
		      pulled from the LunarSphereGlobal speechLibrary
[1] speechDatabase.lastScript = (index) last script index that was successfully displayed

LunarSphereGlobal.speechLibrary description:
============================
speechLibrary[ 0 ] = script name
speechLibrary[>4 ] = speech text. If nil, and the index is within range of the script count, the data will be
		     pulled from the default scripts, if available and a part of the default names
[1] speechLibrary.scriptCount = total scripts in library.
[2] speechLibrary.runProbability = (nil, 0 - 100) chance to display text, 0 being never, 100 being always, and nil being always
[3] speechLibrary.inOrder = (true|nil) whether or not to pull the speeches in order or at random
[4] speechLibrary.channelType = channel to display the data to:
	(LUNAR_SPEECH_SAY=nil, LUNAR_SPEECH_GROUP="GROUP", LUNAR_SPEECH_RAID="RAID", LUNAR_SPEECH_ANY="ANY")
--]]

-- Create our some local databases

--local speechDatabase	= {};	-- Deals with scripts and speeches in the library that are full of default data
local trackedSpell	= {};	-- Deals with all the tracked spells and their respective script ids

-- Grab local copies of these functions. We'll probably need to use them a few times.

local string = string;
local table = table;

-- Set some global variables to represent speech channel names.

LUNAR_SPEECH_SAY	= "SAY";
LUNAR_SPEECH_PARTY	= "PARTY";
LUNAR_SPEECH_RAID	= "RAID";
LUNAR_SPEECH_ANY	= "ANY";

-- Stores the localized summon text, so we don't attach it as a rank on mount spells...
local summonText;

-- Create a table used to convert some dropdown menu choices into action catagories

Lunar.Speech.actionAssignNames = {
	[2] = "drink:::Interface\\Icons\\INV_Drink_12",
	[3] = "food:::Interface\\Icons\\INV_Misc_Food_18",
	[4] = "healingItem:::Interface\\Icons\\INV_Potion_131",
	[5] = "manaItem:::Interface\\Icons\\INV_Potion_137",
	[6] = "energyDrink:::Interface\\Icons\\INV_Drink_Milk_05",
	[7] = "ragePotion:::Interface\\Icons\\INV_Potion_24",
	[8] = "bandage:::Interface\\Icons\\INV_Misc_Bandage_02",
	[9] = "mount:::Interface\\Icons\\INV_Misc_Foot_Centaur",
	[10] = "groundMount:::Interface\\Icons\\Ability_Mount_NightmareHorse",
	[11] = "flyingMount:::Interface\\Icons\\Ability_Mount_WarHippogryph",
	[12] = "companion:::Interface\\Icons\\Ability_Hunter_BeastCall",
};


function Lunar.Speech:Load()
	
if (LunarSphereSettings) and not (LunarSphereSettings.memoryDisableSpeech) then

function Lunar.Speech:WipeLibrary(includeGlobal)

	-- Wipe the database (it will be rebuilt on next login, unless data is
	-- added to the database after the wipe was done)

	if (includeGlobal == true) then
		LunarSphereGlobal.script = nil;
	end	

	LunarSpeechLibrary = nil;

--	speechDatabase = {};

	-- Since no scripts exist, make sure we aren't watching any spells either

	Lunar.Speech:UpdateRegisteredSpells();

end

function Lunar.Speech:UpdateRegisteredSpells()

	-- Set our locals

	local spellIndex, scriptIndex, spellName;

	-- Wipe all of the trackedSpell database (we will reuse it, cut down on garbage

	for spellIndex = 1, table.getn(trackedSpell) do 
		if (trackedSpell[spellIndex][0]) then
			trackedSpell[spellIndex][0] = nil;
			for scriptIndex = 1, table.getn(trackedSpell[spellIndex]) do 
				trackedSpell[spellIndex][scriptIndex] = nil;
			end
			trackedSpell[spellIndex].n = 0
		end
		trackedSpell.n = 0
	end

	-- Now, crawl through every script. If that script has a spell list, we will
	-- cycle through each spell and add it to the tracked spells database along
	-- with the scriptIndex we're looking at

	if (LunarSpeechLibrary.script) then
		for scriptIndex = 1, table.getn(LunarSpeechLibrary.script) do 
--			if (LunarSpeechLibrary.script[scriptIndex].actionAssign or (0)) > 0 then
				if LunarSpeechLibrary.script[scriptIndex].spells then
					for spellIndex = 1, table.getn(LunarSpeechLibrary.script[scriptIndex].spells) do 
						Lunar.Speech:AddTrackedSpell(LunarSpeechLibrary.script[scriptIndex].spells[spellIndex], scriptIndex);
					end
				end
--			end		
		end
	end

end

function Lunar.Speech:Initialize()

	-- Create our watch frame for all spell events so we can react to them
	-- and, well ... do speeches ^_^

	Lunar.Speech.SpellSentry = CreateFrame("Frame", "LunarSpeechSpellSentry", UIParent, BackdropTemplateMixin and "BackdropTemplate");

	Lunar.Speech.SpellSentry:SetWidth(1);
	Lunar.Speech.SpellSentry:SetHeight(1);
	Lunar.Speech.SpellSentry:EnableMouse(false);
	Lunar.Speech.SpellSentry:SetAlpha(0);
	Lunar.Speech.SpellSentry:SetScript("OnEvent", Lunar.Speech.OnEvent);
	Lunar.Speech.SpellSentry:RegisterEvent("UNIT_SPELLCAST_STOP");
	Lunar.Speech.SpellSentry:RegisterEvent("UNIT_SPELLCAST_START");
	Lunar.Speech.SpellSentry:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED");
	Lunar.Speech.SpellSentry:RegisterEvent("UNIT_SPELLCAST_SENT");
	Lunar.Speech.SpellSentry:Show();

	-- Load our library and then register our spells

	Lunar.Speech:LoadLibrary();
	Lunar.Speech:UpdateRegisteredSpells();

	summonText = select(2, GetSpellInfo(23214));
	Lunar.Speech.summonText = summonText;

end

function Lunar.Speech.OnEvent(self, event, unit, target, castGUID, spellID)

	-- Ignore all spells that are not from the player

	if (unit ~= "player") then
		return;
	end

	-- If the player starts to cast a spell, notate that a spell is being cast
	-- and grab the currently active spell of the player. This is needed in 
	-- order to catch spells that have a cast time.

	if (event == "UNIT_SPELLCAST_SENT") then
		self.spellName, self.spellRank = GetSpellInfo(spellID);
		self.spellTarget = target;

		-- If the target data doesn't exist, grab it from the player target if possible
		if ((not target or (target == "")) and UnitName("target")) then
			self.spellTarget = UnitName("target") or ("");
		end
	end

	if (event == "UNIT_SPELLCAST_START") then

		self.spellStart = true;
		Lunar.Speech.CheckCurrentAction(self);

	-- If the player stops casting a spell, clear the spellStart flag

	elseif (event == "UNIT_SPELLCAST_STOP") then

		self.spellStart = nil;

	-- If the player successfully casts a spell and they didn't have a spell
	-- start event (due to it being an instant spell), check the current
	-- spell for speeches

	elseif (event == "UNIT_SPELLCAST_SUCCEEDED") and not (self.spellStart) then
		Lunar.Speech.CheckCurrentAction(self);
	end
end
--REVISE
function Lunar.Speech:Import()
	
	-- Checks to see if there is export data to be imported. If not, leave now

	if not (LunarSphereExport or LunarSphereImport)  then
		return;
	end

	if not ((LunarSphereExport and LunarSphereExport.speech) or (LunarSphereImport and LunarSphereImport.speech)) then
		return;
	end

	-- Crawl through each script in the export data and check if it exists in our
	-- own database. We check if it's a default script first, then if it's script
	-- name exists.

	local scriptName, scriptID, speechID, importID, defaultName, defaultTotal, defaultID, success, j;
	local newScripts, newSpeeches = 0, 0;

	local db = LunarSphereImport;
	
	for j = 1, 2 do 
		if (db) and (db.speech) then
			for importID = 1, table.getn(db.speech) do 

				-- If it's a default script, find the same default script
				-- in our database and save the scriptID

				defaultName, defaultTotal, scriptName = nil, nil, nil;

				if (db.speech[importID].default) then
						
					-- As a precaution, the default speech count might change
					-- in the future, so we just want the default data NAME
					
					defaultName, defaultTotal = string.match(db.speech[importID].default, "(.*)-(%d+)")

					for defaultID = 1, table.getn(LunarSpeechLibrary.script) do 
						if (LunarSpeechLibrary.script[defaultID].default) then
							if (string.find(LunarSpeechLibrary.script[defaultID].default, defaultName .. "-(%d+)")) then
								scriptName = Lunar.Speech:GetScriptName(defaultID);
								break;
							end
						end
					end

				-- Otherwise, grab the library ID of the script, if it exists.

				else
					scriptID = Lunar.Speech:GetLibraryID(db.speech[importID][0]);
					if (scriptID) then
						scriptName = Lunar.Speech:GetScriptName(scriptID);
					end
				end

				-- Make sure the script ID is valid. If it wasn't valid, we will add the
				-- script to the library and the script ID be the size of the library, + 1;

				if not scriptName then
					Lunar.Speech:AddScriptToLibrary(db.speech[importID][0]);
					newScripts = newScripts + 1;
					scriptName = db.speech[importID][0]
				end

				-- Now, run through every speech found in the imported script and add it to the
				-- saved library. The add speech function will automatically skip speeches
				-- that already exist.

				-- Legacy support ... for now
				defaultTotal = db.speech[importID].speechCount or (table.getn(db.speech[importID])) or (0); 

				for speechID = 1, defaultTotal do
					success = nil;
					if (db.speech[importID][speechID]) then
						success = Lunar.Speech:AddSpeechToScript(scriptName, db.speech[importID][speechID])
						if success then
							newSpeeches = newSpeeches + 1;	
						end
					end
				end
			end
		end
		db = LunarSphereExport;
	end
	Lunar.API:Print(LUNARSPHERE_CHAT .. newScripts .. " new script(s) and " .. newSpeeches .. " new speech line(s) imported.");
	
end

function Lunar.Speech:Export(wipeOldData, scriptID)

	-- Check to see if the exporter is loaded. If not, load it up
	local theReason;
	local isLoaded = IsAddOnLoaded("LunarSphereExporter");
	if ( not isLoaded ) then
		isLoaded, theReason = LoadAddOn("LunarSphereExporter");
	end

	-- If it was successfully loaded, run the exporter and export our data.
	-- Output how many scripts and speeches were exported as well.

	if (( isLoaded ) and (Lunar.Export)) then
		local scripts, speeches = Lunar.Export:ExportData("speech", wipeOldData, scriptID);
		Lunar.API:Print(LUNARSPHERE_CHAT .. scripts .. " script(s) with " .. speeches .. " speech line(s) exported.");
	else
		Lunar.API:Print(LUNARSPHERE_CHAT .. Lunar.Locale["_LUNAR_EXPORT_NOT_FOUND"]);
	end			

end

function Lunar.Speech:ToggleGlobal(scriptID)

	-- If the script entry exists, continue

	local db = LunarSpeechLibrary.script[scriptID];
	if (db) then

		-- If there were speeches found locally, make them global

		if (db.speeches) then

			-- If the global space doesn't exist, make it. Then, insert
			-- our local script into the global space. Save the unique
			-- script ID and the default data, if it exists

			if not LunarSphereGlobal.script then
				LunarSphereGlobal.script = {};
			end
			table.insert(LunarSphereGlobal.script,
			{
				id = db.id,
				speeches = db.speeches,
				default = db.default;
			});

			-- Clear our local speeches

			db.speeches = nil;

		-- Otherwise, it was global, so make it local again

		else
			
			-- Get our script name and it's global ID for the transfer
			-- back to local. Then, if it exists, set the local speeches
			-- to our global ones and remove the global entry.

			local scriptName = Lunar.Speech:GetScriptName(scriptID);	
			local globalID, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
			if (isGlobal) then
				db.speeches = LunarSphereGlobal.script[globalID].speeches;
				table.remove(LunarSphereGlobal.script, globalID);
			end
		end
	end
	
end

function Lunar.Speech.CheckCurrentAction(self)

	-- Check if the spell is tracked. If it is, continue

	if not LunarSphereSettings.muteSpeech then

		local spellData = self.spellName;
--		if (self.spellRank and (self.spellRank ~= "") and  (self.spellRank ~= summonText) and (not string.find(self.spellRank, "%d"))) then
		if (self.spellRank and (self.spellRank ~= "") and (not string.find(self.spellRank, "%d"))) then
			spellData = spellData .. "(" .. self.spellRank .. ")";
		end

		local id = Lunar.Speech:IsTrackedAction(spellData);
		if (id) then

			-- Re-randomize the timer
			if (math) and (math.randomseed) then
				math.randomseed(math.random(0,214748364)+(GetTime()*1000));
			end

			-- Since spells can have multiple scripts assigned to the
			-- (doubt anyone would do that, but I added support anyway)
			-- We will run ONE of the scripts attached to the spell, at random.
			local scriptID = trackedSpell[id][math.random(1, table.getn(trackedSpell[id]))]
			Lunar.Speech.RunScript(self, Lunar.Speech:GetScriptName(scriptID));
--			Lunar.Speech:RunScript(Lunar.Speech:GetScriptName(trackedSpell[id][math.random(1, table.getn(trackedSpell[id]))]));

	--[[		-- Old code to run all scripts associated with spell
			local scriptIndex
			for scriptIndex = 1, table.getn(trackedSpell[id]) do 
				Lunar.Speech:RunScript(speechDatabase[trackedSpell[id][scriptIndex] ][0]);
			end
	--]]
		end

	end

	-- This spell is now finished. Clear the data

	self.spellName, self.spellTarget, self.spellStart, self.spellRank = nil, nil, nil, nil;

end

function Lunar.Speech:IsTrackedAction(spellName)

	-- If the spellName is wrong, exit now

	if (spellName == "") or (spellName == nil) then
		return;
	end

	-- Create our local variable and if there are entries in the tracked spell
	-- database, continue

	local id;
	
	if trackedSpell[0] then

		-- Search through all tracked spell names. 

		local index, checkSpell;
		for index = 1, table.getn(trackedSpell) do 
			
			checkSpell = trackedSpell[index][0];

			-- If we found the spell name registered, grab the current
			-- ID and return our results.

			if (checkSpell == spellName) then
				id = index;
				break;

			-- If our tracked spell is a special type, we need to
			-- cross-reference our item database to see if there
			-- is a match

			elseif (checkSpell == "healingItem") then
				if (spellName == Lunar.Items:GetItemType("potionHealing")) then
					id = index;
				elseif (Lunar.Items:FindItemInCatagory("potionHealing", spellName)) then
					id = index;
				end
			elseif (checkSpell == "manaItem") then
				if (spellName == Lunar.Items:GetItemType("potionMana")) then
					id = index;
				elseif (spellName == Lunar.Items:GetItemType("manaStone")) then
					id = index;
				elseif (Lunar.Items:FindItemInCatagory("potionMana", spellName)) then
					id = index;
				end						
			elseif (checkSpell == "mount") or (checkSpell == "groundMount") or (checkSpell == "flyingMount") then
				if (Lunar.Items:FindItemInCatagory(checkSpell, spellName)) then
					id = index;
				end
			elseif (checkSpell == "companion") then
				if (Lunar.Items:FindItemInCatagory(checkSpell, spellName)) then
					id = index;
				end
			elseif (checkSpell == "rage") then
				if (Lunar.Items:FindItemInCatagory("ragePotion", spellName)) then
					id = index;
				end
			else
				if (spellName == Lunar.Items:GetItemType(checkSpell)) then
					id = index;
				end
			end
			
		end
	
	end

	return id;

end

function Lunar.Speech:AddTrackedSpell(spellName, scriptID)

	-- Make sure the trackedSpell database has the proper format
	-- if no entries exist.
	
	if not trackedSpell[0] then
		trackedSpell[0] = {};
	end

	-- Parse the spell name (which also has the texture assigned to it)
	-- so we just have the spell name.

	spellName = string.match(spellName, "(.*):::") or (spellName) ;

	-- Search through all tracked spell names for a match. If we found
	-- the spell name already registered, add the script ID to the
	-- list associated with the spell.

	local id = Lunar.Speech:IsTrackedAction(spellName);

	if (id) then
		table.insert(trackedSpell[id], scriptID);

	-- Otherwise, we did not find the spell name, so we add a new
	-- database entry and populate the data we need.
	
	else
		id = (table.getn(trackedSpell) or (0)) + 1;
		trackedSpell[id] = {};
		trackedSpell[id][0] = spellName
		trackedSpell[id][1] = scriptID;
	end

end

function Lunar.Speech:RemoveTrackedSpell(spellName)

	-- If the spell ID exists, remove it

	local id = Lunar.Speech:IsTrackedAction(spellName);
	if (id) then
		table.remove(trackedSpell[index], index);
	end

end

function Lunar.Speech:AddScriptToLibrary(scriptName)

	-- If the script was not found in the library, we proceed to add the default structure of a script

	local success;
	if not Lunar.Speech:GetLibraryID(scriptName) then
		LunarSphereGlobal.scriptData.lastID = LunarSphereGlobal.scriptData.lastID + 1;
--		table.insert(LunarSphereGlobal.speechLibrary, {[0] = scriptName, ["speechCount"] = 0, id = LunarSphereGlobal.scriptData.lastID});
--		table.insert(LunarSpeechLibrary, {["runProbability"] = 100, id = LunarSphereGlobal.scriptData.lastID});
--		table.insert(LunarSphereGlobal.script, {id = LunarSphereGlobal.scriptData.lastID});
		table.insert(LunarSpeechLibrary.script,
		{
			runProbability = 100, 
			id = LunarSphereGlobal.scriptData.lastID,
			speeches = {[0] = scriptName, lastSpeech = nil, speechCount = 0}
		});
--		table.insert(speechDatabase,
--		{
--			[0] = scriptName,
--			lastSpeech = nil,
--			speechCount = 0
--		});
		success = true;
	end
	return success;

end

function Lunar.Speech:RemoveScriptFromLibrary(scriptName)

	local success;
	local globalID, _, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	local id = Lunar.Speech:GetLibraryID(scriptName, true);

	-- Remove the global settings, and then the local settings
	if (isGlobal) then
		table.remove(LunarSphereGlobal.script, globalID);
		success = true;
	end

	if (id) then
		table.remove(LunarSpeechLibrary.script, id);
		success = true;
	end

	return success;

end

function Lunar.Speech:RenameScriptInLibrary(scriptName, newName)

	-- Set our local and if our new name doesn't exist, continue

	local success, db;

	if not Lunar.Speech:GetLibraryID(newName) then

		-- Find the script in the library, if it exists, we continue and
		-- mark that we succeeded.

		local id, _, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
		if (id) then
			if (isGlobal) then
				db = LunarSphereGlobal.script[id].speeches
			else
				db = LunarSpeechLibrary.script[id].speeches
			end
			db[0] = newName;
--			if (isGlobal) then
--				LunarSphereGlobal.script[id].speeches[0] = newName;
--			else
--				LunarSpeechLibrary.script[id].speeches[0] = newName;
--			end
			success = true;
		end

	end

	return success;

end

--
function Lunar.Speech:AddSpeechToScript(scriptName, speechData)

	-- Grab our script information. If it exists, add the new speech data
	-- and increase the speech count. All added speech or edited speech
	-- will always go into the LunarSphereGlobal speech database. The
	-- local database is ONLY for default speeches

	local success, db;
	local id, speechCount, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	if (id) then

		-- We only add speeches that don't exist ...

		if not (Lunar.Speech:FindSpeechInScript(scriptName, speechData)) then
			if (isGlobal) then
				db = LunarSphereGlobal.script[id].speeches
			else
				db = LunarSpeechLibrary.script[id].speeches
			end
			db.speechCount = (speechCount or (0)) + 1;
			db[db.speechCount] = speechData;
--			if (isGlobal) then
--				LunarSphereGlobal.script[id].speeches.speechCount = (speechCount or (0)) + 1;
--				LunarSphereGlobal.script[id].speeches[(speechCount or (0)) + 1] = speechData;
--			else
--				LunarSpeechLibrary.script[id].speeches.speechCount = (speechCount or (0)) + 1;
--				LunarSpeechLibrary.script[id].speeches[(speechCount or (0)) + 1] = speechData;
--			end
			success = true;
		end
	end

	return success;
end

function Lunar.Speech:AddSpellToScript(scriptName, spellName)

	-- If the script exists, continue

	local id = Lunar.Speech:GetLibraryID(scriptName, true);
	if (id) then

		-- If we don't have any spells assigned to the script, build the spell list and
		-- assign our spell.

		if not (LunarSpeechLibrary.script[id].spells) then
			LunarSpeechLibrary.script[id].spells = {};
			LunarSpeechLibrary.script[id].spells[1] = spellName;

		-- Otherwise, search each spell that is linked to this script. If no match was found,
		-- we can add it.

		else
			local index = Lunar.Speech:GetSpellFromScript(scriptName, spellName);	
			if not (index) then
				table.insert(LunarSpeechLibrary.script[id].spells, spellName);
			end
		end
	end

end

function Lunar.Speech:RemoveSpellFromScript(scriptName, spellName)

	-- If the script exists, continue

	local id = Lunar.Speech:GetLibraryID(scriptName, true);
	if (id) then
	
		-- If the spell exists, remove it

		local index = Lunar.Speech:GetSpellFromScript(scriptName, spellName);
		if (index) then
			table.remove(LunarSpeechLibrary.script[id].spells, index);
		end

	end

end

function Lunar.Speech:GetSpellFromScript(scriptName, spellName)

	-- Set our locals
	local index, id, returnID;

	-- If the script exists (in local) and there is a spell list for the script, continue

	id = Lunar.Speech:GetLibraryID(scriptName, true);
	if (id) then

		if LunarSpeechLibrary.script[id].spells then

			-- Search the list of spells for this script. If the spell name
			-- if found, notate the index for our return value

			for index = 1, table.getn(LunarSpeechLibrary.script[id].spells) do 
				if (spellName == LunarSpeechLibrary.script[id].spells[index]) then
					returnID = index;
					break;
				end
			end
		end
	end

	return returnID;
	
end

--
function Lunar.Speech:RemoveSpeechFromScript(scriptName, speechData)

	-- Grab our script information. If it exists, continue

	local id, scriptCount, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	
	if (id) and (speechData) then

		-- Create our search indexes and start searching the script
		-- for the specificed speech data. If the speech data is
		-- found, we remove it from the both the saved database

		local db, defaultCount;
		if (isGlobal) then
			db = LunarSphereGlobal.script[id];
--			defaultCount = string.match((LunarSphereGlobal.script[id].default or ("")), "-(%d+)") or (0);
		else
			db = LunarSpeechLibrary.script[id];
--			defaultCount = string.match((LunarSpeechLibrary.script[id].default or ("")), "-(%d+)") or (0);
		end

		local searchCount, index = 1, 1;
		local newCount = scriptCount;
--		defaultCount = tonumber(defaultCount);

		for searchCount = 1, scriptCount do 

			-- If we find the speech, we don't update the index and decrease our speech count
			-- if the speech is not a default speech (we do not delete those)

			if (db.speeches[index] == speechData) then --and (searchCount > defaultCount) then
--			if (LunarSphereGlobal.speechLibrary[id][index] == speechData) and (searchCount > defaultCount) then
				newCount = newCount - 1;

			-- Otherwise, we increase our index

			else
				index = index + 1;
			end

			-- If our search index is less than the original size of the script,
			-- we will shuffle the speeches around based upon the new index saved.
			-- If a speech is to deleted, its index data will be replaced with the element
			-- after it. We can't use table.remove because our table is slightly messed up
			-- with some items being empty at the beginning (default speeches) and our
			-- table size is slightly wrong as well.

			if (searchCount < scriptCount) then
--				LunarSphereGlobal.speechLibrary[id][index] = LunarSphereGlobal.speechLibrary[id][searchCount + 1];
				db.speeches[index] = db.speeches[searchCount + 1];

			-- If we hit the end of the search, and our index is less than or the same as
			-- our searchCount (meaning we deleted something), we set that value to empty.

			else
				if (index <= searchCount) then
--					LunarSphereGlobal.speechLibrary[id][index] = nil;
					db.speeches[index] = nil;
				end	
			end
		end

		-- Update the script's new speech count

--		LunarSphereGlobal.speechLibrary[id].speechCount = newCount;
		db.speeches.speechCount = newCount;
	end
end

--
function Lunar.Speech:FindSpeechInScript(scriptName, speechData)

	-- Grab our script information. If it exists, continue

	local id, scriptCount, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	local speechID, db;

	if (id) and (speechData) then

		if (isGlobal) then
			db = LunarSphereGlobal.script[id].speeches
		else
			db = LunarSpeechLibrary.script[id].speeches
		end

		-- Create our search indexes and start searching the script
		-- for the specificed speech data.

		local index;

		for index = 1, scriptCount do 

			-- If we find the speech, we notate that it exists and break our loop

			if (db[index] == speechData) then
--			if (LunarSphereGlobal.speechLibrary[id][index] == speechData) or (speechDatabase[id][index] == speechData) then
				speechID = index;
				break;
			end

		end

	end

	-- Return the speech ID, if it was found

	return speechID;
end

function Lunar.Speech:EditSpeechInScript(scriptName, speechID, speech)

	-- If the script exists in the library, go to the specified
	-- speech ID and change it to the specified speech

	local id, _, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	if (id) then

		local db;		
		if (isGlobal) then
			db = LunarSphereGlobal.script[id].speeches
		else
			db = LunarSpeechLibrary.script[id].speeches
		end

		-- But we only change it if the new speech doesn't
		-- already exist

		if not Lunar.Speech:FindSpeechInScript(scriptName, speech) then
--			LunarSphereGlobal.speechLibrary[id][speechID] = speech;
			db[speechID] = speech;
		end
	end

end

function Lunar.Speech.ParseSpeech(self, speech)

	-- Replace some of our tags with their proper data and return the results

	local soundFile;

	speech = string.gsub(speech, "<target>", (self.spellTarget or UnitName("target") or ("")));
	speech = string.gsub(speech, "<focus>", (UnitName("focus") or self.spellTarget or UnitName("target") or ""));
	if string.find(speech, "<mount>") then
		-- Wipe the "summon" from the name, if it exists, for all locales (in theory)
		local spellName, spellRank = GetSpellBookItemName(self.spellName)
		if spellName and spellRank and (spellRank ~= "")  then
			spellName = string.gsub(spellName, spellRank, "");
			spellName = string.gsub(spellName, string.lower(spellRank), "");
			spellName = strtrim(string.gsub(spellName, "d'un", ""));
		else
			spellName = self.spellName;
		end
		speech = string.gsub(speech, "<mount>", (spellName or ("")));
	end
	speech = string.gsub(speech, "<spell>", (self.spellName or ("")));
	speech = string.gsub(speech, "<player>", (UnitName("player") or ("")));
	speech = string.gsub(speech, "<pet>", (UnitName("pet") or ("")));

	if string.find(speech, "<portal>") then
		speech = string.gsub(speech, "<portal>", strtrim(string.match(self.spellName, ":(.*)") or ("")));
	end

	local forceChannel;

	-- Play sound effects
	if string.find(speech, "<sound=") then
		-- grab part of string with sound file location
		soundFile = string.match(speech, "<sound=(.*)");
		-- rebuild speech to ignore the sound command
		speech = (string.match(soundFile, ">(.*)") or "");
		-- Now, filter the sound file to get JUST the sound file
		soundFile = string.sub(soundFile, 1, (string.find(soundFile, ">") or 2) - 1);
		-- Correct the formatting of the slashes
		soundFile = string.gsub(soundFile, "\\\\", "\\");
		-- Get rid of quotes...
		soundFile = string.gsub(soundFile, "\"", "");
		-- Rejoice!
		PlaySoundFile(soundFile);
	end

	if string.find(speech, "<say>") then
		speech = string.gsub(speech, "<say>", "");
		forceChannel = "SAY";
	end
	if string.find(speech, "<yell>") then
		speech = string.gsub(speech, "<yell>", "");
		forceChannel = "YELL";
	end
	if string.find(speech, "<party>") then
		speech = string.gsub(speech, "<party>", "");
		forceChannel = "PARTY";
	end
	if string.find(speech, "<raid>") then
		speech = string.gsub(speech, "<raid>", "");
		forceChannel = "RAID";
	end
	if string.find(speech, "<emote>") then
		speech = string.gsub(speech, "<emote>", "");
		forceChannel = "EMOTE";
	end
	if string.find(speech, "<whisper>") then
		speech = string.gsub(speech, "<whisper>", "");
		forceChannel = "WHISPER";
	end

	return speech, forceChannel;

end

function Lunar.Speech.RunScript(self, scriptName)

	-- Grab our script library ID and total count of speeches in script.
	-- Also grab the local script library ID for the settings of the script.

	local id, speechCount, isGlobal = Lunar.Speech:GetLibraryID(scriptName);
	local scriptID = Lunar.Speech:GetLibraryID(scriptName, true);

	if (scriptID) and (speechCount > 0) then

		-- Grab our local or global speech database
		local db
		if (isGlobal) then
			db = LunarSphereGlobal.script[id]
		else
			db = LunarSpeechLibrary.script[id]
		end

		-- Calculate whether or not we shall run the script, based upon the run probability

		if (((LunarSpeechLibrary.script[scriptID].runProbability or 100) - math.random(0, 99)) > 0) then

			-- Dertermine the channel to display the speech, with the default as the SAY channel

			local channel = LunarSpeechLibrary.script[scriptID].channelName or "SAY";

			-- Now, if determine if we run the speeches in order or at random. If it's in order,
			-- increment the speech to be used. If it's random, determine the random speech, trying
			-- not to use the last one used. 

			local speech = LunarSpeechLibrary.script[scriptID].lastSpeech or (0); 

			if (LunarSpeechLibrary.script[scriptID].inOrder == true) then
				speech = speech + 1;
			else
				speech = math.random(1, speechCount);
				if (speechCount > 1) and (speech == db.speeches.lastSpeech) then
					speech = speech + 1;
				end
			end

			-- After determining the speech index to use, make sure it's in range and reset
			-- it if it's not. Then, update our last used speech index

			if (speech > speechCount) then
				speech = 1;
			end

--			LunarSpeechLibrary.script[scriptID].lastSpeech = speech;
			db.speeches.lastSpeech = speech;

			-- Convert the speech index into the speech text. Check to see if the speech is
			-- registered in the saved settings of the script. If so, we use that. If it
			-- doesn't exist in the script, chances are that it was a default speech, so
			-- will pull that data from the local speech database.

			speech = Lunar.Speech:GetSpeech(id, speech, isGlobal);

			-- If we are to broadcast to the party or raid channels, but we aren't
			-- in a raid or a party, set our channel to none.

			if (channel == "PARTY") and (GetNumPartyMembers() == 0) then
				channel = "NONE";
			elseif (channel == "RAID") and not UnitInRaid("player") then
				channel = "NONE";
			end

			-- Now, we determine where to say the chat. If it is in any channel, that means it will
			-- use highest channel you are in between say, group, and raid. If you're not in a group,
			-- it will be just the say. If you're in a group, it will be the group channel. If you're
			-- in a raid, you are considered in both a raid and party channel, but the raid channel is
			-- the higher channel, so it will default to that and annoy people :) "ANYGROUP"
			-- works the same, but will never send to the Say channel, so you must
			-- be in a group to see the text.

			if (channel == "ANY") or (channel == "ANYGROUP") then
				if UnitInRaid("player") then
					channel = "RAID";
				elseif (GetNumPartyMembers() > 0) then
					channel = "PARTY";
				else
					if (channel == "ANY") then
						channel = "SAY";
					else
						channel = "NONE";
					end
				end
			end

			-- Say the speech!

			if (channel ~= "NONE") then
				
				local forceChannel, speechLine, startPos, finished;

				finished = false;
--				speechLine = speech;
				
				while (finished == false) do 

					-- Multi-line support. If the tag exists, continue

					startPos = string.find(speech, "<newline>")
					speechLine = nil;

					if (startPos) then

						-- If the tag is not at the start of the string (meaning we have
						-- something to say on this line), grab the text.

						if (startPos > 1) then
							speechLine = string.sub(speech, 1, startPos - 1);
						end

						-- Now, if there is text after the <newline> tag, replace our
						-- current speech data we're saying with the information
						-- after the tag (for the next line to process)

						if (string.len(speech) > startPos + 9) then
							speech = string.sub(speech, startPos + 9);
						else
							speech = "";
						end

					-- Otherwise, we're done doing the lines. Stop the loop

					else
						finished = true;
						speechLine = speech;
					end

					-- Grab the parsed data for this current line of speech and say it.

					if (speechLine) then
						
						speechLine, forceChannel = Lunar.Speech.ParseSpeech(self, speechLine);

						if ((channel == "WHISPER") and not forceChannel) or (forceChannel == "WHISPER") then
							local whisperTarget = self.spellTarget or UnitName("target");
							if (whisperTarget) ~= "" then
								SendChatMessage(speechLine, "WHISPER", nil, whisperTarget);
							end
						else
							if ( (forceChannel or channel) ~= "SAY" ) or IsInInstance() then
								SendChatMessage(speechLine, forceChannel or (channel));
							end
						end
					end
				end
			end
		end	
	end
end

function Lunar.Speech:GetScriptName(scriptID)
	if (LunarSpeechLibrary.script[scriptID]) then
		if (LunarSpeechLibrary.script[scriptID].speeches) then
			return LunarSpeechLibrary.script[scriptID].speeches[0];
		else
			if (LunarSphereGlobal.script) then
				id = LunarSpeechLibrary.script[scriptID].id;
				local i;
				for i = 1, table.getn(LunarSphereGlobal.script) do 
					if (LunarSphereGlobal.script[i].id == id) then
						if (LunarSphereGlobal.script[i].speeches) then
							return LunarSphereGlobal.script[i].speeches[0];
						end
						break;
					end
				end
			end	
		end
	end
	return "";
end

function Lunar.Speech:GetSpeech(scriptID, speechID, isGlobal)

	-- Convert the speech index into the speech text. Check to see if the speech is
	-- registered in the saved settings of the script. If so, we use that. If it
	-- doesn't exist in the script, chances are that it was a default speech, so
	-- will pull that data from the local speech database.
	
	local speech, default;

	if (isGlobal) then
		speech = LunarSphereGlobal.script[scriptID].speeches[speechID];
	else
		if (LunarSpeechLibrary.script[scriptID].speeches) then
			speech = LunarSpeechLibrary.script[scriptID].speeches[speechID];
		else
			local scriptName = Lunar.Speech:GetScriptName(scriptID);
			scriptID = Lunar.Speech:GetLibraryID(scriptName);
			speech = LunarSphereGlobal.script[scriptID].speeches[speechID];	
		end
	end
--	if not (LunarSphereGlobal.speechLibrary[scriptID][speechID]) then
--		speech = speechDatabase[scriptID][speechID];
--	else
--		speech = LunarSphereGlobal.speechLibrary[scriptID][speechID];
--	end

	-- If a speech was found, determine if the speech ID given is one of the
	-- default speeches. If so, notate it.

--	if (speech) then
--		local totalDefault = LunarSphereGlobal.speechLibrary[scriptID].default or "";
--		totalDefault = string.match(totalDefault, "-(%d+)") or (0);
--		if (speechID <= tonumber(totalDefault)) then
--			default = true;
--		end
--	end

	return speech, default;

end

--
function Lunar.Speech:LoadLibrary()

	-- Create our locals

	local index, scriptName, speechCount, scriptIndex, scriptFound, something, speechIndex, searchIndex;
	local defaultSpeech, successful;

	-- If the speech library database doesn't exist, make it now.
	LunarSphereGlobal.scriptData = LunarSphereGlobal.scriptData or {lastID = 0};

	if (not LunarSpeechLibrary) then

		LunarSphereGlobal.scriptData = LunarSphereGlobal.scriptData or {lastID = 0};
		local lastID = LunarSphereGlobal.scriptData.lastID or (0);

		-- We only make the default local scripts if they don't exist in the global space
		if (LunarSphereGlobal.script) then
			LunarSpeechLibrary = { script = {} };
			local defaultData = {"LIB_NAME_GENERIC_MOUNT-10", "LIB_NAME_FLYING_MOUNT-10", "LIB_NAME_REZZING-25"};
			local i, j, foundIt
			for i = 1, 3 do 
				foundIt = nil;
				for j = 1, table.getn(LunarSphereGlobal.script) do 
					if (LunarSphereGlobal.script[j].default == defaultData[i]) then
						foundIt = true;
						break;
					end
				end
				if not foundIt then
					scriptName = string.match(defaultData[i], "(.*)-");
					table.insert(LunarSpeechLibrary.script, {
						[0] = Lunar.Locale[scriptName],
						default = defaultData[i],
						id = lastID + 1,
						runProbability = 100,
						rebuild = true,
						speeches = {}
					});
					lastID = lastID + 1;
				end
			end

		-- No globals, make the local defaults anyway

		else

			LunarSpeechLibrary = {
				script = {
					[1] = {
						[0] = Lunar.Locale["LIB_NAME_GENERIC_MOUNT"],
						default = "LIB_NAME_GENERIC_MOUNT-10",
						id = lastID + 1,
						runProbability = 100,
						rebuild = true,
						speeches = {};
					},
					[2] = {
						[0] = Lunar.Locale["LIB_NAME_FLYING_MOUNT"],
						default = "LIB_NAME_FLYING_MOUNT-10",
						id = lastID + 2,
						runProbability = 100,
						rebuild = true,
						speeches = {};
					},
					[3] = {
						[0] = Lunar.Locale["LIB_NAME_REZZING"],
						default = "LIB_NAME_REZZING-25",
						id = lastID + 3, 
						runProbability = 100,
						rebuild = true,
						speeches = {};
						--active = "1111111111111111111111111"},
					}
				}
			};
			lastID = lastID + 3;

		end
		
		LunarSphereGlobal.scriptData.lastID = lastID;

	end

	-- Now, cycle through all global scripts and make sure there is a local script settings entry (spell data,
	-- probability, etc

	if (LunarSphereGlobal.script) then

		for index = 1, table.getn(LunarSphereGlobal.script) do 
		
			-- Check to see if the current script exists in the local settings. If so, mark it as
			-- "found" (all local scripts that don't have the "found" tag will be created) and
			-- break out of the loop.

			scriptFound = nil;
			for scriptIndex = 1, table.getn(LunarSpeechLibrary.script) do 
				if (LunarSpeechLibrary.script[scriptIndex]) then
					if (LunarSpeechLibrary.script[scriptIndex].id == LunarSphereGlobal.script[index].id) then
						scriptFound = true;
						break;
					end
				end
			end

			-- If the script wasn't found in the local settings (because it was added with another character),
			-- add it to the local settings now;
		
			if not (scriptFound == true) then
				table.insert(LunarSpeechLibrary.script, {runProbability = 100, id = LunarSphereGlobal.script[index].id});
			end

		end
		
	end

	-- Now, cycle through all local scripts and if there is data stored in them (but no speeches), verify that
	-- the global script exists. If it does NOT exist, we have speech data that is no longer needed (user might
	-- have made a global script local on another character, or deleted it altogether). So, wipe the data

	if (LunarSpeechLibrary.script) then

		local i = 1;
		for index = 1, table.getn(LunarSpeechLibrary.script) do 
			if (LunarSpeechLibrary.script[i]) then
				if not (LunarSpeechLibrary.script[i].speeches) then
					if (LunarSphereGlobal.script) then
						scriptFound = nil;
						for scriptIndex = 1, table.getn(LunarSphereGlobal.script) do 
							if (LunarSphereGlobal.script[scriptIndex].id == LunarSpeechLibrary.script[i].id) then
								scriptFound = true;
								i = i + 1;
								break;
							end
						end
						if not scriptFound then
							table.remove(LunarSpeechLibrary.script, i);
						end
					else
						table.remove(LunarSpeechLibrary.script, i);
					end
				else
					i = i + 1;
				end
--			else
--				table.remove(LunarSpeechLibrary.script, i);
			end

		end
		
	end

	-- Now, cycle through each local script and if it was just made, add the default speeches to it. Or, if
	-- the script is tagged for rebuild, add the default speeches back into it if they are missing.

	local db = LunarSpeechLibrary.script;

	for index = 1, table.getn(LunarSpeechLibrary.script) do 

		if (db[index].rebuild == true) then

			db[index].rebuild = nil;
			
			-- Grab the script name. If it's one of our default, built-in scripts, we get to work on loading
			-- the default scripts.

			scriptName = db[index].default or ("");
			scriptName, something = string.match(scriptName, "LIB_NAME_(.*)-(%d+)");

			-- Load up any default scripts if need be. These must be stored in the speechDatabase as full entries
			-- which are taken from the locale strings. If the user has a custom entry added to this library,
			-- or they edited an existing entry, it will not be default and will be skipped from being added. This is
			-- because if an entry is empty in this database, the data will be pulled from the saved database.

			if (scriptName) then

				-- Reset our index and script counts and use the default script name to find the default speeches
				-- in the locale data

				speechIndex = 1;
				speechCount = db[index].speeches.speechCount or (0);
				scriptName = "SPEECH_" .. scriptName;
				defaultSpeech = Lunar.Locale[scriptName .. speechIndex];

				while (defaultSpeech) do 

					-- If we don't have an entry in the global saved library, we pull the data from the
					-- default text. Otherwise, we leave this entry blank, so the speech engine will pull
					-- the data from the saved database (so we don't have duplicates eating up memory)
					successful = true;
					for searchIndex = 1, speechCount do 
						if (db[index].speeches[searchIndex] == defaultSpeech) then
							successful = false;
							break;
						end
					end
					if (successful == true) then
						speechCount = speechCount + 1;
						db[index].speeches[speechCount] = defaultSpeech;
					end

					speechIndex = speechIndex + 1;
					defaultSpeech = Lunar.Locale[scriptName .. speechIndex];

				end

			end

			if (db[index][0]) then
				db[index].speeches[0] = db[index][0];
				db[index][0] = nil;
			end

			-- Update the speech count of the script
			db[index].speeches.speechCount = speechCount;

		end

	end

	-- Lastly, cycle through all script names in the global settings and compare them against the local script.
	-- names. If we have a duplicate, append a " 2" to the name of the script so they can exist in harmony.

	if (LunarSphereGlobal.script) then
		for index = 1, table.getn(LunarSphereGlobal.script) do 
			if (LunarSphereGlobal.script[index].speeches and LunarSpeechLibrary.script) then
				for scriptIndex = 1, table.getn(LunarSpeechLibrary.script) do 
					if (LunarSpeechLibrary.script[scriptIndex].speeches) then
						if (LunarSpeechLibrary.script[scriptIndex].speeches[0] == LunarSphereGlobal.script[index].speeches[0]) then
							LunarSpeechLibrary.script[scriptIndex].speeches[0] = LunarSpeechLibrary.script[scriptIndex].speeches[0] .. " 2";
							break;
						end
					end
				end
			end
		end
	end

end

--[[
function Lunar.Speech:LoadLibrary()

	-- Create our locals

	local index, scriptName, speechCount, scriptIndex, scriptFound;

	-- If the speech library database doesn't exist, make it now.

	if (not LunarSphereGlobal.speechLibrary) then
		LunarSphereGlobal.speechLibrary = {
			[1] = {[0] = Lunar.Locale["LIB_NAME_GENERIC_MOUNT"],	default = "LIB_NAME_GENERIC_MOUNT-10",	id = 1, active = "1111111111"},
			[2] = {[0] = Lunar.Locale["LIB_NAME_FLYING_MOUNT"],	default = "LIB_NAME_FLYING_MOUNT-10",	id = 2, active = "1111111111"},
			[3] = {[0] = Lunar.Locale["LIB_NAME_REZZING"],		default = "LIB_NAME_REZZING-25",	id = 3, active = "1111111111111111111111111"},
		};
		LunarSphereGlobal.scriptData = {active = "111", lastID = table.getn(LunarSphereGlobal.speechLibrary)};
	end

	-- If the local speech library settings don't exist for this character, create them now.
	
	if (not LunarSpeechLibrary) then
		LunarSpeechLibrary = {}
	end

	-- Now, cycle through each global script and verify that it exists in the local settings.
	-- If the ID exists, mark it as "found". If it doesn't exist, add it to the local settings.

	for index = 1, table.getn(LunarSphereGlobal.speechLibrary) do 
		
		-- Check to see if the current script exists in the local settings. If so, mark it as
		-- "found" (all local scripts that don't have the "found" tag will be erased later) and
		-- break out of the loop.

		scriptFound = nil;
		for scriptIndex = 1, table.getn(LunarSpeechLibrary) do 
			if (LunarSpeechLibrary[scriptIndex]) then
				if (LunarSpeechLibrary[scriptIndex].id == LunarSphereGlobal.speechLibrary[index].id) then
					LunarSpeechLibrary[scriptIndex].found = true;
					scriptFound = true;
					break;
				end
			end
		end

		-- If the script wasn't found in the local settings (because it was added with another character),
		-- add it to the local settings now;
		
		if not (scriptFound == true) then
			table.insert(LunarSpeechLibrary, {["runProbability"] = 100, id = LunarSphereGlobal.speechLibrary[index].id, found = true});
		end

	end

	-- Now, run though all of our local settings. If it has the found flag set to true, clear the flag.
	-- If the found flag doesn't exist (i.e., it is no longer a part of the global script database), we
	-- need to wipe it now.

	index = 1;
	for scriptIndex = 1, table.getn(LunarSpeechLibrary) do 
		if (LunarSpeechLibrary[index]) then
			if LunarSpeechLibrary[index].found then
				LunarSpeechLibrary[index].found = nil;
				index = index + 1;
			else
				table.remove(LunarSpeechLibrary, index);
			end
		end
	end

--[ [	-- Create the locale speech library settings for the current character
	-- (We have an issue here. If someone deletes a script and logs on to another
	-- character, the new character will have INCORRECT DATA! I will incorporate
	-- unique IDs to the scripts soon...)

	if (not LunarSpeechLibrary) then
		LunarSpeechLibrary = {}

		local index;
		for index = 1, table.getn(LunarSphereGlobal.speechLibrary) do
			LunarSpeechLibrary[index] = {runProbability = 100};
			LunarSpeechLibrary[index].id = LunarSphereGlobal.speechLibrary[index].id
		end
--] ]
--[ [		LunarSpeechLibrary = {
			[1] = {runProbability = 100, id = 1},
			[2] = {runProbability = 100, id = 2},
			[3] = {runProbability = 100, id = 3},
		};
		if (table.getn(LunarSphereGlobal.speechLibrary) > 3) then
			local index
			for index = 3, table.getn(LunarSphereGlobal.speechLibrary) do
				LunarSpeechLibrary[index] = {runProbability = 100};

			end
		end
--] ]
--	end

	-- Run through each script that's saved

	for scriptIndex = 1, table.getn(LunarSphereGlobal.speechLibrary) do 

		-- Build our internal speech database for tracking and default text purposes

		speechDatabase[scriptIndex] = {
			[0] = LunarSphereGlobal.speechLibrary[scriptIndex][0],
			lastSpeech = nil,
		};

		-- Reset our index and script counts

		index = 1;
		speechCount = LunarSphereGlobal.speechLibrary[scriptIndex].speechCount;

		-- Grab the script name. If it's one of our default, built-in scripts, we get to work on loading
		-- the default scripts.

		scriptName = LunarSphereGlobal.speechLibrary[scriptIndex].default or ("");
		scriptName, something = string.match(scriptName, "LIB_NAME_(.*)-(%d+)");

		-- Load up any default scripts if need be. These must be stored in the speechDatabase as full entries
		-- which are taken from the locale strings. If the user has a custom entry added to this library,
		-- or they edited an existing entry, it will not be default and will be skipped from being added. This is
		-- because if an entry is empty in this database, the data will be pulled from the saved database.

		if (scriptName) and (speechCount ~= 0) then

			-- Use the default script name to find the default speechs in the locale data

			scriptName = "SPEECH_" .. scriptName;

			while (Lunar.Locale[scriptName .. index]) do 

				-- If we don't have an entry in the global saved library, we pull the data from the
				-- default text. Otherwise, we leave this entry blank, so the speech engine will pull
				-- the data from the saved database (so we don't have duplicates eating up memory)

				if not (LunarSphereGlobal.speechLibrary[scriptIndex][index]) then
					speechDatabase[scriptIndex][index] = Lunar.Locale[scriptName .. index];
				end
				index = index + 1;

			end

			-- If our script count didn't exist, set it now.

			if not speechCount then
				speechCount = index - 1;
			end
		end

		-- Update the speech count of the script

		LunarSphereGlobal.speechLibrary[scriptIndex].speechCount = speechCount;

	end

end
--]]

--
function Lunar.Speech:GetLibraryID(scriptName, localOnly)

	-- Define our locals

	local index, id, speechCount, isGlobal, uniqueID;

	-- Travel along each script in the local library. If there is a script name
	-- that matches the one we're looking for, we'll return that id and
	-- the total speeches that the script holds

	local loopTimes
--	local db = LunarSpeechLibrary.script;
	local db = LunarSphereGlobal.script;

	for loopTimes = 1, 2 do 
		
		if (db) then
			for index = 1, table.getn(db) do
				if (uniqueID) then
					if (db[index].id == uniqueID) then
						id = index;
						break;
					end
				end
				if (db[index].speeches) then
					if (db[index].speeches[0] == scriptName) then
						id = index;
						speechCount = db[index].speeches.speechCount;
						if (loopTimes == 1) then
							isGlobal = true;
							uniqueID = db[index].id;
						end
						break;
					end
				end
			end
		end

		-- If we are searching everything, and not just local databases, continue with
		-- the global scripts
		
		if (localOnly == true) or not id then
--			db = LunarSphereGlobal.script;
			db = LunarSpeechLibrary.script;
		else
			break;
		end

	end

	return id, speechCount, isGlobal;

end

end

end

--[[
    if hideShapeshift then

      RegisterStateDriver(ShapeshiftBarFrame, "visibility", "hide");

    else

      RegisterStateDriver(ShapeshiftBarFrame, "visibility", "show");

    end
--]]