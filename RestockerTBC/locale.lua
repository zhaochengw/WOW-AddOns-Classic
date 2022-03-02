
local _, RS = ...

local L = setmetatable(
  {  },
  {
    __index = function(tbl, key, val)
      return key;
    end,
  }
);

RS.L = L;

if GetLocale() == 'zhCN' then
  --  MainFrame.lua
  L["Add"] = "添加";
  L["Add an item"] = "添加一个物品";
  L["Drop an item from your bag, or type a numeric item ID"] = "从背包中将一个物品拖到窗口中，或者手动输入物品ID或者已有物品的名字";
  L["Auto buy items"] = "自动购买";
  L["Restock from bank"] = "自动从银行取出";
  L["Profile"] = "配置";
  --  OptionsPanel.lua
  L["Display login message"] = "打印欢迎信息";
  L["Open window at vendor"] = "与商人交易时打开插件窗口";
  L["Open window at bank"] = "打开银行时打开插件窗口";
  L["Sort list alphabetically"] = "按名字排序";
  L["Sort list by amount"] = "按金额排序";
  L["Profiles"] = "配置文件";
  L["Add profile"] = "添加一个配置";
  L["Delete profile"] = "删除配置";
  L["Amount to restock"] = "添加至列表";
  L["Press Enter when finished editing"] = "按回车来确定修改或添加";
  L["Required vendor reputation (default 0 or empty)"] = "声望检查";
  L["Check player's reputation standing with the vendor before you buy"] = "检查NPC的声望，达到或超过设定值才购买";
  L["Neutral=4, Friendly=5, Honored=6, Revered=7, Exalted=8"] = "中立=4, 友善=5, 尊敬=6, 崇敬=7, 崇拜=8";
  L["Press Enter when finished editing"] = "按回车应用编辑";
else
  --  MainFrame.lua
  L["Add"] = "Add";
  L["Add an item"] = "Add an item";
  L["Drop an item from your bag, or type a numeric item ID"] = "Drop an item from your bag, or type a numeric item ID";
  L["Auto buy items"] = "Auto buy items";
  L["Restock from bank"] = "Restock from bank";
  L["Profile"] = "Profile";
  --  OptionsPanel.lua
  L["Display login message"] = "Display login message";
  L["Open window at vendor"] = "Open window at vendor";
  L["Open window at bank"] = "Open window at bank";
  L["Sort list alphabetically"] = "Sort list alphabetically";
  L["Sort list by amount"] = "Sort list by amount";
  L["Profiles"] = "Profiles";
  L["Add profile"] = "Add profile";
  L["Delete profile"] = "Delete profile";
  L["Amount to restock"] = "Amount to restock";
  L["Press Enter when finished editing"] = "Press Enter when finished editing";
  L["Required vendor reputation (default 0 or empty)"] = "Required vendor reputation (default 0 or empty)";
  L["Check player's reputation standing with the vendor before you buy"] = "Check player's reputation standing with the vendor before you buy";
  L["Neutral=4, Friendly=5, Honored=6, Revered=7, Exalted=8"] = "Neutral=4, Friendly=5, Honored=6, Revered=7, Exalted=8";
  L["Press Enter when finished editing"] = "Press Enter when finished editing";
end
