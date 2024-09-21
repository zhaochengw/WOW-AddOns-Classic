# DBM - Core

## [11.0.14](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.0.14) (2024-09-20)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.0.13...11.0.14) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- fix some random typed characters that leaked through  
- Prevent nil errors in test mode when mods call sorting on names that reference raids table that hasn't been created. Probably needs to just return a player mock instead but at very least this keeps some tests from failing outright  
    prep new tag  
- Update koKR (#1249)  
- Core:  
     - Delves no longer auto reply to whispers automatically  
    Princess  
     - Added personal announce to queen's bane since at this point it doesn't seem like blizzard is gonna fix private aura.  
     - Fixed deathmasks timer using wrong object type  
     - Added orbs timer on heroic and mythic  
- Fixed bug hwere initial tank debuff timer after intermission was not updated for live values on kyveza  
- actually set story difficulty  
- Fix queen ansurek for story difficulty  
- Update Mythic and LFR Rashanan timers  
    Fixed one bad timer on heroic.  
- Fix a few various issues I saw in raid tonight, also closes https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1251#issuecomment-2357512826  
- Fix two errors  
- Fix a bug where watchers still used old mark  
- bump alpha  
