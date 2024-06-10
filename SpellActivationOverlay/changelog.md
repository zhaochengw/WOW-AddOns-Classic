## SpellActivationOverlay Changelog

#### v1.3.2 (2024-04-30)

The Death Knight class experiments the upcoming rework for Cataclysm.
Make sure to report issues you would encounter, thank you :)

New effects:
- New SAO: Death Knight's Crimson Scourge (Cataclysm)
- New SAO: Death Knight's Sudden Doom (Cataclysm)
- New SAO: Death Knight's Will of the Necropolis (Cataclysm)
- New SAO: Druid's Lunar and Solar Eclipse (Cataclysm)
- New SAO: Druid's Shooting Stars (Cataclysm)
- New SAO: Hunter's Lock and Load (Season of Discovery)
- New SAO: Warrior's Bloodsurge (Cataclysm)
- New SAO: Warrior's Sudden Death (Cataclysm)
- New SAO: Warrior's Sword and Board (Cataclysm)
- New SAO: Warrior's Sword and Board (Season of Discovery)
- New GAB: Death Knight's Blood Boil, during Crimson Scourge (Cataclysm)
- New GAB: Death Knight's Death Coil, during Sudden Doom (Cataclysm)
- New GAB: Death Knight's Icy Touch, during Rime (Cataclysm)
- New GAB: Death Knight's Obliterate, during Killing Machine (Cataclysm)
- New GAB: Death Knight's Rune Tap, during Will of the Necropolis (Cataclysm)
- New GAB: Druid's Starfire, during Lunar Eclipse (Cataclysm)
- New GAB: Druid's Wrath, during Solar Eclipse (Cataclysm)
- New GAB: Druid's Starsurge, during Shooting Stars (Cataclysm)
- New GAB: Paladin's Holy Shock, as combat-only counter
- New GAB: Paladin's Flash of Light, during Infusion of Light (Cataclysm)
- New GAB: Paladin's Holy Light, during Infusion of Light (Cataclysm)
- New GAB: Paladin's Divine Light, during Infusion of Light (Cataclysm)
- New GAB: Paladin's Holy Radiance, during Infusion of Light (Cataclysm)
- New GAB: Paladin's Exorcism, during The Art of War (Cataclysm)
- New GAB: Warrior's Slam, during Bloodsurge (Cataclysm)
- New GAB: Warrior's Colossus Smash, during Sudden Death (Cataclysm)
- New GAB: Warrior's Shield Slam, during Sword and Board (Cataclysm)
- New GAB: Warrior's Shield Slam, during Sword and Board (Season of Discovery)
- New GAB: Warrior's Overpower, during Taste for Blood* (Season of Discovery)

* As in Wrath, there is no dedicated Taste for Blood option
Taste for Blood shares its option with Overpower

Updated effects:
- Druid's Nature's Grace now has a fixed texture
- Druid's Nature's Grace texture has been scaled to 70% (down from 100%)

Removed effects:
- Druid's Wrath of Elune has been removed (Cataclysm)
- Druid's Elune Wrath has been removed (Cataclysm)

Bug fixes
- Death Knight's Killing Machine (Cataclysm) no longer glows Icy Touch
- Death Knight's Killing Machine (Cataclysm) no longer glows Howling Blast
- Druid's Lunar or Solar Eclipse spell alert is displayed upon login if needed
- Hungering Cold is now tagged as Frozen debuff for Mages
- Warrior's Blood Surge (Season of Discovery) did not trigger correctly
- Warrior's Bloodsurge (Wrath) did not preview from the options panel
- Warrior's Sudden Death (Wrath) did not preview from the options panel

#### v1.3.1 (2024-04-22)

Shout-out to fellow developers Amanthuul and steijner. Thanks!

Options:
- New option to play a sound effect when triggering a spell alert
- The option is enabled by default for Cataclysm, which had this sound
- The option is disabled by default for Classic Era and Wrath
- It would be confusing to add sounds overnight to Era and Wrath players
- To enable or disable it, please open the options panel by entering /sao

New effect for Wrath Classic:
- New GAB: Paladin's Divine Storm, as combat-only counter

