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

GTFO.SpellID["434830"] = {
  --desc = "Vile Webbing";
  sound = 1;
};

GTFO.SpellID["438825"] = {
  --desc = "Poisonous Cloud (Atik - Residue)";
  applicationOnly = true;
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["433781"] = {
  --desc = "Ceaseless Swarm (Anub'zekt)";
  applicationOnly = true;
  sound = 1;
};


--- **********************
--- * Cinderbrew Meadery *
--- **********************

-- TODO: Crawling Brawl (Brew Master Aldryr) - Mythic

GTFO.SpellID["437965"] = {
  --desc = "Pulsing Flames (Venture Co. Pyromaniac)";
  sound = 4;
};

GTFO.SpellID["432196"] = {
  --desc = "Hot Honey (Brew Master Aldryr)";
  sound = 1;
};

GTFO.SpellID["441179"] = {
  --desc = "Oozing Honey (Brew Drop)";
  applicationOnly = true;
  sound = 1;
};

GTFO.SpellID["440138"] = {
  --desc = "Honey Marinade (Benk Buzzbee - Explosion)";
  sound = 4;
  negatingDebuffSpellID = 440134; -- Honey Marinade
  ignoreEvent = "HoneyMarinade";
  test = true; -- Verification, complicated spell, might have gotten it wrong
};

GTFO.SpellID["440134"] = {
  --desc = "Honey Marinade (Benk Buzzbee - Debuff)";
  applicationOnly = true;
  soundFunction = function() 
    -- Reduce the spam
	GTFO_AddEvent("HoneyMarinade", 6);
	return 0;
  end;
  test = true; -- Verification, complicated spell, might have gotten it wrong
};


GTFO.SpellID["440141"] = {
  --desc = "Honey Marinade (Benk Buzzbee - Pool)";
  applicationOnly = true;
  sound = 1;
};

GTFO.SpellID["441290"] = {
  --desc = "Burning Flames (Goldie Baronbottom)";
  sound = 1;
};

GTFO.SpellID["436640"] = {
  --desc = "Burning Ricochet (Goldie Baronbottom)";
  sound = 4;
  negatingDebuffSpellID = 436644;
  test = true; -- Need verification of negating debuff working
};


--- *******************
--- * City of Threads *
--- *******************

GTFO.SpellID["443435"] = {
  --desc = "Twist Thoughts (Herald of Ansurek)";
  sound = 1;
};

GTFO.SpellID["440310"] = {
  --desc = "Chains of Oppression (Orator Krix'vizk - Step out of circle)";
  sound = 1;
  applicationOnly = true;
};

GTFO.SpellID["434926"] = {
  --desc = "Lingering Influence (Orator Krix'vizk)";
  sound = 1;
};

GTFO.SpellID["438601"] = {
  --desc = "Void Surge (The Coaglamation)";
  sound = 1;
  test = true; -- Verification
};

--- *******************
--- * Darkflame Cleft *
--- *******************

GTFO.SpellID["426265"] = {
  --desc = "Ceaseless Flame (Sootsnout)";
  sound = 1;
};

GTFO.SpellID["426295"] = {
  --desc = "Flaming Tether (Sootsnout)";
  applicationOnly = true;
  negatingDebuffSpellID = 426295; -- Flaming Tether
  sound = 1;
  test = true;
};

GTFO.SpellID["421067"] = {
  --desc = "Molten Wax (The Candle King)";
  sound = 1;
};

GTFO.SpellID["422806"] = {
  --desc = "Smothering Shadows";
  applicationOnly = true;
  sound = 2;
  test = true; -- Verification, might get annoying
};

--- ******************************
--- * Priory of the Scared Flame *
--- ******************************

GTFO.SpellID["427473"] = {
  --desc = "Flamestrike (Fanatical Mage)";
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["424430"] = {
  --desc = "Consecration (Ardent Paladin)";
  sound = 1;
};

GTFO.SpellID["425554"] = {
  --desc = "Purifying Light (Prioress Murrpray - Moving Laser)";
  sound = 1;
};

GTFO.SpellID["425556"] = {
  --desc = "Purifying Light (Prioress Murrpray - Puddle)";
  sound = 1;
};


--- *******************
--- * The Dawnbreaker *
--- *******************

GTFO.SpellID["449332"] = {
  --desc = "Encroaching Shadows";
  sound = 1;
};

GTFO.SpellID["434096"] = {
  --desc = "Sticky Webs (Rasha'nan)";
  sound = 1;
  test = true; -- Verification
};

--- ***************
--- * The Rookery *
--- ***************

GTFO.SpellID["424966"] = {
  --desc = "Lingering Void (Stormguard Gorren)";
  sound = 1;
  test = true; -- Verification
};

--- ******************
--- * The Stonevault *
--- ******************

GTFO.SpellID["428819"] = {
  --desc = "Exhaust Vents (Vent Stalker)";
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["429999"] = {
  --desc = "Flaming Scrap (Vent Stalker)";
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["427329"] = {
  --desc = "Void Corruption (High Speaker Eirich)";
  sound = 2;
  test = true; -- Verification, need more information, such as well to turn on the high damage warning if it's on too long
};

GTFO.SpellID["457465"] = {
  --desc = "Entropy (High Speaker Eirich)";
  sound = 1;
  test = true; -- Verification
};

--- ***************
--- * TWW Devles  *
--- ***************

GTFO.SpellID["448346"] = {
  --desc = "Caustic Webbing (Web General Ab'enar)";
  sound = 1;
};

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

GTFO.SpellID["450344"] = {
  --desc = "Candlethrower (Burning Candle)";
  sound = 1;
};

GTFO.SpellID["415404"] = {
  --desc = "Fungalstorm (Spinshroom)";
  sound = 1;
};

GTFO.SpellID["415495"] = {
  --desc = "Gloopy Fungus (Spinshroom)";
  sound = 1;
};

GTFO.SpellID["443852"] = {
  --desc = "Suffocating Fumes";
  negatingBuffSpellID = 443860; -- Purified Air
  applicationOnly = true;
  soundFunction = function() 
	local stacks = GTFO_DebuffStackCount("player", 443852);
	if (stacks > 45 and stacks % 5 == 0) then
		-- Lost 50% of your HP
		return 1;
	elseif ((stacks == 2 or stacks % 5 == 0) and stacks <= 45) then
		-- Losing HP
		return 2;
	end
  end;
};

GTFO.SpellID["450133"] = {
  --desc = "Noxious Gas (Waxface - Pool)";
  sound = 1;
};

GTFO.SpellID["450636"] = {
  --desc = "Leeching Swarm (Nerubian Lord)";
  sound = 1;
};

GTFO.SpellID["448650"] = {
  --desc = "Burrowing Tremors (Under-Lord Vik'tis)";
  sound = 1;
};

GTFO.SpellID["440299"] = {
  --desc = "Poisoned (Poison Device)";
  sound = 1;
};

GTFO.SpellID["440330"] = {
  --desc = "Poisoned (Poison Device)";
  sound = 1;
};

GTFO.SpellID["447205"] = {
  --desc = "Rend Void (Researcher Ven'kex)";
  sound = 1;
};

GTFO.SpellID["457804"] = {
  --desc = "Ritual Burn (Faceless Devotee)";
  sound = 2;
};

GTFO.SpellID["440805"] = {
  --desc = "Darkrift Smash (Nerl'athekk the Skulking - Pool)";
  sound = 1;
};

GTFO.SpellID["434053"] = {
  --desc = "Darkfire Barrage (Dark Bombardier)";
  sound = 1;
};

GTFO.SpellID["443839"] = {
  --desc = "Desolate Surge (Speaker Halven)";
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["443841"] = {
  --desc = "Desolate Surge (Speaker Halven)";
  sound = 1;
  test = true; -- Verification
};

GTFO.SpellID["436269"] = {
  --desc = "Darkfire (Speaker Davenruth)";
  sound = 1;
};

GTFO.SpellID["454725"] = {
  --desc = "Bog Trap (Bogpiper)";
  sound = 1;
  test = true; -- A bit broken at the moment, it's basically a slow death
};

GTFO.SpellID["452750"] = {
  --desc = "Necrotic Bubble (Air Bubble)";
  sound = 1;
};

GTFO.SpellID["455931"] = {
  --desc = "Defiling Breath (Kobyss Necromancer)";
  sound = 1;
};

GTFO.SpellID["445781"] = {
  --desc = "Lava Blast (Stolen Loader)";
  sound = 3;
  applicationOnly = true;
};

--- *******************
--- * Nerub-ar Palace *
--- *******************

-- TODO: Stalkers Netting (Ulgrax the Devourer) - Negate for players with Digestive Venom

end

