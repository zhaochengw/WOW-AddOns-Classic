local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
---------------
local CombatCycle={}
local spellNUM=10
CombatCycle.spellNUM=spellNUM
local Class_ON={
	["id"]={1,2,3,4,5,7,8,9,11},
	["NR"]={
		[1]={{132355,"武器","DAMAGER",false},{132347,"狂怒","DAMAGER",false},{132341,"防护","TANK",false}},
		[2]={{135920,"神圣","HEALER",false},{135893,"防护","TANK",false},{135873,"惩戒","DAMAGER",false}},
		[3]={{132164,"野兽控制","DAMAGER",false},{132222,"射击","DAMAGER",false},{132215,"生存","DAMAGER",false}},
		[4]={{132292,"刺杀","DAMAGER",false},{132090,"战斗","DAMAGER",false},{132320,"敏锐","DAMAGER",false}},
		[5]={{135940,"戒律","HEALER",false},{135920,"神圣","HEALER",false},{136207,"暗影","DAMAGER",false}},
		[6]={{135770,"鲜血","DAMAGER",false},{135773,"冰霜","DAMAGER",false},{135775,"邪恶","DAMAGER",false}},
		[7]={{136048,"元素","DAMAGER",false},{136051,"增强","DAMAGER",false},{136052,"恢复","HEALER",false}},
		[8]={{135932,"奥术","DAMAGER",false},{135810,"火焰","DAMAGER",false},{135846,"冰霜","DAMAGER",false}},
		[9]={{136145,"痛苦","DAMAGER",false},{136172,"恶魔学识","DAMAGER",false},{136186,"毁灭","DAMAGER",false}},
		[10]={{608951,"酒仙","TANK",false},{608952,"织雾","HEALER",false},{608953,"踏风","DAMAGER",false}},
		[11]={{136096,"平衡","DAMAGER",false},{132115,"野性","DAMAGER",false},{136041,"恢复","HEALER",false}},
		[12]={{1247264,"浩劫","DAMAGER",false},{1247265,"复仇","TANK",false}},
	},
}

local _, classId = UnitClassBase("player");
--职业编号1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
local function SHow_but(self,spellid)
	self.Tex:SetTexture(GetSpellTexture(spellid));
	self:SetWidth(PIG_Per.CombatCycle.Size);
end
local function Huoqu_Class_Update()
	if classId==1 then--战士
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==2 then--圣骑士
	 	local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==3 then--猎人
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==4 then--盗贼
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==5 then--牧师
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==6 then--死亡骑士
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==7 then--萨满
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==8 then--法师
		local PigtishijienengList={}
		local function Class_Update()
			--print(classId)
		end
		addonTable.Class_Update=Class_Update
	elseif classId==9 then--术士
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==11 then--德鲁伊
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	end
	local function Class_Update() end
	return Class_Update
end
CombatCycle.Huoqu_Class_Update=Huoqu_Class_Update

CombatCycle.Class_ON=Class_ON
addonTable.CombatCycle=CombatCycle