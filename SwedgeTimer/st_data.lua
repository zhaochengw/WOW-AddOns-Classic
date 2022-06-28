local _, st = ...
local print = st.utils.print_msg
local get_tab = st.utils.convert_lookup_table
st.data = {}

--=========================================================================================
-- Seal IDs
--=========================================================================================
-- blood/the Martyr
local sob_ids = {
    31892, 348700
}
st.data.sob_ids = get_tab(sob_ids)

-- command
local soc_ids = {
    20375, 20915, 20918, 20919, 20920, 27170
}
st.data.soc_ids = get_tab(soc_ids)

-- righteousness
local sor_ids = {
    20154, 20287, 20288, 20289, 20290, 20291, 20292, 20293, 27155
}
st.data.sor_ids = get_tab(sor_ids)

-- crusader
local sotc_ids = {
    21082, 20162, 20305, 20306, 20307, 20308, 27158
}
st.data.sotc_ids = get_tab(sotc_ids)

-- justice
local soj_ids = {
    20164, 31895
}
st.data.soj_ids = get_tab(soj_ids)

-- wisdom
local sow_ids = {
    20166, 20356, 20357, 27166
}
st.data.sow_ids = get_tab(sow_ids)

-- light
local sol_ids = {
    20165, 20347, 20348, 20349, 27160
}
st.data.sol_ids = get_tab(sol_ids)

-- vengeance/corruption
local sov_ids = {
    31801, 348704
}
st.data.sov_ids = get_tab(sov_ids)

--=========================================================================================
-- Finite cast time spell IDs that reset the swing timer.
--=========================================================================================
local cast_time_spells = {
    -- Flash of Light
    19750, 19939, 19940, 19941, 19942, 19943, 27137,
    -- Holy Light
    635, 639, 647, 1026, 1042, 3472, 10328, 10329, 25292, 27135, 27136,
    -- Avenger's Shield
    31935, 32699, 32700,
    -- Holy Wrath
    2812, 10318, 27139,
    -- Hammer of Wrath
    24275, 24274, 24239, 27180,
    -- Turn Evil
    10326,
    -- Turn Undead
    2878, 5627,
    -- Redemption
    7328, 10322, 10324, 20772, 20773
}
st.data.reset_on_completion_spell_ids = get_tab(cast_time_spells)

--=========================================================================================
-- Instant cast spell IDs that reset the swing timer.
--=========================================================================================
local instant_cast_spells = {
    -- Repentence
    20066,
}
st.data.reset_on_cast_spell_ids = get_tab(instant_cast_spells)

--=========================================================================================
-- End, if debug verify module was read.
--=========================================================================================
if st.debug then print('-- Parsed st_data.lua module correctly') end
