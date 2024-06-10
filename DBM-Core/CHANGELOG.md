# DBM - Core

## [10.2.47](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/10.2.47) (2024-06-07)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/10.2.46...10.2.47) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Prep new tag  
- Make all tocs multi toc and support war within versioning so it's clearer addon IS compatible with war within beta  
    Also make all raid mods public to show just how ready DBM has been for war within ;)  
- Restore wrath client compat for C\_Addons  
- Fix error  
- Fix invalid spellId in delves  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1100  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/980  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/979  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1086  
- note updating  
- fix a condition where auto logging would fail if traveling between a mapID set as a special consideration and an instance (special consideration are zones that are known to border other zoneIds without loading screens). The new code will now ensure auto logging can run on situations "secondaryloadcheck" only fires once (instead of twice) by changing the condition ordering. The race condition that existed before for fixing mythic+ logging is now being handled a different way.  
    TL/DR, auto logging for vault and aberus (when set to log whole zone) should be fixed (amirdrassil was never affected).  
- Push voice pack sounds update  
- Misc api docs in boredom  
- Improve PLAYER\_SPECIALIZATION\_CHANGED to only care about player unit  
- Fix dragonflight tests not loading, and while at it prevent them from loading on non retail  
- Don't send incompatible comms on triala ccounts. Closes https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1111  
- Deprecate restart object in all modules  
- delete restart object, it doesn't work. this will allow luacheck to find any mod using it, so it can be replaced with what does work  
- another handful of commons, rest would require a lot of mod or git digging  
- more voice version data  
- Update VoicePackSounds to include new version 17 media, and now also denote versions of all sounds from version 12 up. TODO, denote all files renamed in version 12 as well  
- bump alpha  
