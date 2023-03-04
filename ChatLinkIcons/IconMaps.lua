--[[	ChatLinkIcons Icon Mapping
	by SDPhantom
	https://www.wowinterface.com/forums/member.php?u=34145
	https://www.curseforge.com/members/sdphantomgamer/projects	]]
--------------------------------------------------------------------------

local AddOn=select(2,...);
AddOn.RaceIcons={};
AddOn.ClassIcons={};

local function GetGridPos(x,y,w,h) return x*w,y*h; end
local function CreateTextureMarkupByGrid(texture,filewidth,fileheight,x,y,w,h,xmultiplier,ymultiplier,xoffset,yoffset)
--	|Tpath:size1:size2:xoffset:yoffset:dimx:dimy:coordx1:coordx2:coordy1:coordy2|t
	x,y=x*(xmultiplier or w)+(xoffset or 0),y*(ymultiplier or h)+(yoffset or 0);
	return ("|T%s:0:0:0:0:%d:%d:%d:%d:%d:%d|t"):format(texture,filewidth,fileheight,x,x+w-1,y,y+h-1);
end

--	Since Blizzard can't decide how to differentiate builds, we're based on ToC version
local ToCVersion=select(4,GetBuildInfo());

----------------------------------
--[[	Race/Gender Icons	]]
----------------------------------
--	Gender from GetPlayerInfoByGUID() is 2=Male/3=Female

--	Modern Formats		(130x130 Main Grid; 66x66 Sub Grids)
if ToCVersion>=100000 then--	Dragon Flight
	local g1x,g1y=GetGridPos(8,3,130,130);
	local g2x,g2y=GetGridPos(9,1,130,130);

	AddOn.RaceIcons.Human2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,7,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Human3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,6,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Orc2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,9,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Orc3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,8,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Dwarf2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,8,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Dwarf3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,7,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.NightElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,7,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.NightElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,6,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Scourge2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,5,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Scourge3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,4,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Tauren2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Tauren3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,12,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Gnome2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Gnome3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Troll2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,3,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Troll3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,2,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Goblin2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,3,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Goblin3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,2,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.BloodElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,7,7,66,66,130,130);
	AddOn.RaceIcons.BloodElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,6,7,66,66,130,130);
	AddOn.RaceIcons.Draenei2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,6,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Draenei3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,5,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Worgen2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,2,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Worgen3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,12,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Pandaren2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,11,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Pandaren3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,10,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Nightborne2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,5,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Nightborne3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,4,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.HighmountainTauren2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,5,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.HighmountainTauren3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,4,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.VoidElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,9,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.VoidElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,8,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.LightforgedDraenei2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,11,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.LightforgedDraenei3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,10,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.ZandalariTroll2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,4,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.ZandalariTroll3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,3,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.KulTiran2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,9,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.KulTiran3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,8,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.DarkIronDwarf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,0,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.DarkIronDwarf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,15,0,66,66,130,130);
	AddOn.RaceIcons.Vulpera2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,11,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Vulpera3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,10,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.MagharOrc2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,1,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.MagharOrc3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,12,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Mechagnome2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,3,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Mechagnome3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,2,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Dracthyr2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,4,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Dracthyr3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,3,66,66,nil,nil,g1x,g1y);

elseif ToCVersion>=80100 then--	Battle For Azeroth
--	This is actually Shadowlands (9.0) layout
--	Allied races were added in 8.1
--	Icons were re-shuffled in 8.2.5
--	Vulpera/Mechagnomes were added in 8.3

--	I don't have the older layouts anymore, we'll revisit this if classic catches up

	local g1x,g1y=GetGridPos(8,1,130,130);
	local g2x,g2y=GetGridPos(10,0,130,130);

	AddOn.RaceIcons.Human2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,7,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Human3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,6,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Orc2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,10,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Orc3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,9,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Dwarf2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,7,7,66,66,130,130);
	AddOn.RaceIcons.Dwarf3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,6,7,66,66,130,130);
	AddOn.RaceIcons.NightElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,8,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.NightElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,7,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Scourge2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,5,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Scourge3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,4,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Tauren2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,1,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Tauren3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,0,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Gnome2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Gnome3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Troll2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,3,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Troll3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,2,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Goblin2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,3,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.Goblin3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,2,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.BloodElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,7,66,66,130,130);
	AddOn.RaceIcons.BloodElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,7,66,66,130,130);
	AddOn.RaceIcons.Draenei2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,5,7,66,66,130,130);
	AddOn.RaceIcons.Draenei3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,4,7,66,66,130,130);
	AddOn.RaceIcons.Worgen2			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,11,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Worgen3			=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,10,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Pandaren2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,12,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Pandaren3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,11,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Nightborne2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,6,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Nightborne3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,5,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.HighmountainTauren2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,5,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.HighmountainTauren3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,4,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.VoidElf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,7,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.VoidElf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,6,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.LightforgedDraenei2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,0,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.LightforgedDraenei3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,10,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.ZandalariTroll2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,2,0,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.ZandalariTroll3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,12,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.KulTiran2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,9,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.KulTiran3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,8,0,66,66,nil,nil,g2x,g2y);
	AddOn.RaceIcons.DarkIronDwarf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,3,7,66,66,130,130);
	AddOn.RaceIcons.DarkIronDwarf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,2,7,66,66,130,130);
	AddOn.RaceIcons.Vulpera2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,9,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Vulpera3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,1,8,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.MagharOrc2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,2,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.MagharOrc3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,1,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Mechagnome2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,4,66,66,nil,nil,g1x,g1y);
	AddOn.RaceIcons.Mechagnome3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,3,66,66,nil,nil,g1x,g1y);

