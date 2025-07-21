# DBM - Core

## [11.2.4](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.2.4) (2025-07-20)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.2.3...11.2.4) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag and bump force update to force library updates (so users avoid deprecated errors if other addons update library first. although caveat, this means users of OTHER addons will get deprecated errors from those addons until they update. but better to be first than last)  
- update version check  
- SendChatMessage future proofing  
- LibSpec updates.  
- More fixes  
- change placement to fit load order  
- Handle upcoming IsSpellKnown api changes  
- Tests: Fix bad non-deterministic sorting of some timers with no spell id (#1694)  
- Tests: Fix anonymizing names in RAID\_BOSS\_WHISPER messages (#1693)  
- bump alpha  
