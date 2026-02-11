---@type ns
local ns = select(2, ...)
local L = ns.L

local GoodLeader = ns.Addon:NewClass('UI.GoodLeaderFrame', 'Frame.GoodLeaderTemplate')

local miniCertificationTextures = {
    [1] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_1:17:40:0:0:1:1:0:1:0:1|t]],
    [2] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_2:17:40:0:0:1:1:0:1:0:1|t]],
    [3] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_3:17:40:0:0:1:1:0:1:0:1|t]],
    [4] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_4:17:40:0:0:1:1:0:1:0:1|t]],
    [5] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_5:17:40:0:0:1:1:0:1:0:1|t]],
    [6] = [[|TInterface\AddOns\MeetingHorn\Media\mini_certification_icon_6:17:40:0:0:1:1:0:1:0:1|t]],
}

local medalTextures = {
    [1] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig1:22:64:0:0:128:64:0:128:0:46|t]],
    [2] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig2:22:64:0:0:128:64:0:128:0:46|t]],
    [140] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig140:22:64:0:0:128:64:0:128:0:46|t]],
    [170] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig170:22:64:0:0:128:64:0:128:0:46|t]],
    [200] = [[|TInterface\AddOns\MeetingHorn\Media\StbTexture\StbTextureBgBig200:22:72:0:0:256:64:0:146:0:46|t]],
}

local questionMark1 = [[|TInterface\AddOns\MeetingHorn\Media\question_m1:16:16:0:-1:1:1:0:1:0:1|t]]
local questionMark2 = [[|TInterface\AddOns\MeetingHorn\Media\question_m2:18:18:0:-3:1:1:0:1:0:1|t]]

