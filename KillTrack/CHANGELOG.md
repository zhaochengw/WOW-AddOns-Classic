# KillTrack

## [v2.31.0](https://github.com/SharpWoW/KillTrack/tree/v2.31.0) (2022-05-08)
[Full Changelog](https://github.com/SharpWoW/KillTrack/compare/v2.30.0...v2.31.0) [Previous Releases](https://github.com/SharpWoW/KillTrack/releases)

- Improve names in artifact build step  
- Store addon zips as build artifacts  
- Add tracking of when a mob was last killed  
    Can be seen in a tooltip in the GUI list view, or when querying data  
    about a mob via slash commands.  
    Implements #19  
- Configure Lua version for project  
- Use consistent font style in options  
- Fix minimap command not working properly  
- Switch to using a single package (multi-toc)  
- Update supported interface versions in TOC  
- Fix tooltip behaviour on classic clients  
    When the mouse leaves a unit on classic clients,  
    the UPDATE\_MOUSEOVER\_UNIT event fires, unlike on retail.  
    This led to the tooltip text being duplicated whenever the user moved  
    the mouse off a unit, and the tooltip staying on screen because of the  
    `Show` method on `GameTooltip` being called after it should be hidden.  
    Hooking the `OnTooltipSetUnit` script on `GameTooltip` instead proves  
    to be a more reliable method that works across all clients.  
- Update URLs for externals  
