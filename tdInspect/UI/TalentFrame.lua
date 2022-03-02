---@type ns
local ns = select(2, ...)

local min = min
local max = max
local huge = math.huge
local rshift = bit.rshift
local ripairs = ripairs or ipairs_reverse

---@class UI.TalentFrame: Object, ScrollFrame, AceEvent-3.0
local TalentFrame = ns.Addon:NewClass('UI.TalentFrame', 'ScrollFrame')

local MAX_TALENT_TABS = 3
local MAX_NUM_TALENT_TIERS = 10
local NUM_TALENT_COLUMNS = 4
local MAX_NUM_TALENTS = 40
local PLAYER_TALENTS_PER_TIER = 5

local TALENT_BUTTON_SIZE_DEFAULT = 32
local INITIAL_TALENT_OFFSET_X_DEFAULT = 35
local INITIAL_TALENT_OFFSET_Y_DEFAULT = 20
local TALENT_GOLD_BORDER_WIDTH = 5

local TALENT_BRANCH_TEXTURECOORDS = {
    up = {[1] = {0.12890625, 0.25390625, 0, 0.484375}, [-1] = {0.12890625, 0.25390625, 0.515625, 1.0}},
    down = {[1] = {0, 0.125, 0, 0.484375}, [-1] = {0, 0.125, 0.515625, 1.0}},
    left = {[1] = {0.2578125, 0.3828125, 0, 0.5}, [-1] = {0.2578125, 0.3828125, 0.5, 1.0}},
    right = {[1] = {0.2578125, 0.3828125, 0, 0.5}, [-1] = {0.2578125, 0.3828125, 0.5, 1.0}},
    topright = {[1] = {0.515625, 0.640625, 0, 0.5}, [-1] = {0.515625, 0.640625, 0.5, 1.0}},
    topleft = {[1] = {0.640625, 0.515625, 0, 0.5}, [-1] = {0.640625, 0.515625, 0.5, 1.0}},
    bottomright = {[1] = {0.38671875, 0.51171875, 0, 0.5}, [-1] = {0.38671875, 0.51171875, 0.5, 1.0}},
    bottomleft = {[1] = {0.51171875, 0.38671875, 0, 0.5}, [-1] = {0.51171875, 0.38671875, 0.5, 1.0}},
    tdown = {[1] = {0.64453125, 0.76953125, 0, 0.5}, [-1] = {0.64453125, 0.76953125, 0.5, 1.0}},
    tup = {[1] = {0.7734375, 0.8984375, 0, 0.5}, [-1] = {0.7734375, 0.8984375, 0.5, 1.0}},
}

local TALENT_ARROW_TEXTURECOORDS = {
    top = {[1] = {0, 0.5, 0, 0.5}, [-1] = {0, 0.5, 0.5, 1.0}},
    right = {[1] = {1.0, 0.5, 0, 0.5}, [-1] = {1.0, 0.5, 0.5, 1.0}},
    left = {[1] = {0.5, 1.0, 0, 0.5}, [-1] = {0.5, 1.0, 0.5, 1.0}},
}

local GameTooltip = LibStub('LibTooltipExtra-1.0').GameTooltip

