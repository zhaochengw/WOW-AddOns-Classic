if BG.IsBlackListPlayer then return end
if not (BG.IsWLK or BG.IsMOP) then return end
BG.canShowAtlasLoot = true

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

BG.Init2(function()
    local addonName = "AtlasLootClassic"
    if not IsAddOnLoaded(addonName) then return end
    local ClickSelectButton

    local mainFrame = _G["AtlasLoot_GUI-Frame"]

    local verNum
    local info = {}

    if BG.IsWLK then
        verNum = 3
    elseif BG.IsMOP then
        if BG.IsMOP_TW then
            verNum = 5
        else
            verNum = 4
        end
    end

    local function GetVerText()
        local verText = {
            [4] = "Cata",
            [5] = "MoP",
        }
        return verText[AtlasLoot.db.GUI.selectedGameVersion] or ""
    end


    local infoTbl = {
        [4] = {
            ["Enchanting"] = 1,      -- 附魔
            ["Blacksmithing"] = 15,  -- 锻造
            ["Engineering"] = 6,     -- 工程
            ["Tailoring"] = 10,      -- 裁缝
            ["Leatherworking"] = 10, -- 制皮
            ["Jewelcrafting"] = 5,   -- 珠宝
            ["Inscription"] = function()
                local id = {
                    WARRIOR = 11,
                    PALADIN = 6,
                    HUNTER = 4,
                    ROGUE = 8,
                    PRIEST = 7,
                    DEATHKNIGHT = 2,
                    SHAMAN = 9,
                    MAGE = 5,
                    WARLOCK = 10,
                    MONK = 1,
                    DRUID = 3,
                }
                if id[classFilename] then
                    mainFrame.boss:SetSelected(id[classFilename])
                end
            end,             -- 铭文
            ["Cooking"] = 1, -- 烹饪
            -- 专业制造
            ["AtlasLootClassic_Crafting"] = function()
                mainFrame.subCatSelect:SetSelected("Enchanting" .. GetVerText())
            end,
            -- 地下城和团队副本
            ["AtlasLootClassic_DungeonsAndRaids"] = function()
                mainFrame.subCatSelect:SetSelected("DragonSoul")
                ClickSelectButton(6, 1, "notRefresh")
            end,
            -- PVP
            ["AtlasLootClassic_PvP"] = function()
                mainFrame.subCatSelect:SetSelected("ArenaS11PvP")
                ClickSelectButton(14, 1, "notRefresh")
            end,
            -- 藏品
            ["AtlasLootClassic_Collections"] = function()
                ClickSelectButton(14, nil, "notRefresh")
                ClickSelectButton(5, 1)
                mainFrame.boss:SetSelected(14)
            end,
        },
        [5] = {
            ["Enchanting"] = 1,      -- 附魔
            ["Blacksmithing"] = 14,  -- 锻造
            ["Engineering"] = 3,     -- 工程
            ["Tailoring"] = 10,      -- 裁缝
            ["Leatherworking"] = 10, -- 制皮
            ["Jewelcrafting"] = 4,   -- 珠宝
            ["Inscription"] = 4,     -- 铭文
            ["Cooking"] = 1,         -- 烹饪
            ["AtlasLootClassic_Crafting"] = function()
                -- 专业制造
                mainFrame.subCatSelect:SetSelected("Enchanting" .. GetVerText())
            end,
            ["AtlasLootClassic_DungeonsAndRaids"] = function()
                -- 地下城和团队副本
                mainFrame.subCatSelect:SetSelected("TerraceofEndlessSpring")
                ClickSelectButton(6, 1, "notRefresh")
            end,
            ["AtlasLootClassic_PvP"] = function()
                -- PVP
                mainFrame.subCatSelect:SetSelected("ArenaS12PvP")
                ClickSelectButton(18, 1, "notRefresh")
            end,
            ["AtlasLootClassic_Collections"] = function()
                -- 藏品
                ClickSelectButton(15, nil, "notRefresh")
                ClickSelectButton(5, 1)
            end,
        },
    }

    function ClickSelectButton(id, selectFrameID, notRefresh)
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

    for _, dropDownButton in ipairs({
        _G["AtlasLoot-DropDown-1"],
        _G["AtlasLoot-DropDown-1-button"],
        _G["AtlasLoot-DropDown-2"],
        _G["AtlasLoot-DropDown-2-button"],
    }) do
        dropDownButton:HookScript("OnClick", function(self)
            for i = 1, 40 do
                local Button = _G["AtlasLoot-DropDown-Button" .. i]
                if Button then
                    Button:HookScript("OnClick", function(self)
                        if BiaoGe.options.AtlasLoot_betterChoose ~= 1 then return end
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
                            local ver = AtlasLoot.db.GUI.selectedGameVersion
                            if infoTbl[ver] then
                                for k, v in pairs(infoTbl[ver]) do
                                    if self.id:find(k) then
                                        if type(v) == "number" then
                                            mainFrame.boss:SetSelected(v)
                                        elseif type(v) == "function" then
                                            v()
                                        end
                                        break
                                    end
                                end
                            end
                        end
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
        bt:SetSize(65, 25)
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
    elseif BG.IsCTM then
        local info = infoTbl[verNum]
        CreateButton(L["巨龙"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_DungeonsAndRaids")
            mainFrame.subCatSelect:SetSelected("DragonSoul")
            ClickSelectButton(6, 1, "notRefresh")
        end)
        CreateButton(L["T13套"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            ClickSelectButton(14, nil, "notRefresh")
            ClickSelectButton(5, 1)
            AtlasLoot.GUI.ItemFrame:Refresh(true)
        end)
        CreateButton(L["正义"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("ValorPoints" .. GetVerText())
            mainFrame.boss:SetSelected(4)
        end, -20)
        CreateButton(L["裂隙石"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("ObsidianFragments")
            mainFrame.boss:SetSelected(10)
        end)
        CreateButton(L["荣誉"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_PvP")
            mainFrame.subCatSelect:SetSelected("ArenaS11PvP")
            ClickSelectButton(14, 1, "notRefresh")
            mainFrame.boss:SetSelected(14)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_engraving") .. L["附魔"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Enchanting" .. GetVerText())
        end, -20)
        CreateButton(AddTexture("Interface/Icons/inv_misc_gem_01") .. L["珠宝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Jewelcrafting" .. GetVerText())
            mainFrame.boss:SetSelected(info["Jewelcrafting"])
        end)
        CreateButton(AddTexture("Interface/Icons/inv_inscription_tradeskill01") .. L["铭文"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Inscription" .. GetVerText())
            info["Inscription"]()
        end)
        CreateButton(AddTexture("Interface/Icons/trade_blacksmithing") .. L["锻造"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Blacksmithing" .. GetVerText())
            mainFrame.boss:SetSelected(info["Blacksmithing"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_tailoring") .. L["裁缝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Tailoring" .. GetVerText())
            mainFrame.boss:SetSelected(info["Tailoring"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_leatherworking") .. L["制皮"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Leatherworking" .. GetVerText())
            mainFrame.boss:SetSelected(info["Leatherworking"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_engineering") .. L["工程"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Engineering" .. GetVerText())
            mainFrame.boss:SetSelected(info["Engineering"])
        end)
    elseif BG.IsMOP_TW then
        local info = infoTbl[verNum]
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
            mainFrame.subCatSelect:SetSelected("ValorPoints" .. GetVerText())
            mainFrame.boss:SetSelected(8)
        end, -20)
        CreateButton(L["正义"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("JusticePoints" .. GetVerText())
            mainFrame.boss:SetSelected(8)
        end)
        CreateButton(L["天神"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Collections")
            mainFrame.subCatSelect:SetSelected("CelestialVendor" .. GetVerText())
            ClickSelectButton(21, 1, "notRefresh")
            mainFrame.boss:SetSelected(6)
        end)

        CreateButton(AddTexture("Interface/Icons/trade_engraving") .. L["附魔"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Enchanting" .. GetVerText())
        end, -20)
        CreateButton(AddTexture("Interface/Icons/inv_misc_gem_01") .. L["珠宝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Jewelcrafting" .. GetVerText())
            mainFrame.boss:SetSelected(info["Jewelcrafting"])
        end)
        CreateButton(AddTexture("Interface/Icons/inv_inscription_tradeskill01") .. L["铭文"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Inscription" .. GetVerText())
            mainFrame.boss:SetSelected(info["Inscription"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_blacksmithing") .. L["锻造"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Blacksmithing" .. GetVerText())
            mainFrame.boss:SetSelected(info["Blacksmithing"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_tailoring") .. L["裁缝"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Tailoring" .. GetVerText())
            mainFrame.boss:SetSelected(info["Tailoring"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_leatherworking") .. L["制皮"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Leatherworking" .. GetVerText())
            mainFrame.boss:SetSelected(info["Leatherworking"])
        end)
        CreateButton(AddTexture("Interface/Icons/trade_engineering") .. L["工程"], function()
            mainFrame.moduleSelect:SetSelected("AtlasLootClassic_Crafting")
            mainFrame.subCatSelect:SetSelected("Engineering" .. GetVerText())
            mainFrame.boss:SetSelected(info["Engineering"])
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
