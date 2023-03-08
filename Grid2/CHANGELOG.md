# Grid2

## [2.2.9](https://github.com/michaelnpsp/Grid2/tree/2.2.9) (2023-03-06)
[Full Changelog](https://github.com/michaelnpsp/Grid2/compare/2.1.3...2.2.9) [Previous Releases](https://github.com/michaelnpsp/Grid2/releases)

- Update locales  
- Added invert activation option to HealthLow status.  
- Multibar: removed the adjust option, instead added a "fill" and "stretch" settings to horizontal and vertical fit options.  
- Added some missing locales.  
    Minimal cosmetic change in frame settings.  
- Fixing valueMax calculation in multibar indicators.  
- Fixing a bug in overheals percent calculation.  
    Fixing a bug in multibar indicator adjust setting.  
    Simplified textures coordinates calculations.  
- Updated health-current locales  
- Merge pull request #114 from michaelnpsp/feature-multibar-tiling  
    Feature multibar tiling textures  
- Updated multibar locales  
- Fixing a crash in indicator test mode.  
- Refactor multibar configuration options.  
    Fixing a bug in suspended statuses when changing profiles.  
    Fixing a edge case bug in poweralt status.  
    Now indicators with linked statuses can be deleted.  
- Fixing overhealing bug when not including player heals (CF issue #1201)  
    Added an option to health-current status to add shields to health percent (github issue #109)  
- Start refactor of multibar indicator settings.  
- Merge pull request #113 from michaelnpsp/revert-112-feature-bar-tile-texture  
    Revert "Added texture horizontal and vertical tile options for bar indicators"  
- Revert "Added texture horizontal and vertical tile options for bar indicators"  
- Adding wrap and tiling options to multibar and bar indicators textures.  
- Merge pull request #112 from michaelnpsp/feature-bar-tile-texture  
    Added texture horizontal and vertical tile options for bar indicators  
- Finishing tile configuration options for bar indicator.  
- More fixes in status load code and configuration.  
- Fixing role filter crash (github issue #111)  
- More bugfixes in status load code.  
- BugFix: non-unit status filters were not working property.  
- Added a texture horizontal and vertical tile option for bar indicators.  
- Update mana locales  
- Merge pull request #108 from michaelnpsp/status-load-refactor  
    Refactor status load conditions  
- Bugfix in power status.  
- Refactor mana & manaalt statuses.  
- More speed optimizations in mana statuses.  
- Speed optimizations in mana and power statuses.  
- Now Power Resources are displayed for NPCs.  
- Fixing some graphics glitches on mouseover hightlight and border configuration options.  
- Fixing possible crash on text/bar indicators when changing profile.  
- Moved combat filter code from StatusAuras.lua to GridStatusLoad.lua  
- Optimizations in status load code.  
- Finished refactor of statuses load filter code.  
- Moving unit load filters from StatusAuras to GridStatusLoad.  
- Mana status: Added unit reaction/type/role/class filters to Load tab and removed the "show only healers" option.  
- Power status: Added unit reaction/type/role/class filters to Load tab.  
- Moved unit filter code from StatusAura.lua to GridStatusLoad.lua so we can use unit filters in non-aura statuses.  
    Enabled unit filters (reaction/class/role/type) for ManaAlt status.  
- Range Status: Now a friendly and a hostile spell can be configured.  
- Implemented new ManaAlt status (see CF ticket #1195)  
- Now a different status range setting can be configured for each player class.  
    Added a custom spell range option.  