function TalentFrame:Constructor()
    self.tabIndex = 1

    self.branches = {}
    self.buttons = {}
    self.brancheTextures = {}
    self.arrowTextures = {}

    self.talentButtonSize = 37
    self.initialOffsetX = 0
    self.initialOffsetY = 0
    self.buttonSpacingX = 52
    self.buttonSpacingY = 48
    self.arrowInsetX = 2
    self.arrowInsetY = -2

    local TopLeft = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    TopLeft:SetPoint('TOPLEFT')

    local TopRight = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    TopRight:SetPoint('TOPLEFT', TopLeft, 'TOPRIGHT')
    TopRight:SetTexCoord(0, 44 / 64, 0, 1)

    local BottomLeft = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    BottomLeft:SetPoint('TOPLEFT', TopLeft, 'BOTTOMLEFT')
    BottomLeft:SetTexCoord(0, 1, 0, 74 / 128)

    local BottomRight = self:CreateTexture(nil, 'BACKGROUND', nil, 1)
    BottomRight:SetPoint('TOPLEFT', TopLeft, 'BOTTOMRIGHT')
    BottomRight:SetTexCoord(0, 44 / 64, 0, 74 / 128)

    local ScrollChild = CreateFrame('Frame', nil, self)
    ScrollChild:SetPoint('TOPLEFT')
    ScrollChild:SetSize(1, 1)
    self:SetScrollChild(ScrollChild)
    self.ScrollChild = ScrollChild

    local t = self:CreateTexture(nil, 'OVERLAY')
    t:SetSize(31, 256)
    t:SetPoint('TOPLEFT', self, 'TOPRIGHT', -2, 5)
    t:SetTexture([[Interface\PaperDollInfoFrame\UI-Character-ScrollBar]])
    t:SetTexCoord(0, 0.484375, 0, 1)

    t = self:CreateTexture(nil, 'OVERLAY')
    t:SetSize(31, 106)
    t:SetPoint('BOTTOMLEFT', self, 'BOTTOMRIGHT', -2, -2)
    t:SetTexture([[Interface\PaperDollInfoFrame\UI-Character-ScrollBar]])
    t:SetTexCoord(0.515625, 1, 0, 0.4140625)

    local ArrowParent = CreateFrame('Frame', nil, self.ScrollChild)
    ArrowParent:SetAllPoints(true)
    ArrowParent:SetFrameLevel(self:GetFrameLevel() + 100)

    self.TopLeft = TopLeft
    self.TopRight = TopRight
    self.BottomLeft = BottomLeft
    self.BottomRight = BottomRight
    self.ArrowParent = ArrowParent

    self:SetScript('OnSizeChanged', self.OnSizeChanged)

    for i = 1, MAX_NUM_TALENT_TIERS do
        self.branches[i] = {}
        for j = 1, NUM_TALENT_COLUMNS do
            self.branches[i][j] = {
                id = nil,
                up = 0,
                left = 0,
                right = 0,
                down = 0,
                leftArrow = 0,
                rightArrow = 0,
                topArrow = 0,
            }
        end
    end
end

local function TalentOnEnter(button)
    button:GetParent():GetParent():ShowTooltip(button)
end

local function TalentOnClick(button)
    if button.link then
        HandleModifiedItemClick(button.link)
    end
end

local function AddLine(line, r, g, b)
    GameTooltip:AddLine(line, r or 1, g or 1, b or 1)
end

local function AddSpellSummary(spellId)
    GameTooltip:AddLine(GetSpellDescription(spellId), 1, 0.82, 0, true)
end

function TalentFrame:OnSizeChanged(width, height)
    self.TopLeft:SetSize(width * 256 / 300, height * 256 / 330)
    self.TopRight:SetSize(width * 44 / 300, height * 256 / 330)
    self.BottomLeft:SetSize(width * 256 / 300, height * 74 / 330)
    self.BottomRight:SetSize(width * 44 / 300, height * 74 / 330)
end

local TOOLTIP_TALENT_RANK = HIGHLIGHT_FONT_COLOR:WrapTextInColorCode(TOOLTIP_TALENT_RANK)
local TOOLTIP_TALENT_PREREQ = RED_FONT_COLOR:WrapTextInColorCode(TOOLTIP_TALENT_PREREQ)
local TOOLTIP_TALENT_TIER_POINTS = RED_FONT_COLOR:WrapTextInColorCode(TOOLTIP_TALENT_TIER_POINTS)

function TalentFrame:ShowTooltip(button)
    local id = button:GetID()
    local name, _, row, _, rank, maxRank = self.talent:GetTalentInfo(self.tabIndex, id)
    local spellId = self.talent:GetTalentRankSpell(self.tabIndex, id, rank)

    GameTooltip:SetOwner(button, 'ANCHOR_RIGHT')

    local lines = {}
    local prereqs = self.talent:GetTalentPrereqs(self.tabIndex, id)
    if prereqs then
        for _, req in ipairs(prereqs) do
            local reqName, _, _, _, rank, reqMaxRank = self.talent:GetTalentInfo(self.tabIndex, req.reqIndex)
            if reqName and rank < reqMaxRank then
                tinsert(lines, format(TOOLTIP_TALENT_PREREQ, reqMaxRank, reqName))
            end
        end
    end

    if rank == 0 and row > 1 then
        local tabName = self.talent:GetTabInfo(self.tabIndex)
        tinsert(lines, format(TOOLTIP_TALENT_TIER_POINTS, (row - 1) * 5, tabName))
    end

    if not IsPassiveSpell(spellId) then
        GameTooltip:SetSpellByID(spellId)

        for _, line in ripairs(lines) do
            GameTooltip:AppendLineFront(2, line)
        end

        GameTooltip:AppendLineFront(2, TOOLTIP_TALENT_RANK:format(rank, maxRank))
    else
        AddLine(name)
        AddLine(TOOLTIP_TALENT_RANK:format(rank, maxRank))

        for _, req in ipairs(lines) do
            AddLine(req, RED_FONT_COLOR:GetRGB())
        end

        AddSpellSummary(spellId)

        if rank > 0 and rank < maxRank then
            AddLine(' ')
            AddLine(TOOLTIP_TALENT_NEXT_RANK)
            AddSpellSummary(self.talent:GetTalentRankSpell(self.tabIndex, id, rank + 1))
        end
    end

    GameTooltip:Show()
