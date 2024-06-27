# DBM - Dungeons

## [r133](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r133) (2024-06-16)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r132...r133) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- Fix numerous cases where count was missing, or wrong object type was set (also causing count to be missing)  
    Disabled some false diagnostics reports as well  
- Add add TWW version of General Umbriss. this concludes boss update for Grim Batol. Trash soon  
- Added TWW complete rework of Throngus. This one actually required it to be two full modules in one since 0 remnant of OG fight was left from cata version. of course, cata versoin still exists and will load exclusively on cataclysm classic :)  
- Update Erudex for TWW  
- Fix bad copy paste  
- better handle dungeon stats between cataclysm classic and retail  
- Add TWW mechanics to Drahga (while maintaining cataclysm classic compat)  
- First siege of boralus update from TWW testing. Some boss timer and event tweaks, added a new trash ability  
- preliminary prioroty of sacred flame trash alerts for abilities that caused most problems  
- Priority of the Sacred Flame update:  
     - Timer improvements on all bosses  
     - Fixed some events on Baron Braunpyke to work using USCS since they don't have CLEU events.  
- Rookery Update:  
     - Fix bad target scan on Kyrloss, that no longer works  
     - Revert/tweak initial timers to reflect that story mode and regular mode has diff timers.  
    Stonevault update:  
     - Fixed bad timer debug on EDNA and improve target warning for refracting beam for multi target  
     - Updated timers on Forge Speakers to reflect recent changes  
     - Added trash warning for Earth Burst totem swap  
     - Fixed a bug with voidinfection timer not canceling on Cursedheart Invader death  
- Couple dungeon fixes to rookery  
