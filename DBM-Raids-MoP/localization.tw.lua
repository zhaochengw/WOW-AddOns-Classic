if GetLocale() ~= "zhTW" then
	return
end
local L

------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s即將超載!",
	specWarnBreakJasperChains	= "扯斷碧玉鎖鏈!"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "為即將超載顯示特別警告",
	specWarnBreakJasperChains	= "當可安全扯斷$spell:130395時顯示特別警告",
	InfoFrame					= "為首領能量，玩家石化和那個首領施放石化顯示訊息框"
})

L:SetMiscLocalization({
	Overload	= "%s要超載了!"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "階段%d",
	specWarnBarrierNow	= "快使用無效屏障!"
})

L:SetOptionLocalization({
	WarnPhase			= "提示轉換階段",
	specWarnBarrierNow	= "為你應該使用$spell:115817的時候顯示特別警告(只對隨機團隊有效)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. "在祕法階段時"
})

L:SetMiscLocalization({
	Fire	= "噢，至高的神啊!藉由我來融化他們的血肉吧!",
	Arcane	= "噢，上古的賢者!賜予我祕法的智慧!",
	Nature	= "噢，偉大的靈魂!賜予我大地之力!",
	Shadow	= "英雄之靈!以盾護我之身!"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull	= "受死吧，你們!"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "黑暗之盾在%d秒"
})

L:SetTimerLocalization({
	timerUSRevive		= "不死黑影重新成形",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon	= "為$spell:117697提示施放前五秒倒數",
	timerUSRevive	= "為$spell:117506重新成形顯示計時器"
})

------------
-- Elegon --
------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "地板將在六秒後消失!"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "地板消失"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "為地板消失之前顯示特別警告",
	timerDespawnFloor		= "為地板消失顯示計時器"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "為中了$spell:116525的玩家顯示訊息框",
	CountOutCombo	= "數出$journal:5673連擊數<br/>註:這目前僅只有女性音效.",
	ArrowOnCombo	= "為$journal:5673顯示DBM箭頭<br/>註:這是假設坦克在前方而其他人在後方"
})

L:SetMiscLocalization({
	Pull		= "這台機器啟動了!到下一層去!",
	Rage		= "大帝之怒響徹群山。",
	Strength	= "帝王之力出現在壁龕裡!",
	Courage		= "帝王之勇出現在壁龕裡!",
	Boss		= "兩個泰坦魁儡出現在大壁龕裡!"
})

------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "回聲出現",
	warnEchoDown		= "回聲已擊殺",
	specwarnAttenuation	= "%s在%s(%s)",
	specwarnPlatform	= "轉換露臺"
})

L:SetOptionLocalization({
	warnEcho			= "提示回聲出現",
	warnEchoDown		= "提示回聲已擊殺",
	specwarnPlatform	= "為首領轉換露臺顯示特別警告",
	ArrowOnAttenuation	= "為$spell:127834指示DBM箭頭移動方向"
})

L:SetMiscLocalization({
	Platform	= "飛向他的其中一個露臺!",
	Defeat		= "我們不會居服於黑暗虛空的絕望之下。如果她的意志要我們滅亡，那麼我們就該滅亡。"
})

------------
-- Blade Lord Ta'yak --
------------
L = DBM:GetModLocalization(744)

-------------------------------
-- Garalon --
-------------------------------
L = DBM:GetModLocalization(713)

L:SetWarningLocalization({
	specwarnUnder	= "離開紫色圓圈範圍!"
})

L:SetOptionLocalization({
	specwarnUnder	= "當你在紫色圓圈範圍內顯示特別警告",
})

