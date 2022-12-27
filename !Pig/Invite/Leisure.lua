local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local _, _, _, tocversion = GetBuildInfo()
-- ----------------------------------
local CDWMinfo=addonTable.CDWMinfo
local SQPindao = CDWMinfo["pindao"]
local qingqiumsg = CDWMinfo["Leisure"]
----
local biaotou='!Pig-Leisure';
local PIG_Lei={}
PIG_Lei.ListInfo={};
C_ChatInfo.RegisterAddonMessagePrefix(biaotou)
--=============================================================
local FBdata=addonTable.FBdata
local InstanceList = FBdata[1]
local InstanceID = FBdata[2]
local ADD_Frame=addonTable.ADD_Frame
local ADD_Biaoti=addonTable.ADD_Biaoti
local ADD_jindutiaoBUT=addonTable.ADD_jindutiaoBUT
local function ADD_Leisure_Frame()
	local fufufuFrame=PlaneInvite_UI
	local fuFrame=PlaneInviteFrame_1;
	local Width,Height=fuFrame:GetWidth(),fuFrame:GetHeight();	
	--浏览窗口
	fuFrame.NR=ADD_Frame(nil,fuFrame,Width-20,Height-80,"BOTTOMLEFT",fuFrame,"BOTTOMLEFT",1,3,false,true,false,false,false,"BG3")

end
addonTable.ADD_Leisure_Frame=ADD_Leisure_Frame