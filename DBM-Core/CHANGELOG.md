# Deadly Boss Mods Core

## [2.5.8](https://github.com/DeadlyBossMods/DBM-TBC-Classic/tree/2.5.8) (2021-06-29)
[Full Changelog](https://github.com/DeadlyBossMods/DBM-TBC-Classic/compare/2.5.7...2.5.8) [Previous Releases](https://github.com/DeadlyBossMods/DBM-TBC-Classic/releases)

- prep release  
- Sync  
- Sync update  
- Fix CoT\_BlackMorass Portal Timers (#32)  
    * Fix CoT\_BlackMorass Portal Timers  
    UPDATE\_UI\_WIDGET triggers off the wrong widgetID  
    See: https://wow.tools/dbc/?dbc=uiwidget&build=2.5.1.39170#page=1&search=3120  
    * Update PortalTimers.lua  
    Co-authored-by: Artemis <QartemisT@gmail.com>  
- add range 28 to range checker code  
- Fix stupid  
- Add another public facing stage api, this time one that lets mods or weak auras request current stage a mod is in (if applicable) for either specific mod by mod id OR by simply doing request without modId, and having DBM just give a return for first mod in combat table  
- Add an icon clear to nightbane when dragon lands  
- And the rest of them  
    Plus fixed a bug where brute set sync revision twice  
- Phase change code expects there to be ONE encounterId present, and in each flavor of game only one id is actually used, so it has to be coded this way instead since blizzard for some reason decidedd to give encounters new Ids in classic instead of using retail ones. 🤷‍♂️  
    Tier 5 and 6 not done yet  
- Reset blast target on combat start, and phase change.  
- kara/nightbane: add smoking blast spec warn (massive healing needed) (#30)  
    * kara/nightbane: add smoking blast spec warn (massive healing needed)  
    * Update Nightbane.lua  
    Any special warning should always support voice packs  
    spam checking timestamp isn't needed here, there are two logic flaws with the 15 second method. If target dies boss is gonna change targets earlier then that and DBM wouldn't announce it, it'd also announce same target again even if it doesn't change. That's unnessesary, instead we'll just mark the victim with star and only announce when it changes and people will just know to "heal star"  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- missed one spot  
- Add combat messge about slam on gruul as well  
    Also disable the silence timer, a timer with a 32-130 second variation is not worth having a timer for at all.  
- improve blast nova timer  
- Fix icons for Kargath. These were set to a weird grass texture for some reason?  
- Add a temporary combat start message to maiden explaining timer  
- Only show gift warning to healers  
    Its just a healer mechanic to "not heal this target or it heals boss", nobody else cares.  
- Bump alpha  
