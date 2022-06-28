local addon_name, st = ...
local print = st.utils.print_msg
local tolerance = st.utils.test_tolerance
local floor = st.utils.simple_round
local ST = LibStub("AceAddon-3.0"):GetAddon("SwedgeTimer")

--=========================================================================================
-- PLAYER SETTINGS 
--=========================================================================================
st.player = {}

st.player.swing_timer = 0.00001
st.player.prev_weapon_speed = 0.1
st.player.current_weapon_speed = 4.0
st.player.speed_changed = false
st.player.extra_attacks_flag = false

-- Flag for when we update equipment without double counting the reset
-- from any gear-related aura change triggers.
st.player.equipment_update_flag = false

-- Flag to detect when to reset the timer from the player mounting up.
st.player.is_mounted = false

-- containers for seal information
st.player.n_active_seals = 0
st.player.active_seals = {}
st.player.active_seal_1 = nil
st.player.active_seal_1_remaining = 0
st.player.active_seal_2 = nil
st.player.active_seal_2_remaining = 0

-- A flag for when lag is likely to 
st.player.twist_impossible = false

-- does the player have heroism/lust buff active
st.player.has_bloodlust = false

-- does the player have KJ breath buff
st.player.has_breath_haste = false

-- judgement information
st.player.new_judgement_cast = false
st.player.judgement_being_tracked = false
st.player.judgement_on_cooldown = false
st.player.judgement_cd_remaining = 0.0

-- containers for GCD information
st.player.active_gcd_full_duration = 0.0 -- length of the currently active GCD
st.player.active_gcd_remaining = 0.0 -- timer on currently active GCD.
st.reported_gcd_lockout = true
st.player.gcd_lockout = false -- lock for when we have an active GCD ticking
st.player.spell_gcd_duration = 1.5
st.player.base_gcd_duration = 1.5 -- should never change, use this for CS

-- counter for periodic repolls
st.player.periodic_repoll_counter = 0.0

-- flag to run a double poll after 0.1s on aura change to catch bad API calls
st.player.aura_repoll_counter = 0.0
st.player.repoll_on_aura_change = true

-- a flag to ensure the code on swing completion only runs once
st.player.reported_swing_timer_complete = false
st.player.reported_swing_timer_complete_double = false
st.player.time_since_swing_completion = 0.0

-- container for the last guid we picked up being cast by the player
st.player.currently_casting_spell_guid = nil

-- a flag to ensure the code on speed change only runs once per change
st.player.reported_speed_change = true

-- Flags to detect if we have a new/falling off SotCr aura and need to change swing
-- timers to account for haste snapshotting
st.crusader_currently_active = false
st.player.new_crusader_midswing = false
st.player.crusader_fell_off_midswing = false
st.increased_first = false
st.dealt_with_stupid_edgecase = false

-- The points in two-handed weapon specialisation
st.player.twohand_spec_points = 0

-- A measure of the player's ping
st.player.lag_world_ms = 0.0
st.player.lag_calibrated_ms = 0.0

-- Some timestamp containers used to determine when cast times get interrupted
st.player.last_spell_update_timestamp = nil
st.player.tracked_spell_cast_start_timestamp = nil
st.player.swing_complete_timestamp = nil

-- a flag to indicate if the player is currently in the "attacking" state
-- from either using the manual "attack" spell 6603 or from executing 
-- startattack/stopattack.
st.player.is_attacking = false

-- Updates the player's lag according to the specified calibration.
st.player.update_lag = function()
    local db = ST.db.profile
    local lag = select(4, GetNetStats())
    st.player.lag_world_ms = lag
    -- print('lag before calibration: ' .. tostring(lag))
    -- print('lag multiplier: ' .. tostring(db.lag_multiplier))
    -- print('lag offset: ' .. tostring(db.lag_offset))
    lag = (lag * db.lag_multiplier) + db.lag_offset
    -- print('lag after calibration: ' .. tostring(lag))
    st.player.lag_calibrated_ms = lag
end

st.player.lag_detection_enabled = function()
    local db = ST.db.profile
    return db.lag_detection_enabled
end

