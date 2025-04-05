# Details! Damage Meter

## [Details.20250331.13502.162](https://github.com/Tercioo/Details-Damage-Meter/tree/Details.20250331.13502.162) (2025-03-31)
[Full Changelog](https://github.com/Tercioo/Details-Damage-Meter/compare/Details.20250311.13444.162...Details.20250331.13502.162) 

- Wrapping all mythic+ updates for the new scoreboard addon  
- Merge pull request #889 from linaori/fix-nil-error  
    Fix nil error where object is expected  
- The CLEUEventAmount and CLEUEventTime were removed from being set in another commit causing Destroy with nil instead of object  
- Added combat:GetCrowdControlSpells(actorName); combat:GetDamageTakenBySpells(actorName)  
- Update the crowdcontrol cache within the parser file  
- New table for crowd control spells  
- Added combat.bloodlust\_overall which stores time() of when a loot lust was used, only exists in merged segments, example the m+ end segment.  
- Added timeStart and timeEnd to combat class, this is the time() of when the combat start and ended. timeEnd may not exists if the combat does not  finished yet.  
- Merge pull request #887 from linaori/fix-time-local-overwriting  
    Fixed an issue where the time global function was overwritten by a local  
- Fixed an issue where the time global function was overwritten by a local  
- Start a M+ run after 10 seconds of CHALLENGE\_MODE\_START. This instead of listening WORLD\_STATE\_TIMER\_START.  
- Merge pull request #880 from Gogo1951/patch-3  
    Update Details\_Classic.toc  
- Merge pull request #886 from NayooZ/master  
    Update parser.lua  
- Update parser.lua  
    Comment out debug print statement that occurs on zone entry  
- Update Details\_Classic.toc  
    Updated Interface for latest version of Classic Era, SoD, and Anniversary Edition.  