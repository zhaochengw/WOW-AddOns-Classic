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

GTFO.SpellID["446843"] = {
  --desc = "Darkness Outburst (The Oozekhan)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["453876"] = {
  --desc = "Militant Green (Grand Overspinner Antourix)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["449770"] = {
  --desc = "Worm Bile (Magma Serpent)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["458799"] = {
  --desc = "Overcharged Earth (Kordac)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["459545"] = {
  --desc = "Choking Cloud (Archavon the Stone Watcher)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["419210"] = {
  --desc = "Defiling Breath (Scourge Abomination)";
  sound = 1;
};

GTFO.SpellID["465284"] = {
  --desc = "Nether Zone (Tichondrius)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["458512"] = {
  --desc = "Spore Cloud (Parasidious)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["469060"] = {
  --desc = "Breath of Death (Nerathor)";
  applicationOnly = true;
  sound = 1;
  trivialLevel = 90;
};

GTFO.SpellID["472198"] = {
  --desc = "Stormcast (Zek'ul the Shipbreaker)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["469833"] = {
  --desc = "Mega Lava Barrage (Haywire MEK IV)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["471424"] = {
  --desc = "Focused Storm (Storm-Touched Clawfiend)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["458835"] = {
  --desc = "Toxic Sludge";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1217648"] = {
  --desc = "Defiling Breath (Lady of the Lake)";
  sound = 1;
};

