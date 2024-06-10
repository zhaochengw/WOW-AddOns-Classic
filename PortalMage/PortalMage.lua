local PortalMage = LibStub("AceAddon-3.0"):NewAddon("PortalMage")
local L = LibStub("AceLocale-3.0"):GetLocale("PortalMage")
local group = {}
local Masque
local teleportRunes
local portalRunes

portalMageSpells = {["stormwind"] = true,
					["orgrimmar"] = true,
					["ironforge"] = true,
					["undercity"] = true,
					["darnassus"] = true,
					["thunderbluff"] = true,
					["exodar"] = true,
					["silvermoon"] = true,
					["theramore"] = true,
					["stonard"] = true,
					["shattrath"] = true,
					["dalaran"] = true}

PortalMage.portals = {["stormwind"] = 10059,
					  ["orgrimmar"] = 11417,
					  ["ironforge"] = 11416,
					  ["undercity"] = 11418,
					  ["darnassus"] = 11419,
					  ["thunderbluff"] = 11420,
					  ["exodar"] = 32266,
					  ["silvermoon"] = 32267,
					  ["theramore"] = 49360,
					  ["stonard"] = 49361,
					  ["shattrathA"] = 33691,
					  ["shattrathH"] = 35717,
					  ["dalaran"] = 53142}

PortalMage.teleports = {["stormwind"] = 3561,
						["orgrimmar"] = 3567,
						["ironforge"] = 3562,
						["undercity"] = 3563,
						["darnassus"] = 3565,
						["thunderbluff"] = 3566,
						["exodar"] = 32271,
						["silvermoon"] = 32272,
						["theramore"] = 49359,
						["stonard"] = 49358,
						["shattrathA"] = 33690,
						["shattrathH"] = 35715,
						["dalaran"] = 53140}

PortalMage.icons = {["stormwind"] = "Interface/ICONS/Spell_Arcane_TeleportStormwind",
					["orgrimmar"] = "Interface/ICONS/Spell_Arcane_TeleportOrgrimmar",
					["ironforge"] = "Interface/ICONS/Spell_Arcane_TeleportIronforge",
					["undercity"] = "Interface/ICONS/Spell_Arcane_TeleportUndercity",
					["darnassus"] = "Interface/ICONS/Spell_Arcane_TeleportDarnassus",
					["thunderbluff"] = "Interface/ICONS/Spell_Arcane_TeleportThunderBluff",
					["exodar"] = "Interface/ICONS/Spell_Arcane_TeleportExodar",
					["silvermoon"] = "Interface/ICONS/Spell_Arcane_TeleportSilvermoon",
					["theramore"] = "Interface/ICONS/Spell_Arcane_TeleportTheramore",
					["stonard"] = "Interface/ICONS/Spell_Arcane_TeleportStonard",
					["shattrath"] = "Interface/ICONS/Spell_Arcane_TeleportShattrath",
					["dalaran"] = "Interface/ICONS/Spell_Arcane_TeleportDalaran"}