New effects for Season of Discovery:
- New SAO: Shaman's Rolling Thunder with 7-9 Lightning Shield stacks
- New SAO: Shaman's Tidal Waves
- New SAO: Priest's Mind Spike
- New GAB: Mage's Deep Freeze, during Fingers of Frost
- New GAB: Mage's Deep Freeze, when the target is Frozen
- New GAB: Paladin's Divine Storm, as combat-only counter
- New GAB: Priest's Mind Blast, during Mind Spike at 3 stacks
- New GAB: Shaman's Earth Shock, with 7-9 Lightning Shield stacks
- New GAB: Shaman's Healing Wave, during Tidal Waves
- New GAB: Shaman's Lesser Healing Wave, during Tidal Waves

Introducing Cataclysm flavor!
- The addon is in very early stage, currently in alpha
- Support for Mage's Arcane Missiles
- Support for Mage's Arcane Potency
- Support for Mage's Brain Freeze
- Support for Mage's Clearcasting
- Support for Mage's Deep Freeze
- Support for Mage's Fingers of Frost
- Support for Mage's Frozen debuff
- Support for Mage's Heating Up and Hot Streak
- Support for Mage's Impact

Bug Fixes
- Spell Alerts of counters are instantly hidden when the counter is un-learned

#### v1.3.0 (2024-04-17)

Bump in TOC file for Season of Discovery update (Classic Era)

- New GAB: Paladin's Exorcism
- New SAO: Priest's Surge of Light (Season of Discovery)
- New GAB: Priest's Flash Heal button glows during Surge of Light (SoD)
- New GAB: Priest's Smite button glows during Surge of Light (SoD)

Combat-only counters:
- Hunter's Flanking Strike now fades out after leaving combat
- Mage's Heating Up now fades out after leaving combat
- Paladin's Exorcism fades out after leaving combat
- Shaman's Molten Blast now fades out after leaving combat

Bug Fixes
- Counters are no longer flagged as unavailable during GCD (Classic Era)
- Druid's Eclipse now refreshes its visual timer when gaining a stack

#### v1.2.0 (2024-03-19)

Bump in TOC file for Season of Discovery and Hardcore update (Classic Era)

Shout-out to fellow developers abecks, Amanthuul and AboveAzureSkies. Thanks!

Talent update:
- New SAO: Druid's Nature's Grace (Classic Era)

New runes for Season of Discovery:
- New SAO: Druid's Eclipse
- New GAB: Druid's Starfire button glows during Lunar Eclipse
- New GAB: Druid's Wrath button glows during Solar Eclipse
- New SAO: Mage's Hot Streak
- New GAB: Mage's Pyroblast button glows during Hot Streak
- New SAO: Mage's Missile Barrage, blue-ish tint to differ from Arcane Blast
- New GAB: Mage's Arcane Missiles button glows during Missile Barrage
- New SAO: Mage's Brain Freeze
- New GAB: Mage's Fireball button glows during Brain Freeze
- New GAB: Mage's Spellfrost Bolt button glows during Brain Freeze
- New GAB: Mage's Frostfire Bolt button glows during Brain Freeze
- New SAO: Shaman's Maelstrom Weapon
- New GAB: Shaman's Lightning Bolt glows during Maelstrom Weapon
- New GAB: Shaman's Chain Lightning glows during Maelstrom Weapon
- New GAB: Shaman's Lesser Healing Wave glows during Maelstrom Weapon
- New GAB: Shaman's Healing Wave glows during Maelstrom Weapon
- New GAB: Shaman's Chain Heal glows during Maelstrom Weapon
- New GAB: Shaman's Lava Burst glows during Maelstrom Weapon
- New SAO: Shaman's Power Surge
- New GAB: Shaman's Chain Lightning glows during Power Surge
- New GAB: Shaman's Chain Heal glows during Power Surge
- New GAB: Shaman's Lava Burst glows during Power Surge
- New SAO: Warrior's Bloodsurge
- New GAB: Warrior's Slam glows during Bloodsurge

#### v1.1.4 (2024-01-23)

- Rune list is refreshed explicitly, so that detection no longer fails
- Runes are checked every 10 secs until one is found, to detect them sooner

#### v1.1.3 (2023-12-13)

