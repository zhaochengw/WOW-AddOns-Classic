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

GTFO.SpellID["447917"] = {
  --desc = "Lava Patch (Master Machinist Dunstan)";
  sound = 1;
};

GTFO.SpellID["426836"] = {
  --desc = "Wildfire";
  sound = 1;
};

GTFO.SpellID["456309"] = {
  --desc = "Shadow Wreath (Aelric Leid)";
  sound = 1;
};

GTFO.SpellID["456057"] = {
  --desc = "Black Blood";
  sound = 1;
};

GTFO.SpellID["457741"] = {
  --desc = "Fel Damage";
  sound = 1;
};

GTFO.SpellID["454741"] = {
  --desc = "Slobber (Tka'ktath)";
  sound = 1;
};

GTFO.SpellID["439523"] = {
  --desc = "Dusk Demise (Shadowtide Corruptor)";
  sound = 1;
};

GTFO.SpellID["458771"] = {
  --desc = "Ravage (Ravageant)";
  sound = 1;
  applicationOnly = true;
  trivialLevel = 90;
};

GTFO.SpellID["451287"] = {
  --desc = "Rotting Sludge (Rotbark the Unfelled)";
  sound = 1;
  trivialLevel = 90;
};

GTFO.SpellID["435440"] = {
  --desc = "Toxic Outbreak";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["455915"] = {
  --desc = "Congealed Goop (Oozemodius)";
  sound = 1;
};

GTFO.SpellID["462985"] = {
  --desc = "Magma Puddle";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["432458"] = {
  --desc = "Itching Waters";
  applicationOnly = true;
  sound = 2;
};

GTFO.SpellID["433301"] = {
  --desc = "Parasitic Infestation";
	soundFunction = function() 
		-- Alert if hit more than 5 times
		if (not GTFO.VariableStore.ParasiticInfestation) then
			GTFO.VariableStore.ParasiticInfestation = 0;
		end
		local stacks = tonumber(GTFO_DebuffStackCount("player", 433301));
		if (stacks ~= GTFO.VariableStore.ParasiticInfestation) then
			GTFO.VariableStore.ParasiticInfestation = stacks;
			return 0;
		end
		return 1;
	end;
};

GTFO.SpellID["454901"] = {
  --desc = "Sundered Wrath (Surek'Tak the Sundered)";
  sound = 1;
};

GTFO.SpellID["452261"] = {
  --desc = "Black Blood Vial (Harvest Warden Izk'tilak)";
  sound = 1;
};

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

GTFO.SpellID["439832"] = {
  --desc = "Bloody Miasma";
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
  --desc = "Black Blood (The Coaglamation)";
  sound = 1;
};

GTFO.SpellID["462439"] = {
  --desc = "Black Blood (Outer edge)";
  sound = 1;
};

--- *******************
--- * Darkflame Cleft *
--- *******************

GTFO.SpellID["426265"] = {
  --desc = "Ceaseless Flame (Sootsnout)";
  sound = 1;
  negatingDebuffSpellID = 426277; -- One-Hand Headlock
};

GTFO.SpellID["421638"] = {
  --desc = "Wicklighter Barrage (Blazikon)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["424223"] = {
  --desc = "Incite Flames (Blazikon)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["440653"] = {
  --desc = "Surging Wax (Wandering Candle - Wax puddle)";
  sound = 1;
};

GTFO.SpellID["421067"] = {
  --desc = "Molten Wax (The Candle King)";
  sound = 1;
};

GTFO.SpellID["422806"] = {
  --desc = "Smothering Shadows";
  applicationOnly = true;
  category = "SmotheringShadows";
  sound = 2;
};

--- ******************************
--- * Priory of the Scared Flame *
--- ******************************

GTFO.SpellID["427473"] = {
  --desc = "Flamestrike (Fanatical Mage)";
  sound = 1;
};

GTFO.SpellID["424430"] = {
  --desc = "Consecration (Ardent Paladin)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["427900"] = {
  --desc = "Molten Pool (Forge Master Damian)";
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
  soundFunction = function() -- Don't alert when it first goes off, but warn if the player waits too long
	GTFO_AddEvent("EncroachingShadowsDebuff", 2, GTFO.SpellID["449332"].specialFunction);
	GTFO_AddEvent("EncroachingShadowsInitial", 1.9);
	return 0;
  end;
  specialFunction = function() -- Check to see if the player still has the debuff
	if GTFO_HasDebuff("player", 449332) then
		if not GTFO_FindEvent("EncroachingShadowsInitial") and not UnitIsDead("player") then
			local time = GTFO_DebuffTime("player", 449332);
			if (time > 0 and time < 12) then
				GTFO_PlaySound(1);
			end
			GTFO_AddEvent("EncroachingShadowsDebuff"..math.random(), 1, GTFO.SpellID["449332"].specialFunction);
		end
	end
  end;
};

GTFO.SpellID["434096"] = {
  --desc = "Sticky Webs (Rasha'nan)";
  ignoreApplication = true;
  sound = 1;
};

--- ***************
--- * The Rookery *
--- ***************

GTFO.SpellID["424966"] = {
  --desc = "Lingering Void (Stormguard Gorren)";
  sound = 1;
};

GTFO.SpellID["433067"] = {
  --desc = "Seeping Fragment (Voidstone Monstrosity)";
  sound = 1;
};

--- ******************
--- * The Stonevault *
--- ******************

GTFO.SpellID["428819"] = {
  --desc = "Exhaust Vents (Speaker Brokk)";
  sound = 1;
};

GTFO.SpellID["429999"] = {
  --desc = "Flaming Scrap (Speaker Brokk)";
  sound = 1;
};

GTFO.SpellID["427329"] = {
  --desc = "Void Corruption (High Speaker Eirich)";
  sound = 2;
};

GTFO.SpellID["457465"] = {
  --desc = "Entropy (High Speaker Eirich)";
  sound = 1;
};

--- ***************
--- * TWW Delves  *
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
	if (stacks >= 50 and stacks % 5 == 0) then
		-- Lost 50% of your HP
		return 1;
	elseif ((stacks == 2 or stacks % 10 == 0) and stacks < 50) then
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
	if (stacks >= 50 and stacks % 5 == 0) then
		-- Lost 50% of your HP
		return 1;
	elseif ((stacks == 2 or stacks % 10 == 0) and stacks < 50) then
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

GTFO.SpellID["461742"] = {
  --desc = "Consecration (Sir Finley Mrrgglton)";
  sound = 1;
};

GTFO.SpellID["463426"] = {
  --desc = "Freezing (Stalker)";
  sound = 1;
};

GTFO.SpellID["458836"] = {
  --desc = "Shadowspin (Speaker Xanventh)";
  sound = 1;
};

--- *******************
--- * Nerub-ar Palace *
--- *******************

-- TODO: Stalkers Netting (Ulgrax the Devourer) - Negate for players with Digestive Venom

end

