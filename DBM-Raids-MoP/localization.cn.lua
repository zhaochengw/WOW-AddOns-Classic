-- Mini Dragon(projecteurs[at]gmail.nospam.com) <流浪者酒馆-Brilla@金色平原> 20240414

if GetLocale() ~= "zhCN" then
	return
end
local L

--魔古山宝库--
------------
-- The Stone Guard --
------------
L = DBM:GetModLocalization(679)

L:SetWarningLocalization({
	SpecWarnOverloadSoon		= "%s: 即将施放", -- prepare survival ablility or move boss. need more specific message.
	specWarnBreakJasperChains	= "扯断红玉锁链！"
})

L:SetOptionLocalization({
	SpecWarnOverloadSoon		= "特殊警报：过载预警", -- need to change this, i can not translate this with good grammer. please help.
	specWarnBreakJasperChains	= "特殊警报：可扯断$spell:130395",
	InfoFrame					= "信息框：石像能量及激活情况"
})

L:SetMiscLocalization({
	Overload	= "%s即将过载！"
})

------------
-- Feng the Accursed --
------------
L = DBM:GetModLocalization(689)

L:SetWarningLocalization({
	WarnPhase			= "第%d阶段",
	specWarnBarrierNow	= "快使用废灵壁垒！"
})

L:SetOptionLocalization({
	WarnPhase			= "警报：阶段转换",
	specWarnBarrierNow	= "特殊警报：当你需要使用$spell:115817 时(限随机团)",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT_SHORT:format("6") .. " 应对奥术阶段"
})

L:SetMiscLocalization({
	Fire	= "噢，至高的神！借我之手融化他们的血肉吧！",
	Arcane	= "噢，上古的贤者！赐予我魔法的智慧吧！",
	Nature	= "噢，伟大的神灵！赐予我大地的力量！",
	Shadow	= "先烈的英灵！用你的盾保护我吧！"
})

-------------------------------
-- Gara'jal the Spiritbinder --
-------------------------------
L = DBM:GetModLocalization(682)

L:SetMiscLocalization({
	Pull	= "死亡时间到！"
})

----------------------
-- The Spirit Kings --
----------------------
L = DBM:GetModLocalization(687)

L:SetWarningLocalization({
	DarknessSoon	= "黑暗之盾：%d秒后施放"
})

L:SetTimerLocalization({
	timerUSRevive		= "不灭之影复活",
	timerRainOfArrowsCD	= "%s"
})

L:SetOptionLocalization({
	DarknessSoon	= "预警：$spell:117697（提前5秒倒计时）",
	timerUSRevive	= "计时条：$spell:117506复活"
})

------------
L = DBM:GetModLocalization(726)

L:SetWarningLocalization({
	specWarnDespawnFloor	= "6秒后地板消失！"
})

L:SetTimerLocalization({
	timerDespawnFloor	= "地板消失"
})

L:SetOptionLocalization({
	specWarnDespawnFloor	= "特殊警报：地板消失预警",
	timerDespawnFloor		= "计时条：地板消失"
})

------------
-- Will of the Emperor --
------------
L = DBM:GetModLocalization(677)

L:SetOptionLocalization({
	InfoFrame		= "信息框：受$spell:116525效果影响的玩家",
	CountOutCombo	= "统计$journal:5673次数<br/>注：当前仅有女性声音设置",
	ArrowOnCombo	= "DBM箭头：$journal:5673阶段<br/>注：该功能正常工作的前提是坦克在Boss面前而其他人在Boss身后"
})

L:SetMiscLocalization({
	Pull		= "机器开始嗡嗡作响了！到下层去！",--Emote
	Rage		= "皇帝之怒响彻群山。",--Yell
	Strength	= "皇帝的力量出现在壁龛中！",--Emote
	Courage		= "皇帝的勇气出现在壁龛中！",--Emote
	Boss		= "两个巨型构造体出现在大型的壁龛中！"--Emote
})

--恐惧之心--
------------
-- Imperial Vizier Zor'lok --
------------
L = DBM:GetModLocalization(745)

L:SetWarningLocalization({
	warnEcho			= "回响出现",
	warnEchoDown		= "回响被击败",
	specwarnAttenuation	= "%s：%s (%s)",
	specwarnPlatform	= "换平台"
})

L:SetOptionLocalization({
	warnEcho			= "警报：回响出现",
	warnEchoDown		= "警报：回响被击败",
	specwarnPlatform	= "特殊警报：改变平台",
	ArrowOnAttenuation	= "DBM箭头：在$spell:127834阶段指示移动方向"
})