L:SetMiscLocalization({
	UnderHim	= "在他下面",
	Phase2		= "巨大的裝甲開始破裂並粉碎!"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L = DBM:GetModLocalization(741)

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s在>%s<(%d)",
	warnReshapeLifeTutor		= "1:中斷/易傷(使用這招堆疊易傷), 2:中斷自己所施放的琥珀爆炸, 3:回復意志力當意志力低落(主要是P3使用), 4:脫離魁儡(P1和P2使用)",
	warnAmberExplosion			= ">%s<正在施放%s",
	warnAmberExplosionAM		= "琥珀巨怪正在施放琥珀爆炸 - 快中斷!",
	warnInterruptsAvailable		= "可為%s使用中斷:>%s<",
	warnWillPower				= "目前的意志力:%s",
	specwarnWillPower			= "意志力低落! - 離開變身或是吃黃水",
	specwarnAmberExplosionYou	= "中斷你自己的%s!",
	specwarnAmberExplosionAM	= "%s:中斷%s!",
	specwarnAmberExplosionOther	= "%s:中斷%s!"
})

L:SetTimerLocalization({
	timerDestabalize		= "動搖 (%2$d):%1$s",
	timerAmberExplosionAMCD	= "琥珀爆炸冷卻:琥珀巨怪"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "顯示突變魁儡的能力說明效果",
	warnAmberExplosion			= "為$spell:122398施放顯示警告(以及來源)",
	warnAmberExplosionAM		= "為琥珀巨怪的$spell:122398顯示個人警告(為了中斷)",
	warnInterruptsAvailable		= "提示誰有琥珀打擊可使用以中斷$spell:122402",
	warnWillPower				= "提示目前意志力在80,50,30,10,和4.",
	specwarnWillPower			= "為在傀儡裡時意志力低落顯示特別警告",
	specwarnAmberExplosionYou	= "為中斷你自己的$spell:122398顯示特別警告",
	specwarnAmberExplosionAM	= "為中斷琥珀巨怪的$spell:122402顯示特別警告",
	specwarnAmberExplosionOther	= "為中斷突變傀儡的$spell:122398顯示特別警告",
	timerAmberExplosionAMCD		= "為琥珀巨怪下一次的$spell:122402顯示計時器",
	InfoFrame					= "為玩家的意志力顯示訊息框架"
})

L:SetMiscLocalization({
	WillPower	= "意志力"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "琥珀陷阱:(%d/5)"
})

L:SetOptionLocalization({
	warnAmberTrap	= "為$spell:125826的製作進度顯示警告",
	InfoFrame		= "為受到$spell:125390的玩家顯示訊息框架"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "凝視",
	YellPhase3		= "不要再找藉口了，女皇!消滅這些侏儒，否則我會親自殺了妳!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "恐懼之心小怪"
})

------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "輪到小隊:%s",
	specWarnYourGroup	= "輪到你的小隊!"
})

L:SetOptionLocalization({
	warnGroupOrder		= "提示$spell:118191的隊伍輪班<br/>(目前只支援25人5,2,2,2,戰術)",
	specWarnYourGroup	= "為$spell:118191顯示特別警告當輪到你的隊伍時(只適用於25人)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "<br/>(當你有debuff時只顯示其他沒有debuff的玩家)"
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory	= "謝謝你，陌生人。我重獲自由了。"
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver	= "%s結束"
})

L:SetTimerLocalization({
	timerSpecialCD	= "特別技能冷卻(%d)"
})

L:SetOptionLocalization({
	warnHideOver	= "為$spell:123244結束顯示警告",
	timerSpecialCD	= "為下一次特別技能冷卻顯示計時器",
	RangeFrame		= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .. "<br/>(消失時顯示所有玩家其餘時間只有顯示坦)"
})

L:SetMiscLocalization{
	Victory	= "我...啊..喔!我曾經...?我是不是...?這一切...都太...模糊了。"
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "向前穿過去",
	MoveRight					= "向右移動",
	MoveBack					= "回到原本位置",
	specWarnBreathOfFearSoon	= "恐懼之息來臨 - 移動到光牆裡!"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD	= "下一次特別技能",
	timerSpoHudCD			= "恐懼畏縮/水魄冷卻",
	timerSpoStrCD			= "水魄/嚴厲襲擊冷卻",
	timerHudStrCD			= "恐懼畏縮/嚴厲襲擊冷卻"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "當你在平台時顯示$spell:119414警告<br/>(不建議使用，團隊隊長使用)",
	specWarnBreathOfFearSoon	= "為$spell:119414顯示提前特別警告如果你身上沒有$spell:117964增益",
	specWarnMovement			= "當$spell:120047施放時顯示移動的特別警告",
	timerSpecialAbility 		= "為下一次特別技能施放顯示計時器"
})

