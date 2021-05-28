local _G = getfenv(0);			-- TT_LevelMatch
local unpack = unpack;
local UnitName = UnitName;
local GetQuestGreenRange = GetQuestGreenRange;
local gtt = GameTooltip;

-- TipTac refs
local tt = TipTac;
local cfg;

-- element registration
local ttStyle = tt:RegisterElement({},"Style");

-- vars
local lineName = tt:CreatePushArray();
local lineInfo = tt:CreatePushArray();

-- String Constants
local TT_LevelMatch = "^"..TOOLTIP_UNIT_LEVEL:gsub("%%[^s ]*s",".+"); -- Was changed to match other localizations properly, used to match: "^"..LEVEL.." .+" -- Doesn't actually match the level line on the russian client! [14.02.24] Doesn't match for Italian client either. [18.07.27] changed the pattern, might match non-english clients now
local TT_LevelMatchPet = "^"..TOOLTIP_WILDBATTLEPET_LEVEL_CLASS:gsub("%%[^s ]*s",".+");	-- "^Pet Level .+ .+"
local TT_NotSpecified = "Not specified";
local TT_Targeting = BINDING_HEADER_TARGETING;	-- "Targeting"
local TT_Reaction = {
	"Tapped",					-- No localized string of this
	FACTION_STANDING_LABEL2,	-- Hostile
	FACTION_STANDING_LABEL3,	-- Unfriendly (Caution)
	FACTION_STANDING_LABEL4,	-- Neutral
	FACTION_STANDING_LABEL5,	-- Friendly
	FACTION_STANDING_LABEL5,	-- Friendly (Exalted)
	DEAD,						-- Dead
};

-- colors
local COL_WHITE = "|cffffffff";
local COL_LIGHTGRAY = "|cffc0c0c0";
local COL_GRANK = "|cFF777777";

--------------------------------------------------------------------------------------------------------
--                                           Style Tooltip                                            --
--------------------------------------------------------------------------------------------------------

-- Returns the correct difficulty color compared to the player
-- Az: Check out GetCreatureDifficultyColor, GetQuestDifficultyColor, GetScalingQuestDifficultyColor, GetRelativeDifficultyColor
local function GetDifficultyLevelColor(level)
	level = (level - tt.playerLevel);
	if (level > 4) then
		return "|cffff2020"; -- red
	elseif (level > 2) then
		return "|cffff8040"; -- orange
	elseif (level >= -2) then
		return "|cffffff00"; -- yellow
	elseif (level >= -GetQuestGreenRange()) then
		return "|cff40c040"; -- green
	else
		return "|cff808080"; -- gray
	end
end

-- Add target
local function AddTarget(lineList,target,targetName)
	if (UnitIsUnit("player",target)) then
		lineList.next = COL_WHITE;
		lineList.next = cfg.targetYouText;
	else
		local targetReaction = cfg["colReactText"..tt:GetUnitReactionIndex(target)];
		lineList.next = targetReaction;
		lineList.next = "[";
		if (UnitIsPlayer(target)) then
			local _, targetClassID = UnitClass(target);
			lineList.next = (tt.ClassColorMarkup[targetClassID] or COL_LIGHTGRAY);
			lineList.next = targetName;
			lineList.next = targetReaction;
		else
			lineList.next = targetName;
		end
		lineList.next = "]";
	end
end

-- TARGET
function ttStyle:GenerateTargetLines(unit,method)
	local target = unit.."target";
	local targetName = UnitName(target);
	if (targetName) and (targetName ~= UNKNOWNOBJECT and targetName ~= "" or UnitExists(target)) then
		if GetFakeName~=nil then targetName=GetFakeName(targetName,"TipTacStyle:GenTargetLines") end -- DaMaGepy		
		if (method == "first") then
			lineName.next = COL_WHITE;
			lineName.next = " : |r";
			AddTarget(lineName,target,targetName);
		elseif (method == "second") then
			lineName.next = "\n  ";
			AddTarget(lineName,target,targetName);
		elseif (method == "last") then
			lineInfo.next = "\n|cffffd100";
			lineInfo.next = TT_Targeting;
			lineInfo.next = ": ";
			AddTarget(lineInfo,target,targetName);
		end
	end
end