end

function TalentFrame:GetTalentButton(i)
    if not self.buttons[i] then
        local button = CreateFrame('Button', nil, self.ScrollChild, 'ItemButtonTemplate')
        button:SetSize(self.talentButtonSize, self.talentButtonSize)
        button:SetID(i)
        button:SetScript('OnEnter', TalentOnEnter)
        button:SetScript('OnLeave', GameTooltip_Hide)
        button:SetScript('OnClick', TalentOnClick)

        local Slot = button:CreateTexture(nil, 'BACKGROUND')
        Slot:SetSize(64, 64)
        Slot:SetPoint('CENTER', 0, -1)
        Slot:SetTexture([[Interface\Buttons\UI-EmptySlot-White]])

        local RankBorder = button:CreateTexture(nil, 'OVERLAY')
        RankBorder:SetSize(32, 32)
        RankBorder:SetPoint('CENTER', button, 'BOTTOMRIGHT')
        RankBorder:SetTexture([[Interface\TalentFrame\TalentFrame-RankBorder]])

        local Rank = button:CreateFontString(nil, 'OVERLAY', 'GameFontNormalSmall')
        Rank:SetPoint('CENTER', RankBorder, 'CENTER')

        button.Slot = Slot
        button.RankBorder = RankBorder
        button.Rank = Rank
        button.UpdateTooltip = TalentOnEnter

        self.buttons[i] = button
    end
    return self.buttons[i]
end

function TalentFrame:Refresh()
    self:SetScript('OnUpdate', self.OnUpdate)
end

function TalentFrame:OnUpdate()
    self:SetScript('OnUpdate', nil)
    self:Update()
end

