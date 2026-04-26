# Details! Damage Meter

## [Details.20260424.15009.171](https://github.com/Tercioo/Details-Damage-Meter/tree/Details.20260424.15009.171) (2026-04-24)
[Full Changelog](https://github.com/Tercioo/Details-Damage-Meter/compare/Details.20260422.15002.171...Details.20260424.15009.171) 

- But fixes for 12.0.5  
- Fix deathlog getting a smaller tooltip when pressing shift.  
- Fix statusbar mini-display for encounter elapsed time.  
- Fixed HPS number below 1000  
- Fix Streamer plugin  
- Add demon hunter devastation icon, fix specIds on framework level.  
- Framework Update  
- Fix alpha spec icons.  
- [AI] Refactor Details:BaseFrameSnap()  
    Root cause of the original bug: The three-loop approach (direct neighbors → retrograde chain → forward chain) had no mechanism to prevent a frame from being anchored twice. For example, with windows A←B←C, when C called BaseFrameSnap: the first loop anchored B to C, then the retrograde loop tried to anchor A to B using B.snap — but B may already have A in its snap table pointing back toward C. This created the circular dependency.  
- Cooltip errors fix  