Effects based on stackable auras could sometimes not be triggered correctly:
- Hunter's Cobra Strikes (Season of Discovery)
- Hunter's Lock and Load (Wrath Classic)
- Mage's Arcane Blast (Season of Discovery)
- Mage's Fingers of Frost (Wrath Classic, Season of Discovery)
- Priest's Serendipity (Wrath Classic, Season of Discovery)
- Shaman's Maelstrom Weapon (Wrath Classic)
- Shaman's Tidal Waves (Wrath Classic)
- Warlock's Molten Core (Wrath Classic)
- Warrior's Bloodsurge (Wrath Classic)
- Warrior's Sudden Death (Wrath Classic)

#### v1.1.2 (2023-12-12)

- Seasonal effects are no longer displayed as options in non-Seasonal realms
- Updated SAO: Rogue's Riposte can now trigger independently of cooldown
- Updated GAB: Rogue's Riposte can now trigger independently of cooldown
- Rogue's new options are independent; make sure to enable both, if needed
- Rogue new options are disabled by default, similar to Warrior stance options
- Mage's Arcane Blast should now trigger correctly (Season of Discovery only)
- Season of Discovery action counters should now glow correctly

The action counter fix includes the following spells and abilities:
- Hunter's Flanking Strike
- Shaman's Molten Blast
- Warrior's Raging Blow
- Warrior's Victory Rush (fixed for Season of Discovery only, Wrath was fine)

#### v1.1.1 (2023-12-05)

- New SAO: Mage's Arcane Blast
- New GAB: Mage's Arcane Missiles, during Arcane Blast
- New GAB: Mage's Arcane Explosion, during Arcane Blast
- Updated SAO: Mage's Clearcasting is back to 150% size, to avoid overlap
- Hunter's Flanking Strike Spell Alert is no longer always displayed upon login
- Shaman's Molten Blast Spell Alert is no longer always displayed upon login

#### v1.1.0-beta (2023-12-01)

This release focuses on supporting runes introduced in Season of Discovery
- New SAO: Druid's Fury of Stormrage
- New SAO: Hunter's Flanking Strike
- New SAO: Hunter's Cobra Strikes
- New SAO: Mage's Fingers of Frost
- New SAO: Priest's Serendipity
- New SAO: Shaman's Molten Blast
- New SAO: Warrior's Raging Blow
- New GAB: Druid's Healing Touch, during Fury of Stormrage
- New GAB: Hunter's Flanking Strike, when the action is usable
- New GAB: Mage's Ice Lance, during Fingers of Frost
- New GAB: Mage's Ice Lance, when the enemy target is Frozen
- New GAB: Priest's Lesser Heal, during Serendipity
- New GAB: Priest's Heal, during Serendipity
- New GAB: Priest's Greater Heal, during Serendipity
- New GAB: Priest's Prayer of Healing, during Serendipity
- New GAB: Shaman's Molten Blast, when the action is usable
- New GAB: Warrior's Raging Blow, when the action is usable
- New GAB: Warrior's Victory Rush, when the action is usable

Bug Fixes
- In rare circumstances, glowing buttons would never glow
- Reloading the UI would always fix the issue, until next log out

#### v1.0.0 (2023-12-01)

Spell Alerts have a shrinking effect to know when the alert is about to fade
- This effect is enabled by default; enter /sao to enable or disable it
- Feel free to report spell alerts that should have but do not have this effect
- Please note, some effects never fade on purpose, such as Mage's Heating Up

Bug Fixes
- Mage's Deep Freeze debuff now counts as a Frozen effect (Wrath Classic only)
- Mage's Heating Up lingered after 4 critical strikes without casting Pyroblast

This release bumps TOC file for Season of Discovery patch (Classic Era)
- Runes of Season of Discovery will be supported over time
- To support them, we need technical information not always available day 1
- Make sure to head over GitHub or Discord to help us, thank you :)

#### v0.9.5 (2023-11-07)

- Buttons should glow correctly when using AzeriteUI
- New SAOs: Healing Trance / Soul Preserver, for all healing classes
- New GAB: Hunter's Mongoose Bite (Classic Era only)
- Warriors can hold 2 charges of Sudden Death thanks to tier 10 set bonus
- Warriors can hold 2 charges of Bloodsurge thanks to tier 10 set bonus

#### v0.9.4 (2023-11-01)