function TalentFrame:Update()
    if not self.talent then
        return
    end

    local talentButtonSize = self.talentButtonSize or TALENT_BUTTON_SIZE_DEFAULT
    local initialOffsetX = self.initialOffsetX or INITIAL_TALENT_OFFSET_X_DEFAULT
    local initialOffsetY = self.initialOffsetY or INITIAL_TALENT_OFFSET_Y_DEFAULT
    local buttonSpacingX = self.buttonSpacingX or (2 * talentButtonSize - 1)
    local buttonSpacingY = self.buttonSpacingY or (2 * talentButtonSize - 1)

    -- Setup Frame
    local base
    local isUnlocked = true
    local name, background, pointsSpent = self.talent:GetTabInfo(self.tabIndex)
    if name then
        base = 'Interface\\TalentFrame\\' .. background .. '-'
    else
        -- temporary default for classes without talents poor guys
        base = 'Interface\\TalentFrame\\MageFire-'
    end

    self.TopLeft:SetTexture(base .. 'TopLeft')
    self.TopRight:SetTexture(base .. 'TopRight')
    self.BottomLeft:SetTexture(base .. 'BottomLeft')
    self.BottomRight:SetTexture(base .. 'BottomRight')

    local numTalents = self.talent:GetNumTalents(self.tabIndex)
    -- Just a reminder error if there are more talents than available buttons
    if numTalents > MAX_NUM_TALENTS then
        message('Too many talents in talent frame!')
    end

    -- get unspent talent points
    local unspentPoints = self:GetUnspentTalentPoints()

    self:ResetBranches()
    local forceDesaturated, tierUnlocked
    for i = 1, MAX_NUM_TALENTS do
        local button = self:GetTalentButton(i)
        if i <= numTalents then
            -- Set the button info
            local name, iconTexture, tier, column, rank, maxRank = self.talent:GetTalentInfo(self.tabIndex, i)
            if name and tier <= MAX_NUM_TALENT_TIERS then
                button.link = self.talent:GetTalentLink(self.tabIndex, i)
                button.Rank:SetText(rank)
                self:SetButtonLocation(button, tier, column, talentButtonSize, initialOffsetX, initialOffsetY,
                                       buttonSpacingX, buttonSpacingY)
                self.branches[tier][column].id = button:GetID()

                -- If player has no talent points or this is the inactive talent group then show only talents with points in them
                if unspentPoints <= 0 and rank == 0 then
                    forceDesaturated = 1
                else
                    forceDesaturated = nil
                end

                -- is this talent's tier unlocked?
                if isUnlocked and (tier - 1) * PLAYER_TALENTS_PER_TIER <= pointsSpent then
                    tierUnlocked = 1
                else
                    tierUnlocked = nil
                end

                SetItemButtonTexture(button, iconTexture)

                local prereqsSet = self:SetPrereqs(tier, column, forceDesaturated, tierUnlocked,
                                                   self.talent:GetTalentPrereqs(self.tabIndex, i))
                if prereqsSet then
                    SetItemButtonDesaturated(button, nil)
                    button.RankBorder:Show()
                    button.RankBorder:SetVertexColor(1, 1, 1)
                    button.Rank:Show()

                    if rank < maxRank then
                        -- Rank is green if not maxed out
                        button.Rank:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b)
                        button.Slot:SetVertexColor(0.1, 1.0, 0.1)
                    else
                        button.Slot:SetVertexColor(1.0, 0.82, 0)
                        button.Rank:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b)
                    end
                else
                    SetItemButtonDesaturated(button, 1)
                    button.Slot:SetVertexColor(0.5, 0.5, 0.5)
                    if rank == 0 then
                        button.RankBorder:Hide()
                        button.Rank:Hide()
                    else
                        button.RankBorder:SetVertexColor(0.5, 0.5, 0.5)
                        button.Rank:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b)
                        button.RankBorder:Show()
                        button.Rank:Show()
                    end
                end

                button:Show()
            else
                button:Hide()
            end
        else
            if button then
                button:Hide()
            end
        end
    end

    -- Draw the prereq branches
    local node
    local textureIndex = 1
    local xOffset, yOffset
    local texCoords
    local tempNode
    self:ResetBranchTextureCount()
    self:ResetArrowTextureCount()
    for i = 1, MAX_NUM_TALENT_TIERS do
        for j = 1, NUM_TALENT_COLUMNS do
            node = self.branches[i][j]

            -- Setup offsets
            xOffset = ((j - 1) * buttonSpacingX) + initialOffsetX + (self.branchOffsetX or 0)
            yOffset = -((i - 1) * buttonSpacingY) - initialOffsetY + (self.branchOffsetY or 0)

            -- Always draw Right and Down branches, never draw Left and Up branches as those will be drawn by the preceeding talent
            if node.down ~= 0 then
                self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['down'][node.down], xOffset,
                                      yOffset - talentButtonSize, talentButtonSize, buttonSpacingY - talentButtonSize)
            end
            if node.right ~= 0 then
                self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['right'][node.right],
                                      xOffset + talentButtonSize, yOffset, buttonSpacingX - talentButtonSize,
                                      talentButtonSize)
            end

            if node.id then
                -- There is a talent in this slot; draw arrows
                local arrowInsetX, arrowInsetY = (self.arrowInsetX or 0), (self.arrowInsetY or 0)

                if node.rightArrow ~= 0 then
                    self:SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS['right'][node.rightArrow],
                                         xOffset + talentButtonSize / 2 - arrowInsetX, yOffset)
                end
                if node.leftArrow ~= 0 then
                    self:SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS['left'][node.leftArrow],
                                         xOffset - talentButtonSize / 2 + arrowInsetX, yOffset)
                end
                if node.topArrow ~= 0 then
                    self:SetArrowTexture(i, j, TALENT_ARROW_TEXTURECOORDS['top'][node.topArrow], xOffset,
                                         yOffset + talentButtonSize / 2 - arrowInsetY)
                end
            else
                -- No talent; draw branches
                if node.up ~= 0 and node.left ~= 0 and node.right ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['tup'][node.up], xOffset, yOffset)
                elseif node.down ~= 0 and node.left ~= 0 and node.right ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['tdown'][node.down], xOffset, yOffset)
                elseif node.left ~= 0 and node.down ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['topright'][node.left], xOffset, yOffset)
                elseif node.left ~= 0 and node.up ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['bottomright'][node.left], xOffset, yOffset)
                elseif node.left ~= 0 and node.right ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['right'][node.right],
                                          xOffset + talentButtonSize, yOffset)
                elseif node.right ~= 0 and node.down ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['topleft'][node.right], xOffset, yOffset)
                elseif node.right ~= 0 and node.up ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['bottomleft'][node.right], xOffset, yOffset)
                elseif node.up ~= 0 and node.down ~= 0 then
                    self:SetBranchTexture(i, j, TALENT_BRANCH_TEXTURECOORDS['up'][node.up], xOffset, yOffset)
                end
            end
        end
    end

    -- Hide any unused branch textures
    for i = self:GetBranchTextureCount(), #self.brancheTextures do
        self.brancheTextures[i]:Hide()
    end
    -- Hide and unused arrowl textures
    for i = self:GetArrowTextureCount(), #self.arrowTextures do
        self.arrowTextures[i]:Hide()
    end
