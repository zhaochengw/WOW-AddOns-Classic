--------------------------------------------------------------------------
-- GTFO_Spells_TWW.lua 
--------------------------------------------------------------------------
--[[
GTFO Spell List - The War Within
]]--

if (GTFO.RetailMode) then

--- ************************
--- *  Khaz Algar (World)  *
--- ************************


--- ****************************
--- * Ara-Kara, City of Echoes *
--- ****************************


--- **********************
--- * Cinderbrew Meadery *
--- **********************


--- *******************
--- * City of Threads *
--- *******************


--- *******************
--- * Darkflame Cleft *
--- *******************


--- ******************************
--- * Priory of the Scared Flame *
--- ******************************


--- *******************
--- * The Dawnbreaker *
--- *******************


--- ***************
--- * The Rookery *
--- ***************


--- ******************
--- * The Stonevault *
--- ******************


--- ********************
--- * Earthcrawl Mines *
--- ********************

GTFO.SpellID["448346"] = {
  --desc = "Caustic Webbing (Web General Ab'enar)";
  sound = 1;
};

--- *******************
--- * Kriegval's Rest *
--- *******************

GTFO.SpellID["414144"] = {
  --desc = "Smothering Shadows";
  negatingBuffSpellID = 424721; -- Candlelight
  applicationOnly = true;
  soundFunction = function() 
	local stacks = GTFO_DebuffStackCount("player", 414144);
	if (stacks > 45 and stacks % 5 == 0) then
		-- Lost 50% of your HP
		return 1;
	elseif ((stacks == 2 or stacks % 5 == 0) and stacks <= 45) then
		-- Losing HP
		return 2;
	end
  end;
};

GTFO.SpellID["455090"] = {
  --desc = "Frostfield (Candle)";
  sound = 1;
};

GTFO.SpellID["449089"] = {
  --desc = "Blazing Wick (Kobold Taskfinder)";
  sound = 1;
};

GTFO.SpellID["449266"] = {
  --desc = "Flamestorm (Tomb-Raider Drywhisker)";
  sound = 1;
};


--- ****************
--- * Fungal Folly *
--- ****************

GTFO.SpellID["415404"] = {
  --desc = "Fungalstorm (Spinshroom)";
  sound = 1;
};

GTFO.SpellID["415495"] = {
  --desc = "Gloopy Fungus (Spinshroom)";
  sound = 1;
};

--- ******************
--- * The Waterworks *
--- ******************


--- *****************
--- * The Dread Pit *
--- *****************


--- *************
--- * Underkeep *
--- *************


--- *********************
--- * Skittering Breach *
--- *********************


--- *********************
--- * Nightfall Sanctum *
--- *********************


--- ****************
--- * The Sinkhole *
--- ****************


--- **********************
--- * Myconmancer Cavern *
--- **********************


--- ********************
--- * The Spiral Weave *
--- ********************


--- ********************
--- * Rak-Rethan Abyss *
--- ********************


--- **********************
--- * Mystery 13th Delve *
--- **********************


--- ***************
--- * Delve Rares *
--- ***************

GTFO.SpellID["445781"] = {
  --desc = "Lava Blast (Stolen Loader)";
  sound = 3;
  applicationOnly = true;
};

--- *******************
--- * Nerub-ar Palace *
--- *******************


end