function PortalMage:OnInitialize()
	_, self.class = UnitClass("player")
	self.faction = UnitFactionGroup("player")
	if self.class == "MAGE" then
		self.frame = CreateFrame("FRAME", nil, UIParent)
		self.move = CreateFrame("FRAME", nil, self.frame, BackdropTemplateMixin and "BackdropTemplate")
		Masque = LibStub("Masque", true)
		if Masque ~= nil then
			group = Masque:Group("Portal Mage", "Buttons")
		end
		if not portalMageData then
			portalMageData = {}
		end
		if not portalMageData.X then
			portalMageData.X = 300
		end
		if not portalMageData.Y then
			portalMageData.Y = 300
		end
		if portalMageData.Vertical == nil then
			portalMageData.Vertical = false
		end
		if portalMageData.Scale == nil then
			portalMageData.Scale = 1
		end
		if portalMageData.Runes == nil then
			portalMageData.Runes = {}
		end
		if portalMageData.Runes.Portal == nil then
			portalMageData.Runes.Portal = {}
			portalMageData.Runes.Portal.show = true
			portalMageData.Runes.Portal.position = "TOPLEFT"
		end
		if portalMageData.Runes.Teleport == nil then
			portalMageData.Runes.Teleport = {}
			portalMageData.Runes.Teleport.show = true
			portalMageData.Runes.Teleport.position = "TOPRIGHT"
		end
		if portalMageData.Invert == nil then
			portalMageData.Invert = false
		end
		if portalMageData.Opacity == nil then
			portalMageData.Opacity = 1
		end
		if portalMageData.Mouseover == nil then
			portalMageData.Mouseover = false
		end
		teleportRunes = self:CountItems(17031)
		portalRunes = self:CountItems(17032)
		self:SetupFrame(self.frame)
		self:SetupMoveFrame(self.move)
		if self.faction == "Alliance" then
			local options = {
				name = L["Portal Mage"],
				handler = PortalMage,
				type = "group",
				args = {
					movable = {
						name = L["Set Movable"],
						type = "toggle",
						desc = L["makes bar movable"],
						set = "SetMove",
						get = "GetMove"
					},
					layout = {
						name = L["Layout"],
						type = "group",
						args = {
							vertical = {
								name = L["Layout"],
								order = 0,
								type = "select",
								desc = L["select layout type"],
								values = {[true] = "Vertical", [false] = "Horizontal"},
								set = "SetLayout",
								get = "GetLayout",
								style = "radio"
							},
							scale = {
								name = L["Scale"],
								order = 1,
								type = "range",
								desc = L["you scale whole bar up or down"],
								width = "full",
								min = 0.5,
								max = 2,
								set = "SetScale",
								get = "GetScale"
							},
							portalRune = {
								name = "Rune of Portals",
								type = "group",
								args ={
									enable = {
										name = "Enable",
										type = "toggle",
										desc = "enable Rune of Portals display near the bar",
										set = "SetPortalRuneEnable",
										get = "GetPortalRuneEnable"
									},
									position = {
										name = "Position",
										type = "select",
										values = {["TOPLEFT"] = L["Top Left"], ["BOTTOMLEFT"] = L["Bottom Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMRIGHT"] = L["Bottom Right"]},
										style = "dropdown",
										set = "SetPortalRunePosition",
										get = "GetPortalRunePosition"
									}
								}
							},
							teleportRune = {
								name = "Rune of Teleportaion",
								type = "group",
								args ={
									enable = {
										name = "Enable",
										type = "toggle",
										desc = "enable Rune of Teleportaion display near the bar",
										set = "SetTeleportRuneEnable",
										get = "GetTeleportRuneEnable"
									},
									position = {
										name = "Position",
										type = "select",
										values = {["TOPLEFT"] = L["Top Left"], ["BOTTOMLEFT"] = L["Bottom Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMRIGHT"] = L["Bottom Right"]},
										style = "dropdown",
										set = "SetTeleportRunePosition",
										get = "GetTeleportRunePosition"
									}
								}
							},
							invert = {
								name = L["Invert mouse buttons"],
								type = "toggle",
								desc = L["when enabled left mouse button will cast teleport spell while right mouse button will cast portal spell"],
								set = "SetInvert",
								get = "GetInvert"
							},
							opacity = {
								name = L["Opacity"],
								order = 1,
								type = "range",
								desc = L["change bar opacity"],
								width = "full",
								min = 0.1,
								max = 1,
								set = "SetOpacity",
								get = "GetOpacity"
							},
							mouseover = {
								name = L["Show only on mouse over"],
								type = "toggle",
								desc = L["when enabled bar will only be visible when you mouse over it"],
								set = "SetMouseover",
								get = "GetMouseover"
							}
						}
					},
					portals = {
						name = L["Portals"],
						type = "group",
						args = {
							stormwind = {
								name = L["Stormwind"],
								type = "toggle",
								desc = L["toggles portal and teleport to Stormwind"],
								set = "Set",
								get = "Get"
							},
							ironforge = {
								name = L["Ironforge"],
								type = "toggle",
								desc = L["toggles portal and teleport to Ironforge"],
								set = "Set",
								get = "Get"
							},
							darnassus = {
								name = L["Darnassus"],
								type = "toggle",
								desc = L["toggles portal and teleport to Darnassus"],
								set = "Set",
								get = "Get"
							},
							exodar = {
								name = L["Exodar"],
								type = "toggle",
								desc = L["toggles portal and teleport to Exodar"],
								set = "Set",
								get = "Get"
							},
							theramore = {
								name = L["Theramore"],
								type = "toggle",
								desc = L["toggles portal and teleport to Theramore"],
								set = "Set",
								get = "Get"
							},
							shattrath = {
								name = L["Shattrath"],
								type = "toggle",
								desc = L["toggles portal and teleport to Shattrath"],
								set = "Set",
								get = "Get"
							},
							dalaran = {
								name = L["Dalaran"],
								type = "toggle",
								desc = L["toggles portal and teleport to Dalaran"],
								set = "Set",
								get = "Get"
							}
						}
					}
				}
			}
			LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalMage", options, nil)
			LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalMage", "Portal Mage")
		else
			local options = {
				name = L["Portal Mage"],
				handler = PortalMage,
				type = "group",
				args = {
					movable = {
						name = L["Set Movable"],
						type = "toggle",
						desc = L["makes bar movable"],
						set = "SetMove",
						get = "GetMove"
					},
					layout = {
						name = L["Layout"],
						type = "group",
						args = {
							vertical = {
								name = L["Layout"],
								order = 0,
								type = "select",
								desc = L["select layout type"],
								values = {[true] = "Vertical", [false] = "Horizontal"},
								set = "SetLayout",
								get = "GetLayout",
								style = "radio"
							},
							scale = {
								name = L["Scale"],
								order = 1,
								type = "range",
								desc = L["you scale whole bar up or down"],
								width = "full",
								min = 0.5,
								max = 2,
								set = "SetScale",
								get = "GetScale"
							},
							portalRune = {
								name = "Rune of Portals",
								type = "group",
								args ={
									enable = {
										name = "Enable",
										type = "toggle",
										desc = "enable Rune of Portals display near the bar",
										set = "SetPortalRuneEnable",
										get = "GetPortalRuneEnable"
									},
									position = {
										name = "Position",
										type = "select",
										values = {["TOPLEFT"] = L["Top Left"], ["BOTTOMLEFT"] = L["Bottom Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMRIGHT"] = L["Bottom Right"]},
										style = "dropdown",
										set = "SetPortalRunePosition",
										get = "GetPortalRunePosition"
									}
								}
							},
							teleportRune = {
								name = "Rune of Teleportaion",
								type = "group",
								args ={
									enable = {
										name = "Enable",
										type = "toggle",
										desc = "enable Rune of Teleportaion display near the bar",
										set = "SetTeleportRuneEnable",
										get = "GetTeleportRuneEnable"
									},
									position = {
										name = "Position",
										type = "select",
										values = {["TOPLEFT"] = L["Top Left"], ["BOTTOMLEFT"] = L["Bottom Left"], ["TOPRIGHT"] = L["Top Right"], ["BOTTOMRIGHT"] = L["Bottom Right"]},
										style = "dropdown",
										set = "SetTeleportRunePosition",
										get = "GetTeleportRunePosition"
									}
								}
							},
							invert = {
								name = L["Invert mouse buttons"],
								type = "toggle",
								desc = L["when enabled left mouse button will cast teleport spell while right mouse button will cast portal spell"],
								set = "SetInvert",
								get = "GetInvert"
							},
							opacity = {
								name = L["Opacity"],
								order = 1,
								type = "range",
								desc = L["change bar opacity"],
								width = "full",
								min = 0.1,
								max = 1,
								set = "SetOpacity",
								get = "GetOpacity"
							},
							mouseover = {
								name = L["Show only on mouse over"],
								type = "toggle",
								desc = L["when enabled bar will only be visible when you mouse over it"],
								set = "SetMouseover",
								get = "GetMouseover"
							}
						}
					},
					portals = {
						name = L["Portals"],
						type = "group",
						args = {
							orgrimmar = {
								name = L["Orgrimmar"],
								type = "toggle",
								desc = L["toggles portal and teleport to Orgrimmar"],
								set = "Set",
								get = "Get"
							},
							undercity = {
								name = L["Undercity"],
								type = "toggle",
								desc = L["toggles portal and teleport to Undercity"],
								set = "Set",
								get = "Get"
							},
							thunderbluff = {
								name = L["Thunder Bluff"],
								type = "toggle",
								desc = L["toggles portal and teleport to Thunder Bluff"],
								set = "Set",
								get = "Get"
							},
							silvermoon = {
								name = L["Silvermoon"],
								type = "toggle",
								desc = L["toggles portal and teleport to Silvermoon"],
								set = "Set",
								get = "Get"
							},
							stonard = {
								name = L["Stonard"],
								type = "toggle",
								desc = L["toggles portal and teleport to Stonard"],
								set = "Set",
								get = "Get"
							},
							shattrath = {
								name = L["Shattrath"],
								type = "toggle",
								desc = L["toggles portal and teleport to Shattrath"],
								set = "Set",
								get = "Get"
							},
							dalaran = {
								name = L["Dalaran"],
								type = "toggle",
								desc = L["toggles portal and teleport to Dalaran"],
								set = "Set",
								get = "Get"
							}
						}
					}
				}
			}
			LibStub("AceConfig-3.0"):RegisterOptionsTable("PortalMage", options, nil)
			LibStub("AceConfigDialog-3.0"):AddToBlizOptions("PortalMage", "Portal Mage")
		end
	end
