local follow = CreateFrame("frame",nil,UIParent)
local configurationPanelCreated = false

function loadSettings()
    if settings == nil then
        settings = settings or {}
        settings.followCheck = true
        settings.stopCheck = true
        settings.command1 = "go"
        settings.command2 = "stop"
				settings.followLeaderCheck = true
				settings.followNameCheck = false
				settings.followName = "这里输入队伍中要跟随的人"
				settings.followPartyCheck = false
				settings.repoCheck = true
        settings.tradeCheck = false
        settings.greyCheck = true
        settings.greenCheck = false
        settings.blueCheck = false
    end
end

DonotSellItem = {
"厚符文布绷带",
"超强治疗药水",
"强效法力药水",
}

function CreatPanel()
    local configurationPanel = CreateFrame("Frame", "MainFrame")
    configurationPanel.name = "AutoFollow"
    InterfaceOptions_AddCategory(configurationPanel)

    local introMessageHeader = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    introMessageHeader:SetPoint("TOPLEFT", 10, -10)
    introMessageHeader:SetText("自动跟随 - AutoFollow")
	
    local VerTitle = configurationPanel:CreateFontString(nil, "ARTWORK","NumberFontNormalSmall")
    VerTitle:SetPoint("TOPRIGHT", 0, -10)
    VerTitle:SetText("V1.1.28")
	
		local subText = configurationPanel:CreateFontString(nil, 'ARTWORK', 'GameFontHighlightSmall')
		subText:SetPoint('BOTTOMRIGHT', -0, 0)
		subText:SetText('作者: Jason, LeonLin.')

    local followCheckBox = CreateFrame("CheckButton","followCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    followCheckBox:SetPoint("TOPLEFT",10, -40)
    getglobal(followCheckBox:GetName().."Text"):SetText("自动跟随 - 设置一个命令开始跟随。 <该项目是跟随设置总开关>")

    local nameTitle1 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    nameTitle1:SetPoint("TOPLEFT", 15, -65)
    nameTitle1:SetText("跟随命令:")

    local nameBox1 = CreateFrame("EditBox","FollowUnit", configurationPanel,"InputBoxTemplate")
    nameBox1:SetMultiLine(true)
    nameBox1:SetTextInsets(6, 10, 3, 5)
    nameBox1:SetFontObject(ChatFontNormal)
    nameBox1:SetWidth(110)
    nameBox1:SetHeight(25)
    nameBox1:SetPoint("TOPLEFT",100, -62)
    nameBox1:HighlightText()
    nameBox1:SetMaxLetters(10)
    nameBox1:SetAutoFocus(false)
    -- nameBox1:SetBackdrop({
    --     _,
    --     edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    --     _,
    --     _,
    --     edgeSize = 10,
    --     _
    -- })


    local stopCheckBox = CreateFrame("CheckButton","stopCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    stopCheckBox:SetPoint("TOPLEFT",50, -95)
    getglobal(stopCheckBox:GetName().."Text"):SetText("自动停止 - 设置一个命令停止跟随")

    local nameTitle2 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    nameTitle2:SetPoint("TOPLEFT", 55, -120)
    nameTitle2:SetText("停止命令:")

    local nameBox2 = CreateFrame("EditBox","FollowUnit", configurationPanel,"InputBoxTemplate")
    nameBox2:SetMultiLine(true)
    nameBox2:SetTextInsets(6, 10, 3, 5)
    nameBox2:SetFontObject(ChatFontNormal)
    nameBox2:SetWidth(110)
    nameBox2:SetHeight(25)
    nameBox2:SetPoint("TOPLEFT",140, -117)
    nameBox2:HighlightText()
    nameBox2:SetMaxLetters(10)
    nameBox2:SetAutoFocus(false)
    -- nameBox2:SetBackdrop({
    --     _,
    --     edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    --     _,
    --     _,
    --     edgeSize = 10,
    --     _
    -- })


    local followLeaderCheckBox = CreateFrame("CheckButton","followLeaderCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    followLeaderCheckBox:SetPoint("TOPLEFT",55, -150)
    getglobal(followLeaderCheckBox:GetName().."Text"):SetText("只听从队长命令 - 此选项优先级最高。")

    local followNameCheckBox = CreateFrame("CheckButton","followNameCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    followNameCheckBox:SetPoint("TOPLEFT",55, -175)
    getglobal(followNameCheckBox:GetName().."Text"):SetText("只听从指定目标命令 - 如果队伍中找不到该目标，将听从全队命令。")

    local nameBox3 = CreateFrame("EditBox","FollowUnit", configurationPanel,"InputBoxTemplate")
    nameBox3:SetMultiLine(true)
    nameBox3:SetTextInsets(6, 10, 3, 5)
    nameBox3:SetFontObject(ChatFontNormal)
    nameBox3:SetWidth(300)
    nameBox3:SetHeight(25)
    nameBox3:SetPoint("TOPLEFT",77, -200)
    nameBox3:HighlightText()
    nameBox3:SetMaxLetters(18)
    nameBox3:SetAutoFocus(false)
    -- nameBox3:SetBackdrop({
    --     _,
    --     edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
    --     _,
    --     _,
    --     edgeSize = 10,
    --     _
    -- })


    local followPartyCheckBox = CreateFrame("CheckButton","followPartyCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    followPartyCheckBox:SetPoint("TOPLEFT",55, -228)
    getglobal(followPartyCheckBox:GetName().."Text"):SetText("听从队伍中任意队员命令。")
	
    local repoCheckBox = CreateFrame("CheckButton","repoCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    repoCheckBox:SetPoint("TOPLEFT",55, -255)
    getglobal(repoCheckBox:GetName().."Text"):SetText("向命令目标回报跟随状况。")


    local introMessageHeader2 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontNormalLarge")
    introMessageHeader2:SetPoint("TOPLEFT", 10, -290)
    introMessageHeader2:SetText("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━")

    local tradeCheckBox = CreateFrame("CheckButton","tradeCheckBox", configurationPanel, "ChatConfigCheckButtonTemplate")
    tradeCheckBox:SetPoint("TOPLEFT",10, -320)
    getglobal(tradeCheckBox:GetName().."Text"):SetText("自动交易灰色物品")

    local introMessageHeader3 = configurationPanel:CreateFontString(nil, "ARTWORK","GameFontRedSmall")
    introMessageHeader3:SetPoint("TOPLEFT", 10, -365)
    introMessageHeader3:SetText("设置要交易的物品的质量")

    local colorCheckBox1 = CreateFrame("CheckButton","colorCheckBox1", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox1:SetPoint("TOPLEFT",10, -390)
    getglobal(colorCheckBox1:GetName().."Text"):SetText("灰色")
    colorCheckBox1:RegisterForClicks("AnyUp",false)

    local colorCheckBox2 = CreateFrame("CheckButton","colorCheckBox2", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox2:SetPoint("TOPLEFT",150, -390)
    getglobal(colorCheckBox2:GetName().."Text"):SetText("绿色")
    colorCheckBox2:RegisterForClicks("AnyUp",false)

    local colorCheckBox3 = CreateFrame("CheckButton","colorCheckBox3", configurationPanel, "ChatConfigCheckButtonTemplate")
    colorCheckBox3:SetPoint("TOPLEFT",300, -390)
    getglobal(colorCheckBox3:GetName().."Text"):SetText("蓝色")
    colorCheckBox3:RegisterForClicks("AnyUp",false)

    colorCheckBox1:SetScript("OnClick", function(self)
        colorCheckBox1:SetChecked(true)
        colorCheckBox2:SetChecked(false)
        colorCheckBox3:SetChecked(false)
    end)

    colorCheckBox2:SetScript("OnClick", function(self)
        if colorCheckBox2:GetChecked() == false then
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(false)
            colorCheckBox3:SetChecked(false)
        else
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(false)
        end

    end)

    colorCheckBox3:SetScript("OnClick", function(self)
        if colorCheckBox3:GetChecked() == false then
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(false)
        else
            colorCheckBox1:SetChecked(true)
            colorCheckBox2:SetChecked(true)
            colorCheckBox3:SetChecked(true)
        end

    end)
	
	followLeaderCheckBox:SetScript("OnClick", function(self)
        followLeaderCheckBox:SetChecked(true)
        followNameCheckBox:SetChecked(false)
        followPartyCheckBox:SetChecked(false)
    end)
	
	followNameCheckBox:SetScript("OnClick", function(self)
		followLeaderCheckBox:SetChecked(false)
		followNameCheckBox:SetChecked(true)
		followPartyCheckBox:SetChecked(false)

    end)
	
	followPartyCheckBox:SetScript("OnClick", function(self)
		followLeaderCheckBox:SetChecked(false)
		followNameCheckBox:SetChecked(false)
		followPartyCheckBox:SetChecked(true)
    end)


  configurationPanel.okay = function(self)
		settings.followCheck = followCheckBox:GetChecked()
		settings.stopCheck = stopCheckBox:GetChecked()

		settings.command1 = nameBox1:GetText()
		settings.command2 = nameBox2:GetText()
		
		settings.followLeaderCheck = followLeaderCheckBox:GetChecked()
		settings.followNameCheck = followNameCheckBox:GetChecked()
		
		settings.followName = nameBox3:GetText()
		
		settings.followPartyCheck = followPartyCheckBox:GetChecked()
		
		settings.repoCheck = repoCheckBox:GetChecked()

		settings.tradeCheck = tradeCheckBox:GetChecked()

		settings.greyCheck = colorCheckBox1:GetChecked()
		settings.greenCheck = colorCheckBox2:GetChecked()
		settings.blueCheck = colorCheckBox3:GetChecked()

	end

	configurationPanel.cancel = function(self)
		followCheckBox:SetChecked(settings.followCheck)
		stopCheckBox:SetChecked(settings.stopCheck)

    if settings.command1 then
		  nameBox1:SetText(settings.command1)
    end
    if settings.command2 then
		  nameBox2:SetText(settings.command2)
    end

		followLeaderCheckBox:SetChecked(settings.followLeaderCheck)
		followNameCheckBox:SetChecked(settings.followNameCheck)
		
		nameBox3:SetText(settings.followName)
		
		followPartyCheckBox:SetChecked(settings.followPartyCheck)
		
		repoCheckBox:SetChecked(settings.repoCheck)
		
		tradeCheckBox:SetChecked(settings.tradeCheck)

		colorCheckBox1:SetChecked(settings.greyCheck)
		colorCheckBox2:SetChecked(settings.greenCheck)
		colorCheckBox3:SetChecked(settings.blueCheck)

	end

	configurationPanel.cancel()
end


function qualityCheck()
		local qualityCount = -1
    if settings.greyCheck == true then
        qualityCount =0
    end
    if settings.greenCheck == true then
        qualityCount = 2
    end
    if settings.blueCheck == true then
        qualityCount = 3
    end
    return qualityCount
end


function follow:followEvent(event,arg1,_,_,_,arg5,_,_,_,_,_,_,_,_)
    if event == "ADDON_LOADED" then

        if configurationPanelCreated == false then
            configurationPanelCreated = true
            loadSettings()
            CreatPanel()
        end

    end

	if settings.followCheck == true then
		if settings.followLeaderCheck == true then
			if event == "CHAT_MSG_PARTY_LEADER" then
				if arg1 == settings.command1 then
					print("开始跟随")
					if settings.repoCheck == true then
						SendChatMessage("收到，小弟来了", "WHISPER", nil, arg5)
					end
					FollowUnit(arg5)
				end
				if arg1 == settings.command2 and settings.stopCheck == true then
					print("停止跟随")
					if settings.repoCheck == true then
						SendChatMessage("收到，别忘了我哦~", "WHISPER", nil, arg5)
					end
					FollowUnit("player")
				end
            end
			
		elseif settings.followNameCheck == true then
			if event == "CHAT_MSG_PARTY" or "CHAT_MSG_PARTY_LEADER" then
				if arg5 == settings.followName then
					if arg1 == settings.command1 then
						print("开始跟随")
						if settings.repoCheck == true then 
							SendChatMessage("收到，小弟来了", "WHISPER", nil, arg5)
						end
						FollowUnit(arg5)
					end
					if arg1 == settings.command2 and settings.stopCheck == true then
						print("停止跟随")
						if settings.repoCheck == true then 
							SendChatMessage("收到，别忘了我哦~", "WHISPER", nil, arg5)
						end
						FollowUnit("player")
					end
				end
			end
		else
			if event == "CHAT_MSG_PARTY" or "CHAT_MSG_PARTY_LEADER" then
				if arg1 == settings.command1 then
					print("开始跟随")
					if settings.repoCheck == true then 
						SendChatMessage("收到，小弟来了", "WHISPER", nil, arg5)
					end
					FollowUnit(arg5)
				end
				if arg1 == settings.command2 and settings.stopCheck == true then
					print("停止跟随")
					if settings.repoCheck == true then 
						SendChatMessage("收到，别忘了我哦~", "WHISPER", nil, arg5)
					end
					FollowUnit("player")
				end
			end
    end
  end

    if event == "TRADE_SHOW" then
        if settings.tradeCheck == true then
            for bag = 0, 4 do
                for slot = 0, GetContainerNumSlots(bag) do
                    local link = GetContainerItemLink(bag, slot)
                    if link and (select(3, GetItemInfo(link)) <= qualityCheck())  then
                        if select(1, GetItemInfo(link)) ~= "厚符文布绷带" and select(1, GetItemInfo(link)) ~= "超强治疗药水" and select(1, GetItemInfo(link)) ~= "强效法力药水" and select(1, GetItemInfo(link)) ~= "有限无敌药水" and select(1, GetItemInfo(link)) ~= "自然防护药水" and select(1, GetItemInfo(link)) ~= "魔粉" and select(1, GetItemInfo(link)) ~= "传送门符文" and select(1, GetItemInfo(link)) ~= "传送符文" and select(1, GetItemInfo(link)) ~= "魔法晶水" and select(1, GetItemInfo(link)) ~= "魔法甜面包"then
                            UseContainerItem(bag, slot)
                        end
                    end
                end
            end
        end
    end

	end


follow:RegisterEvent("ADDON_LOADED")

follow:RegisterEvent("CHAT_MSG_PARTY")
follow:RegisterEvent("CHAT_MSG_WHISPER")
follow:RegisterEvent("CHAT_MSG_PARTY_LEADER")

follow:RegisterEvent("TRADE_SHOW")

follow:RegisterEvent("PLAYER_LOGIN")

follow:SetScript("OnEvent",follow.followEvent)

SLASH_TEST1 = "/autofollow"
SLASH_TEST2 = "/af"
SlashCmdList["TEST"] = function(msg)
    InterfaceOptionsFrame_OpenToCategory("AutoFollow")
end
