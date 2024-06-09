--place un sort a l'endroit indiqué
local function PlaceSpellInActionSlot(spellId,barIndex, slot)
   ClearCursor()
   PickupSpell(spellId) -- Prendre le sort
   PlaceAction(slot + ((barIndex - 1) * NUM_ACTIONBAR_BUTTONS)) 
   ClearCursor()
 end





local function PrintActionBarSpells(spellId)
   name, rank, icon, castTime, minRange, maxRange, spellID, originalIcon = GetSpellInfo(spellId)
   for bar = 1, NUM_ACTIONBAR_PAGES do -- Parcours de toutes les barres de sorts
      for slot = 1, NUM_ACTIONBAR_BUTTONS do -- Parcours de tous les emplacements de la barre de sorts
         local actionType, id = GetActionInfo(slot + (NUM_ACTIONBAR_BUTTONS * (bar - 1))) -- Récupération des informations de l'action dans l'emplacement
         
         if actionType == "spell" then 
            local spellName = GetSpellInfo(id)
            if spellName == name then
               PlaceSpellInActionSlot(spellId,bar, slot)
            end
           
         end
      end
   end
end

--Cherche un spellID par son nom
local function GetSpellIDFromName(spellName)
   local spellID = nil

   for tabIndex = 1, GetNumSpellTabs() do
       local _, _, offset, numSpells = GetSpellTabInfo(tabIndex)

       for spellIndex = 1, numSpells do
           local spellBookIndex = spellIndex + offset
           local name = GetSpellBookItemName(spellBookIndex, BOOKTYPE_SPELL)

           if name == spellName then
               local _, _, _, _, _, _, spellID = GetSpellInfo(spellBookIndex, BOOKTYPE_SPELL)
               return spellID
           end
       end
   end

   return spellID
end

local function CheckActionBarSpellsAll()
   for bar = 1, NUM_ACTIONBAR_PAGES do -- Parcours de toutes les barres de sorts
      for slot = 1, NUM_ACTIONBAR_BUTTONS do -- Parcours de tous les emplacements de la barre de sorts
         local actionType, id = GetActionInfo(slot + (NUM_ACTIONBAR_BUTTONS * (bar - 1))) -- Récupération des informations de l'action dans l'emplacement
         
         if actionType == "spell" then 
            local spellName = GetSpellInfo(id)
            PlaceSpellInActionSlot(GetSpellIDFromName(spellName),bar, slot)
         end
      end
   end
end


--Check si un sort est appris
local frame = CreateFrame("Frame")
frame:RegisterEvent("LEARNED_SPELL_IN_TAB")

frame:SetScript("OnEvent", function(self, event, spellId, spellTab)
      PrintActionBarSpells(spellId);
end)




local frame1 = CreateFrame("Frame")
frame1:RegisterEvent("ADDON_LOADED")

frame1:SetScript("OnEvent", function(self, event, addonName)
    if event == "ADDON_LOADED" and addonName == "SpellAutoMaxRank" then
        SpellbookTabButton = CreateFrame("Button", "$parentButton", SpellBookFrame, "UIPanelButtonTemplate")
        SpellbookTabButton:SetPoint("CENTER", SpellBookFrame, "TOP", 0, 0)
        SpellbookTabButton:SetText("Maxer les sorts")
        SpellbookTabButton:SetWidth(140);
        SpellbookTabButton:SetHeight(24);
        SpellbookTabButton:SetNormalFontObject("GameFontNormal")
        SpellbookTabButton:SetHighlightFontObject("GameFontHighlight")
        SpellbookTabButton:SetScript("OnClick", function()
         CheckActionBarSpellsAll()
        end)

        SpellBookFrame_Update()
    end
end)


-- Utilisation de la fonction pour afficher les sorts présents dans les barres de sorts
print("CHARGÉ");