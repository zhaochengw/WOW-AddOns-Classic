--[[
	上官晓雾
	2021年07月24日
	2.3.16

	重写了观察装等/天赋的模块
	添加观察史诗地下城分数
	优化了下地下城分数
	修复了添加地下城分数后版本导致敌对目标的关注目标不显示的问题
    修正了装备弩后装等错误的情况
]] --

--观察数据缓存到本地
--不太行，理论上数据会越来越对，占用的内存也会越来越多
local LocalCache = false

local _G = getfenv(0)
local format = string.format
local strfind = string.find
local gsub = string.gsub
local _, i, unit
--~ LoadAddOn("Blizzard_InspectUI")
local lastlinenum

local iLibRangeCheck
if (LibStub and LibStub.libs["LibRangeCheck-2.0"]) then
	iLibRangeCheck = LibStub("LibRangeCheck-2.0")
end

local HInspect = nil
zTip = CreateFrame("Frame", nil, GameTooltip)
-- Mixin(CreateFrame("Frame", "zTip", GameTooltip),HInspectMixin):Initialize()

-----------------默认设置修改处:
------生命、魔法条材质
local GameBarTexture1 = "Interface\\RAIDFRAME\\Raid-Bar-Hp-Fill.blp"
local GameBarTexture2 = "Interface\\TargetingFrame\\UI-TargetingFrame-BarFill"
function zTip:GetDefault()
	return {
		-- 以下为参数设置
		-- 提示: 取值只有两种 -- 1. 数字 2. true / false
		-- true 表示开启, false表示关闭

		Anchor = false, -- Default: 0
		-- [false 使用系统默认位置(屏幕右下角)]
		-- [0为人物信息跟随鼠标，非人物（按钮之类）使用默认位置（屏幕右下角）]
		-- [1为屏幕上方，注意用OffsetX和OffsetY调整相对位置，非人物为默认位置（屏幕右下角）]
		-- [2为跟随鼠标，向上延展，非人物为默认位置]
		-- [3为全部跟随鼠标，非人物(按钮之类)为对象右上]
		-- [4为屏幕上方，注意用OffsetX和OffsetY调整相对位置，非人物为对象右上]
		-- [5为全部跟随鼠标，并向上延展，要正上方，将Offset调为0,0即可]

		OffsetX = 30,
		OffsetY = 30, --位置偏移值（系统位置无效） Default: 30,30
		OrigPosX = 70,
		OrigPosY = 120, --系统默认位置的偏移值（原版X=100, Y=160），要使用游戏默认设置为: false, false
		Scale = 1.0, --提示缩放 Default: 1.1 取值：0~N.x		Game's Default: 1.0
		Fade = false, --是否渐隐 Default: false       游戏默认设置为: true
		DisplayPvPRank = true, --显示军衔[false 不显示 | true 显示] Default: false
		ShowIsPlayer = false, --是否在等级行显示“（玩家）”字样	Default: false
		DisplayFaction = true, --是否显示NPC声望等级。
		PlayerServer = true, --是否显示玩家所属服务器. Default: true
		TargetOfMouse = true, --显示对象的目标. Default: true
		TTargetOfMouse = false, --显示对象的目标的目标
		ClassIcon = true, --显示对象玩家/小宠物的职业/天赋图标。Default: true
		TalentIcon = false, --显示天赋图标
		CombatHide = false, --战斗中隐藏
		VividMask = true, --立体化鼠标提示. Default: true
		ShowTalent = false, --是否显示玩家天赋
		TargetedBy = false, --是否显示关注目标
		ManaBAR = false, --显示法力条
		HealthBAR = true, --显示法力条
		NPCClass = true, --显示NPC职业
		ItemLevel = true, --显示物品等级
		ShowFaction = false, --显示阵营字样(默认隐藏)
		ShowBarNum = false, --显示生命法力条数字
		BarTexture = true, --切换生命条材质
		GuildInfo = false,
		MiniNum = true,
		ShowRc = false --显示距离，如果有LibRangeCheck
	}
end

local function RGB(r, g, b)
	return string.format("%02x%02x%02x", r * 255, g * 255, b * 255)
end
local function GetRangeColorText(minRange, maxRange)
	local color, text
	if (minRange) then
		if (minRange > 100) then
			maxRange = nil
		end

		if (maxRange) then
			local tmpText = format("%d-%d", minRange, maxRange)

			if (maxRange <= 5) then
				color = RGB(0.9, 0.9, 0.9)
			elseif (maxRange <= 20) then
				color = RGB(0.055, 0.875, 0.825)
			elseif (maxRange <= 30) then
				color = RGB(0.035, 0.865, 0.0)
			elseif (minRange >= 40) then
				color = RGB(0.9, 0.055, 0.075)
			else
				color = RGB(1.0, 0.82, 0)
			end

			text = format(" |cff%s%s|r", color, tmpText)
		end
	end

	return text
end

function zTip:AddLine(line1, line2)
	if self.lastlinenum and self.lastlinenum < GameTooltip:NumLines() then
		self.lastlinenum = self.lastlinenum + 1
		_G["GameTooltipTextLeft" .. self.lastlinenum]:SetText(line1)
		if line2 then
			_G["GameTooltipTextRight" .. self.lastlinenum]:SetText(line2)
		end
	else
		if line2 then
			GameTooltip:AddDoubleLine(line1, line2)
		else
			GameTooltip:AddLine(line1)
		end
		self.lastlinenum = GameTooltip:NumLines()
	end
end