function GoodLeader:Constructor(p)
    ns.UI.CountdownButton:Bind(self.First.Header.Search)

    self.instances = self.Result.Raids.instances

    local function CreateInstance(i)
        local frame = CreateFrame('Frame', nil, self.Result.Raids, 'GoodLeaderRaidTemplate')
        -- local font, size = frame.Count:GetFont()
        -- frame.Count:SetFont(font, size, 'OUTLINE')
        self.instances[i] = frame
        return frame
    end

    local index = 1
    for i, v in ipairs(ns.GOODLEADER_INSTANCES) do
        if v.projectId == WOW_PROJECT_ID then
            local button = self.instances[index] or CreateInstance(index)

            button.Name:SetText(C_Map.GetAreaInfo(v.mapId) .. (v.name and '-' .. v.name or ''))
            if type(v.image) == 'string' then
                button.Image:SetTexture([[interface\encounterjournal\ui-ej-dungeonbutton-]] .. v.image)
            else
                button.Image:SetTexture(v.image)
            end
            button.bossId = v.bossId
            button.difficulties = v.difficulties
            index = index + 1
        end
    end

    self.First.Header.Disconnect:SetText(L['没有查询到该团长数据~'])

    self.ProgressBarFrame = CreateFrame("Frame", "ProgressBarFrame", self.First.Header)
    self.ProgressBarFrame:SetSize(586, 70)
    self.ProgressBarFrame:SetPoint("RIGHT" )

    self.medalList = self.ProgressBarFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    self.medalList:SetPoint("CENTER", -115, 6)

    self.ProgressBarFrame.texture = self.ProgressBarFrame:CreateTexture(nil, "BACKGROUND")
    self.ProgressBarFrame.texture:SetTexture("Interface\\AddOns\\MeetingHorn\\Media\\progressBarBG")
    self.ProgressBarFrame.texture:SetSize(371, 20)
    self.ProgressBarFrame.texture:SetPoint("CENTER",-82, -30)

    self.ProgressBarFrame.statusBar = CreateFrame("StatusBar", nil, self.ProgressBarFrame)
    self.ProgressBarFrame.statusBar:SetSize(369, 12)
    self.ProgressBarFrame.statusBar:SetPoint("CENTER", self.ProgressBarFrame.texture, "CENTER", 2, 4)
    self.ProgressBarFrame.statusBar:SetStatusBarTexture("Interface\\AddOns\\MeetingHorn\\Media\\progressBar")

    local describeText = self.ProgressBarFrame:CreateFontString(nil, "ARTWORK", "GameFontHighlightLeft")
    describeText:SetPoint("LEFT", self.ProgressBarFrame.texture, "LEFT", self.ProgressBarFrame.texture:GetWidth() / 2 + 30, 5)
    describeText:SetFont("Fonts\\ARHei.ttf", 10)
    describeText:SetTextColor(0.905, 0.839, 0.761, 1)
    describeText:SetText(questionMark2.."经验值明细")

    self.ProgressBarFrame:SetScript("OnMouseDown", function(_, button)
        if button == "LeftButton" then
            self:OpenTooltip('点击下方按钮，将会自动进入【星团长官方DD频道】。\n\n您也可以使用网易大神APP扫码下方二维码查看该团长的主页，了解有关TA的更多信息')
        end
    end)

    self.ViewExperienceBtn = CreateFrame("Button", "ViewExperienceBtn", self.First.Header, "UIPanelButtonTemplate")
    self.ViewExperienceBtn:SetSize(230, 40)
    self.ViewExperienceBtn:SetText(questionMark1.."如何获取【额外】开团经验")
    local fontString = self.ViewExperienceBtn:GetFontString()
    fontString:SetFont(fontString:GetFont(), 12)  -- 12是字体大小，根据需要调整
    self.ViewExperienceBtn:SetPoint("CENTER" , 0, -55)
    self.ViewExperienceBtn:Hide()

    self.ViewExperienceBtn:SetScript("OnClick", function(_, button)
        self:OpenVoiceRoom()
    end)

    self.First.Header.Search:SetScript('OnClick', function(button)
        ns.GoodLeader:LookupLeader()
        button:SetCountdown(5)
    end)

    self.First.Footer.Text:SetText(L.TIP_SUMMARY)
    self.First.Footer.Title:SetText(L.TIP_TITLE)

    self.Result.Score.NoResult:SetText(L['团长被评价数量较少，暂时无法查看。'])
    self.Result.Raids.Title:SetText(L['作为团长的次数：|cff808080（暴雪通行证下所有角色）|r'])

    ns.UI.QRCodeWidget:Bind(self.First.Inset.QRCode)

    self.scores = {}

    local function SetupScore(frame, text)
        frame.Text:SetText(text)
        frame.Score:SetReadOnly(true)

        tinsert(self.scores, frame)
    end

    SetupScore(self.Result.Score.Score1, L['指挥：'])
    SetupScore(self.Result.Score.Score2, L['公正：'])
    SetupScore(self.Result.Score.Score3, L['运势：'])

    self.First:SetScript('OnShow', function()
        self.First.Inset.QRCode:SetValue(ns.MakeQRCode(ns.GetGroupLeader()))
    end)

    self.Result.Raids:SetScript('OnSizeChanged', function()
        local spacing = 10
        local parentWidth = self.Result.Raids:GetWidth() - spacing * 2
        local width = parentWidth
        local x = 0
        local y = 0
        local buttonWidth = self.instances[1]:GetWidth()
        local buttonHeight = self.instances[1]:GetHeight()
        local relativeTo = self.Result.Raids.Title

        for i, button in ipairs(self.instances) do
            button:ClearAllPoints()
            button:SetPoint('TOPLEFT', relativeTo, 'BOTTOMLEFT', x * (buttonWidth + spacing),
                            -y * (buttonHeight + spacing) - spacing)
            width = width - buttonWidth - spacing

            if width < buttonWidth then
                width = parentWidth
                x = 0
                y = y + 1
            else
                x = x + 1
            end
        end

        if x == 0 then
            y = y - 1
        end

        self.Result.Raids:SetHeight((y + 1) * (buttonHeight + spacing) + 60)
    end)

    ns.ApplyImageButton(self.First.Header.ApplyLeaderBtn, {
        text = '申请星团长',
        summary = '大神扫码 了解星团长',
        texture = [[Interface/AddOns/MeetingHorn/Media/ApplyLeaderQR]],
        points = {'BOTTOMLEFT', self.First.Header.ApplyLeaderBtn, 'BOTTOMRIGHT', 5, -25},
    })
    self.First.Header.Search:Hide()

    self.First:Show()
    self.Result:Hide()

    self:SetScript('OnShow', self.OnShow)
    self:RegisterEvent('GROUP_ROSTER_UPDATE')
    self:RegisterMessage('GOODLEADER_LOGIN')
    self:RegisterMessage('GOODLEADER_LEADERINFO_UPDATE')
    self:RegisterMessage('GOODLEADER_CONNECT_TIMEOUT')
