# Hekili

## [v5.5.2-1.0.0n](https://github.com/Smufrik/Hekili/tree/v5.5.2-1.0.0n) (2025-10-30)
[Full Changelog](https://github.com/Smufrik/Hekili/compare/v5.5.1-1.0.0m...v5.5.2-1.0.0n) [Previous Releases](https://github.com/Smufrik/Hekili/releases)

- Refactor Death Knight Unholy rotation and improve resource handling  
    - Updated precombat actions to ensure unholy presence is applied correctly.  
    - Enhanced cooldown management with new variables for advanced ICD and cooldowns running out.  
    - Adjusted single target and cleave actions to better utilize unholy blight and plague leech based on resource availability.  
    - Improved resource formatting in SnapshotUtil to handle non-numeric values and ensure proper display of resource states.  
    - Modified resource advancement logic in State.lua to only apply regeneration when the resource is a valid table, preventing errors with numeric placeholders.  
- chore(release): add notes for v5.5.1-1.0.0m (MoP Classic)  
