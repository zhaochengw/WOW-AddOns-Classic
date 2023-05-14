WoW classic has no profession API, but profession info can be fetched using GetTradeSkill... functions.
This library provides methods that wraps the API calls and works the same way on both classic and BfA. This makes it easy to create cross-platform addons.

Usage:

Add these lines to your addons toc file:

`libs\LibStub\LibStub.lua
ProfessionApi.lua
LibProfessions.lua
CurrentProfession.lua`

Include the library in your addon:

`local professions = LibStub("LibProfessions-1.0")`