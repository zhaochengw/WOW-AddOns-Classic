local AddonName, SAO = ...
local Module = "texture"

-- Credits to WeakAuras for listing these textures https://github.com/WeakAuras
local mapping =
{
    ["449486"]	= "Arcane Missiles",
    ["1027131"]	= "Arcane Missiles 1",
    ["1027132"]	= "Arcane Missiles 2",
    ["1027133"]	= "Arcane Missiles 3",
    ["450913"] 	= "Art of War",
    ["801266"] 	= "Backlash Green",
    ["460830"] 	= "Backlash",
    ["1030393"]	= "Bandits Guile",
    ["510822"] 	= "Berserk",
    ["511104"] 	= "Blood Boil",
    ["449487"] 	= "Blood Surge",
    ["449488"] 	= "Brain Freeze",
    ["603338"] 	= "Dark Tiger",
    ["461878"] 	= "Dark Transformation",
    ["459313"] 	= "Daybreak",
    ["511469"] 	= "Denounce",
    ["1057288"]	= "Echo of the Elements",
    ["450914"] 	= "Eclipse Moon",
    ["450915"] 	= "Eclipse Sun",
    ["450916"] 	= "Focus Fire",
    ["449489"] 	= "Frozen Fingers",
    ["467696"] 	= "Fulmination",
    ["460831"] 	= "Fury of Stormrage",
    ["450917"] 	= "GenericArc 01",
    ["450918"] 	= "GenericArc 02",
    ["450919"] 	= "GenericArc 03",
    ["450920"] 	= "GenericArc 04",
    ["450921"] 	= "GenericArc 05",
    ["450922"] 	= "GenericArc 06",
    ["450923"] 	= "GenericTop 01",
    ["450924"] 	= "GenericTop 02",
    ["450925"] 	= "Grand Crusader",
    ["459314"] 	= "Hand of Light",
    ["2851788"] = "High Tide",
    ["449490"] 	= "Hot Streak",
    ["801267"] 	= "Imp Empowerment Green",
    ["449491"] 	= "Imp Empowerment",
    ["457658"] 	= "Impact",
    ["458740"] 	= "Killing Machine",
    ["450926"] 	= "Lock and Load",
    ["1028136"]	= "Maelstrom Weapon 1",
    ["1028137"]	= "Maelstrom Weapon 2",
    ["1028138"]	= "Maelstrom Weapon 3",
    ["1028139"]	= "Maelstrom Weapon 4",
    ["450927"] 	= "Maelstrom Weapon",
    ["450928"] 	= "Master Marksman",
    ["801268"] 	= "Molten Core Green",
    ["458741"] 	= "Molten Core",
    ["1001511"]	= "Monk Blackout Kick",
    ["1028091"]	= "Monk Ox 2",
    ["1028092"]	= "Monk Ox 3",
    ["623950"] 	= "Monk Ox",
    ["623951"] 	= "Monk Serpent",
    ["1001512"]	= "Monk Tiger Palm",
    ["623952"] 	= "Monk Tiger",
    ["450929"] 	= "Nature's Grace",
    ["511105"] 	= "Necropolis",
    ["449492"] 	= "Nightfall",
    ["510823"] 	= "Feral OmenOfClarity",
    ["898423"] 	= "Predatory Swiftness",
    ["962497"] 	= "Raging Blow",
    ["450930"] 	= "Rime",
    ["469752"] 	= "Serendipity",
    ["656728"] 	= "Shadow Word Insanity",
    ["627609"] 	= "Shadow of Death",
    ["463452"] 	= "Shooting Stars",
    ["450931"] 	= "Slice and Dice",
    ["424570"] 	= "Spell Activation Overlay 0",
    ["449493"] 	= "Sudden Death",
    ["450932"] 	= "Sudden Doom",
    ["592058"] 	= "Surge of Darkness",
    ["450933"] 	= "Surge of Light",
    ["449494"] 	= "Sword and Board",
    ["1029138"]	= "Thrill of the Hunt 1",
    ["1029139"]	= "Thrill of the Hunt 2",
    ["1029140"]	= "Thrill of the Hunt 3",
    ["774420"] 	= "Tooth and Claw",
    ["627610"] 	= "Ultimatum",
    ["603339"] 	= "White Tiger",
}