GTFO.SpellID["1222515"] = {
  --desc = "Leaking Fluid (Gallagio Security)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["1214845"] = {
  --desc = "Filthy Pool (Dockmaster Skeez)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1218158"] = {
  --desc = "Molten Gold (Gallagio Garbage)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["470843"] = {
  --desc = "Noxious Ooze (Ahn'tak)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["470827"] = {
  --desc = "Poison Breath (Ahn'tak)";
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

GTFO.SpellID["440087"] = {
  --desc = "Oozing Honey (Brew Drop)";
  ignoreApplication = true;
  sound = 1;
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

GTFO.SpellID["461825"] = {
  --desc = "Black Blood (The Coaglamation)";
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

GTFO.SpellID["443835"] = {
  --desc = "Blazing Storms (Blazikon)"; -- Tank is out of range
  tankSound = 1;
  sound = 0;
};

GTFO.SpellID["1218133"] = {
  --desc = "Burning Candles (Sootsnout)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["440653"] = {
  --desc = "Surging Wax (Wandering Candle - Wax puddle)";
  ignoreApplication = true;
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

GTFO.SpellID["453214"] = {
  --desc = "Obsidian Beam (Speaker Shadowcrown)";
  applicationOnly = true;
  sound = 1;
};

GTFO.SpellID["453173"] = {
  --desc = "Collapsing Night (Speaker Shadowcrown)";
  sound = 1;
  ignoreApplication = true;
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

GTFO.SpellID["423393"] = {
  --desc = "Entropy (Voidstone Monstrosity)";
  sound = 0;
  tankSound = 1;
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
  ignorePeriodic = true;
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

GTFO.SpellID["445193"] = {
  --desc = "Flame Patch (Spitfire Charger)";
  sound = 1;
};

GTFO.SpellID["424710"] = {
  --desc = "Vicious Stabs (Fungal Gutter)";
  sound = 1;
};

GTFO.SpellID["465605"] = {
  --desc = "Poisoned (Poison Device)";
  sound = 1;
};

GTFO.SpellID["440779"] = {
  --desc = "Shadow Line (Shadow Totem)";
  sound = 1;
};

GTFO.SpellID["455662"] = {
  --desc = "Grasping Shadows";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["414523"] = {
  --desc = "Shadow Barrier";
  sound = 1;
};

GTFO.SpellID["452041"] = {
  --desc = "Grimweave Orb (Ascended Webfriar)";
  sound = 1;
  ignorePeriodic = true;
};

GTFO.SpellID["440939"] = {
  --desc = "Frost Grip (Researcher Xik'vik)";
  sound = 1;
};

GTFO.SpellID["453152"] = {
  --desc = "Gossamer Webbing (Web Marauder)";
  sound = 1;
};

GTFO.SpellID["1213374"] = {
  --desc = "Massive Shock";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1215912"] = {
  --desc = "Black Blood (Geargrave)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["473700"] = {
  --desc = "Molotov Cocktail (Flinging Flicker)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["474230"] = {
  --desc = "Shadow Blast (Silent Slitherer - Residue)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["474155"] = {
  --desc = "Slime Trail (Coagulated Mass)";
  ignoreApplication = true;
  sound = 1;
};


--- *******************
--- * Nerub-ar Palace *
--- *******************

GTFO.SpellID["441402"] = {
  --desc = "Concentrated Cold (Hollow Frostweaver)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["434275"] = {
  --desc = "Black Blood";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["445518"] = {
  --desc = "Black Blood";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["448148"] = {
  --desc = "Black Blood (Blood Collector)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["444172"] = {
  --desc = "Blightstorm (Xur'khun the Defiled)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["440904"] = {
  --desc = "Devour (Ulgrax the Devourer)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["450130"] = {
  --desc = "Slip 'n Slime";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["441116"] = {
  --desc = "Heaving Retch (Regurgitating Monstrosity)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["459785"] = {
  --desc = "Cosmic Residue";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["454832"] = {
  --desc = "Poison Breath (Caustic Skyrazor)";
  sound = 1;
};

GTFO.SpellID["439776"] = {
  --desc = "Acid Pools (Rasha'nan)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["457467"] = {
  --desc = "Acid Pools (Rasha'nan)";
  sound = 1;
  ignoreApplication = true;
  test = true;
};

GTFO.SpellID["439780"] = {
  --desc = "Sticky Webs (Rasha'nan)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["437786"] = {
  --desc = "Atomized (Nexus-Princess Ky'veza)";
  sound = 1;
};

GTFO.SpellID["463071"] = {
  --desc = "Sanguine Overflow (Brood Infuser)";
  sound = 1;
};

GTFO.SpellID["442799"] = {
  --desc = "Sanguine Overflow (Broodtwister Ovi'nax)";
  sound = 1;
};

GTFO.SpellID["451086"] = {
  --desc = "Entropic Webs (Skeinspinner Takazj)";
  ignoreApplication = true;
  sound = 2;
};

GTFO.SpellID["444956"] = {
  --desc = "Noxious Discharge (Xur'khun the Defiled)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["437078"] = {
  --desc = "Acid (Queen Ansurek)";
  sound = 1;
};

GTFO.SpellID["443403"] = {
  --desc = "Gloom (Queen Ansurek)";
  sound = 1;
};

GTFO.SpellID["441958"] = {
  --desc = "Grasping Silk (Queen Ansurek)";
  sound = 1;
  ignoreApplication = true;
};

GTFO.SpellID["445818"] = {
  --desc = "Frothing Gluttony (Queen Ansurek)";
  applicationOnly = true;
  sound = 1;
};

GTFO.SpellID["462252"] = {
  --desc = "Volatile Eruption (Volatile Black Blood Pool)";
  sound = 1;
};

GTFO.SpellID["446253"] = {
  --desc = "Slime Trail (Congealed Mass)";
  sound = 1;
};

GTFO.SpellID["447175"] = {
  --desc = "Predation Threads (Queen Ansurek)";
  soundFunction = function() -- Warn only if you get hit more than once within 1.5 seconds
	if (GTFO_FindEvent("PredationThreads")) then
		return 4;
	end
	GTFO_AddEvent("PredationThreads", 1);
	return 0;
  end;
};


--- ***************************
--- * Blackrock Depths (Raid) *
--- ***************************

GTFO.SpellID["462352"] = {
  --desc = "Roiling Magma (Eruption)";
  sound = 1;
};

GTFO.SpellID["463492"] = {
  --desc = "Firewall (Lord Incendius)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["470484"] = {
  --desc = "Designed Disaster (Fineous Darkvire)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["464473"] = {
  --desc = "Chemical Pool (Chemical Bomb)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["463822"] = {
  --desc = "Flamethrower (Prototype Fire Golem)";
  sound = 1;
  negatingDebuffSpellID = 467918; -- Poison-Soaked
  tankSound = 0;
};

GTFO.SpellID["463849"] = {
  --desc = "Lethal Attraction (Electron Mk. II)";
  sound = 4;
};

GTFO.SpellID["464339"] = {
  --desc = "Blizzard (Seeth'rel)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["464350"] = {
  --desc = "Bladestorm (Anger'rel)";
  sound = 2;
  tankSound = 0;
};

GTFO.SpellID["466382"] = {
  --desc = "Volcanic Stone (Avatar of Ragnaros)";
  ignoreApplication = true;
  sound = 1;
};

--- ************************
--- * Operation: Floodgate *
--- ************************

GTFO.SpellID["464469"] = {
  --desc = "Taking Aim";
  applicationOnly = true;
  sound = 1;
};

GTFO.SpellID["474350"] = {
  --desc = "Shreddation Sawblade (Shreddinator 3000)";
  sound = 1;
};

GTFO.SpellID["474388"] = {
  --desc = "Flamethrower (Shreddinator 3000)";
  sound = 1;
};

GTFO.SpellID["465128"] = {
  --desc = "Wind Up (Loaderbot)";
  sound = 1;
};

GTFO.SpellID["1215071"] = {
  --desc = "Electrified Water (Electrified Water)";
  negatingDebuffSpellID = 1215089; -- Electrified Water
  sound = 1;
};

GTFO.SpellID["473224"] = {
  --desc = "Sonic Boom (Big M.O.M.M.A.)";
  sound = 1;
};

GTFO.SpellID["1213790"] = {
  --desc = "Zeppelin Barrage (Zeppelin)";
  sound = 1;
};

GTFO.SpellID["472338"] = {
  --desc = "Surveyed Ground (Venture Co. Surveyor)";
  sound = 1;
};

GTFO.SpellID["473051"] = {
  --desc = "Rushing Tide (Swampface)";
  sound = 1;
};

GTFO.SpellID["473287"] = {
  --desc = "Excessive Electrification (Big M.O.M.M.A.)";
  ignoreApplication = true;
  sound = 1;
};

--- ***************************
--- * Liberation of Undermine *
--- ***************************

GTFO.SpellID["459683"] = {
  --desc = "Oil Slick (The Geargrinder)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["468223"] = {
  --desc = "Incendiary Fire (The Geargrinder)";
  sound = 1;
};

GTFO.SpellID["1214039"] = {
  --desc = "Molten Pool (Flarendo)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["463925"] = {
  --desc = "Lingering Electricity (Torq)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["467048"] = {
  --desc = "Faulty Zap (Rik Reverb)";
  ignoreSelfInflicted = true;
  sound = 4;
};

GTFO.SpellID["1219448"] = {
  --desc = "Fire Starters (Darkfuse Shredder)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["467177"] = {
  --desc = "Blistering Roar (King Flamespite)";
  sound = 1;
  tankSound = 0;
};

GTFO.SpellID["464248"] = {
  --desc = "Hot Garbage (Stix Bunkjunker)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["467138"] = {
  --desc = "Forever Chemicals";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["464854"] = {
  --desc = "Garbage Pile (Stix Bunkjunker)";
  sound = 1;
  negatingDebuffSpellID = 461536; -- Rolling Rubbish
};

GTFO.SpellID["472849"] = {
  --desc = "Incineration (Stix Bunkjunker)";
  sound = 4;
  ignoreSelfInflicted = true;
}

GTFO.SpellID["466235"] = {
  --desc = "Wire Transfer (Sprocketmonger Lockenstock)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1221320"] = {
  --desc = "Activate Inventions! (Sprocketmonger Lockenstock)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1216415"] = {
  --desc = "Blazing Beam (Beam Turret)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1216679"] = {
  --desc = "Jumbo Void Beam (Void Turret)";
  sound = 1;
};

GTFO.SpellID["474072"] = {
  --desc = "Noxious Spew (Darkfuse Growler)";
  sound = 1;
};

GTFO.SpellID["460576"] = {
  --desc = "Shocking Field (One-Armed Bandit)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["473178"] = {
  --desc = "Voltaic Streak (One-Armed Bandit)";
  sound = 1;
};

GTFO.SpellID["474554"] = {
  --desc = "Shaken Earth (Mug'Zee)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["466509"] = {
  --desc = "Stormfury Finger Gun (Mug'Zee)";
  applicationOnly = true;
  soundFunction = function() 
	GTFO_AddEvent("StormfuryFingerGun", 6);
	return 0;
  end;
};

GTFO.SpellID["470245"] = {
  --desc = "Stormfury Finger Gun (Mug'Zee)";
  sound = 1;
  tankSound = 0;
  ignoreEvent = "StormfuryFingerGun";
  negatingDebuffSpellID = 466509; -- Stormfury Finger Gun 
  test = true;
};

GTFO.SpellID["1218077"] = {
  --desc = "Bullet (Mug'Zee)";
  sound = 1;
};

GTFO.SpellID["1218182"] = {
  --desc = "Storm (Mug'Zee)";
  sound = 1;
};

GTFO.SpellID["470089"] = {
  --desc = "Molten Gold Pool (Mug'Zee)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["472057"] = {
  --desc = "Hot Mess (Mug'Zee)";
  ignoreApplication = true;
  sound = 1;
};

GTFO.SpellID["1215209"] = {
  --desc = "Sabotage Zone (Chrome King Gallywix)";
  ignoreApplication = true;
  sound = 1;
};


end


