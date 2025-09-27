if BG.IsBlackListPlayer then return end
if not (BG.IsWLK or BG.IsMOP) then return end

local AddonName, ns = ...

local LibBG = ns.LibBG
local L = ns.L

local RR = ns.RR
local NN = ns.NN
local RN = ns.RN
local Size = ns.Size
local RGB = ns.RGB
local RGB_16 = ns.RGB_16
local GetClassRGB = ns.GetClassRGB
local SetClassCFF = ns.SetClassCFF
local GetText_T = ns.GetText_T
local AddTexture = ns.AddTexture
local GetItemID = ns.GetItemID

local pt = print
local RealmId = GetRealmID()
local player = BG.playerName
local className, classFilename, classID = UnitClass("player")
local IsAddOnLoaded = IsAddOnLoaded or C_AddOns.IsAddOnLoaded

local verNum
local verText
local info = {}
if BG.IsWLK then
    verNum = 3
elseif BG.IsMOP then
    verNum = 5
    verText="MoP"
    info = {
        ["附魔"] = {
            subCatSelect = "Enchanting"..verText,
            boss = 1,
        },
        ["锻造"] = {
            subCatSelect = "Blacksmithing"..verText,
            boss = 14,
        },
        ["工程"] = {
            subCatSelect = "Engineering"..verText,
            boss = 3,
        },
        ["裁缝"] = {
            subCatSelect = "Tailoring"..verText,
            boss = 10,
        },
        ["制皮"] = {
            subCatSelect = "Leatherworking"..verText,
            boss = 10,
        },
        ["珠宝"] = {
            subCatSelect = "Jewelcrafting"..verText,
            boss = 4,
        },
        ["铭文"] = {
            subCatSelect = "Inscription"..verText,
            boss = 4,
        },
        ["烹饪"] = {
            subCatSelect = "Cooking" .. verText,
            boss = 1,
        },
    }
