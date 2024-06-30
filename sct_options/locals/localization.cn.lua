-- Chinese Translation Valkyrie@CWDG

if GetLocale() ~= "zhCN" then return end

local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "伤害", tooltipText = "显示受到的近战伤害与其他伤害（火焰、摔落等）"};
SCT.LOCALS.OPTION_EVENT2 = {name = "未击中", tooltipText = "显示敌人未击中你的近战攻击"};
SCT.LOCALS.OPTION_EVENT3 = {name = "闪避", tooltipText = "显示闪避的近战攻击"};
SCT.LOCALS.OPTION_EVENT4 = {name = "招架", tooltipText = "显示招架的近战攻击"};
SCT.LOCALS.OPTION_EVENT5 = {name = "格挡", tooltipText = "显示格挡的近战攻击"};
SCT.LOCALS.OPTION_EVENT6 = {name = "法术伤害", tooltipText = "显示受到的法术伤害"};
SCT.LOCALS.OPTION_EVENT7 = {name = "法术治疗", tooltipText = "显示受到的法术治疗"};
SCT.LOCALS.OPTION_EVENT8 = {name = "法术抵抗", tooltipText = "显示抵抗敌人的法术"};
SCT.LOCALS.OPTION_EVENT9 = {name = "不良效果", tooltipText = "显示受到的不良效果影响"};
SCT.LOCALS.OPTION_EVENT10 = {name = "吸收/其它", tooltipText = "显示对敌人伤害的吸收、反射、免疫效果等"};
SCT.LOCALS.OPTION_EVENT11 = {name = "生命过低", tooltipText = "生命值过低警告"};
SCT.LOCALS.OPTION_EVENT12 = {name = "法力过低", tooltipText = "法力值过低警告"};
SCT.LOCALS.OPTION_EVENT13 = {name = "能量获得", tooltipText = "显示透过药水、物品、增益效果等获得的法力值、怒气、能量（非正常恢复）"};
SCT.LOCALS.OPTION_EVENT14 = {name = "战斗标记", tooltipText = "显示进入、脱离战斗状态的提示信息"};
SCT.LOCALS.OPTION_EVENT15 = {name = "连击点", tooltipText = "显示获得的连击点数"};
SCT.LOCALS.OPTION_EVENT16 = {name = "荣誉获得", tooltipText = "显示获得的荣誉点数"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buff效果", tooltipText = "显示获得的增益效果"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Buff消失", tooltipText = "显示从你身上消失的增益效果"};
SCT.LOCALS.OPTION_EVENT19 = {name = "可使用技能", tooltipText = "显示进入可使用状态的特定技能（斩杀、猫鼬撕咬、愤怒之锤等）"};
SCT.LOCALS.OPTION_EVENT20 = {name = "声望", tooltipText = "显示声望的提昇或降低"};
SCT.LOCALS.OPTION_EVENT21 = {name = "玩家治疗", tooltipText = "显示对别人的治疗"};
SCT.LOCALS.OPTION_EVENT22 = {name = "技能点数", tooltipText = "显示技能点数的提昇"};
SCT.LOCALS.OPTION_EVENT23 = {name = "击杀", tooltipText = "显示是否是由你的最后一击造成怪物死亡的。"};
SCT.LOCALS.OPTION_EVENT24 = {name = "被打断", tooltipText = "显示施法被中断提示。"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "启用SCT", tooltipText = "启用 Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "标记战斗信息", tooltipText = "在战斗信息两侧添加'*'标记"};
SCT.LOCALS.OPTION_CHECK3 = { name = "显示治疗者", tooltipText = "显示治疗你的玩家或生物的名字"};
SCT.LOCALS.OPTION_CHECK4 = { name = "文字向下滚动", tooltipText = "战斗信息向下滚动"};
SCT.LOCALS.OPTION_CHECK5 = { name = "重击效果", tooltipText = "以特效显示受到的致命一击或极效治疗"};
SCT.LOCALS.OPTION_CHECK6 = { name = "法术伤害类型", tooltipText = "显示你受到的法术伤害的类型"};
SCT.LOCALS.OPTION_CHECK7 = { name = "对伤害启用字体设定", tooltipText = "以SCT使用的字体显示游戏预设的伤害数字。\n\n注意：此设定必须重新登入才能生效。重新载入界面无效。"};
SCT.LOCALS.OPTION_CHECK8 = { name = "显示所有能量获得", tooltipText = "显示所有的能量获得，而不是仅显示战斗记录中出现的。 \n\n注意：必须先启用普通的“能量获得”事件。非常容易洗频。且德鲁伊在切换回施法者形态时会有不正常的现象。"};
SCT.LOCALS.OPTION_CHECK10 = { name = "显示过量治疗", tooltipText = "显示你的过量治疗值，必须先启用“玩家治疗”事件。"};
SCT.LOCALS.OPTION_CHECK11 = { name = "警报声音", tooltipText = "当发出警告时播放声音。"};
SCT.LOCALS.OPTION_CHECK12 = { name = "法术伤害颜色", tooltipText = "以不同的颜色显示不同类型的法术伤害"};
SCT.LOCALS.OPTION_CHECK13 = { name = "启用自定义事件", tooltipText = "启用自定义事件。关闭后能节省大量记忆体的使用。"};
SCT.LOCALS.OPTION_CHECK14 = { name = "启用低耗模式", tooltipText = "启用低CPU消耗模式。低耗模式使用WoW内建的事件来驱动大部分SCT事件，减少对战斗记录的监控分析。能够提高整体效能，但部分功能将不能使用，包括自定事件。\n\n请注意这些WoW事件回馈的信息不如战斗记录那麽丰富，而且可能会出错。"};
SCT.LOCALS.OPTION_CHECK15 = { name = "闪烁", tooltipText = "使得致命／极效的效果呈现闪烁状态。"};
SCT.LOCALS.OPTION_CHECK16 = { name = "横扫／碾压", tooltipText = "显示横扫 ~150~ 以及碾压 ^150^ 攻击"};
SCT.LOCALS.OPTION_CHECK17 = { name = "你的持续治疗", tooltipText = "显示你对别的角色所施放的持续性治疗法术效果。请注意如果你对很多人放恢复或是回春术的话，画面上将会有一堆HOT信息。"};
SCT.LOCALS.OPTION_CHECK18 = { name = "在血条上显示治疗", tooltipText = "在你对玩家施放治疗法术的血条上，启用或禁用显示你要治疗的动作。\n\n友方的血条必须为开放状态，并且你必须能看见血条。本功能不一定100%正常工作。若为正常工作，治疗文字将显示在默认位置。\n\n若要禁用的话，需重新加载UI才可以。"};
SCT.LOCALS.OPTION_CHECK19 = { name = "关闭WoW自带治疗显示", tooltipText = "启用或禁用（2.1版本）治疗显示文字。"};
SCT.LOCALS.OPTION_CHECK20 = { name = "显示图标", tooltipText = "显示你施放的法术技能图标。"};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="文字动画速度", minText="快", maxText="慢", tooltipText = "调整动态文字滚动速度"};
SCT.LOCALS.OPTION_SLIDER2 = { name="文字大小", minText="小", maxText="大", tooltipText = "调整动态文字的大小"};
SCT.LOCALS.OPTION_SLIDER3 = { name="生命百分比", minText="10%", maxText="90%", tooltipText = "设定玩家生命值降低到几％时发出警告"};
SCT.LOCALS.OPTION_SLIDER4 = { name="法力百分比",  minText="10%", maxText="90%", tooltipText = "设定玩家法力值降低到几％时发出警告"};
SCT.LOCALS.OPTION_SLIDER5 = { name="文字透明度", minText="0%", maxText="100%", tooltipText = "调整动态文字的透明度"};
SCT.LOCALS.OPTION_SLIDER6 = { name="文字移动距离", minText="小", maxText="大", tooltipText = "调整动态文字间的距离"};
SCT.LOCALS.OPTION_SLIDER7 = { name="文字横坐标", minText="-600", maxText="600", tooltipText = "调整以文字中间点为准，其显示的水平位置"};
SCT.LOCALS.OPTION_SLIDER8 = { name="文字纵坐标", minText="-400", maxText="400", tooltipText = "调整以文字中间点为准，其显示的垂直位置"};
SCT.LOCALS.OPTION_SLIDER9 = { name="静态文字横坐标", minText="-600", maxText="600", tooltipText = "调整以文字中间点为准，静态信息其显示的水平位置"};
SCT.LOCALS.OPTION_SLIDER10 = { name="静态文字纵坐标", minText="-400", maxText="400", tooltipText = "调整以文字中间点为准，静态信息其显示的垂直位置"};
SCT.LOCALS.OPTION_SLIDER11 = { name="静态信息淡出速度", minText="快", maxText="慢", tooltipText = "调整静态信息淡出的速度"};
SCT.LOCALS.OPTION_SLIDER12 = { name="静态信息字体大小", minText="小", maxText="大", tooltipText = "调整静态信息的文字大小"};
SCT.LOCALS.OPTION_SLIDER13 = { name="治疗者过滤", minText="0", maxText="500", tooltipText = "调整SCT要显示的最小的治疗量的值,用於不想显示如恢复，回春术，祝福等小量的治疗效果时"};
SCT.LOCALS.OPTION_SLIDER14 = { name="法力过滤", minText="0", maxText="500", tooltipText = "设定SCT要显示的数字的最低法力获得的门槛值.对於过滤掉少量的法力恢复如图腾，祝福效果...等等."};
SCT.LOCALS.OPTION_SLIDER15 = { name="弧形条间距", minText="0", maxText="200", tooltipText = "控制HUD动画效果和水平中点距离。对于想要信息尽量靠中间显示，但是又想要调整和水平中间点距离时使用."};
SCT.LOCALS.OPTION_SLIDER16 = { name="简写法术名", minText="1", maxText="30", tooltipText = "法术名用简写方式来代替。"};
SCT.LOCALS.OPTION_SLIDER17 = { name="伤害过滤", minText="0", maxText="500", tooltipText = "过滤最小伤害数值，比如dot等..."};