- Bump in TOC file for Icecrown Citadel patch (Wrath Classic)
- New SAO: Mage's Frozen when the target is under a Frozen effect
- New GAB: Mage's Ice Lance button glows during Fingers of Frost
- New GAB: Mage's Deep Freeze button glows during Fingers of Frost
- New GAB: Mage's Ice Lance button glows when the target is Frozen
- New GAB: Mage's Deep Freeze button glows when the target is Frozen

List of spells that trigger the Frozen effect:
- Mage's Frost Nova
- Mage's Frostbite (Frost talent)
- Mage's Shattered Barrier (Frost talent, Wrath Classic only)
- Mage's Frost Elemental's Freeze spell (Wrath Classic only)
- Hunter's Freezing Trap

#### v0.9.3 (2023-09-02)

- Bump in TOC file for Classic Hardcore patch (Classic Era)
- Druid's Omen of Clarity was no longer working since Classic Era last patch
- Warrior's Overpower button could glow for too long after the target dodged
- Warrior's Overpower button glows during Taste for Blood
- The 'baseline' Overpower can only be cast on the target who dodged
- Taste for Blood, on the other hand, allows to cast Overpower on any target
- Taste for Blood is available on Wrath Classic only

The bug that happened to druids may also happen to other classes
Please report bugs to the addon's Discord, GitHub or CurseForge

#### v0.9.2 (2023-06-21)

- Bump in TOC file for Trial of the Grand Crusader patch (Wrath Classic)
- The options window is compatible with the new settings UI

#### v0.9.1 (2023-05-28)

- Mage's Clearcasting is now enabled by default on Classic Era
- Mage's Clearcasting has been scaled to 100% (down from 150%) on Classic Era
- New GAB: Warlock's Drain Soul when the enemy has low HP
- The Drain Soul option is available for Wrath Classic only
- Warrior's Overpower has an option to be detected in any stance
- Warrior's Revenge has an option to be detected in any stance
- Warrior's Execute has an option to be detected in any stance

Please enter /sao to enable or disable these options

#### v0.9.0 (2023-05-01)

- Support for Classic Era, although many WotLK spells and talents are missing
- Mage's Heating Up effect is now hidden when the talent is lost e.g., respec
- Fixed an issue where paladin and warrior buttons would sometimes not glow
- The addon should now use a bit less CPU than before

#### v0.8.4 (2023-04-28)

- New SAO: Druid's Wrath of Elune (4p set bonus of PvP season 5-6-7-8)
- New SAO: Druid's Elune's Wrath (4p set bonus of tier 8)
- New SAO: Mage's Heating Up and Hot Streak at the same time
- New GAB: Druid's Starfire button glows during Wrath of Elune
- New GAB: Druid's Starfire button glows during Elune's Wrath

Enter /sao to enable or disable these options

#### v0.8.3 (2023-01-29)

- Glowing buttons work again with ProjectAzilroka, after Ulduar patch
- Mage's Heating Up works again with ProjectAzilroka, after Ulduar patch
- Other features may also work back to normal for ProjectAzilroka users
- These fixes also apply to addons embedding an outdated LibButtonGlow
- If there is no fallback solution, glowing buttons are temporarily disabled

#### v0.8.2 (2023-01-18)

- Bump in TOC file for Ulduar patch

#### v0.8.1 (2022-11-13)

- The default glowing button library is now LibButtonGlow for ElvUI 13

#### v0.8.0 (2022-11-08)

- SAOs and GABs can be previewed by moving the cursor over their options
- SAOs may have variants when e.g. there is no obvious texture to use
- New SAO: Druid's Nature's Grace, optional
- New SAO: Mage's Arcane Concentration (a.k.a. Clearcasting), optional
- New SAO: Shaman's Tidal Waves, optional
- New GAB: Shaman's Lesser Healing Wave button may glow during Tidal Waves
- New GAB: Shaman's Healing Wave button may glow during Tidal Waves

#### v0.7.0 (2022-10-09)

- Spell Alerts may now be enabled or disabled individually
- Glowing buttons may now be enabled or disabled individually
- Options panel is opened by entering /sao or /spellactivationoverlay

#### v0.6.5 (2022-10-05)

- Entering a vehicle should no longer cause a Lua error
- Spending 1 point out of 2 in Art of War now has a SAO and GABs