local cache_MythicPlusRating = {}
function DungeonsInTip(unit)
	if C_PlayerInfo and C_PlayerInfo.GetPlayerMythicPlusRatingSummary then
		if UnitIsPlayer(unit) and UnitLevel(unit) == MAX_PLAYER_LEVEL then
			local ratingSummary = C_PlayerInfo.GetPlayerMythicPlusRatingSummary(unit)
			local GUID = UnitGUID(unit)
			if not ratingSummary then
				ratingSummary = cache_MythicPlusRating[GUID]
			else
				cache_MythicPlusRating[GUID] = ratingSummary
			end
			if ratingSummary then
				local color = C_ChallengeMode.GetDungeonScoreRarityColor(ratingSummary.currentSeasonScore) or HIGHLIGHT_FONT_COLOR
				zTip:AddLine(
					"|cffffff00" .. DUNGEON_SCORE_TOTAL_SCORE:format(color:WrapTextInColorCode(ratingSummary.currentSeasonScore))
				)
				if IsControlKeyDown() then
					if ratingSummary and ratingSummary.runs then
						zTip:AddLine(" ")
						for key, value in pairs(ratingSummary.runs) do
							local leaderDungeonScoreInfo = value
							local color = C_ChallengeMode.GetSpecificDungeonOverallScoreRarityColor(leaderDungeonScoreInfo.mapScore)
							if (not color) then
								color = HIGHLIGHT_FONT_COLOR
							end
							local left = C_ChallengeMode.GetMapUIInfo(leaderDungeonScoreInfo.challengeModeID)
							local right = color:WrapTextInColorCode(leaderDungeonScoreInfo.mapScore)
							if (leaderDungeonScoreInfo.mapScore == 0) then
							elseif (leaderDungeonScoreInfo.finishedSuccess) then
								right = right .. "|cffffffff(" .. leaderDungeonScoreInfo.bestRunLevel .. ")"
							else
								right = right .. "|cff808080(" .. leaderDungeonScoreInfo.bestRunLevel .. ")"
							end
							zTip:AddLine(left, right)
						end
					end
				end
				GameTooltip:Show()
			end
		end
	end
end
function TargetedInTip(unit)
	local num = GetNumGroupMembers()
	if (num > 0) then
		local players, counter = "", 0
		for i = 1, num do
			local unit1 = (UnitName("raid" .. i) and "raid" .. i or "party" .. i)
			if (UnitIsUnit(unit1 .. "target", unit)) and (not UnitIsUnit(unit1, "player")) then
				if (mod(counter + 3, 6) == 0) then
					players = players .. "\n"
				end
				local color = RAID_CLASS_COLORS[select(2, UnitClass(unit1))]
				players = ("%s|cff%.2x%.2x%.2x%s|r, "):format(players, color.r * 255, color.g * 255, color.b * 255, UnitName(unit1))
				counter = (counter + 1)
			end
		end
		if (players ~= "") then
			zTip:AddLine(L["TargetedBy"] .. " (|cffffffff" .. counter .. "|r): " .. players:sub(1, -5))
		--~ 	--------------------------------------------
		-- if lastlinenum >= GameTooltip:NumLines() then
		-- 	GameTooltip:AddLine("zTip -- targetedby line")
		-- 	lastlinenum = GameTooltip:NumLines()
		-- 	print(213)
		-- else
		-- 	if zTipSaves.ShowTalent then
		-- 		lastlinenum = lastlinenum + 1
		-- 	end
		-- 	if zTipSaves.ItemLevel then
		-- 		lastlinenum = lastlinenum + 1
		-- 	end
		-- end
		-- text = _G["GameTooltipTextLeft" .. lastlinenum]
		-- if text then
		-- 	text:SetText(L["TargetedBy"] .. " (|cffffffff" .. counter .. "|r): " .. players:sub(1, -5))
		-- else
		-- 	--~ 					lastlinenum = nil
		-- end
		end
	end
end

function HSetTooltip(guid, gear, spec, flag)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit or UnitGUID(unit) ~= guid then
		return
	end
	zTip.lastlinenum = zTip.trueNum
	if zTipSaves.ItemLevel then
		if gear then
			local msg = "|cffffff00" .. HInspect.GearStr .. gear
			zTip:AddLine(msg)
		end
	end
	if zTipSaves.ShowTalent then
		if spec then
			local msg = "|cffffff00" .. HInspect.TalentStr .. spec
			zTip:AddLine(msg)
		end
	end
	zTip:SetTooltipOtherInfo(unit)
end
function zTip:SetTooltip_1(guid, gear, spec)
	local unit = select(2, GameTooltip:GetUnit())
	if not unit or UnitGUID(unit) ~= guid then
		return
	end
	local gearLine, specLine
	for i = 2, GameTooltip:NumLines() do
		local line = _G["GameTooltipTextLeft" .. i]
		local text = line:GetText()
		if text and strfind(text, self.GearStr) then
			gearLine = line
		elseif text and strfind(text, self.TalentStr) then
			specLine = line
		end
	end
	if zTipSaves.ItemLevel then
		if gear then
			local msg = "|cffffff00" .. self.GearStr .. gear
			if gearLine then
				gearLine:SetText(msg)
			else
				if specLine then
					specLine:SetText(msg)
					specLine = nil
				else
					GameTooltip:AddLine(msg)
				end
			end
		else
			if gearLine then
				gearLine:SetText()
			else
				if specLine then
					specLine:SetText()
					specLine = nil
				else
					GameTooltip:AddLine()
				end
			end
		end
	end
	if zTipSaves.ShowTalent then
		if spec then
			local msg = "|cffffff00" .. self.TalentStr .. spec
			if specLine then
				specLine:SetText(msg)
			else
				GameTooltip:AddLine(msg)
			end
		else
			if specLine then
				specLine:SetText(msg)
			else
				GameTooltip:AddLine(msg)
			end
		end
	end
	GameTooltip:Show()
end

zTipSaves = zTip:GetDefault()

-- 公会名和姓名的明暗度调整 Default: 0.86 暗一点（不可超过1！）
zTip.GuildColorAlpha = 0.86
local pet_r = 1
local pet_b = 0
local pet_g = 1

