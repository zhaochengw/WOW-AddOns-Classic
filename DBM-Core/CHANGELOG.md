# DBM - Core

## [11.0.5](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.0.5) (2024-09-03)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.0.3...11.0.5) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- Fix a typo that slipped through testing (since 0 of those objects existed at time of tag)  
    Prep new tag to push typo fix and callback updates out  
- split nameplate only timers into a different simpType so it's easy for weak auras to filter nameplate only timer object as they wish  
- bump alpha  
- prep new tag  
- Update localization.ru.lua (#1211)  
- Update localization.es.lua (#1212)  
- Update localization.fr.lua (#1213)  
- Update localization.ru.lua (#1210)  
- Update koKR (#1209)  
- Update localization.ru.lua (#1208)  
- - some more lua check  
- - luacheck  
- - Adding glow support for expiring NP icons  
- - Adding LibCustomGlow  
- - Dynamically update options on nameplate timers  
- add priority flag to regular timer object too, and use it in test mode interrupt bar  
- Create a new timer arg called "isPriority" that will be used to flag priorty casts or cooldowns for use with 3rd party addons and weak auras that can use this flag to treat these timers with extra flourish such as glow. It'll also be used internally by DBMs built in nameplate feature as well for glow as well.  
    Also prepped code for nameplate cast timers (this object will ONLY be used for priority spells, period)  
- change callback behavior  
- tweak couple strings  
- Don't strip tools folder out of packaging  
- Prep new nameplate features  
- Tests: Fix import if ENCOUNTER\_START/END is the only event in a frame  
- Tests: Remove debug code  
- CI: Fix LuaCheck warnings  
- Tests: Add import UI  
- LuaLS: Use regex feature for global Fonts  
- Tests: Move Transcriptor filter rules to Shared/Data  
- Tests: Handle logs where the recorder casts no spells  
- Tests: Fix messages on test end  
    Local timewarp variable was 0 for "infinite" speed  
- Tests: Fix error for InfoFrame usage with invalid names  
- Tests: Add explicit taint for tests from Playground  
- Tests: Make a better job at guessing instance info for logs without DBM debug data  
- Core: Hide InfoFrame when disabling DBM  
- GUI: Play click sound for dropdown earlier  
    Sounds more responsive  
- Update 1 silken Court spell key (key we used made more sense, but WA compat is more important)  
    Cancel timers earlier on bloodtwister (start point remains unchanged)  
- Full pass on raid to add a lot more alternate spellids/short names  
- Tests: Make test tools available in WoW environment  
    This CL is basically a big no-op as it doesn't add any parsing in the  
    game yet, it just splits the CLI-specific parts from the generic parts.  
- Add further protection against Paul's unconventional timer object usage on FlightTimers.  
    While at it, also just make code more robust against misuse in general from external sources too so it doesn't error or write garbage into table if someone writes into table.  
- clear note  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1191  
- improve CC annotation  
- Fix nil table index error for objects that don't actually have a spellId  
- Update difficulties and zones for Sod Phase 4  
- Fix bug with wrath missing module popup  
- further work on auto populating short text table for Plater  
- Preliminary work for plater to be able to pull our short/custom text as well.  
    Currently supports all announce objects (special and normal)  
    Most timer objects. Some niche timer objects need some work first before adding to API, but it's in a usable state now and will only return valid custom names. Just not ALL of them (yet)  
- Update localization.br.lua (#1200)  
- Update koKR (#1205)  
- Update commonlocal.br.lua (#1204)  
- Update commonlocal.fr.lua (#1203)  
- Update commonlocal.es.lua (#1202)  
- Update localization.fr.lua (#1199)  
- Update localization.es.lua (#1198)  
- Update localization.tw.lua (#1196)  
- Update commonlocal.tw.lua (#1197)  
- Tests: Fix playground UI for tests that use EJ ids to identify the mod under test  
- Tests: Add class info if available  
- Tests: Keep real GUIDs when not anonymizing names  
- Tests: Resolve some Lua 5.1 vs. 5.4 discrepancies  
- Tests: Add simple parser for Transcriptor files to support Lua 5.1  
- Fix LuaLS error for updated EncounterInfo signature  
- Fix lint  
- GUI: Add test and perspective selection to playground mode  
- GUI: Fix completely inexplicable bug that happens if the very first thing you click is a playground panel  
- Tests: Track Playground panel per mod, not globally  
    Previously we always created playground panels for all mods in an addon if they were loaded with test support for whatever reason. Track this per mod instead.  
- Tests: Add "allOnYou" option that rewrites every event to target you and come from you  
    Just like perspective shifting this doesn't work for everything, but most things do work  
- Tests: Respect most user options in playground mode  
- Tests: Pass the reporter object to the TestStop callback instead of the report itself  
    I initially didn't do this because I didn't want callbacks to potentially mess with the report, but it seems useful, especially as we might add different report formats  
- GUI: Add lazy dropdowns that load their contents only when you click on them  
- Core: Add warning on pull if DBM was used in test mode with time warping  
- Core: Clear all timing-related state on DBM:Disable()  
- Update localization.tw.lua (#1193)  
- LuaLS: Update for https://github.com/Ketho/vscode-wow-api/commit/a1deeb87763aeceee16cfbdf887ccfa40c6acb7b renaming  
    Doing it like this works with both the old and new definition  
- Tests: Make dev UI available in all builds  
    Errors due to diffs are hidden in non-alpha builds to not give the wrong impression about a diff meaning something is broken  
- Tests: Inject extra UNIT\_POWER\_UPDATE events  
- Core: Add extra target parameter to AntiSpam  
    To distinguish multiple different targets for the same event without having to dynamically assembly an ID  
- Tests: Make loading timewarp setting more reliable  
- bump alpha  
