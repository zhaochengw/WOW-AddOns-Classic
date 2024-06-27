# DBM - Core

## [10.2.49](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/10.2.49) (2024-06-22)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/10.2.48...10.2.49) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new release  
- Update koKR (#1123)  
- Update localization.ru.lua (#1122)  
- Update localization.tw.lua (#1121)  
- Update README.md  
- pkgmeta update  
- Move delves to dungeon mods. Thinking forward, it's gonna be multi expansion/old content and it makes sense to bundle it with the best package that is that, dungeons.  
- tweaks to debug messages to reduce unneeded/obsolete ones or reclassify spammy ones in right debuglevel  
- switch to PLAYER\_MAP\_CHANGED for loadless instance ID changes in TWW, previous code still in place to handle caverns til TWW prepatch  
    Some debug tweaks  
- Show up to date on 1.14.3 PTR  
- create an auto localized gossip option since these are becoming more and more common.  
- Fix couple of bugs introduced by recent changes to delves. A lot more stuff will be added this week, but wanted to at least fix these while fresh before adding new  
- Bump MapChallengeMode  
- Update delve boss Ids with all newest bosses added recently. This should improve win conditions in most delves.  
- visual and location for this are both obvious, so disabling this for now  
- Small Ulgrax update:  
     - Spell Key syncing for WAs  
     - Tweaked phase changes to also more align with BW (but still using one I was using for same reason as before as fallback, DC/reload protection)  
     - Brutal lashings tweaks to add in red yell texts  
     - Fixed some bad copy/paste spell keys for hardened and stalker netting.  
     - Confirmed the early phase 2 was a fluke and added phase change timer after comparing like 20 WCL pulls  
- Add type checks for announce:Show() arguments based on announce type  
- Update koKR (#1115)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR (Retail)  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * koKR locale for warwithin prep  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * revert core locale  
    * Delves kr locale initializing  
    * koKR Update  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
    * Update koKR  
- Fix two missing counts that failed in the dev test  
- Fix a missed timer  
- Fix timer objects on finished Rashanan mod  
- Forgot to hit save on this one  
- first cleanup pass  
- Push the finished Rashanan mod  
- Couple quick fixes from bloodhbound debug  
- Fix one last bug where a race condition can occur from two abilities that happen at same time.  
- More tweaks  
- Fix several bugs found on first boss (almost all missing count)  
- Minor test updates (#1117)  
- Fix bad messaging  
- forgot to remove event  
- Kill spammy alert  
- minor redundant code cleanup, no functionality changes  
- Fix missing count  
- Fix two Kyveza bugs  
    Tank warnings now throttled to fix spam  
    Some timers and counts not incrementing cause wrong CID of bosses two fight CIDs were used in filters  
- Update localization.tw.lua (#1116)  
- bump alpha  