-- record player's factions standingId
zTip.factions = {}
---:一些函数:---
-- 颜色转换
function zTip:GetHexColor(color)
	if not color then
		-- elseif not color.colorStr then
		return "FFFFFF"
	else
		-- return color.colorStr
		return format("%2x%2x%2x", color.r * 255, color.g * 255, color.b * 255)
	end
end

--Hook：GameTooltip渐隐/功能有用，猜测正式服可能也有效
hooksecurefunc(
	GameTooltip,
	"FadeOut",
	function(self)
		if (not zTipSaves.Fade) then
			GameTooltip:Hide()
		end
	end
)

function zTip:SetTooltipOtherInfo(unit)
	if zTipSaves.ShowDungeons then
		DungeonsInTip(unit)
	end

	-- Add "Targeted By" line
	if zTipSaves.TargetedBy then
		TargetedInTip(unit)
	end

	GameTooltip:Show()
end
--[[	返回职业图标	]]
function zTip:GetClassIconForText(class, size)
	if not class then
		return
	end
	local classiconCoord = CLASS_ICON_TCOORDS[class]
	if classiconCoord then
		local a1, a2, a3, a4 =
			classiconCoord[1] * 100,
			classiconCoord[2] * 100,
			classiconCoord[3] * 100,
			classiconCoord[4] * 100
		local ed
		if size and tonumber(size) < 0 then
			ed = a2 .. ":" .. a1 .. ":" .. a3 .. ":" .. a4 .. "|t "
		else
			ed = a1 .. ":" .. a2 .. ":" .. a3 .. ":" .. a4 .. "|t "
		end
		return "|TInterface\\WorldStateFrame\\Icons-Classes:" .. (size or 12) .. ":" .. (size or 12) .. ":0:0:100:100:" .. ed
	end
end

---:遮罩:---
function zTip:GetVividMask()
	local mask = _G["GameTooltipMask"]
	if mask then
		return mask
	end

	mask = GameTooltip:CreateTexture("GameTooltipMask")
	mask:SetTexture("Interface\\Tooltips\\UI-Tooltip-Background")
	mask:SetPoint("TOPLEFT", GameTooltip, "TOPLEFT", 4, -4)
	mask:SetPoint("BOTTOMRIGHT", GameTooltip, "TOPRIGHT", -4, -30)
	mask:SetBlendMode("ADD")
	mask:SetGradientAlpha("VERTICAL", 0, 0, 0, 0, 1, 1, 1, 0.66)
	mask:Hide()

	return mask
end