L:SetMiscLocalization({
	Platform	= "朝他其中一个平台飞去了！",
	Defeat		= "我们不会向黑暗虚空的绝望屈服。如果女皇要我们去死，我们便照做。"
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
	warnCrush		= "%s",
	specwarnUnder	= "远离紫圈！"
})

L:SetOptionLocalization({
	specwarnUnder	= "特殊警报：当你在首领身体下方时"
})

L:SetMiscLocalization({
	UnderHim	= "在它下方",
	Phase2		= "巨型盔甲开始碎裂了"
})

----------------------
-- Wind Lord Mel'jarak --
----------------------
L = DBM:GetModLocalization(741)

--L:SetMiscLocalization({
--	Reinforcements	= "风领主梅尔加拉克调遣援兵了！"
--})

------------
-- Amber-Shaper Un'sok --
------------
L = DBM:GetModLocalization(737)

L:SetWarningLocalization({
	warnReshapeLife				= "%s：>%s< (%d)",--Localized because i like class colors on warning and shoving a number into targetname broke it using the generic.
	warnReshapeLifeTutor		= "1：打断/减益目标，2：打断自己，3：回复生命/意志，4：离开构造体",
	warnAmberExplosion			= "%s 正在施放 %s",
	warnAmberExplosionAM		= "琥珀畸怪正在施放琥珀爆炸 - 快打断！",--personal warning.
	warnInterruptsAvailable		= "可打断 %s: >%s<",
	warnWillPower				= "当前意志：%s",
	specwarnWillPower			= "意志低下！- 还剩5秒",
	specwarnAmberExplosionYou	= "打断%s！",--Struggle for Control interrupt.
	specwarnAmberExplosionAM	= "%s：打断 %s!",--Amber Montrosity
	specwarnAmberExplosionOther	= "%s：打断 %s!"--Mutated Construct
})

L:SetTimerLocalization({
	timerDestabalize		= "动摇意志（%2$d）：%1$s",
	timerAmberExplosionAMCD	= "爆炸冷却：琥珀畸怪"
})

L:SetOptionLocalization({
	warnReshapeLifeTutor		= "当变为变异构造体时显示技能及其作用",
	warnAmberExplosion			= "警报：$spell:122398正在施放，并警报来源",
	warnAmberExplosionAM		= "个人警报：打断琥珀畸怪的$spell:122398",
	warnInterruptsAvailable		= "警报：可使用$spell:122402打断琥珀打击的成员",
	warnWillPower				= "警报：当前意志剩余80、50、30、10以及4点时",
	specwarnWillPower			= "特殊警报：在变异构造体中意志低下时",
	specwarnAmberExplosionYou	= "特殊警报：打断自己的$spell:122398",
	specwarnAmberExplosionAM	= "特殊警报：打断琥珀畸怪的$spell:122402",
	specwarnAmberExplosionOther	= "特殊警报：打断变异构造体的$spell:122398",
	timerAmberExplosionAMCD		= "计时条：琥珀畸怪的下一次$spell:122402",
	InfoFrame					= "信息框：意志值",
	FixNameplates				= "在变为构造体时自动关闭烦人的姓名版<br/>(离开战斗时恢复)"
})

L:SetMiscLocalization({
	WillPower	= "意志"
})

------------
-- Grand Empress Shek'zeer --
------------
L = DBM:GetModLocalization(743)

L:SetWarningLocalization({
	warnAmberTrap	= "琥珀陷阱：%d/5"
})

L:SetOptionLocalization({
	warnAmberTrap	= "警报：$spell:125826的生成，并提示进度", -- maybe bad translation.
	InfoFrame		= "信息框：受$spell:125390效果影响的玩家"
})

