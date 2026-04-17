# Hekili

## [v5.5.3-1.0.0y](https://github.com/Smufrik/Hekili/tree/v5.5.3-1.0.0y) (2026-03-01)
[Full Changelog](https://github.com/Smufrik/Hekili/compare/v5.5.3-1.0.0x...v5.5.3-1.0.0y) [Previous Releases](https://github.com/Smufrik/Hekili/releases)

- feat: enhance Vengeance tracking for MoP tanks and update related logic across various specs  
- Merge branch 'main' of https://github.com/Smufrik/Hekili  
- Refactor and enhance class abilities and priorities for various specs  
    - Mage Fire: Added talent check for Rune of Power in ability handler.  
    - Paladin Retribution: Introduced two new trinket abilities with handlers for cooldown management.  
    - Death Knight Blood: Updated action lists for cooldowns and defensives, incorporating Shiego Logic for aggressive mitigation.  
    - Death Knight Frost: Adjusted mind freeze action to react to target casting.  
    - Death Knight Unholy: Modified mind freeze action to react to target casting.  
    - Rogue Subtlety: Enhanced Hemorrhage handling with new conditions for usage and updated spell ID for the DoT.  
    - Shaman Elemental: Removed wait action during Shamanistic Rage to optimize casting.  
    - Shaman Enhancement: Allowed hardcasts during Shamanistic Rage to prevent dead time.  
    - Warlock Demonology: Ensured last\_cast\_time is properly registered across state resets.  
    - Options: Fixed type conversion for current spec in pack control and standardized health stone naming.  
    - State: Improved ability lookup logic to handle unknown abilities more gracefully.  
    - UI: Enhanced glow handling for abilities and adjusted cooldown settings for ElvUI compatibility.  
- Initialize embedded SpellFlashCore to enable SpellFlash in MoP Classic (#130)  
    * feat: implement SpellFlashCore bootstrap and button counting functions  
    * fix: Initialize embedded SpellFlashCore to enable SpellFlash in MoP Classic  