local updateTooltip = 2
----
--Events
----
function zTip:OnUpdate(elapsed)
	-- offset to mouse
	if zTip.AnchorType then
		local x, y = GetCursorPosition()
		local uiscale = UIParent:GetScale()
		local tipscale = GameTooltip:GetScale()
		x = (x + zTipSaves.OffsetX) / tipscale / uiscale
		GameTooltip:ClearAllPoints()
		if zTip.AnchorType == 2 then
			y = (y + zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("BOTTOM", UIParent, "BOTTOMLEFT", x, y)
		else
			y = (y - zTipSaves.OffsetY) / tipscale / uiscale
			GameTooltip:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", x, y)
		end
	end

	if elapsed then
		if UnitExists("mouseover") then
			-- refresh target of mouseover
			zTip:RefreshMouseOverTarget(elapsed)
		elseif zTip.unit and not zTipSaves.Fade and GameTooltip:IsOwned(UIParent) then
			GameTooltip:Hide()
		elseif not GameTooltipTextLeft1:GetText() and not GameTooltipTextRight1:GetText() then
			GameTooltip:Hide()
		end
	end
end

function zTip:OnEvent(event, ...)
	if event == "PLAYER_LOGIN" then
		self:Init()
	elseif event == "PLAYER_LEAVING_WORLD" then
	elseif event == "PLAYER_ENTERING_WORLD" then
		GameTooltip:SetScale(zTipSaves.Scale)
	elseif event == "UPDATE_FACTION" then
		self:UpdatePlayerFaction()
	end
end
zTip:RegisterEvent("PLAYER_LOGIN")
zTip:SetScript("OnEvent", zTip.OnEvent)

----[[Initialize]]
function zTip:Init()
	zTipSaves.CacheData = zTipSaves.CacheData or {}
	if LocalCache then
		self.inspectDB = zTipSaves.CacheData
	else
		self.inspectDB = {}
	end

	HInspect = Mixin(CreateFrame("FRAME"), HInspectMixin):Init(self.inspectDB, L["ItemLevel"], nil, HSetTooltip)
	--加载一些额外功能

	---血量条动态变色（暴雪默认方案）
	-- local t=HealthBar_OnValueChanged
	-- HealthBar_OnValueChanged=function(self,value,smooth)
	-- t(self,value,true)
	-- end
	---修改系统函数，用途：改为美式/中式(简中)
	if zTipSaves.MiniNum then
		local ttAbbreviateLargeNumbers = AbbreviateLargeNumbers
		function AbbreviateLargeNumbers(...)
			local value = ...
			local strLen = strlen(value)
			local retString = value
			if (strLen > 8) then
				retString = string.sub(value, 1, -7) .. "M"
			elseif (strLen > 5) then
				retString = string.sub(value, 1, -4) .. "K"
			elseif (strLen > 3) then
				retString = BreakUpLargeNumbers(value)
			end
			return retString
		end
	end

	self:RegisterEvent("UPDATE_FACTION")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("PLAYER_LEAVING_WORLD")
	-- self:SetScript("OnUpdate", self.OnUpdate)
	GameTooltip:HookScript("OnUpdate", self.OnUpdate)
	-- Scripts

	GameTooltip:HookScript(
		"OnTooltipSetUnit",
		function(self, ...)
			zTip:OnTooltipSetUnit()
		end
	)

	GameTooltip:HookScript(
		"OnTooltipCleared",
		function(self)
			-- GameTooltip_ClearMoney(self)
			-- GameTooltip_ClearStatusBars(self)
			zTip:OnGameTooltipHide()
		end
	)

	-- HOOKs
	hooksecurefunc("GameTooltip_SetDefaultAnchor", zTip.SetDefaultAnchor)
	--GameTooltip_SetDefaultAnchor = zTip.SetDefaultAnchor
	--GameTooltip_UnitColor = function(unit)
	--	return zTip:UnitColor(unit)
	--end
	if zTipSaves.HealthBAR then
		GameTooltipStatusBar.pauseUpdates = false
	else
		GameTooltipStatusBar.pauseUpdates = true
	end

	if zTipSaves.VividMask then
		zTip:GetVividMask():Show()
	end

	-- Slash
	SLASH_ZTIPSLASH1 = "/ztip"
	SlashCmdList["ZTIPSLASH"] = function(msg)
		zTip:Slash(msg)
	end
end

--factions
local name, standingId, isHeader, isCollapsed
function zTip:UpdatePlayerFaction()
	for i = 1, GetNumFactions() do
		name, _, standingId, _, _, _, _, _, isHeader, isCollapsed, _ = GetFactionInfo(i)
		if name and not isHeader then
			self.factions[name] = standingId
		end
	end
end

local reaction  -- self var used in several functions
local gender = UnitSex("player")

-- get the formated faction name
local label, str
function zTip:GetUnitFaction(unit, reaction)
	reaction = reaction or UnitReaction(unit, "player")
	if not reaction then
		return ""
	end

	if reaction == 7 then
		for i = GameTooltip:NumLines(), 3, -1 do
			label = _G["GameTooltipTextLeft" .. i]:GetText()
			if label and label ~= PVP and self.factions[label] then
				reaction = self.factions[label]
				break
			end
		end
	end
	str = GetText("FACTION_STANDING_LABEL" .. reaction, gender)
	if reaction == 5 then
		str = format("|cff33CC33%s|r", str)
	elseif reaction == 6 then
		str = format("|cff33CCCC%s|r", str)
	elseif reaction == 7 then
		str = format("|cffFF6633%s|r", str)
	elseif reaction == 8 then
		--Add 4 lines. By YYSS
		str = format("|cffDD33DD%s|r", str)
	elseif reaction == 1 then
		str = format("|cffFF4444%s|r", str)
	elseif reaction == 2 then
		str = format("|cffFF0000%s|r", str)
	elseif reaction == 3 then
		str = format("|cffFF7744%s|r", str)
	elseif reaction == 4 then
		str = format("|cffFFCC00%s|r", str)
	end

	return str
end

--[[	Positions		]]
local x, y, uiscale, tipscale
function zTip:SetDefaultAnchor(parent)
	self:SetOwner(parent, "ANCHOR_NONE")
	if zTipSaves.OrigPosX and zTipSaves.OrigPosY then
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -zTipSaves.OrigPosX - 13, zTipSaves.OrigPosY)
	else
		self:SetPoint("BOTTOMRIGHT", "UIParent", "BOTTOMRIGHT", -CONTAINER_OFFSET_X - 13, CONTAINER_OFFSET_Y)
	end
	--self.default = 1;

	if zTipSaves.Anchor then
		if parent == UIParent then
			if zTipSaves.SelfUse and InCombatLockdown() then
				GameTooltip:ClearAllPoints()
				GameTooltip:SetPoint("TOPLEFT", UIParent, "TOPLEFT", CONTAINER_OFFSET_X - 80, CONTAINER_OFFSET_Y - 170)
				return
			end
			-- posiont will be set in update function
			if zTipSaves.Anchor == 0 or zTipSaves.Anchor == 3 then
				GameTooltip:ClearAllPoints()
				zTip.AnchorType = 1
			elseif zTipSaves.Anchor == 2 or zTipSaves.Anchor == 5 then
				GameTooltip:ClearAllPoints()
				zTip.AnchorType = 2
			end
			if UnitExists("mouseover") then
				if zTipSaves.Anchor == 1 or zTipSaves.Anchor == 4 then -- on top
					zTip.AnchorType = nil
					uiscale = UIParent:GetScale()
					tipscale = self:GetScale()
					x = zTipSaves.OffsetX / tipscale / uiscale
					y = zTipSaves.OffsetY / tipscale / uiscale
					self:ClearAllPoints()
					self:SetPoint("TOP", UIParent, "TOP", x, -y)
				else -- follow cursor [0,2,3,5]
				end
				--如果目标是unit,刷新一次
				zTip:OnUpdate() --鼠标跟随模式，修改位置
			else -- not unit 像是熔炉，信箱
				self:SetOwner(parent, "ANCHOR_CURSOR")
				zTip.AnchorType = nil
			end
		else -- not a unit tip, buttons or other
			if zTipSaves.Anchor > 2 or parent.unit and zTipSaves.Anchor ~= 0 then
				self:SetOwner(parent, "ANCHOR_RIGHT")
			else -- use default anchor (BottomRight to Screen)
			end
			if zTipSaves.Anchor == 2 then
				zTip.AnchorType = 2
			end
		end
	else -- use deault
	end
end