--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove	= "%s即將到來 - 離開導電水池!"
})

L:SetOptionLocalization({
	specWarnWaterMove	= "為$spell:137313施放前或$spell:138732效果消失前顯示特別警告"
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "控獸寶珠掉落",
	specWarnOrbofControl	= "控獸寶珠掉落!"
})

L:SetTimerLocalization({
	timerDoor	= "下一個部族的門",
	timerAdds	= "下一波%s"
})

L:SetOptionLocalization({
	warnAdds				= "提示新的小怪跳下",
	warnOrbofControl		= "提示$journal:7092掉落",
	specWarnOrbofControl	= "為$journal:7092掉落顯示特別警告",
	timerDoor				= "為下一個部族的門顯示計時器",
	timerAdds				= "為下一次小怪跳下顯示計時器",
	SetIconOnAdds			= "為台上跳下的小怪設置團隊圖示"
})

L:SetMiscLocalization({
	newForces		= "的門蜂擁而出!",
	chargeTarget	= "用力拍動尾巴!"
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed	= "%s在%s - 快換目標"
})

L:SetOptionLocalization({
	AnnounceCooldowns	= "為團隊冷卻數出$spell:137166施放(數到3)"
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s被>%s<使用(還剩餘%d)",
	specWarnCrystalShell	= "取得%s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "當你沒有$spell:137633減益並且血量大於90%時顯示特別警告",
	InfoFrame				= "為玩家沒有$spell:137633顯示訊息框架",
	ClearIconOnTurtles		= "當$journal:7129中了$spell:133971清除團隊圖示",
	AnnounceCooldowns		= "為團隊冷卻數出$spell:134920施放"
})

L:SetMiscLocalization({
	WrongDebuff	= "沒有%s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD	= "下一次吐息"
})

L:SetOptionLocalization({
	timerBreaths			= "為下一次吐息顯示計時器",
	AnnounceCooldowns		= "為團隊冷卻數出暴怒施放",
	Never					= "絕不",
	Every					= "每次(連續)",
	EveryTwo				= "數到2",
	EveryThree				= "數到3",
	EveryTwoExcludeDiff		= "數到2(除了祕法散射)",
	EveryThreeExcludeDiff	= "數到3(除了祕法散射)"
})

L:SetMiscLocalization({
	rampageEnds	= "梅賈拉的怒氣平息了。"
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock			= "%s %s %s",
	specWarnFlock		= "%s %s %s",
	specWarnBigBird		= "巢穴守護者:%s",
	specWarnBigBirdSoon	= "巢穴守護者即將出現:%s"
})

L:SetTimerLocalization({
	timerFlockCD	= "蛋巢(%d):%s"
})

L:SetOptionLocalization({
	ShowNestArrows	= "為蛋巢孵化顯示DBM箭頭",
	Never			= "從不",
	Northeast		= "藍 - 上層&下層 東北",
	Southeast		= "綠 - 上層&下層 東南",
	Southwest		= "紫 - 下層 西南 & 上層 西南(25)或上層 中間(10)",
	West			= "紅 - 下層 西 & 上層 中間(只有25)",
	Northwest		= "黃 - 下層 & 上層 西北(只有25)",
	Guardians		= "巢穴守護者"
})

