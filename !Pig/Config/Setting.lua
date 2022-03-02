local _, addonTable = ...;

--///////////////////////////////////////////
local fuFrame=Pig_Options_RF_TAB_14_UI

local Config_Name ={"初始配置","常用配置","PIG",};
local Config_ID ={"Default","AllNO","PIG"};
local Config_SM ={
	"此配置默认关闭所有功能，请按需开启。",
	"开启常用功能，不需要功能请自行关闭。",
	"作者个人使用的配置",
};
---------
for id=1,#Config_ID do
	local Default_Button = CreateFrame("Button", "Default_Button_"..id, fuFrame, "UIPanelButtonTemplate");  
	Default_Button:SetSize(120,30);
	if id==1 then
		Default_Button:SetPoint("TOPLEFT",fuFrame,"TOPLEFT",20,-20);
	else
		Default_Button:SetPoint("TOPLEFT",_G["Default_Button_"..(id-1)],"BOTTOMLEFT",0,-40);
	end
	Default_Button:SetText(Config_Name[id]);
	Default_Button.title = Default_Button:CreateFontString();
	Default_Button.title:SetPoint("LEFT", Default_Button, "RIGHT", 6, 0);
	Default_Button.title:SetFontObject(GameFontNormal);
	Default_Button.title:SetTextColor(0, 1, 0, 1);
	Default_Button.title:SetJustifyH("LEFT");
	Default_Button.title:SetText(Config_SM[id]);
	Default_Button.line = Default_Button:CreateLine()
	Default_Button.line:SetColorTexture(1,1,1,0.2)
	Default_Button.line:SetThickness(1);
	Default_Button.line:SetStartPoint("BOTTOMLEFT",-16,-20)
	Default_Button.line:SetEndPoint("BOTTOMRIGHT",444,-20)
end

for id=1,#Config_ID do
	_G["Default_Button_"..id]:SetScript("OnClick", function ()
		StaticPopup_Show ("PEIZHI_"..Config_ID[id]);
	end);
	StaticPopupDialogs["PEIZHI_"..Config_ID[id]] = {
		text = "此操作将\124cff00ff00载入\124r\n"..Config_Name[id].."的设置。\n已保存的聊天记录，副本助手/带本助手的数据也将被\124cffff0000清空\124r。\n确定载入?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG = addonTable[Config_ID[id]];
			PIG_Per = addonTable[Config_ID[id].."_Per"];
			Pig_Options_RLtishi_UI:Show()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
end
----------------------------------------------------------------
---提示
fuFrame.tishi = fuFrame:CreateFontString();
fuFrame.tishi:SetPoint("TOPLEFT", fuFrame, "TOPLEFT", 20, -300);
fuFrame.tishi:SetFont(GameFontNormal:GetFont(), 20,"OUTLINE")
fuFrame.tishi:SetTextColor(1, 1, 0, 1);
fuFrame.tishi:SetText("提示：");
fuFrame.tishi1 = fuFrame:CreateFontString();
fuFrame.tishi1:SetPoint("TOPLEFT", fuFrame.tishi, "TOPRIGHT", 10, -2);
fuFrame.tishi1:SetFont(ChatFontNormal:GetFont(), 14,"OUTLINE")
fuFrame.tishi1:SetTextColor(0.6, 1, 0, 1);
fuFrame.tishi1:SetJustifyH("LEFT");
fuFrame.tishi1:SetText(
	"1、如遇到问题，请在对应功能内单独重置功能配置。\n"..
	"2、如未解决请先在此恢复初始配置再查看是否还存在问题。\n"..
	"\124cffFFff003、如问题仍未解决请加关于内的反馈群。\124r");