local unit, guid
local bplayer, bdead, tapped
local text, levelline, tmp, tmp2
local unitrace, unitCreatureType
local guild, guildrank, guildid
local bbattlepet
local targetlinenum
local found, trueNum
--[[ MouseOver Target 目标]]
local mouseTarget, mouseTTarget
local function GetTarget(unit, tname, ic)
	local tip, name
	local unittarget = unit .. "target"
	name = UnitName(unittarget)
	if name ~= tname then
		tname = name or UNKNOWNOBJECT
		local tmp, tmp2 = nil, nil
		--~ 		local punit = gsub(unit,"target","")
		--~ 		if not (punit~="target" and UnitExists(punit)) then punit = nil end

		tip = format("|cffFFFF00%s [|r", ic and "-->" or L["Targeting"]) -- '['
		-->>>
		-- 指向我自己
		if UnitIsUnit(unittarget, "player") then
			-- 指向他自己
			tip = format("%s |c00FF0000%s|r", tip, L["YOU"])
		elseif unit and UnitIsUnit(unittarget, unit) then
			-- 指向其它玩家
			tip = format("%s |cffFFFFFF%s|r", tip, L["Self"])
		elseif UnitIsPlayer(unittarget) then
			tmp, tmp2 = UnitClass(unittarget)
			if UnitIsEnemy(unittarget, "player") then
				-- red enemy player
				tip =
					format(
					"%s |cffFF0000%s|r |cff%s(%s)|r",
					tip,
					tname,
					zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]),
					zTip:GetClassIconForText(tmp2, -1) or nil
				)
			else
				-- white friend player
				tip =
					format(
					"%s |cff%s%s|r |cffFFFFFF(%s)|r",
					tip,
					zTip:GetHexColor(RAID_CLASS_COLORS[(tmp2 or "")]),
					tname,
					zTip:GetClassIconForText(tmp2, -1) or nil
				)
			end
		else
			tip = format("%s |cffFFFFFF%s|r", tip, tname)
		end
		-->>>
		tip = format("%s |cffFFFF00]|r", tip) -- ']'
	end
	return tip, tname
end
local function SetMouseTarget(text)
	local result
	if not UnitExists(zTip.unittarget) then
		mouseTarget = nil
		result = nil
	else
		local tip
		tip, mouseTarget = GetTarget(zTip.unit, mouseTarget)

		if tip then
			result = tip
		end
	end
	return result
end
local function SetMouseTTarget(text)
	local result
	if not zTip.unittarget or not UnitExists(zTip.unittarget .. "target") then
		mouseTTarget = nil
		result = nil
	else
		local tip
		tip, mouseTTarget = GetTarget(zTip.unittarget, mouseTTarget, true)
		if tip then
			result = tip
		end
	end
	return result
end
--[[	目标刷新		]]
function zTip:RefreshMouseOverTarget(elapsed)
	-- timer, refresh every 0.5s
	self.timer = (self.timer or 0.1) + elapsed
	if self.timer < 0.1 then
		return
	end
	self.timer = 0

	if not zTipSaves.TargetOfMouse then
		return
	end
	if not targetlinenum then
		return
	end

	local text
	text = _G["GameTooltipTextLeft" .. targetlinenum]
	if not text then
		return
	end

	text.dtxtt = SetMouseTarget(text)

	if zTipSaves.TTargetOfMouse then
		text.dtxttt = SetMouseTTarget(text)
	else
		text.dtxttt = nil
	end

	if text.dtxtt then
		text:SetText(text.dtxtt .. (text.dtxttt or ""))
		text:Show()
		GameTooltip:Show()
	end
end

--[[	设置目标		]]
function zTip:OnTooltipSetUnit()
	--~ 	BOSS战中隐藏
	if zTipSaves.CombatHide and UnitExists("boss1") then
		GameTooltip:Hide()
	end

	zTip:OnMouseOverUnit(GameTooltip:GetUnit())
	if zTip.unit then
		if not zTipSaves.HealthBAR then
			GameTooltipStatusBar:Hide()
		end
		zTip.unittarget = zTip.unit .. "target"
	end
end

--[[	清理目标目标	]]
function zTip:OnGameTooltipHide()
	targetlinenum = nil
	self.trueNum = nil
	mouseTarget = nil
	mouseTTarget = nil
	zTip.AnchorType = nil
	zTip.timer = nil
	zTip.unit = nil
	zTip.unittarget = nil
	if zTip.icon then
		zTip.icon:Hide()
	end
	if zTip.peticon then
		zTip.peticon:Hide()
	end
	if zTip.talenticon then
		zTip.talenticon:Hide()
	end
end

--[[	第一行名字上色 	]]
local DEFCOLOR = {r = 0.5, g = 0.5, b = 1.0}
function zTip:UnitColor(unit, bdead, tapped, reaction, bbattlepet)
	bdead = bdead or UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = tapped or UnitIsTapDenied(unit)
	reaction = reaction or UnitReaction(unit, "player")
	local ISPLAYER = UnitIsPlayer(unit)
	local r, g, b
	if tapped or bdead then
		r = 0.55
		g = 0.55
		b = 0.55
	elseif bbattlepet then
		r, g, b = 0.8, 0.5, 0.8
	elseif ISPLAYER or UnitPlayerControlled(unit) then
		if (UnitCanAttack(unit, "player")) then
			if (not UnitCanAttack("player", unit)) then
				--purple, caution, only they can attack
				r = 1.0
				g = 0.4
				b = 1.0
			else
				-- Hostile players are red
				r = 1.0
				g = 0.0
				b = 0.0
			end
		elseif (UnitCanAttack("player", unit)) then
			-- elseif (UnitIsPVP(unit) and not UnitIsPVPSanctuary(unit) and not UnitIsPVPSanctuary("player")) then
			-- -- Players we can assist but are PvP flagged are green
			-- r = 0.0;g = 1.0;b = 0.0
			-- Players we can attack but which are not hostile are yellow
			r = 1.0
			g = 1.0
			b = 0.0
		else
			local color = ISPLAYER and RAID_CLASS_COLORS[select(2, UnitClass(unit))] or DEFCOLOR
			r, g, b = color.r, color.g, color.b
		end
	elseif reaction then
		-- mob/npc
		if reaction < 4 then -- harm
			r, g, b = 1, 0.3, 0.22
		elseif reaction > 4 then -- friendly
			r, g, b = 0, 1, 0
		else -- nature
			r, g, b = 1, 1, 0
		end
	else -- normal
		r, g, b = 1, 1, 1
	end
	return r, g, b
