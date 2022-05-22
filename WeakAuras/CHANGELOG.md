# [4.0.0](https://github.com/WeakAuras/WeakAuras2/tree/4.0.0) (2022-05-18)

[Full Changelog](https://github.com/WeakAuras/WeakAuras2/compare/3.7.16...4.0.0)

## Highlights

 This is it. This is the big one. Nested Groups are finally here.

Please read our blog post to learn all about them: https://www.patreon.com/posts/nested-groups-58780348

We also want to thank everyone who reported bugs during the alpha period, it really helped us polish this release.

As usual, this release comes with a ton of bug fixes and minor feature addtions that you can browse in the full changelog. 

## Commits

InfusOnWoW (59):

- Make opening CodeReview much faster
- Fix nil error if direction is not set
- Tweak protected frame warning
- Add a "Match Count Per Unit" check
- Add warnings about protected frames with a link to the wiki
- Fix visibility handling some more
- Add a sound icon for Auras that play sound via a action or a condition
- Deprecate %t, taget in Chat Message/Whisper Sent To
- Aura List: Fix scroll being wonky
- Fixup visibility handling
- Fix "Since Ready" condition
- Fix ActionOptions layout
- Add description for - escape in more places
- Conditions: Add Chat Color option to Chat Action
- Update.lua: Remove unused function
- Tweak Update Summary display
- Fix Warmode load condition
- Enable the auto-filled Instance Type also on classic/tbc
- Fix UpdateFakeTimers to always start from now
- Import: Increase font size
- Rename export options
- Reintroduce warning about tocVersion
- Fix typo in variable name
- Change "In Group" string usage, so that it's better translatable
- Profiling Window: Change "Start" to "Start Now"
- Add missing localization
- Add \ escaping to Name-Realm filter
- NewAura: Fix thumbnail buttons after canceling templates
- Reputation Trigger: Don't include standingId 0
- Texture Picker: Fix empty drop down for strange users
- Add missing color escape resets
- Increase width of Code Review Tree
- ScamCheck: Fix missing custom check
- ScamCheck:ScamCheck: Fix missing overlay functions
- Fix lua error on trying to unregister a buggy event name
- Readd warning for auras from the future
- BT2: Fix indentaion mistake
- BT2: Fix automatic removal of multi auras after 60s
- Options: Fix moving auras showing wrong text replacements
- Check Item Equipped via name instead of item id
- Localize a few error messages
- Preserve order of auras on drag and drop
- Add a scrollbar to the import window
- Move showing of NewAura tab to FillOptions instead of Pick
- Fix inconsistency of text replacements
- Block access to WeakAurasOptions + WeakAurasOptionsSaved
- Add a few entries to the block list
- Options: Refactor visbility flag tracking
- Options: Also cache nameAll
- Make ClearPicks a lot faster
- Remove WeakAuras.UpdateDisplayButton
- Allow dragging/grouping of group auras
- Enable importing for nested groups
- Fix Duplicate not creating nested auras in the right order
- Clear AuraEnvironment recursively
- Rework load tracking for group auras for nested
- Fix scamCheck
- Rewrite Importing of auras
- Make Options window background less transparent

Vardex (2):

- Enable creation of nested group
- Adjust corruption detection for nested

asakawa (1):

- Add headers to bufftrigger2 to aid navigation of settings (#3598)

dependabot[bot] (1):

- Bump actions/upload-artifact from 2 to 3

mrbuds (22):

- Companion: show consolidated update/install nags after login
- add WeakAuras.AddCompanionData to avoid colision between companion addons
- Allow usage of names/units from trigger for whisper destination
- extra Cooldown Progress: typo for showlossofcontrol
- Group icons handle atlas
- Select a group show group tab
- Spell Cooldown: new Loss of Control option
- rangecheck condition: fix indenting
- Fix shift-multiselection with aura installed from "Ready For Install"
- fix error with dual dropdown multiselection
- add newFeatureString for recent new features
- cast trigger: new "advanced caster's target check" option
- new global range check condtion
- add transparent background wa mini logo
- set update/install logo behind animated texture
- stopmotion picker: slow down animation frame rate
- make texture picker handle stopmotion files with settings in name
- Unit Characteristics trigger: add Afk & DND checks
- anchor options tuning for "group by frame", fixes #3570 hide "Anchored To", and show correct anchorPoint option
- library check before loading files
- handle CDR with modRate (#3548)
- dummy commit to fix error in dependency

stako (1):

- fix parry logic in swing timer (#3592)

