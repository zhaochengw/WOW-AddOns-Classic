-- main.lua ============================================================================
local addon_name, st = ...
-- local L = st.localization_table
local version = "1.3.1"
local load_message = "version " .. version .. " loaded!"
local ST = LibStub("AceAddon-3.0"):GetAddon("SwedgeTimer")
local print = st.utils.print_msg

st.core = {}
st.core.in_combat = false

--=========================================================================================
-- A frame to detect if the player is in combat or not.
st.core.in_combat_frame = CreateFrame("Frame", addon_name .. "CombatFrame", UIParent)
local function in_combat_frame_event_handler(self, event, ...)
    if event == "PLAYER_REGEN_ENABLED" then
        st.core.in_combat = false
    elseif event == "PLAYER_REGEN_DISABLED" then
        st.core.in_combat = true
    end
    st.bar.update_bar_on_combat()
end

--=========================================================================================
-- Now, a frame to load the addon upon intercepting the ADDON_LOADED event trigger
--=========================================================================================
-- This function is called once when the addon is loaded, and 
-- sets up the various frames and elements.
local function init_addon(self)

    -- Load visuals
    if st.debug then print('Initialising visuals...') end
    st.bar.init_bar_visuals()

    if st.debug then print('Registering events and widget handlers...') end
    -- Register the in-combat events and widget handlers
    st.core.in_combat_frame:SetScript("OnEvent", in_combat_frame_event_handler)
    st.core.in_combat_frame:RegisterEvent("PLAYER_REGEN_ENABLED")
    st.core.in_combat_frame:RegisterEvent("PLAYER_REGEN_DISABLED")

    -- Attach the events and widget handlers for the player stats frame
    st.player_frame:SetScript("OnEvent", st.player.frame_on_event)
    st.player_frame:SetScript("OnUpdate", st.player.frame_on_update)
    st.player_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    st.player_frame:RegisterEvent("UNIT_INVENTORY_CHANGED")
    st.player_frame:RegisterUnitEvent("UNIT_AURA", "player")
    st.player_frame:RegisterUnitEvent("UNIT_SPELLCAST_INTERRUPTED", "player")
    st.player_frame:RegisterUnitEvent("UNIT_SPELLCAST_START", "player")
    
    st.player_frame:RegisterEvent("EXECUTE_CHAT_LINE")
    st.player_frame:RegisterEvent("PLAYER_TARGET_SET_ATTACKING")

    st.player_frame:RegisterEvent("CHARACTER_POINTS_CHANGED")
    st.player_frame:RegisterEvent("UNIT_SPELLCAST_SENT")
    st.player_frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
    st.player_frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
    st.player_frame:RegisterEvent("PLAYER_MOUNT_DISPLAY_CHANGED")

    -- Any operations to initialise the player state
    st.player.swing_timer = 0.00001
    st.player.update_weapon_speed()
    st.player.calculate_spell_GCD_duration()
    st.player.on_player_aura_change()
    st.player.update_lag()

    -- Some settings that have to be set after the bar is initialised
    st.bar.update_visuals_on_update()
    st.bar.set_bar_color()
    st.bar.set_gcd_bar_width()
    st.bar.set_bar_color()
    st.bar.show_or_hide_bar()

    -- If appropriate show welcome message
    if st.debug then print('... complete!') end
    if ST.db.profile.welcome_message then print(load_message) end
end

-- The frame responsible for loading the addon at the appropriate time
st.core.init_frame = CreateFrame("Frame", addon_name .. "InitFrame", UIParent)
local function init_frame_event_handler(self, event, ...)
    local args = {...}
    if event == "ADDON_LOADED" then
        if args[1] == "SwedgeTimer" then

            -- Only load the addon if the player is a paladin
            if not st.utils.player_is_paladin() then
                st.core.init_frame:SetScript("OnEvent", nil)
                return
            end
        
            -- else, load it
            init_addon()

            -- Now we've loaded, remove the handler from the frame to stop it 
            -- processing events
            st.core.init_frame:SetScript("OnEvent", nil)
        end
    end
end

st.core.init_frame:SetScript("OnEvent", init_frame_event_handler)
st.core.init_frame:RegisterEvent("ADDON_LOADED")

--=========================================================================================
-- End, if debug verify module was read.
--=========================================================================================
if st.debug then print('-- Parsed main.lua module correctly') end
