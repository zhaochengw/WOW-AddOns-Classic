local media = LibStub("LibSharedMedia-3.0")

--Event and Damage option values
SCT.LOCALS.OPTION_EVENT1 = {name = "Damage", tooltipText = "Enables or Disables melee and misc. (fire, fall, etc...) damage"};
SCT.LOCALS.OPTION_EVENT2 = {name = "Misses", tooltipText = "Enables or Disables melee misses"};
SCT.LOCALS.OPTION_EVENT3 = {name = "Dodges", tooltipText = "Enables or Disables melee dodges"};
SCT.LOCALS.OPTION_EVENT4 = {name = "Parries", tooltipText = "Enables or Disables melee parries"};
SCT.LOCALS.OPTION_EVENT5 = {name = "Blocks", tooltipText = "Enables or Disables melee blocks and partial blocks"};
SCT.LOCALS.OPTION_EVENT6 = {name = "Spells", tooltipText = "Enables or Disables spell damage"};
SCT.LOCALS.OPTION_EVENT7 = {name = "Heals", tooltipText = "Enables or Disables spell heals"};
SCT.LOCALS.OPTION_EVENT8 = {name = "Resists", tooltipText = "Enables or Disables spell resists"};
SCT.LOCALS.OPTION_EVENT9 = {name = "Debuffs", tooltipText = "Enables or Disables showing when you get debuffs"};
SCT.LOCALS.OPTION_EVENT10 = {name = "Absorb/Misc", tooltipText = "Enables or Disables showing when damage is absorbed, reflected, immune, etc..."};
SCT.LOCALS.OPTION_EVENT11 = {name = "Low HP", tooltipText = "Enables or Disables showing when you have low health"};
SCT.LOCALS.OPTION_EVENT12 = {name = "Low Mana", tooltipText = "Enables or Disables showing when you have low mana"};
SCT.LOCALS.OPTION_EVENT13 = {name = "Power Gains", tooltipText = "Enables or Disables showing when you gain Mana, Rage, Energy from potions, items, buffs, etc...(Not regular regen)"};
SCT.LOCALS.OPTION_EVENT14 = {name = "Combat Flags", tooltipText = "Enables or Disables showing when you enter or leave combat"};
SCT.LOCALS.OPTION_EVENT15 = {name = "Combo Points", tooltipText = "Enables or Disables showing when you gain combo points"};
SCT.LOCALS.OPTION_EVENT16 = {name = "Honor Gain", tooltipText = "Enables or Disables showing when you gain Honor Contribution points"};
SCT.LOCALS.OPTION_EVENT17 = {name = "Buffs", tooltipText = "Enables or Disables showing when you gain buffs"};
SCT.LOCALS.OPTION_EVENT18 = {name = "Aura Fades", tooltipText = "Enables or Disables showing when you lose buffs or debuffs. Uses the color of Buff or Debuff."};
SCT.LOCALS.OPTION_EVENT19 = {name = "Active Skills", tooltipText = "Enables or Disables alerting when a skill becomes active (Execute, Mongoose Bite, Hammer of Wrath, etc...)"};
SCT.LOCALS.OPTION_EVENT20 = {name = "Reputation", tooltipText = "Enables or Disables showing when you gain or lose Reputation"};
SCT.LOCALS.OPTION_EVENT21 = {name = "Your Heals", tooltipText = "Enables or Disables showing how much you heal others for"};
SCT.LOCALS.OPTION_EVENT22 = {name = "Skills", tooltipText = "Enables or Disables showing when you gain Skill points"};
SCT.LOCALS.OPTION_EVENT23 = {name = "Killing Blows", tooltipText = "Enables or Disables showing when you get a killing blow"};
SCT.LOCALS.OPTION_EVENT24 = {name = "Interrupts", tooltipText = "Enables or Disables showing when you are interrupted"};
SCT.LOCALS.OPTION_EVENT25 = {name = "Dispels", tooltipText = "Enables or Disables showing when you dispel something"};
SCT.LOCALS.OPTION_EVENT26 = {name = "Runes", tooltipText = "Enables or Disables showing when a Rune is ready"};
SCT.LOCALS.OPTION_EVENT27 = {name = "Cooldowns", tooltipText = "Enables or Disables showing when a Cooldown is finished"};

