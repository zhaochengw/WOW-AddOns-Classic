# DBM - The Burning Crusade mods

## [r15](https://github.com/DeadlyBossMods/DBM-BurningCrusade/tree/r15) (2026-03-15)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-BurningCrusade/compare/r14...r15) [Previous Releases](https://github.com/DeadlyBossMods/DBM-BurningCrusade/releases)

- Prevent loading of options on 55 boss mods on retail (they'll still load and record stats). This is the number of dungeon, delve, and scenario bosses that blizzard doesn't support with boss mod api  
- more cleanup  
- Remove deprecated functions: (rangeframe, hud, arrow)  
    due to buggy diffs, some regressions may be possible since it's harder to verify nothing was accidentally removed  
- modernize CI  
