# DBM - Core

## [12.0.42](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/12.0.42) (2026-04-24)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/12.0.41...12.0.42) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag  
- Add additional routing to Late Stage 3 pulls of mythic crown.  
    Add ignores for erratic bar restarts that appeared with 12.0.5 for mythic stage 1 crown.  
- remove 12.0.1 compat code, take 2 (CN and KR updated now)  
- impliment more surgical handling of timeline api in hardcoded modules that now considers if a user has disabled DBM bars. if they have, timeline api for countdowns and colors will be used in hardcoded modules  
- Add missing icon  
- Preliminary Mythic Lura mod up to P4 start. No actual P4 stuff yet as debuglog was only up to P4 start  
- use fallback for cases where LSM exists but isn't registered yet  
- Bump alpha  
    Fix some gui layout issues on midnight  