--Spell Color options]
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "设定"..SPELL_SCHOOL0_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "设定"..SPELL_SCHOOL1_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "设定"..SPELL_SCHOOL2_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "设定"..SPELL_SCHOOL3_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "设定"..SPELL_SCHOOL4_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "设定"..SPELL_SCHOOL5_CAP.."法术的显示颜色"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "设定"..SPELL_SCHOOL6_CAP.."法术的显示颜色"};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT设定"..SCT.Version, tooltipText = "按左键拖曳来移动"};
SCT.LOCALS.OPTION_MISC2 = {name="关闭", tooltipText = "关闭法术颜色设定" };
SCT.LOCALS.OPTION_MISC3 = {name="编辑", tooltipText = "编辑法术显示颜色" };
SCT.LOCALS.OPTION_MISC4 = {name="杂项设定"};
SCT.LOCALS.OPTION_MISC5 = {name="警告设定"};
SCT.LOCALS.OPTION_MISC6 = {name="动画设定"};
SCT.LOCALS.OPTION_MISC7 = {name="选择设定档"};
SCT.LOCALS.OPTION_MISC8 = {name="存档并关闭", tooltipText = "储存所有目前设定，并关闭设定选单"};
SCT.LOCALS.OPTION_MISC9 = {name="重置", tooltipText = "＞＞警告＜＜\n\n确定要还原所有SCT设定为预设值吗？"};
SCT.LOCALS.OPTION_MISC10 = {name="设定档", tooltipText = "选择其它角色的设定档"};
SCT.LOCALS.OPTION_MISC11 = {name="载入", tooltipText = "载入其它角色的设定档到此角色"};
SCT.LOCALS.OPTION_MISC12 = {name="删除", tooltipText = "删除一个角色设定档"};
SCT.LOCALS.OPTION_MISC13 = {name="文字设定" };
SCT.LOCALS.OPTION_MISC14 = {name="框架1"};
SCT.LOCALS.OPTION_MISC15 = {name="静态信息"};
SCT.LOCALS.OPTION_MISC16 = {name="动画效果"};
SCT.LOCALS.OPTION_MISC17 = {name="法术设定"};
SCT.LOCALS.OPTION_MISC18 = {name="视窗"};
SCT.LOCALS.OPTION_MISC19 = {name="法术"};
SCT.LOCALS.OPTION_MISC20 = {name="框架2"};
SCT.LOCALS.OPTION_MISC21 = {name="事件"};
SCT.LOCALS.OPTION_MISC22 = {name="典型设定档", tooltipText = "载入典型设定档，使得SCT的动作行为接近内定值。"};
SCT.LOCALS.OPTION_MISC23 = {name="效能设定档", tooltipText = "载入高效能配置。选取所有的设定来得到最佳的效能。"};
SCT.LOCALS.OPTION_MISC24 = {name="分割设定档", tooltipText = "载入分割配置。使得伤害和事件显示在右侧，治疗和增益效果在左侧。"};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof设定档", tooltipText = "载入Grayhoof配置。使SCT有如Grayhoof(作者)在使用它时一般的运作"};
SCT.LOCALS.OPTION_MISC26 = {name="内建设定档", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="分割的SCTD设定档", tooltipText = "载入分割SCTD配置。如果有安装SCTD，会使得收到的事件在右侧，输出的事件在左侧，其它的事件在上方。"};
SCT.LOCALS.OPTION_MISC28 = {name="测试", tooltipText = "在每个框架中生成测试事件。"};