elseif ToCVersion>=20000 then--	Burning Crusade Classic	(Expanded to 512x256; Uses a later (Mists of Pandaria) version)
	AddOn.RaceIcons.Human2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,0,0,64,64);
	AddOn.RaceIcons.Human3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,0,2,64,64);
	AddOn.RaceIcons.Orc2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,3,1,64,64);
	AddOn.RaceIcons.Orc3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,3,3,64,64);
	AddOn.RaceIcons.Dwarf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,1,0,64,64);
	AddOn.RaceIcons.Dwarf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,1,2,64,64);
	AddOn.RaceIcons.NightElf2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,3,0,64,64);
	AddOn.RaceIcons.NightElf3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,3,2,64,64);
	AddOn.RaceIcons.Scourge2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,1,1,64,64);
	AddOn.RaceIcons.Scourge3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,1,3,64,64);
	AddOn.RaceIcons.Tauren2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,0,1,64,64);
	AddOn.RaceIcons.Tauren3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,0,3,64,64);
	AddOn.RaceIcons.Gnome2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,2,0,64,64);
	AddOn.RaceIcons.Gnome3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,2,2,64,64);
	AddOn.RaceIcons.Troll2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,2,1,64,64);
	AddOn.RaceIcons.Troll3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,2,3,64,64);

--	Burning Crusade
	AddOn.RaceIcons.BloodElf2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,4,1,64,64);
	AddOn.RaceIcons.BloodElf3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,4,3,64,64);
	AddOn.RaceIcons.Draenei2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,4,0,64,64);
	AddOn.RaceIcons.Draenei3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,4,2,64,64);

--	Cataclysm
	AddOn.RaceIcons.Goblin2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,5,1,64,64);
	AddOn.RaceIcons.Goblin3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,5,3,64,64);
	AddOn.RaceIcons.Worgen2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,5,0,64,64);
	AddOn.RaceIcons.Worgen3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,5,2,64,64);

--	Mists of Pandaria	(Texture file does include flipped versions for Horde, these are Alliance; Can't identify Alliance/Horde by GUID)
--				In the character creator, Alliance and Horde race buttons face each other, yet there is only one Pandaren button
	AddOn.RaceIcons.Pandaren2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,6,0,64,64);
	AddOn.RaceIcons.Pandaren3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",512,256,6,2,64,64);

else--	Vanilla Classic	(Original 256x256 format)
	AddOn.RaceIcons.Human2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,0,0,64,64);
	AddOn.RaceIcons.Human3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,0,2,64,64);
	AddOn.RaceIcons.Orc2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,3,1,64,64);
	AddOn.RaceIcons.Orc3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,3,3,64,64);
	AddOn.RaceIcons.Dwarf2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,1,0,64,64);
	AddOn.RaceIcons.Dwarf3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,1,2,64,64);
	AddOn.RaceIcons.NightElf2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,3,0,64,64);
	AddOn.RaceIcons.NightElf3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,3,2,64,64);
	AddOn.RaceIcons.Scourge2	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,1,1,64,64);
	AddOn.RaceIcons.Scourge3	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,1,3,64,64);
	AddOn.RaceIcons.Tauren2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,0,1,64,64);
	AddOn.RaceIcons.Tauren3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,0,3,64,64);
	AddOn.RaceIcons.Gnome2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,2,0,64,64);
	AddOn.RaceIcons.Gnome3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,2,2,64,64);
	AddOn.RaceIcons.Troll2		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,2,1,64,64);
	AddOn.RaceIcons.Troll3		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Races",256,256,2,3,64,64);
end

--	Class Icons	(All pre-DF classes are included in the Classic files)
AddOn.ClassIcons.WARRIOR	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,0,0,64,64);
AddOn.ClassIcons.MAGE		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,1,0,64,64);
AddOn.ClassIcons.ROGUE		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,2,0,64,64);
AddOn.ClassIcons.DRUID		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,3,0,64,64);
AddOn.ClassIcons.HUNTER		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,0,1,64,64);
AddOn.ClassIcons.SHAMAN		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,1,1,64,64);
AddOn.ClassIcons.PRIEST		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,2,1,64,64);
AddOn.ClassIcons.WARLOCK	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,3,1,64,64);
AddOn.ClassIcons.PALADIN	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,0,2,64,64);
AddOn.ClassIcons.DEATHKNIGHT	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,1,2,64,64);
AddOn.ClassIcons.MONK		=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,2,2,64,64);
AddOn.ClassIcons.DEMONHUNTER	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\UI-CharacterCreate-Classes",256,256,3,2,64,64);
if ToCVersion>=100000 then--	Dragon Flight
	AddOn.ClassIcons.EVOKER	=CreateTextureMarkupByGrid("Interface\\Glues\\CharacterCreate\\CharacterCreateIcons",2048,1024,0,0,130,130);
end

--[	Debug Testing Only
hash_SlashCmdList["/CLI"]=function()
	for _,category in ipairs({"RaceIcons","ClassIcons"}) do
		print(category..":");
		local tbl=AddOn[category]; local keys=GetKeysArray(tbl); table.sort(keys);
		for _,key in pairs(keys) do print(tbl[key]:gsub(":0:0",":32:32",1),key); end
	end
end
--]]
