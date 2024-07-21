--------------------------------------------------------------------------
-- GTFO_Fail_TWW.lua 
--------------------------------------------------------------------------
--[[
GTFO Fail List - The War Within
]]--

if (GTFO.RetailMode) then

--- ************************
--- *  Khaz Algar (World)  *
--- ************************


--- ****************************
--- * Ara-Kara, City of Echoes *
--- ****************************

GTFO.SpellID["436401"] = {
  --desc = "AUGH! (Spider Eggs)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["434824"] = {
  --desc = "Web Spray (Ixin)";
  sound = 3;
};

GTFO.SpellID["438623"] = {
  --desc = "Toxic Rupture (Engorged Crawler)";
  sound = 3;
};

GTFO.SpellID["438832"] = {
  --desc = "Poisonous Cloud (Atik - Impact)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["433443"] = {
  --desc = "Impale (Anub'zekt)";
  sound = 3;
};

GTFO.SpellID["453160"] = {
  --desc = "Impale (Hulking Bloodguard)";
  sound = 3;
};

GTFO.SpellID["433843"] = {
  --desc = "Erupting Webs (Blood Overseer)";
  sound = 3;
};

GTFO.SpellID["433662"] = {
  --desc = "Grasping Blood (Black Blood)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["432132"] = {
  --desc = "Erupting Webs (Ki'katal the Harvester)";
  sound = 3;
};

GTFO.SpellID["432031"] = {
  --desc = "Grasping Blood (Ki'katal the Harvester - Black Blood)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["432119"] = {
  --desc = "Faded (Ki'katal the Harvester)";
  applicationOnly = true;
  sound = 3;
  test = true; -- Verification
};

--- **********************
--- * Cinderbrew Meadery *
--- **********************

GTFO.SpellID["435000"] = {
  --desc = "High Steaks (Chef Chewie)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["434707"] = {
  --desc = "Cinderbrew Toss (Tasting Room Attendant)";
  sound = 3;
  test = true; -- Unknown if this is avoidable
};

GTFO.SpellID["432198"] = {
  --desc = "Blazing Belch (Brew Master Aldryr)";
  sound = 3;
};

GTFO.SpellID["439991"] = {
  --desc = "Spouting Stout (I'pa - Swirl)";
  sound = 3;
};

GTFO.SpellID["442589"] = {
  --desc = "Beeswax (Venture Co. Honey Harvester)";
  sound = 3;
};

GTFO.SpellID["440887"] = {
  --desc = "Rain of Honey (Royal Jelly Purveyor)";
  sound = 3;
};

GTFO.SpellID["441344"] = {
  --desc = "Bee-Zooka (Bee Wrangler)";
  -- sound = 4;
  -- Private aura, will need to track SPELL_CAST_SUCCESS to determine for failure, but I'm not sure the extra overhead is worth it 
  -- SPELL_CAST_SUCCESS,Creature-0-2085-2661-15405-210264-000165FCCC,"Bee Wrangler",0xa48,0x0,Player-4184-005C2C54,"TestPlayerNameHere-TheseGoToEleven",0x511,0x0,441119,"Bee-Zooka",0x1,Creature-0-2085-2661-15405-210264-000165FCCC,0000000000000000,7748325,7846710,0,0,108569,0,1,0,0,0,2516.85,-4935.88,2335,0.2229,80
};

GTFO.SpellID["439468"] = {
  --desc = "Downward Trend (Yes Man)";
  sound = 3;
};

GTFO.SpellID["436592"] = {
  --desc = "Cash Cannon (Goldie Baronbottom)";
  sound = 3;
  tankSound = 0;
};

GTFO.SpellID["435788"] = {
  --desc = "Cinder-BOOM! (Goldie Baronbottom)";
  sound = 3;
};


--- *******************
--- * City of Threads *
--- *******************