end
BG.Init2(function()
    local addonName = "AtlasLootClassic"
    if not IsAddOnLoaded(addonName) then return end

    local mainFrame = _G["AtlasLoot_GUI-Frame"]

    local tbl = {
        _G["AtlasLoot-DropDown-1"],
        _G["AtlasLoot-DropDown-1-button"],
        _G["AtlasLoot-DropDown-2"],
        _G["AtlasLoot-DropDown-2-button"],
    }

    local function ClickSelectButton(id, selectFrameID, notRefresh)
        for i, SelectButton in ipairs(_G["AtlasLoot-Select-" .. (selectFrameID or 2)].obj.buttons) do
            if SelectButton.info and SelectButton.info.id == id then
                SelectButton:Click()
                if not notRefresh then
                    AtlasLoot.GUI.ItemFrame:Refresh(true)
                end
                return
            end
        end
    end
    local function SetBestChoose(self)
        -- pt(self.id)
        if BG.IsWLK then
            if AtlasLoot.db.GUI.selectedGameVersion and AtlasLoot.db.GUI.selectedGameVersion ~= verNum then return end
            if self.id == "BlacksmithingWrath" then
                -- 锻造
                mainFrame.boss:SetSelected(14)
            elseif self.id == "EngineeringWrath" then
                -- 工程
                mainFrame.boss:SetSelected(11)
            elseif self.id == "TailoringWrath" then
                -- 裁缝
                mainFrame.boss:SetSelected(11)
            elseif self.id == "LeatherworkingWrath" then
                -- 制皮
                mainFrame.boss:SetSelected(10)
            elseif self.id == "JewelcraftingWrath" then
                -- 珠宝
                mainFrame.boss:SetSelected(5)
            elseif self.id == "InscriptionWrath" then
                -- 铭文
                local id
                if classFilename == "DRUID" then
                    id = 3 + classID - 1
                else
                    id = 3 + classID
                end
                mainFrame.boss:SetSelected(id)
            elseif self.id == "CookingWrath" then
                -- 烹饪
                mainFrame.boss:SetSelected(13)
            elseif self.id == "AtlasLootClassic_DungeonsAndRaids" then
                -- 地下城和团队副本
                mainFrame.subCatSelect:SetSelected("IcecrownCitadel")
                ClickSelectButton(10, 1, "notRefresh")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Crafting" then
                -- 专业制造
                mainFrame.subCatSelect:SetSelected("EnchantingWrath")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Factions" then
                -- 声望
                mainFrame.subCatSelect:SetSelected("TheSonsofHodir")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_PvP" then
                -- PVP
                -- mainFrame.subCatSelect:SetSelected("ArenaS6PvP")
                -- AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Collections" then
                -- 藏品
                ClickSelectButton(11, nil, "notRefresh")
                ClickSelectButton(9, 1)
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            end
        elseif BG.IsMOP then
            if AtlasLoot.db.GUI.selectedGameVersion and AtlasLoot.db.GUI.selectedGameVersion ~= verNum then return end
            if self.id == "BlacksmithingMoP" then
                -- 锻造
                mainFrame.boss:SetSelected(info["锻造"].boss)
            elseif self.id == "EngineeringMoP" then
                -- 工程
                mainFrame.boss:SetSelected(info["工程"].boss)
            elseif self.id == "TailoringMoP" then
                -- 裁缝
                mainFrame.boss:SetSelected(info["裁缝"].boss)
            elseif self.id == "LeatherworkingMoP" then
                -- 制皮
                mainFrame.boss:SetSelected(info["制皮"].boss)
            elseif self.id == "JewelcraftingMoP" then
                -- 珠宝
                mainFrame.boss:SetSelected(info["珠宝"].boss)
            elseif self.id == "InscriptionMoP" then
                -- 铭文
                mainFrame.boss:SetSelected(info["铭文"].boss)
            elseif self.id == "CookingMoP" then
                -- 烹饪
                mainFrame.boss:SetSelected(info["烹饪"].boss)
            elseif self.id == "AtlasLootClassic_DungeonsAndRaids" then
                -- 地下城和团队副本
                mainFrame.subCatSelect:SetSelected("TerraceofEndlessSpring")
                ClickSelectButton(6, 1, "notRefresh")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Crafting" then
                -- 专业制造
                mainFrame.subCatSelect:SetSelected("EnchantingMoP")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Factions" then
                -- 声望
                -- mainFrame.subCatSelect:SetSelected("TheSonsofHodir")
                -- AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_PvP" then
                -- PVP
                mainFrame.subCatSelect:SetSelected("ArenaS12PvP")
                ClickSelectButton(18, 1, "notRefresh")
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            elseif self.id == "AtlasLootClassic_Collections" then
                -- 藏品
                ClickSelectButton(15, nil, "notRefresh")
                ClickSelectButton(5, 1)
                AtlasLoot.GUI.ItemFrame:Refresh(true)
            end
        end
    end
    for _, dropDownButton in ipairs(tbl) do
        dropDownButton:HookScript("OnClick", function(self)
            for i = 1, 40 do
                local Button = _G["AtlasLoot-DropDown-Button" .. i]
                if Button then
                    Button:HookScript("OnClick", function(self)
                        if BiaoGe.options.AtlasLoot_betterChoose ~= 1 then return end
                        SetBestChoose(self)
                        AtlasLoot.GUI.ItemFrame:Refresh(true)
                    end)
                end
            end
        end)
    end

    -- 快捷按钮
    local last
    local buttons = {}
    local function CreateButton(text, func, height)
        local bt = BG.CreateButton(mainFrame)
        bt:SetSize(60, 25)
        if last then
            bt:SetPoint("TOP", last, "BOTTOM", 0, height or -2)
        else
            bt:SetPoint("TOPLEFT", _G["AtlasLoot-Select-1"], "TOPRIGHT", 10, 0)
        end
        bt:SetFrameLevel(10)
        bt:SetText(text)
        last = bt
        tinsert(buttons, bt)
        bt:SetScript("OnClick", function(self)
            AtlasLoot.db.GUI.selectedGameVersion = verNum
            mainFrame.gameVersionLogo:SetTexture(AtlasLoot.GAME_VERSION_TEXTURES[verNum])
            func()
            AtlasLoot.GUI.ItemFrame:Refresh(true)
            BG.PlaySound(1)
        end)
    end

    if BG.IsWLK then
        CreateButton(L["冰冠"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("IcecrownCitadel")
            ClickSelectButton(10, 1, "notRefresh")
        end)
        CreateButton(L["T10套"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("IcecrownCitadel")
            ClickSelectButton(14, 3, "notRefresh")
            ClickSelectButton(15, 1, "notRefresh")
        end)
        CreateButton(L["牌子"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("EmblemofFrost")
            mainFrame.boss:SetSelected(8)
        end)
        CreateButton(L["天谴石"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("DefilersScourgestone")
            mainFrame.boss:SetSelected(8)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_engraving") .. L["附魔"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("EnchantingWrath")
        end, -20)
        CreateButton(AddTexture("Interface/Icons/inv_misc_gem_01") .. L["珠宝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("JewelcraftingWrath")
            mainFrame.boss:SetSelected(5)
        end)
        CreateButton(AddTexture("Interface/Icons/inv_inscription_tradeskill01") .. L["铭文"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("InscriptionWrath")
            local id
            if classFilename == "DRUID" then
                id = 3 + classID - 1
            else
                id = 3 + classID
            end
            mainFrame.boss:SetSelected(id)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_blacksmithing") .. L["锻造"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("BlacksmithingWrath")
            mainFrame.boss:SetSelected(14)
        end, -20)
        CreateButton(AddTexture("Interface/Icons/trade_engineering") .. L["工程"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("EngineeringWrath")
            mainFrame.boss:SetSelected(11)
        end)
        CreateButton(AddTexture("Interface/Icons/trade_tailoring") .. L["裁缝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("TailoringWrath")
            mainFrame.boss:SetSelected(11)
        end)
        CreateButton(AddTexture("Interface/Icons/trade_leatherworking") .. L["制皮"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("LeatherworkingWrath")
            mainFrame.boss:SetSelected(10)
        end)
    elseif BG.IsMOP then
        CreateButton(L["魔古山"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("MoguShanVaults")
            ClickSelectButton(6, 1, "notRefresh")
        end)
        CreateButton(L["恐惧"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("HeartofFear")
            ClickSelectButton(6, 1, "notRefresh")
        end)
        CreateButton(L["永春台"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("TerraceofEndlessSpring")
            ClickSelectButton(6, 1, "notRefresh")
        end)
        CreateButton(L["T14套"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            ClickSelectButton(15, nil, "notRefresh")
            ClickSelectButton(5, 1)
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        end)
        CreateButton(L["勇气"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("ValorPointsMoP")
            mainFrame.boss:SetSelected(8)
        end, -20)
        CreateButton(L["正义"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("JusticePointsMoP")
            mainFrame.boss:SetSelected(8)
        end)
        CreateButton(L["天神"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("CelestialVendorMoP")
            ClickSelectButton(21, 1, "notRefresh")
            mainFrame.boss:SetSelected(6)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_engraving") .. L["附魔"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["附魔"].subCatSelect)
        end, -20)
        CreateButton(AddTexture("Interface/Icons/inv_misc_gem_01") .. L["珠宝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["珠宝"].subCatSelect)
            mainFrame.boss:SetSelected(info["珠宝"].boss)
        end)
        CreateButton(AddTexture("Interface/Icons/inv_inscription_tradeskill01") .. L["铭文"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["铭文"].subCatSelect)
            mainFrame.boss:SetSelected(info["铭文"].boss)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_blacksmithing") .. L["锻造"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["锻造"].subCatSelect)
            mainFrame.boss:SetSelected(info["锻造"].boss)
        end)
        CreateButton(AddTexture("Interface/Icons/trade_engineering") .. L["工程"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["工程"].subCatSelect)
            mainFrame.boss:SetSelected(info["工程"].boss)
        end)
        CreateButton(AddTexture("Interface/Icons/trade_tailoring") .. L["裁缝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["裁缝"].subCatSelect)
            mainFrame.boss:SetSelected(info["裁缝"].boss)
        end)
        CreateButton(AddTexture("Interface/Icons/trade_leatherworking") .. L["制皮"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected(info["制皮"].subCatSelect)
            mainFrame.boss:SetSelected(info["制皮"].boss)
        end)
    end

    mainFrame:HookScript("OnShow", function(self)
        if BiaoGe.options.AtlasLoot_fastChoose == 1 then
            for _, bt in pairs(buttons) do
                bt:Show()
            end
        else
            for _, bt in pairs(buttons) do
                bt:Hide()
            end
        end
    end)
end)