#### v0.6.4 (2022-09-29)

- Spell Alerts fade out after being out of combat for 30 seconds
- Spell Alerts triggering out-of-combat are not dimmed for 5 seconds
- SAOs and GABs should disappear if their triggers fade during a loading screen
- Lua errors of 'ipairs' should no longer occur after a loading screen
- Pulse animations should no longer start earlier thn expected

#### v0.6.3 (2022-09-20)

- New SAO: Warlock's Decimation
- New GAB: Warlock's Soul Fire button glows during Decimation
- Changed SAO: Warlock's Molten Core SAO no longer displays the 3rd charge
- Rogue's Riposte SAO should no longer trigger without the talent

#### v0.6.2 (2022-09-13)

Shout-out to MartGon once again for his contribution to the code. Thanks!

- Glowing buttons no longer "un-glow" during the Global Cooldown (GCD)
- Glowing buttons no longer "un-glow" due to the lack of rage, energy, or RP
- New SAO: Druid's Predatory Strikes, based on Predatory Swiftness from Retail
- New SAO: Mage's Firestarter, which uses texture of Impact
- New GAB: Mage's Flamestrike button glows during Firestarter
- Changed SAO: Mage's Impact uses texture of Lock and Load instead of Impact

#### v0.6.1 (2022-09-06)

Shout-out to MartGon and xHashii for their contribution to the code. Thanks!

- Buttons should glow correctly when using Bartender, ElvUI or Dominos
- New GAB: Hunter's Kill Shot button glows when the target has low HP
- New GAB: Paladin's Hammer of Wrath button glows when the target has low HP
- New GAB: Warrior's Execute button glows when the target has low HP
- New GAB: Warrior's Victory Rush button glows after killing an enemy
- Riposte should display its SAO as intended
- Reload UI should no longer cause a Lua error because of options
- Glowing Buttons checkbox should now apply the option correctly

#### v0.6.0 (2022-09-04)

- After extensive testing, SpellActivationOverlay now leaves its Beta phase!
- Options Panel, available from Interface > AddOns > SpellActivationOverlay
- Options for Spell Alerts: opacity, scale factor, offset
- Options for Glowing Buttons: on/off
- A "Toggle Test" button displays fake Spell Alerts for testing interactively

#### v0.5.0-beta (2022-08-31)

SpellActivationOverlay now has a Discord server!
Make sure to check it out at https://discord.gg/xJmGfGcd4M

Support for Glowing Action Buttons (GABs), making some actions glow, namely:
- Death Knight's Rune Strike button glows after parrying or dodging an attack
- Death Knight's Howling Blast button glows during Rime
- DK's Icy Touch/Frost Strike/Howling Blast buttons glow during Killing Machine
- Druid's Wrath button glows during Solar Eclipse
- Druid's Starfire button glows during Lunar Eclipse
- Hunter's Counterattack button glows after parrying an attack, unless on CD
- Hunter's Aimed/Arcane/Chimera Shot buttons glow during Improved Steady Shot
- Hunter's Arcane/Explosive Shot buttons glow during Lock and Load
- Mage's Arcane Missiles button glows during Missile Barrage
- Mage's Pyroblast button glows during Hot Streak
- Mage's Fire Blast button glows during Impact
- Mage's Fireball and Frostfire Bolt buttons glow during Brain Freeze
- Paladin's Flash of Light and Holy Light buttons glow during Infusion of Light
- Paladin's Flash of Light and Exorcism buttons glow during The Art of War
- Priest's Smite and Flash Heal buttons glow during Surge of Light
- Priest's Greater Heal and Prayer of Healing glow at 3 stacks of Serendipity
- Rogue's Riposte button glows after parrying an attack, unless on cooldown
- Warlock's Shadow Bolt button glows during Nightfall, a.k.a. Shadow Trance
- Warlock's Shadow Bolt and Incinerate buttons glow during Backlash
- Warlock's Incinerate and Soul Fire buttons glow during Molten Core
- Warrior's Overpower button glows after the enemy dodges, if in Battle Stance
- Warrior's Revenge button glows after parry/dodge/block in Defensive Stance
- Warrior's Execute button glows during Sudden Death
- Warrior's Slam button glows during Bloodsurge
- Warrior's Shield Slam button glows during Sword and Board

