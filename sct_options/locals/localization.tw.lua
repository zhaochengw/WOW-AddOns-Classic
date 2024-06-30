--***************************************
-- zhTW Chinese Traditional
-- 2007/06/01 艾娜羅沙@奧妮克希亞
-- 如拿本文修改，請保留本翻譯作者名，謝謝
-- 2008/4/20修訂 天明@眾星之子
--***************************************

if GetLocale() ~= "zhTW" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "傷害", tooltipText = "顯示受到的近戰傷害與其他傷害(火焰、摔落等)"};
SCT.LOCALS.OPTION_EVENT2 = {name = "未擊中", tooltipText = "顯示敵人未擊中你的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT3 = {name = "閃避", tooltipText = "顯示閃避的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT4 = {name = "招架", tooltipText = "顯示招架的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT5 = {name = "格擋", tooltipText = "顯示格擋的近戰攻擊"};
SCT.LOCALS.OPTION_EVENT6 = {name = "法術傷害", tooltipText = "顯示受到的法術傷害"};
SCT.LOCALS.OPTION_EVENT7 = {name = "法術治療", tooltipText = "顯示受到的法術治療"};
SCT.LOCALS.OPTION_EVENT8 = {name = "法術抵抗", tooltipText = "顯示抵抗敵人的法術"};
SCT.LOCALS.OPTION_EVENT9 = {name = "不良效果", tooltipText = "顯示受到的不良效果影響"};
SCT.LOCALS.OPTION_EVENT10 = {name = "吸收/其它", tooltipText = "顯示對敵人傷害的吸收、反射、免疫效果等"};
SCT.LOCALS.OPTION_EVENT11 = {name = "生命過低", tooltipText = "生命值過低警告"};
SCT.LOCALS.OPTION_EVENT12 = {name = "法力過低", tooltipText = "法力值過低警告"};
SCT.LOCALS.OPTION_EVENT13 = {name = "能量獲得", tooltipText = "顯示透過藥水、物品、增益效果等獲得的法力值、怒氣、能量(非正常恢復)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "戰鬥標記", tooltipText = "顯示進入、脫離戰鬥狀態的提示訊息"};
SCT.LOCALS.OPTION_EVENT15 = {name = "連擊點", tooltipText = "顯示獲得的連擊點數"};
SCT.LOCALS.OPTION_EVENT16 = {name = "榮譽獲得", tooltipText = "顯示獲得的榮譽點數"};
SCT.LOCALS.OPTION_EVENT17 = {name = "增益效果", tooltipText = "顯示獲得的增益效果"};
SCT.LOCALS.OPTION_EVENT18 = {name = "增益消失", tooltipText = "顯示從你身上消失的增益效果"};
SCT.LOCALS.OPTION_EVENT19 = {name = "可使用技能", tooltipText = "顯示進入可使用狀態的特定技能(斬殺、貓鼬撕咬、憤怒之錘等)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "聲望", tooltipText = "顯示聲望的提昇或降低"};
SCT.LOCALS.OPTION_EVENT21 = {name = "玩家治療", tooltipText = "顯示對別人的治療"};
SCT.LOCALS.OPTION_EVENT22 = {name = "技能點數", tooltipText = "顯示技能點數的提昇"};
SCT.LOCALS.OPTION_EVENT23 = {name = "擊殺攻擊", tooltipText = "顯示是否是由你的最後一擊造成怪物死亡的."};
SCT.LOCALS.OPTION_EVENT24 = {name = "被中斷", tooltipText = "顯示你的動作是否被中斷"};
SCT.LOCALS.OPTION_EVENT25 = {name = "驅散", tooltipText = "顯示你有否成功驅散魔法"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "啟用SCT", tooltipText = "啟用 Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "標記戰鬥訊息", tooltipText = "在戰鬥訊息兩側添加'*'標記"};
SCT.LOCALS.OPTION_CHECK3 = { name = "顯示治療者", tooltipText = "顯示治療你的玩家或生物的名字"};
SCT.LOCALS.OPTION_CHECK4 = { name = "文字向下捲動", tooltipText = "戰鬥訊息向下捲動"};
SCT.LOCALS.OPTION_CHECK5 = { name = "重擊效果", tooltipText = "以特效顯示受到的致命一擊或極效治療"};
SCT.LOCALS.OPTION_CHECK6 = { name = "法術傷害類型", tooltipText = "顯示你受到的法術傷害的類型"};
SCT.LOCALS.OPTION_CHECK7 = { name = "對傷害啟用字體設定", tooltipText = "以SCT使用的字體顯示遊戲預設的傷害數字.\n\n注意：此設定必須重新登入才能生效.重新載入界面無效."};
SCT.LOCALS.OPTION_CHECK8 = { name = "顯示所有能量獲得", tooltipText = "顯示所有的能量獲得，而不是僅顯示戰鬥記錄中出現的. \n\n注意：必須先啟用普通的“能量獲得”事件.非常容易洗頻.且德魯伊在切換回施法者形態時會有不正常的現象."};
SCT.LOCALS.OPTION_CHECK10 = { name = "顯示過量治療", tooltipText = "顯示你的過量治療值，必須先啟用“玩家治療”事件."};
SCT.LOCALS.OPTION_CHECK11 = { name = "警報聲音", tooltipText = "當發出警告時播放聲音."};
SCT.LOCALS.OPTION_CHECK12 = { name = "法術傷害顏色", tooltipText = "以不同的顏色顯示不同類型的法術傷害"};
SCT.LOCALS.OPTION_CHECK13 = { name = "啟用自定義事件", tooltipText = "啟用自定義事件.關閉後能節省大量記憶體的使用."};
SCT.LOCALS.OPTION_CHECK14 = { name = "法術／技能名稱", tooltipText = "啟用或是關閉對你造成[傷害的法術或是技能名稱"};
SCT.LOCALS.OPTION_CHECK15 = { name = "閃爍", tooltipText = "使得致命／極效的效果呈現閃爍狀態."};
SCT.LOCALS.OPTION_CHECK16 = { name = "擦過／輾壓", tooltipText = "顯示擦過 ~150~ 以及輾壓 ^150^ 攻擊"};
SCT.LOCALS.OPTION_CHECK17 = { name = "你的HOT治療", tooltipText = "顯示你對別的角色所施放的持續性治療法術效果.請注意如果你對很多人放恢復或是回春術的話，畫面上將會有一堆HOT訊息."};
SCT.LOCALS.OPTION_CHECK18 = { name = "在血條上顯示治療", tooltipText = "在你要施放治療的對象玩家角色的血條上，啟用或是關閉顯示你要治療的動作條.\n\n友方的血條必需要開啟，並且你必需能看見血條.本功能不一定能100%運作.如果沒有正常運作，治療文字將出現在一般設定的位置.\n\n要關閉的話，要重新載入UI才行."};
SCT.LOCALS.OPTION_CHECK19 = { name = "關閉內建治療顯示", tooltipText = "啟用或是關閉2.1版更新中的治療顯示文字."};
SCT.LOCALS.OPTION_CHECK20 = { name = "法術圖示", tooltipText = "啟用或是關閉法術/技能圖示"};
SCT.LOCALS.OPTION_CHECK21 = { name = "顯示圖示", tooltipText = "啟用自訂事件所用的法術/技能圖示, 如有相關的圖示的話"};
SCT.LOCALS.OPTION_CHECK22 = { name = "致命顯示", tooltipText = "啟用這會令事件永遠以致命一擊效果來顯示"};
SCT.LOCALS.OPTION_CHECK23 = { name = "致命一擊", tooltipText = "這事件需要由致命一擊來觸發"};
SCT.LOCALS.OPTION_CHECK24 = { name = "抵抗", tooltipText = "這事件需要由部份抵抗來觸發"};
SCT.LOCALS.OPTION_CHECK25 = { name = "擋格", tooltipText = "這事件需要由部份擋格來觸發"};
SCT.LOCALS.OPTION_CHECK26 = { name = "吸收", tooltipText = "這事件需要由部份吸收來觸發"};
SCT.LOCALS.OPTION_CHECK27 = { name = "擦過", tooltipText = "這事件需要由擦過來觸發"};
SCT.LOCALS.OPTION_CHECK28 = { name = "輾壓", tooltipText = "這事件需要由輾壓來觸發"};
SCT.LOCALS.OPTION_CHECK29 = { name = "自己的Debuffs", tooltipText = "如這事件引致Debuff, 只會被你能引致的Debuff才會觸發事件. 只能在你當前的目標生效."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="文字動畫速度", minText="快", maxText="慢", tooltipText = "調整動態文字捲動速度"};
SCT.LOCALS.OPTION_SLIDER2 = { name="文字大小", minText="小", maxText="大", tooltipText = "調整動態文字的大小"};
SCT.LOCALS.OPTION_SLIDER3 = { name="生命百分比", minText="10%", maxText="90%", tooltipText = "設定玩家生命值降低到幾％時發出警告"};
SCT.LOCALS.OPTION_SLIDER4 = { name="法力百分比",  minText="10%", maxText="90%", tooltipText = "設定玩家法力值降低到幾％時發出警告"};
SCT.LOCALS.OPTION_SLIDER5 = { name="文字透明度", minText="0%", maxText="100%", tooltipText = "調整動態文字的透明度"};
SCT.LOCALS.OPTION_SLIDER6 = { name="文字移動距離", minText="小", maxText="大", tooltipText = "調整動態文字間的距離"};
SCT.LOCALS.OPTION_SLIDER7 = { name="文字X坐標", minText="-600", maxText="600", tooltipText = "調整以文字中間點為準，其顯示的水平位置"};
SCT.LOCALS.OPTION_SLIDER8 = { name="文字Y坐標", minText="-400", maxText="400", tooltipText = "調整以文字中間點為準，其顯示的垂直位置"};
SCT.LOCALS.OPTION_SLIDER9 = { name="靜態文字中心X坐標", minText="-600", maxText="600", tooltipText = "調整以文字中間點為準，靜態訊息其顯示的水平位置"};
SCT.LOCALS.OPTION_SLIDER10 = { name="靜態文字中心Y坐標", minText="-400", maxText="400", tooltipText = "調整以文字中間點為準，靜態訊息其顯示的垂直位置"};
SCT.LOCALS.OPTION_SLIDER11 = { name="靜態訊息淡出速度", minText="快", maxText="慢", tooltipText = "調整靜態訊息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER12 = { name="靜態訊息字體大小", minText="小", maxText="大", tooltipText = "調整靜態訊息的文字大小"};
SCT.LOCALS.OPTION_SLIDER13 = { name="治療者過濾", minText="0", maxText="500", tooltipText = "調整SCT要顯示的最小的治療量的值.用於不想顯示如恢復，回春術，祝福等小量的治療效果時"};
SCT.LOCALS.OPTION_SLIDER14 = { name="法力過濾", minText="0", maxText="500", tooltipText = "設定SCT要顯示的數字的最低法力/能量獲得的門檻值.對於過濾掉少量的法力/能量恢復如圖騰，祝福效果...等等."};
SCT.LOCALS.OPTION_SLIDER15 = { name="HUD 離中間距離", minText="0", maxText="200", tooltipText = "控制 HUD 動畫效果和水平中央點的距離.對於想要訊息儘量靠中間顯示，但是想要調整和水平中間點離時使用."};
SCT.LOCALS.OPTION_SLIDER16 = { name="簡寫式法術名", minText="1", maxText="30", tooltipText = "法術名稱如果比這個設定的值還長，則會以簡寫方式顯示."};
SCT.LOCALS.OPTION_SLIDER17 = { name="傷害過濾", minText="0", maxText="500", tooltipText = "設定SCT傷害顯示的門檻值. 可過濾掉少量的傷害,扣血效果...等等."};
SCT.LOCALS.OPTION_SLIDER18 = { name="Aura的數目", minText="0", maxText="20", tooltipText = "所需的buff或debuff的數目來觸發事件. 0是說任何數目也可"};

--Spell Color options]
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "設定"..SPELL_SCHOOL0_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "設定"..SPELL_SCHOOL1_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "設定"..SPELL_SCHOOL2_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "設定"..SPELL_SCHOOL3_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "設定"..SPELL_SCHOOL4_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "設定"..SPELL_SCHOOL5_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "設定"..SPELL_SCHOOL6_CAP.."法術的顯示顏色"};
SCT.LOCALS.OPTION_COLOR8 = { name="事件顏色", tooltipText = "這事件所使用的顏色."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT設定"..SCT.Version, tooltipText = "按左鍵拖曳來移動"};
SCT.LOCALS.OPTION_MISC2 = {name="關閉", tooltipText = "關閉法術顏色設定" };
SCT.LOCALS.OPTION_MISC3 = {name="編輯", tooltipText = "編輯法術顯示顏色" };
SCT.LOCALS.OPTION_MISC4 = {name="雜項設定"};
SCT.LOCALS.OPTION_MISC5 = {name="警告設定"};
SCT.LOCALS.OPTION_MISC6 = {name="動畫設定"};
SCT.LOCALS.OPTION_MISC7 = {name="選擇設定檔"};
SCT.LOCALS.OPTION_MISC8 = {name="存檔並關閉", tooltipText = "儲存所有目前設定，並關閉設定選單"};
SCT.LOCALS.OPTION_MISC9 = {name="重置", tooltipText = "＞＞警告＜＜\n\n確定要還原所有SCT設定為預設值嗎？"};
SCT.LOCALS.OPTION_MISC10 = {name="設定檔", tooltipText = "選擇其它角色的設定檔"};
SCT.LOCALS.OPTION_MISC11 = {name="載入", tooltipText = "載入其它角色的設定檔到此角色"};
SCT.LOCALS.OPTION_MISC12 = {name="刪除", tooltipText = "刪除一個角色設定檔"}; 
SCT.LOCALS.OPTION_MISC13 = {name="文字選項" };
SCT.LOCALS.OPTION_MISC14 = {name="框架 1"};
SCT.LOCALS.OPTION_MISC15 = {name="靜態訊息"};
SCT.LOCALS.OPTION_MISC16 = {name="動畫效果"};
SCT.LOCALS.OPTION_MISC17 = {name="法術設定"};
SCT.LOCALS.OPTION_MISC18 = {name="視窗"};
SCT.LOCALS.OPTION_MISC19 = {name="法術"};
SCT.LOCALS.OPTION_MISC20 = {name="框架 2"};
SCT.LOCALS.OPTION_MISC21 = {name="事件"};
SCT.LOCALS.OPTION_MISC22 = {name="典型設定檔", tooltipText = "載入典型設定檔，使得SCT的動作行為接近內定值."};
SCT.LOCALS.OPTION_MISC23 = {name="效能設定檔", tooltipText = "載入高效能配置.選取所有的設定來得到最佳的效能."};
SCT.LOCALS.OPTION_MISC24 = {name="分割設定檔", tooltipText = "載入分割配置.使得傷害和事件顯示在右側，治療和增益效果在左側."};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof設定檔", tooltipText = "載入Grayhoof配置.使SCT有如Grayhoof(作者)在使用它時一般的運作"};
SCT.LOCALS.OPTION_MISC26 = {name="內建設定檔", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="分割的SCTD設定檔", tooltipText = "載入分割SCTD配置.如果有安裝SCTD，會使得收到的事件在右側，輸出的事件在左側，其它的事件在上方."};
SCT.LOCALS.OPTION_MISC28 = {name="測試", tooltipText = "在每個框架中產生測試的文字事件"};
SCT.LOCALS.OPTION_MISC29 = {name="自訂事件"};
SCT.LOCALS.OPTION_MISC30 = {name="儲存事件", tooltipText = "儲存這自訂事件的變更."};
SCT.LOCALS.OPTION_MISC31 = {name="刪除事件", tooltipText = "刪除這自訂事件.", warning="-警告-\n\n你確定要刪除這自訂事件嗎?"};
SCT.LOCALS.OPTION_MISC32 = {name="新增事件", tooltipText = "新增自訂事件."};
SCT.LOCALS.OPTION_MISC33 = {name="重置事件", tooltipText = "重置所有事件到sct_event_config.lua的預設值.", warning="-警告-\n\n你確定要重置所有SCT的自訂事件到預設值嗎?"};
SCT.LOCALS.OPTION_MISC34 = {name="取消", tooltipText = "取消這自訂事件的變更"};
SCT.LOCALS.OPTION_MISC35 = {name="職業", tooltipText = "選擇這事件的職業", open="<", close=">"};

--Selections
SCT.LOCALS.OPTION_SELECTION1 = { name="動畫類型", tooltipText = "選擇動態文字動畫類型", table = {[1] = "垂直(預設)",[2] = "彩虹",[3] = "水平",[4] = "斜下", [5] = "斜上", [6] = "飄灑", [7] = "HUD曲線", [8] = "HUD斜向"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="彈出方式", tooltipText = "選擇動態文字彈出方式", table = {[1] = "交錯",[2] = "傷害向左",[3] = "傷害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="字體", tooltipText = "選擇動態文字字體", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="字體描邊", tooltipText = "選擇動態文字字體描邊類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="靜態字體", tooltipText = "選擇靜態訊息字體", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="靜態字體輪廓", tooltipText = "選擇靜態訊息字體輪廓類型", table = {[1] = "無",[2] = "細",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="文字對齊 ", tooltipText = "設定文字如何對齊.在使用HUD動畫或是垂直顯示時最有用.「HUD方式對齊」將使得左側文字為靠右對齊／右側文字為靠左對齊.", table = {[1] = "左",[2] = "置中",[3] = "右", [4] = "HUD方式對齊"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="簡寫式法術名", tooltipText = "如何縮短法術名稱", table = {[1] = "切斷",[2] = "縮寫式"}};
SCT.LOCALS.OPTION_SELECTION9 = { name="圖示對位", tooltipText = "選擇圖示的方向",  table = {[1] = "左", [2] = "右", [3] = "向內", [4] = "向外",}};

local eventtypes = {
  ["BUFF"] = "增益獲得",
  ["FADE"] = "增益消失",
  ["MISS"] = "未命中",
  ["HEAL"] = "治療",
  ["DAMAGE"] = "傷害",
  ["DEATH"] = "死亡",
  ["INTERRUPT"] = "中斷",
  ["POWER"] = "能量",
  ["SUMMON"] = "召喚",
  ["DISPEL"] = "驅散",
  ["CAST"] = "施法",

}

local flags = {
  ["SELF"] = "玩家",
  ["TARGET"] = "目標",
  ["FOCUS"] = "Focus",
  ["PET"] = "寵物",
  ["ENEMY"] = "敵人",
  ["FRIEND"] = "朋友",
  ["ANY"] = "任何人",
}

local frames = {
  [SCT.FRAME1] = SCT.LOCALS.OPTION_MISC14.name,
  [SCT.FRAME2] = SCT.LOCALS.OPTION_MISC20.name,
  [SCT.MSG] = SCT.LOCALS.OPTION_MISC15.name,
}
if SCTD then
  frames[SCT.FRAME3] = "SCTD"
end

local misses = {
  ["ABSORB"] = ABSORB,
  ["DODGE"] = DODGE,
  ["RESIST"] = RESIST,
  ["PARRY"] = PARRY,
  ["MISS"] = MISS,
  ["BLOCK"] = BLOCK,
  ["REFLECT"] = REFLECT,
  ["DEFLECT"] = DEFLECT,
  ["IMMUNE"] = IMMUNE,
  ["EVADE"] = EVADE,
  ["ANY"] = "Any",
}

local power = {
  [SPELL_POWER_MANA] = MANA,
  [SPELL_POWER_RAGE] = RAGE,
  [SPELL_POWER_FOCUS] = FOCUS,
  [SPELL_POWER_ENERGY] = ENERGY,
  --[SPELL_POWER_HAPPINESS] = HAPPINESS_POINTS,
  [0] = "Any",
}

--Custom Selections
SCT.LOCALS.OPTION_CUSTOMSELECTION1 = { name="事件類型", tooltipText = "這事件的類型.", table = eventtypes};
SCT.LOCALS.OPTION_CUSTOMSELECTION2 = { name="目標", tooltipText = "這事件的目標.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION3 = { name="來源", tooltipText = "這事件的來源.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION4 = { name="事件框", tooltipText = "這事件會顯示的框.", table = frames};
SCT.LOCALS.OPTION_CUSTOMSELECTION5 = { name="未命中的類型", tooltipText = "未命中的類型觸發這事件.", table = misses};
SCT.LOCALS.OPTION_CUSTOMSELECTION6 = { name="能量類型", tooltipText = "能量的類型觸發這事件.", table = power};

--EditBox options
SCT.LOCALS.OPTION_EDITBOX1 = { name="名稱", tooltipText = "自訂事件的名稱"};
SCT.LOCALS.OPTION_EDITBOX2 = { name="顯示", tooltipText = "想要SCT顯示的事件. 使用 *1 - *5 做捕捉數值:\n\n*1 - 法術名稱\n*2 - 來源\n*3 - 目標\n*4 - 一般 (數量, 等等...)"};
SCT.LOCALS.OPTION_EDITBOX3 = { name="搜尋", tooltipText = "用法術或技能去尋找.可以用空格(片語)或部分字搜尋."};
SCT.LOCALS.OPTION_EDITBOX4 = { name="聲音", tooltipText = "這自訂事件所使用的聲音檔. 例如:GnomeExploration"};
SCT.LOCALS.OPTION_EDITBOX5 = { name="聲音檔", tooltipText = "這自訂事件所使用的聲音檔的位置. 例如:Interface\\AddOns\\MyAddOn\\mysound.ogg or Sound\\Spells\\ShaysBell.ogg"};
