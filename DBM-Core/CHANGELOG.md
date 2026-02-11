# DBM - Core

## [12.0.18](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/12.0.18) (2026-02-11)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/12.0.17...12.0.18) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Update localization.ru.lua (#1896)  
- Update localization.tw.lua (#1895)  
- Update Core translation strings (#1897)  
    Co-authored-by: anon1231823 <anon1231823@users.noreply.github.com>  
- Prep another new release with many 12.0.1 bugfixes. some fixes are still waiting on blizzard though.  
- hacky workarounds to de-white some non combat timers. Combat timers are still going to be white and ignore user color settings until blizzard provides a solution, with the exception of modules already updated with custom color api.  
- Fix regression that a broke private aura sounds from being registered at all  
    Fix regression that caused cast announces to lookup wrong sound file  
    Fix patch issue that caused flashing bars to become stuck in a non flash state/transparent  
    Fix one invalid optino key on plexus sentinel and add some missing ones ( so at least less of the bars wil be pure white due to blizzard bug)  
    Fix bug where the timer counts weren't enabled on login, as intended  
- bump alpha  