--Animation Types
SCT.LOCALS.OPTION_SELECTION1 = { name="动画类型", tooltipText = "选择动态文字动画类型", table = {[1] = "垂直(预设)",[2] = "彩虹",[3] = "水平",[4] = "斜下", [5] = "斜上", [6] = "飘洒", [7] = "HUD曲线", [8] = "HUD斜向"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="弹出方式", tooltipText = "选择动态文字弹出方式", table = {[1] = "交错",[2] = "伤害向左",[3] = "伤害向右", [4] = "全部向左", [5] = "全部向右"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="战斗字体", tooltipText = "选择你使用的字体", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="字体描边", tooltipText = "选择动态文字字体描边类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="静态信息字体", tooltipText = "选择静态信息字体", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="静态信息字体轮廓", tooltipText = "选择静态信息字体轮廓类型", table = {[1] = "无",[2] = "细",[3] = "粗"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="对齐", tooltipText = "设定文字对齐。在使用HUD动画或是垂直显示时最有用。「HUD方式对齐」将使得左侧文字为靠右对齐／右侧文字为靠左对齐。", table = {[1] = "左",[2] = "居中",[3] = "右", [4] = "HUD方式对齐"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="法术名缩写", tooltipText = "缩写方式", table = {[1] = "切断",[2] = "缩写"}};
SCT.LOCALS.OPTION_SELECTION9 = { name="图标的设置", tooltipText = "设置图标的位置.", table = {[1] = "左", [2] = "右", [3] = "内部", [4] = "外部",}};
