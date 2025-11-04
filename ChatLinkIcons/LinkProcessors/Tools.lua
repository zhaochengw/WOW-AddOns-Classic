--[[	ChatLinkIcons - Link Processor Tools
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
local GetSpellTexture=GetSpellTexture or C_Spell.GetSpellTexture;--	Moved in TWW, hasn't happened in Classic yet

local RaceAtlasMap={
	Scourge="Undead";
	HighmountainTauren="Highmountain";
	LightforgedDraenei="Lightforged";
	ZandalariTroll="Zandalari";
};

local ClassAtlasOverrides={}; do
	local function CreateTextureMarkupFromGrid(file,filew,fileh,x,y,tilew,tileh)
		return CreateTextureMarkup(file,filew,fileh,0,0,GetTexCoordsByGrid(x,y,filew,fileh,tilew,tileh));
	end

	for class,info in pairs({
		MONK={"Interface\\GLUES\\CHARACTERCREATE\\UI-CHARACTERCREATE-CLASSES",256,256,3,3,64,64};
	}) do
		if not C_Texture.GetAtlasInfo(GetClassAtlas(class)) then
			ClassAtlasOverrides[class]=CreateTextureMarkupFromGrid(unpack(info));
		end
	end
end

function AddOn.LinkProcessorTools_CreateTextureMarkup(path) return path and ("|T%s:0|t"):format(tostring(path)); end
function AddOn.LinkProcessorTools_CreateTextureMarkupFromItemID(itemid) return itemid and AddOn.LinkProcessorTools_CreateTextureMarkup(GetItemIcon(itemid)); end
function AddOn.LinkProcessorTools_CreateTextureMarkupFromSpellID(spellid) return spellid and AddOn.LinkProcessorTools_CreateTextureMarkup(GetSpellTexture(spellid)); end

function AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerGUID(guid)
	if not guid then return nil; end

--	GenderID is 2=Male 3=Female
	local _,class,_,race,gender=GetPlayerInfoByGUID(guid);

	race,class=
		(AddOn.Options.Links_Player_Race and race and gender) and CreateAtlasMarkup(("raceicon-%s-%s"):format((RaceAtlasMap[race] or race):lower(),gender==3 and "female" or "male")) or nil
		,(AddOn.Options.Links_Player_Class and class) and (ClassAtlasOverrides[class] or CreateAtlasMarkup("classicon-"..class:lower())) or nil;
	return (race and class) and race..class or race or class;
end

function AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerName(name)
	return AddOn.LinkProcessorTools_CreateTextureMarkupFromPlayerGUID(AddOn.PlayerCache_GetPlayerGUID(name));
end