end

function GoodLeader:OnShow()
    self:UpdateLeader()
    ns.LogStatistics:InsertLog({time(), 2})
end

function GoodLeader:UpdateLeader()
    local name = ns.GetGroupLeader()
    local playerName = name:match("^(.-)-") or name
    local regimentData = ns.Addon.db.realm.starRegiment.regimentData[playerName]
    self.First.Inset.QRCode:Refresh()
    if regimentData == nil or regimentData.medalMap == nil or regimentData.level == -1 or regimentData.medalMap.acc_exp == nil then
        self.ProgressBarFrame:Hide()
        self.ViewExperienceBtn:Hide()
        self.First.Header.Disconnect:Show()
        self.First.Header.ApplyLeaderBtn:Show()
        self.First.Header.Name:SetFormattedText(L['团长ID：%s'], playerName)
    else
        self.ProgressBarFrame:Show()
        self.ViewExperienceBtn:Show()
        self.First.Header.Disconnect:Hide()
        self.First.Header.ApplyLeaderBtn:Hide()
        local level = regimentData.level
        self.First.Header.Name:SetFormattedText(L['团长ID：%s '] .. miniCertificationTextures[level], playerName)

        local info = regimentData.medalMap
        local accExp = info.acc_exp
        local nextStarLevelThreshold = info.next_star_level_threshold
        self.ProgressBarFrame.statusBar:SetMinMaxValues(0, accExp + nextStarLevelThreshold)
        self.ProgressBarFrame.statusBar:SetValue(accExp)

        local medalTexture = ''
        local medalList = ns.LFG:GetMedalList(playerName)
        if medalList then
            for _, medal in ipairs(medalList) do
                local texture = medalTextures[medal]
                if texture then
                    medalTexture = medalTexture .. texture
                end
            end
        end
        self.medalList:SetText(medalTexture)

    end
end

function GoodLeader:GROUP_ROSTER_UPDATE()
    self:UpdateLeader()
end

function GoodLeader:GOODLEADER_LOGIN()
    self:UpdateLeader()
end

function GoodLeader:GOODLEADER_CONNECT_TIMEOUT()
    self:UpdateLeader()
end

