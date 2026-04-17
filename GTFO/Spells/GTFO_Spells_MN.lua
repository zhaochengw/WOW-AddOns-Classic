--------------------------------------------------------------------------
-- GTFO_Spells_MN.lua 
--------------------------------------------------------------------------
--[[
GTFO Spell List - Midnight
]]--

if (GTFO.RetailMode) then

--- ********************
--- * Midnight (World) *
--- ********************

GTFO.SpellID["1225385"] = {
  --desc = "Grasping Shadows (Voidgorged Reserve)";
  sound = 1;
  --instance = 2858; 
};

GTFO.SpellID["1243988"] = {
  --desc = "Binding Fissure (Lu'ashal);
  sound = 1;
  --instance = 0; 
};

--- **********************
--- * Magister's Terrace *
--- **********************

GTFO.SpellID["1214089"] = {
  --desc = "Arcane Residue (Arcanotron Custos)";
  sound = 1;
  instance = 2811; 
};

--- ******************
--- * Voidscar Arena *
--- ******************

GTFO.SpellID["1248130"] = {
  --desc = "Unstable Singularity (Overseer Charonus)";
  sound = 1;
  instance = 2923; 
};

--- ********************
--- * Windrunner Spire *
--- ********************

GTFO.SpellID["473784"] = {
  --desc = "Fetid Spew (Flesh Behemoth)";
  sound = 1;
  instance = 2805; 
};

GTFO.SpellID["472118"] = {
  --desc = "Ignited Embers (Emberdawn)";
  sound = 1;
  instance = 2805; 
  test = true;
};

GTFO.SpellID["468924"] = {
  --desc = "Bladestorm (Commander Kroluk)";
  sound = 1;
  instance = 2805; 
};

GTFO.SpellID["472777"] = {
  --desc = "Gunk Splatter (Latch)";
  sound = 1;
  instance = 2805; 
};

--- *****************
--- * The Dreamrift *
--- *****************


GTFO.SpellID["1245919"] = {
  --desc = "Alndust Essence (Chimaerus)";
  sound = 1;
  instance = 2939;
  --encounter = 3306;
};


--- *****************
--- * The Voidspire *
--- *****************

GTFO.SpellID["1284786"] = {
  --desc = "Shadow Phalanx (Imperator Averzian)";
  sound = 1;
  instance = 2912;
  --encounter = 3306;
};

GTFO.SpellID["1280101"] = {
  --desc = "Void Breath (Vorasius)";
  sound = 1;
  instance = 2912; 
  --encounter = 3177;
};

GTFO.SpellID["1251213"] = {
  --desc = "Twilight Spikes (Fallen-King Salhadaar)";
  sound = 1;
  instance = 2912; 
  --encounter = 3179;
};

GTFO.SpellID["1245592"] = {
  --desc = "Torturous Extract (Fallen-King Salhadaar)";
  sound = 1;
  instance = 2912; 
  --encounter = 3179;
};

GTFO.SpellID["1260030"] = {
  --desc = "Umbral Beams (Fallen-King Salhadaar)";
  sound = 1;
  instance = 2912; 
  --encounter = 3179;
};

GTFO.SpellID["1244672"] = {
  --desc = "Nullzone (Vaelgor)";
  sound = 1;
  instance = 2912; 
  --encounter = 3178;
};

GTFO.SpellID["1245421"] = {
  --desc = "Gloomfield (Ezzorak)";
  sound = 1;
  instance = 2912; 
  --encounter = 3178;
};

GTFO.SpellID["1276982"] = {
  --desc = "Divine Consecration (General Amias Bellamy)";
  sound = 1;
  instance = 2912; 
  --encounter = 3180;
};

GTFO.SpellID["1246158"] = {
  --desc = "Consecration (General Amias Bellamy)";
  sound = 1;
  instance = 2912; 
  --encounter = 3180;
};

GTFO.SpellID["1272324"] = {
  --desc = "Divine Tempest (Commander Venel Lightblood)";
  sound = 1;
  instance = 2912; 
  --encounter = 3180;
};

GTFO.SpellID["1238206"] = {
  --desc = "Volatile Fissure (Alleria Windrunner)";
  sound = 1;
  instance = 2912; 
  --encounter = 3181;
};

GTFO.SpellID["1242553"] = {
  --desc = "Void Remnants (Alleria Windrunner)";
  sound = 1;
  instance = 2912; 
  --encounter = 3181;
};


--- ***********************
--- * March on Quel'Danas *
--- ***********************

GTFO.SpellID["1241840"] = {
  --desc = "Light Patch (Belo'ren)";
  sound = 1;
  instance = 2913; 
  --encounter = 3182;
};

GTFO.SpellID["1241841"] = {
  --desc = "Void Patch (Belo'ren)";
  sound = 1;
  instance = 2913; 
  --encounter = 3182;
};

GTFO.SpellID["1242803"] = {
  --desc = "Light Flames (Belo'ren)";
  sound = 1;
  instance = 2913; 
  --encounter = 3182;
};

GTFO.SpellID["1242815"] = {
  --desc = "Void Flames (Belo'ren)";
  sound = 1;
  instance = 2913; 
  --encounter = 3182;
};

GTFO.SpellID["1282470"] = {
  --desc = "Dark Quasar (L'ura)";
  sound = 1;
  instance = 2913; 
  --encounter = 3183;
};

--- ***************************
--- * Midnight (Unclassified) *
--- ***************************

GTFO.SpellID["1282006"] = {
  --desc = "Abyssal Pool";
  ignoreApplication = true;
  sound = 1;
  encounter = -1;
};


end

