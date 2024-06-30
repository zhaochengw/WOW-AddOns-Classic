--[[
  ****************************************************************
  Scrolling Combat Text
  Event Config File
  ****************************************************************

  PLEASE NOTE:
    Custom events are radically different than from previous versions.
    Please see examples below to learn how to do most everything in the
    new system.

    However, please note you can do all of this from within the game now
    using the custom event option menu. You do not have to read or learn
    this file to use the in game option menu.

  Description:
    This file is used to setup custom events for use in SCT. Due to the
    combat log changes in 2.4, custom events are very differnt. You now
    must specificy what type of event for every event, along with various
    optional settings to get at what you want. Please read all the paramaters
    below in detail and review the examples.

        name:   This is a unique name for the event. It is mainly used by
                they in game custom event menu to distinguish between each event

     display:   This is basically the text you want SCT to display
                whenever the event occurs. for captured data you
                use *n where n is the index of the captured data you
                want to display. See the table below for all available
                arguments.

      search:   in most cases now, this is the spell/skill that you are
                looking for. However this is optional and not always needed
                depending on what you are wanting to. Use ACTION_SWING for
                regular melee

        type:   Indicates the type of event. The Current
                allowed types are:

                "BUFFS" - When buff or debuff is gained
                "FADE" - When buff or debuff fades
                "MISS" - When something misses
                "HEAL" - When healing occurs
                "DAMAGE" - When damage occurs
                "DEATH" - When someone or something dies
                "INTERRUPT" - When something is inerrupted
                "POWER" - When power is gained
                "SUMMON" - When something is summoned
                "DISPEL" - When a buff/debuff is removed
                "CAST" - When spell cast starts

                                                         CAPTURES
                TYPE        OPTIONS                      arg1       arg2        arg3        arg4
                "BUFF"      buffcount                    spellname  nil         targetname  buffcount
                "FADE"      buffcount                    spellname  nil         targetname  buffcount
                "MISS"      misstype                     spellname  sourcename  targetname  misstype
                "HEAL"      critical, resisted, blocked, spellname  sourcename  targetname  amount
                            absorbed, glancing, crushing
                "DAMAGE"    critical                     spellname  sourcename  targetname  amount
                "DEATH"                                  nil        sourcename  targetname
                "INTERRUPT"                              spellname  sourcename  targetname
                "POWER"     power                        spellname  sourcename  targetname  amount
                "SUMMON"                                 spellname  sourcename  targetname
                "DISPEL"                                 spellname  sourcename  targetname
                "CAST"                                   spellname  sourcename  targetname

                OPTIONS DESCRIPTIONS
                buffcount: if used, this limits the event to only fire when the count of the
                           buff is this value. Usefull for debuffs like Sunder Armor, Deadly Poision, etc...

                misstype:  the type of the miss. "DODGE", "ABSORB", "RESIST", "PARRY", "MISS", "BLOCK",
                           "REFLECT", "DEFLECT", "IMMUNE", "EVADE"

                critical:  if set to 1 or true, the event will only trigger if the event was a crit hit
                resisted:  if set to 1 or true, the event will only trigger if the event has a partial resist
                blocked:   if set to 1 or true, the event will only trigger if the event has a partial block
                absorbed:  if set to 1 or true, the event will only trigger if the event has a partial absorb
                glancing:  if set to 1 or true, the event will only trigger if the event was a glancing hit
                crushing:  if set to 1 or true, the event will only trigger if the event was a crushing hit

                power:     the type of the power gain. SPELL_POWER_MANA, SPELL_POWER_RAGE,
                           SPELL_POWER_FOCUS, SPELL_POWER_ENERGY, SPELL_POWER_HAPPINESS

       target:  Who the event affects or happened to.

                "SELF" - The player only
                "TARGET" - Your current target only
                "FOCUS" - Your current focus only
                "PET" - Your pet(s) only
                "ENEMY" - Any unit you can attack
                "FRIEND" - Any friendly unit
                "ANY" - Any unit (you do not care who)

       source:  Who the event came from. This is not always relevant/available.
                Values are the same as for target. for Debuffs, setting
                it to "SELF" will make only a debuff you apply to your
                target trigger the event.

      r, g, b:  These are the color settings used to select the
                color you want the event to display in. r = red,
                g = green, b = blue. Some common colors:

                Red:        r=256/256,  g=0/256,    b=0/256
                Green:      r=0/256,    g=256/256,  b=0/256
                Blue:       r=0/256,    g=0/256,    b=256/256
                Yellow:     r=256/256,  g=256/256,  b=0/256
                Magenta:    r=256/256,  g=0/256,    b=256/256
                Cyan:       r=0/256,    g=256/256,  b=256/256

      iscrit:   this will make the event appear as a crit event,
                so it will be sticky or large font. You only need
                to set this if you want it used. iscrit=1

        icon:   this will attempt to show the spell icon for the event
                if it is appropriate. icon=1

    override:   if set to false, the event will be displayed but any normal
                event will also still trigger. Defaults to true.

       frame:   Determines what frame to show the event in. Default is Frame1.
                The only values allowed are:

                SCT.FRAME1
                SCT.FRAME2
                SCT.FRAME3 (SCTD)
                SCT.MSG (SCT message frame)

       class:   This allows you to filter events by class. Put only
                the classes you want to see the even here. They must
                be in LUA table format.

                Examples:

                Warrior only:         class={"Warrior"}
                Warrior and Shaman:   class={"Warrior", "Shaman"}

        sound:  (advanced users only)
                plays a sound built into WoW. Please see here for a
                list of values: http://www.wowwiki.com/API_PlaySound

                Examples:
                sound="TellMessage"
                sound="GnomeExploration"

    soundwave:  (advanced users only)
                plays a wave file in the path you choose. You can use
                in game ones if you know the path, or custom ones you
                put it in an addon folder.

                Examples:
                In game:      soundwave="Sound\\Spells\\ShaysBell.ogg"
                Custom:       soundwave="Interface\\AddOns\\MyAddOn\\mysound.ogg"

  Note:
    Make sure you increase the key count ([1], [2], etc...) for
    each new event you add. Feel free to delete any of the already
    provided events if you know you will never need them or you
    dont want them to display. You may also place -- in front
    of any of them to comment them out.

  ****************************************************************]]

