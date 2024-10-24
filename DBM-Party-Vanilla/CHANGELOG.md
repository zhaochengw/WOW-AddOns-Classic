# DBM - Dungeons, Delves, & Events

## [r164](https://github.com/DeadlyBossMods/DBM-Dungeons/tree/r164) (2024-10-20)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-Dungeons/compare/r163...r164) [Previous Releases](https://github.com/DeadlyBossMods/DBM-Dungeons/releases)

- Scope all remaining Season 1 dungeons with zone event filters  
    Dawnbreaker now has initial timers for trash ability nameplates  
    Fixed a bug in dawnbreaker wehre ensnaring shadows didn't cancel for summoned nightfall shadowmages  
    Fixed abug in dawnbreaker where Umbrel rush didn't cancel for any nightfall shadowwalkers  
- City of Threads Update:  
     - Fixed a bug Null Slam timer object didn't cancel for auras using callback by adding missing creatureId for Hallows Resident  
     - Moved xeph combat end detection to new zone combat handler, making it more efficient.  
     - Added initial nameplate timers for all mobs  
     - Scoped mod event handlers  
- timer tweak from testing  
- now that system is working, can start making timer corrections the debug detects :D  
- fix invalid modId  
- Preliminary support for initial nameplate timers on pull and stopping nameplate timers on trash wipes for arakara.  
    also added zone scoping to reduce overhead of mods event handlers running in other dungeons.  
- increase darkness comes timer. apparently tooltip is a lie  
- Update koKR (#298)  
- adjustments for https://github.com/DeadlyBossMods/DBM-Dungeons/issues/300  
- switch blightbone to the slower repeat scanner since there are reports the instant scanner doesn't always work  
- remove redundant call  
- be more aggressive in filtering non combat mobs  
- fix double registered creatureId in boralus trash  
- Update localization.ru.lua (#294)  
- Clarify forge speakers to actually say what you're actually supposed to  do during exhaust vents in both alert and voice packs  
    also removed exhaust event over event and message as it's mostly a distraction.  
- Update stonevault timers that changed with this weeks hotfixes  
- Add missing count. closes https://github.com/DeadlyBossMods/DBM-Dungeons/issues/295  
- Add hotfixed Id for tank buster on Coaglamation  
- improve clarity of dark eruption  
- Upgrade averting shrill to special announce. thought I had done that sooner.  
- tweak last  
- Mark Tongue Lashing as frontal ability in Mists of Tirna (#293)  
