if not WeakAuras.IsLibsOK() then return end

if GetLocale() ~= "koKR" then
  return
end

local L = WeakAuras.L

-- WeakAuras/Templates
	L[" Debuff"] = "약화 효과"
	L["<70% Mana"] = "<70% 마나"
	L[">70% Mana"] = ">70% 마나"
	L["Abilities"] = "능력"
	L["Ability"] = "능력"
	L["Add Triggers"] = "활성 조건 추가"
	L["Always Active"] = "항상 활성화"
	L["Always Show"] = "항상 표시"
	L["Always show the aura, highlight it if debuffed."] = "효과를 항상 표시하고, 약화 효과면 강조합니다."
	L["Always show the aura, turns grey if on cooldown."] = "효과를 항상 표시하고, 재사용 대기 중이면 회색으로 변합니다."
	L["Always show the aura, turns grey if the debuff not active."] = "효과를 항상 표시하고, 약화 효과가 활성화되어 있지 않으면 회색으로 바뀝니다."
	--[[Translation missing --]]
	L["Always shows highlights if enchant missing."] = "Always shows highlights if enchant missing."
	L["Always shows the aura, grey if buff not active."] = "효과를 항상 표시하고, 강화 효과가 활성화되어 있지 않으면 회색으로 바뀝니다."
	L["Always shows the aura, highlight it if buffed."] = "효과를 항상 표시하고, 강화 효과면 강조합니다."
	L["Always shows the aura, highlight when active, turns blue on insufficient resources."] = "효과를 항상 표시하고, 활성화되면 강조하며, 자원이 부족하면 파란색으로 바뀝니다."
	L["Always shows the aura, highlight while proc is active, blue on insufficient resources."] = "효과를 항상 표시하고, 발동 중일 때 강조되며, 자원이 부족하면 파란색으로 바뀝니다."
	L["Always shows the aura, highlight while proc is active, blue when not usable."] = "효과를 항상 표시하고, 발동 중일 때 강조되며, 사용할 수 없으면 파란색으로 바뀝니다."
	L["Always shows the aura, highlight while proc is active, turns red when out of range, blue on insufficient resources."] = "효과를 항상 표시하고, 발동 중일 때 강조되며, 사정 거리를 벗어나면 빨간색으로, 자원이 부족하면 파란색으로 바뀝니다."
	L["Always shows the aura, turns blue on insufficient resources."] = "효과를 항상 표시하고, 자원이 부족하면 파란색으로 바뀝니다."
	L["Always shows the aura, turns blue when not usable."] = "효과를 항상 표시하고, 사용할 수 없을 때는 파란색으로 바뀝니다."
	L["Always shows the aura, turns grey if on cooldown."] = "효과를 항상 표시하고, 재사용 대기 중이면 회색으로 바뀝니다."
	L["Always shows the aura, turns grey if the ability is not usable and red when out of range."] = "효과를 항상 표시하고, 능력을 사용할 수 없으면 회색으로, 사정 거리를 벗어나면 빨간색으로 바뀝니다."
	L["Always shows the aura, turns grey if the ability is not usable."] = "효과를 항상 표시하고, 능력을 사용할 수 없으면 회색으로 바뀝니다."
	L["Always shows the aura, turns red when out of range, blue on insufficient resources."] = "효과를 항상 표시하고, 사정 거리를 벗어나면 빨간색으로, 자원이 부족하면 파란색으로 바뀝니다."
	L["Always shows the aura, turns red when out of range."] = "효과를 항상 표시하고, 사정 거리를 벗어나면 빨간색으로 바뀝니다."
	L["Always shows the aura."] = "효과를 항상 표시합니다."
	L["Back"] = "뒤로"
	L["Basic Show On Cooldown"] = "재사용 대기 중 표시"
	L["Basic Show On Ready"] = "준비완료 시 표시"
	L["Bloodlust/Heroism"] = "피의 욕망/영웅심"
	--[[Translation missing --]]
	L["Bonded Buff"] = "Bonded Buff"
	L["Buff"] = "강화 효과"
	L["buff"] = "강화 효과"
	--[[Translation missing --]]
	L["Buff on Other"] = "Buff on Other"
	L["Buffs"] = "강화 효과"
	--[[Translation missing --]]
	L["Build Up"] = "Build Up"
	L["Cancel"] = "취소"
	L["Cast"] = "시전"
	L["Charge and Buff Tracking"] = "충전량 및 강화 효과 추적"
	L["Charge and Debuff Tracking"] = "충전량 및 약화 효과 추적"
	L["Charge and Duration Tracking"] = "충전량 및 지속시간 추적"
	L["Charge Tracking"] = "충전량 추적"
	--[[Translation missing --]]
	L["Combustion Ready"] = "Combustion Ready"
	L["Conduits"] = "도관"
	L["Cooldown"] = "재사용 대기시간"
	L["cooldown"] = "재사용 대기시간"
	L["Cooldown Tracking"] = "재사용 대기시간 추적"
	L["Create Auras"] = "aura 생성"
	L["Debuff"] = "약화 효과"
	L["debuff"] = "약화 효과"
	L["Debuffs"] = "약화 효과"
	--[[Translation missing --]]
	L["Empowered Buff"] = "Empowered Buff"
	L["Fire"] = "화염"
	L["Frost"] = "냉기"
	L["General"] = "일반"
	L["Health"] = "생명력"
	--[[Translation missing --]]
	L["Highlight while action is queued."] = "Highlight while action is queued."
	L["Highlight while active, red when out of range."] = "활성화 된 동안 강조, 사정거리를 벗어나면 붉은색으로 표시"
	L["Highlight while active."] = "활성화된 동안 강조합니다."
	L["Highlight while buffed, red when out of range."] = "강화 효과가 있는 동안 강조, 사정거리를 벗어나면 붉은색으로 표시"
	L["Highlight while buffed."] = "강화 효과가 있는 동안 강조합니다."
	L["Highlight while debuffed, red when out of range."] = "약화 효과가 있는 동안 강조, 사정거리를 벗어나면 붉은색으로 표시"
	L["Highlight while debuffed."] = "약화 효과가 있는 동안 강조합니다."
	L["Highlight while spell is active."] = "주문이 활성화 되어 있는 동안 강조"
	L["Hold CTRL to create multiple auras at once"] = "한 번에 여러 효과를 만드려면 CTRL 키를 누르세요"
	--[[Translation missing --]]
	L["Initial Buff"] = "Initial Buff"
	L["Keeps existing triggers intact"] = "활성 조건 그대로 유지"
	L["Legendaries"] = "전설"
	--[[Translation missing --]]
	L["Meteor Ready"] = "Meteor Ready"
	L["Nature"] = "자연"
	L["Next"] = "다음"
	L["Only show the aura if the target has the debuff."] = "대상에 약화 효과가 있을 때만 효과를 표시합니다."
	L["Only show the aura when the item is on cooldown."] = "아이템이 재사용 대기 중일 때만 효과를 표시합니다."
	--[[Translation missing --]]
	L["Only shows if the weapon is enchanted."] = "Only shows if the weapon is enchanted."
	L["Only shows if the weapon is not enchanted."] = "무기에 마법부여가 되지 않았을 때만 표시합니다."
	L["Only shows the aura if the target has the buff."] = "대상에 강화 효과가 있을 때만 효과를 표시합니다."
	L["Only shows the aura when the ability is on cooldown."] = "능력이 재사용 대기 중일 때만 효과를 표시합니다."
	L["Only shows the aura when the ability is ready to use."] = "능력을 사용할 준비가 되었을 때만 효과를 표시합니다."
	--[[Translation missing --]]
	L["Other cooldown"] = "Other cooldown"
	L["Pet alive"] = "소환수 생존"
	L["Pet Behavior"] = "소환수 행동"
	--[[Translation missing --]]
	L["Preparation"] = "Preparation"
	L["PvP Talents"] = "명예 특성"
	L["Replace all existing triggers"] = "모든 활성 조건 교체"
	L["Replace Triggers"] = "활성 조건 교체"
	L["Resources"] = "자원"
	L["Resources and Shapeshift Form"] = "자원과 태세 변환"
	--[[Translation missing --]]
	L["Rogue cooldown"] = "Rogue cooldown"
	--[[Translation missing --]]
	L["Root"] = "Root"
	L["Runes"] = "룬"
	L["Shapeshift Form"] = "태세 변환"
	--[[Translation missing --]]
	L["Shards Of Domination"] = "Shards Of Domination"
	--[[Translation missing --]]
	L["Show Always, Glow on Missing"] = "Show Always, Glow on Missing"
	--[[Translation missing --]]
	L["Show Charges and Check Usable"] = "Show Charges and Check Usable"
	--[[Translation missing --]]
	L["Show Charges with Proc Tracking"] = "Show Charges with Proc Tracking"
	--[[Translation missing --]]
	L["Show Charges with Range Tracking"] = "Show Charges with Range Tracking"
	--[[Translation missing --]]
	L["Show Charges with Usable Check"] = "Show Charges with Usable Check"
	--[[Translation missing --]]
	L["Show Cooldown and Action Queued"] = "Show Cooldown and Action Queued"
	L["Show Cooldown and Buff"] = "재사용 대기시간 및 강화 효과 표시"
	L["Show Cooldown and Buff and Check for Target"] = "재사용 대기시간과 강화 효과 표시 및 대상 확인"
	--[[Translation missing --]]
	L["Show Cooldown and Buff and Check Usable"] = "Show Cooldown and Buff and Check Usable"
	L["Show Cooldown and Check for Target"] = "재사용 대기시간 표시 및 대상 확인"
	--[[Translation missing --]]
	L["Show Cooldown and Check for Target & Proc Tracking"] = "Show Cooldown and Check for Target & Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable"] = "Show Cooldown and Check Usable"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable & Target"] = "Show Cooldown and Check Usable & Target"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable, Proc Tracking"] = "Show Cooldown and Check Usable, Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable, Target & Proc Tracking"] = "Show Cooldown and Check Usable, Target & Proc Tracking"
	L["Show Cooldown and Debuff"] = "재사용 대기시간 및 약화 효과 표시"
	--[[Translation missing --]]
	L["Show Cooldown and Debuff and Check for Target"] = "Show Cooldown and Debuff and Check for Target"
	L["Show Cooldown and Duration"] = "재사용 대기시간 및 지속시간 표시"
	L["Show Cooldown and Duration and Check for Target"] = "재사용 대기시간과 지속시간 표시 및 대상 확인"
	--[[Translation missing --]]
	L["Show Cooldown and Duration and Check Usable"] = "Show Cooldown and Duration and Check Usable"
	--[[Translation missing --]]
	L["Show Cooldown and Proc Tracking"] = "Show Cooldown and Proc Tracking"
	L["Show Cooldown and Totem Information"] = "재사용 대기시간 및 토템 정보 표시"
	--[[Translation missing --]]
	L["Show if Enchant Missing"] = "Show if Enchant Missing"
	--[[Translation missing --]]
	L["Show on Ready"] = "Show on Ready"
	L["Show Only if Buffed"] = "있는 강화 효과만 표시"
	L["Show Only if Debuffed"] = "있는 약화 효과만 표시"
	--[[Translation missing --]]
	L["Show Only if Enchanted"] = "Show Only if Enchanted"
	L["Show Only if on Cooldown"] = "재사용 대기 중일 때만 표시"
	--[[Translation missing --]]
	L["Show Totem and Charge Information"] = "Show Totem and Charge Information"
	--[[Translation missing --]]
	L["Slow"] = "Slow"
	--[[Translation missing --]]
	L["slow debuff"] = "slow debuff"
	--[[Translation missing --]]
	L["Sprint"] = "Sprint"
	L["Stance"] = "태세"
	L["stun debuff"] = "기절 약화 효과"
	L["Stun Debuff"] = "기절 약화 효과"
	L["Totem"] = "토템"
	--[[Translation missing --]]
	L["Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."] = "Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the buff, highlight while the buff is active, blue on insufficient resources."] = "Tracks the charge and the buff, highlight while the buff is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the debuff, highlight while the debuff is active, blue on insufficient resources."] = "Tracks the charge and the debuff, highlight while the debuff is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."] = "Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."
	L["Unknown Item"] = "알 수 없는 아이템"
	L["Unknown Spell"] = "알 수 없는 주문"
	--[[Translation missing --]]
	L["Warrior cooldown"] = "Warrior cooldown"