end

--[[	修改tip整体格式 ]]
local tip
function zTip:OnMouseOverUnit(name, unit)
	zTip.unit = unit
	if not unit then
		return
	end
	-- hack to fix problems
	if unit == "npc" then
		unit = "mouseover"
	end
	--[[
	local values and initials
--]]
	bplayer = UnitIsPlayer(unit)
	name = name or UnitName(unit)
	guid = UnitGUID(unit)
	--~ 是否是战宠
	bbattlepet = UnitIsWildBattlePet and (UnitIsWildBattlePet(unit) or UnitIsBattlePetCompanion(unit))
	--~ 尸体，排除猎人假死
	bdead = UnitHealth(unit) <= 0 and (not bplayer or UnitIsDeadOrGhost(unit))
	tapped = UnitIsTapDenied(unit)

	-- 1 憎恨 2 敌对 3 冷淡 4 中立 5 友好 6 尊敬 7 崇敬/崇拜
	reaction = UnitReaction(unit, "player")

	local OldName = _G[GameTooltip:GetName() .. "TextLeft1"]:GetText()
	--[[
	New Way
--]]
	tip, text, levelline, tmp, tmp2 = nil, nil, nil, nil, nil
	local pvplinenum, factlinenum = nil, nil
	--[[ Serch and Delete ]]
	self.trueNum = GameTooltip:NumLines()
	self.lastlinenum = self.trueNum
	for i = 2, self.trueNum do
		text = _G[GameTooltip:GetName() .. "TextLeft" .. i]
		tip = text:GetText()
		if tip then
			--~ 查找等级行
			if not levelline and (strfind(tip, LEVEL) or strfind(tip, "Pet Level")) then
				-- 删除阵营字符
				levelline = i
			elseif not zTipSaves.ShowFaction and (tip == FACTION_ALLIANCE or tip == FACTION_HORDE) then
				-- 删除PVP字符
				text:SetText()
				-- foundfact = true
				factlinenum = i
				--~ 				_G["GameTooltipTextLeft"..i]:Hide()
				self.lastlinenum = self.lastlinenum - 1
			elseif tip == PVP then
				-- 能否驯服
				text:SetText()
				pvplinenum = i
				self.lastlinenum = self.lastlinenum - 1
			elseif tip == TAMEABLE then
				text:SetText(format("|cff00FF00%s|r", tip))
			elseif tip == NOT_TAMEABLE then
				text:SetText(format("|cffFF6035%s|r", tip))
			end
		end
	end
	self.trueNum = self.lastlinenum
	-- insert target line
	if zTipSaves.TargetOfMouse then
		self:AddLine("zTip -- target line")
		-- if lastlinenum >= GameTooltip:NumLines() then
		-- 	GameTooltip:AddLine("zTip -- target line")
		-- 	targetlinenum = GameTooltip:NumLines()
		-- else
		-- 	targetlinenum = lastlinenum + 1
		-- end
		-- lastlinenum = targetlinenum
		text = _G["GameTooltipTextLeft" .. self.lastlinenum]
		if text then
			targetlinenum = self.lastlinenum
			self.trueNum = self.lastlinenum
			-- end
			-- text.dtxtt = SetMouseTarget(text)

			-- if zTipSaves.TTargetOfMouse then
			-- text.dtxttt=SetMouseTTarget(text)
			-- else
			-- text.dtxttt=nil
			-- end

			-- if text.dtxtt then
			-- text:SetText(text.dtxtt..(text.dtxttt or ""))
			-- else
			text:SetText()
		else
			targetlinenum = nil
		end
	end
	-- if false and bplayer and UnitLevel(unit) > 0 and CheckInteractDistance(unit, 1) and CanInspect(unit,true) then
	-- and not UnitCanAttack("player", unit)
	---尝试下敌对阵营中立区域能不能观察
	-- _G.print(CheckInteractDistance(unit, 1))
	if bplayer then
		if zTipSaves.ItemLevel or zTipSaves.ShowTalent then
			if bplayer and UnitLevel(unit) > 9 then
				if self.ScanIns then
					self:ScanIns(unit)
				end
				if HInspect.ScanIns then
					HInspect:ScanIns(unit)
				end
			end
		end
	else
		self:SetTooltipOtherInfo(unit)
	end
	--[[ 等级行涂改 ]]
	if levelline then
		-- 表示 等级,尸体(如果死亡)
		if bbattlepet then
			tmp = UnitBattlePetLevel(unit)
			tmp2 = format(TOOLTIP_WILDBATTLEPET_LEVEL_CLASS, "", "")
		else
			tmp = UnitLevel(unit)
			tmp2 = ""
		end

		if bdead then
			if tmp > 0 then
				tmp2 = format("|cff888888%d %s|r", tmp, CORPSE)
			else
				tmp2 = format("|cff888888?? %s|r", CORPSE)
			end
		elseif (tmp > 0) then
			-- Color level number
			if UnitCanAttack("player", unit) or UnitCanAttack(unit, "player") then
				tmp2 = format("%s%d|r", HTool.GetDifficultyColor(tmp), tmp)
			else
				-- normal color
				tmp2 = format("%s|cff3377CC%d|r", tmp2, tmp)
			end
		else
			-- Target is too high level to tell
			tmp2 = "|cffFF0000 ??|r"
		end

		-- 种族, 职业/ creature type/ creature family(pet)
		unitrace = UnitRace(unit)
		unitCreatureType = UnitCreatureType(unit)
		if unitrace and bplayer then
			--race, it is a player
			if UnitFactionGroup(unit) == UnitFactionGroup("player") then
				tmp = "00FF33"
			else
				tmp = "FF3300" -- 敌对阵营种族为暗红
			end
			tmp2 = format("%s |cff%s%s|r", tmp2, tmp, unitrace)
			-- class
			_, tmp = UnitClass(unit)
			local c = RAID_CLASS_COLORS[(tmp or "")]
			-- if(c) then
			-- GameTooltip:SetBackdropBorderColor(c.r,c.g,c.b)
			-- end
			tmp = zTip:GetHexColor(c)
			tmp2 = format("%s |cff%s%s|r ", tmp2, tmp, _)
		elseif UnitPlayerControlled(unit) or bbattlepet then
			--creature family, its is a pet
			if bbattlepet then --判断是否是战斗宠物
				-- petType
				local petType = UnitBattlePetType(unit)
				if (petType) then
					tmp = _G["BATTLE_PET_NAME_" .. petType]
					tmp2 = format("%s %s ", tmp2, tmp or "")
				end
			else
				tmp2 = format("%s %s ", tmp2, (UnitCreatureFamily(unit) or unitCreatureType or ""))
			end
		elseif unitCreatureType then
			--creature type, it is a mob or npc
			if unitCreatureType == L["NotSpecified"] then
				unitCreatureType = L["Specified"]
			end --"未指定"替换为更通顺的"神秘物种"
			tmp2 = format("%s |cffFFFFFF%s|r", tmp2, unitCreatureType)
			if zTipSaves.NPCClass then
				local SYSCType, SYSCID = select(2, UnitClass(unit))
				tmp2 =
					format(
					"%s |cff%s%s|r",
					tmp2,
					zTip:GetHexColor(RAID_CLASS_COLORS[SYSCType]),
					C_CreatureInfo.GetClassInfo(SYSCID).className
				)
			end
			if zTipSaves.DisplayFaction and reaction and reaction > 0 then
				tmp2 = format("%s %s ", tmp2, zTip:GetUnitFaction(unit, reaction))
			end
		else
			tmp2 = format("%s %s ", tmp2, UKNOWNBEING)
		end
		if zTipSaves.ShowRc and not bplayer and iLibRangeCheck then --距离
			local minRange, maxRange = iLibRangeCheck:getRange(unit)
			local text = GetRangeColorText(minRange, maxRange)
			if (text) then
				tmp2 = tmp2 .. text
			end
		end
		tip = tmp2

		-- special info
		tmp = nil
		tmp2 = ""
		if bplayer then
			if zTipSaves.ShowIsPlayer then
				tmp2 = format("(%s)", PLAYER)
			end
		elseif not UnitPlayerControlled(unit) then
			tmp = UnitClassification(unit) -- Elite status
			--if tmp and tmp ~= "normal" and UnitHealth(unit) > 0 then
			if tmp and tmp ~= "normal" then
				if tmp == "elite" then
					tmp2 = format("|cffFFFF33(%s)|r", ELITE)
				elseif tmp == "worldboss" then
					tmp2 = format("|cffFF0000(%s)|r", BOSS)
				elseif tmp == "rare" then
					tmp2 = format("|cffFF66FF(%s)|r", L["Rare"])
				elseif tmp == "rareelite" then
					tmp2 = format("|cffFFAAFF(%s%s)|r", L["Rare"], ELITE)
				else
					tmp2 = format("(%s)", tmp) -- unknown type
				end
			end
		end
		_G["GameTooltipTextLeft" .. levelline]:SetText(format("%s%s", tip, tmp2))
	end

	--[[ First Line, rewrite name ]]
	if bplayer or bbattlepet then
		-- 军衔
		tip = ""
		if not zTipSaves.DisplayPvPRank then
			GameTooltipTextLeft1:SetText(format("%s%s", tip, name))
		else
			GameTooltipTextLeft1:SetText(format("%s%s", tip, (UnitPVPName(unit) or name)))
		end
	end

	--[[ Second Line, Rewrite / Insert guild and/or realm name ]]
	tip = nil
	guild, guildrank, guildid = GetGuildInfo(unit)
	if bplayer then
		-- 工会
		if guild then
			-- if #guildrank > 6 then guildrank = guildrank:sub(1,6)..".." end
			tip = "<" .. guild .. "> " .. (zTipSaves.GuildInfo and (guildrank .. "(" .. guildid .. ")") or "")
		end
		-- 服务器
		_, tmp = UnitName(unit)
		if zTipSaves.PlayerServer and (tmp and tmp ~= "" or tip) then
			if tmp and tip then
				tmp2 = " @ "
			else
				tmp2 = ""
			end
			tip = format("%s|cff00EEEE%s%s|r", tip or "", tmp2, tmp or "")
		end
		if tip then
			if guild then
				GameTooltipTextLeft2:SetText(tip)
			else
				GameTooltipTextLeft1:SetText(GameTooltipTextLeft1:GetText() .. " - " .. tmp)
			end
		end
	end

	-- classicon
	local cicon = ""
	if zTipSaves.ClassIcon then
		if bbattlepet then
			local petType = UnitBattlePetType(unit)
			if (petType) then
				cicon = "|TInterface\\Icons\\Pet_TYPE_" .. PET_TYPE_SUFFIX[petType] .. ":12:12:0:0:10:10:0:10:0:10|t "
			end
		elseif unitrace and bplayer then
			local cls = select(2, UnitClass(unit))
			cicon = zTip:GetClassIconForText(cls)
		end
	end

	--[[ Colors ]]
	--~ 第一行名字上色，并调整第一行
	local r, g, b = zTip:UnitColor(unit, bdead, tapped, reaction, bbattlepet)
	if bbattlepet then
		GameTooltipTextLeft1:SetText(cicon .. OldName)
	else
		local isafk = UnitIsAFK(unit)
		GameTooltipTextLeft1:SetText(
			cicon ..
				format("|cff%2x%2x%2x", r * 255, g * 255, b * 255) ..
					GameTooltipTextLeft1:GetText() .. "|r" .. (isafk and "<" .. AFK .. ">" or "")
		)
	end

	--~ 给第二行上色
	if tip or (levelline and levelline > 2) then
		if bdead or tapped then -- 尸体或已被攻击
			GameTooltipTextLeft2:SetTextColor(0.55, 0.55, 0.55)
		elseif bbattlepet then
			if levelline ~= 3 then
				GameTooltipTextLeft1:SetTextColor(pet_r, pet_g, pet_b)
				----宠物修改名颜色
				GameTooltipTextLeft2:SetTextColor(r, g, b)
			end
		else
			GameTooltipTextLeft2:SetTextColor(r * zTip.GuildColorAlpha, g * zTip.GuildColorAlpha, b * zTip.GuildColorAlpha)
		end
	end
	--~ 标记本工会为亮色
	--	if bplayer and guild == GetGuildInfo("player") then
	--		GameTooltipTextLeft2:SetTextColor(0.9, 0.5, 0.9)
	--	end
	if bplayer and guild then
		if guild == GetGuildInfo("player") then
			GameTooltipTextLeft2:SetTextColor(0.9, 0.5, 0.9)
		else
			GameTooltipTextLeft2:SetTextColor(1.0, 1.0, 1.0)
		end
	end

	--[[
	done
--]]
	for el = GameTooltip:NumLines(), 1, -1 do
		if not _G["GameTooltipTextLeft" .. el]:GetText() then
			_G["GameTooltipTextLeft" .. el]:Hide()
		else
			break
		end
	end
	return unit