SAO.TexName = {}
SAO.TextureFilenameFromFullname = {}
for retailTexture, classicTexture in pairs(mapping) do
  -- For now, all textures are copied locally in the addon's texture folder
  local filename = classicTexture:gsub(" ", "_"):gsub("'", "");
  local fullTextureName = "Interface\\Addons\\SpellActivationOverlay\\textures\\"..filename;
  local retailNumber = tonumber(retailTexture, 10);
  if SAO.IsCata() and retailNumber <= 511469 and -- Cataclysm game files embed textures up to (at least) 511469
    retailNumber ~= 450914 and retailNumber ~= 450915 then -- Eclipse textures in Cataclysm were different
    -- In this case, use texture embedded in game using its FileDataID, not from addon folder using a file path
    fullTextureName = retailTexture;
  end
  SAO.TexName[retailTexture] = fullTextureName;
  SAO.TexName[retailNumber] = fullTextureName;
  SAO.TexName[strlower(classicTexture)] = fullTextureName;
  SAO.TexName[strlower(classicTexture):gsub(" ", "_"):gsub("'", "")] = fullTextureName;
  SAO.TextureFilenameFromFullname[fullTextureName] = strlower(filename);
end

SAO.MarkedTextures = {}
function SAO.MarkTexture(self, texName)
  if not texName then return end

  local pointedTexName = self.TexName[texName];
  local fullTextureName;
  if pointedTexName then
    self.MarkedTextures[pointedTexName] = true;
    fullTextureName = pointedTexName;
  elseif self.TextureFilenameFromFullname[texName] then
    self.MarkedTextures[texName] = true;
    fullTextureName = texName;
  else
    self:Error(Module, "Unknown texture "..texName);
  end

  if fullTextureName and -- Has texture
    tostring(tonumber(fullTextureName,10)) ~= fullTextureName and -- Texture is not embedded (in theory we could test it, but not easily, cf. SAO_DB_LookForTexture)
    not GetFileIDFromPath(fullTextureName) -- File path is missing
  then
    self:Error(Module, "Missing file for texture "..texName);
  end
end

-- List fetched from bash: cd textures && ls -1 *.blp | cut -d. -f1 | tr 'A-Z' 'a-z' | grep -vE '^(mask|maskzero)$' | awk 'BEGIN{ print "local availableTextures = {" } {printf "  [\"%s\"] = true,\n", $0} END { print "}" }'
local availableTextures = {
  ["arcane_missiles"] = true,
  ["arcane_missiles_1"] = true,
  ["arcane_missiles_2"] = true,
  ["arcane_missiles_3"] = true,
  ["art_of_war"] = true,
  ["backlash"] = true,
  ["bandits_guile"] = true,
  ["blood_surge"] = true,
  ["brain_freeze"] = true,
  ["daybreak"] = true,
  ["echo_of_the_elements"] = true,
  ["eclipse_moon"] = true,
  ["eclipse_sun"] = true,
  ["feral_omenofclarity"] = true,
  ["frozen_fingers"] = true,
  ["fulmination"] = true,
  ["fury_of_stormrage"] = true,
  ["genericarc_02"] = true,
  ["genericarc_05"] = true,
  ["high_tide"] = true,
  ["hot_streak"] = true,
  ["imp_empowerment"] = true,
  ["impact"] = true,
  ["killing_machine"] = true,
  ["lock_and_load"] = true,
  ["maelstrom_weapon"] = true,
  ["maelstrom_weapon_1"] = true,
  ["maelstrom_weapon_2"] = true,
  ["maelstrom_weapon_3"] = true,
  ["maelstrom_weapon_4"] = true,
  ["master_marksman"] = true,
  ["molten_core"] = true,
  ["monk_serpent"] = true,
  ["natures_grace"] = true,
  ["nightfall"] = true,
  ["predatory_swiftness"] = true,
  ["raging_blow"] = true,
  ["rime"] = true,
  ["serendipity"] = true,
  ["shooting_stars"] = true,
  ["sudden_death"] = true,
  ["sudden_doom"] = true,
  ["surge_of_light"] = true,
  ["sword_and_board"] = true,
  ["tooth_and_claw"] = true,
}

-- Global functions, helpful for optimizing package