st.player.get_twohand_spec_points = function()
    st.player.twohand_spec_points = select(5,GetTalentInfo(3, 13))
    -- print("points in 2h spec = "..tostring(st.player.twohand_spec_points))
end

-- Returns true if any points in 2h weapon spec
st.player.is_player_ret = function()
    if st.player.twohand_spec_points > 0 then
        return true
    end
    return false
end

-- Called when the swing timer reaches zero
st.player.swing_timer_complete = function()
    -- clear SotC flags
    st.player.crusader_fell_off_midswing = false
    st.player.new_crusader_midswing = false
    st.increased_first = false
    st.dealt_with_stupid_edgecase = false

    -- print('Swing timer complete.')
    st.player.update_weapon_speed()
    st.bar.update_bar_on_timer_full()
end

-- Called when the swing timer should be reset
st.player.reset_swing_timer = function()

    -- clear SotC flags
    st.player.crusader_fell_off_midswing = false
    st.player.new_crusader_midswing = false
    st.increased_first = false
    st.dealt_with_stupid_edgecase = false


    st.player.twist_impossible = false
    -- st.player.update_weapon_speed() -- NOT SURE IF THIS IS NEEDED
    st.player.swing_timer = st.player.current_weapon_speed
    -- print('releasing double timer check')
    st.player.reported_swing_timer_complete = false
    st.bar.update_bar_on_swing_reset()
end

-- called onupdate to manually alter the swing timer with the elapsed time
st.player.update_swing_timer = function(elapsed)
    if true then
        if st.player.swing_timer > 0 then
            st.player.swing_timer = st.player.swing_timer - elapsed
            if st.player.swing_timer < 0 then
                st.player.swing_timer = 0
            end
        end
    end
end

-- called onupdate to manually alter the active GCD remaining time_before_swing
st.player.update_active_gcd_timer = function(elapsed)
    if st.player.active_gcd_remaining > 0 then
        st.player.active_gcd_remaining = st.player.active_gcd_remaining - elapsed
        if st.player.active_gcd_remaining < 0 then
            st.player.active_gcd_remaining = 0
        end
    end
end 

--=========================================================================================
-- Functions run when relevant events are intercepted
--=========================================================================================

st.player.update_weapon_speed = function()
    -- Function called whenever it is possible that the attack speed has changed.
    -- We use the reported_speed_change flag to ensure that this logic happens
    -- exactly once during a player frame update, because multiple events can
    -- happen between the same update, and the logic to process speed changes
    -- is most efficiently handled in the onupdate.

    local old = st.player.current_weapon_speed
    local new = UnitAttackSpeed("player")
    -- print('API speed says: ' .. tostring(new))

    -- Handle crusader snapshotting *before* we compare old and new speeds
    -- apply a 1.4 speed multiplier until the next swing
    -- but only if the speed has actually changed - if it hasn't
    -- then the UnitAttackSpeed endpoint might be lagging, and we don't
    -- want to double count the increase or reduction.

    -- SotC has ONLY become active this swing, not fallen off
    if st.player.new_crusader_midswing and not st.player.crusader_fell_off_midswing then
        if not tolerance(new, old, 0.004) then
            st.increased_first = true -- need to record this
            new = new * 1.4
        end
    -- SotC has ONLY fallen off this swing, not become active
    elseif st.player.crusader_fell_off_midswing and not st.player.new_crusader_midswing then
        if not tolerance(new, old, 0.004) then
            new = new / 1.4
        end
    -- SotC became active then fell off, things can misbehave here!
    -- (seems fine when it falls off then is reactivated)
    elseif st.player.new_crusader_midswing and st.increased_first then
        -- if they are not the same, apply the correction,
        if not tolerance(new, old, 0.004) then           
            -- BUT ONLY if we haven't flagged that the API has registered
            -- the change due to SotC falling off again.
            if not st.dealt_with_stupid_edgecase then
                new = new * 1.4
            end
        -- if they are substantially different, this is very likely due to the game
        -- registering the attack speed change from crusader falling off. So enable
        -- a flag that now prevents the correction from being re-applied if another
        -- genuine haste effect changes state, like a dst proc.
        else
            st.dealt_with_stupid_edgecase = true
        end
    end

    -- print('API speed after correction says: ' .. tostring(new))
    if not st.player.reported_speed_change then 
        -- check the speed isn't the same, and if it is, return 
        -- this check picks up on multiple events between updates
        -- that can trigger attack speed changes
        if tolerance(new, old, 0.004) then return end
    end
    
    -- Handle when the API sometimes returns 0, especially on first 
    -- load of the client.
    -- Not perfect but it prevents infinities appearing in calculations.
    if new == 0 then
        new = 3.0
    end

    -- Update the attack speed and mark if it has changed.
    st.player.prev_weapon_speed = old
    st.player.current_weapon_speed = new   
    if st.player.current_weapon_speed ~= st.player.prev_weapon_speed then
        st.player.speed_changed = true
        st.player.reported_speed_change = false
    else
        st.player.speed_changed = false
    end