function GoodLeader:GOODLEADER_LEADERINFO_UPDATE()
    local name, guid = ns.GetGroupLeader()
    local user = ns.GoodLeader:GetUserCache(guid)

    self.name = name

    local raids = user.raids
    if not raids then
        return
    end

    for _, button in ipairs(self.instances) do
        if button then
            -- button.Count:SetText(raids and raids[button.bossId] or 0)
            local bossData = raids[button.bossId]
            local sb = {}

            for _, difficulty in ipairs(button.difficulties) do
                local count = bossData and bossData[difficulty] or 0

                if count > 0 then
                    count = format('|cffffd100%d|r', count)
                end

                table.insert(sb, format('%s: %s次', GetDifficultyInfo(difficulty), count))
            end

            button.Count:SetText(table.concat(sb, '\n'))
        end
    end

    -- if not user.itemPercent then
    --     self.Result.Info.ItemLevel:SetFormattedText(
    --         L['|cff808080物品等级：|r当前团长未安装星团长插件，需要自行查看。'])
    -- else
    --     self.Result.Info.ItemLevel:SetFormattedText(
    --         L['|cff808080物品等级：|r当前团长的装备超过|cffffd100%s%%|r的玩家。'], user.itemPercent)
    -- end

    if user.guild then
        self.Result.Info.Guild:SetFormattedText(
            L['|cff808080公会成员：|r当前团队有|cffffd100%s|r名成员与团长相同公会，公会名：|cffffd100%s|r。'],
            user.guildCount, user.guild)
    else
        self.Result.Info.Guild:SetFormattedText(
            L['|cff808080公会成员：|r团长距离过远，无法获得公会信息，建议进入团队后查看。'])
    end

    -- self.Result.Name:SetFormattedText(L['团长ID：%s'], name)
    self.Result.Tags:SetText(user.tags and table.concat(user.tags, ',') or '')

    for i, frame in ipairs(self.scores) do
        self:UpdateScore(frame, user.scores and user.scores[i])
    end

    self.Result.Score.NoResult:SetShown(not user.scores)

    self.Result:Show()
    self.First:Hide()
end

function GoodLeader:UpdateScore(frame, score)
    if score then
        frame.Score:SetValue(score)
        frame:Show()
    else
        frame:Hide()
    end
end

function GoodLeader:OpenTooltip(text)
    local name = ns.GetGroupLeader()
    local playerName = name:match("^(.-)-") or name
    if not self.QRTooltip then
        self.QRTooltip = CreateFrame('Frame', nil, self, 'MeetingHornActivityTooltipTemplate')
        self.QRTooltip:SetSize(240, 340)
        self.QRTooltip:SetPoint('TOPLEFT', self, 'TOPRIGHT', 0, 0)
        self.QRTooltip.Text:ClearAllPoints()
        self.QRTooltip.Text:SetPoint('TOPLEFT', self.QRTooltip, "TOPLEFT", 8, -30)
        self.QRTooltip.Text:SetPoint('TOPRIGHT', self.QRTooltip, "BOTTOMRIGHT", -8, 8)
        self.QRTooltip.QRCode:ClearAllPoints()
        self.QRTooltip.QRCode:SetPoint('BOTTOM', self.QRTooltip, "BOTTOM", 0, 30)
        ns.UI.QRCodeWidget:Bind(self.QRTooltip.QRCode)
    end
    self.QRTooltip.Text:SetText(text)
    self.QRTooltip.QRCode:SetValue(ns.MakeQRCode(playerName))
    self.QRTooltip:Show()
end

function GoodLeader:OpenVoiceRoom()
    local currentRoomID = 291978
    local sendData = { roomID = currentRoomID }
    ns.ThreeDimensionsCode:sendCommand('joinRoom', ns.TableToJson(sendData))
    ns.isOpenVoiceRoom = false
    self:OpenTooltip('如果您已安装网易DD客户端，将会自动进入【星团长官方DD频道】。请稍等片刻…\n\n您也可以使用网易大神APP扫码下方二维码查看该团长的主页，了解有关TA的更多信息')

    local  data = ns.NetEaseBase64:EnCode(format('%s+%d', UnitGUID("player"), GetRealmID()))
    ns.LogStatistics:InsertLog({time(), 7, 1, data})

    C_Timer.After(3, function(...)
        if ns.isOpenVoiceRoom then
            return
        end
        ns.ThreeDimensionsCode:sendCommand('joinRoom', '-1')
        ns.LogStatistics:InsertLog({time(), 7, 2, data})
        ns.OpenUrlDialog(format('https://dd.163.com/i/v9Xv5LFROd/?utm_source=jjh&utm_term=%s', data), '复制并访问以下链接，即可快速进入【星团长官方DD频道】了解如何获取更多【额外】开团经验')
    end)
end