L:SetMiscLocalization({
	eggsHatch		= "巢裡的蛋開始孵化了!",
	Upper			= "上層",
	Lower			= "下層",
	UpperAndLower	= "上層和下層",
	TrippleD		= "三個巢(下層x2)",
	TrippleU		= "三個巢(上層x2)",
	NorthEast		= "|cff0000ff東北|r",--Blue
	SouthEast		= "|cFF088A08東南|r",--Green
	SouthWest		= "|cFF9932CD西南|r",--Purple
	West			= "|cffff0000西邊|r",--Red
	NorthWest		= "|cffffff00西北|r",--Yellow
	Middle10		= "|cFF9932CD中間|r",--Purple (Middle is upper southwest on 10 man/LFR)
	Middle25		= "|cffff0000中間|r"--Red (Middle is upper west on 25 man)
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "|cffff0000紅|r:>%s<,|cff0000ff藍|r:>%s<",
	warnBeamHeroic				= "|cffff0000紅|r:>%s<,|cff0000ff藍|r:>%s<,|cffffff00黃|r:>%s<",
	warnAddsLeft				= "霧獸還剩餘:%d",
	specWarnBlueBeam			= "你中了藍光射線 - 避免移動!!",
	specWarnFogRevealed			= "照出%s了!",
	specWarnDisintegrationBeam	= "%s(%s)"
})

L:SetOptionLocalization({
	warnBeam			= "提示射線目標",
	warnAddsLeft		= "提示還剩餘多少霧獸",
	specWarnFogRevealed	= "為照出霧獸顯示特別警告",
	ArrowOnBeam			= "為$journal:6882指示DBM箭頭移動方向",
	InfoFrame			= "為$spell:133795堆疊顯示訊息框架",
	SetParticle			= "開戰後自動將投影材質調為低(離開戰鬥後恢復設定)"
})

L:SetMiscLocalization({
	LifeYell	= "%s中了生命吸取(%d層)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount		= "突變:%d/5有益和%d有害"
})

L:SetOptionLocalization({
	warnDebuffCount		= "當你吃池水時顯示減益計算警告",
	SetIconOnBigOoze	= "為$journal:6969設定團隊圖示"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped	= "%s:>%s<和>%s<交換"
})

L:SetOptionLocalization({
	warnMatterSwapped	= "提示目標被$spell:138618交換"
})

L:SetMiscLocalization({
	Pull	= "血靈球體爆炸了!"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone	= "%s:%s跟%s開盾"
})

L:SetOptionLocalization({
	RangeFrame	= "顯示動態距離框架(當太多人太接近時會動態顯示)",
	InfoFrame	= "為玩家有$spell:136193顯示訊息框架"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight	= "黑夜階段",
	warnDay		= "白天階段",
	warnDusk	= "黃昏階段"
})

L:SetTimerLocalization({
	timerDayCD	= "白天階段",
	timerDuskCD	= "黃昏階段"
})

L:SetMiscLocalization({
	DuskPhase	= "盧凜!借本宮力量!"
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "超級充能導雷管階段即將到來",
	warnDiffusionChainSpread	= "%s擴散在>%s<"
})

L:SetTimerLocalization({
	timerConduitCD	= "第一次導管技能冷卻"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "在超級充能導雷管階段前顯示預先特別警告",
	warnDiffusionChainSpread	= "提示$spell:135991擴散的目標",
	timerConduitCD				= "為第一次導管技能冷卻顯示計時器",
	StaticShockArrow			= "當某人中了$spell:135695顯示DBM箭頭",
	OverchargeArrow				= "當某人中了$spell:136295顯示DBM箭頭"
})

L:SetMiscLocalization({
	StaticYell	= "%s中了靜電震擊(%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump	= "動盪生命傳到你身上!"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump	= "當$spell:138297傳遞你身上時顯示特別警告"
})

L:SetMiscLocalization({
	Defeat	= "慢著!"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name	="雷霆王座小怪"
})

---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory	= "啊，你成功了!水又再次純淨了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures	= "絕處求生即將到來(%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime	= "很好，我會創造一個力場隔離你們的腐化。"
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment	= "為腐化的碎片設置圖示"
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen	= "砲塔門被打開了",
	warnTowerGrunt	= "塔防蠻兵"
})