end

function PortalMage:SetMove(info, val)
	if val then
		self.move:Show()
		self.frame:SetAlpha(1)
	else
		self.move:Hide()
	if portalMageData.Mouseover then
		self.frame:SetAlpha(0)
	else
		self.frame:SetAlpha(portalMageData.Opacity)
	end
	end
end

function PortalMage:GetMove(info)
	return PortalMage.move:IsShown()
end

function PortalMage:SetLayout(info, val)
	portalMageData.Vertical = val
	if portalMageData.Vertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetLayout(info)
	return portalMageData.Vertical
end

function PortalMage:SetScale(info, val)
	portalMageData.Scale = val;
	self.frame:SetScale(0.8 * portalMageData.Scale)
end

function PortalMage:GetScale(info)
	return portalMageData.Scale
end

function PortalMage:SetPortalRuneEnable(info, val)
	portalMageData.Runes.Portal.show = val
	if portalMageData.Runes.Portal.show then
		self.frame.portals:Show()
	else
		self.frame.portals:Hide()
	end
end

function PortalMage:GetPortalRuneEnable(info)
	return portalMageData.Runes.Portal.show
end

function PortalMage:SetPortalRunePosition(info, val)
	portalMageData.Runes.Portal.position = val
	if portalMageData.Vertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetPortalRunePosition(info)
	return portalMageData.Runes.Portal.position