end

function TalentFrame:SetArrowTexture(tier, column, texCoords, xOffset, yOffset)
    local arrowTexture = self:GetArrowTexture()
    arrowTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4])
    arrowTexture:SetPoint('TOPLEFT', arrowTexture:GetParent(), 'TOPLEFT', xOffset, yOffset)
end

function TalentFrame:SetBranchTexture(tier, column, texCoords, xOffset, yOffset, xSize, ySize)
    local branchTexture = self:GetBranchTexture()
    branchTexture:SetTexCoord(texCoords[1], texCoords[2], texCoords[3], texCoords[4])
    branchTexture:SetPoint('TOPLEFT', branchTexture:GetParent(), 'TOPLEFT', xOffset, yOffset)
    branchTexture:SetWidth(xSize or self.talentButtonSize or TALENT_BUTTON_SIZE_DEFAULT)
    branchTexture:SetHeight(ySize or self.talentButtonSize or TALENT_BUTTON_SIZE_DEFAULT)
end

function TalentFrame:GetArrowTexture()
    local texture = self.arrowTextures[self.arrowIndex]
    if not texture then
        texture = self.ArrowParent:CreateTexture(nil, 'BACKGROUND')
        texture:SetSize(37, 37)
        texture:SetTexture([[Interface\TalentFrame\UI-TalentArrows]])
        self.arrowTextures[self.arrowIndex] = texture
    end
    self.arrowIndex = self.arrowIndex + 1
    texture:Show()
    return texture
end

function TalentFrame:GetBranchTexture()
    local texture = self.brancheTextures[self.textureIndex]
    if not texture then
        texture = self.ScrollChild:CreateTexture(nil, 'ARTWORK')
        texture:SetSize(30, 30)
        texture:SetTexture([[Interface\TalentFrame\UI-TalentBranches]])
        self.brancheTextures[self.textureIndex] = texture
    end
    self.textureIndex = self.textureIndex + 1
    texture:Show()
    return texture
end

function TalentFrame:ResetArrowTextureCount()
    self.arrowIndex = 1
end

function TalentFrame:ResetBranchTextureCount()
    self.textureIndex = 1
end

function TalentFrame:GetArrowTextureCount()
    return self.arrowIndex
end

function TalentFrame:GetBranchTextureCount()
    return self.textureIndex
end

---@param prereqs tdInspectTalentPrereqs[]
function TalentFrame:SetPrereqs(buttonTier, buttonColumn, forceDesaturated, tierUnlocked, prereqs)
    local requirementsMet = tierUnlocked and not forceDesaturated

    if prereqs then
        for i, v in ipairs(prereqs) do
            local tier, column = v.row, v.column
            if forceDesaturated then
                requirementsMet = nil
            end
            self:DrawLines(buttonTier, buttonColumn, tier, column, requirementsMet)
        end
    end
    return requirementsMet
end