local event_config = {
[1] = {name="Clearcast", display="Clearcast!", type="BUFF", target="SELF", search="Clearcast", icon=1, r=256/256, g=256/256, b=0/256, iscrit=1, soundwave="Sound\\Spells\\Clearcasting_Impact_Chest.ogg", class={"Mage","Shaman","Druid","Priest"}},
[2] = {name="Flurry", display="Flurry!", type="BUFF", target="SELF", search="Flurry", r=128/256, g=0/256, b=0/256, class={"Warrior","Shaman"}},
[3] = {name="Lightning Shield", display="Lightning Shield!", type="FADE", target="SELF", search="Lightning Shield", r=0/256, g=0/256, b=256/256,class={"Shaman"}},
[4] = {name="Nightfall", display="Nightfall!", type="BUFF", target="SELF", search="Shadow Trance", r=0/256, g=128/256, b=128/256, class={"Warlock"}},
[5] = {name="Overpower", display="Overpower!", type="MISS", target="TARGET", source="SELF", override=false, misstype="DODGE", r=256/256, g=256/256, b=0/256, iscrit=1, class={"Warrior"}},
[6] = {name="Enraged", display="Enraged!", type="BUFF", target="SELF", search="Enrage", r=128/256, g=256/256, b=128/256, iscrit=1, class={"Warrior"}},
[7] = {name="Crusader", display="Crusader!", type="BUFF", target="SELF", search="Holy Strength", r=128/256, g=128/256, b=256/256, iscrit=1,  class={"Warrior","Rogue","Paladin","Shaman","Hunter"}},
[8] = {name="Spirit Tap", display="Spirit Tap!", type="BUFF", target="SELF", search="Spirit Tap", r=128/256, g=128/256, b=150/256, iscrit=1,  class={"Priest"}},
[9] = {name="Totems", display="[*1]", type="SUMMON", target="ANY", source="SELF", search="Totem", icon=1, r=205/256, g=205/256, b=0/256, class={"Shaman"}},
[10] = {name="Mace Stun", display="Mace Stun!", type="BUFF", target="TARGET", source="SELF", search="Mace Stun",r=256/256, g=256/256, b=0/256, iscrit=1, class={"Rogue","Warrior"}},
[11] = {name="Rooted", display="Rooted!", type="BUFF", target="TARGET", source="SELF", search="Improved Hamstring", r=0/256, g=128/256, b=0/256, iscrit=1, class={"Warrior"}},
[12] = {name="Full Sunder", display="Full Sunder!", type="BUFF", target="TARGET", search="Sunder Armor", buffcount=5, r=0/256, g=256/256, b=0/256, iscrit=1, class={"Warrior"}},
[13] = {name="Envenom", display="Envenom!", type="BUFF", target="TARGET", source="SELF", search="Deadly", buffcount=5, r=256/256, g=0/256, b=256/256, iscrit=1, class={"Rogue"}},
[14] = {name="Frostbite", display="Frostbite!", type="BUFF", target="TARGET", source="SELF", search="Frostbite", icon=1, r=75/256, g=150/256, b=225/256, iscrit=1, class={"Mage"}},
[15] = {name="Deep Wound Spam", display="", type="MISS", target="TARGET", source="SELF", search="Deep Wound", r=128/256, g=0/256, b=0/256, class={"Warrior"}},
[16] = {name="Blackout", display="Blackout!", type="BUFF", target="TARGET", search="Blackout", source="SELF", r=128/256, g=128/256, b=150/256, iscrit=1, class={"Priest"}},
[17] = {name="Impact", display="Impact!", type="BUFF", target="TARGET", source="SELF", search="Impact", r=128/256, g=64/256, b=64/256, iscrit=1, class={"Mage"}},
[18] = {name="Feint", display="Feint Failed!", type="MISS", target="TARGET", source="SELF", search="Feint", r=255/256, g=153/256, b=51/256, iscrit=1, class={"Rogue"}},
[19] = {name="Sheep", display="Sheep Broke!", type="FADE", target="FOCUS", search="Polymorph", r=205/256, g=205/256, b=256/256, iscrit=1, class={"Mage"}},
[20] = {name="Slow", display="Slow Removed!", type="FADE", target="ENEMY", search="Slow", r=205/256, g=205/256, b=0/256, iscrit=1, class={"Mage"}},
};

--Set this to true if you always want to load everything from this file.
--When false (default) it only loads these once and then depends on the custom event
--option screen to make changes or add any new events. If you'd prefer to continue to
--maintain your events with this file only, setting this to true is probably prefered.
SCT.AlwaysLoadEvents = false

--Don't mess with these =)
SCT.Events = event_config
