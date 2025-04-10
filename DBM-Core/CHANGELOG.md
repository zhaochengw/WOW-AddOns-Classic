# DBM - Core

## [11.1.14](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.1.14) (2025-04-04)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.1.13...11.1.14) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag with forced update toggled on to propagate version check comm changes  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1604  
- Finally fix up LFR support of gallywix  
- Kill off range checker in wrath. Even if blizzard hasn't blocked all the apis yet, they've blocked it partially and I can't be certain they will or won't block the rest and I can't actively test it either so it's better to just remove this functionality now. Closes https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1607#issuecomment-2777896351  
- Kill checkInteractDistance in wrath range checker. unsure about item api yet  
- Fix bug that caused ego check timer to break  
- put hacky workaronds in for Linaori problem  
- cleanup deprecations some. add ignores for others  
- Update localization.ru.lua (#1603)  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
    * Update localization.ru.lua  
- Update localization.tw.lua (#1605)  
- fix dungeon version reporting 0 instead of "not installed"  
- Update koKR (#1602)  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Revert  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR stings in tocs  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    ---------  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Fix break timer recovery no longer working since start of TWW due to arg accidentally getting dropped in refactor  
- fix lua error in new version check  
- fix voice alerts being backwards on stix  
- Fix cauldron fades being inverted  
- Update localization.ru.lua (#1601)  
- Update localization.tw.lua (#1600)  
- Fix double dungeons  
- Revert "Also collect dungeon version from guild"  
- Also collect dungeon version from guild  
- missed a tonumber  
- Scrap sending voice pack version and replace it with always sending dungeon mod version.  
- bump alpha  
