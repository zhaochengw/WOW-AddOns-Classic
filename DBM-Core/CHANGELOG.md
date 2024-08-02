# DBM - Core

## [11.0.2](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/11.0.2) (2024-07-28)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/11.0.1...11.0.2) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new tag  
- Tests: Give mods more time to detect a wipe if necessary (#1171)  
- Tests: restructure UI a bit (#1170)  
- AnnoyingPopup: Simplify logic (#1168)  
- Update koKR (#1169)  
- Update localization.tw.lua  
- Update localization.ru.lua (#1165)  
- fix link  
- Update localization.ru.lua (#1163)  
- Update koKR (#1164)  
- improve instructional language  
- Also support M+ dungeons for that alert  
- Fix delves and molten core showing needless + sign. that was bad copy and paste from Mythic+  
    Add regular vanilla, wrath, and cata raid popups  
    Fix wago url for vanilla raid module  
- Show more annoying nag if important raid mods are missing (#1162)  
- Push core fixes for delve loading timing  
- Fix last to actually use faster function on retail  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1159  
    Fixes cross realm pull timers no longer working in pre patch. Also fixes pull timers never fully working correctly in Classic Era and Classic Cata  
- Tests: strip prefix when auto-generating test report files  
- Tests: pre-fill more metadata based on educated guesses when generating tests  
- Tests: parse difficulty modifier from Transcriptor logs  
- Tests: update transcriptor filter  
- Tests: fake player debuff on test start for MC heat levels  
- Core: don't special-case unnamed AntiSpam() calls  
    This avoids a somewhat obscure problem in tests: it was generating a  
    trailing whitespace in the record because the check result gets removed  
    from an array with a hole due to the previous nil-value.  
- Add new nil warning object to avoid a LuaLS nil checking bug (#1158)  
- Fix and close https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1160  
- bump alpha  
