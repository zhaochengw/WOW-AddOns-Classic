# DBM - Core

## [11.1.16](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.1.16) (2025-04-11)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.1.15...11.1.16) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag  
- Core: Fix AntiSpam when GetTime() is ~0 (happens with DBM-Offline)  
- Core: Add support for DAMAGE\_SHIELD events  
- Core: Add basic difficulty modifier support for Scarlet Enclave  
- Update localization.ru.lua (#1615)  
- Difficulty check updates:  
     - Fixed a bug where dungeon popup didn't show for season 2 dungeons (it was still locked to season 1 retail dunegons)  
     - Improved handling of challenges module checks and ensured they run for visions return as well. Visions specifically will use popup notifier  
     - Delves will now use the non popup notifier of available dungeon mods (instead of no notification at all)  
     - Missing module popup will now correctly run in Scarlet Enclave in SoD  
- Cauldron of carnage update  
     - Fixed bug where timer fades still didn't work for first side you started on.  
     - Fixed bug where tank alert on flare side gave wrong instruction (said to watch step instead of defensive)  
     - Fixed bug where clash timer didn't restart after first clash  
     - Added Clash active timer that shows when clash ends  
- Notes  
- Send respawn, battlefield, lfg pop, and pizza/custom timers to Timerbegin callback. Addresses https://github.com/WeakAuras/WeakAuras2/issues/5800#issuecomment-2792795291  
