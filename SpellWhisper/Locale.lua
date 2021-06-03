--版本控制：1.9.3 输出新增HUD模式

local AddonName, Addon = ...

local L = setmetatable({}, {
    __index = function(table, key)
        if key then
            table[key] = tostring(key)
        end
        return tostring(key)
    end,
})

Addon.L = L

L["Feedback & Update Link"] = "https://www.curseforge.com/wow/addons/spellwhisper"

local locale = GetLocale()

if locale == "enUs" then
	--频道名称
    L["off"] = true
    L["say"] = true
    L["party"] = true
    L["raid"] = true
	L["self"] = true
	--Tips
	L["SPELLWHISPER TIPS"] = "|cFFBA55D3SpellWhisper|r Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF4500gui|r or |cFF00BFFF/sw|r |cFFFF4500gui|r open Option Interface, Use |cFF00BFFF/spellwhisper|r |cFFFF0000in|r or |cFF00BFFF/sw|r |cFFFF0000in|r for Delay Task."
	--输出格式化字符串
    L["SPELLWHISPER_TEXT_SENTTOGROUPSTART"] = "<Start>[#spell#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOGROUPDONE"] = "<Succeed>[#spell#]->[#target#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"] = "<Start>[#spell#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"] = "<Succeed>[#spell#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"] = "<Warning>Try to [#spell#]->[#target#], Change Target!"
	L["SPELLWHISPER_TEXT_BROKEN"] = "<Broken>[#caster#] [#spell#]->[#target#] [#spell_2#]"
	L["SPELLWHISPER_TEXT_INTERRUPT"] = "<Interrupt>[#caster#] [#spell#]->[#target#] [#spell_2#]"
	L["SPELLWHISPER_TEXT_MISSED"] = "<Failed>[#caster#] [#spell#]->[#target#] [#spell_2#]"
	L["SPELLWHISPER_TEXT_DISPEL"] = "<Dispal>[#caster#] [#spell#]->[#target#][#spell_2#]"
	L["SPELLWHISPER_TEXT_HEALINGFAILED"] = "<Attention>[#spell#] to you was failed cause by [#spell_2#]"
	L["SPELLWHISPER_TEXT_BGWARNING"] = "<Controlled>[#caster#] [#spell#]->[#target#]，Pos: [#pos#]"
	L["SPELLWHISPER_TEXT_THREAT"] = "<Threat>[%s]->[%s]"
	--Trades
	L["SPELLWHISPER_TEXT_TRADE_ERROR"] = "Trade with %s was failed, caused by %s."
	L["SPELLWHISPER_TEXT_TRADE_SUCCEED"] = "Trade with %s was succeed."
	L["SPELLWHISPER_TEXT_TRADE_ITEMS_RECEIVE"] = " Received #num# item(s), included #item# (#quantity#)."
	L["SPELLWHISPER_TEXT_TRADE_ITEMS_GIVE"] = " Gave #num# item(s), included #item# (#quantity#)."
	L["SPELLWHISPER_TEXT_TRADE_MONEY_RECEIVE"] = " Received %s."
	L["SPELLWHISPER_TEXT_TRADE_MONEY_GIVE"] = " Gave %s."
	L["SPELLWHISPER_TEXT_TRADE_ENCHANTMENT"] = " Item %s got Enchantment %s."
	--补全
	L["SPELLWHISPER_TEXT_SWINGATTACK"] = "Swing"
	L["SPELLWHISPER_TEXT_UNKNOWN"] = "Unknown"
	--Replay
    L["SPELLWHISPER_TEXT_FOLLOWREPLY"] = "OK, followed."
	L["SPELLWHISPER_TEXT_STOPFOLLOWREPLY"] = "Stopped."
	L["SPELLWHISPER_TEXT_FOLLOWFAILED_OUTOFRANGE"] = "Sorry, Out of Range."
	L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEON"] = "Done, Combat Follow Mode turned On."
	L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEOFF"] = "Done, Combat Follow Mode turned Off."
	L["SPELLWHISPER_TEXT_STOPFOLLOW_MANUALLY"] = "Stopped following."
	--英文客户端下直接返回key值
	--[[
	--法术技能失败原因
    L["ABSORB"] = true
	L["BLOCK"] = true
	L["DEFLECT"] = true
	L["DODGE"] = true
	L["EVADE"] = true
	L["IMMUNE"] = true
	L["MISS"] = true
	L["PARRY"] = true
	L["REFLECT"] = true
	L["RESIST"] = true
	--施法失败原因
	L["Out of Range"] = true
	L["Out of Sight"] = true
	--目标标记
	L["Star"] = true
	L["Circle"] = true
	L["Diamond"] = true
	L["Triangle"] = true
	L["Moon"] = true
	L["Square"] = true
	L["Cross"] = true
	L["Skull"] = true
	--法术技能
	L["Repentance"] = true
	L["Wyvern Sting"] = true
	L["Gouge"] = true
	L["Hammer of Justice"] = true
	L["Scatter Shot"] = true
	L["Blind"] = true
	L["Sap"] = true
	L["Death Coil"] = true
	L["Intimidating Shout"] = true
	L["Innervate"] = true
	L["Power Infusion"] = true
	L["Divine Intervention"] = true
	L["Blessing of Protection"] = true
	L["Blessing of Freedom"] = true
	L["Polymorph"] = true
	L["Hibernate"] = true
	L["Shackle Undead"] = true
	L["Banish"] = true
	L["Fear"] = true
	L["Entangling Roots"] = true
	L["Turn Undead"] = true
	L["Enslave Demon"] = true
	L["Scare Beast"] = true
	L["Rebirth"] = true
	L["Resurrection"] = true
	L["Redemption"] = true
	L["Ancestral Spirit"] = true
	L["Ritual of Summoning"] = true
	L["Soulstone Resurrection"] = true
	L["Holy Light"] = true
	L["Flash of Light"] = true
	L["Lay on Hands"] = true
	L["Holy Shock"] = true
	L["Lesser Healing Wave"] = true
	L["Healing Wave"] = true
	L["Chain Heal"] = true
	L["Healing Touch"] = true
	L["Regrowth"] = true
	L["Rejuvenation"] = true
	L["Swiftmend"] = true
	L["Power Word: Shield"] = true
	L["Heal"] = true
	L["Lesser Heal"] = true
	L["Renew"] = true
	L["Flash Heal"] = true
	L["Greater Heal"] = true
	L["Taunt"] = true
	L["Mocking Blow"] = true
	L["Challenging Shout"] = true
	L["Shield Slam"] = true
	L["Growl"] = true
	L["Challenging Roar"] = true
	L["Kidney Shot"] = true
	L["Feign Death"] = true
	L["Dispel Magic"] = true
	L["Purge"] = true
	]]
	--[[
	--Slash Command提示文字
	L["|cFFBA55D3SpellWhisper|r v%s|cFFB0C4DE is Loaded."] = true
    L["|cFFBA55D3SpellWhisper|r v%s is |cFF00FFFFEnabled|r."] = true
    L["|cFFBA55D3SpellWhisper|r v%s is |cFF00FFFFDisabled|r."] = true
    L["|cFFBA55D3SpellWhisper|r Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF4500gui|r or |cFF00BFFF/sw|r |cFFFF4500gui|r open Option Interface, |cFF00BFFF/spellwhisper|r |cFFFF0000in|r or |cFF00BFFF/sw|r |cFFFF0000in|r for Delay Task."] = true
	L["|cFFBA55D3SpellWhisper|r Delay Command Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r or |cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r create a Delay Task."] = true
	L["|cFFBA55D3SpellWhisper|r Delay Command Tips: Please Input |cFF00E09EValid|r |cFFCCA4E3[Seconds]|r and |cFF00E09ELegal|r |cFFCCA4E3[Command]|r!"] = true
	--Config界面文字
	L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"] = true
	L["|cFF00A0FFThanks to|r: Tachibana Babyannie and other guild members."] = true
	L["|cFF3A5FCDUsage|r:"] = true
	L["Anti Disturbance Time Slider will prevent Addon automatically\nsent repeat message. Time is threshold. Whisper Switch Check-\nBox will Enable/Disable Whisper Warning Function."] = true
	L["Enable |cFFBA55D3SpellWhisper|r"] = true
    L["Channel:"] = true
    L["Anti Disturbance Time"] = true
    L["OFF"] = true
    L["Whisper Mode"] = true
    L["Enable |cFFFFCC33Whisper|r"] = true
    L["Enable |cFF44CEF6TOT Whisper|r Warning"] = true
	L["BG Auto Report"] = true
	L["Enable |cFF0099FFBG Auto Report|r"] = true
	L["Auto Follow Setting"] = true
    L["|cFFFF99CCStart Follow|r KeyWords:"] = true
    L["|cFF999966Stop Follow|r KeyWords:"] = true
	]]