function SAO_DB_ResetMarkedTextures(output)
  if not SpellActivationOverlayDB.dev then
    SpellActivationOverlayDB.dev = { marked = {} };
  else
    SpellActivationOverlayDB.dev.marked = {};
  end
  if type(output) ~= 'boolean' or output then
    print("SAO_DB_ResetMarkedTextures() "..WrapTextInColorCode("OK", "FF00FF00"));
  end
end

function SAO_DB_AddMarkedTextures(output)
  if not SpellActivationOverlayDB.dev or not SpellActivationOverlayDB.dev.marked then
    SAO_DB_ResetMarkedTextures(false);
  end

  for fullTextureName, filename in pairs(SAO.TextureFilenameFromFullname) do
    if SAO.MarkedTextures[fullTextureName] then
      SpellActivationOverlayDB.dev.marked[filename] = true;
    end
  end

  if type(output) ~= 'boolean' or output then
    print("SAO_DB_AddMarkedTextures() "..WrapTextInColorCode("OK", "FF00FF00"));
  end
end

function SAO_DB_ComputeUnmarkedTextures(output)
  SAO_DB_AddMarkedTextures(false); -- Not needed in theory, but it avoids confusion
  SpellActivationOverlayDB.dev.unmarked = {};

  for fullTextureName, filename in pairs(SAO.TextureFilenameFromFullname) do
    if availableTextures[filename] then
      if     not SAO.MarkedTextures[fullTextureName] -- Not marked by current class
        and (not SpellActivationOverlayDB.dev.marked or not SpellActivationOverlayDB.dev.marked[filename]) -- Mark not stored in database
      then
        SpellActivationOverlayDB.dev.unmarked[filename] = true;
      end
    end
  end

  if type(output) ~= 'boolean' or output then
    print("SAO_DB_ComputeUnmarkedTextures() "..WrapTextInColorCode("OK", "FF00FF00"));
  end
end

function SAO_DB_LookForTexture(fileDataID, output, saveToDev)
  local f = CreateFrame("Frame", nil);
  local tex = f:CreateTexture();
  tex:SetPoint('CENTER', WorldFrame);

  f:SetAllPoints(tex);
  if saveToDev and SpellActivationOverlayDB.dev then
    SpellActivationOverlayDB.dev.existing[fileDataID] = nil;
  end
  f:SetScript('OnSizeChanged', function(self, width, height)
      local isLoaded = width > 15 and height > 15
      if saveToDev and SpellActivationOverlayDB.dev then
        SpellActivationOverlayDB.dev.existing.id[fileDataID] = isLoaded;

        SpellActivationOverlayDB.dev.existing.remaining = SpellActivationOverlayDB.dev.existing.remaining-1;
        if SpellActivationOverlayDB.dev.existing.remaining == 0 and (type(output) ~= 'boolean' or output) then
          print("SAO_DB_DetectExistingMarkedTextures() "..WrapTextInColorCode("Complete", "FF00FF00"));
        end
      end
      if not saveToDev and (type(output) ~= 'boolean' or output) then
        if isLoaded then
          SAO:Info(Module, "Texture "..tostring(fileDataID).." has been found in game files.");
        else
          SAO:Warn(Module, "Texture "..tostring(fileDataID).." has *not* been found in game files.");
        end
      end
      f:Hide();
  end);

  tex:SetTexture(fileDataID);

  tex:SetSize(0, 0); -- Reset size to make sure OnSizeChanged will be triggered
end

function SAO_DB_LookForAllTextures(output)
  SAO_DB_AddMarkedTextures(false); -- Not needed in theory, but it avoids confusion
  SpellActivationOverlayDB.dev.existing = { remaining = 0, id = {} };

  local fileDataIDs = {};

  for retailTexture in pairs(mapping) do
    table.insert(fileDataIDs, tonumber(retailTexture, 10));
  end

  SpellActivationOverlayDB.dev.existing.remaining = #fileDataIDs;
  for _, fileDataID in ipairs(fileDataIDs) do
    SAO_DB_LookForTexture(fileDataID, output, true);
  end

  if type(output) ~= 'boolean' or output then
    print("SAO_DB_DetectExistingMarkedTextures() "..WrapTextInColorCode("Pending ("..#fileDataIDs..")...", "FFFFFF00"));
  end
end
