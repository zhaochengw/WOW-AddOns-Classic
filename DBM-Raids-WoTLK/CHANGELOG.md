# <DBM Mod> Raids (WoTLK)

## [r347](https://github.com/DeadlyBossMods/DBM-WotLK/tree/r347) (2026-03-15)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-WotLK/compare/r346...r347) [Previous Releases](https://github.com/DeadlyBossMods/DBM-WotLK/releases)

- Prevent loading of options on 62 boss mods on retail (they'll still load and record stats). This is the number of dungeon, delve, and scenario bosses that blizzard doesn't support with boss mod api  
- more cleanup  
- Remove deprecated functions: (rangeframe, hud, arrow)  
    due to buggy diffs, some regressions may be possible since it's harder to verify nothing was accidentally removed  
- toc cleanup  