end

-- Function to return a bool indicating if we're in a seal we can twist from.
st.player.is_twist_seal_active = function()
    if st.player.active_seals["command"] ~= nil or st.player.active_seals["righteousness"] ~= nil then
        return true
    else
        return false
    end
end

-- Function run when we intercept an event indicating the player's equipment has changed.
st.player.on_equipment_change = function()
    local new_guid = GetInventoryItemID("player", 16)
    -- Check for a main hand weapon change
    if st.player.weapon_id ~= new_guid then
        st.player.equipment_update_flag = true
        st.player.update_weapon_speed()
        st.player.reset_swing_timer()
        st.player.weapon_id = new_guid

        -- if we're also in combat, trigger a GCD
        if st.core.in_combat then
            -- st.player.force_gcd_repoll()
            st.player.process_possible_spell_cooldown(true)
        end
    end
end

-- Function run when we intercept an unfiltered combatlog event.
st.player.OnCombatLogUnfiltered = function(combat_info)
	local _, event, _, source_guid, _, _, _, dest_guid, _, _, _, _, _, _ = unpack(combat_info)

    -- Handle all relevant events where the player is the action source
    if (source_guid == st.player.guid) then

	-- Check for extra attacks that would accidently reset the swing timer.
    -- If we find any, set a flag that lets the code know to expect two attack events to come 
    -- through later, and that we should ignore the first of these.
		if (event == "SPELL_EXTRA_ATTACKS") then
			st.player.extra_attacks_flag = true
		end
        if (event == "SWING_DAMAGE") then
			if (st.player.extra_attacks_flag == false) then
				st.player.reset_swing_timer()
			end
			st.player.extra_attacks_flag = false
        elseif (event == "SWING_MISSED") then
            if (st.player.extra_attacks_flag == false) then
			    st.player.reset_swing_timer()
            end
            st.player.extra_attacks_flag = false
        end
    -- Handle all relevant events where the player is the target
    elseif (dest_guid == st.player.guid) then
        if (event == "SWING_MISSED") then
            local miss_type = select(12, unpack(combat_info))
            if miss_type == "PARRY" then
                -- parry reduces your swing timer by 40%, but cannot go below 20%.
                local swing_timer_reduced_40p = st.player.swing_timer - (0.4 * st.player.current_weapon_speed)
                local min_swing_time = st.player.current_weapon_speed * 0.2             
                if swing_timer_reduced_40p < min_swing_time then
                    st.player.swing_timer = min_swing_time
                else
                    st.player.swing_timer = swing_timer_reduced_40p
                end
                -- once the swing timer is updated, alter the bar as necessary
                if st.player.gcd_lockout then
                    st.bar.update_bar_on_parry()      
                end
            end
        end
    end
end

