# <DBM Mod> Raids (MoP)

## [r186](https://github.com/DeadlyBossMods/DBM-MoP/tree/r186) (2026-03-15)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-MoP/compare/r185...r186) [Previous Releases](https://github.com/DeadlyBossMods/DBM-MoP/releases)

- Prevent loading of options on 74 boss mods on retail (they'll still load and record stats). This is the number of dungeon, delve, and scenario bosses that blizzard doesn't support with boss mod api  
- more cleanup  
- Remove deprecated functions: (rangeframe, hud, arrow)  
    due to buggy diffs, some regressions may be possible since it's harder to verify nothing was accidentally removed  
- toc cleanup  
- Fix reported lua error on council of elders  
