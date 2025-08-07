# DBM - Core

## [11.2.5](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.2.5) (2025-08-05)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.2.4...11.2.5) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new core tag  
- fix lua error in MoP challenge modes. closes https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1701 and closes https://github.com/DeadlyBossMods/DBM-MoP/issues/66  
- fix regressions and avoid duplicate callbacks better  
- helps to hit save before pushing.  
- make zone combat scanner more equipped to deal with 3 similtanious mods accessing zone combat scanner at once (affixes, trash, boss)  
- STATICPOPUP\_NUMDIALOGS no longer exists  
- Few timer fixes  
- Replace test data with pull that isn't bugged  
- Push Nexus King updates  
- attempt to avoid lua errors on RU client caused by raid boss whispers that are > 255 string length  
- final micro adjustment to cleanup the DBM offline reports  
- micro adjustments  
- significant reworking of soul hunters since blizzard removed one of phase events i was using before. Plus this ends up being cleaner for all 3 difficulties anyways.  
- Update RU locales (#1695)  
- Update localization.es.lua (#1698)  
- Update localization.es.lua (#1699)  
- fix same bug with death throes  
- fixed bug with void harvest not referencing table as intended  
- eliminate redundant warning  
- Account for observed variances acrossed multiple pulls  
- Add missing mythic spell Void Tear to Araz  
- One timer tweak  
- Add heroic and Mythic timer updates to Naazindhri  
    Made icons compatible with public BW  
- tweak 1 timer to eliminate the 1 remaining refreshed warning  
- Loomithar heroic and mythic updates  
- Cleanup old S1 stuff from affixes module  
- Fix a bug causing wrong missing mod notification in MoP dungeons  
- Fixed a bug where Mythic and MythicPlus could return true in MoP challenge modes (since diffIndex 8 was reused for M+ at end of Challenge mode era)  