-- Function to calculate the player's GCD duration of a standard spell
-- takes into account spell haste, and multiplicative buffs like
-- bloodlust and breath buff
st.player.calculate_spell_GCD_duration = function()
    local rating_percent_reduction = GetCombatRatingBonus(20)
    local base = st.player.base_gcd_duration
    local current = base * (100 / (100+rating_percent_reduction))
    
    -- Check for multiplicative buffs
    if st.player.has_bloodlust then
        current = current * (1/1.3)
    end
    if st.player.has_breath_haste then
        current = current * (1/1.25)
    end
	
	-- get FoL speed, should normally equivalent to GCD unless some debuff
	local spellFoL = 19750
	local _, _, _, timeFoL, _,  _, _ = GetSpellInfo(spellFoL)
	timeFoL = timeFoL or 1500
	timeFoL = timeFoL / 1000
	
	-- get the minimum of 2 logics
	current = math.min(current, timeFoL)

    -- minimum GCD for paladins in 1s
    if current < 1 then
        current = 1.0
    end
	
    -- round to 3 decimal places
    current = floor(current, 0.001)
    st.player.spell_gcd_duration = current
    -- print('current spell GCD: ' .. current)
    return current
end

-- Simple func to match a seal label.
st.player.match_seal = function(seal_label)
    if st.player.active_seals[seal_label] ~= nil then
        return true
    end
    return false
    
end

