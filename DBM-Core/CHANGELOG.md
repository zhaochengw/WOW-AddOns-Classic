# DBM - Core

## [11.0.3](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.0.3) (2024-08-23)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.0.2...11.0.3) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Update localization.fr.lua (#1189)  
- Update localization.br.lua (#1190)  
- Update localization.es.lua (#1188)  
- prep new tag  
- Push finished queen mod  
    Ulgrax update  
- Make GetGroupId function more robust by running backup name check through wrapper which has a safer exit (that way we don't nil error when we get a bad unit name from combat log)  
- Update localization.ru.lua (#1185)  
- Tests: Add basic UI infrastructure for playground mode  
- Tests: Make timewarp slider a reusable UI component  
- Tests: Add saved variable to always load mods with test support  
- Tests: Trigger Stop callback if a test gets stopped by the user  
- Tests: Ignore timers that would end on the next frame in reports  
    Yeah, determinism for these is still a problem, I might need to do it the proper way and use a deterministic order for OnUpdate :(  
- Tests: Add GetTestsForMod(mod) helper  
- Tests: Add info from first ENCOUNTER\_START event to Start callback  
- preliminary work on Devour alert and Cd (CD limited to debug mode for now)  
    Disabled Afflicted options for now since it saves unneeded combat checks. Other disabled affixes still in mod though cause it does no harm  
- tweak  
- Tests: Add callbacks for 3rd party integrations  
- Tests: Catch multi-registrations for timewarping frames  
- Remove extra tocs that no longer need to be flagge on wago and curseforge  
    Remove useless tocs that don't need to exist on war within test modules  
- Further tighten more checks to require valid Unit Ids  
- tweak  
- GUI: Auto-load addons if you click on them once  
    No point in requiring an extra click. Still keeping the old frame around to make it show up in case auto-load fails for whatever reason  
- Tests: Anonymize player names used in MONSTER/RAID\_BOSS chats  
- Tests: Add a flag for when DBM was used in test mode during the session  
    We might want to add a warning somewhere based on this, the time warper can seriously mess up things, for example, at the moment AntiSpam breaks outside of tests after running a timewarped test  
- Tests: Add option to pass through errors instead of aggregating them  
- Tests: Support for running tests on mods not explicitly loaded in test mode  
    This will never be perfect, at the moment everything related to hooking globals will not work, e.g., mostly mods calling Unit* functions.  
- Tests: New UI for showing test reports that's used for playground tests  
- Tests: Explicitly split toc for TWW tests  
- Tests: Add taint system that flags tests not running with reproducible defaults  
    This avoids incorrectly reporting errors in playground mode or when using a non-english client  
- Tests: Log target scanning debug info to Transcriptor  
- Add a fix to target scanner for Wrath chinese client always adding realm names to combat log  
- Test updates and fix Sikran warning delay (#1181)  
- fix core bugs where target/focus checks could return false when "ONLY use target or focus" is passed as a check  
- More test updates (#1180)  
- update version check  
- fix some more WoTLK inconsistencies  
- text clarification  
- Fix missing copy operation for warwithin tests  
- Fix one of the wrath client compat issues  
- fix a bug where missing dungeon popup incorrectly showed in grim batol on cataclym classic due to the M+ retail check code  
- Tests: Add support for test anonymization and add Nerub'ar Palace logs (#1172)  
- Fix new luaLS errors?  
- test LuaLS here  
- allow auto logging of sod instanced world bosses  
- so this stops nagging me about errors  
- Mini dragon patch 2 (#1176)  
- Fix some option text that's no longer applicable that was noticed in recent demo video  
- in test mode, nothing is trivial  
- make code a little more LuaLS friendly  
- Fix a bug that's been there since voice pack filter option redesign, but under no circomstance should the notes sound ever be disabled. That's one of it's core features, to play that sound if player name is in note. So yeah, this fixes that bug so once again even if voice packs enabled, notes sound (special announce 5 sound) is always played when utilized  
- bump alpha  