L:SetTimerLocalization({
	timerTowerCD		= "下一波塔攻",
	timerTowerGruntCD	= "下一次塔防蠻兵"
})

L:SetOptionLocalization({
	warnTowerOpen		= "提示砲塔門被打開",
	warnTowerGrunt		= "提示新的塔防蠻兵重生",
	timerTowerCD		= "為下一波塔攻顯示計時器",
	timerTowerGruntCD	= "為下一次塔防蠻兵顯示計時器"
})

L:SetMiscLocalization({
	wasteOfTime		= "做得好!登陸小隊，集合!步兵打前鋒!",
	wasteOfTime2	= "很好，第一梯隊已經登陸。",
	Pull			= "龍喉氏族，奪回碼頭，把他們推進海裡!以地獄吼及正統部落之名!",
	newForces1		= "他們來了!",
	newForces1H		= "趕快把她弄下來，讓我用手掐死她。",
	newForces2		= "龍喉氏族，前進!",
	newForces3		= "為了地獄吼!",
	newForces4		= "下一隊，前進!",
	tower			= "的門已經遭到破壞!"
})

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "%s的囚犯被釋放 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "%d秒後防禦姿態"
})

L:SetMiscLocalization({
	newForces1	= "戰士們，快點過來!",
	newForces2	= "守住大門!",
	newForces3	= "重整部隊!",
	newForces4	= "柯爾克隆，來我身邊!",
	newForces5	= "下一隊，來前線!",
	allForces	= "所有柯爾克隆...聽我號令...殺死他們!",
	nextAdds	= "下一次小兵: "
})

------------------------
-- Spoils of Pandaria --
------------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "我們在錄音嗎?有嗎?好。哥布林-泰坦控制模組開始運作，請後退。",
	Module1 	= "模組一號已準備好系統重置。",
	Victory		= "模組二號已準備好系統重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "顯示動態距離框架(10碼)<br/>(這是智慧距離框架，當到達血之狂暴階段時自動切換)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "尚未完成的武器開始從生產線上掉落。",
	newShredder	= "有個自動化伐木機靠近了!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "你虛弱於%s - 換坦!",
	specWarnMoreParasites		= "你需要更多的寄生蟲 - 不要開招!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "當你虛弱於活動的議會成員時顯示特別警告",
	specWarnMoreParasites		= "當你需要更多寄生蟲時顯示特別警告"
})

L:SetMiscLocalization({
	one				= "一",
	two				= "二",
	three			= "三",
	four			= "四",
	five			= "五",
	hisekFlavor		= "現在是誰寂然無聲啊",
	KilrukFlavor	= "又是個撲殺蟲群的一天",
	XarilFlavor		= "我只在你的未來看到黑色天空",
	KaztikFlavor	= "減少隻昆蟲的蟲害",
	KaztikFlavor2	= "1隻螳螂倒下了，還有199隻要殺",
	KorvenFlavor	= "古代帝國的終結",
	KorvenFlavor2	= "拿著你的葛薩尼石板窒息吧",
	IyyokukFlavor	= "看到機會。剝削他們!",
	KarozFlavor		= "你再也跳不起來了!",
	SkeerFlavor		= "一份血腥的喜悅!",
	RikkalFlavor	= "已滿足樣本要求"
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetOptionLocalization({
	timerRoleplay		= "為卡爾洛斯/索爾劇情事件顯示計時器",
	RangeFrame			= "顯示動態距離框架(10碼)<br/>(這是智慧距離框架，當到達$spell:147126門檻時自動切換)",
	InfoFrame			= "為玩家在中場階段時沒有傷害減免顯示訊息框架"
})

L:SetMiscLocalization({
	wasteOfTime		= "卡爾洛斯，現在還不遲。放下大酋長的權力。我們可以在此時此地就結束，停止流血。",
	NoReduce		= "無傷害減免",
	phase3End		= "你們以為贏了嗎?"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "圍攻奧格瑪小兵"
})
