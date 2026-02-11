HunterTrapsBar – Version 2 (Clean Rewrite)

V.2.1
-  "/htb panic" now resets scale and position to default
- added details for each command when using /htb
- disabled addon from creating the bar when you're not a hunter


This version is a ground-up rewrite of HunterTrapsBar.

Goals:
- No legacy libraries
- No automatic repositioning
- Deterministic visibility
- Manual positioning only
- Clear, maintainable architecture

Notes:
- Existing SavedVariables may be reset in early V2 builds
- V2 prioritizes stability and clarity over backward compatibility

This rewrite exists to improve long-term maintainability.