end

function PortalMage:SetTeleportRuneEnable(info, val)
	portalMageData.Runes.Teleport.show = val
	if portalMageData.Runes.Teleport.show then
		self.frame.teleports:Show()
	else
		self.frame.teleports:Hide()
	end
end

function PortalMage:GetTeleportRuneEnable(info)
	return portalMageData.Runes.Teleport.show
end

function PortalMage:SetTeleportRunePosition(info, val)
	portalMageData.Runes.Teleport.position = val
	if portalMageData.Vertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetTeleportRunePosition(info)
	return portalMageData.Runes.Teleport.position
end

function PortalMage:SetInvert(info, val)
	portalMageData.Invert = val
	if portalMageData.Vertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetInvert(info)
	return portalMageData.Invert
end

function PortalMage:SetOpacity(info, val)
	portalMageData.Opacity = val
	if portalMageData.Mouseover then
		self.frame:SetAlpha(0)
	else
		self.frame:SetAlpha(val)
	end
end

function PortalMage:GetOpacity(info)
	return portalMageData.Opacity
end

function PortalMage:SetMouseover(info, val)
	portalMageData.Mouseover = val
	if portalMageData.Mouseover then
		self.frame:SetAlpha(0)
	else
		self.frame:SetAlpha(portalMageData.Opacity)
	end
end

function PortalMage:GetMouseover(info)
	return portalMageData.Mouseover
end