-- DaMaGepy's PvP title stuffs
function GepyPvPTitles (gpnname,gpunit)
	local rankID = UnitPVPRank(gpunit)
	local gName = gpnname.name;
	local gPvPrank = 0
	local gPvPtitle = ""
	local gClassColor = (cfg.colorNameByClass and (tt.ClassColorMarkup[gpnname.classID] or COL_WHITE) or gpnname.reactionColor);
	local gRankCol="|cFF776666";
	local gRankNum=""
	local GPT = gClassColor..gName; -- normal name
	-- Generate pvptitle, rank and name texts...
	if rankID~=nil then
		if rankID>4 then
			local grankName, grankNumber = GetPVPRankInfo(rankID)
			local gPvPName = UnitPVPName(gpunit)
			if gPvPName~=nil then gPvPtitle = string.gsub(gPvPName," "..gName,""); -- removing the name, leaving only the pvptitle (so other faction's shows up well)
							 else gPvPtitle=grankName; end 
			if grankNumber~=nil then gPvPrank=grankNumber else gPvPrank=rankID-4; end
			gPvPtitle="|cFF776666"..gPvPtitle.." ";
			gRankNum = "|cFF555555(|cFFCC7777"..(gPvPrank).."|cFF555555)"  -- (#)
		end
	end
	if GetFakeName~=nil then gName=GetFakeName(gName,"TipTacStyle:GenPlayerLines") end -- DaMaGepy

	-- Name Display type (Options / General / Name Type)
	if cfg.nameType == "original" then 
		GPT = gClassColor..gpnname.originalName
	elseif cfg.nameType == "marysueprot" then 
		GPT = gClassColor..gpnname.rpName
	elseif cfg.nameType == "title" then 
		GPT = gPvPtitle..gClassColor..gName;
	elseif cfg.nameType == "pvptitlerank" then 
		GPT = gPvPtitle..gClassColor..gName.." "..gRankNum;
	elseif cfg.nameType == "pvpnum" then 
		GPT = gClassColor..gName.."  "..gRankNum;
	elseif cfg.nameType == "pvprank" then 
		GPT = gClassColor..gName.." "..gRankNum.." "..gPvPtitle;
	end

	-- Realmname (Options / General / Show Unit Realm)
	if (gpnname.realm) and (gpnname.realm ~= "") and (cfg.showRealm ~= "none") then
		if (cfg.showRealm == "show") then
			GPT = GPT.."|cFF666666 - "..gpnname.realm;
		else
			GPT = GPT.."|cFF666666 (*)";
		end
	end

	return GPT;
end



-- PLAYER Styling
function ttStyle:GeneratePlayerLines(u,first,unit)
	-- gender	
	if (cfg.showPlayerGender) then
		local sex = UnitSex(unit);
		if (sex == 2) or (sex == 3) then
			lineInfo.next = " ";
			lineInfo.next = cfg.colRace;
			lineInfo.next = (sex == 3 and FEMALE or MALE);
		end
	end	
	--local guild, guildRank = GetGuildInfo(unit); if (guild==nil) then guild="??"; end; DEFAULT_CHAT_FRAME:AddMessage("--- "..u.name..": "..UnitLevel(unit).." "..UnitRace(unit).." "..u.class.."   <"..guild..">|r");
	-- race
	lineInfo.next = " ";
	lineInfo.next = cfg.colRace;
	lineInfo.next = UnitRace(unit);	
	-- class
	lineInfo.next = " ";
	lineInfo.next = (tt.ClassColorMarkup[u.classID] or COL_WHITE);
	lineInfo.next = u.class;
	-- name
	lineName.next = GepyPvPTitles(u,unit); -- DaMaGepy custom (PvP) titles...
	
	-- dc, afk or dnd
	if (cfg.showStatus) then
		local status = (not UnitIsConnected(unit) and " <DC>") or (UnitIsAFK(unit) and " <AFK>") or (UnitIsDND(unit) and " <DND>");
		if (status) then
			lineName.next = COL_WHITE;
			lineName.next = status;
		end
	end	
	-- guild
	if (cfg.showTTguildAfter) then -- DaMaGepy
		local guild, guildRank = GetGuildInfo(unit);
		if (guild) then
			local pGuild = GetGuildInfo("player");
			local guildColor = (guild == pGuild and cfg.colSameGuild or cfg.colorGuildByReaction and u.reactionColor or cfg.colGuild);
			lineInfo.next = "\n"..guildColor.."<"..guild..">"; -- DaMaGepy Fix
			if cfg.showGuildRank and guildRank then lineInfo.next = " "..COL_GRANK..guildRank; end
			GameTooltipTextLeft2:SetFormattedText(cfg.showGuildRank and guildRank and "%s<%s> %s%s" or "%s<%s>",guildColor,guild,COL_GRANK,guildRank);
			--lineInfo.Index = (lineInfo.Index + 1);		
		end
	end
	
	--[[
	if (guild) then
		local pGuild = GetGuildInfo("player");
		local guildColor = (guild == pGuild and cfg.colSameGuild or cfg.colorGuildByReaction and u.reactionColor or cfg.colGuild);
		GameTooltipTextLeft2:SetFormattedText(cfg.showGuildRank and guildRank and "%s<%s> %s%s" or "%s<%s>",guildColor,guild,COL_LIGHTGRAY,guildRank);
		lineInfo.Index = (lineInfo.Index + 1);		
	end
	]]--
end

-- PET Styling
function ttStyle:GeneratePetLines(u,first,unit)
	lineName.next = u.reactionColor;	
	if GetFakeName~=nil then u.name=GetFakeName(u.name,"TipTacStyle:GenPetLines") end -- DaMaGepy
	lineName.next = u.name;
	
	lineInfo.next = " ";
	lineInfo.next = cfg.colRace;
	local petType = UnitBattlePetType(unit) or 5;
	lineInfo.next = _G["BATTLE_PET_NAME_"..petType];

	if (u.isPetWild) then
		lineInfo.next = " ";
		lineInfo.next = UnitCreatureFamily(unit) or UnitCreatureType(unit);
	else
		if not (self.petLevelLineIndex) then
			for i = 2, gtt:NumLines() do
				local gttLineText = _G["GameTooltipTextLeft"..i]:GetText();
				if (type(gttLineText) == "string") and (gttLineText:find(TT_LevelMatchPet)) then
					self.petLevelLineIndex = i;
					break;
				end
			end
		end
		lineInfo.Index = self.petLevelLineIndex or 2;
		local expectedLine = 3 + (tt.isColorBlind and 1 or 0);
		if (lineInfo.Index > expectedLine) then
			GameTooltipTextLeft2:SetFormattedText("%s<%s>",u.reactionColor,u.title);
		end
	end
end

-- NPC Styling
function ttStyle:GenerateNpcLines(u,first,unit)
	-- name
	lineName.next = u.reactionColor;
	if GetFakeName~=nil then u.name=GetFakeName(u.name,"TipTacStyle:GenNpcLines") end -- DaMaGepy: 's Pet/minion
	lineName.next = u.name;

	local Ftitle = u.title;
	if GetFakeName~=nil then Ftitle=GetFakeName(Ftitle,"TipTacStyle:GenNpcLines") end -- DaMaGepy: 's Pet/minion
	
	-- guild/title -- since WoD, npc title can be a single space character
	if (u.title) and (u.title ~= " ") then
		-- Az: this doesn't work with "Mini Diablo" or "Mini Thor", which has the format: 1) Mini Diablo 2) Lord of Terror 3) Player's Pet 4) Level 1 Non-combat Pet
		local gttLine = tt.isColorBlind and GameTooltipTextLeft3 or GameTooltipTextLeft2;
		--gttLine:SetFormattedText("%s<%s>",u.reactionColor,u.title);
		gttLine:SetFormattedText("%s<%s>",u.reactionColor,Ftitle);
		lineInfo.Index = (lineInfo.Index + 1);
	end

	-- class
	local class = UnitCreatureFamily(unit) or UnitCreatureType(unit);
	if (not class or class == TT_NotSpecified) then
		class = UNKNOWN;
	end
	lineInfo.next = " ";
	lineInfo.next = cfg.colRace;
	lineInfo.next = class;
end

-- Modify Tooltip Lines (name + info)
function ttStyle:ModifyUnitTooltip(u,first)
	-- obtain unit properties
	local unit = u.token;
	u.name, u.realm = UnitName(unit);
	u.reactionColor = cfg["colReactText"..u.reactionIndex];
	--u.isPetWild, u.isPetCompanion = UnitIsWildBattlePet(unit), UnitIsBattlePetCompanion(unit);
	u.isPetWild, u.isPetCompanion = false, false;
	-- this is the line index where the level and unit type info is
	lineInfo.Index = 2 + (tt.isColorBlind and UnitIsVisible(unit) and 1 or 0);

	if (cfg.showTTguildAfter==false) and (u.isPlayer) then -- DaMaGepy
		local guild, guildRank = GetGuildInfo(unit);
		if (guild) then
			local pGuild = GetGuildInfo("player");
			local guildColor = (guild == pGuild and cfg.colSameGuild or cfg.colorGuildByReaction and u.reactionColor or cfg.colGuild);
			lineInfo.next = guildColor.."<"..guild..">"; -- DaMaGepy Fix
			if cfg.showGuildRank and guildRank then lineInfo.next = " "..COL_GRANK..guildRank; end
			GameTooltipTextLeft2:SetFormattedText(cfg.showGuildRank and guildRank and "%s<%s> %s%s" or "%s<%s>",guildColor,guild,COL_GRANK,guildRank);
			--lineInfo.Index = (lineInfo.Index + 1);
			lineInfo.next =	"\n";
		end	
	end;
	
	-- Level + Classification
	local level = (u.isPetWild or u.isPetCompanion) and UnitBattlePetLevel(unit) or UnitLevel(unit) or -1;
	local classification = UnitClassification(unit) or "";
	lineInfo.next = (UnitCanAttack(unit,"player") or UnitCanAttack("player",unit)) and GetDifficultyLevelColor(level ~= -1 and level or 500) or cfg.colLevel;
	lineInfo.next = (cfg["classification_"..classification] or "%s? "):format(level == -1 and "??" or level);

	-- Generate Line Modification
	if (u.isPlayer) then
		self:GeneratePlayerLines(u,first,unit);
--	elseif (cfg.showBattlePetTip) and (u.isPetWild or u.isPetCompanion) then
--		self:GeneratePetLines(u,first,unit);
	else
		self:GenerateNpcLines(u,first,unit);
	end

	-- Target
	if (cfg.showTarget ~= "none") then
		self:GenerateTargetLines(unit,cfg.showTarget);
	end

	-- Reaction Text
	if (cfg.reactText) then
		lineInfo.next = "\n";
		lineInfo.next = u.reactionColor;
		lineInfo.next = TT_Reaction[u.reactionIndex];
	end

	-- Name Line
	GameTooltipTextLeft1:SetText(lineName:Concat());
	lineName:Clear();

	-- Info Line
	local gttLine = _G["GameTooltipTextLeft"..lineInfo.Index];
	gttLine:SetText(lineInfo:Concat());
	gttLine:SetTextColor(1,1,1);	
	lineInfo:Clear();
end

--------------------------------------------------------------------------------------------------------
--                                           Element Events                                           --
--------------------------------------------------------------------------------------------------------

function ttStyle:OnLoad()
	cfg = TipTac_Config;
end

function ttStyle:OnStyleTip(tip,u,first)
	-- some things only need to be done once initially when the tip is first displayed
	if (first) then
		-- Store Original Name
		if (cfg.nameType == "original") then
			u.originalName = GameTooltipTextLeft1:GetText();
		end

		-- Az: RolePlay Experimental (Mary Sue Protocol)
		if (u.isPlayer) and (cfg.nameType == "marysueprot") and (msp) then
			local field = "NA";
			local name = UnitName(u.token);
			if GetFakeName~=nil then name=GetFakeName(name,"TipTacStyle:OnStyleTip1") end -- DaMaGepy
			if GetFakeName~=nil then u.rpName=GetFakeName(u.rpName,"TipTacStyle:OnStyleTip2") end -- DaMaGepy
			if GetFakeName~=nil then u.originalName=GetFakeName(u.originalName,"TipTacStyle:OnStyleTip3") end -- DaMaGepy
			msp:Request(name,field);	-- Az: does this return our request, or only storing it for later use? I'm guessing the info isn't available right away, but only after the person's roleplay addon replies.
			if (msp.char[name]) and (msp.char[name].field[field] ~= "") then
				u.rpName = msp.char[name].field[field] or name;
			end
		end

		-- Find NPC Title -- 09.08.22: Should now work with colorblind mode
		if (not u.isPlayer) then
			u.title = (tt.isColorBlind and GameTooltipTextLeft3 or GameTooltipTextLeft2):GetText();
			if (u.title) and (u.title:find(TT_LevelMatch)) then
				u.title = nil;
			end
		end
	end

	self:ModifyUnitTooltip(u,first);
end

function ttStyle:OnCleared()
	self.petLevelLineIndex = nil;
end