elseif locale == "zhCN" then
	--频道名称
    L["off"] = "关闭"
	L["say"] = "说"
	L["yell"] = "大喊"
    L["party"] = "队伍"
	L["raid"] = "团队"
	L["Raid_Warning"] = "团队警告"
	L["self"] = "自身可见"
	L["hud"] = "自屏正中"
	--Tips
	L["SPELLWHISPER TIPS"] = "|cFFBA55D3SpellWhisper|r命令行提示：使用|cFF00BFFF/spellwhisper|r |cFFFF4500gui|r或者|cFF00BFFF/sw|r |cFFFF4500gui|r打开设置窗口，使用|cFF00BFFF/spellwhisper|r |cFFFF0000in|r或者|cFF00BFFF/sw|r |cFFFF0000in|r新建延时任务。"
	--仇恨目标类型
	L["worldboss"] = "BOSS"
	L["elite"] = "精英"
	L["all"] = "全部"
	--监控法术类型
	L["Healing"] = "治疗技能"
	L["Instant Harm"] = "瞬发控制"
	L["Instant Help"] = "瞬发增益"
	L["Cast Harm"] = "施法控制"
	L["Cast Help"] = "复活/召唤"
	L["Self Buff"] = "自体增益"
	L["Other"] = "失误通报"
	--输出格式化字符串
	L["SPELLWHISPER_TEXT_THREAT"] = "<仇恨>[#mob#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOGROUPSTART"] = "<开始>[#spell#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOGROUPDONE"] = "<成功>[#spell#]->[#target#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"] = "<开始>[#spell#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"] = "<成功>[#spell#]"
	L["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"] = "<警告>正在[#spell#]->[#target#]，请切换目标！"
	L["SPELLWHISPER_TEXT_BROKEN"] = "<破控>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
	L["SPELLWHISPER_TEXT_INTERRUPT"] = "<打断>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
	L["SPELLWHISPER_TEXT_MISSED"] = "<失败>[#caster#]的[#spell#]->[#target#]被[#reason#]"
	L["SPELLWHISPER_TEXT_DISPEL"] = "<驱散>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
	L["SPELLWHISPER_TEXT_HEALINGFAILED"] = "<注意>对你的[#spell#]因[#reason#]<失败>"
	L["SPELLWHISPER_TEXT_BGWARNING"] = "<被控>[#caster#]的[#spell#]->[#target#]，地点[#pos#]"
	L["NONE"] = "不提示"
	--交易
	L["SPELLWHISPER_TEXT_TRADE_ERROR"] = "与<%s>的交易失败了，因为<%s>。"
	L["SPELLWHISPER_TEXT_TRADE_SUCCEED"] = "与<%s>的交易成功了。"
	L["SPELLWHISPER_TEXT_TRADE_MONEY_RECEIVE"] = "收入%s。"
	L["SPELLWHISPER_TEXT_TRADE_MONEY_GIVE"] = "付出%s。"
	L["SPELLWHISPER_TEXT_TRADE_ITEMS_RECEIVE"] = "获得#item#(#quantity#)等#num#件物品。"
	L["SPELLWHISPER_TEXT_TRADE_ITEMS_GIVE"] = "给予#item#(#quantity#)等#num#件物品。"
	L["SPELLWHISPER_TEXT_TRADE_ENCHANTMENT"] = "物品%s获得了附魔<%s>。"
	--补全
	L["SPELLWHISPER_TEXT_SWINGATTACK"] = "普通攻击"
	L["SPELLWHISPER_TEXT_UNKNOWN"] = "未知目标"
	--Replay
    L["SPELLWHISPER_TEXT_FOLLOWREPLY"] = "收到，已跟随！"
	L["SPELLWHISPER_TEXT_STOPFOLLOWREPLY"] = "收到，已停止跟随！"
	L["SPELLWHISPER_TEXT_FOLLOWFAILED_OUTOFRANGE"] = "跟随失败，超出距离。"
	L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEON"] = "完成，已打开战斗跟随模式。"
	L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEOFF"] = "完成，已关闭战斗跟随模式。"
	L["SPELLWHISPER_TEXT_STOPFOLLOW_MANUALLY"] = "已自主停止跟随。"
	--法术技能失败原因
	L["ABSORB"] = "吸收"
	L["BLOCK"] = "格挡"
	L["DEFLECT"] = "偏斜"
	L["DODGE"] = "躲闪"
	L["EVADE"] = "闪避"
	L["IMMUNE"] = "免疫"
	L["MISS"] = "未命中"
	L["PARRY"] = "招架"
	L["REFLECT"] = "反射"
	L["RESIST"] = "抵抗"
	--施法失败原因
	L["Out of range"] = "超出范围"
	L["Target not in line of sight"] = "目标不在视野中"
	--目标标记
	L["Star"] = "{星形}"
	L["Circle"] = "{圆形}"
	L["Diamond"] = "{菱形}"
	L["Triangle"] = "{三角}"
	L["Moon"] = "{月亮}"
	L["Square"] = "{方块}"
	L["Cross"] = "{十字}"
	L["Skull"] = "{骷髅}"
	--法术技能
	L["Repentance"] = "忏悔"
	L["Wyvern Sting"] = "翼龙钉刺"
	L["Gouge"] = "凿击"
	L["Hammer of Justice"] = "制裁之锤"
	L["Scatter Shot"] = "驱散射击"
	L["Blind"] = "致盲"
	L["Sap"] = "闷棍"
	L["Death Coil"] = "死亡缠绕"
	L["Intimidating Shout"] = "破胆怒吼"
	L["Innervate"] = "激活"
	L["Power Infusion"] = "能量灌注"
	L["Fear Ward"] = "防护恐惧结界"
	L["Divine Intervention"] = "神圣干涉"
	L["Blessing of Protection"] = "保护祝福"
	L["Blessing of Freedom"] = "自由祝福"
	L["Polymorph"] = "变形术"
	L["Hibernate"] = "休眠"
	L["Shackle Undead"] = "束缚亡灵"
	L["Banish"] = "放逐术"
	L["Fear"] = "恐惧术"
	L["Howl of Terror"] = "恐惧嚎叫"
	L["Entangling Roots"] = "纠缠根须"
	L["Turn Undead"] = "超度亡灵"
	L["Enslave Demon"] = "奴役恶魔"
	L["Scare Beast"] = "恐吓野兽"
	L["Rebirth"] = "复生"
	L["Resurrection"] = "复活术"
	L["Redemption"] = "救赎"
	L["Ancestral Spirit"] = "先祖之魂"
	L["Ritual of Summoning"] = "召唤仪式"
	L["Soulstone Resurrection"] = "灵魂石复活"
	L["Holy Light"] = "圣光术"
	L["Flash of Light"] = "圣光闪现"
	L["Lay on Hands"] = "圣疗术"
	L["Holy Shock"] = "神圣震击"
	L["Lesser Healing Wave"] = "次级治疗波"
	L["Healing Wave"] = "治疗波"
	L["Chain Heal"] = "治疗链"
	L["Healing Touch"] = "治疗之触"
	L["Regrowth"] = "愈合"
	L["Rejuvenation"] = "回春术"
	L["Swiftmend"] = "迅捷治愈"
	L["Power Word: Shield"] = "真言术：盾"
	L["Heal"] = "治疗术"
	L["Lesser Heal"] = "次级治疗术"
	L["Renew"] = "恢复"
	L["Flash Heal"] = "快速治疗"
	L["Greater Heal"] = "强效治疗术"
	L["Taunt"] = "嘲讽"
	L["Mocking Blow"] = "惩戒痛击"
	L["Challenging Shout"] = "挑战怒吼"
	L["Shield Slam"] = "盾牌猛击"
	L["Growl"] = "低吼"
	L["Challenging Roar"] = "挑战咆哮"
	L["Kidney Shot"] = "肾击"
	L["Feign Death"] = "假死"
	L["Dispel Magic"] = "驱散魔法"
	L["Purge"] = "净化术"
	L["Tranquilizing Shot"] = "宁神射击"
	L["Shield Wall"] = "盾墙"
	L["Last Stand"] = "破釜沉舟"
	L["Gift of Life"] = "生命赐福"
	--载入提示文字
	L["|cFFBA55D3SpellWhisper|r v%s|cFFB0C4DE is Loaded.|r"] = "|cFFBA55D3SpellWhisper|r v%s已|cFFB0C4DE成功|r加载！"
    L["Now is |cFF00FFFFEnabled|r."] = "当前已|cFF00FFFF启用|r。"
	L["Now is |cFF00FFFFDisabled|r."] = "当前已|cFF00FFFF禁用|r。"
	L["|cFFBA55D3SpellWhisper|r v%s is |cFFFF4C00Out of date|r. Goto %s for |cFFF48CBANew Version.|r"] = "|cFFBA55D3SpellWhisper|r v%s已|cFFFF4C00过期|r，请用|cFF00FFFF桃乐豆|r|cFFFFF468更新|r或前往%s|cFFFFF468下载|r|cFFF48CBA最新版本|r。"
	L["<|cFFBA55D3SW|r>Start Check Team Member's |cFFBA55D3SpellWhisper|r Version."] = "<|cFFBA55D3SW|r>开始检查团队成员SpellWhisper插件版本。"
	L["<|cFFBA55D3SW|r>Don't Have Any Team Member(s)."] = "<|cFFBA55D3SW|r>不在一个队伍或团队中。"
	L["<|cFFBA55D3SW|r>Can't Check |cFFBA55D3SpellWhisper|r Version In Battleground."] = "<|cFFBA55D3SW|r>无法在战场中检查SpellWhisper版本。"
	L["<|cFFBA55D3SW|r>Please Enable |cFFBA55D3SpellWhisper|r First."] = "<|cFFBA55D3SW|r>请先启用|cFFBA55D3SpellWhisper|r插件。"
	--Slash Command提示文字
	L["<|cFFBA55D3SW|r>Can NOT Open |cFFBA55D3SpellWhisper|r GUI when you in COMBAT."] = "<|cFFBA55D3SW|r>战斗中无法打开|cFFBA55D3SpellWhisper|r设置界面。"
	L["|cFFBA55D3SpellWhisper|r Delay Command Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r or |cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r create a Delay Task."] = "|cFFBA55D3SpellWhisper|r使用说明：使用|cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r或者|cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r新建延时任务。"
	L["|cFFBA55D3SpellWhisper|r Delay Command: |cFFCCA4E3%d|r [seconds] later do |cFFCCA4E3[%s]|r Task."] = "|cFFBA55D3SpellWhisper|r：|cFFCCA4E3[%d]|r秒后执行|cFFCCA4E3[%s]|r任务。"
	L["|cFFBA55D3SpellWhisper|r Delay Command Tips: Please Input |cFF00E09EValid|r |cFFCCA4E3[Seconds]|r and |cFF00E09ELegal|r |cFFCCA4E3[Command]|r!"] = "|cFFBA55D3SpellWhisper|r使用说明：请输入|cFF00E09E有效|r的|cFFCCA4E3[Seconds]|r和|cFF00E09E合法|r的|cFFCCA4E3[Command]！"
	--Config界面文字
	L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"] = "|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FF零界|r-|cFFDE2910CN|r"
	L["|cFFFF33CCFeedback & Update: |r"] = "|cFFFF33CC反馈与更新：|r"
	L["Check & Display Version"] = "检查插件版本"
	L["Enable |cFFBA55D3SpellWhisper|r"] = "启用|cFFBA55D3SpellWhisper|r"
	L["Show Minimap |cFF00F0F0Icon|r"] = "显示|cFF00F0F0小地图按钮|r"
	L["|cFFCC9933Self|r Spell Only"] = "仅通告|cFFCC9933自身技能|r"
	L["|cFFA330C9Delay Task|r Tips"] = "|cFFA330C9延时任务|r创建提示"
	L["Enable |cFF0099FFBG Auto Warning|r"] = "启用|cFF0099FF战场自动报告|r"
	L["Channel: "] = "输出频道："
	L["Threat: "] = "仇恨提示："
	L["Anti Disturbance Time"] = "防重复刷屏"
	L["Anti Break Disturbance Time"] = "防破控刷屏"
    L["Whisper Mode"] = "密语通知"
    L["Enable |cFFFFCC33Whisper|r"] = "启用|cFFFFCC33密语|r通知"
    L["Enable |cFF44CEF6TOT Whisper|r Warning"] = "启用|cFF44CEF6同目标密语|r警示"
	L["BG Auto Report"] = "战场自动报告"
	L["Enable |cFF0099FFBG Auto Report|r"] = "启用|cFF0099FF战场自动报告|r"
	L["Auto Follow Setting"] = "密语自动跟随"
	L["Enable |cFFFF6600Combat Follow|r"] = "启用|cFFFF6600战斗跟随|r"
    L["|cFFFF99CCStart Follow|r KeyWords:"] = "|cFFFF99CC开始|r跟随："
	L["|cFF999966Stop Follow|r KeyWords:"] = "|cFF999966停止|r跟随："
	L["|cFFD9B611Combat Follow Mode|r KeyWords:"] = "|cFFD9B611切换|r模式："
	L["Spell List"] = "当前监控技能列表"
	L["Spell Monitor: "] = "技能类型："
	L["Display"] = "显示"
	L["Restore"] = "还原"
	L["Add"] = "增加"
	L["Remove"] = "移除"
	L["Default"] = "默认"
	L["Set"] = "设置"
	L["Check Version"] = "检查版本"
	L["Announce Template: "] = "通告模板："
	--提示模板提示
	L["Tell Group Spell Start Casting"] = "施法开始提示模板"
	L["Tell Group Spell Have Done"] = "施法完成提示模板"
	L["Whisper Someone Spell Start Casting"] = "施法开始密语模板"
	L["Whisper Someone Spell Have Done"] = "施法完成密语模板"
	L["Tell Someone To Change His/Her Target"] = "同目标警告提示模板"
	L["Announce CC Spell Broken"] = "破控提示模板"
	L["Announce Enemy's Spell Interrupted"] = "打断提示模板"
	L["Announce Spell/Skill Missed"] = "失误提示模板"
	L["Announce Enemy's Buff Dispelled"] = "驱散提示模板"
	L["Tell Target Heal Spell Failed"] = "治疗失败提示模板"
	L["Warning Group You Have Be Controlled In BG"] = "战场被控提示模板"
	L["Announce Mob's First Target Have Changed"] = "怪物切换目标提示模板"
	L["Version Check"] = "版本检查"
	-- MinimapIcon
	L["|cFF00FF00Shift+Left|r to Check SW Version of Group"] = "|cFF00FF00Shift+左键|r发起版本检查"
	L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右键|r打开设置窗口"
	L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"] = "|cFF00FF00Shift+右键|r重置小地图按钮位置"