end

--[[	Slash Command	]]
function zTip:Slash(msg)
	local param1 = string.lower(msg)
	if (param1 == "cc") then --/ztip cc清空天赋缓存
		wipe(self.inspectDB)
		collectgarbage("collect")
		self.inspectDB = {}
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r " .. L["ResetCache"], 1, 1, 0)
	elseif (param1 == "pp") then
		local n = 0
		for k, v in pairs(self.inspectDB) do
			n = n + 1
		end
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r inspectDB=" .. n)
	else
		collectgarbage("collect")
		UpdateAddOnMemoryUsage()
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r Toggle Option Window", 1, 1, 0)
		DEFAULT_CHAT_FRAME:AddMessage("|cff00FFFFzTip:|r " .. format("%.2f", GetAddOnMemoryUsage("zTip")) .. " KB", 1, 1, 0)
		if not zTipOption then
			return
		end
		if not zTipOption.ready then
			zTipOption:Init()
		end
		if not zTipOption:IsShown() then
			zTipOption:Show()
		end
	end
end

---- ID
local select, UnitBuff, UnitDebuff, UnitAura, tonumber, strfind, hooksecurefunc =
	select,
	UnitBuff,
	UnitDebuff,
	UnitAura,
	tonumber,
	strfind,
	hooksecurefunc