-- Function to iterate over the player's auras and record any active Seals.
st.player.parse_auras = function()
    
    -- copy the previous seals
    st.player.previous_active_seals = st.player.active_seals

    -- reset the player's state
    st.player.n_active_seals = 0
    st.player.has_bloodlust = false
    st.player.has_breath_haste = false
    st.player.active_seals = {}

    -- iterate over the current player auras and process seals
    -- and other buffs of interest
    local counter = 1
    while true do
        local name, _, _, _, _, _, _, _, _, spell_id = UnitAura("player", counter)
        if name == nil then
            break
        end

        -- First cross check seals
        if st.data.sob_ids[spell_id] ~= nil then
            st.player.active_seals['blood'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.soc_ids[spell_id] ~= nil then
            st.player.active_seals['command'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.sotc_ids[spell_id] ~= nil then
            st.player.active_seals['crusader'] = true
            st.player.crusader_currently_active = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.sor_ids[spell_id] ~= nil then
            st.player.active_seals['righteousness'] = true         
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.sow_ids[spell_id] ~= nil then
            st.player.active_seals['wisdom'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.sol_ids[spell_id] ~= nil then
            st.player.active_seals['light'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.soj_ids[spell_id] ~= nil then
            st.player.active_seals['justice'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1

        elseif st.data.sov_ids[spell_id] ~= nil then
            st.player.active_seals['vengeance'] = true
            st.player.n_active_seals = st.player.n_active_seals + 1       

        -- Catch bloodlust or heroism
        elseif spell_id == 2825 or spell_id == 32182 then
            st.player.has_bloodlust = true       

        -- Catch KJ breath buff
        elseif spell_id == 45856 then
            st.player.has_breath_haste = true           
        end
        counter = counter + 1
    end
end

-- Function to parse the list of Seals and set flags etc.
st.player.process_auras = function()
    -- Check if crusader currently active.
    if st.player.active_seals["crusader"] == nil then
        st.player.crusader_currently_active = false
    end
    -- check for any new crusader casts
    if st.player.crusader_currently_active then
        if st.player.previous_active_seals["crusader"] == nil then
            -- if we're also midway through a swing, need some additional logic 
            -- to handle the haste snapshotting
            if st.player.swing_timer > 0 then
                -- print('enabling crusader lock, new SotC cast midswing')
                st.player.new_crusader_midswing = true
            end
        end
    -- check for any crusader that's fallen off midswing
    elseif st.player.previous_active_seals["crusader"] then
        if st.player.swing_timer > 0 then
            -- print('enabling crusader lock, old SotC fell off midswing')
            st.player.crusader_fell_off_midswing = true
        end
    end
end



-- There is no information in the event payload on what changed, so we have to rescan auras
-- on the player.
st.player.on_player_aura_change = function()

    -- Function that parses the auras to record seals.
    st.player.parse_auras()

    -- Function that processes the above.
    st.player.process_auras()

    -- print(st.player.active_seals)
    -- print(st.player.n_active_seals)
    st.player.calculate_spell_GCD_duration()
    st.player.update_weapon_speed()
    st.player.check_impossible_twists()
    st.bar.update_bar_on_aura_change()
    
end

-- Function to detect any spell casts like repentance that would reset
-- the swing timer. GCD tracking handled elsewhere by other event triggers.
st.player.OnPlayerSpellCast = function(args)
    -- print('detected spell cast')
    -- only process player casts
    if not args[1] == "player" then
        return
    end
   
    local spell_id = args[4] -- universal for a given spell type
    local spell_guid = args[3] -- completely unique 

    -- Detect judgements and track the cooldown
    if spell_id == 20271 then
        st.player.new_judgement_cast = true
    end

    -- Detect casts that reset the timer on cast
    if st.data.reset_on_cast_spell_ids[spell_id] ~= nil then
        st.player.reset_swing_timer()

    -- Detect casts that reset the timer on completion and log
    -- the spell guid to check it against any completing spells.
    elseif st.data.reset_on_completion_spell_ids[spell_id] ~= nil then
        st.player.currently_casting_spell_guid = spell_guid
    end

end

-- function to detect the player's successful casts that reset the 
-- swing timer
st.player.OnPlayerSpellCompletion = function(args)
    -- print('Spell completed')
    if args[2] == st.player.currently_casting_spell_guid then
        -- print('detected a finished cast that resets the timer')
        st.player.reset_swing_timer()
    end

    local spell_id = args[3]
    -- if this is the "attack" spell id 6603, switch the attack state
    if spell_id == 6603 then
        st.player.is_attacking = not st.player.is_attacking
        -- print('player is attacking = '..tostring(st.player.is_attacking))
    end
    -- also clear the last spell cast timestamp
    st.player.tracked_spell_cast_start_timestamp = nil

end

-- Called when the player's spellcast is interrupt to reset the gcd.
st.player.on_spell_interrupt = function()
    st.player.active_gcd_remaining = 0
    st.player.gcd_lockout = false
    st.bar.hide_gcd_bar()

    -- also check if we need to add time to the swing timer under
    -- certain circumstances
    if st.player.swing_timer == 0 and st.player.is_attacking then
        if st.player.tracked_spell_cast_start_timestamp ~= nil then
            local time_now = GetTime()
            local deduction = time_now - st.player.swing_complete_timestamp
            local new_swing_timer = st.player.current_weapon_speed - deduction
            -- print('new swing timer says '..tostring(new_swing_timer))
            st.player.reset_swing_timer()
            st.player.swing_timer = new_swing_timer
        end
    end

    st.player.tracked_spell_cast_start_timestamp = nil

end

-- Function to check for impossible twists and set the according flag
st.player.check_impossible_twists = function()
    
    local db = ST.db.profile
    -- if setting is disabled just return
    if not db.lag_detection_enabled then
        return
    end

    local gcd_with_lag = st.player.active_gcd_remaining + (st.player.lag_calibrated_ms * 0.001)
    local time_since_previous_swing = st.player.current_weapon_speed - st.player.swing_timer
    local gcd_ends_relative_to_swing = time_since_previous_swing + gcd_with_lag
    -- local gcd_ends_relative_to_swing = time_since_previous_swing + gcd_with_lag
    -- print('GCD + lag ends relative to swing: ' .. tostring(gcd_ends_relative_to_swing))
    -- print('Current attack speed: ' .. tostring(st.player.current_weapon_speed))
    -- print('Lag after calibration: ' .. tostring(st.player.lag_calibrated_ms))
    
    if gcd_ends_relative_to_swing > st.player.current_weapon_speed then
        if st.player.swing_timer > st.bar.get_twist_window_time_before_swing() then
            -- print('SHIT SON WE COULD BE MISSING THIS TWIST')
            st.player.twist_impossible = true
        else
            st.player.twist_impossible = false
        end
    end
end

-- Called when we receive the SPELL_UPDATE_COOLDOWN event
st.player.process_possible_spell_cooldown = function(force_flag)
    -- first check if we're on gcd lockout
    if st.player.gcd_lockout and not force_flag then
        -- print('on gcd lockout already, ignoring')
        return
    end

    local time_started, duration = GetSpellCooldown(29515)
    -- print('detected GCD going off, setting internally: ' .. tostring(duration))
    if duration == 0 then
        -- print('SPELL_UPDATE_COOLDOWN with no GCD duration')
        return
    end

    local time_now = GetTime()
    local calced_duration_remaining = duration - (time_now - time_started)
    -- print(time_now - time_started)
    -- print('time_now says:' .. tostring(time_now))
    -- print('time_started says: ' .. tostring(time_started))
    -- print('duration says: ' .. tostring(duration))
    -- print('calculated duration remaining:' .. tostring(calced_duration_remaining))

    st.player.gcd_lockout = true
    st.reported_gcd_lockout = false
    st.player.active_gcd_full_duration = duration
    st.player.active_gcd_remaining = calced_duration_remaining

    -- Figure out if we're lagging
    st.player.update_lag()

    -- Check for impossible twists
    st.player.check_impossible_twists()   
end

st.player.process_gcd_end = function()
    -- print('reached end of GCD, releasing lock')
    st.player.active_gcd_remaining = 0
    st.player.gcd_lockout = false
    st.bar.hide_gcd_bar() -- i almost don't like this being here
end


-- Called on spell update cooldown 
st.player.on_spell_update_cooldown = function()
    st.player.last_spell_update_timestamp = GetTime()
end

-- If the swing timer is not zero, we need to track the timestamp of the last
-- SPELL_UPDATE_COOLDOWN event, which might need to be used in setting the swing timer
st.player.on_spell_cast_start = function()
    if st.player.swing_timer > 0 then
        st.player.tracked_spell_cast_start_timestamp = st.player.last_spell_update_timestamp
        -- print(st.player.tracked_spell_cast_start_timestamp)
    end
end

st.player.process_new_judgment_cd = function()
    -- called each frame after judgement is registered until the API
    -- updates with the proper cooldown information
    
    -- print('checking judgement cast')
    st.player.judgement_on_cooldown = true
    local start_time, duration = GetSpellCooldown(20271)
    -- print(start_time)
    -- print(duration)
    
    if duration ~= 0 then
        -- print('detected cooldown info')
        -- manipulate flags
        st.player.new_judgement_cast = false
        st.player.judgement_being_tracked = true
        
        -- calc the duration
        local time_now = GetTime()
        local calced_duration_remaining = duration - (time_now - start_time)
        -- print(calced_duration_remaining)
        st.player.judgement_cd_remaining = calced_duration_remaining
    end
end

-- CALLED EVERY FRAME
st.player.frame_on_update = function(self, elapsed)
    
    -- print('elapsed says')
    -- print(elapsed)

    -- Logic for when the swing timer is complete.
    if st.player.swing_timer == 0 and not st.player.reported_swing_timer_complete then
        st.player.swing_complete_timestamp = GetTime()
        st.player.swing_timer_complete()
        st.bar.update_bar_on_timer_full()
        st.player.reported_swing_timer_complete = true
        st.player.twist_impossible = false
        st.player.reported_swing_timer_complete_double = false
        st.player.time_since_swing_completion = 0
    end

    -- -- At the latest, repoll the attack speed every 0.1s
    if st.player.periodic_repoll_counter > 0.1 then
        st.player.update_weapon_speed()
        st.player.periodic_repoll_counter = 0.0
    else
        st.player.periodic_repoll_counter = st.player.periodic_repoll_counter + elapsed
    end

    -- If there is a GCD lock, check if we should clear it.
    if st.player.gcd_lockout then
        st.player.update_active_gcd_timer(elapsed)
        if st.player.active_gcd_remaining == 0 then
            st.player.process_gcd_end()
        end
    end

    -- If the weapon speed changed due to buffs/debuffs, we need to modify the swing timer
    -- and inform all the UI elements that need things altered or recalculated.   
    if st.player.speed_changed and not st.player.reported_speed_change then
        -- st.player.check_impossible_twists()
        -- print('swing speed changed, timer updating')
        -- print(tostring(st.player.prev_weapon_speed) .. " > " .. tostring(st.player.current_weapon_speed))        

        -- Modify swing timer but only if we don't have the equipment flag set because the timer is already reset
        if not st.player.equipment_update_flag then
            local multiplier = st.player.current_weapon_speed / st.player.prev_weapon_speed
            -- print('multiplier: ' .. tostring(multiplier))
            -- print('swing timer before multiplier: ' .. tostring(st.player.swing_timer))
            st.player.swing_timer = st.player.swing_timer * multiplier
            -- print('swing timer after multiplier: ' .. tostring(st.player.swing_timer))
            -- print(st.player.swing_timer)
            -- print('swing timer after update func and elapsed: ' .. tostring(st.player.swing_timer))            
        else
            -- print('intercepting redundant speed change from equipment change')
            st.player.equipment_update_flag = false
        end            
        -- recalculate any necessary bar visuals
        st.bar.update_bar_on_speed_change()
        -- flag so this only runs once on speed change
        st.player.reported_speed_change = true
    end

    if st.player.gcd_lockout and not st.reported_gcd_lockout then
        st.bar.update_bar_on_new_gcd()
        st.reported_gcd_lockout = true
    end 

    -- Track any judgement cooldowns
    if st.player.new_judgement_cast then
        st.player.process_new_judgment_cd()
    end

    if st.player.judgement_being_tracked then
        st.player.judgement_cd_remaining = st.player.judgement_cd_remaining - elapsed
        if st.player.judgement_cd_remaining <= 0 then
            -- print('judgement off cd!')
            st.player.judgement_being_tracked = false
            st.bar.frame.judgement_line:Hide()
        end
    end

    -- Always update the swing timer with how much time has elapsed
    st.player.update_swing_timer(elapsed)

    if st.player.speed_changed then
        st.player.check_impossible_twists()
    end


    -- Always update the bar visuals
    st.bar.update_visuals_on_update()

end

--=========================================================================================
-- Create a frame to process events relating to player information.
--=========================================================================================
-- This function handles events related to the player's statistics
st.player.frame_on_event = function(self, event, ...)
	local args = {...}
    if event == "UNIT_INVENTORY_CHANGED" then
        -- print('INVENTORY CHANGE DETECTED')
        st.player.on_equipment_change()

    elseif event == "PLAYER_MOUNT_DISPLAY_CHANGED" then
        if IsMounted() then
            st.player.reset_swing_timer()
        end

    -- Check talent point changes.
    elseif event == "CHARACTER_POINTS_CHANGED" then
        st.player.get_twohand_spec_points()

    elseif event == "UNIT_SPELLCAST_SENT" then
        -- print('INFO: received spellcast trigger')
        st.player.OnPlayerSpellCast(args)        

    elseif event == "COMBAT_LOG_EVENT_UNFILTERED" then
        local combat_info = {CombatLogGetCurrentEventInfo()}
        st.player.OnCombatLogUnfiltered(combat_info)
    
    elseif event == "UNIT_AURA" then
        -- print('processing aura change')
        st.player.on_player_aura_change()
    
    elseif event == "UNIT_SPELLCAST_SUCCEEDED" then
        st.player.OnPlayerSpellCompletion(args)

    elseif event == "UNIT_SPELLCAST_INTERRUPTED" then
        -- print('found an interruption')
        st.player.on_spell_interrupt()
        st.player.process_gcd_end()

    elseif event == "UNIT_SPELLCAST_START" then
        st.player.on_spell_cast_start()

    elseif event == "SPELL_UPDATE_COOLDOWN" then
        -- print('spell update cd triggering a GCD')
        st.player.on_spell_update_cooldown()
        st.player.process_possible_spell_cooldown(false)
    
    elseif event == "EXECUTE_CHAT_LINE" then
        -- If the command is stopattack or startattack, change attacking state
        if args[1] == "/stopattack" then
            st.player.is_attacking = false
            -- print('player is attacking = '..tostring(st.player.is_attacking))
        elseif args[1] == "/startattack" then
            st.player.is_attacking = true  
            -- print('player is attacking = '..tostring(st.player.is_attacking))
        end        
    
    elseif event == "PLAYER_TARGET_SET_ATTACKING" then
        st.player.is_attacking = true
    end

end

-- Finally make the playerframe to house the logic.
st.player_frame = CreateFrame("Frame", addon_name .. "PlayerFrame", UIParent)

--=========================================================================================
-- End, if debug verify module was read.
--=========================================================================================
if st.debug then print('-- Parsed player.lua module correctly') end
