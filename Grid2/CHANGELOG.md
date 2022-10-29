# Grid2

## [2.0.60](https://github.com/michaelnpsp/Grid2/tree/2.0.60) (2022-10-26)
[Full Changelog](https://github.com/michaelnpsp/Grid2/compare/2.0.54...2.0.60) [Previous Releases](https://github.com/michaelnpsp/Grid2/releases)

- TOC Updated for Dragonflight prepatch.  
- Refactored indicator highlight (blink/glow/zoom) activation code.  
- Fixing dispelTypes for Shaman in Wotlk Classic (CF issue #1124)  
- Dragonflight: Added support for Evoker class dispells (github issue #81)  
- Refactored highlight effects code.  
- Fixing a possible glitch on inital health display when Instant Health frequency is enabled.  
- Dragonflight: Fixing a crash in multibar configuration (github issue #80)  
- Added Glow borders for buffs/debuffs and icon indicators (CF issue #1091)  
    BugFix: "by group" layouts did not obey the groups detached configuration (CF issue #1123)  
- Fixed some glitches in new position/anchor configuration options.  
- Fixing possible crash in icons indicator.  
- Added a toggle in general options to Zoom In buffs/debuffs icons (github issue #79)  
- Moved some Grid2Layout AceDB options from global to profile and added db upgrade code in GridDefaults.lua  
- Now detached headers for current loaded layout can be manual positioned using sliders in Appearance section..  
- Added player role Load option to buffs/debuffs (curseforge issue #1109)  
    Removed roster update event from DungeonRole status.  
- Moved layout position sliders to players tab.  
- Refactored special headers generation to ensure they are always created in the same order.  
- Moved detached savedvariables from global section to profile section. More tweaking in appearance configuration.  
- Now unitsPerColumn can be individually configured for different header types (pets, players, bosses).  
    Now anchor points of detached groups can be individually configured for different header types (pets, players, bosses).  
    Now target and focus have a "hide Empty Units" option.  
- Changed "Appearance" configuration, now options are splitted in 4 tabs instead of 2.  
- BugFix: Now using different frame sizes by instance aize should work when "Display all groups" option is enabled.  
- Fixing crash creating buffs/debuffs in Dragonflight (CF issue #1121)  
- Now players/pets/target/focus/bosses frame sizes can be individually configured.  
    Now in non-develop versions Grid2 always uses blizzard unit frames.  
- Now Name status can be configured to display pet/vehicle owner instead of pet/vehicle name.  
- Better handling of toggleForVehicle bug, now we track if the vehicle pet does not exist yet (curseforge issue #1113).  
    Removed some unused code in group headers.  
- Fixing Wotlk layouts role order (github issue #78)  
- More fixes in options for Dragonflight.  
- Some fixes for Dragonflight.  
- BugFix: Now toggleForVehicle bug workaround is only enabled in malygos and oculus instances.  
- Reimplemented the workaround for Wrath toggleForVehicle bug, new workaround should work more or less in Malygos but only with Grid2 left-click targeting on players (not pets): clique or mouseover macros don't work; a real fix in blizzard game code is needed to fix this mess.  
