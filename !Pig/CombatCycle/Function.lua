local _, addonTable = ...;
local _, _, _, tocversion = GetBuildInfo()
---------------
local CombatCycle={}
local spellNUM=10
CombatCycle.spellNUM=spellNUM
local Class_ON={
	["id"]={1,2,3,4,5,6,7,8,9,10,11,12},
	["NR"]={
		[1]={{},{},{}},
		[2]={{},{},{}},
		[3]={{},{},{}},
		[4]={{},{},{}},
		[5]={{},{},{}},
		[6]={{},{},{}},
		[7]={{},{},{}},
		[8]={{},{},{}},
		[9]={{},{},{}},
		[10]={{},{},{}},
		[11]={{},{},{},{}},
		[12]={{},{}},
	},
}
for i=1,#Class_ON["id"] do
	local tianfulist = Class_ON["id"][i]
	for ii=1,#Class_ON["NR"][tianfulist] do
		local id, name, description, icon,role=GetSpecializationInfoForClassID(tianfulist,ii)
		Class_ON["NR"][tianfulist][ii]={icon, name, role, false}
	end
end


local _, classId = UnitClassBase("player");
--职业编号1战士/2圣骑士/3猎人/4盗贼/5牧师/6死亡骑士/7萨满祭司/8法师/9术士/10武僧/11德鲁伊/12恶魔猎手
local function SHow_but(self,spellid)
	self.Tex:SetTexture(GetSpellTexture(spellid));
	self:SetWidth(PIG_Per.CombatCycle.Size);
end
local function Huoqu_Class_Update()
	for i=1,#Class_ON["id"] do
		local tianfulist = Class_ON["id"][i]
		for ii=1,#Class_ON["NR"][tianfulist] do
			Class_ON["NR"][tianfulist][ii][4]=false
		end
	end
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
		local specID = GetSpecialization()
		if specID==1 then

		elseif specID==2 then
			local function Class_Update()
				--print("射击")
			end
			--Class_ON["NR"][classId][specID][4]=true
			return Class_Update
		elseif specID==3 then
			local function Class_Update()
				print("qweq")
										--夺命射击
				local PigtishijienengList={320976,259491,259495,259489,186270}
				for i=1,spellNUM do
					local fujik = _G["CombatCycle_But_"..i]
					fujik:SetWidth(0.001);
					local spellid = PigtishijienengList[i]
					if spellid then
						local keyishifangSP = false
						local usable, noMana = IsUsableSpell(spellid)--可用，没蓝不可用
						local currentCharges= GetSpellCharges(spellid)--充能次数
						if currentCharges then
							if currentCharges>0 then
								keyishifangSP = true
							end
						else
							if usable and not noMana then
								local _, GGDCD = GetSpellCooldown(61304)
								if GGDCD==0 then GGDCD=1.5 end
								local start, duration, enabled = GetSpellCooldown(spellid)
								if enabled==1 and duration<=GGDCD then
									keyishifangSP = true
								end	
							end
						end
						if keyishifangSP then
							if i==2 then
								local buffcunzaipig = true
								AuraUtil.ForEachAura("target", "HARMFUL", nil, function(name, _, _, _, _, expirationTime, _, _, _, spellId)
									if spellId == spellid then
										buffcunzaipig=false
										local SYtime=expirationTime-GetTime()
										if SYtime<=3 then
											SHow_but(fujik,spellid)
										end
										return
									end
								end)
								if buffcunzaipig then
									SHow_but(fujik,spellid)
								end
							elseif i==5 then
								local power = UnitPower("player")
								if power>75 then
									SHow_but(fujik,spellid)
								end
							else
								SHow_but(fujik,spellid)
							end
						end
					end
				end
			end
			Class_ON["NR"][classId][specID][4]=true
			return Class_Update
		end
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
		end
		return Class_Update
	elseif classId==9 then--术士
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==10 then--武僧
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==11 then--德鲁伊
		local PigtishijienengList={}
		local function Class_Update()
		end
		return Class_Update
	elseif classId==12 then--恶魔猎手
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


-- function()
-- 	local count1 = 0
-- 	local count2 = 0
-- 	for i = 1, 40 do
-- 	local unit = "nameplate"..i
-- 	if UnitCanAttack("player", unit) and WeakAuras.CheckRange(unit, 8, "<=") then
-- 		count1 = count1 + 1
-- 	end
-- end