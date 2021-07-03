------------------------------------------------------------------
-- Name: ConfigFrame										    --
-- Description: Set values of user options        				--
-- Parent Frame: OptionsMenuFrame              					--
------------------------------------------------------------------

MTSLOPTUI_CONFIG_FRAME = {
    FRAME_HEIGHT = 495,
    MARGIN_LEFT = 25,
    MARGIN_RIGHT = 285,
    WIDTH_DD = 100,
    ui_split_keys = { "MTSL", "ACCOUNT", "CHAR", "DATABASE", "NPC" },
    ui_scale_keys = { "MTSL", "ACCOUNT", "CHAR", "DATABASE", "NPC", "OPTIONSMENU" },

    ---------------------------------------------------------------------------------------
    -- Initialises the titleframe
    ----------------------------------------------------------------------------------------
    Initialise = function (self, parent_frame)
        self.FRAME_WIDTH = MTSLUI_OPTIONS_MENU_FRAME.FRAME_WIDTH
        self.ui_frame = MTSLUI_TOOLS:CreateBaseFrame("Frame", "MTSLOPTUI_ConfigFrame", parent_frame, nil, self.FRAME_WIDTH, self.FRAME_HEIGHT, false)
        -- below title frame
        self.ui_frame:SetPoint("TOPLEFT", parent_frame, "BOTTOMLEFT", 0, -5)

        -- build the lists to be used in the drop downs
        self:BuildListsDropDowns()

        -- build the UI for the drop downs
        self.TOP_LABEL_ABOVE_DD = 23
        self.MARGIN_RIGHT_CHECKBOX = 110

        local margin_top = -3
        local margin_between_rows = 50
        self:InitialiseOptionsWelcomeMessage(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsAutoShowMTSL(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsMinimap(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsTooltip(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsLinkToChat(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsMTSLFrameLocation(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsUISplitOrientation(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsUISplitScale(margin_top)
        margin_top = margin_top - margin_between_rows
        self:InitialiseOptionsFonts(margin_top)
        
        -- load the current savedvarialbes and show the values
        self:LoadSavedVariables()
        self:ResetUI()
    end,

    BuildListsDropDowns = function(self)
        self.drop_down_lists = {}

        -- minimap
        self.drop_down_lists.minimap = {}
        self.drop_down_lists.minimap.shapes = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("circle"),
                ["id"] = "circle",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("square"),
                ["id"] = "square",
            }
        }

        self.drop_down_lists.minimap.radius = {}
        local current_radius = tonumber(MTSLUI_SAVED_VARIABLES.MIN_MINIMAP_RADIUS)
        while current_radius <= tonumber(MTSLUI_SAVED_VARIABLES.MAX_MINIMAP_RADIUS) do
            local new_radius = {
                ["id"] = current_radius,
                ["name"] = current_radius .. " px",
            }
            current_radius = current_radius + 4
            table.insert(self.drop_down_lists.minimap.radius, new_radius)
        end

        -- Tooltip
        self.drop_down_lists.tooltip = {}
        self.drop_down_lists.tooltip.factions = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("current character"),
                ["id"] = "current character",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("any"),
                ["id"] = "any",
            }
        }
        self.drop_down_lists.tooltip.known = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("show"),
                ["id"] = "show",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("hide"),
                ["id"] = "hide",
            }
        }

        -- Available chat channels
        self.drop_down_lists.chat = {}
        self.drop_down_lists.chat.channels = {}

        for _, c in pairs(MTSLUI_SAVED_VARIABLES.CHAT_CHANNELS) do
            local new_chat_channel = {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel(c),
                ["id"] = c,
            }
            table.insert(self.drop_down_lists.chat.channels, new_chat_channel)
        end

        -- MTSL button location
        self.drop_down_lists.mtsl_button_locations = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("left"),
                ["id"] = "left",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("right"),
                ["id"] = "right",
            }
        }

        -- MTSL frame location
        self.drop_down_lists.mtsl_frame_locations = {
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("left"),
                ["id"] = "left",
            },
            {
                ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("right"),
                ["id"] = "right",
            }
        }

        -- Split modes
        self.drop_down_lists.ui_split = {}
        for _, k in pairs(self.ui_split_keys) do
            self.drop_down_lists.ui_split[k] = {
                {
                    ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("vertical"),
                    ["id"] = "Vertical",
                },
                {
                    ["name"] = MTSLUI_TOOLS:GetLocalisedLabel("horizontal"),
                    ["id"] = "Horizontal",
                }
            }
        end
        -- UI scales
        self.drop_down_lists.ui_scale = {}
        for _, k in pairs(self.ui_scale_keys) do
            self.drop_down_lists.ui_scale[k] = {}

            local current_scale = tonumber(MTSLUI_SAVED_VARIABLES.MIN_UI_SCALE)

            while current_scale <= tonumber(MTSLUI_SAVED_VARIABLES.MAX_UI_SCALE) do
                local new_scale = {
                    ["id"] = current_scale,
                    ["name"] =  (100 * current_scale) .. " %",
                }
                -- steps of 5%
                current_scale = current_scale + 0.05
                table.insert(self.drop_down_lists.ui_scale[k], new_scale)
            end
        end

        -- Font
        self.drop_down_lists.font = {}
        self.drop_down_lists.font.names = MTSLUI_FONTS:GetAvailableFonts()
        self.drop_down_lists.font.title = MTSLUI_FONTS.AVAILABLE_FONT_SIZES
        self.drop_down_lists.font.label = MTSLUI_FONTS.AVAILABLE_FONT_SIZES
        self.drop_down_lists.font.text = MTSLUI_FONTS.AVAILABLE_FONT_SIZES
    end,

    InitialiseOptionsWelcomeMessage = function(self, margin_top)
        self.ui_frame.welcome_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("addon loaded msg"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")
        self.welcome_check = MTSLUI_TOOLS:CreateCheckbox(self.ui_frame, "MTSLOPTUI_ConfigFrame_Welcome", self.MARGIN_RIGHT + self.MARGIN_RIGHT_CHECKBOX, margin_top + 5)
    end,

    InitialiseOptionsAutoShowMTSL = function(self, margin_top)
        self.ui_frame.autoshow_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("auto show mtsl"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")
        self.autoshow_check = MTSLUI_TOOLS:CreateCheckbox(self.ui_frame, "MTSLOPTUI_ConfigFrame_AutoShow", self.MARGIN_RIGHT + self.MARGIN_RIGHT_CHECKBOX, margin_top + 5)
    end,

    InitialiseOptionsMinimap = function(self, margin_top)
        self.ui_frame.minimap_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("minimap icon"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")
        self.minimap_button_check = MTSLUI_TOOLS:CreateCheckbox(self.ui_frame, "MTSLOPTUI_ConfigFrame_Minimap", self.MARGIN_RIGHT + self.MARGIN_RIGHT_CHECKBOX, margin_top + 5)

        self.ui_frame.minimap_shape_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_MINIMAP_SHAPE", self.ui_frame, self.minimap_button_check, "TOPRIGHT", -5, 2, self.CreateDropDownMinimapShape, self.WIDTH_DD)
        self.ui_frame.minimap_shape_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_shape_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("minimap shape"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.minimap_radius_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_MINIMAP_RADIUS", self.ui_frame, self.ui_frame.minimap_shape_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownMinimapRadius, self.WIDTH_DD)
        self.ui_frame.minimap_radius_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_radius_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("radius"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.minimap_reset_btn = MTSLUI_TOOLS:CreateBaseFrame("Button", "MTSLOPTUI_MINIMLAP_BTN_RESET", self.ui_frame, "UIPanelButtonTemplate", self.WIDTH_DD + 20, 26)
        self.ui_frame.minimap_reset_btn:SetPoint("TOPLEFT", self.ui_frame.minimap_radius_drop_down, "TOPRIGHT", -5, 0)
        self.ui_frame.minimap_reset_btn:SetText(MTSLUI_TOOLS:GetLocalisedLabel("reset"))
        self.ui_frame.minimap_reset_btn:SetScript("OnClick", function () MTSLUI_MINIMAP:ResetButton() end)

        self.ui_frame.minimap_radius_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.minimap_reset_btn, "Position", 0, 20, "LABEL", "CENTER")
    end,

    InitialiseOptionsTooltip = function(self, margin_top)
        self.ui_frame.tooltip_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("enhance tooltip"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")
        self.tooltip_check = MTSLUI_TOOLS:CreateCheckbox(self.ui_frame, "MTSLOPTUI_ConfigFrame_TooltipEnhance", self.MARGIN_RIGHT + self.MARGIN_RIGHT_CHECKBOX, margin_top + 5)

        self.ui_frame.tooltip_faction_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_TOOLTIP_FACTION", self.ui_frame, self.tooltip_check, "TOPRIGHT", -5, 2, self.CreateDropDownTooltipFaction, self.WIDTH_DD)
        self.ui_frame.tooltip_faction_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.tooltip_faction_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("faction"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.tooltip_known_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_TOOLTIP_SHOWHIDE", self.ui_frame, self.ui_frame.tooltip_faction_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownTooltipShowKnown, self.WIDTH_DD)
        self.ui_frame.tooltip_known_drop_down_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.tooltip_known_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("known"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    InitialiseOptionsLinkToChat = function(self, margin_top)
        self.ui_frame.linktochat_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("link_to_chat"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")
        self.linktochat_check = MTSLUI_TOOLS:CreateCheckbox(self.ui_frame, "MTSLOPTUI_ConfigFrame_LinkToChat", self.MARGIN_RIGHT + self.MARGIN_RIGHT_CHECKBOX, margin_top + 5)

        self.ui_frame.chat_channel_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_linktochat", self.ui_frame, self.linktochat_check, "TOPRIGHT", -5, 2, self.CreateDropDownChatChannel, self.WIDTH_DD)
        self.ui_frame.chat_channel_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.chat_channel_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("channel"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    InitialiseOptionsMTSLFrameLocation = function (self, margin_top)
        self.ui_frame.location_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, "MTSL", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.location_mtsl_button_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_location_MTSL_button", self.ui_frame, self.ui_frame, "TOPLEFT", self.MARGIN_RIGHT, margin_top + 7, self.CreateDropDownLocationMTSLbutton, self.WIDTH_DD)
        self.ui_frame.location_button_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.location_mtsl_button_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("mtsl button location"),0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.location_mtsl_frame_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_location_MTSL_frame", self.ui_frame, self.ui_frame.location_mtsl_button_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownLocationMTSLframe, self.WIDTH_DD)
        self.ui_frame.location_frame_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.location_mtsl_frame_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("mtsl frame location"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    InitialiseOptionsUISplitOrientation = function (self, margin_top)
        self.ui_frame.ui_split_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("ui split orientation"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.ui_split_MTSL_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_ui_split_MTSL", self.ui_frame, self.ui_frame.location_mtsl_button_drop_down, "BOTTOMLEFT", 0, -18, self.CreateDropDownOrientationMTSL, self.WIDTH_DD)
        self.ui_frame.ui_split_mtsl_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_split_MTSL_drop_down, "MTSL", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_split_ACCOUNT_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_ui_split_ACCOUNT", self.ui_frame, self.ui_frame.ui_split_MTSL_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownOrientationAccount, self.WIDTH_DD)
        self.ui_frame.ui_split_account_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_split_ACCOUNT_drop_down, "Account explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_split_CHAR_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_ui_split_CHAR", self.ui_frame, self.ui_frame.ui_split_ACCOUNT_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownOrientationCharacter, self.WIDTH_DD)
        self.ui_frame.ui_split_char_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_split_CHAR_drop_down, "Character explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_split_DATABASE_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_ui_split_DB", self.ui_frame, self.ui_frame.ui_split_CHAR_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownOrientationDatabase, self.WIDTH_DD)
        self.ui_frame.ui_split_database_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_split_DATABASE_drop_down, "Database explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_split_NPC_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_ui_split_NPC", self.ui_frame, self.ui_frame.ui_split_DATABASE_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownOrientationNpc, self.WIDTH_DD)
        self.ui_frame.ui_split_npc_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_split_NPC_drop_down, "NPC Explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    InitialiseOptionsUISplitScale = function (self, margin_top)
        self.ui_frame.ui_scale_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("ui scale"), self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.ui_scale_MTSL_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_MTSL", self.ui_frame, self.ui_frame.ui_split_MTSL_drop_down, "BOTTOMLEFT", 0, -18, self.CreateDropDownScaleMTSL, self.WIDTH_DD)
        self.ui_frame.ui_scale_mtsl_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_MTSL_drop_down, "MTSL", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_scale_ACCOUNT_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_ACC", self.ui_frame, self.ui_frame.ui_scale_MTSL_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownScaleAccount, self.WIDTH_DD)
        self.ui_frame.ui_scale_account_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_ACCOUNT_drop_down, "Account Explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_scale_CHAR_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_CHAR", self.ui_frame, self.ui_frame.ui_scale_ACCOUNT_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownScaleCharacter, self.WIDTH_DD)
        self.ui_frame.ui_scale_char_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_CHAR_drop_down, "Character Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.ui_scale_DATABASE_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_DB", self.ui_frame, self.ui_frame.ui_scale_CHAR_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownScaleDatabase, self.WIDTH_DD)
        self.ui_frame.ui_scale_database_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_DATABASE_drop_down, "Database Explorer", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.ui_scale_NPC_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_NPC", self.ui_frame, self.ui_frame.ui_scale_DATABASE_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownScaleNpc, self.WIDTH_DD)
        self.ui_frame.ui_scale_npc_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_NPC_drop_down, "NPC Explorer", 0, 22, "LABEL", "CENTER")

        self.ui_frame.ui_scale_OPTIONSMENU_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_SCALE_OPTIONS", self.ui_frame, self.ui_frame.ui_scale_NPC_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownScaleOptionsMenu, self.WIDTH_DD)
        self.ui_frame.ui_scale_options_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.ui_scale_OPTIONSMENU_drop_down, "Options menu", 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    InitialiseOptionsFonts = function (self, margin_top)
        self.ui_frame.font_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame, MTSLUI_TOOLS:GetLocalisedLabel("font") .. " (" .. MTSLUI_TOOLS:GetLocalisedLabel("reload UI") .. ")", self.MARGIN_LEFT, margin_top, "LABEL", "TOPLEFT")

        self.ui_frame.font_name_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_font_MTSL", self.ui_frame, self.ui_frame.ui_scale_MTSL_drop_down, "BOTTOMLEFT", 0, -18, self.CreateDropDownFontType, self.WIDTH_DD)
        self.ui_frame.font_name_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_name_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("type"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.font_title_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_font_TITLE", self.ui_frame, self.ui_frame.font_name_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownSizeTitle, self.WIDTH_DD)
        self.ui_frame.font_title_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_title_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("title"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.font_label_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_font_LABEL", self.ui_frame, self.ui_frame.font_title_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownSizeLabel, self.WIDTH_DD)
        self.ui_frame.font_label_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_label_drop_down,MTSLUI_TOOLS:GetLocalisedLabel("label list"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")

        self.ui_frame.font_text_drop_down = MTSLUI_TOOLS:CreateDropDown("MTSLOPTUI_CONFIG_FRAME_DD_font_TEXT", self.ui_frame, self.ui_frame.font_label_drop_down, "TOPRIGHT", -20, 0, self.CreateDropDownSizeText, self.WIDTH_DD)
        self.ui_frame.font_options_text = MTSLUI_TOOLS:CreateLabel(self.ui_frame.font_text_drop_down, MTSLUI_TOOLS:GetLocalisedLabel("text"), 0, self.TOP_LABEL_ABOVE_DD, "LABEL", "CENTER")
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop downs for the minimap options
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownMinimapShape = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.minimap.shapes, MTSLOPTUI_CONFIG_FRAME.ChangeMinimapShapeHandler)
    end,

    CreateDropDownMinimapRadius = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.minimap.radius, MTSLOPTUI_CONFIG_FRAME.ChangeMinimapRadiusHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for tooltip faction
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownTooltipFaction = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.tooltip.factions, MTSLOPTUI_CONFIG_FRAME.ChangeTooltipFactionHandler)
    end,

    CreateDropDownTooltipShowKnown  = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.tooltip.known, MTSLOPTUI_CONFIG_FRAME.ChangeTooltipShowKnownHandler)
    end,
    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for chat channels
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownChatChannel = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.chat.channels, MTSLOPTUI_CONFIG_FRAME.ChangeChatChannelHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for location mtsl button & frame
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownLocationMTSLbutton = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.mtsl_button_locations, MTSLOPTUI_CONFIG_FRAME.ChangeLocationMTSLbuttonHandler)
    end,

    CreateDropDownLocationMTSLframe = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.mtsl_frame_locations, MTSLOPTUI_CONFIG_FRAME.ChangeLocationMTSLframeHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for split orientation
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownOrientationMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_split["MTSL"], MTSLOPTUI_CONFIG_FRAME.ChangeOrientationMTSLHandler)
    end,

    CreateDropDownOrientationAccount = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_split["ACCOUNT"], MTSLOPTUI_CONFIG_FRAME.ChangeOrientationAccountHandler)
    end,

    CreateDropDownOrientationCharacter = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_split["CHAR"], MTSLOPTUI_CONFIG_FRAME.ChangeOrientationCharacterHandler)
    end,

    CreateDropDownOrientationDatabase = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_split["DATABASE"], MTSLOPTUI_CONFIG_FRAME.ChangeOrientationDatabaseHandler)
    end,

    CreateDropDownOrientationNpc = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_split["NPC"], MTSLOPTUI_CONFIG_FRAME.ChangeOrientationNpcHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for UI scaling
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownScaleMTSL = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["MTSL"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleMTSLHandler)
    end,

    CreateDropDownScaleAccount = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["ACCOUNT"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleAccountHandler)
    end,

    CreateDropDownScaleDatabase = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["DATABASE"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleDatabaseHandler)
    end,

    CreateDropDownScaleCharacter = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["CHAR"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleCharacterHandler)
    end,

    CreateDropDownScaleNpc = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["NPC"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleNpcHandler)
    end,

    CreateDropDownScaleOptionsMenu = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.ui_scale["OPTIONSMENU"], MTSLOPTUI_CONFIG_FRAME.ChangeScaleOptionsMenuHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Intialises drop down for font
    ----------------------------------------------------------------------------------------------------------
    CreateDropDownFontType = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.font.names, MTSLOPTUI_CONFIG_FRAME.ChangeFontTypeHandler)
    end,

    CreateDropDownSizeTitle = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.font.title, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeTitleHandler)
    end,

    CreateDropDownSizeLabel = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.font.label, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeLabelHandler)
    end,

    CreateDropDownSizeText = function(self, level)
        MTSLUI_TOOLS:FillDropDown(MTSLOPTUI_CONFIG_FRAME.drop_down_lists.font.text, MTSLOPTUI_CONFIG_FRAME.ChangeFontSizeTextHandler)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change events for minimap values
    ----------------------------------------------------------------------------------------------------------
    ChangeMinimapShapeHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("minimap", "shape", value, text)
    end,

    ChangeMinimapRadiusHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("minimap", "radius", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change events for the tooltip
    ----------------------------------------------------------------------------------------------------------
    ChangeTooltipFactionHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("tooltip", "faction", value, text)
    end,

    ChangeTooltipShowKnownHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("tooltip", "known", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the chat channel to link item/spell to
    ----------------------------------------------------------------------------------------------------------
    ChangeChatChannelHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("chat", "channel", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the location of button or frame
    ----------------------------------------------------------------------------------------------------------
    ChangeLocationMTSLbuttonHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("location_mtsl", "button", value, text)
    end,

    ChangeLocationMTSLframeHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("location_mtsl", "frame", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change events after changing the orientation for a frame
    ----------------------------------------------------------------------------------------------------------
    ChangeOrientationMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_split", "MTSL", value, text)
    end,

    ChangeOrientationAccountHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_split", "ACCOUNT", value, text)
    end,

    ChangeOrientationCharacterHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_split", "CHAR", value, text)
    end,

    ChangeOrientationDatabaseHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_split", "DATABASE", value, text)
    end,

    ChangeOrientationNpcHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_split", "NPC", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event afters changing the scale for aframe
    ----------------------------------------------------------------------------------------------------------
    ChangeScaleMTSLHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "MTSL", value, text)
    end,

    ChangeScaleAccountHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "ACCOUNT", value, text)
    end,

    ChangeScaleCharacterHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "CHAR", value, text)
    end,

    ChangeScaleDatabaseHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "DATABASE", value, text)
    end,

    ChangeScaleNpcHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "NPC", value, text)
    end,

    ChangeScaleOptionsMenuHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("ui_scale", "OPTIONSMENU", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Handles DropDown Change event after changing the font
    ----------------------------------------------------------------------------------------------------------
    ChangeFontTypeHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("font", "name", value, text)
    end,

    ChangeFontSizeTitleHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("font", "title", value, text)
    end,

    ChangeFontSizeLabelHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("font", "label", value, text)
    end,

    ChangeFontSizeTextHandler = function(value, text)
        MTSLOPTUI_CONFIG_FRAME:ChangeWithSubValue("font", "text", value, text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Generic method to handle change of a config value
    ----------------------------------------------------------------------------------------------------------
    ChangeValue = function (self, value_name, value, text)
        self.config_values[value_name] = value
        UIDropDownMenu_SetText(self.ui_frame[value_name .. "_drop_down"], text)
    end,

    ChangeWithSubValue = function (self, value_name, sub_value_name, value, text)
        self.config_values[value_name][sub_value_name] = value
        UIDropDownMenu_SetText(self.ui_frame[value_name .. "_" .. sub_value_name .. "_drop_down"], text)
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Save the current values
    ----------------------------------------------------------------------------------------------------------
    Save = function(self)
        MTSLUI_SAVED_VARIABLES:SetShowWelcomeMessage(self.welcome_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetAutoShowMTSL(self.autoshow_check:GetChecked())

        MTSLUI_SAVED_VARIABLES:SetMinimapShape(self.config_values.minimap.shape)
        MTSLUI_SAVED_VARIABLES:SetMinimapButtonRadius(self.config_values.minimap.radius)
        MTSLUI_SAVED_VARIABLES:SetMinimapButtonActive(self.minimap_button_check:GetChecked())

        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipActive(self.tooltip_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipFaction(self.config_values.tooltip.faction)
        MTSLUI_SAVED_VARIABLES:SetEnhancedTooltipShowKnown(self.config_values.tooltip.known)

        MTSLUI_SAVED_VARIABLES:SetChatLinkEnabled(self.linktochat_check:GetChecked())
        MTSLUI_SAVED_VARIABLES:SetChatLinkChannel(self.config_values.chat.channel)

        -- Update the UI filter frames
        MTSLUI_SAVED_VARIABLES:SetMTSLLocationButton(self.config_values.location_mtsl.button)
        MTSLUI_SAVED_VARIABLES:SetMTSLLocationFrame(self.config_values.location_mtsl.frame)

        MTSLUI_SAVED_VARIABLES:SetSplitModes(self.config_values.ui_split)
        MTSLUI_SAVED_VARIABLES:SetUIScales(self.config_values.ui_scale)

        -- if Font was actually changed, reload ui
        if MTSLUI_SAVED_VARIABLES:SetFont(self.config_values.font) == true then
            MTSLUI_FONTS:Initialise()
            ReloadUI()
        end
    end,

    ShowValueInCheckBox = function(self, checkbox, value)
        if value == 1 then checkbox:SetChecked(true)
            -- using false or 0 does not work, has to be nil
        else checkbox:SetChecked(nil) end
    end,

    -- Show all the current values in the UI
    ResetUI = function (self)
        self:ShowValueInCheckBox(self.welcome_check, self.config_values.welcome)

        self:ShowValueInCheckBox(self.autoshow_check, self.config_values.auto_show)
        -- minimap
        self:ShowValueInCheckBox(self.minimap_button_check, self.config_values.minimap.active)
        UIDropDownMenu_SetText(self.ui_frame.minimap_shape_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(self.config_values.minimap.shape))
        UIDropDownMenu_SetText(self.ui_frame.minimap_radius_drop_down, self.config_values.minimap.radius .. " px")

        -- Enchanced Tooltip
        self:ShowValueInCheckBox(self.tooltip_check, self.config_values.tooltip.active)
        UIDropDownMenu_SetText(self.ui_frame.tooltip_faction_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(self.config_values.tooltip.faction))
        UIDropDownMenu_SetText(self.ui_frame.tooltip_known_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(self.config_values.tooltip.known))
        -- Link to chat
        self:ShowValueInCheckBox(self.linktochat_check, self.config_values.chat.active)
        UIDropDownMenu_SetText(self.ui_frame.chat_channel_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(self.config_values.chat.channel))

        UIDropDownMenu_SetText(self.ui_frame.location_mtsl_button_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(self.config_values.location_mtsl.button)))
        UIDropDownMenu_SetText(self.ui_frame.location_mtsl_frame_drop_down, MTSLUI_TOOLS:GetLocalisedLabel(string.lower(self.config_values.location_mtsl.frame)))

        -- Split modes
        for _, k in pairs(self.ui_split_keys) do
            UIDropDownMenu_SetText(self.ui_frame["ui_split_" .. k .. "_drop_down"], self.config_values.ui_split[k])
        end
        -- UI scales
        for _, k in pairs(self.ui_scale_keys) do
            UIDropDownMenu_SetText(self.ui_frame["ui_scale_" .. k .. "_drop_down"], (100 * self.config_values.ui_scale[k]) .. " %")
        end
        -- Font
        UIDropDownMenu_SetText(self.ui_frame.font_name_drop_down, MTSL_TOOLS:GetItemFromArrayByKeyValue(self.drop_down_lists.font.names, "id", self.config_values.font.name).name)
        UIDropDownMenu_SetText(self.ui_frame.font_title_drop_down, self.config_values.font.title)
        UIDropDownMenu_SetText(self.ui_frame.font_label_drop_down, self.config_values.font.label)
        UIDropDownMenu_SetText(self.ui_frame.font_text_drop_down, self.config_values.font.text)
    end,

    -- Loads the current saved variables values
    LoadSavedVariables = function(self)
        self.config_values = {}
        self.config_values.welcome = MTSLUI_SAVED_VARIABLES:GetShowWelcomeMessage()

        self.config_values.auto_show = MTSLUI_SAVED_VARIABLES:GetAutoShowMTSL()

        self.config_values.minimap = {}
        self.config_values.minimap.active = MTSLUI_SAVED_VARIABLES:GetMinimapButtonActive()
        self.config_values.minimap.shape = MTSLUI_SAVED_VARIABLES:GetMinimapShape()
        self.config_values.minimap.radius = MTSLUI_SAVED_VARIABLES:GetMinimapButtonRadius()

        self.config_values.tooltip = {}
        self.config_values.tooltip.active =  MTSLUI_SAVED_VARIABLES:GetEnhancedTooltipActive()
        self.config_values.tooltip.faction = MTSLUI_SAVED_VARIABLES:GetEnhancedTooltipFaction()
        self.config_values.tooltip.known = MTSLUI_SAVED_VARIABLES:GetEnhancedTooltipShowKnown()

        self.config_values.chat = {}
        self.config_values.chat.active = MTSLUI_SAVED_VARIABLES:GetChatLinkEnabled()
        self.config_values.chat.channel = MTSLUI_SAVED_VARIABLES:GetChatLinkChannel()

        self.config_values.location_mtsl = {}
        self.config_values.location_mtsl.button = MTSLUI_SAVED_VARIABLES:GetMTSLLocationButton()
        self.config_values.location_mtsl.frame = MTSLUI_SAVED_VARIABLES:GetMTSLLocationFrame()

        -- Split modes
        self.config_values.ui_split = {}
        for _, k in pairs(self.ui_split_keys) do
            self.config_values.ui_split[k] = MTSLUI_SAVED_VARIABLES:GetSplitMode(k)
        end
        -- UI scales
        self.config_values.ui_scale = {}
        for _, k in pairs(self.ui_scale_keys) do
            self.config_values.ui_scale[k] = MTSLUI_SAVED_VARIABLES:GetUIScale(k)
        end

        self.config_values.font = {}
        self.config_values.font.name = MTSLUI_SAVED_VARIABLES:GetFontName()
        self.config_values.font.title = MTSLUI_SAVED_VARIABLES:GetFontSizeTitle()
        self.config_values.font.label = MTSLUI_SAVED_VARIABLES:GetFontSizeLabel()
        self.config_values.font.text = MTSLUI_SAVED_VARIABLES:GetFontSizeText()
    end,

    ----------------------------------------------------------------------------------------------------------
    -- Reset the current values
    ----------------------------------------------------------------------------------------------------------
    Reset = function(self)
        MTSLUI_SAVED_VARIABLES:ResetSavedVariables()

        self:LoadSavedVariables()
        self:ResetUI()
    end,
}