- New SAO: Rogue's Riposte
- SAOs should now always show up on ReloadUI

#### v0.4.2-beta (2022-08-05)

- Mage's Heating Up is no longer lost on death
- Alpha is reduced by 50% when out of combat
- SAOs are shown uplon login if player already has the corresponding buffs
- Currently, this includes all SAOs but Heating Up, which is not a buff

#### v0.4.1-beta (2022-08-05)

- New SAO: Paladin's Infusion of Light
- Textures should keep pulsing after gaining/losing stacks
- Mage's Heating Up does not pulse anymore
- Shamans's Maelstrom Weapon does not pulse at stacks 1-4

#### v0.4.0-beta (2022-07-31)

- Because all classes are supported, the addon now enters its Beta phase!
- New classes: Druid, Hunter, Rogue
- New SAO: Druid's Lunar Eclipse
- New SAO: Druid's Solar Eclipse
- New SAO: Druid's Omen of Clarity
- New SAO: Hunter's Improved Steady Shot
- New SAO: Hunter's Lock and Load
- New SAO: Mage's Impact
- New SAO: Shaman's Elemental Focus
- The Rogue class, although supported, currently doesn't have any SAO

#### v0.3.4-alpha (2022-07-31)

- New class: Warlock
- New SAO: Warlock's Backlash
- New SAO: Warlock's Empowered Imp
- New SAO: Warlock's Molten Core
- New SAO: Warlock's Nightfall, a.k.a. Shadow Trance

#### v0.3.3-alpha (2022-07-29)

- New classes: Shaman, Warrior
- New SAO: Priest's Serendipity
- New SAO: Shaman's Maelstrom Weapon
- New SAO: Warrior's Bloodsurge
- New SAO: Warrior's Sudden Death
- New SAO: Warrior's Sword and Board

#### v0.3.2-alpha (2022-07-27)

- New classes: Priest, Paladin
- New SAO: Priest's Surge of Light
- New SAO: Paladin's Art of War

#### v0.3.1-alpha (2022-07-26)

- New SAO: Mage's Missile Barrage
- New SAO: Mage's Brain Freeze

#### v0.3.0-alpha (2022-07-25)

- New SAO: Mage's Fingers of Frost
- Major changes to how stackable auras, such as Fingers of Frost, are handled
- Due to a game limitation, stackable auras rely a bit less on combat logs
- Talent checks could fail during login
- This addon no longer stores data to the game client local storage

#### v0.2.0-alpha (2022-07-24)

- Major changes to how custom code can be implemented, on a per-class basis
- Mage's Heating Up is now fully functional
- Mage's Heating Up now triggers only for mages who picked Hot Streak talent

#### v0.1.2-alpha (2022-07-24)

- New SAO: Mage's Heating Up, barely functional because Wrath has no such buff
- Factorized code in common.lua

#### v0.1.1-alpha (2022-07-24)

- New class: Mage
- New SAO: Mage's Hot Streak

#### v0.1.0-alpha (2020-07-24)

- SpellActivationOverlay is now public!
- Addon hosted on Curse https://www.curseforge.com/wow/addons/spellactivationoverlay
- Source code is available on GitHub https://github.com/ennvina/spellactivationoverlay
- This release mostly focuses on cleaning up some files before sharing them

#### v0.0.5-alpha (2022-07-24)

- Track combat event log instead of unit auras
- Support for stackable effects, although no stackable example is written yet

#### v0.0.4-alpha (2022-07-23)

- Utility functions are now centralized in common.lua
- First working Spell Activation Overlays (SAOs): DK's Rime and Killing Machine

#### v0.0.3-alpha (2022-07-23)

- Custom code for initializing new frame members
- Extra caution to ensure Blizzard original code changes as little as possible
- Utility functions to work around auras; defined in a separate source file

#### v0.0.2-alpha (2022-07-23)

- Re-use WeakAuras "Blizzard Alert" category for listing textures
- Map texture IDs to a local texture name in the addon folder

#### v0.0.1-alpha (2022-07-23)

- Re-use Blizzard code from Retail's FrameXML source code
- Re-use Rime and Killing Machine textures from Retail
- Ignore displaySpellActivationOverlays cvariable, unavailable in Classic