local function addLine(self, id, isItem)
	if id and IsAltKeyDown() then
		if isItem then
			self:AddDoubleLine(ITEMS .. "ID:", "|cffffffff" .. tostring(id))
		else
			self:AddDoubleLine(SPELLS .. "ID:", "|cffffffff" .. tostring(id))
		end
		self:Show()
	end
end

-- Spell Hooks ----------------------------------------------------------------
hooksecurefunc(
	GameTooltip,
	"SetUnitBuff",
	function(self, ...)
		local id = select(10, UnitBuff(...))
		if id then
			addLine(self, id)
		end
	end
)

hooksecurefunc(
	GameTooltip,
	"SetUnitDebuff",
	function(self, ...)
		local id = select(10, UnitDebuff(...))
		if id then
			addLine(self, id)
		end
	end
)

hooksecurefunc(
	GameTooltip,
	"SetUnitAura",
	function(self, ...)
		local id = select(10, UnitAura(...))
		if id then
			addLine(self, id)
		end
	end
)

GameTooltip:HookScript(
	"OnTooltipSetSpell",
	function(self)
		local id = select(2, self:GetSpell())
		if id then
			addLine(self, id)
		end
	end
)

hooksecurefunc(
	"SetItemRef",
	function(link, ...)
		local id = tonumber(link:match("spell:(%d+)"))
		if id then
			addLine(ItemRefTooltip, id)
		end
	end
)

-- Item Hooks -----------------------------------------------------------------

local function attachItemTooltip(self)
	local link = select(2, self:GetItem())
	if not link then
		return
	end
	local id = tonumber(link:match("item:(%d+)"))
	if id then
		addLine(self, id, true)
	end
end

GameTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefTooltip:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip1:HookScript("OnTooltipSetItem", attachItemTooltip)
ShoppingTooltip2:HookScript("OnTooltipSetItem", attachItemTooltip)

if PaperDollFrame_SetItemLevel then
	--- 角色界面数字 ---
	hooksecurefunc(
		"PaperDollFrame_SetItemLevel",
		function(self, unit)
			if (unit ~= "player") then
				return
			end

			local total, equip = GetAverageItemLevel()
			if (total > 0) then
				total = string.format("%.1f", total)
			end
			if (equip > 0) then
				equip = string.format("%.1f", equip)
			end

			local ilvl = equip
			if ((tonumber(equip) or 0) < (tonumber(total) or 0)) then
				ilvl = (equip or 0) .. " / " .. (total or 0)
			end

			-- local ilvlLine = _G[self:GetName() .. 'StatText']
			CharacterStatsPane.ItemLevelFrame.Value:SetText(ilvl)

			self.tooltip = "|cffffffff" .. STAT_AVERAGE_ITEM_LEVEL .. " " .. ilvl
		end
	)
end