-- TODO: Shadows of Doubt (Orator Krix'vizk) - Mythic
-- TODO: Slime Propagation (Orator Krix'vizk) - Mythic
-- TODO: Gutburst (Izo - Ravenous Scarab) - Mythic

GTFO.SpellID["443500"] = {
  --desc = "Earthshatter (Royal Swarmguard)";
  sound = 3;
};

GTFO.SpellID["434710"] = {
  --desc = "Chains of Oppression (Orator Krix'vizk - Pulled in)";
  sound = 3;
};

GTFO.SpellID["434779"] = {
  --desc = "Terrorize (Orator Krix'vizk)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["451543"] = {
  --desc = "Null Slam (Eye of the Queen)";
  sound = 3;
};

GTFO.SpellID["448047"] = {
  --desc = "Web Wrap (Pale Priest)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["434133"] = {
  --desc = "Venomous Spray (Royal Venomshell)";
  sound = 3;
};

GTFO.SpellID["445838"] = {
  --desc = "Dark Barrage (Unstable Test Subject)";
  sound = 3;
};

GTFO.SpellID["446086"] = {
  --desc = "Void Wave (Sureki Unnaturaler)";
  sound = 3;
};

GTFO.SpellID["447271"] = {
  --desc = "Tremor Slam (Hulking Warshell)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["437700"] = {
  --desc = "Tremor Slam (Izo, the Grand Splicer)";
  sound = 3;
  test = true; -- Verification, is the within 12 yards version a different spell ID?
};


--- *******************
--- * Darkflame Cleft *
--- *******************

-- TODO: Extinguishing Gust (Blazikon) - Mythic
-- TODO: Cursed Wax (The Candle King) - Mythic
-- TODO: Eternal Darkness (The Darkness) - Mythic

GTFO.SpellID["423501"] = {
  --desc = "Wild Wallop (Rank Overseer)";
  sound = 3;
};

GTFO.SpellID["422274"] = {
  --desc = "Cave-In (Ol' Waxbeard)";
  sound = 3;
};

GTFO.SpellID["424821"] = {
  --desc = "High Speed Collision (Ol' Waxbeard - Creaky Mine Cart)";
  sound = 3;
};

GTFO.SpellID["428650"] = {
  --desc = "Burning Backlash (Wandering Candle)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["422393"] = {
  --desc = "Suffocating Darkness (Skittering Darkness)";
  sound = 3;
};

GTFO.SpellID["421638"] = {
  --desc = "Wicklighter Barrage (Blazikon)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["427011"] = {
  --desc = "Shadowblast (The Darkness - Application)";
  applicationOnly = true;
  soundFunction = function() 
	GTFO_AddEvent("Shadowblast", 9);
	return 0;
  end;
  test = true; -- Verification
};

GTFO.SpellID["427011"] = {
  --desc = "Shadowblast (The Darkness - Explosion)";
  negatingDebuffSpellID = 427015; -- Shadowblast
  ignoreEvent = "Shadowblast";
  sound = 4;
  test = true; -- Verification
};

GTFO.SpellID["427100"] = {
  --desc = "Umbral Slash (The Darkness)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["422414"] = {
  --desc = "Shadow Smash (Shuffling Horror)";
  sound = 3;
};

--- ******************************
--- * Priory of the Scared Flame *
--- ******************************

GTFO.SpellID["453461"] = {
  --desc = "Caltrops (Fervent Sharpshooter)";
  applicationOnly = true;
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["448492"] = {
  --desc = "Thunderclap (Guard Captain Suleyman)";
  sound = 3;
  test = true; -- Avoidable?
};

GTFO.SpellID["427472"] = {
  --desc = "Flamestrike (Fanatical Mage - Impact)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["424621"] = {
  --desc = "Brutal Smash (Sergeant Shaynemail)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["427601"] = {
  --desc = "Burst of Light (Lightspawn)";
  sound = 3;
};

GTFO.SpellID["424420"] = {
  --desc = "Cinderblast (Taener Duelmal)";
  applicationOnly = true;
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["424460"] = {
  --desc = "Ember Storm (Taener Duelmal)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["423076"] = {
  --desc = "Hammer of Purity (Baron Braunpyke - Impact)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["423121"] = {
  --desc = "Hammer of Purity (Baron Braunpyke - Flying Hammer)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["446657"] = {
  --desc = "Burning Light (Baron Braunpyke)";
  sound = 3;
  test = true; -- Verification, need more info about this one
};

GTFO.SpellID["451818"] = {
  --desc = "Crushing Leap (Sir Braunpyke)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["451606"] = {
  --desc = "Holy Flame (Prioress Murrpray)";
  sound = 3;
  applicationOnly = true;
};

--- *******************
--- * The Dawnbreaker *
--- *******************

-- TODO: Obsidian Beam (Shadowcrown) - Mythic
-- TODO: Collapsing Night (Shadowcrown) - Mythic
-- TODO: Expel Webs (Rasha'nan) - Mythic

GTFO.SpellID["430655"] = {
  --desc = "Arathi Airship Cannon";
  sound = 3;
};

GTFO.SpellID["451093"] = {
  --desc = "Arathi Bomb";
  sound = 3;
};

GTFO.SpellID["426715"] = {
  --desc = "Collapsing Darkness (Speaker Shadowcrown)";
  sound = 3;
};

GTFO.SpellID["449335"] = {
  --desc = "Encroaching Shadows";
  sound = 3;
};

GTFO.SpellID["451032"] = {
  --desc = "Darkness Comes (Speaker Shadowcrown)";
  sound = 3;
};

GTFO.SpellID["451098"] = {
  --desc = "Tacky Nova (Sureki Militant)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["432606"] = {
  --desc = "Black Hail (Manifested Shadow)";
  sound = 3;
};

GTFO.SpellID["434441"] = {
  --desc = "Rolling Acid (Rasha'nan)";
  applicationOnly = true;
  sound = 3;
  test = true; -- Verification
};

--- ***************
--- * The Rookery *
--- ***************

-- TODO: Thunderbolt (Kyrioss) - Mythic
-- TODO: Void Chunks (Voidstone Monstrosity) - Mythic, Avoidable?

GTFO.SpellID["427331"] = {
  --desc = "Charged Bombardment (Cursed Stormrider)";
  sound = 3;
  test = true; -- Unknown if this is avoidable?
};

GTFO.SpellID["432605"] = {
  --desc = "Charged Bombardment (Cursed Stormrider - Impact)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["426968"] = {
  --desc = "Bounding Void (Quartermaster Koratite)";
  sound = 3;
};

GTFO.SpellID["430013"] = {
  --desc = "Thunderstrike (Unruly Stormrook)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["427616"] = {
  --desc = "Energized Barrage (Unruly Stormrook)";
  sound = 3;
  tankSound = 0;
  test = true; -- Verification
};

GTFO.SpellID["419871"] = {
  --desc = "Lightning Dash (Kyrioss)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["420739"] = {
  --desc = "Unstable Charge (Kyrioss)";
  applicationOnly = true;
  soundFunction = function() 
	GTFO_AddEvent("UnstableCharge", 9);
	return 0;
  end;
  test = true; -- Verification
};

GTFO.SpellID["424195"] = {
  --desc = "Unstable Blast (Kyrioss)";
  sound = 4;
  ignoreEvent = "UnstableCharge";
  test = true; -- Verification
};

GTFO.SpellID["444250"] = {
  --desc = "Lightning Torrent (Kyrioss)";
  sound = 3;
  applicationOnly = true;
  test = true; -- Verification
};

GTFO.SpellID["452932"] = {
  --desc = "Attracting Shadows (Corrupted Thunderer)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["423981"] = {
  --desc = "Implosion (Corrupted Rookguard)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["430186"] = {
  --desc = "Seeping Corruption (Cursed Rookgruard)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["443847"] = {
  --desc = "Instability (Inflicted Civilian)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["426136"] = {
  --desc = "Reality Tear (Stormguard Gorren)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["425052"] = {
  --desc = "Dark Gravity (Stormguard Gorren)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["442192"] = {
  --desc = "Oppressive Void (Void Mass)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["438848"] = {
  --desc = "Embrace the Void (Radiating Voidstone)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["430288"] = {
  --desc = "Crushing Darkness (Void Fragment)";
  sound = 3;
  test = true; -- Verification
};

GTFO.SpellID["445537"] = {
  --desc = "Oblivion Wave (Voidstone Monstrosity)";
  sound = 3;
  tankSound = 0;
  test = true; -- Verification
};

GTFO.SpellID["423356"] = {
  --desc = "Null Upheaval (Voidstone Monstrosity)";
  sound = 3;
  test = true; -- Verification
};


--- ******************
--- * The Stonevault *
--- ******************

GTFO.SpellID["425027"] = {
  --desc = "Seismic Wave (Earth Infused Golem)";
  sound = 3;
};

GTFO.SpellID["447145"] = {
  --desc = "Pulverizing Pounce (Repurposed Loaderbot)";
  sound = 3;
};

GTFO.SpellID["449129"] = {
  --desc = "Lava Cannon (Forge Loader)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["428547"] = {
  --desc = "Scrap Cube (Scrap Block)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["449070"] = {
  --desc = "Crystal Salvo (Void Touched Elemental)";
  sound = 3;
};

GTFO.SpellID["422261"] = {
  --desc = "Crystal Shard (Skarmorak)";
  sound = 3;
};

GTFO.SpellID["423538"] = {
  --desc = "Unstable Crash (Skarmorak)";
  sound = 3;
};

GTFO.SpellID["448975"] = {
  --desc = "Shield Stampede (Cursedforge Honor Guard)";
  sound = 3;
};

GTFO.SpellID["428709"] = {
  --desc = "Granite Eruption (Rock Smasher)";
  sound = 3;
};

GTFO.SpellID["427869"] = {
  --desc = "Unbridled Void (High Speaker Eirich)";
  sound = 3;
  test = true; -- Verification
};

--- ***************
--- * TWW Devles  *
--- ***************

GTFO.SpellID["433410"] = {
  --desc = "Fearful Shriek (Chittering Fearmonger)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["450509"] = {
  --desc = "Wide Swipe (Nerubian Captain)";
  sound = 3;
};

GTFO.SpellID["448412"] = {
  --desc = "Burning Cart (Web General Ab'enar)";
  sound = 3;
};

GTFO.SpellID["448529"] = {
  --desc = "BOOM! (Spitfire Fusetender)";
  sound = 3;
};

GTFO.SpellID["427710"] = {
  --desc = "Sporesplosion (Sporbit)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["424738"] = {
  --desc = "Infectious Spores (Fungarian Flinger)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["424798"] = {
  --desc = "Bloated Eruption (Infected Beast)";
  sound = 3;
};

GTFO.SpellID["425319"] = {
  --desc = "Fungsplosion (Spinshroom)";
  sound = 3;
};

GTFO.SpellID["450131"] = {
  --desc = "Noxious Gas (Waxface - Swirl)";
  sound = 3;
};

GTFO.SpellID["450714"] = {
  --desc = "Jagged Barbs (Nerubian Lord)";
  sound = 3;
};

GTFO.SpellID["450710"] = {
  --desc = "Jagged Barbs (Nerubian Lord)";
  sound = 3;
};

GTFO.SpellID["448638"] = {
  --desc = "Impale (Under-Lord Vik'tis)";
  sound = 3;
};

GTFO.SpellID["439840"] = {
  --desc = "Cold Retort (Ice Block)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["447133"] = {
  --desc = "Poison Glob (Researcher Ven'kex)";
  sound = 3;
};

GTFO.SpellID["447187"] = {
  --desc = "Rend Void (Researcher Ven'kex)";
  sound = 3;
};

GTFO.SpellID["440679"] = {
  --desc = "Forbidden Ritual (Nerubian Ritualist - Swirl)";
  sound = 3;
};

GTFO.SpellID["442253"] = {
  --desc = "Forbidden Ritual (Nerubian Ritualist - Purple orb)";
  sound = 3;
};

GTFO.SpellID["440801"] = {
  --desc = "Dark Abatement (Nerl'athekk the Skulking)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["440806"] = {
  --desc = "Darkrift Smash (Nerl'athekk the Skulking - Impact)";
  sound = 3;
};

GTFO.SpellID["441129"] = {
  --desc = "Spotted! (Dark Bombardier)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["443292"] = {
  --desc = "Umbral Slam (Devouring Shade)";
  sound = 3;
};

GTFO.SpellID["453335"] = {
  --desc = "Erratic Energies";
  sound = 3;
};

GTFO.SpellID["443837"] = {
  --desc = "Shadow Sweep (Speaker Halven)";
  sound = 3;
};

GTFO.SpellID["444446"] = {
  --desc = "Speaker's Wrath (Speaker Davenruth)";
  sound = 3;
};

GTFO.SpellID["457448"] = {
  --desc = "Shadow Eruption (Slippery Syphoner)";
  sound = 3;
};

GTFO.SpellID["424891"] = {
  --desc = "Vine Spear (Fungal Speartender)";
  sound = 3;
};

GTFO.SpellID["454205"] = {
  --desc = "Muck Charge (Bogpiper)";
  sound = 3;
};

GTFO.SpellID["449061"] = {
  --desc = "Impaling Spikes (Overseer Kaskel)";
  sound = 3;
};

GTFO.SpellID["445038"] = {
  --desc = "Cleave (Kobyss Trickster)";
  sound = 3;
  tankSound = 0;
  test = true; -- Avoidable in single-player?
};

GTFO.SpellID["446406"] = {
  --desc = "Fungal Infection (Undersea Abomination)";
  applicationOnly = true;
  sound = 3;
};

GTFO.SpellID["446321"] = {
  --desc = "Deepsea Polyps (Undersea Abomination)";
  sound = 3;
};

GTFO.SpellID["445781"] = {
  --desc = "Lava Blast (Stolen Loader)";
  sound = 3;
  applicationOnly = true;
};

GTFO.SpellID["415253"] = {
  --desc = "Fungal Breath (Invasive Sporecap)";
  sound = 3;
};

GTFO.SpellID["415356"] = {
  --desc = "Fungal Explosion (Invasive Sporecap)";
  sound = 3;
};

--- *******************
--- * Nerub-ar Palace *
--- *******************

-- TODO: Stalkers Webbing (Ulgrax the Devourer) - Swirl impact
-- TODO: Digestive Venom (Ulgrax the Devourer) - Friendly Fire
-- TODO: Brutal Crush (Ulgrax the Devourer) - Tank-only cone
-- TODO: Juggernaut Charge (Ulgrax the Devourer) - 20-yard damage, need more info
-- TODO: Hungering Bellows (Ulgrax the Devourer) - Avoidable Swirl?
-- TODO: Hulking Crash (Ulgrax the Devourer) - Bad tooltip, can't tell if avoidable


end

