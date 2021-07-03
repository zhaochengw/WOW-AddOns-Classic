-------------------------------------------------------
-- Name: SkillDetailFrame							 --
-- Description: Shows the detail of a selected skill --
-- Parent Frame: MissingTradeSkillsListFrame		 --
-------------------------------------------------------

MTSLUI_SKILL_DETAIL_FRAME = {
    ui_frame,
    -- array holding all labels shown on this panel, for easy acces later
    labels = {
        name = {},
        expansion = {},
        min_skill = {},
        requires_xp = {},
        requires_rep = {},
        requires_spec = {},
        holiday = {},
        special_action = {},
        price = {},
        type = {},
        source = {},
        sources = {},
        alt_type ={},
        alt_source = {},
        alt_sources = {},
    },
    sources = {
        main = {
            npcs = {},
            objects = {},
            items = {},
        },
        alt = {
            npcs = {},
            objects = {},
            items = {},
        },
    },
    -- width of the frame
    FRAME_WIDTH = 515,
    -- height of the frame
    FRAME_HEIGHT = 440,
    -- height of the primary sources frame
    FRAME_SOURCES_HEIGHT = 260,
    FRAME_SOURCES_HEIGHT_WITH_SECONDARY = 140,
    -- shows up to 17 sources
    MAX_SOURCES_SHOWN_PRIMARY = 16,
    -- height of the frame with alternative source
    FRAME_ALT_SOURCES_HEIGHT = 105,
    -- shows up to 7 alternative sources
    MAX_SOURCES_SHOWN_SECONDARY = 6,
    -- save the texts for the tooltips
    tooltip_skill_name,
    tooltip_source_name,
    tooltip_alt_source_name,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises the DetailsSelectedSkillFrame
    --
    -- @parent_frame		Frame		The parent frame
    ----------------------------------------------------------------------------------------------------------
    Initialise = function (self, parent_frame, frame_name)
        -- make local copy of this instance to hook the events too
        local event_class = self
        -- create the frame
        self.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", frame_name, parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT, true)
        -- TBC fix for backdrops
        Mixin(self.ui_frame, BackdropTemplateMixin)
        --  Black background
        self.ui_frame:SetBackdropColor(0,0,0,1)
        -- Add the Texts/Strings to the frame
        local text_label_left = 10
        local text_label_right = 130
        local text_label_top = -8
        local text_gap = 16
        -- Labels to show "name: <name>"
        self.labels.name.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("name"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.name.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        -- create a frame to hover over and show the tooltip
        self.labels.name.tooltip_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", self.ui_frame, nil, 300, text_gap + 5, false)
        self.labels.name.tooltip_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", text_label_right - 5, -2)
        self.labels.name.tooltip_frame:SetScript("OnEnter", function() event_class:ToolTipShowSkillName() end)
        self.labels.name.tooltip_frame:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
        text_label_top = text_label_top - text_gap
        -- Labels to show "Expansion: <expansion> (<phase>: <name phase>)"
        self.labels.expansion.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("expansion"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.expansion.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Required skill: <min skill>"
        self.labels.min_skill.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("needs skill level"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.min_skill.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Required XP level: <xp level>"
        self.labels.requires_xp.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("needs XP level"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.requires_xp.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Required reputation: <reputation>"
        self.labels.requires_rep.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("needs reputation"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.requires_rep.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Required reputation: <reputation>"
        self.labels.requires_spec.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("needs specialisation"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.requires_spec.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Holiday <holiday>"
        self.labels.holiday.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("holiday"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.holiday.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Special action <special action>"
        self.labels.special_action.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("special action"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.special_action.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Price: <price>"
        self.labels.price.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("price"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.price.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Learned from: <type>"
        self.labels.type.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("learned from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.type.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        -- create a frame to hover over and show the tooltip
        self.labels.type.tooltip_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", self.ui_frame, nil, 300, text_gap + 5, false)
        self.labels.type.tooltip_frame_point_x = text_label_right - 5
        self.labels.type.tooltip_frame_point_y = text_label_top + 5
        self.labels.type.tooltip_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.labels.type.tooltip_frame_point_x, self.labels.type.tooltip_frame_point_y)
        self.labels.type.tooltip_frame:SetScript("OnMouseUp", function(self, button)
            -- Left mouse button
            if button == "LeftButton" then
                event_class:LinkItemToChat(IsAltKeyDown(), IsControlKeyDown(), IsShiftKeyDown())
            -- Right mouse button, so insert
            else
                event_class:InsertItemToChat()
            end
        end)
        self.labels.type.tooltip_frame:SetScript("OnEnter", function() event_class:ToolTipShowSourceName() end)
        self.labels.type.tooltip_frame:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
        text_label_top = text_label_top - text_gap
        self.labels.source.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("obtained from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.source.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Trained by: <trainers> or Sold by: <vendors> or Dropped by: <mobs> or Obtained from: <quest>"
        self.labels.sources.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("learned from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.sources.title:Hide()
        -- Create a frame to hold the labels
        self.labels.sources.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", self.ui_frame, nil, self.FRAME_WIDTH - 120, self.FRAME_SOURCES_HEIGHT, false)
        -- position under MissingSkillsListui_frameand above ProgressBar
        self.labels.sources.ui_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", text_label_right - 10, text_label_top + 8)
        -- we have MAX_SOURCES_SHOWN we can show at same time
        self.labels.sources.values = {}
        text_label_top = -8
        text_label_right = 10
        -- Create the labels for sources
        for i=1,self.MAX_SOURCES_SHOWN_PRIMARY do
            local string_sources_content = MTSLUI_TOOLS:CreateLabel(self.labels.sources.ui_frame, i, text_label_right, text_label_top, "TEXT", "TOPLEFT")
            text_label_top = text_label_top - text_gap
            -- add possibility to save waypoint info
            string_sources_content.waypoint = {
                name,
                x,
                y,
                zone,
            }
            table.insert(self.labels.sources.values, string_sources_content)
        end
        -- add on click for tom tom integration
        self.labels.sources.ui_frame:SetScript("OnMouseUp", function() event_class:AddTomTomWayPointPrimarySource() end)
        -- hide on creation
        self.labels.sources.ui_frame:Show()
        text_label_right = 130
        text_label_top = text_label_top - (3 * text_gap)
        self.labels.alt_type.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("also learned from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.alt_type.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        -- create a frame to hover over and show the tooltip
        self.labels.alt_type.tooltip_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", self.ui_frame, nil, 300, text_gap + 5, false)
        self.labels.alt_type.tooltip_frame_point_x = text_label_right - 5
        self.labels.alt_type.tooltip_frame_point_y = text_label_top + 5
        self.labels.alt_type.tooltip_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.labels.alt_type.tooltip_frame_point_x, self.labels.alt_type.tooltip_frame_point_y)
        self.labels.alt_type.tooltip_frame:SetScript("OnMouseUp", function(self, button)
            -- Left mouse button
            if button == "LeftButton" then
                event_class:LinkAlternativeItemToChat(IsAltKeyDown(), IsControlKeyDown(), IsShiftKeyDown())
                -- Right mouse button, so insert
            else
                event_class:InsertAlternativeItemToChat()
            end
        end)
        self.labels.alt_type.tooltip_frame:SetScript("OnEnter", function() event_class:ToolTipShowAltSourceName() end)
        self.labels.alt_type.tooltip_frame:SetScript("OnLeave", function() _G.GameTooltip:Hide() end)
        text_label_top = text_label_top - text_gap
        self.labels.alt_source.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("obtained from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        self.labels.alt_source.value = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "-", text_label_right, text_label_top, "TEXT", "TOPLEFT")
        text_label_top = text_label_top - text_gap
        -- Labels to show "Trained by: <trainers> or Sold by: <vendors> or Dropped by: <mobs> or Obtained from: <quest>"
        self.labels.alt_sources.title = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("also learned from"), text_label_left, text_label_top, "LABEL", "TOPLEFT")
        -- Create a frame to show the alternative sources
        self.labels.alt_sources.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "", self.ui_frame, nil, self.FRAME_WIDTH - 120, self.FRAME_ALT_SOURCES_HEIGHT, false)
        -- position halfway from the frame with primary sources
        self.labels.alt_sources.ui_frame:SetPoint("BOTTOMRIGHT", self.ui_frame, "BOTTOMRIGHT", 0, 0)
        -- hide on creation
        self.labels.alt_sources.ui_frame:Show()
        self.labels.alt_sources.values = {}
        text_label_top = -8
        text_label_right = 10
        -- Create the labels for sources
        for i=1,self.MAX_SOURCES_SHOWN_SECONDARY do
            local string_sources_content = MTSLUI_TOOLS:CreateLabel(self.labels.alt_sources.ui_frame, i .. " alt", text_label_right, text_label_top, "TEXT", "TOPLEFT")
            text_label_top = text_label_top - text_gap
            -- add possibility to save waypoint info
            string_sources_content.waypoint = {
                name,
                x,
                y,
                zone,
            }
            table.insert(self.labels.alt_sources.values, string_sources_content)
        end
        -- add on click for tom tom integration
        self.labels.alt_sources.ui_frame:SetScript("OnMouseUp", function() event_class:AddTomTomWayPointSecondarySource() end)
    end,

    -- Tries to add a way point to the map for the clicked NPC
    AddTomTomWayPointPrimarySource = function(self)
        self:AddTomTomWayPoint(self.labels.sources, 16, self.MAX_SOURCES_SHOWN_PRIMARY)
    end,

    -- Tries to add a way point to the map for the clicked NPC of an alternative source
    AddTomTomWayPointSecondarySource = function(self)
        self:AddTomTomWayPoint(self.labels.alt_sources, 16, self.MAX_SOURCES_SHOWN_SECONDARY)
    end,

    -- Determine the number of label clicked in an area
    AddTomTomWayPoint = function(self, labels, text_gap, max_label_number)
        -- Calculate the clicked Y coordinate based on the used scale
        local x, y = GetCursorPosition()
        local s = labels.ui_frame:GetEffectiveScale()
        x, y = x/s, y/s;
        local top = labels.ui_frame:GetTop()
        -- calculate how many labels we passed from top coordinate
        local label_number = 0
        while top > y and label_number < max_label_number do
            top = top - text_gap
            label_number = label_number + 1
        end
        -- Check if the label is visable
        if label_number <= max_label_number and labels.values[label_number]:IsVisible() then
            MTSLUI_TOOLS:CreateWayPoint(labels.values[label_number].waypoint, self.labels.name.value:GetText())
        end
    end,

    LinkItemToChat = function(self, is_alt_down, is_ctrl_down, is_shift_down)
        if self.tooltip_source_name then self:LinkToChat(self.tooltip_source_name, is_alt_down, is_ctrl_down, is_shift_down) end
    end,

    LinkAlternativeItemToChat = function(self, is_alt_down, is_ctrl_down, is_shift_down)
        if self.tooltip_alt_source_name then self:LinkToChat(self.tooltip_alt_source_name, is_alt_down, is_ctrl_down, is_shift_down) end
    end,

    LinkToChat = function (self, item_name, is_alt_down, is_ctrl_down, is_shift_down)
        if MTSLUI_SAVED_VARIABLES:GetChatLinkEnabled()  == 1 then
            local link = self:GetItemLink(item_name)
            if link then
                local channel = MTSLUI_SAVED_VARIABLES:GetChatLinkChannel()
                -- if channel is auto, then select channel on how we clicked
                if channel == "AUTO" then
                    if is_alt_down and not is_ctrl_down and not is_shift_down then channel = "RAID"
                    elseif not is_alt_down and is_ctrl_down and not is_shift_down then channel = "GUILD"
                    elseif not is_alt_down and not is_ctrl_down and is_shift_down then channel = "PARTY"
                    else channel = "SAY" end
                end
                -- check if channel is guild and we are in guild, otherwise use say
                if channel == "GUILD" and MTSL_LOGIC_PLAYER_NPC:GetCurrentPlayerIsInGuild() == false then channel = "SAY" end
                -- Same but for party
                if channel == "PARTY" and MTSL_LOGIC_PLAYER_NPC:GetCurrentPlayerIsInParty() == false then channel = "SAY" end
                -- Same but for raid
                if channel == "RAID" and MTSL_LOGIC_PLAYER_NPC:GetCurrentPlayerIsInRaid() == false then channel = "SAY" end
                SendChatMessage(link, channel)
            end
        end
    end,

    InsertItemToChat = function(self)
        if self.tooltip_source_name then self:InsertIntoChat(self.tooltip_source_name) end
    end,

    InsertAlternativeItemToChat = function(self)
        if self.tooltip_alt_source_name then self:InsertIntoChat(self.tooltip_alt_source_name) end
    end,

    InsertIntoChat = function(self, item_name)
        if ChatFrame1EditBox and ChatFrame1EditBox:IsVisible() then
            local link = self:GetItemLink(item_name)
            if link then ChatFrame1EditBox:Insert(link) end
        end
    end,

    GetItemLink = function (self, item_name)
        local _, link = GetItemInfo(item_name)
        local attempts = 0
        while link == nil and attempts < 5 do
            link = self:GetItemLink(item_name)
            attempts = attempts + 1
        end
        return link
    end,

    -- Show the tooltip for the skill/item on top of the detail skill frame
    ToolTipShow = function(self, parent_frame, text)
        if text ~= nil then
            local GameTooltip = _G.GameTooltip
            GameTooltip:SetOwner(parent_frame, "ANCHOR_CURSOR")
            GameTooltip:ClearLines()
            GameTooltip:SetHyperlink(text)
            GameTooltip:Show()
        end
    end,

    ToolTipShowSkillName = function(self)
        self:ToolTipShow(self.labels.name.tooltip_frame, self.tooltip_skill_name)
    end,

    ToolTipShowSourceName = function(self)
        self:ToolTipShow(self.labels.name.tooltip_frame, self.tooltip_source_name)
    end,

    ToolTipShowAltSourceName = function(self)
        self:ToolTipShow(self.labels.name.tooltip_frame, self.tooltip_alt_source_name)
    end,

    HideTooltipFrameShowSkillName = function(self)
        self.tooltip_skill_name = nil
    end,

    HideTooltipFrameShowSourceName = function(self)
        self.tooltip_source_name = nil
        self.labels.type.tooltip_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.labels.type.tooltip_frame_point_x, self.labels.type.tooltip_frame_point_y)
    end,

    HideTooltipFrameShowAltSourceName = function(self)
        self.tooltip_alt_source_name = nil
        self.labels.alt_type.tooltip_frame:SetPoint("TOPLEFT", self.ui_frame, "TOPLEFT", self.labels.alt_type.tooltip_frame_point_x, self.labels.alt_type.tooltip_frame_point_y)
    end,

    ---------------------------------------------------------------------------
    -- Show the frame when no skill is selected so empty labels
    ---------------------------------------------------------------------------
    ShowNoSkillSelected = function(self)
        self.labels.name.value:SetText("-")
        self.labels.expansion.value:SetText("-")
        self.labels.min_skill.value:SetText("-")
        self.labels.requires_xp.value:SetText("-")
        self.labels.requires_rep.value:SetText("-")
        self.labels.requires_spec.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
        self.labels.holiday.value:SetText("-")
        self.labels.special_action.value:SetText("-")
        self.labels.price.value:SetText("-")
        self.labels.type.value:SetText("-")
        -- always reset height as it will be only source
        self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT)
        self.labels.source.value:SetText("-")
        self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("learned from"))
        self.labels.sources.title:Hide()
        self.labels.sources.ui_frame:Hide()
        self.labels.alt_type.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("also learned from"))
        self.labels.alt_type.title:Hide()
        self.labels.alt_type.value:SetText("-")
        self.labels.alt_type.value:Hide()
        self.labels.alt_source.title:Hide()
        self.labels.alt_source.value:SetText("-")
        self.labels.alt_source.value:Hide()
        self.labels.alt_sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("learned from"))
        self.labels.alt_sources.title:Hide()
        self.labels.alt_sources.ui_frame:Hide()
        -- hide the tooltips
        self:HideTooltipFrameShowSkillName()
        self:HideTooltipFrameShowSourceName()
        self:HideTooltipFrameShowAltSourceName()
    end,

    ---------------------------------------------------------------------------
    -- Show the details of a skill (based on its type)
    --
    -- @skill		MTSL_DATA	The skill of which the information must be shown
    ---------------------------------------------------------------------------
    ShowDetailsOfSkill = function(self, skill, profession_name, current_xp_level, current_skill_level)
        self:ShowNoSkillSelected()
        if skill ~= nil then
            -- Generic label setting for every type
            self.labels.name.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedData(skill))
            self:SetRequiredExpansion(skill.expansion, skill.phase)
            self:SetRequiredSkillLevel(skill.min_skill, current_skill_level)
            -- Set minimum xp level
            self:SetRequiredXPLevel(skill.min_xp_level, current_xp_level)
            self:SetRequiredReputationWithFaction(skill.reputation, current_xp_level)
            self:SetRequiredSpecialisation(profession_name, skill.specialisation, current_xp_level)
            self:SetRequiredSpecialAction(skill.special_action)
            -- clear the price
            self.labels.price.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")

            -- Default show only primary source
            self.labels.source.title:Show()
            self.labels.source.value:Show()
            self.labels.sources.title:Show()
            self.labels.sources.ui_frame:Show()

            if skill.items ~= nil then
                self:ShowDetailsOfSkillTypeItem(skill.items[1], profession_name, current_xp_level, 0, 0)
                -- Fix for a 2nd vendor for same item
                if skill.items[2] then
                    self:ShowDetailsOfSkillTypeItem(skill.items[2], profession_name, current_xp_level, 1, 0)
                end
            elseif skill.trainers ~= nil then
                self:ShowDetailsOfSkillTypeTrainer(skill.trainers)
            elseif skill.quests ~= nil then
                self:ShowDetailsOfSkillTypeQuest(skill.quests, profession_name, current_xp_level, 0, 0)
            elseif skill.objects ~= nil then
                self:ShowDetailsOfSkillTypeObject(skill.objects[1], 0, 0)
                -- no sources (special action only)
            else
                self.labels.type.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("special action"))
                self.labels.source.title:Hide()
                self.labels.source.value:Hide()
                self.labels.sources.title:Hide()
                self.labels.sources.ui_frame:Hide()
            end
            self.ui_frame:Show()
            -- Update the text for the tooltips
            self.tooltip_skill_name = "spell:"..skill.id
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a expansion level required
    --
    -- @min_expansion           Number	    The minimum expansion level required to learn the skill
    -- @min_phase               Number	    The minimum phase level required to learn the skill
    ----------------------------------------------------------------------------
    SetRequiredExpansion = function(self, min_expansion, min_phase)
        local expansion_id = min_expansion or MTSL_DATA.CURRENT_EXPANSION_ID
        local phase = min_phase or MTSL_DATA.MIN_PATCH_LEVEL

        -- always available for previous expansions
        if expansion_id < MTSL_DATA.CURRENT_EXPANSION_ID then
            self.labels.expansion.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.YES .. MTSL_TOOLS:GetExpansionNameById(expansion_id))
        else
            -- only available for current expansion if phase level is not too high
            local text = MTSL_TOOLS:GetExpansionNameById(expansion_id) .. " (" .. MTSLUI_TOOLS:GetLocalisedLabel("phase") .. " " .. phase .. ": " .. MTSL_LOGIC_WORLD:GetZoneNameById (MTSL_DATA.PHASE_IDS[phase]) ..")"
            if phase <= MTSL_DATA.CURRENT_PATCH_LEVEL then
                self.labels.expansion.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.YES .. text)
            else
                self.labels.expansion.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.NO .. text)
            end

        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a minimum skill level required
    --
    -- @min_skill	            Number	    The minimum skill level required to learn the skill
    -- @current_skill_level     Number      The current skill level of the player
    ----------------------------------------------------------------------------
    SetRequiredSkillLevel = function(self, min_skill, current_skill_level)
        if min_skill == nil or min_skill <= 0  then
            self.labels.min_skill.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
        elseif current_skill_level == nil or current_skill_level <= 0 then
            self.labels.min_skill.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.ALL .. min_skill)
        elseif min_skill <= current_skill_level then
            self.labels.min_skill.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.YES .. min_skill)
        else
            self.labels.min_skill.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.NO .. min_skill)
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a minimum XP level required
    --
    -- @min_xp_level	    Number	    The minimum XP level required to learn the skill
    -- @current_xp_level    Number      The current XP level of the player
    ----------------------------------------------------------------------------
    SetRequiredXPLevel = function (self, min_xp_level, current_xp_level)
        -- Check if we need certain XP level to learn
        if min_xp_level == nil or min_xp_level <= 0 then
            self.labels.requires_xp.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
        elseif current_xp_level == nil or current_xp_level <= 0 then
            self.labels.requires_xp.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.ALL .. min_xp_level)
        elseif min_xp_level <= current_xp_level then
            self.labels.requires_xp.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.YES .. min_xp_level)
        else
            self.labels.requires_xp.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.NO .. min_xp_level)
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a minimum reputation level required with a faction
    --
    -- @reputation	object	Contains reputation.faction & reputation.level
    ----------------------------------------------------------------------------
    SetRequiredReputationWithFaction = function(self, reputation, current_xp_level)
        -- Check if require reputation to acquire
        local current_text = self.labels.requires_rep.value:GetText()
        if reputation ~= nil then
            local faction = MTSL_LOGIC_FACTION_REPUTATION:GetFactionNameById(reputation.faction_id)
            local rep_level = MTSL_LOGIC_FACTION_REPUTATION:GetReputationLevelById(reputation.level_id)
            -- Color for standing
            local rep_level_player = MTSL_LOGIC_FACTION_REPUTATION:GetReputationLevelWithFaction(faction)
            local rep_status = MTSLUI_FONTS.COLORS.TEXT.NORMAL
            if current_xp_level and current_xp_level > 0 then
                if rep_level_player >= reputation.level_id  then
                    rep_status = MTSLUI_FONTS.COLORS.AVAILABLE.YES
                else
                    rep_status = MTSLUI_FONTS.COLORS.AVAILABLE.NO
                end
            end
            -- append if needed
            if not current_text or current_text == "" or current_text == "-" then
                self.labels.requires_rep.value:SetText(rep_status .. faction .. " [" .. MTSLUI_TOOLS:GetLocalisedData(rep_level) .. "]")
            else
                self.labels.requires_rep.value:SetText(current_text .. " / " .. rep_status .. faction .. " [" .. MTSLUI_TOOLS:GetLocalisedData(rep_level) .. "]")
            end
        else
            if not current_text or current_text == "" then
                self.labels.requires_rep.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
            end
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a specialisation required for the skill
    --
    -- @profession_name         String      The name of the profession
    -- @rspecialisation 	    Number      The number of the specialisation
    ----------------------------------------------------------------------------
    SetRequiredSpecialisation = function(self, profession_name, specialisation, current_xp_level)
        -- Check if require specialisation to acquire
        if specialisation ~= nil and specialisation > 0 then
            local name_spec = MTSL_LOGIC_PROFESSION:GetNameSpecialisation(profession_name, specialisation)
            -- global database so show neutral color
            if current_xp_level == nil or current_xp_level <= 0 then
                self.labels.requires_spec.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.ALL .. name_spec)
                -- check if player knows the specialisation by using its spellid
            elseif IsSpellKnown(specialisation) then
                self.labels.requires_spec.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.YES .. name_spec)
            else
                self.labels.requires_spec.value:SetText(MTSLUI_FONTS.COLORS.AVAILABLE.NO .. name_spec)
            end
        else
            self.labels.requires_spec.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a holiday event required for the skill
    --
    -- @holiday         Number      The id of the holiday
    ----------------------------------------------------------------------------
    SetRequiresHoliday = function(self, holiday_id)
        local holiday = MTSL_TOOLS:GetItemFromArrayByKeyValue(MTSL_DATA["holidays"], "id", holiday_id)
        -- if holiday is required
        if holiday ~= nil then
            self.labels.holiday.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedData(holiday))
        else
            self.labels.holiday.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-")
        end
    end,

    ----------------------------------------------------------------------------
    -- Show the details of a special action required for the skill
    --
    -- @special_action         String      The special actiion
    ----------------------------------------------------------------------------
    SetRequiredSpecialAction = function(self, special_action)
        local text_special_action = self.labels.special_action.value:GetText()

        -- if special action is required
        if special_action ~= nil then
            -- add to current special action or overwrite "-"
            if text_special_action == "-" then
                text_special_action = MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabelSpecialAction(special_action)
                -- dont overwrite current special action
            else
                text_special_action = text_special_action .. ", " .. MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabelSpecialAction(special_action)
            end
            -- only update special action text if this is first time
        elseif text_special_action == nil or text_special_action == "" then
            text_special_action = MTSLUI_FONTS.COLORS.TEXT.NORMAL .. "-"
        end
        self.labels.special_action.value:SetText(text_special_action)
    end,

    ---------------------------------------------------------------------------------------------------
    -- Show the details of a skill learned from trainer
    --
    -- @trainers_info		MTSLDATA	Contains the price from trainer and list of souces with npc ids
    ----------------------------------------------------------------------------------------------------
    ShowDetailsOfSkillTypeTrainer = function(self, trainers_info)
        -- No need to update the expansion/phase, all are available since 1
        self.labels.price.value:SetText(MTSL_TOOLS:GetNumberAsMoneyString(trainers_info.price))
        self.labels.type.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("trainer"))
        self.labels.source.value:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("trainer"))
        -- Labels to show "Trained by: <trainer>"
        self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("trained by"))
        -- Get all "available" trainers for the player
        local trainers = MTSL_LOGIC_PLAYER_NPC:GetNpcsByIds(trainers_info.sources)
        -- Show all the npcs
        self:ShowDetailsOfNpcs(trainers, 0)
        -- hide the tooltips
        self:HideTooltipFrameShowSourceName()
        self:HideTooltipFrameShowAltSourceName()
    end,

    ---------------------------------------------------------------------------------------------------------
    -- Show the details of a skill learned from quest
    --
    -- @quest_id				Number	    The id of the quest to show
    -- @profession_name         String      The name of the profession
    -- @current_xp_level        Number      The current XP level of the player
    -- @is_alternative_source	Number	    Indicates if quest is primary (=0) or secondary (=1) source for skill
    -- @is_primary_type	        Number	    Indicates if quest is primary (=0) or secondary (=1) type for skill
    ----------------------------------------------------------------------------------------------------------
    ShowDetailsOfSkillTypeQuest = function(self, quest_ids, profession_name, current_xp_level, is_alternative_source, is_primary_type)
        if is_alternative_source == 1 then
            self.labels.alt_sources.title:Show()
            self.labels.alt_type.title:Show()
            self.labels.alt_type.value:Show()
            self.labels.alt_source.title:Show()
            self.labels.alt_source.value:Show()
            self.labels.alt_sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("started by"))
        else
            self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("started by"))
        end

        local quest = MTSL_LOGIC_QUEST:GetQuestByIds(quest_ids)

        -- check if quest is availbe to us
        if quest ~= nil then
            self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("quest") .. " : " .. MTSLUI_TOOLS:GetLocalisedData(quest), is_alternative_source, is_primary_type)
            -- show xp level requirements if any
            self:SetRequiredXPLevel(quest.min_xp_level, current_xp_level)
            self:SetRequiredSpecialAction(quest.special_action)
            -- show the npcs as sources that start it if any
            local amount_npcs = MTSL_TOOLS:CountItemsInArray(quest.npcs)
            local amount_items = MTSL_TOOLS:CountItemsInArray(quest.items)

            -- Can only be 1 source
            if amount_npcs > 0 then
                -- Get the npcs the player can interact with
                local questgivers = MTSL_LOGIC_PLAYER_NPC:GetNpcsByIds(quest.npcs)
                self:ShowDetailsOfNpcs(questgivers, is_alternative_source)
                -- hide the tooltip since it does not start from an item
                if is_alternative_source == 0 then
                    self:HideTooltipFrameShowSourceName()
                else
                    self:HideTooltipFrameShowAltSourceName()
                end
            else
                self:ShowDetailsOfNpcs({nil}, is_alternative_source)
            end
            -- show the items as sources
            if amount_items > 0 then
                local items = MTSL_LOGIC_ITEM_OBJECT:GetItemsForProfessionByIds(quest.items, profession_name)
                self:ShowDetailsOfItems(items, is_alternative_source)
                -- update the corresponding tooltip to show info on the item
                if is_alternative_source == 0  then
                    self.tooltip_source_name = "item:" .. quest.items[1]
                else
                    self.tooltip_alt_source_name  = "item:" ..  quest.items[1]
                end
            end
            -- show the objects
            if quest.objects ~= nil then
                local objects = MTSL_LOGIC_ITEM_OBJECT:GetObjectsByIds(quest.objects)
                self:ShowDetailsOfObjects(objects, is_alternative_source, 1)
            end
            -- hide source labels if none
            if amount_npcs <= 0 and amount_items <= 0 and quest.objects == nil then
                if is_alternative_source == 0 then
                    self.labels.sources.title:Hide()
                    self.labels.sources.ui_frame:Hide()
                else
                    self.labels.alt_sources.title:Hide()
                    self.labels.alt_sources.ui_frame:Hide()
                end
            end
            -- not available for our faction
        else
            self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("quest"), is_alternative_source, is_primary_type)
            self:ShowDetailsOfNpcs(quest, is_alternative_source)
        end
    end,

    ---------------------------------------------------------------------------------------------------
    -- Show the details of a skill learned from an object
    --
    -- @oject_id		number  	The id of the source object
    -- @is_alternative_source	Number	    Indicates if quest is primary (=0) or secondary (=1) source for skill
    -- @is_primary_type	        Number	    Indicates if quest is primary (=0) or secondary (=1) type for skill
    ----------------------------------------------------------------------------------------------------
    ShowDetailsOfSkillTypeObject = function (self, oject_id, is_alternative_source, is_primary_type)
        local object = MTSL_LOGIC_ITEM_OBJECT:GetObjectById(oject_id)
        self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedData(object), is_alternative_source, is_primary_type)
        local objects = { object }
        self:ShowDetailsOfObjects(objects, is_alternative_source)
    end,

    ---------------------------------------------------------------------------------------------------
    -- Show the details of a skill learned from a recipe
    --
    -- @item_id		number	The id of the item to show
    -- @profession_name         String      The name of the profession
    -- @current_xp_level        Number      The current XP level of the player
    -- @is_alternative_source	Number	    Indicates if quest is primary (=0) or secondary (=1) source for skill
    -- @is_primary_type	        Number	    Indicates if quest is primary (=0) or secondary (=1) type for skill
    ----------------------------------------------------------------------------------------------------
    ShowDetailsOfSkillTypeItem = function(self, item_id, profession_name, current_xp_level, is_alternative_source, is_primary_type)
        local item = MTSL_LOGIC_ITEM_OBJECT:GetItemForProfessionById(item_id, profession_name)
        if item  == nil then
            MTSL_TOOLS:AddMissingData("item", item_id)
        else
            self:SetRequiredXPLevel(item.min_xp_level)
            self:SetRequiredReputationWithFaction(item.reputation)
            self:SetRequiredSpecialAction(item.special_action)
            self:SetRequiresHoliday(item.holiday)
            self:SetSourceType(MTSLUI_FONTS:GetTextColorByItemQuality(item.quality) .. MTSLUI_TOOLS:GetLocalisedData(item), is_alternative_source, is_primary_type)

            -- Check the amount for each source possible
            local has_vendors = 0
            if item.vendors ~= nil then
                has_vendors = 1
            end
            local has_quests = 0
            if item.quests ~= nil then
                has_quests = 1
            end
            local has_drops = 0
            if item.drops ~= nil then
                has_drops = 1
            end
            local has_objects = 0
            if item.objects ~= nil then
                has_objects = 1
            end

            local amount_sources = has_drops + has_vendors + has_quests + has_objects
            -- hide labels and sources if no sources (when only special action)
            if amount_sources <= 0 then
                self.labels.sources.title:Hide()
                self.labels.sources.ui_frame:Hide()
                self.labels.alt_sources.title:Hide()
                self.labels.alt_sources.ui_frame:Hide()
                self.labels.alt_type.title:Hide()
                self.labels.alt_type.value:Hide()
                self:HideTooltipFrameShowSourceName()
                self:HideTooltipFrameShowAltSourceName()
            else
                -- check if we have more then 1 source to activate the split
                if amount_sources > 1 or is_alternative_source == 1 then
                    -- adjust the height of the source frames to split situation
                    self.labels.alt_sources.title:Show()
                    self.labels.alt_source.title:Show()
                    self.labels.alt_source.value:Show()
                    self.labels.alt_type.title:Show()
                    self.labels.alt_type.value:Show()
                else
                    self:HideTooltipFrameShowAltSourceName()
                end

                -- obtained from vendors
                if has_vendors > 0 then
                    self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("vendor"), is_alternative_source, 1)
                    self.tooltip_source_name = "item:" .. item_id
                    if is_alternative_source == 1 then
                        self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("sold by"))
                    else
                        self.labels.alt_sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("sold by"))
                    end

                    -- if its a currency, dont convert price to gold
                    if item.vendors.currency then
                        if is_alternative_source == 1 and self.labels.price.value:GetText() ~= "" then
                            self.labels.price.value:SetText(self.labels.price.value:GetText() .. " / " .. item.vendors.price .. " " .. MTSL_LOGIC_ITEM_OBJECT:GetCurrencyNameById(item.vendors.currency))
                        else
                            self.labels.price.value:SetText(item.vendors.price .. " " .. MTSL_LOGIC_ITEM_OBJECT:GetCurrencyNameById(item.vendors.currency))
                        end
                    else
                        if is_alternative_source == 1 and self.labels.price.value:GetText() ~= "" then
                            self.labels.price.value:SetText(self.labels.price.value:GetText() .. " / " .. MTSL_TOOLS:GetNumberAsMoneyString(item.vendors.price))
                        else
                            self.labels.price.value:SetText(MTSL_TOOLS:GetNumberAsMoneyString(item.vendors.price))
                        end
                    end
                    -- Get all "available" vendors for the player
                    local vendors = MTSL_LOGIC_PLAYER_NPC:GetNpcsByIds(item.vendors.sources)
                    self:ShowDetailsOfNpcs(vendors, is_alternative_source)
                end
                -- Obtained from a quest
                if has_quests > 0 then
                    -- primary source since no vendors
                    if has_vendors <= 0 then
                        self:ShowDetailsOfSkillTypeQuest(item.quests, profession_name, current_xp_level, 0, 1)
                        self.tooltip_source_name = "item:" .. item_id
                    else
                        -- also set the recipe as alternative source item
                        self:SetSourceType(MTSLUI_FONTS:GetTextColorByItemQuality(item.quality) .. MTSLUI_TOOLS:GetLocalisedData(item), 1, is_primary_type)
                        self:ShowDetailsOfSkillTypeQuest(item.quests, profession_name, current_xp_level, 1, 1)
                        self.tooltip_alt_source_name  = "item:" .. item_id
                    end
                end
                -- Obtained as drop of a mob or range of mobs
                if has_drops > 0 then
                    -- primary source since no vendors or quests
                    if has_vendors <= 0 and has_quests <= 0 then
                        self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("mobs"), is_alternative_source, 1)
                        self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("dropped by"))
                        -- check if drop of mob or world drops
                        if item.drops.range ~= nil then
                            self:ShowWorldDropSources(item.drops.range.min_xp_level, item.drops.range.max_xp_level, 0)
                        else
                            if item.drops.zone_ids ~= nil then
                                self.labels.sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("zone"))
                                self:ShowZoneDropSources(item.drops.zone_ids, 0)
                            else
                                local mobs = MTSL_LOGIC_PLAYER_NPC:GetMobsByIds(item.drops.sources)
                                self:ShowDetailsOfNpcs(mobs, 0)
                            end
                        end
                        self.tooltip_source_name = "item:" .. item_id
                        -- alternative/secundary source
                    else
                        -- also set the recipe as alternative source item
                        self:SetSourceType(MTSLUI_FONTS:GetTextColorByItemQuality(item.quality) .. MTSLUI_TOOLS:GetLocalisedData(item), 1, 0)
                        self:SetSourceType(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("mobs"), 1, 1)
                        self.labels.alt_sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("dropped by"))
                        -- check if drop of mob or world drops
                        if item.drops.range then
                            self:ShowWorldDropSources(item.drops.range.min_xp_level, item.drops.range.max_xp_level, 1)
                        else
                            if item.drops.zone_ids then
                                self.labels.alt_sources.title:SetText(MTSLUI_FONTS.COLORS.TEXT.TITLE .. MTSLUI_TOOLS:GetLocalisedLabel("zone"))
                                self:ShowZoneDropSources(item.drops.zone_ids, 1)
                            else
                                local mobs = MTSL_LOGIC_PLAYER_NPC:GetMobsByIds(item.drops.sources)
                                self:ShowDetailsOfNpcs(mobs, 1)
                            end
                        end
                        self.tooltip_alt_source_name  = "item:" .. item_id
                    end
                end
                -- Obtained by interacting with an object
                if has_objects > 0 then
                    local objects = MTSL_LOGIC_ITEM_OBJECT:GetObjectsByIds(item.objects)
                    -- primary source since no vendors or quests or drops
                    if has_vendors <= 0 and has_quests <= 0 and has_drops <= 0 then
                        self:ShowDetailsOfObjects(objects, 0)
                        self.tooltip_source_name = "item:" .. item_id
                    else
                        -- also set the recipe as alternative source item
                        self:SetSourceType(MTSLUI_FONTS:GetTextColorByItemQuality(item.quality) .. MTSLUI_TOOLS:GetLocalisedData(item), 1, is_primary_type)
                        self:ShowDetailsOfObjects(objects, 1)
                        self.tooltip_alt_source_name  = "item:" .. item_id
                    end
                end
            end
        end
    end,

    ---------------------------------------------------------------------------------------------------
    -- Show the source type of a skill
    --
    -- @text                    String      The text to show for the type
    -- @is_alternative_source	Number	    Indicates if quest is primary (=0) or secondary (=1) source for skill
    -- @is_primary_type	        Number	    Indicates if quest is primary (=0) or secondary (=1) type for skill
    ----------------------------------------------------------------------------------------------------
    SetSourceType = function(self, text, is_alternative_source, is_primary_type)
        if is_alternative_source == 0 then
            if is_primary_type == 0 then
                self.labels.type.value:SetText(text)
            else
                self.labels.source.value:SetText(text)
            end
        else
            if is_primary_type == 0 then
                self.labels.alt_type.value:SetText(text)
            else
                self.labels.alt_source.value:SetText(text)
            end
        end
    end,

    ---------------------------------------------------------------------------------------
    -- Hides the frame
    ----------------------------------------------------------------------------------------
    Hide = function (self)
        self.ui_frame:Hide()
    end,

    ---------------------------------------------------------------------------------------
    -- Shows the frame
    ----------------------------------------------------------------------------------------
    Show = function (self)
        self.ui_frame:Show()
    end,

    ---------------------------------------------------------------------------
    -- Show the details of a list of npcs as sources
    --
    -- @npcs			        Array		The list of npcs
    -- @is_alternative_source	Number		Indicating if primary (=0) or secondary (=1) source
    ---------------------------------------------------------------------------
    ShowDetailsOfNpcs = function(self, npcs, is_alternative_source)
        -- Count amount of trainers
        local npcs_amount = MTSL_TOOLS:CountItemsInArray(npcs)
        local labels_sources = self.labels.sources
        local amount_labels = self.MAX_SOURCES_SHOWN_PRIMARY
        -- take secondary source labels
        if is_alternative_source == 1 then
            labels_sources = self.labels.alt_sources
            amount_labels = self.MAX_SOURCES_SHOWN_SECONDARY
            -- adjust the height of the primary panel
            self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT_WITH_SECONDARY)
        end
        labels_sources.ui_frame:Show()
        -- Not obtainable for this faction
        if npcs_amount <= 0 then
            labels_sources.values[1]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSLUI_TOOLS:GetLocalisedLabel("not available faction"))
            labels_sources.values[1]:Show()
            labels_sources.values[1].waypoint = {
                name,
                x,
                y,
                zone,
            }
            -- Hide the other labels
            for i=2,amount_labels do
                labels_sources.values[i]:Hide()
                labels_sources.values[i].waypoint = {
                    name,
                    x,
                    y,
                    zone,
                }
            end
        else
            -- Show the npcs
            for i=1,amount_labels do
                if npcs[i] ~= nil then
                    local text = ""
                    -- show level of mob/npc if known
                    if npcs[i].xp_level ~= nil and npcs[i].xp_level ~= "" and npcs[i].xp_level ~= 0 then
                        text = "[" .. npcs[i].xp_level["min"]
                        -- show range of levels if needed
                        if npcs[i].xp_level["min"] ~= npcs[i].xp_level["max"] then
                            text = text .. "-" .. npcs[i].xp_level["max"]
                        end
                        -- add a + for elite but not a boss mob
                        if npcs[i].xp_level.is_elite == 1 and npcs[i].xp_level["min"] ~= "??" then
                            text = text .. "+"
                        end
                        --end the text
                        text = text .. "] "
                    else
                        text = text .. "[-] "
                    end
                    -- add name & zone
                    text = text .. MTSLUI_TOOLS:GetLocalisedData(npcs[i]) .. " - " ..  MTSL_LOGIC_WORLD:GetZoneNameById(npcs[i].zone_id)
                    labels_sources.values[i].waypoint.name = MTSLUI_TOOLS:GetLocalisedData(npcs[i])
                    labels_sources.values[i].waypoint.zone = MTSL_LOGIC_WORLD:GetZoneNameById(npcs[i].zone_id)
                    labels_sources.values[i].waypoint.x = nil
                    labels_sources.values[i].waypoint.y = nil
                    -- add coords if known
                    if npcs[i].location ~= nil and npcs[i].location.x ~= "-" and
                            npcs[i].location.x ~= "" then
                        text = text .. " (" .. npcs[i].location.x ..", " .. npcs[i].location.y ..")"
                        -- only fill X and Y if its a real zone
                        if MTSL_LOGIC_WORLD:IsRealZone(npcs[i].zone_id) == 1 then
                            labels_sources.values[i].waypoint.x = npcs[i].location.x
                            labels_sources.values[i].waypoint.y = npcs[i].location.y
                        end
                    end
                    -- Check if require reputation to interact with npc
                    if npcs[i].reputation ~= nil then
                        text = text .. " [".. npcs[i].reputation.faction .. " - " .. npcs[i].reputation.level .. "]"
                    end
                    -- Check if special action is required to interact with npc
                    if npcs[i].special_action ~= nil then
                        text = text .. " [".. MTSLUI_TOOLS:GetLocalisedLabelSpecialAction(npcs[i].special_action) .. "]"
                    end

                    labels_sources.values[i]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. text)

                    labels_sources.values[i]:Show()
                else
                    labels_sources.values[i]:Hide()
                    labels_sources.values[i].waypoint = {
                        name,
                        x,
                        y,
                        zone,
                    }
                end
            end
        end
    end,

    ---------------------------------------------------------------------------
    -- Show the labels of the world drop in the main list
    --
    -- @min_level	            Number      The minimum level of the mobs
    -- @max_level	            Number      The maximum level of the mobs
    -- @is_alternative_source	Number		Indicating if primary (=0) or secondary (=1) source
    ---------------------------------------------------------------------------
    ShowWorldDropSources = function(self, min_level, max_level, is_alternative_source)
        local label_sources = self.labels.sources
        local amount_labels = self.MAX_SOURCES_SHOWN_PRIMARY
        if is_alternative_source == 1  then
            label_sources = self.labels.alt_sources
            amount_labels = self.MAX_SOURCES_SHOWN_SECONDARY
            -- adjust the height of the primary panel
            self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT_WITH_SECONDARY)
        end
        label_sources.ui_frame:Show()
        local drop_text = MTSLUI_TOOLS:GetLocalisedLabel("worldwide drop") .. min_level .. MTSLUI_TOOLS:GetLocalisedLabel("to") .. max_level .. MTSLUI_TOOLS:GetLocalisedLabel("worldwide drop rest")
        label_sources.values[1]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. drop_text)
        label_sources.values[1]:Show()
        label_sources.values[1].waypoint = {
            name,
            x,
            y,
            zone,
        }
        for i=2,amount_labels do
            label_sources.values[i]:Hide()
            label_sources.values[i].waypoint = {
                name,
                x,
                y,
                zone,
            }
        end
    end,

    ---------------------------------------------------------------------------
    -- Show the labels of the zone drop in the main list
    --
    -- @zone_ids                Array       List of zones where it drops
    -- @is_alternative_source	Number		Indicating if primary (=0) or secondary (=1) source
    ---------------------------------------------------------------------------
    ShowZoneDropSources = function(self, zone_ids, is_alternative_source)
        local label_sources = self.labels.sources
        local amount_labels = self.MAX_SOURCES_SHOWN_PRIMARY
        if is_alternative_source == 1  then
            label_sources = self.labels.alt_sources
            amount_labels = self.MAX_SOURCES_SHOWN_SECONDARY
            -- adjust the height of the primary panel
            self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT_WITH_SECONDARY)
        end
        label_sources.ui_frame:Show()
        local drop_text = MTSLUI_TOOLS:GetLocalisedLabel("zone")
        local amount_of_zones = MTSL_TOOLS:CountItemsInArray(zone_ids)
        for i = 1, amount_of_zones do
            label_sources.values[i]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. MTSL_LOGIC_WORLD:GetZoneNameById(zone_ids[i]))
            label_sources.values[i]:Show()
            label_sources.values[i].waypoint = {
                name,
                x,
                y,
                zone,
            }
        end
        for i= amount_of_zones + 1,amount_labels do
            label_sources.values[i]:Hide()
            label_sources.values[i].waypoint = {
                name,
                x,
                y,
                zone,
            }
        end
    end,

    ---------------------------------------------------------------------------
    -- Show the details of a list of items as sources
    --
    -- @items			Array		The list of items
    -- @is_alternative_source	Number		Indicating if primary (=0) or secondary (=1) source
    ---------------------------------------------------------------------------
    ShowDetailsOfItems = function(self, items, is_alternative_source)
        local labels_sources = self.labels.sources
        local amount_labels = self.MAX_SOURCES_SHOWN_PRIMARY
        -- take secondary source labels
        if is_alternative_source == 1 then
            labels_sources = self.labels.alt_sources
            amount_labels = self.MAX_SOURCES_SHOWN_SECONDARY
            -- adjust the height of the primary panel
            self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT_WITH_SECONDARY)
        end
        labels_sources.ui_frame:Show()
        for i=1, amount_labels do
            if items[i] ~= nil then
                local location =  MTSL_LOGIC_WORLD:GetZoneNameById(items[i].zone_id)
                local text = "[" .. MTSLUI_TOOLS:GetLocalisedLabel("item") .. "] " ..  MTSLUI_TOOLS:GetLocalisedData(items[i])
                labels_sources.values[i].waypoint.name = MTSLUI_TOOLS:GetLocalisedData(items[i])
                if location ~= "" then
                    text = text  .. " - " .. location
                    labels_sources.values[i].waypoint.zone = location
                end
                labels_sources.values[i].waypoint.x = nil
                labels_sources.values[i].waypoint.y = nil
                -- add coords if known
                if items[i].location ~= nil and items[i].location.x ~= "-" and
                        items[i].location.x ~= "" then
                    text = text .. " (" .. items[i].location.x ..", " .. items[i].location.y ..")"
                    -- only fill X and Y if its a real zone
                    if MTSL_LOGIC_WORLD:IsRealZone(items[i].zone_id) == 1 then
                        labels_sources.values[i].waypoint.x = items[i].location.x
                        labels_sources.values[i].waypoint.y = items[i].location.y
                    end
                end
                labels_sources.values[i]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. text)
                labels_sources.values[i]:Show()
            else
                labels_sources.values[i]:Hide()
                labels_sources.values[i].waypoint = {
                    name,
                    x,
                    y,
                    zone,
                }
            end
        end
    end,

    ---------------------------------------------------------------------------
    -- Show the labels of the visible objects in the main list
    --
    -- @objects			Array		The list of objects
    -- @is_alternative_source	Number		Indicating if primary (=0) or secondary (=1) source
    ---------------------------------------------------------------------------
    ShowDetailsOfObjects = function(self, objects, is_alternative_source)
        local labels_sources = self.labels.sources
        local amount_labels = self.MAX_SOURCES_SHOWN_PRIMARY
        -- take secondary source labels
        if is_alternative_source == 1 then
            labels_sources = self.labels.alt_sources
            amount_labels = self.MAX_SOURCES_SHOWN_SECONDARY
            -- adjust the height of the primary panel
            self.labels.sources.ui_frame:SetHeight(self.FRAME_SOURCES_HEIGHT_WITH_SECONDARY)
        end
        labels_sources.ui_frame:Show()
        for i=1, amount_labels do
            if objects[i] ~= nil then
                local text =  "[" .. MTSLUI_TOOLS:GetLocalisedLabel("object") .. "] " ..  MTSLUI_TOOLS:GetLocalisedData(objects[i]) .. " - " ..  MTSL_LOGIC_WORLD:GetZoneNameById(objects[i].zone_id)
                labels_sources.values[i].waypoint.name = MTSLUI_TOOLS:GetLocalisedData(objects[i])
                labels_sources.values[i].waypoint.zone = MTSL_LOGIC_WORLD:GetZoneNameById(objects[i].zone_id)
                labels_sources.values[i].waypoint.x = nil
                labels_sources.values[i].waypoint.y = nil
                -- add coords if known
                if objects[i].location ~= nil and objects[i].location.x ~= "-" and
                        objects[i].location.x ~= "" then
                    text = text .. " (" .. objects[i].location.x ..", " .. objects[i].location.y ..")"
                    -- only fill X and Y if its a real zone
                    if MTSL_LOGIC_WORLD:IsRealZone(objects[i].zone_id) == 1 then
                        labels_sources.values[i].waypoint.x = objects[i].location.x
                        labels_sources.values[i].waypoint.y = objects[i].location.y
                    end
                end
                labels_sources.values[i]:SetText(MTSLUI_FONTS.COLORS.TEXT.NORMAL .. text)
                labels_sources.values[i]:Show()
            else
                labels_sources.values[i]:Hide()
                labels_sources.values[i].waypoint = {
                    name,
                    x,
                    y,
                    zone,
                }
            end
        end
    end,
}