function PortalMage:Set(info, val)
	portalMageSpells[info[#info]] = val
	if portalMageData.Vertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
	if Masque ~= nil then
		self:RemoveMasqueButtons()
		self:AddMasqueButtons()
		group:ReSkin()
	end
end

function PortalMage:Get(info)
	return portalMageSpells[info[#info]]
end

function PortalMage:AddMasqueButtons()
	if self.faction == "Alliance" then
		if portalMageSpells["stormwind"] then
			group:AddButton(self.button1)
		end
		if portalMageSpells["ironforge"] then
			group:AddButton(self.button2)
		end
		if portalMageSpells["darnassus"] then
			group:AddButton(self.button3)
		end
		if portalMageSpells["exodar"] then
			group:AddButton(self.button4)
		end
		if portalMageSpells["theramore"] then
			group:AddButton(self.button5)
		end
		if portalMageSpells["shattrath"] then
			group:AddButton(self.button6)
		end
		if portalMageSpells["dalaran"] then
			group:AddButton(self.button7)
		end
	else
		if portalMageSpells["orgrimmar"] then
			group:AddButton(self.button1)
		end
		if portalMageSpells["undercity"] then
			group:AddButton(self.button2)
		end
		if portalMageSpells["thunderbluff"] then
			group:AddButton(self.button3)
		end
		if portalMageSpells["silvermoon"] then
			group:AddButton(self.button4)
		end
		if portalMageSpells["stonard"] then
			group:AddButton(self.button5)
		end
		if portalMageSpells["shattrath"] then
			group:AddButton(self.button6)
		end
		if portalMageSpells["dalaran"] then
			group:AddButton(self.button7)
		end
	end
end

function PortalMage:RemoveMasqueButtons()
	group:RemoveButton(self.button1)
	group:RemoveButton(self.button2)
	group:RemoveButton(self.button3)
	group:RemoveButton(self.button4)
	group:RemoveButton(self.button5)
	group:RemoveButton(self.button6)
	group:RemoveButton(self.button7)
end

function PortalMage.frameOnEvent(self, event, spell)
	if event == "PLAYER_LOGIN" then
		self:SetHeight(40)
		PortalMage.move:SetHeight(40);
		if portalMageData.Vertical then
			PortalMage:SetupButtonsVertical(self, PortalMage.move)
		else
			PortalMage:SetupButtonsHorizontal(self, PortalMage.move)
		end
		if Masque ~= nil then
			PortalMage:AddMasqueButtons()
			group:ReSkin()
		end
		self:UnregisterEvent("PLAYER_LOGIN")
	elseif event == "LEARNED_SPELL_IN_TAB" and PortalMage:NewSpell(spell) then
		self:SetHeight(40)
		PortalMage.move:SetHeight(40);
		if portalMageData.Vertical then
			PortalMage:SetupButtonsVertical(self, PortalMage.move)
		else
			PortalMage:SetupButtonsHorizontal(self, PortalMage.move)
		end
		if Masque ~= nil then
			PortalMage:RemoveMasqueButtons()
			PortalMage:AddMasqueButtons()
			group:ReSkin()
		end
	elseif event == "BAG_UPDATE" then
		teleportRunes = PortalMage:CountItems(17031)
		portalRunes = PortalMage:CountItems(17032)
		self.teleports:SetText(teleportRunes)
		self.portals:SetText(portalRunes)
		AdjustReagentDisplay(self)
	end
end

function PortalMage.frameOnDragStart(self)
	PortalMage.frame:StartMoving()
end

function PortalMage.frameOnDragStop(self)
	PortalMage.frame:StopMovingOrSizing()
	portalMageData.X = PortalMage.frame:GetLeft()
	portalMageData.Y = PortalMage.frame:GetBottom()
end

function PortalMage:NewSpell(id)
	if self:SpellOnList(id) then
		for i = 121,135,1 do
			_, spell = GetActionInfo(i)
			if spell == id then
				return false
			end
		end
		return true
	end
	return false
end

function PortalMage:SpellOnList(id)
	local name = GetSpellInfo(id)
	for k, v in pairs(self.portals) do
		if name == v then 
			return true
		end
	end
	return false
end

function PortalMage:SetupFrame(frame)
	frame:SetMovable(true)
	frame:SetPoint("BOTTOMLEFT", portalMageData.X, portalMageData.Y)
	frame:SetScale(0.8 * portalMageData.Scale)
	frame:SetFrameStrata("LOW")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
	frame:RegisterEvent("BAG_UPDATE")
	frame:SetScript("OnEvent", PortalMage.frameOnEvent)
	frame.teleports = frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
	frame.teleports:SetTextColor(1, 1, 0)
	frame.teleports:SetText(teleportRunes)
	--frame.texture = frame:CreateTexture()
	--frame.texture:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
	--frame.texture:SetVertexColor(0, 0, 0, 1)
	--frame.texture:SetAllPoints(frame.teleports)
	frame.portals = frame:CreateFontString(nil, "OVERLAY", "GameFontWhite")
	frame.portals:SetTextColor(0, 1, 0)
	frame.portals:SetText(portalRunes)
	--frame.texture = frame:CreateTexture()
	--frame.texture:SetTexture("Interface/Tooltips/UI-Tooltip-Background")
	--frame.texture:SetVertexColor(0, 0, 0, 1)
	--frame.texture:SetAllPoints(frame.portals)
	if portalMageData.Runes.Portal.show then
		frame.portals:Show()
	else
		frame.portals:Hide()
	end
	if portalMageData.Runes.Teleport.show then
		frame.teleports:Show()
	else
		frame.teleports:Hide()
	end
	if portalMageData.Mouseover then
		frame:SetAlpha(0)
	else
		frame:SetAlpha(portalMageData.Opacity)
	end
end

function PortalMage:SetupMoveFrame(frame)
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:SetClampedToScreen(true)
	frame:SetPoint("BOTTOMLEFT", 0, 0)
	frame:SetFrameStrata("HIGH")
	local backdrop = {
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		tile = false,
		tileSize = 0,
	}
	frame:SetBackdrop(backdrop)
	frame:SetBackdropColor(0, 0.75, 0.25, 0.75)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", PortalMage.frameOnDragStart)
	frame:SetScript("OnDragStop", PortalMage.frameOnDragStop)
	frame:Hide()
end

function PortalMage:CountItems(item)
	local count = 0
	for bag = 0 ,NUM_BAG_SLOTS do
		for slot = 1, C_Container.GetContainerNumSlots(bag) do
			if item == C_Container.GetContainerItemID(bag, slot) then
				local info = C_Container.GetContainerItemInfo(bag, slot)
				if info then
					count = count + info.stackCount
				end
			end
		end
	end
	return count
end

function PortalMage:SetupButtonsVertical(frame, move)
	self:ClearButtons()
	local length = 0
	if self.faction == "Alliance" then
		if portalMageSpells["stormwind"] then
			self.button1, length = self:SetupButtonVertical("PortalMageButton1", self.button1, length, "stormwind", 121, frame, PortalMage.icons["stormwind"])
		end
		if portalMageSpells["ironforge"] then
			self.button2, length = self:SetupButtonVertical("PortalMageButton2", self.button2, length, "ironforge", 122, frame, PortalMage.icons["ironforge"])
		end
		if portalMageSpells["darnassus"] then
			self.button3, length = self:SetupButtonVertical("PortalMageButton3", self.button3, length, "darnassus", 123, frame, PortalMage.icons["darnassus"])
		end
		if portalMageSpells["exodar"] then
			self.button4, length = self:SetupButtonVertical("PortalMageButton4", self.button4, length, "exodar", 124, frame, PortalMage.icons["exodar"])
		end
		if portalMageSpells["theramore"] then
			self.button5, length = self:SetupButtonVertical("PortalMageButton5", self.button5, length, "theramore", 125, frame, PortalMage.icons["theramore"])
		end
		if portalMageSpells["shattrath"] then
			self.button6, length = self:SetupButtonVertical("PortalMageButton6", self.button6, length, "shattrathA", 126, frame, PortalMage.icons["shattrath"])
		end
		if portalMageSpells["dalaran"] then
			self.button7, length = self:SetupButtonVertical("PortalMageButton7", self.button7, length, "dalaran", 127, frame, PortalMage.icons["dalaran"])
		end
	else
		if portalMageSpells["orgrimmar"] then
			self.button1, length = self:SetupButtonVertical("PortalMageButton1", self.button1, length, "orgrimmar", 121, frame, PortalMage.icons["orgrimmar"])
		end
		if portalMageSpells["undercity"] then
			self.button2, length = self:SetupButtonVertical("PortalMageButton2", self.button2, length, "undercity", 122, frame, PortalMage.icons["undercity"])
		end
		if portalMageSpells["thunderbluff"] then
			self.button3, length = self:SetupButtonVertical("PortalMageButton3", self.button3, length, "thunderbluff", 123, frame, PortalMage.icons["thunderbluff"])
		end
		if portalMageSpells["silvermoon"] then
			self.button4, length = self:SetupButtonVertical("PortalMageButton4", self.button4, length, "silvermoon", 124, frame, PortalMage.icons["silvermoon"])
		end
		if portalMageSpells["stonard"] then
			self.button5, length = self:SetupButtonVertical("PortalMageButton5", self.button5, length, "stonard", 125, frame, PortalMage.icons["stonard"])
		end
		if portalMageSpells["shattrath"] then
			self.button6, length = self:SetupButtonVertical("PortalMageButton6", self.button6, length, "shattrathH", 126, frame, PortalMage.icons["shattrath"])
		end
		if portalMageSpells["dalaran"] then
			self.button7, length = self:SetupButtonVertical("PortalMageButton7", self.button7, length, "dalaran", 127, frame, PortalMage.icons["dalaran"])
		end
	end
	frame:SetWidth(40)
	move:SetWidth(40)
	frame:SetHeight(-length)
	move:SetHeight(-length)
	AdjustReagentDisplay(frame)
	collectgarbage("collect")
end

function PortalMage:SetupButtonsHorizontal(frame, move)
	self:ClearButtons()
	local length = 0
	if self.faction == "Alliance" then
		if portalMageSpells["stormwind"] then
			self.button1, length = self:SetupButtonHorizontal("PortalMageButton1", self.button1, length, "stormwind", 121, frame, PortalMage.icons["stormwind"])
		end
		if portalMageSpells["ironforge"] then
			self.button2, length = self:SetupButtonHorizontal("PortalMageButton2", self.button2, length, "ironforge", 122, frame, PortalMage.icons["ironforge"])
		end
		if portalMageSpells["darnassus"] then
			self.button3, length = self:SetupButtonHorizontal("PortalMageButton3", self.button3, length, "darnassus", 123, frame, PortalMage.icons["darnassus"])
		end
		if portalMageSpells["exodar"] then
			self.button4, length = self:SetupButtonHorizontal("PortalMageButton4", self.button4, length, "exodar", 124, frame, PortalMage.icons["exodar"])
		end
		if portalMageSpells["theramore"] then
			self.button5, length = self:SetupButtonHorizontal("PortalMageButton5", self.button5, length, "theramore", 125, frame, PortalMage.icons["theramore"])
		end
		if portalMageSpells["shattrath"] then
			self.button6, length = self:SetupButtonHorizontal("PortalMageButton6", self.button6, length, "shattrathA", 126, frame, PortalMage.icons["shattrath"])
		end
		if portalMageSpells["dalaran"] then
			self.button7, length = self:SetupButtonHorizontal("PortalMageButton7", self.button7, length, "dalaran", 127, frame, PortalMage.icons["dalaran"])
		end
	else
		if portalMageSpells["orgrimmar"] then
			self.button1, length = self:SetupButtonHorizontal("PortalMageButton1", self.button1, length, "orgrimmar", 121, frame, PortalMage.icons["orgrimmar"])
		end
		if portalMageSpells["undercity"] then
			self.button2, length = self:SetupButtonHorizontal("PortalMageButton2", self.button2, length, "undercity", 122, frame, PortalMage.icons["undercity"])
		end
		if portalMageSpells["thunderbluff"] then
			self.button3, length = self:SetupButtonHorizontal("PortalMageButton3", self.button3, length, "thunderbluff", 123, frame, PortalMage.icons["thunderbluff"])
		end
		if portalMageSpells["silvermoon"] then
			self.button4, length = self:SetupButtonHorizontal("PortalMageButton4", self.button4, length, "silvermoon", 124, frame, PortalMage.icons["silvermoon"])
		end
		if portalMageSpells["stonard"] then
			self.button5, length = self:SetupButtonHorizontal("PortalMageButton5", self.button5, length, "stonard", 125, frame, PortalMage.icons["stonard"])
		end
		if portalMageSpells["shattrath"] then
			self.button6, length = self:SetupButtonHorizontal("PortalMageButton6", self.button6, length, "shattrathH", 126, frame, PortalMage.icons["shattrath"])
		end
		if portalMageSpells["dalaran"] then
			self.button7, length = self:SetupButtonHorizontal("PortalMageButton7", self.button7, length, "dalaran", 127, frame, PortalMage.icons["dalaran"])
		end
	end
	frame:SetWidth(length)
	move:SetWidth(length)
	frame:SetHeight(40)
	move:SetHeight(40)
	AdjustReagentDisplay(frame)
	collectgarbage("collect")
end

function AdjustReagentDisplay(frame)
	frame.portals:ClearAllPoints()
	frame.teleports:ClearAllPoints()
	local offset = 15
	if portalRunes > 99 then
		offset = offset + 17
	elseif portalRunes > 9 then
		offset = offset + 7
	end
	if string.find(portalMageData.Runes.Portal.position, "LEFT") then
		offset = -offset
	end
	frame.portals:SetPoint(portalMageData.Runes.Portal.position, offset, 0)
	offset = 15
	if teleportRunes > 99 then
		offset = offset + 17
	elseif teleportRunes > 9 then
		offset = offset + 7
	end
	if string.find(portalMageData.Runes.Teleport.position, "LEFT") then
		offset = -offset
	end
	frame.teleports:SetPoint(portalMageData.Runes.Teleport.position, offset, 0)
end

function PortalMage.buttonOnUpdate(self)
	if Masque ~= nil then
		group:ReSkin()
	end
end

function PortalMage:SetupButtonVertical(name, button, y, index, id, frame, icon)
	if button == nil then
		button = CreateFrame("CHECKBUTTON", name, frame, BackdropTemplateMixin and "BackdropTemplate, SecureActionButtonTemplate, ActionBarButtonTemplate")
	end
	button:Show()
	button:SetWidth(38)
	button:SetHeight(38)
	button:SetPoint("TOPLEFT", 0, y)
	self:SetupButton(button, index, id, icon)
	return button, y - 40
end

function PortalMage:SetupButtonHorizontal(name, button, x, index, id, frame, icon)
	if button == nil then
		button = CreateFrame("CHECKBUTTON", name, frame, BackdropTemplateMixin and "BackdropTemplate, SecureActionButtonTemplate, ActionBarButtonTemplate")
	end
	button:Show()
	button:SetWidth(38)
	button:SetHeight(38)
	button:SetPoint("TOPLEFT", x, 0)
	self:SetupButton(button, index, id, icon)
	return button, x + 40
end

function PortalMage:SetupButton(button, index, id, icon)
	button:SetFrameStrata("MEDIUM")
	button:SetAttribute("showgrid", 1)
	button:SetAttribute("action", id)
	button:SetAttribute("type", "spell")
	if portalMageData.Invert then
		button:SetAttribute("spell2", self.portals[index])
		button:SetAttribute("spell1", self.teleports[index])
		button:SetScript("OnEnter", function(self) 
						PortalMage.frame:SetAlpha(1)
						GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
						GameTooltip:AddLine(L["Left Click:"])
						GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
						GameTooltip:AddLine("\n")
						GameTooltip:AddLine(L["Right Click:"])
						GameTooltip:AddSpellByID(self:GetAttribute("spell2"))
						GameTooltip:Show()
						end)
	else
		button:SetAttribute("spell1", self.portals[index])
		button:SetAttribute("spell2", self.teleports[index])
		button:SetScript("OnEnter", function(self) 
						PortalMage.frame:SetAlpha(1)
						GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
						GameTooltip:AddLine(L["Left Click:"])
						GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
						GameTooltip:AddLine("\n")
						GameTooltip:AddLine(L["Right Click:"])
						GameTooltip:AddSpellByID(self:GetAttribute("spell2"))
						GameTooltip:Show()
						end)
	end
	button:SetScript("OnLeave", function(self)
					if portalMageData.Mouseover then
						PortalMage.frame:SetAlpha(0)
					else
						PortalMage.frame:SetAlpha(portalMageData.Opacity)
					end
					GameTooltip:Hide()
					end)
	button:SetBackdrop({bgFile = icon,
					   tile = false,
					   insets = {left = 0,
								 right = 0,
								 top = 0,
								 bottom = 0}})
end

function PortalMage:ClearButtons()
	self:ClearButton(self.button1, 121)
	self:ClearButton(self.button2, 122)
	self:ClearButton(self.button3, 123)
	self:ClearButton(self.button4, 124)
	self:ClearButton(self.button5, 125)
	self:ClearButton(self.button6, 126)
	self:ClearButton(self.button7, 127)
end

function PortalMage:ClearButton(button, id)
	if button ~= nil then
		button:Hide()
		button:SetAttribute("showgrid", 0)
		button:SetAttribute("action", id)
		button:SetAttribute("type", "spell")
	end
end