function TalentFrame:DrawLines(buttonTier, buttonColumn, tier, column, requirementsMet)
    if requirementsMet then
        requirementsMet = 1
    else
        requirementsMet = -1
    end

    -- Check to see if are in the same column
    if buttonColumn == column then
        -- Check for blocking talents
        if buttonTier - tier > 1 then
            -- If more than one tier difference
            for i = tier + 1, buttonTier - 1 do
                if self.branches[i][buttonColumn].id then
                    -- If there's an id, there's a blocker
                    message('Error this layout is blocked vertically ' .. self.branches[buttonTier][i].id)
                    return
                end
            end
        end

        -- Draw the lines
        for i = tier, buttonTier - 1 do
            self.branches[i][buttonColumn].down = requirementsMet
            if i + 1 <= buttonTier - 1 then
                self.branches[i + 1][buttonColumn].up = requirementsMet
            end
        end

        -- Set the arrow
        self.branches[buttonTier][buttonColumn].topArrow = requirementsMet
        return
    end
    -- Check to see if they're in the same tier
    if buttonTier == tier then
        local left = min(buttonColumn, column)
        local right = max(buttonColumn, column)

        -- See if the distance is greater than one space
        if right - left > 1 then
            -- Check for blocking talents
            for i = left + 1, right - 1 do
                if self.branches[tier][i].id then
                    -- If there's an id, there's a blocker
                    message('there\'s a blocker ' .. tier .. ' ' .. i)
                    return
                end
            end
        end
        -- If we get here then we're in the clear
        for i = left, right - 1 do
            self.branches[tier][i].right = requirementsMet
            self.branches[tier][i + 1].left = requirementsMet
        end
        -- Determine where the arrow goes
        if buttonColumn < column then
            self.branches[buttonTier][buttonColumn].rightArrow = requirementsMet
        else
            self.branches[buttonTier][buttonColumn].leftArrow = requirementsMet
        end
        return
    end
    -- Now we know the prereq is diagonal from us
    local left = min(buttonColumn, column)
    local right = max(buttonColumn, column)
    -- Don't check the location of the current button
    if left == column then
        left = left + 1
    else
        right = right - 1
    end
    -- Check for blocking talents
    local blocked = nil
    for i = left, right do
        if self.branches[tier][i].id then
            -- If there's an id, there's a blocker
            blocked = 1
        end
    end
    left = min(buttonColumn, column)
    right = max(buttonColumn, column)
    if not blocked then
        self.branches[tier][buttonColumn].down = requirementsMet
        self.branches[buttonTier][buttonColumn].up = requirementsMet

        for i = tier, buttonTier - 1 do
            self.branches[i][buttonColumn].down = requirementsMet
            self.branches[i + 1][buttonColumn].up = requirementsMet
        end

        for i = left, right - 1 do
            self.branches[tier][i].right = requirementsMet
            self.branches[tier][i + 1].left = requirementsMet
        end
        -- Place the arrow
        self.branches[buttonTier][buttonColumn].topArrow = requirementsMet
        return
    end
    -- If we're here then we were blocked trying to go vertically first so we have to go over first, then up
    if left == buttonColumn then
        left = left + 1
    else
        right = right - 1
    end
    -- Check for blocking talents
    for i = left, right do
        if self.branches[buttonTier][i].id then
            -- If there's an id, then throw an error
            message('Error, this layout is undrawable ' .. self.branches[buttonTier][i].id)
            return
        end
    end
    -- If we're here we can draw the line
    left = min(buttonColumn, column)
    right = max(buttonColumn, column)
    -- TALENT_BRANCH_ARRAY[tier][column].down = requirementsMet;
    -- TALENT_BRANCH_ARRAY[buttonTier][column].up = requirementsMet;

    for i = tier, buttonTier - 1 do
        self.branches[i][column].up = requirementsMet
        self.branches[i + 1][column].down = requirementsMet
    end

    -- Determine where the arrow goes
    if buttonColumn < column then
        self.branches[buttonTier][buttonColumn].rightArrow = requirementsMet
    else
        self.branches[buttonTier][buttonColumn].leftArrow = requirementsMet
    end
end

-- Helper functions

function TalentFrame:GetUnspentTalentPoints()
    -- local talentPoints = GetUnspentTalentPoints(self.inspect, self.pet, self.talentGroup)
    -- local unspentPoints = talentPoints - GetGroupPreviewTalentPointsSpent(self.pet, self.talentGroup)
    -- return unspentPoints
    -- TODO:
    return 0
end

function TalentFrame:SetButtonLocation(button, tier, column, talentButtonSize, initialOffsetX, initialOffsetY,
                                       buttonSpacingX, buttonSpacingY)
    column = (column - 1) * buttonSpacingX + initialOffsetX
    tier = -(tier - 1) * buttonSpacingY - initialOffsetY
    button:SetPoint('TOPLEFT', button:GetParent(), 'TOPLEFT', column, tier)
end

function TalentFrame:ResetBranches()
    local node
    for i = 1, MAX_NUM_TALENT_TIERS do
        for j = 1, NUM_TALENT_COLUMNS do
            node = self.branches[i][j]
            node.id = nil
            node.up = 0
            node.down = 0
            node.left = 0
            node.right = 0
            node.rightArrow = 0
            node.leftArrow = 0
            node.topArrow = 0
        end
    end
end

function TalentFrame:SetTalentTab(tabIndex)
    self.tabIndex = tabIndex
    self:Refresh()
end

function TalentFrame:SetTalent(talent)
    self.talent = talent
    self:Refresh()
end
