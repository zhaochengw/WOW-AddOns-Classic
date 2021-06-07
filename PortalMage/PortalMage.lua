local PortalMage = LibStub("AceAddon-3.0"):NewAddon("PortalMage")
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
					["shattrath"] = false}

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
					  ["shattrathH"] = 35717}

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
						["shattrathH"] = 35715}

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
					["shattrath"] = "Interface/ICONS/Spell_Arcane_TeleportShattrath"}

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
		if not portalMageFrameX then
			portalMageFrameX = 300
		end
		if not portalMageFrameY then
			portalMageFrameY = 300
		end
		if portalMageVertical == nil then
			portalMageVertical = false
		end
		if portalMageScale == nil then
			portalMageScale = 1
		end
		if portalMageRunes == nil then
			portalMageRunes = {}
			portalMageRunes.show = true
			portalMageRunes.flip = false
			portalMagerunes.right = false
		end
		teleportRunes = self:CountItems(17031)
		portalRunes = self:CountItems(17032)
		self:SetupFrame(self.frame)
		self:SetupMoveFrame(self.move)
		if self.faction == "Alliance" then
			local options = {
				name = "Portal Mage",
				handler = PortalMage,
				type = "group",
				args = {
					movable = {
						name = "解锁插件条",
						type = "toggle",
						desc = "使插件条可移动",
						set = "SetMove",
						get = "GetMove"
					},
					layout = {
						name = "布局",
						type = "group",
						args = {
							vertical = {
								name = "布局",
								order = 0,
								type = "select",
								desc = "选择布局类型",
								values = {[true] = "纵向", [false] = "横向"},
								set = "SetLayout",
								get = "GetLayout",
								style = "radio"
							},
							scale = {
								name = "缩放",
								order = 1,
								type = "range",
								desc = "整体缩放插件条",
								width = "full",
								min = 0.5,
								max = 2,
								set = "SetScale",
								get = "GetScale"
							},
							showRunes = {
								name = "显示施法材料数量",
								order = 2,
								type = "toggle",
								desc = "用小数字显示传送/传送门施法材料数量",
								set = "SetShowRunes",
								get = "GetShowRunes"
							},
							flipRunes = {
								name = "切换施法材料数量显示位置",
								order = 3,
								type = "toggle",
								desc = "切换施法材料数量显示，传送材料数量显示在右侧/底部或传送门数量显示在左侧/顶部",
								set = "SetFlipRunes",
								get = "GetFlipRunes"
							},
							right = {
								name = "纵向布局时施法材料数量显示位置",
								order = 4,
								type = "select",
								desc = "选择纵向布局时施法材料数量显示的位置",
								values = {[false] = "左", [true] = "右"},
								set = "SetRunePosition",
								get = "GetRunePosition",
								style = "radio"
							}
						}
					},
					portals = {
						name = "传送",
						type = "group",
						args = {
							stormwind = {
								name = "暴风城",
								type = "toggle",
								desc = "显示到暴风城的传送/传送门",
								set = "Set",
								get = "Get"
							},
							ironforge = {
								name = "铁炉堡",
								type = "toggle",
								desc = "显示到铁炉堡的传送/传送门",
								set = "Set",
								get = "Get"
							},
							darnassus = {
								name = "达纳苏斯",
								type = "toggle",
								desc = "显示到达纳苏斯的传送/传送门",
								set = "Set",
								get = "Get"
							},
							exodar = {
								name = "埃索达",
								type = "toggle",
								desc = "显示到埃索达的传送/传送门",
								set = "Set",
								get = "Get"
							},
							theramore = {
								name = "塞拉摩",
								type = "toggle",
								desc = "显示到塞拉摩的传送/传送门",
								set = "Set",
								get = "Get"
							},
							shattrath = {
								name = "沙塔斯",
								type = "toggle",
								desc = "显示到沙塔斯的传送/传送门",
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
				name = "Portal Mage",
				handler = PortalMage,
				type = "group",
				args = {
					movable = {
						name = "解锁插件条",
						type = "toggle",
						desc = "使插件条可移动",
						set = "SetMove",
						get = "GetMove"
					},
					layout = {
						name = "布局",
						type = "group",
						args = {
							vertical = {
								name = "布局",
								order = 0,
								type = "select",
								desc = "选择布局类型",
								values = {[true] = "纵向", [false] = "横向"},
								set = "SetLayout",
								get = "GetLayout",
								style = "radio"
							},
							scale = {
								name = "缩放",
								order = 1,
								type = "range",
								desc = "整体缩放插件条",
								width = "full",
								min = 0.5,
								max = 2,
								set = "SetScale",
								get = "GetScale"
							},
							showRunes = {
								name = "显示施法材料数量",
								order = 2,
								type = "toggle",
								desc = "用小数字显示传送/传送门施法材料数量",
								set = "SetShowRunes",
								get = "GetShowRunes"
							},
							flipRunes = {
								name = "切换施法材料数量显示位置",
								order = 3,
								type = "toggle",
								desc = "切换施法材料数量显示，传送材料数量显示在右侧/底部或传送门数量显示在左侧/顶部",
								set = "SetFlipRunes",
								get = "GetFlipRunes"
							},
							right = {
								name = "纵向布局时施法材料数量显示位置",
								order = 4,
								type = "select",
								desc = "选择纵向布局时施法材料数量显示的位置",
								values = {[false] = "左", [true] = "右"},
								set = "SetRunePosition",
								get = "GetRunePosition",
								style = "radio"
							}
						}
					},
					portals = {
						name = "传送",
						type = "group",
						args = {
							orgrimmar = {
								name = "奥格瑞玛",
								type = "toggle",
								desc = "显示到奥格瑞玛的传送/传送门",
								set = "Set",
								get = "Get"
							},
							undercity = {
								name = "幽暗城",
								type = "toggle",
								desc = "显示到幽暗城的传送/传送门",
								set = "Set",
								get = "Get"
							},
							thunderbluff = {
								name = "雷霆崖",
								type = "toggle",
								desc = "显示到雷霆崖的传送/传送门",
								set = "Set",
								get = "Get"
							},
							silvermoon = {
								name = "银月城",
								type = "toggle",
								desc = "显示到银月城的传送/传送门",
								set = "Set",
								get = "Get"
							},
							stonard = {
								name = "斯通纳德",
								type = "toggle",
								desc = "显示到斯通纳德的传送/传送门",
								set = "Set",
								get = "Get"
							},
							shattrath = {
								name = "沙塔斯",
								type = "toggle",
								desc = "显示到沙塔斯的传送/传送门",
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
		PortalMage.move:Show()
	else
		PortalMage.move:Hide()
	end
end

function PortalMage:GetMove(info)
	return PortalMage.move:IsShown()
end

function PortalMage:SetLayout(info, val)
	portalMageVertical = val
	if portalMageVertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetLayout(info)
	return portalMageVertical
end

function PortalMage:SetScale(info, val)
	portalMageScale = val;
	self.frame:SetScale(0.8 * portalMageScale)
end

function PortalMage:GetScale(info)
	return portalMageScale
end

function PortalMage:SetShowRunes(info, val)
	portalMageRunes.show = val
	if portalMageRunes.show then
		self.frame.portals:Show()
		self.frame.teleports:Show()
	else
		self.frame.portals:Hide()
		self.frame.teleports:Hide()
	end
end

function PortalMage:GetShowRunes(info)
	return portalMageRunes.show
end

function PortalMage:SetFlipRunes(info, val)
	portalMageRunes.flip = val
	if portalMageVertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetFlipRunes(info)
	return portalMageRunes.flip
end

function PortalMage:SetRunePosition(info, val)
	portalMageRunes.right = val
	if portalMageVertical then
		self:SetupButtonsVertical(self.frame, self.move)
	else
		self:SetupButtonsHorizontal(self.frame, self.move)
	end
end

function PortalMage:GetRunePosition(info)
	return portalMageRunes.right
end

function PortalMage:Set(info, val)
	portalMageSpells[info[#info]] = val
	if portalMageVertical then
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
	end
end

function PortalMage:RemoveMasqueButtons()
	group:RemoveButton(self.button1)
	group:RemoveButton(self.button2)
	group:RemoveButton(self.button3)
	group:RemoveButton(self.button4)
	group:RemoveButton(self.button5)
	group:RemoveButton(self.button6)
end

function PortalMage.frameOnEvent(self, event, spell)
	if event == "PLAYER_LOGIN" then
		self:SetHeight(40)
		PortalMage.move:SetHeight(40);
		if portalMageVertical then
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
		if portalMageVertical then
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
	end
end

function PortalMage.frameOnDragStart(self)
	PortalMage.frame:StartMoving()
end

function PortalMage.frameOnDragStop(self)
	PortalMage.frame:StopMovingOrSizing()
	portalMageFrameX = PortalMage.frame:GetLeft()
	portalMageFrameY = PortalMage.frame:GetBottom()
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
	frame:SetPoint("BOTTOMLEFT", portalMageFrameX, portalMageFrameY)
	frame:SetScale(0.8 * portalMageScale)
	frame:SetFrameStrata("LOW")
	frame:RegisterEvent("PLAYER_LOGIN")
	frame:RegisterEvent("LEARNED_SPELL_IN_TAB")
	frame:RegisterEvent("BAG_UPDATE")
	frame:SetScript("OnEvent", PortalMage.frameOnEvent)
	frame.teleports = frame:CreateFontString(nil, "HIGH", "GameFontWhite")
	frame.teleports:SetTextColor(1, 1, 0)
	frame.teleports:SetText(teleportRunes)
	frame.portals = frame:CreateFontString(nil, "HIGH", "GameFontWhite")
	frame.portals:SetTextColor(0, 1, 0)
	frame.portals:SetText(portalRunes)
	if portalMageRunes.show then
		self.frame.portals:Show()
		self.frame.teleports:Show()
	else
		self.frame.portals:Hide()
		self.frame.teleports:Hide()
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
		for slot = 1, GetContainerNumSlots(bag) do
			if item == GetContainerItemID(bag, slot) then
				count = count + (select(2, GetContainerItemInfo(bag, slot)))
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
	end
	frame:SetWidth(40)
	move:SetWidth(40)
	frame:SetHeight(-length)
	move:SetHeight(-length)
	frame.teleports:ClearAllPoints()
	frame.portals:ClearAllPoints()
	local position
	local offset
	if portalMageRunes.right then
		position = "RIGHT"
		offset = 15
	else
		position = "LEFT"
		offset = -15
	end
	if portalMageRunes.flip then		
		frame.portals:SetPoint("BOTTOM"..position, offset, 0)
		frame.teleports:SetPoint("TOP"..position, offset, 0)
	else
		frame.portals:SetPoint("TOP"..position, offset, 0)
		frame.teleports:SetPoint("BOTTOM"..position, offset, 0)
	end
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
	end
	frame:SetWidth(length)
	move:SetWidth(length)
	frame:SetHeight(40)
	move:SetHeight(40)
	frame.teleports:ClearAllPoints()
	frame.portals:ClearAllPoints()
	if portalMageRunes.flip then		
		frame.portals:SetPoint("TOPRIGHT", 15, 0)
		frame.teleports:SetPoint("TOPLEFT", -15, 0)
	else
		frame.portals:SetPoint("TOPLEFT", -15, 0)
		frame.teleports:SetPoint("TOPRIGHT", 15, 0)
	end
	collectgarbage("collect")
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
	button:SetFrameStrata("MEDIUM")
	button:SetAttribute("showgrid", 1)
	button:SetAttribute("action", id)
	button:SetAttribute("type", "spell")
	button:SetAttribute("spell1", self.portals[index])
	button:SetAttribute("spell2", self.teleports[index])
	button:SetScript("OnUpdate", self.buttonOnUpdate)
	button:SetScript("OnEnter", function(self) 
					 GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
					 GameTooltip:AddLine("左键:")
					 GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
					 GameTooltip:AddLine("\n")
					 GameTooltip:AddLine("右键:")
					 GameTooltip:AddSpellByID(self:GetAttribute("spell2"))
					 GameTooltip:Show()
					end)
	button:SetScript("OnLeave", function(self) 
					 GameTooltip:Hide()
					end)
	button:SetBackdrop({bgFile = icon,
					   tile = false,
					   insets = {left = 0,
								 right = 0,
								 top = 0,
								 bottom = 0}})
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
	button:SetFrameStrata("MEDIUM")
	button:SetAttribute("showgrid", 1)
	button:SetAttribute("action", id)
	button:SetAttribute("type", "spell")
	button:SetAttribute("spell1", self.portals[index])
	button:SetAttribute("spell2", self.teleports[index])
	button:SetScript("OnEnter", function(self) 
					 GameTooltip_SetDefaultAnchor(GameTooltip, UIParent)
					 GameTooltip:AddLine("左键:")
					 GameTooltip:AddSpellByID(self:GetAttribute("spell1"))
					 GameTooltip:AddLine("\n")
					 GameTooltip:AddLine("右键:")
					 GameTooltip:AddSpellByID(self:GetAttribute("spell2"))
					 GameTooltip:Show()
					end)
	button:SetScript("OnLeave", function(self) 
					 GameTooltip:Hide()
					end)
	button:SetScript("OnUpdate", function(self)
					 self:Show()
					end)
	button:SetBackdrop({bgFile = icon,
					   tile = false,
					   insets = {left = 0,
								 right = 0,
								 top = 0,
								 bottom = 0}})
	return button, x + 40
end

function PortalMage:ClearButtons()
	self:ClearButton(self.button1, 121)
	self:ClearButton(self.button2, 122)
	self:ClearButton(self.button3, 123)
	self:ClearButton(self.button4, 124)
	self:ClearButton(self.button5, 125)
	self:ClearButton(self.button6, 126)
end

function PortalMage:ClearButton(button, id)
	if button ~= nil then
		button:Hide()
		button:SetAttribute("showgrid", 0)
		button:SetAttribute("action", id)
		button:SetAttribute("type", "spell")
	end
end