L:SetMiscLocalization({
	PlayerDebuffs	= "凝视",
	YellPhase3		= "别找借口了，女皇！消灭这些傻瓜，否则我会亲手杀了你！"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("HoFTrash")

L:SetGeneralLocalization({
	name	= "恐惧之心小怪"
})

--永春台--
------------
-- Protectors of the Endless --
------------
L = DBM:GetModLocalization(683)

L:SetWarningLocalization({
	warnGroupOrder		= "循环：第%s小队",
	specWarnYourGroup	= "轮到你的小对了！"
})

L:SetOptionLocalization({
	warnGroupOrder		= "警报：针对$spell:118191的小队循环<br/>（当前仅支持25人模式的5/2/2/2战术）",
	specWarnYourGroup	= "特殊警报：当轮到你的小队需要应对$spell:118191时<br/>（仅25人模式）",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(8, 111850) .. "（当你受到效果影响时会显示其他所有没有受到效果影响的队友）"
})

------------
-- Tsulong --
------------
L = DBM:GetModLocalization(742)

L:SetMiscLocalization{
	Victory				= "谢谢你，陌生人。我自由了。"
}

-------------------------------
-- Lei Shi --
-------------------------------
L = DBM:GetModLocalization(729)

L:SetWarningLocalization({
	warnHideOver		= "%s 结束"
})

L:SetTimerLocalization({
	timerSpecialCD		= "特殊能力冷却（%d）"
})

L:SetOptionLocalization({
	warnHideOver		= "特殊警报：$spell:123244效果结束时",
	timerSpecialCD		= "计时条：特殊技能冷却",
--	SetIconOnProtector	= "为$journal:6224的目标添加团队标记<br/>（当有多名团队助理时该功能不可靠）",
	RangeFrame			= DBM_CORE_L.AUTO_RANGE_OPTION_TEXT:format(3, 123121) .."（隐藏阶段时显示所有人，其余时仅显示坦克位置）"
})

L:SetMiscLocalization{
	Victory				= "我……啊……噢！我……？眼睛……好……模糊。"--wtb alternate and less crappy victory event.
}

----------------------
-- Sha of Fear --
----------------------
L = DBM:GetModLocalization(709)

L:SetWarningLocalization({
	MoveForward					= "穿过金莲之影",
	MoveRight					= "向右移动",
	MoveBack					= "返回原位",
	specWarnBreathOfFearSoon	= "即将恐惧吐息 - 快到光墙内！"
})

L:SetTimerLocalization({
	timerSpecialAbilityCD		= "下一次特殊能力",
	timerSpoHudCD				= "畏惧/水涌冷却",
	timerSpoStrCD				= "水涌/打击冷却",
	timerHudStrCD				= "畏惧/打击冷却"
})

L:SetOptionLocalization({
	warnBreathOnPlatform		= "警报：当你在平台时的$spell:119414（不推荐，为团长准备）",
	specWarnBreathOfFearSoon	= "特殊警报：当没有$spell:117964效果需要躲避$spell:119414时",
	specWarnMovement			= "特殊警报：$spell:120047时的移动",
	timerSpecialAbility			= "计时条：下一次特殊能力"
})


--雷电王座--
--------------------------
-- Jin'rokh the Breaker --
--------------------------
L = DBM:GetModLocalization(827)

L:SetWarningLocalization({
	specWarnWaterMove		= "%s 即将到来 - 离开黑水！"
})

L:SetOptionLocalization({
	specWarnWaterMove		= "特殊警报：当你站在 $spell:138470 时<br/>($spell:137313 即将施放时或者 $spell:138732 debuff刚消失时)"
})

--------------
-- Horridon --
--------------
L = DBM:GetModLocalization(819)

L:SetWarningLocalization({
	warnAdds				= "%s",
	warnOrbofControl		= "支配宝珠掉落",
	specWarnOrbofControl	= "支配宝珠掉落！"
})

L:SetTimerLocalization({
	timerDoor				= "下一个部族大门",
	timerAdds				= "下一次%s"
})

L:SetOptionLocalization({
	warnAdds				= "警报：新的敌人加入战斗",
	warnOrbofControl		= "警报：$journal:7092 掉落",
	specWarnOrbofControl	= "特殊警报：$journal:7092 掉落",
	timerDoor				= "计时条：下一个部族大门阶段",
	timerAdds				= "计时条：下一次小怪",
	SetIconOnAdds			= "为跳下来的小怪设置标记"
})

L:SetMiscLocalization({
	newForces				= "法拉基大军从法拉基部族之门中涌出！",--Farraki forces pour from the Farraki Tribal Door!
	chargeTarget			= "并开始拍打他的尾巴！"--Horridon sets his eyes on Eraeshio and stamps his tail!
})

---------------------------
-- The Council of Elders --
---------------------------
L = DBM:GetModLocalization(816)

L:SetWarningLocalization({
	specWarnPossessed		= "%s -> %s - 改变目标"
})

L:SetOptionLocalization({
	AnnounceCooldowns		= "为 $spell:137166 的释放提供团队计数 (最多3个)"
})

------------
-- Tortos --
------------
L = DBM:GetModLocalization(825)

L:SetWarningLocalization({
	warnKickShell			= "%s由>%s<使用（%d次剩余）",
	specWarnCrystalShell	= "快去获得%s"
})

L:SetOptionLocalization({
	specWarnCrystalShell	= "特殊警报：当没有$spell:137633并且你的生命值低于90%时",
	InfoFrame				= "信息框：没有$spell:137633效果的团员",
	ClearIconOnTurtles		= "当受到 $spell:133971 的影响时清除 $journal:7129 的团队标记",
	AnnounceCooldowns		= "忽略 $spell:134920 造成的团队计数"
})

L:SetMiscLocalization({
	WrongDebuff				= "没有%s"
})

-------------
-- Megaera --
-------------
L = DBM:GetModLocalization(821)

L:SetTimerLocalization({
	timerBreathsCD			= "下一次吐息"
})

L:SetOptionLocalization({
	timerBreaths			= "计时条：下一次吐息",
	AnnounceCooldowns		= "为狂暴提供团队计数的方式",
	Never					= "从不",
	Every					= "每次 (连续)",
	EveryTwo				= "2次狂暴循环",
	EveryThree				= "3次狂暴循环",
	EveryTwoExcludeDiff		= "2次狂暴循环 (排除专注的头)",
	EveryThreeExcludeDiff	= "3次狂暴循环 (排除专注的头)"
})

L:SetMiscLocalization({
	rampageEnds	= "墨格瑞拉的怒火平息了。"
})

------------
-- Ji-Kun --
------------
L = DBM:GetModLocalization(828)

L:SetWarningLocalization({
	warnFlock				= "%s %s (%d)",
	specWarnFlock			= "%s %s (%d)",
	specWarnBigBird			= "巢穴守卫: %s",
	specWarnBigBirdSoon		= "即将到来的巢穴守卫: %s"
})

L:SetTimerLocalization({
	timerFlockCD			= "巢穴 (%d): %s"
})

L:SetOptionLocalization({
	ShowNestArrows			= "为下一个激活的鸟窝显示DBM箭头",
	Never					= "从不",
	Northeast				= "蓝-上下层东北",
	Southeast				= "绿-上下层东南",
	Southwest				= "紫/红-下层西南&上层西南(25人)或上层中间(10人)",
	West					= "红-下层西边&上层中间(25人)",
	Northwest				= "黄-上下层东西北（25人）",
	Guardians				= "巢穴守卫"
})

L:SetMiscLocalization({
	eggsHatch				= "某个鸟巢中的蛋开始孵化了",
	Upper					= "上层",
	Lower					= "下层",
	UpperAndLower			= "上下都有",
	TrippleD				= "三次 (2x下)",
	TrippleU				= "三次 (2x上)"
})

--------------------------
-- Durumu the Forgotten --
--------------------------
L = DBM:GetModLocalization(818)

L:SetWarningLocalization({
	warnBeamNormal				= "光线 - |cffff0000红|r ： >%s<, |cff0000ff蓝|r ： >%s<",
	warnBeamHeroic				= "光线 - |cffff0000红|r ： >%s<, |cff0000ff蓝|r ： >%s<, |cffffff00黄|r ： >%s<",
	warnAddsLeft				= "迷雾剩余：%d",
	specWarnBlueBeam			= "蓝光点你 - 别动",
	specWarnFogRevealed			= "%s 出现了！",
	specWarnDisintegrationBeam	= "%s (%s)"
})

L:SetOptionLocalization({
	warnBeam					= "警报：光线照射的目标",
	warnAddsLeft				= "警报：剩余的迷雾",
	specWarnFogRevealed			= "特殊警报：当迷雾被发现时",
	ArrowOnBeam					= "DBM箭头： 为 $journal:6882 提示逃跑方向",
	InfoFrame					= "信息框： $spell:133795 层数",
	SetParticle					= "开战后自动设置粒子效果为低<br/>(战斗结束后还原)"
})

L:SetMiscLocalization({
	LifeYell				= " %s 中了生命吸取 (%d)"
})

----------------
-- Primordius --
----------------
L = DBM:GetModLocalization(820)

L:SetWarningLocalization({
	warnDebuffCount			= "进化进度： 好- %d/5 ，坏- %d"
})

L:SetOptionLocalization({
	warnDebuffCount			= "当你吸收了池子后显示debuff计数",
	SetIconOnBigOoze		= "为 $journal:6969 设置标记"
})

-----------------
-- Dark Animus --
-----------------
L = DBM:GetModLocalization(824)

L:SetWarningLocalization({
	warnMatterSwapped		= "%s：>%s<、>%s<交换"
})

L:SetOptionLocalization({
	warnMatterSwapped		= "警报：$spell:138618交换的目标"
})

L:SetMiscLocalization({
	Pull					= "宝珠爆炸了！"
})

--------------
-- Iron Qon --
--------------
L = DBM:GetModLocalization(817)

L:SetWarningLocalization({
	warnDeadZone			= "%s：%s、%s被保护"
})

L:SetOptionLocalization({
	RangeFrame				= "距离监视（动态，当存在多名团员过近时显示）",
	InfoFrame				= "信息框：中了 $spell:136193 的玩家"
})

-------------------
-- Twin Consorts --
-------------------
L = DBM:GetModLocalization(829)

L:SetWarningLocalization({
	warnNight				= "黑夜阶段",
	warnDay					= "白天阶段",
	warnDusk				= "黄昏阶段"
})

L:SetTimerLocalization({
	timerDayCD				= "下一个白天阶段",
	timerDuskCD				= "下一个黄昏阶段"
})

L:SetMiscLocalization({
	DuskPhase				= "露琳！将你的力量借给我！"--Not in use, but a backup just in case, so translate in case it's switched to on moments notice on live or next PTR test
})

--------------
-- Lei Shen --
--------------
L = DBM:GetModLocalization(832)

L:SetWarningLocalization({
	specWarnIntermissionSoon	= "准备中场阶段",
	warnDiffusionChainSpread	= "%s 传导给 >%s<"
})

L:SetTimerLocalization({
	timerConduitCD				= "第一个导管CD"
})

L:SetOptionLocalization({
	specWarnIntermissionSoon	= "特殊警报：中场阶段",
	warnDiffusionChainSpread	= "警报： $spell:135991 传导的目标",
	timerConduitCD				= "计时条：第一个导管技能CD",
	StaticShockArrow			= "DBM箭头：受 $spell:135695 影响的玩家",
	OverchargeArrow				= "DBM箭头：受 $spell:136295 影响的玩家"
})

L:SetMiscLocalization({
	StaticYell					= "%s 中了静电冲击 (%d)"
})

------------
-- Ra-den --
------------
L = DBM:GetModLocalization(831)

L:SetWarningLocalization({
	specWarnUnstablVitaJump		= "你中了不稳定的生命！"
})

L:SetOptionLocalization({
	specWarnUnstablVitaJump		= "特殊警报： 当 $spell:138297 跳到你身上时"
})

L:SetMiscLocalization({
	Defeat						= "等等！我"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("ToTTrash")

L:SetGeneralLocalization({
	name						= "雷电王座小怪"
})


--围攻奥格瑞玛--
---------------
-- Immerseus --
---------------
L = DBM:GetModLocalization(852)

L:SetMiscLocalization({
	Victory					= "啊，你成功了!水又再次纯净了。"
})

---------------------------
-- The Fallen Protectors --
---------------------------
L = DBM:GetModLocalization(849)

L:SetWarningLocalization({
	specWarnMeasures		= "绝处求生即将到来(%s)!"
})

---------------------------
-- Norushen --
---------------------------
L = DBM:GetModLocalization(866)

L:SetMiscLocalization({
	wasteOfTime				= "很好，我会创造一个力场隔离你们的腐化。"
})

------------------
-- Sha of Pride --
------------------
L = DBM:GetModLocalization(867)

L:SetOptionLocalization({
	SetIconOnFragment		= "为腐化的碎片设置图示"
})

--------------
-- Galakras --
--------------
L = DBM:GetModLocalization(868)

L:SetWarningLocalization({
	warnTowerOpen			= "炮塔门被打开了",
	warnTowerGrunt			= "塔防蛮兵"
})

L:SetTimerLocalization({
	timerTowerCD		= "下一波塔攻",
	timerTowerGruntCD	= "下一次塔防蛮兵"
})

L:SetOptionLocalization({
	warnTowerOpen		= "提示炮塔门被打开",
	warnTowerGrunt		= "提示新的塔防蛮兵重生",
	timerTowerCD		= "为下一波塔攻显示计时器",
	timerTowerGruntCD	= "为下一次塔防蛮兵显示计时器"
})

L:SetMiscLocalization({
	wasteOfTime		= "做得好!登陆小，集合!步兵打前锋!",
	wasteOfTime2	= "很好，第一梯队已经登陆。",
	Pull			= "龙喉氏族，夺回码头，把他们推进海里去!以地狱咆哮及正統部落之名!",
	newForces1		= "他们来了!",
	newForces1H		= "赶快把她弄下来，让我用手掐死她。",
	newForces2		= "龙喉氏族，前进!",
	newForces3		= "为了地狱咆哮!",
	newForces4		= "下一队，前进!",
	tower			= "的门已经遭到破坏!"
})

--------------------
--Iron Juggernaut --
--------------------
L = DBM:GetModLocalization(864)

--------------------------
-- Kor'kron Dark Shaman --
--------------------------
L = DBM:GetModLocalization(856)

L:SetMiscLocalization({
	PrisonYell	= "%s的囚犯被释放 (%d)"
})

---------------------
-- General Nazgrim --
---------------------
L = DBM:GetModLocalization(850)

L:SetWarningLocalization({
	warnDefensiveStanceSoon	= "%d秒后防御姿态"
})

L:SetMiscLocalization({
	newForces1	= "战士们，快点过来!",
	newForces2	= "守住大门!",
	newForces3	= "重整部队!",
	newForces4	= "库卡隆，来我身边!",
	newForces5	= "下一队，来前线!",
	allForces	= "所有库卡隆...听我号令...杀死他们!",
	nextAdds	= "下一次小兵: "
})

------------------------
-- Spoils of Pandaria --
------------------------
L = DBM:GetModLocalization(870)

L:SetMiscLocalization({
	wasteOfTime	= "我们在录音吗?有吗?好。哥布林-泰坦控制模组开始运作，请后退。",
	Module1 	= "模组一号已准备好系統重置。",
	Victory		= "模组二号已准备好系統重置。"
})

---------------------------
-- Thok the Bloodthirsty --
---------------------------
L = DBM:GetModLocalization(851)

L:SetOptionLocalization({
	RangeFrame	= "显示动态距离框架(10码)<br/>(这是智慧距离框架，当到达血之狂暴阶段时自动切换)"
})

----------------------------
-- Siegecrafter Blackfuse --
----------------------------
L = DBM:GetModLocalization(865)

L:SetMiscLocalization({
	newWeapons	= "尚未完成的武器开始从生产线上掉落。",
	newShredder	= "有个自动化伐木机靠近了!"
})

----------------------------
-- Paragons of the Klaxxi --
----------------------------
L = DBM:GetModLocalization(853)

L:SetWarningLocalization({
	specWarnActivatedVulnerable	= "你虛弱于%s - 换坦!",
	specWarnMoreParasites		= "你需要更多的寄生虫 - 不要开招!"
})

L:SetOptionLocalization({
	specWarnActivatedVulnerable	= "当你虛弱于活动的议会成员时显示特別警告",
	specWarnMoreParasites		= "当你需要更多寄生虫时显示特別警告"
})

L:SetMiscLocalization({
	one				= "一",
	two				= "二",
	three			= "三",
	four			= "四",
	five			= "五",
	hisekFlavor		= "现在是谁寂然无声啊",
	KilrukFlavor	= "又是个扑杀虫群的一天",
	XarilFlavor		= "我只在你的未来看到黑色天空",
	KaztikFlavor	= "减少只昆虫的虫害",
	KaztikFlavor2	= "1只螳螂倒下了，还有199只要杀",
	KorvenFlavor	= "古代帝国的终结",
	KorvenFlavor2	= "拿着你的格萨尼石板窒息吧",
	IyyokukFlavor	= "看到机会。剥削他们!",
	KarozFlavor		= "你再也跳不起来了!",
	SkeerFlavor		= "一份血腥的喜悦!",
	RikkalFlavor	= "已满足样本要求"
})

------------------------
-- Garrosh Hellscream --
------------------------
L = DBM:GetModLocalization(869)

L:SetOptionLocalization({
	timerRoleplay		= "计时条：NPC剧情",
	RangeFrame			= "显示动态距离框架(10码)<br/>(这是智慧距离框架，当到达$spell:147126阈值时自动切换)",
	InfoFrame			= "为玩家在中场阶段时没有伤害减免显示信息框架"
})

L:SetMiscLocalization({
	wasteOfTime		= "现在还不迟，加尔鲁什。卸下酋长的包裹吧。我们可以就此结束这场流血冲突。",
	NoReduce		= "无减伤",
	phase3End		= "别以为你们已经赢了"
})

-------------
--  Trash  --
-------------
L = DBM:GetModLocalization("SoOTrash")

L:SetGeneralLocalization({
	name	= "围攻奥格瑞玛小兵"
})
