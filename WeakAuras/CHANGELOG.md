# [5.4.0](https://github.com/WeakAuras/WeakAuras2/tree/5.4.0) (2023-03-14)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/5.3.7...5.4.0)

## Highlights

 - Add Spec Position load option
- Add warning for custom code auras with COMBAT_LOG_EVENT_UNFILTERED and no filter
- Add a Count filter to some triggers
- Add a new Delay option to some triggers
- Item trigger: add %quality and %qualityTexture
- BT2: Add a condition for "buffed" check for Group/Combine Matches/All
- Aura trigger: use new API for retail
- BT2: Add softenemy/friend support
- Add support for AddonLocale
- Cast trigger: add "Empowered Charged" overlay
- Lots of smaller changes and fixes 

## Commits

BannZay (1):

- register ARENA_OPPONENT_UPDATE event on wrath

Casey Raethke (1):

- Add support for queued spell costs (#4331)

Hekili (1):

- For talent selector, force tooltip not to override.  Use original icon if overridden (i.e., Raze overrides Maul, Elemental Blast overrides Lava Burst).

InfusOnWoW (15):

- Fade Animation: Add error handler to SetAlpha call
- Fix regression caused by 7fd46bbb623f
- Progress Texture: Fix Texture Rotation property only allowing *10 values
- Add arg1 to untrigger call for unit events
- Fix AuraEnvironment not being deactived if the stacks functions errors
- Cast: Fix lua error on casting not empowered channeled spells
- Tweak AuraBars to hopefully work around mask funkyness
- Global Conditions: Fix wrong state in some cases
- Update: Fix edge case in Update code with anchoring to frames
- BT2: Add a condition for "buffed" check for Group/Combine Matches/All
- Templates: Work around Blizzard bug with Evoker empowered spells
- SubModel: Call ClearAllPoints before setting them
- Conditions: On trigger delete correctly modify conditions
- Fix atlas textures if use full rotation is enabled for atlas textures (#4288)
- Only show charged overlay if enabled in the trigger

Stanzilla (1):

- Update config and contributing guide

Vardex (1):

- Add support for AddonLocale (#4277)

dev-fatal (1):

- Fixed pronouns in buff trigger language

emptyrivers (3):

- fix ignored value checks
- softenemy/friend support in BT2 (#4266)
- add stagger stat

mrbuds (22):

- Remove warning message in chat for CLEU without filter, and reword the warning slightly
- Add Spec Position load option
- Add warning for custom code auras with COMBAT_LOG_EVENT_UNFILTERED and no filter
- Cleanup unused code in WeakAuras.CheckTalentSpellId
- Remove unused arguments on Private.EndEvent
- Fix Private.UpdateTalentInfo
- Add newFeatureString
- Add a Count filter to some triggers
- Add a new Delay option to some triggers
- Item Count trigger: rename quality to reagentQuality, and qualityTexture to reagentQualityTexture
- Item Count trigger: restore conditions from before quality change
- Item Count trigger: fix error when making new trigger
- Item trigger: add %quality and %qualityTexture
- Aura trigger: use new API for retail (#4244)
- Fix IsClassic => IsClassicEra in Types.lua
- rename Classic to ClassicEra
- Purge handling of TBC
- Models & SubModels: use model_fileId on wotlk
- Model SubRegion: prevent bad model data to raise an Lua error
- anchorFrameType sort options
- Add Screen anchor
- Cast trigger: add "Empowered Charged" overlay

