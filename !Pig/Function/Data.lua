local addonName, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
-------------
function table.removekey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end
function PIG_print(msg)
	print("|cff00FFFF!Pig:|r|cffFFFF00"..msg.."！|r");
end
----
local OLD_SetRotation=SetRotation
function PIGRotation(self,dushu)
	local angle = math.rad(dushu)
	self:SetRotation(angle)
end
---
if tocversion<40000 then
	PIG_InviteUnit=InviteUnit
else
	PIG_InviteUnit=C_PartyInfo.InviteUnit
	--PIG_InviteUnit=C_PartyInfo.ConfirmInviteUnit
end
--装备颜色
addonTable.QualityColor= {
	[0]={157/255,157/255,157/255},
	[1]={1, 1, 1},
	[2]={30/255, 1, 0},
	[3]={0,112/255,221/255},
	[4]={163/255,53/255,238/255},
	[5]={1,128/255,0},
	[6]={230/255,204/255,128/255},
	[7]={0,204/255,1},
}
--副本数据
local InstanceList = {}
local InstanceID_id = {
	["Party"]={
		["Vanilla"]={33,34,36,43,47,48,70,90,109,129,189,209,229,230,289,329,349,389,429,},
		["TBC"]={269,540,542,543,545,546,547,552,553,554,555,556,557,558,560,585,},
		["WLK"]={574,575,576,578,595,599,600,601,602,604,608,619,632,650,658,668,},
	},
	["Raid"] = {
		["Vanilla"]={309,409,469,509,531},
		["TBC"]={532,534,544,548,550,564,565,580},
		["WLK"]={603,615,616,624,631,649,724},
	},
}
if tocversion<20000 then
	table.insert(InstanceList,{"地下城","Party","Vanilla"})
	table.insert(InstanceList,{"团队副本","Raid","Vanilla"})
	table.insert(InstanceID_id["Raid"]["Vanilla"],249)--奥妮克希亚的巢穴
	table.insert(InstanceID_id["Raid"]["Vanilla"],533)--纳克萨玛斯
else
	table.insert(InstanceList,{"地下城(经典)","Party","Vanilla"})
	table.insert(InstanceList,{"地下城(TBC)","Party","TBC"})
	table.insert(InstanceList,{"团队副本(经典)","Raid","Vanilla"})
	table.insert(InstanceList,{"团队副本(TBC)","Raid","TBC"})
	if tocversion<30000 then
		table.insert(InstanceID_id["Raid"]["Vanilla"],249)
		table.insert(InstanceID_id["Raid"]["Vanilla"],533)
	else
		table.insert(InstanceList,3,{"地下城(WLK)","Party","WLK"})
		table.insert(InstanceList,{"团队副本(WLK)","Raid","WLK"})
		table.insert(InstanceID_id["Raid"]["WLK"],249)
		table.insert(InstanceID_id["Raid"]["WLK"],533)
	end
end
local InstanceID = {}
for k,v in pairs(InstanceID_id) do
	InstanceID[k]={}
	for kk,vv in pairs(v) do
		InstanceID[k][kk]={}
		for i=1,#vv do
			local fubenname = GetRealZoneText(vv[i])
			local _,_,_, fubennameXX =fubenname:find("(：(.+))");
			if fubennameXX then
				InstanceID[k][kk][i]=fubennameXX
			else
				InstanceID[k][kk][i]=fubenname
			end
		end
	end
end
addonTable.FBdata={InstanceList,InstanceID}
--根据等级计算单价
local function jisuandanjia(lv)
	local fbName=PIG_Per.daiben.fubenName
	if fbName~="无" then
		local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
		for id = 1, 4, 1 do
			if danjiaList[id][1]>0 then
				if lv>=danjiaList[id][1] and lv<=danjiaList[id][2] then
					return danjiaList[id][3]
				end
			end
		end
	end
	return 0
end
addonTable.jisuandanjia=jisuandanjia
--获取队伍等级
local function huoquduiwLV(MsgNr)
	local MsgNr=""
	if IsInGroup() then
		local numgroup = GetNumSubgroupMembers()
		if numgroup>0 then
			for id=1,numgroup do
				local dengjiKk = UnitLevel("Party"..id);
				if id==numgroup then
					MsgNr=MsgNr..dengjiKk;
				else
					MsgNr=MsgNr..dengjiKk..",";
				end
			end
			MsgNr=MsgNr;
		end
	end
	return MsgNr
end
addonTable.huoquduiwLV=huoquduiwLV
--获取所带副本级别单价
local function huoquLVdanjia(MsgNr)
	local MsgNr = ""
	local fbName=PIG_Per.daiben.fubenName
	local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
	for id = 1, 4, 1 do
		local kaishiLV =danjiaList[id][1]
		local jieshuLV =danjiaList[id][2]
		local jiageG =danjiaList[id][3]
		if kaishiLV>0 and jieshuLV>0 then
			if jiageG>0 then
				MsgNr=MsgNr.."<"..kaishiLV.."-"..jieshuLV..">"..jiageG.."G;"
			else
				MsgNr=MsgNr.."<"..kaishiLV.."-"..jieshuLV..">".."免费;"
			end
		end
	end
	return MsgNr
end
addonTable.huoquLVdanjia=huoquLVdanjia
--获取设置的级别范围
local function huoquLVminmax()
	local min,max = nil,nil
	local fbName=PIG_Per.daiben.fubenName
	local danjiaList=PIG_Per.daiben.LV_danjia[fbName]
	for id = 1, 4, 1 do
		local kaishiLV =danjiaList[id][1]
		local jieshuLV =danjiaList[id][2]
		if kaishiLV>0 and jieshuLV>0 then
			if min then
				if kaishiLV<min then
					min=kaishiLV
				end
			else
				min=kaishiLV
			end
			if max then
				if jieshuLV>max then
					max=jieshuLV
				end
			else
				max=jieshuLV
			end
		end
	end
	local min,max = min or 0,max or 0
	return min,max
end
addonTable.huoquLVminmax=huoquLVminmax