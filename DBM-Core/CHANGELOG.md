# DBM - Core

## [12.0.38](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/12.0.38) (2026-04-13)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/12.0.37...12.0.38) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag. maybe  
- also use GetPartyAssignment as additional fallback for classic "isTank" checks  
- cleanup redundant checks in specrole  
- fix to gearcheck queries so they aren't over aggressive and hitting unnessesary throttles or timeouts  
- Fix bad scrollbar/refresh button behaviors that'd cause tools gui frames to have over scroll and place refresh button under a needless scroll when frames would have too few columns to trigger auto resize.  
- Fix nitpick  
- Durability, gear, Keystones, and latency will now use unified player column width and realm name to * logic for cleaner reading and reduced footprint for player name  
    Gear check will now also show missing enchants/gems. In coming days will update it to also show number of cheap gems/enchants in use.  
- reduce unnessesary global space functions in ilvl check  
- non player check is already rounded (and not to first decimal unfortunately), so no sense in rounding again.  
- fix bug causing close button to disappear  
- update remaining translations  
- Add very basic gear ilvl check (#2025)  
- Update deDE (#2021)  
- Update commonlocal.tw.lua (#2022)  
- Mini dragon patch 1 (#2024)  
- scope morium tank warning to only show if you have status 3 return on threat.  
- Add pre warning and warning for color swaps on beloren  
    Scope rift slash warning on crown to only be on tank who has threat on simulacrum  
    Preliminary Vanguard mythic hardcode.  
- also readd original log command  
- don't ever clear debug log on debugmode disabling to avoid all the accidental clears  
- wrath titan toc bump  
- workaround blizzards overscheduling of timers on lightbound with a force enable of 60 second bar filter rule on fight (especially on mythic) to avoid bar spam.  
- adjust threat checks for midnight  
- here too, to reduce spam  
- Add a litle experiment while at it  
- enable in LFR too for testing purposes  
- Upgrade midnight falls to hardcode for both normal and heroic  
    cleanup unused  
- prevent skipping midnight falls cutscene if manually played  
- Add missing Averzian mythic hardcode  
- Crown  
     - Fixed a bug that could cause hardcode misrouting for 2 sting timers in longer Stage 2 pulls on heroic  
     - Fixed a regression that caused stage 3 changeover not to occur anymore on heroic difficulty do to over correction in stage change filter.  
     - Fixed invalid sound and bar colors on interrupting tremor.  
    Vaelgor and Ezzorak  
     - Added additional timer routing for longer stage 3 pulls on heroic  
- Fixes #2018 (#2019)  
- add heroic routing to beloren from week 4  
- Fix DBM not loading on Predaxas  