elseif locale == "zhTW" then --Taiwan is a part of China forever
    --頻道名稱
    L["off"] = "關閉"
    L["say"] = "說"
    L["yell"] = "大喊"
    L["party"] = "隊伍"
    L["raid"] = "團隊"
    L["Raid_Warning"] = "團隊警告"
    L["self"] = "自身可見"
    L["hud"] = "自屏正中"
    --Tips
    L["SPELLWHISPER TIPS"] = "|cFFBA55D3SpellWhisper|r命令列提示：使用|cFF00BFFF/spellwhisper|r |cFFFF4500gui|r或者|cFF00BFFF/sw|r |cFFFF4500gui|r打開設置視窗，使用|cFF00BFFF/spellwhisper|r |cFFFF0000in|r或者|cFF00BFFF/sw|r |cFFFF0000in|r新建延時任務。"
    --仇恨目標類型
    L["worldboss"] = "BOSS"
    L["elite"] = "精英"
    L["all"] = "全部"
    --監控法術類型
    L["Healing"] = "治療技能"
    L["Instant Harm"] = "瞬發控制"
    L["Instant Help"] = "瞬發增益"
    L["Cast Harm"] = "施法控制"
    L["Cast Help"] = "復活/召喚"
    L["Self Buff"] = "自體增益"
    L["Other"] = "失誤通報"
    --輸出格式化字串
    L["SPELLWHISPER_TEXT_THREAT"] = "<仇恨>[#mob#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOGROUPSTART"] = "<開始>[#spell#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOGROUPDONE"] = "<成功>[#spell#]->[#target#]"
    L["SPELLWHISPER_TEXT_SENTTOPLAYERSTART"] = "<開始>[#spell#]"
    L["SPELLWHISPER_TEXT_SENTTOPLAYERDONE"] = "<成功>[#spell#]"
    L["SPELLWHISPER_TEXT_SENTTOPLAYERTARGETTHETARGET"] = "<警告>正在[#spell#]->[#target#]，請切換目標！"
    L["SPELLWHISPER_TEXT_BROKEN"] = "<破控>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
    L["SPELLWHISPER_TEXT_INTERRUPT"] = "<打斷>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
    L["SPELLWHISPER_TEXT_MISSED"] = "<失敗>[#caster#]的[#spell#]->[#target#]被[#reason#]"
    L["SPELLWHISPER_TEXT_DISPEL"] = "<驅散>[#caster#]的[#spell#]->[#target#]的[#spell_2#]"
    L["SPELLWHISPER_TEXT_HEALINGFAILED"] = "<注意>對你的[#spell#]因[#reason#]<失敗>"
    L["SPELLWHISPER_TEXT_BGWARNING"] = "<被控>[#caster#]的[#spell#]->[#target#]，地點[#pos#]"
    L["NONE"] = "不提示"
    --交易
    L["SPELLWHISPER_TEXT_TRADE_ERROR"] = "與<%s>的交易失敗了，因為<%s>。"
    L["SPELLWHISPER_TEXT_TRADE_SUCCEED"] = "與<%s>的交易成功了。"
    L["SPELLWHISPER_TEXT_TRADE_MONEY_RECEIVE"] = "收入%s。"
    L["SPELLWHISPER_TEXT_TRADE_MONEY_GIVE"] = "付出%s。"
    L["SPELLWHISPER_TEXT_TRADE_ITEMS_RECEIVE"] = "獲得#item#(#quantity#)等#num#件物品。"
    L["SPELLWHISPER_TEXT_TRADE_ITEMS_GIVE"] = "給予#item#(#quantity#)等#num#件物品。"
    L["SPELLWHISPER_TEXT_TRADE_ENCHANTMENT"] = "物品%s獲得了附魔<%s>。"
    --補全
    L["SPELLWHISPER_TEXT_SWINGATTACK"] = "普通攻擊"
    L["SPELLWHISPER_TEXT_UNKNOWN"] = "未知目標"
    --Replay
    L["SPELLWHISPER_TEXT_FOLLOWREPLY"] = "收到，已跟隨！"
    L["SPELLWHISPER_TEXT_STOPFOLLOWREPLY"] = "收到，已停止跟隨！"
    L["SPELLWHISPER_TEXT_FOLLOWFAILED_OUTOFRANGE"] = "跟隨失敗，超出距離。"
    L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEON"] = "完成，已打開戰鬥跟隨模式。"
    L["SPELLWHISPER_TEXT_CHANGEFOLLOWMODEOFF"] = "完成，已關閉戰鬥跟隨模式。"
    L["SPELLWHISPER_TEXT_STOPFOLLOW_MANUALLY"] = "已自主停止跟隨。"
    --法術技能失敗原因
    L["ABSORB"] = "吸收"
    L["BLOCK"] = "格擋"
    L["DEFLECT"] = "偏斜"
    L["DODGE"] = "躲閃"
    L["EVADE"] = "閃避"
    L["IMMUNE"] = "免疫"
    L["MISS"] = "未命中"
    L["PARRY"] = "招架"
    L["REFLECT"] = "反射"
    L["RESIST"] = "抵抗"
    --施法失敗原因
    L["Out of range"] = "超出範圍"
    L["Target not in line of sight"] = "目標不在視野中"
    --目標標記
    L["Star"] = "{星形}"
    L["Circle"] = "{圓形}"
    L["Diamond"] = "{菱形}"
    L["Triangle"] = "{三角}"
    L["Moon"] = "{月亮}"
    L["Square"] = "{方塊}"
    L["Cross"] = "{十字}"
    L["Skull"] = "{骷髏}"
    --法術技能
    L["Repentance"] = "懺悔"
    L["Wyvern Sting"] = "翼龍釘刺"
    L["Gouge"] = "鑿擊"
    L["Hammer of Justice"] = "制裁之錘"
    L["Scatter Shot"] = "驅散射擊"
    L["Blind"] = "致盲"
    L["Sap"] = "悶棍"
    L["Death Coil"] = "死亡纏繞"
    L["Intimidating Shout"] = "破膽怒吼"
    L["Innervate"] = "啟動"
    L["Power Infusion"] = "能量灌注"
    L["Fear Ward"] = "防護恐懼結界"
    L["Divine Intervention"] = "神聖干涉"
    L["Blessing of Protection"] = "保護祝福"
    L["Blessing of Freedom"] = "自由祝福"
    L["Polymorph"] = "變形術"
    L["Hibernate"] = "休眠"
    L["Shackle Undead"] = "束縛亡靈"
    L["Banish"] = "放逐術"
    L["Fear"] = "恐懼術"
    L["Howl of Terror"] = "恐懼嚎叫"
    L["Entangling Roots"] = "糾纏根須"
    L["Turn Undead"] = "超度亡靈"
    L["Enslave Demon"] = "奴役惡魔"
    L["Scare Beast"] = "恐嚇野獸"
    L["Rebirth"] = "複生"
    L["Resurrection"] = "復活術"
    L["Redemption"] = "救贖"
    L["Ancestral Spirit"] = "先祖之魂"
    L["Ritual of Summoning"] = "召喚儀式"
    L["Soulstone Resurrection"] = "靈魂石復活"
    L["Holy Light"] = "聖光術"
    L["Flash of Light"] = "聖光閃現"
    L["Lay on Hands"] = "聖療術"
    L["Holy Shock"] = "神聖震擊"
    L["Lesser Healing Wave"] = "次級治療波"
    L["Healing Wave"] = "治療波"
    L["Chain Heal"] = "治療鏈"
    L["Healing Touch"] = "治療之觸"
    L["Regrowth"] = "癒合"
    L["Rejuvenation"] = "回春術"
    L["Swiftmend"] = "迅捷治癒"
    L["Power Word: Shield"] = "真言術：盾"
    L["Heal"] = "治療術"
    L["Lesser Heal"] = "次級治療術"
    L["Renew"] = "恢復"
    L["Flash Heal"] = "快速治療"
    L["Greater Heal"] = "強效治療術"
    L["Taunt"] = "嘲諷"
    L["Mocking Blow"] = "懲戒痛擊"
    L["Challenging Shout"] = "挑戰怒吼"
    L["Shield Slam"] = "盾牌猛擊"
    L["Growl"] = "低吼"
    L["Challenging Roar"] = "挑戰咆哮"
    L["Kidney Shot"] = "腎擊"
    L["Feign Death"] = "假死"
    L["Dispel Magic"] = "驅散魔法"
    L["Purge"] = "淨化術"
    L["Tranquilizing Shot"] = "寧神射擊"
    L["Shield Wall"] = "盾牆"
    L["Last Stand"] = "破釜沉舟"
    L["Gift of Life"] = "生命賜福"
    --載入提示文字
    L["|cFFBA55D3SpellWhisper|r v%s|cFFB0C4DE is Loaded.|r"] = "|cFFBA55D3SpellWhisper|r v%s已|cFFB0C4DE成功|r載入！"
    L["Now is |cFF00FFFFEnabled|r."] = "當前已|cFF00FFFF啟用|r。"
    L["Now is |cFF00FFFFDisabled|r."] = "當前已|cFF00FFFF禁用|r。"
    L["|cFFBA55D3SpellWhisper|r v%s is |cFFFF4C00Out of date|r. Goto %s for |cFFF48CBANew Version.|r"] = "|cFFBA55D3SpellWhisper|r v%s已|cFFFF4C00過期|r，請用|cFF00FFFF桃樂豆|r|cFFFFF468更新|r或前往%s|cFFFFF468下載|r|cFFF48CBA最新版本|r。"
    L["<|cFFBA55D3SW|r>Start Check Team Member's |cFFBA55D3SpellWhisper|r Version."] = "<|cFFBA55D3SW|r>開始檢查團隊成員SpellWhisper外掛程式版本。"
    L["<|cFFBA55D3SW|r>Don't Have Any Team Member(s)."] = "<|cFFBA55D3SW|r>不在一個隊伍或團隊中。"
    L["<|cFFBA55D3SW|r>Can't Check |cFFBA55D3SpellWhisper|r Version In Battleground."] = "<|cFFBA55D3SW|r>無法在戰場中檢查SpellWhisper版本。"
    L["<|cFFBA55D3SW|r>Please Enable |cFFBA55D3SpellWhisper|r First."] = "<|cFFBA55D3SW|r>請先啟用|cFFBA55D3SpellWhisper|r外掛程式。"
    --Slash Command提示文字
    L["<|cFFBA55D3SW|r>Can NOT Open |cFFBA55D3SpellWhisper|r GUI when you in COMBAT."] = "<|cFFBA55D3SW|r>戰鬥中無法打開|cFFBA55D3SpellWhisper|r設置介面。"
    L["|cFFBA55D3SpellWhisper|r Delay Command Tips:Use |cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r or |cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r create a Delay Task."] = "|cFFBA55D3SpellWhisper|r使用說明：使用|cFF00BFFF/spellwhisper|r |cFFFF0000in|r |cFFCCA4E3[Seconds] [Task]|r或者|cFF00BFFF/sw|r |cFFCCA4E3in [Seconds] [Task]|r新建延時任務。"
    L["|cFFBA55D3SpellWhisper|r Delay Command: |cFFCCA4E3%d|r [seconds] later do |cFFCCA4E3[%s]|r Task."] = "|cFFBA55D3SpellWhisper|r：|cFFCCA4E3[%d]|r秒後執行|cFFCCA4E3[%s]|r任務。"
    L["|cFFBA55D3SpellWhisper|r Delay Command Tips: Please Input |cFF00E09EValid|r |cFFCCA4E3[Seconds]|r and |cFF00E09ELegal|r |cFFCCA4E3[Command]|r!"] = "|cFFBA55D3SpellWhisper|r使用說明：請輸入|cFF00E09E有效|r的|cFFCCA4E3[Seconds]|r和|cFF00E09E合法|r的|cFFCCA4E3[Command]！"
    --Config介面文字
    L["|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FFZeroZone|r-|cFFDE2910CN|r"] = "|cFFFFC040By:|r |cFF9382C9Aoikaze|r-|cFFFF66FF零界|r-|cFFDE2910CN|r"
    L["|cFFFF33CCFeedback & Update: |r"] = "|cFFFF33CC回饋與更新：|r"
    L["Check & Display Version"] = "檢查外掛程式版本"
    L["Enable |cFFBA55D3SpellWhisper|r"] = "啟用|cFFBA55D3SpellWhisper|r"
	L["Show Minimap |cFF00F0F0Icon|r"] = "顯示|cFF00F0F0小地圖按鈕|r"
	L["|cFFCC9933Self|r Spell Only"] = "僅通告|cFFCC9933自身技能|r"
    L["|cFFA330C9Delay Task|r Tips"] = "|cFFA330C9延時任務|r創建提示"
    L["Enable |cFF0099FFBG Auto Warning|r"] = "啟用|cFF0099FF戰場自動報告|r"
    L["Channel: "] = "輸出頻道："
    L["Threat: "] = "仇恨提示："
    L["Anti Disturbance Time"] = "防重複刷屏"
    L["Anti Break Disturbance Time"] = "防破控刷屏"
    L["Whisper Mode"] = "密語通知"
    L["Enable |cFFFFCC33Whisper|r"] = "啟用|cFFFFCC33密語|r通知"
    L["Enable |cFF44CEF6TOT Whisper|r Warning"] = "啟用|cFF44CEF6同目標密語|r警示"
    L["BG Auto Report"] = "戰場自動報告"
    L["Enable |cFF0099FFBG Auto Report|r"] = "啟用|cFF0099FF戰場自動報告|r"
    L["Auto Follow Setting"] = "密語自動跟隨"
    L["Enable |cFFFF6600Combat Follow|r"] = "啟用|cFFFF6600戰鬥跟隨|r"
    L["|cFFFF99CCStart Follow|r KeyWords:"] = "|cFFFF99CC開始|r跟隨："
    L["|cFF999966Stop Follow|r KeyWords:"] = "|cFF999966停止|r跟隨："
    L["|cFFD9B611Combat Follow Mode|r KeyWords:"] = "|cFFD9B611切換|r模式："
    L["Spell List"] = "當前監控技能列表"
    L["Spell Monitor: "] = "技能類型："
    L["Display"] = "顯示"
    L["Restore"] = "還原"
    L["Add"] = "增加"
    L["Remove"] = "移除"
    L["Default"] = "默認"
    L["Set"] = "設置"
    L["Check Version"] = "檢查版本"
    L["Announce Template: "] = "通告範本："
    --提示範本提示
    L["Tell Group Spell Start Casting"] = "施法開始提示範本"
    L["Tell Group Spell Have Done"] = "施法完成提示範本"
    L["Whisper Someone Spell Start Casting"] = "施法開始密語範本"
    L["Whisper Someone Spell Have Done"] = "施法完成密語範本"
    L["Tell Someone To Change His/Her Target"] = "同目標警告提示範本"
    L["Announce CC Spell Broken"] = "破控提示範本"
    L["Announce Enemy's Spell Interrupted"] = "打斷提示範本"
    L["Announce Spell/Skill Missed"] = "失誤提示範本"
    L["Announce Enemy's Buff Dispelled"] = "驅散提示範本"
    L["Tell Target Heal Spell Failed"] = "治療失敗提示範本"
    L["Warning Group You Have Be Controlled In BG"] = "戰場被控提示範本"
    L["Announce Mob's First Target Have Changed"] = "怪物切換目標提示範本"
    L["Version Check"] = "版本檢查"
    -- MinimapIcon
    L["|cFF00FF00Shift+Left|r to Check SW Version of Group"] = "|cFF00FF00Shift+左鍵|r發起版本檢查"
    L["|cFF00FF00Right Click|r to Open Config Frame"] = "|cFF00FF00右鍵|r打開設置窗口"
    L["|cFF00FF00Shift+Right|r to Restore Minimap Icon Position"] = "|cFF00FF00Shift+右鍵|r重置小地圖按鈕位置"
end