--Check Button option values
SCT.LOCALS.OPTION_CHECK1 = { name = "Enable SCT", tooltipText = "Enables or Disables the Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK2 = { name = "Flag Combat Text", tooltipText = "Enables or Disables placing a * around all Scrolling Combat Text"};
SCT.LOCALS.OPTION_CHECK3 = { name = "Healer Name", tooltipText = "Enables or Disables showing who or what heals you."};
SCT.LOCALS.OPTION_CHECK4 = { name = "Scroll Text Down", tooltipText = "Enables or Disables scrolling text downwards"};
SCT.LOCALS.OPTION_CHECK5 = { name = "Sticky Crits", tooltipText = "Enables or Disables having critical hits/heals stick above your head"};
SCT.LOCALS.OPTION_CHECK6 = { name = "Spell Damage Type", tooltipText = "Enables or Disables showing spell damage type"};
SCT.LOCALS.OPTION_CHECK7 = { name = "Apply Font to Damage", tooltipText = "Enables or Disables changing the in game damage font to match the font used for SCT Text.\n\nIMPORTANT: YOU MUST LOG OUT AND BACK IN FOR THIS TO TAKE EFFECT. RELOADING THE UI WON'T WORK"};
SCT.LOCALS.OPTION_CHECK8 = { name = "All Power Gain", tooltipText = "Enables or Disables showing all power gain, not just those from the chat log\n\nNOTE: This is dependent on the regular Power Gain event being on, is VERY SPAMMY, and sometimes acts strange for Druids just after shapeshifting back to caster form."};
SCT.LOCALS.OPTION_CHECK10 = { name = "Overhealing", tooltipText = "Enables or Disables showing how much you overheal for against you or your targets. Dependent on 'Your Heals' being on."};
SCT.LOCALS.OPTION_CHECK11 = { name = "Alert Sounds", tooltipText = "Enables or Disables playing sounds for warning alerts."};
SCT.LOCALS.OPTION_CHECK12 = { name = "Spell Colors", tooltipText = "Enables or Disables showing spell damage in colors per spell class"};
SCT.LOCALS.OPTION_CHECK13 = { name = "Enable Custom Events", tooltipText = "Enables or Disables using custom events. When disabled, much less memory is consumed by SCT."};
SCT.LOCALS.OPTION_CHECK14 = { name = "Spell/Skill Name", tooltipText = "Enables or Disables showing the name of the Spell or Skill that damaged you"};
SCT.LOCALS.OPTION_CHECK15 = { name = "Flash", tooltipText = "Makes sticky crits 'Flash' into view."};
SCT.LOCALS.OPTION_CHECK16 = { name = "Glancing/Crushing", tooltipText = "Enables or Disables showing Glancing ~150~ and Crushing ^150^ blows"};
SCT.LOCALS.OPTION_CHECK17 = { name = "Your HOT's", tooltipText = "Enables or Disables showing your healing over time spells cast on others. Note: this can be very spammy if you cast a lot of them."};
SCT.LOCALS.OPTION_CHECK18 = { name = "Heals at Nameplates", tooltipText = "Enables or Disables attempting to show your heals over the nameplate of the person(s) you heal.\n\nFriendly nameplates must be on, you must be able to see the nameplate, and it will not work 100% of the time. If it does not work, heals appear in the normal configured position.\n\nDisabling can require a reloadUI to take effect."};
SCT.LOCALS.OPTION_CHECK19 = { name = "Disable WoW Healing", tooltipText = "Enables or Disables showing the built in healing text, added in patch 2.1."};
SCT.LOCALS.OPTION_CHECK20 = { name = "Spell Icons", tooltipText = "Enables or Disables showing icons for spells and skills"};
SCT.LOCALS.OPTION_CHECK21 = { name = "Show Icon", tooltipText = "Enables showing the spell or skill icon for the custom event, if appropriate"};
SCT.LOCALS.OPTION_CHECK22 = { name = "Make Critical", tooltipText = "Enables making this event always appears as a critical"};
SCT.LOCALS.OPTION_CHECK23 = { name = "Critical", tooltipText = "The event must be a Critical to trigger"};
SCT.LOCALS.OPTION_CHECK24 = { name = "Resist", tooltipText = "The event must be a partial Resist to trigger"};
SCT.LOCALS.OPTION_CHECK25 = { name = "Block", tooltipText = "The event must be a partial Block to trigger"};
SCT.LOCALS.OPTION_CHECK26 = { name = "Absorb", tooltipText = "The event must be a partial Absorb to trigger"};
SCT.LOCALS.OPTION_CHECK27 = { name = "Glancing", tooltipText = "The event must be a Glancing hit to trigger"};
SCT.LOCALS.OPTION_CHECK28 = { name = "Crushing", tooltipText = "The event must be a Crushing hit to trigger"};
SCT.LOCALS.OPTION_CHECK29 = { name = "Self Only Debuffs", tooltipText = "If it is a Debuff gain, only trigger the event if the Debuff came from you. Only works for your target."};
SCT.LOCALS.OPTION_CHECK30 = { name = "Shorten Amounts", tooltipText = "Shorten all amounts over 1000 to appear like:\n1.2k instead of 1221\n650k instead of 650199\n3.7m instead of 3700321\nEtc..."};

--Slider options values
SCT.LOCALS.OPTION_SLIDER1 = { name="Text Animation Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed at which the text animation scrolls"};
SCT.LOCALS.OPTION_SLIDER2 = { name="Text Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the scrolling text"};
SCT.LOCALS.OPTION_SLIDER3 = { name="HP %", minText="10%", maxText="90%", tooltipText = "Controls the % of health needed to give a warning"};
SCT.LOCALS.OPTION_SLIDER4 = { name="Mana %",  minText="10%", maxText="90%", tooltipText = "Controls the % of mana needed to give a warning"};
SCT.LOCALS.OPTION_SLIDER5 = { name="Text Opacity", minText="0%", maxText="100%", tooltipText = "Controls the opacity of the text"};
SCT.LOCALS.OPTION_SLIDER6 = { name="Text Movement Distance", minText="Smaller", maxText="Larger", tooltipText = "Controls the movement distance of the text between each update"};
SCT.LOCALS.OPTION_SLIDER7 = { name="Text Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER8 = { name="Text Center Y Position", minText="-400", maxText="400", tooltipText = "Controls the placement of the text center"};
SCT.LOCALS.OPTION_SLIDER9 = { name="Message Center X Position", minText="-600", maxText="600", tooltipText = "Controls the placement of the message center"};
SCT.LOCALS.OPTION_SLIDER10 = { name="Message Center Y Position", minText="-400", maxText="400", tooltipText = "Controls the placement of the message center"};
SCT.LOCALS.OPTION_SLIDER11 = { name="Message Fade Speed", minText="Faster", maxText="Slower", tooltipText = "Controls the speed that messages fade"};
SCT.LOCALS.OPTION_SLIDER12 = { name="Message Size", minText="Smaller", maxText="Larger", tooltipText = "Controls the size of the message text"};
SCT.LOCALS.OPTION_SLIDER13 = { name="Healer Filter", minText="0", maxText="10000", tooltipText = "Controls the minimum amount a heal needs to heal you for to appear in SCT. Good for filtering out frequent small heals like Totems, Blessings, etc...\n\nNote: You can type ANY value next to the slider and hit enter if you like."};
SCT.LOCALS.OPTION_SLIDER14 = { name="Mana Filter", minText="0", maxText="10000", tooltipText = "Controls the minimum amount a power gain needs to be to appear in SCT. Good for filtering out frequent small power gains like Totems, Blessings, etc...\n\nNote: You can type ANY value next to the slider and hit enter if you like."};
SCT.LOCALS.OPTION_SLIDER15 = { name="HUD Gap Distance", minText="0", maxText="200", tooltipText = "Controls the distance from the center for the HUD animation. Useful when wanting to keep eveything centered but adjust the distance from center"};
SCT.LOCALS.OPTION_SLIDER16 = { name="Shorten Spell Size", minText="1", maxText="30", tooltipText = "Spell names over this length will be shortend using the selected shorten type."};
SCT.LOCALS.OPTION_SLIDER17 = { name="Damage Filter", minText="0", maxText="10000", tooltipText = "Controls the minimum amount damage needs to be to appear in SCT. Good for filtering out frequent small hits like Damage Shields, Small DOT's, etc...\n\nNote: You can type ANY value next to the slider and hit enter if you like."};
SCT.LOCALS.OPTION_SLIDER18 = { name="Aura Count", minText="0", maxText="20", tooltipText = "Number of buff or debuff count need to trigger the event. 0 means any amount"};
SCT.LOCALS.OPTION_SLIDER19 = { name="Cooldown Filter", minText="0", maxText="600", tooltipText = "Number of seconds need to trigger the event. 0 means any amount"};

--Spell Color options
SCT.LOCALS.OPTION_COLOR1 = { name=SPELL_SCHOOL0_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL0_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR2 = { name=SPELL_SCHOOL1_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL1_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR3 = { name=SPELL_SCHOOL2_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL2_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR4 = { name=SPELL_SCHOOL3_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL3_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR5 = { name=SPELL_SCHOOL4_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL4_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR6 = { name=SPELL_SCHOOL5_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL5_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR7 = { name=SPELL_SCHOOL6_CAP, tooltipText = "Controls the color for "..SPELL_SCHOOL6_CAP.." spells"};
SCT.LOCALS.OPTION_COLOR8 = { name="Event Color", tooltipText = "The color to use for this event."};

--Misc option values
SCT.LOCALS.OPTION_MISC1 = {name="SCT Options "..SCT.version, tooltipText = "Left Click to Drag"};
SCT.LOCALS.OPTION_MISC2 = {name="Close", tooltipText = "Close Spell Colors" };
SCT.LOCALS.OPTION_MISC3 = {name="Edit", tooltipText = "Edit Spell Colors" };
SCT.LOCALS.OPTION_MISC4 = {name="Misc. Options"};
SCT.LOCALS.OPTION_MISC5 = {name="Warning Options"};
SCT.LOCALS.OPTION_MISC6 = {name="Animation Options"};
SCT.LOCALS.OPTION_MISC7 = {name="Select Player Profile"};
SCT.LOCALS.OPTION_MISC8 = {name="Save & Close", tooltipText = "Saves all current settings and close the options"};
SCT.LOCALS.OPTION_MISC9 = {name="Reset", tooltipText = "-Warning-\n\nAre you sure you want to reset SCT to defaults?"};
SCT.LOCALS.OPTION_MISC10 = {name="Profiles", tooltipText = "Select another characters profile"};
SCT.LOCALS.OPTION_MISC11 = {name="Load", tooltipText = "Load another characters profile for this character"};
SCT.LOCALS.OPTION_MISC12 = {name="Delete", tooltipText = "Delete a characters profile"};
SCT.LOCALS.OPTION_MISC13 = {name="Text Options" };
SCT.LOCALS.OPTION_MISC14 = {name="Frame 1"};
SCT.LOCALS.OPTION_MISC15 = {name="Messages"};
SCT.LOCALS.OPTION_MISC16 = {name="Animation"};
SCT.LOCALS.OPTION_MISC17 = {name="Spell Options"};
SCT.LOCALS.OPTION_MISC18 = {name="Frames"};
SCT.LOCALS.OPTION_MISC19 = {name="Spells"};
SCT.LOCALS.OPTION_MISC20 = {name="Frame 2"};
SCT.LOCALS.OPTION_MISC21 = {name="Events"};
SCT.LOCALS.OPTION_MISC22 = {name="Classic Profile", tooltipText = "Load the Classic profile. Makes SCT act very close to how it used to by default"};
SCT.LOCALS.OPTION_MISC23 = {name="Performance Profile", tooltipText = "Load the Performance profile. Selects all the settings to get the best performance out of SCT"};
SCT.LOCALS.OPTION_MISC24 = {name="Split Profile", tooltipText = "Load the Split profile. Makes Incoming damage and events appear on the right side, and Incoming heals and buffs on the left side."};
SCT.LOCALS.OPTION_MISC25 = {name="Grayhoof Profile", tooltipText = "Load Grayhoof's profile. Sets SCT to act how Grayhoof sets his."};
SCT.LOCALS.OPTION_MISC26 = {name="Built In Profiles", tooltipText = ""};
SCT.LOCALS.OPTION_MISC27 = {name="Split SCTD Profile", tooltipText = "Load Split SCTD profile. If you have SCTD installed, makes Incoming events appear on the right side, and Outgoing events appear on the left side, and misc appear on top."};
SCT.LOCALS.OPTION_MISC28 = {name="Test", tooltipText = "Create Test event for each frame"};
SCT.LOCALS.OPTION_MISC29 = {name="Custom Events"};
SCT.LOCALS.OPTION_MISC30 = {name="Save Event", tooltipText = "Save the changes to this custom event."};
SCT.LOCALS.OPTION_MISC31 = {name="Delete Event", tooltipText = "Delete this custom event.", warning="-Warning-\n\nAre you sure you want to delete this event?"};
SCT.LOCALS.OPTION_MISC32 = {name="New Event", tooltipText = "Create a new custom event."};
SCT.LOCALS.OPTION_MISC33 = {name="Reset Events", tooltipText = "Reset all events to the defaults in sct_event_config.lua.", warning="-Warning-\n\nAre you sure you want to reset all SCT Custom Events to defaults?"};
SCT.LOCALS.OPTION_MISC34 = {name="Cancel", tooltipText = "Cancel any changes to this event"};
SCT.LOCALS.OPTION_MISC35 = {name="Classes", tooltipText = "Select Classes for this event", open="<", close=">"};
SCT.LOCALS.OPTION_MISC36 = {name="Cooldown Options"};

--Selections
SCT.LOCALS.OPTION_SELECTION1 = { name="Animation Type", tooltipText = "Which animation type to use", table = {[1] = "Vertical (Normal)",[2] = "Rainbow",[3] = "Horizontal",[4] = "Angled Down", [5] = "Angled Up", [6] = "Sprinkler", [7] = "HUD Curved", [8] = "HUD Angled"}};
SCT.LOCALS.OPTION_SELECTION2 = { name="Side Style", tooltipText = "How side scrolling text should display", table = {[1] = "Alternating",[2] = "Damage Left",[3] = "Damage Right", [4] = "All Left", [5] = "All Right"}};
SCT.LOCALS.OPTION_SELECTION3 = { name="Font", tooltipText = "What font to use", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION4 = { name="Font Outline", tooltipText = "What font outline to use", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT.LOCALS.OPTION_SELECTION5 = { name="Message Font", tooltipText = "What font to use for messages", table = media:List("font")};
SCT.LOCALS.OPTION_SELECTION6 = { name="Message Font Outline", tooltipText = "What font outline to use for messages", table = {[1] = "None",[2] = "Thin",[3] = "Thick"}};
SCT.LOCALS.OPTION_SELECTION7 = { name="Text Alignment", tooltipText = "How the text aligns itself. Most useful for vertical or HUD animations. HUD alignment will make left side right-aligned and right side left-aligned.", table = {[1] = "Left",[2] = "Center",[3] = "Right", [4] = "HUD Centered"}};
SCT.LOCALS.OPTION_SELECTION8 = { name="Shorten Spell Type", tooltipText = "How to shorten spell names.", table = {[1] = "Truncate",[2] = "Abbreviate"}};
SCT.LOCALS.OPTION_SELECTION9 = { name="Icon Alignment", tooltipText = "Which side of the text the icons appear on.", table = {[1] = "Left", [2] = "Right", [3] = "Inner", [4] = "Outer",}};
SCT.LOCALS.OPTION_SELECTION10 = { name="Cooldown", tooltipText = "Which type of cooldown list", table = {[1] = "Blacklist", [2] = "Whitelist",}};

local eventtypes = {
  ["BUFF"] = "Aura Gains",
  ["FADE"] = "Aura Fades",
  ["MISS"] = "Misses",
  ["HEAL"] = "Heals",
  ["DAMAGE"] = "Damage",
  ["DEATH"] = "Death",
  ["INTERRUPT"] = "Interrupts",
  ["POWER"] = "Power",
  ["SUMMON"] = "Summon",
  ["DISPEL"] = "Dispel",
  ["CAST"] = "Cast",
}

local flags = {
  ["SELF"] = "Player",
  ["TARGET"] = "Target",
  ["FOCUS"] = "Focus",
  ["PET"] = "Pet",
  ["ENEMY"] = "Enemies",
  ["FRIEND"] = "Friends",
  ["ANY"] = "Anyone",
}

local frames = {
  [SCT.FRAME1] = SCT.LOCALS.OPTION_MISC14.name,
  [SCT.FRAME2] = SCT.LOCALS.OPTION_MISC20.name,
  [SCT.MSG] = SCT.LOCALS.OPTION_MISC15.name,
}
if SCTD then
  frames[SCT.FRAME3] = "SCTD"
end

local misses = {
  ["ABSORB"] = ABSORB,
  ["DODGE"] = DODGE,
  ["RESIST"] = RESIST,
  ["PARRY"] = PARRY,
  ["MISS"] = MISS,
  ["BLOCK"] = BLOCK,
  ["REFLECT"] = REFLECT,
  ["DEFLECT"] = DEFLECT,
  ["IMMUNE"] = IMMUNE,
  ["EVADE"] = EVADE,
  ["ANY"] = "Any",
}

local power = {
  [Enum.PowerType.Mana] = MANA,
  [Enum.PowerType.Rage] = RAGE,
  [Enum.PowerType.Focus] = FOCUS,
  [Enum.PowerType.Energy] = ENERGY,
  [Enum.PowerType.ComboPoints] = COMBO_POINTS,
  [Enum.PowerType.Runes] = RUNES,
  [Enum.PowerType.RunicPower] = RUNIC_POWER,
  [Enum.PowerType.SoulShards] = SOUL_SHARDS,
  [Enum.PowerType.LunarPower] = LUNAR_POWER,
  [Enum.PowerType.HolyPower] = HOLY_POWER,
  [Enum.PowerType.Alternate] = ALTERNATE_RESOURCE_TEXT,
  [Enum.PowerType.Maelstrom] = MAELSTROM_POWER,
  [Enum.PowerType.Chi] = CHI_POWER,
  [Enum.PowerType.Insanity] = INSANITY_POWER,
  [Enum.PowerType.ArcaneCharges] = ARCANE_CHARGES_POWER,
  [Enum.PowerType.Fury] = FURY,
  [Enum.PowerType.Pain] = PAIN,
  [0] = "Any",
}

--Custom Selections
SCT.LOCALS.OPTION_CUSTOMSELECTION1 = { name="Event Type", tooltipText = "What type of event it is.", table = eventtypes};
SCT.LOCALS.OPTION_CUSTOMSELECTION2 = { name="Target", tooltipText = "Who the event happens to.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION3 = { name="Source", tooltipText = "Who the event comes from.", table = flags};
SCT.LOCALS.OPTION_CUSTOMSELECTION4 = { name="Event Frame", tooltipText = "What Frame to send the event to.", table = frames};
SCT.LOCALS.OPTION_CUSTOMSELECTION5 = { name="Miss Type", tooltipText = "What type of miss to trigger off of.", table = misses};
SCT.LOCALS.OPTION_CUSTOMSELECTION6 = { name="Power Type", tooltipText = "What type of power to trigger off of.", table = power};

--EditBox options
SCT.LOCALS.OPTION_EDITBOX1 = { name="Name", tooltipText = "The name for the custom event"};
SCT.LOCALS.OPTION_EDITBOX2 = { name="Display", tooltipText = "What to display in SCT for the event. Use *1 - *5 for captured values:\n\n*1 - spell name\n*2 - source\n*3 - target\n*4 - varies (amount, etc...)"};
SCT.LOCALS.OPTION_EDITBOX3 = { name="Search", tooltipText = "What spell or skill to search for. Can be empty (suppression) or partial words."};
SCT.LOCALS.OPTION_EDITBOX4 = { name="Sound", tooltipText = "Name of ingame sound to play for this event. Ex. GnomeExploration"};
SCT.LOCALS.OPTION_EDITBOX5 = { name="Wave Sound", tooltipText = "Path to a .ogg sound file to play for this event. Ex. Interface\\AddOns\\MyAddOn\\mysound.ogg or Sound\\Spells\\ShaysBell.ogg"};
SCT.LOCALS.OPTION_EDITBOX6 = { name="Cooldown List", tooltipText = "List of cooldowns for black-/whitelist separated by commas"};
