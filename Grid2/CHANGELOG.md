# Grid2

## [2.8.0](https://github.com/michaelnpsp/Grid2/tree/2.8.0) (2024-02-07)
[Full Changelog](https://github.com/michaelnpsp/Grid2/compare/2.7.3...2.8.0) [Previous Releases](https://github.com/michaelnpsp/Grid2/releases)

- Classic TOC Update  
- BugFix: Added a guard to avoid changing frame size while in combat (github issue #201)  
- Fixed Grid2Options range status crash in an edge case (github issue #200)  
    Fixed incorrect method name in RangeAlt status.  
    Fixed RangeAlt default value for retail.  
- Disabled "Cast Start" option in AOE&Damage statuses (CF issue #1280)  
- Refactor Debuffs Group status configuration.  
    Refactor color settings for Buffs and Debuffs.  
    Added new debuffType-Boss status, this status displays boss debuffs.  
    Now coloring by debuff type in debuffs groups use debuffType-Boss color for boss debuffs.  
- Removed some unused variables.  
- BugFix: Auras dispell Type management was broken (github issue #199)  
    Feature: Added Relevant/Non-Relevant debuffs filter to debuffs groups.  
- Using custom function to calculate blizzard buffs, because AuraUtil function is too slow and custom function is compatible with all wow clients.  
- Minimal style change in display combine stacks code.  
- Removed some unused code.  
- Optimizations and bug fixes in debuffs "combine stacks" code.  
- Added "Combine Stacks" option to Debuffs Groups statuses.  
- Refactored debuff "combine stacks" code.  
- Removed unused function.  
- Better implementation of buffs groups strict filter (CF issue #1278)  
- Added a option to "Buffs" groups to enable the status only when all listed buffs are active on the unit (CF issue #1278)  
- Added optional blizzard behaviour for Resurrection status (only enabled when resurrection is being cast).  
- Bugfix: "blizzard buffs" status was not working in retail.  
- Retail: Refactor to use C\_UnitAuras.GetAuraDataByIndex() instead of UnitAura()  
- Fixing bug in Resurrection status (CF issue #1277).  
- Merge pull request #198 from michaelnpsp/refactor-custom-headers  
    Refactor custom headers, added targettarget and focustarget headers.  
- BugFix: custom header unit not updated when the same unit is used in several headers.  
- Now targettarget and focustarget units can be used in the layout editor.  
    Now targettarget and focustarget units can be used in indicators/statuses load filters.  
    Bug Fixes in custom group headers code.  
- Added targettarget and focustarget units.  
    Optimizations in custom headers events code.  
    Buf Fixes.  
- Optimization: Now RegisterUnitEvent() is used for UNIT\_TARGET event.  
- Minimal optimization.  
- New custom headers refactor, moving most faked units management code to GridGroupHeaders.lua  
- Some optimizations in the custom headers code.  
- Initial commit, refactor and added support for targettarget & focustarget.  
