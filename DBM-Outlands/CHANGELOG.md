# <DBM> Outlands

## [2.5.29](https://github.com/DeadlyBossMods/DBM-TBC-Classic/tree/2.5.29) (2022-02-22)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-TBC-Classic/compare/2.5.28...2.5.29) [Previous Releases](https://github.com/DeadlyBossMods/DBM-TBC-Classic/releases)

- prep new tags  
- bump toc files  
- changing it back to spellId because that's only way i won't fuck it up  
- minor sync  
- Update commonlocal.fr.lua (#78)  
- Add support for range 6 in TBC, Closes https://github.com/DeadlyBossMods/DBM-TBC-Classic/issues/104 Also fixed a regression that dates back to unified core where TBC and classic would show ranges in drop down that are unavailable.  
- and one more regression i missed  
- Fixed regressionn that caused some stage warnings to get grouped funny.  
- Adds left fix will work better if the adds left object isn't also called \"adds\"  
- Gui Updates: - Fixed AddsLeft warnings getting filtered (not grouped) with improved object identification - Added ability to group Generic Announce and Special Announce objects with optional spellID argument  
- Update soul scream timer to match the data from logs (#105)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- Updated new GUI parsing to properly handle achievement timer objects, which exist in a lot of wrath and mop content.  
- Fixed a bug that caused crushed icon description to be missing. While at it, upgradedd object to show used icons, respect global disable, and lastly use better icons so it doesn't mess with icons usually used to. mark mobs.  
- bump alpha versions  
