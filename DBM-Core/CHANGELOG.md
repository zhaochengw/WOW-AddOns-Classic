# <DBM Mod> Raids (DF)

## [10.2.37](https://github.com/DeadlyBossMods/DeadlyBossMods/tree/10.2.37) (2024-04-29)
[Full Changelog](https://github.com/DeadlyBossMods/DeadlyBossMods/compare/10.2.36...10.2.37) [Previous Releases](https://github.com/DeadlyBossMods/DeadlyBossMods/releases)

- prep new core tag too  
- Support multiple retail tocs for war within alpha  
- Fixed a bug that caused cinematic skip options to not be shown in GUI on wrath classic  
- Pull boss mod basics and difficulty handling out of core (#1070)  
- Icon notes and tweaks  
- migrate several icons to numeric type system  
- Define icon types and check for legacy ones still using true/false (and flag them as warnings)  
    (assuming I did this right)  
- improve SpecFlags  
- accept "movetostatue" for voicepack audio  
- Hacky support for more auto spec role filling on more common objects.  
- Update localization.es.lua (#1069)  
- Load World Events mod in SoD based on DMF schedule  
- Disable Lua Check global warnings in favor of LuaLS  
- Use voice enum for EnablePrivateAuraSound (#1068)  
- Fix custom path for :Play(): can use asset IDs  
- Update localization.es.lua (#1065)  
- cleanup extended icon hack stuff. blizzard fixed that ages ago and isn't adding official icon extention any time soon  
- Fix https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1064  
    Fix https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1063  
- Enabling warnings for globals that we write  
    By default LuaLS allows us to implictly declare a global by writing to  
    it, whereas LuaCheck didn't allow this. Since we don't want to write to  
    many globals it's better to require them to be explicitly declared in  
    .luarc.json.  
    Unlike LuaCheck this unfortunately doesn't support regular expressions  
    to define the set of allowed globals, this will be fixed in  
    https://github.com/LuaLS/lua-language-server/pull/2629 soon hopefully.  
- Use GetSpellName api instead of GetSpellInfo in all places that only care about name  
- Also add key to cctype  
- Define enum for DispelType  
- Update localization.es.lua (#1059)  
- Update localization.es.lua (#1058)  
- Icons: cleanup (#1060)  
- Ignore target on pull timer if person targetted is someone in raid.  
- Raszageth update:  
     - Static Charge target warning will also use shorttext name  
     - Hurricane Wing will now have a cast bar til it ends  
     - Hurricane Wing will now announce when it has ended with positve green text and "safe now" TTS alert  
- Fix all issues in https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1056  
- Rescope definition of "Easy dungeon" to now just be follower and normal. heroic is the new mythic 0 and should not be treated as trivially as in the past. This basically makes it so now trash warnings show up by default in heroic dungeons and up instead of just mythic 0 and up (as per season 4 and later, heroic is the new mythic 0 and the new mythic 0 is basically the old mythic 10)  
- Use GetSpellName in war within when we only need name and not entire table  
- prevent a lua error on war within when calling GetSpellTexture with a nil spellId, the api throws error now (as opposed to live of just failing silently  
- Update koKR (#1055)  
- lol luacheck failing on whitespace in a commented line  
- Sadly, BW didn't agree with using countdown to also support universal supporting break timers. They'd rather support multi minute pull timers so changing DBM to supporting multi miniute pull timers and back to no break timers for non boss mod users.  
- Update localization.ru.lua (#1054)  
- unregister unused spellId  
- Fixed a bug where broodkeeper was referencing wrong timer going into stage 2 when setting the new icy timer  
    Fixed a bug on RAszageth where breath timer could show wrong count due to CLEU event being too slow (switched to unit event which is way faster)  
    Closes https://github.com/DeadlyBossMods/DeadlyBossMods/issues/1053  
- Add PT message when trying to send pull timers too large.  
    Match blizzards cancelation rule of canceling for negative integers too and not just 0  
- Allow 1 minute break timers  
- some consistency tweaks  
- Migrate to also using blizzard countdown for break timers  
    Fixed not blocking blizzard countdowns in combat on 10.2.7 and higher.  
    used more consistent naming conventions between break and pull timer functions.  
- Fix GetIcon object  
- Refix two things off top of head  
- More modularization in core (#1045)  
    Co-authored-by: Adam <MysticalOS@users.noreply.github.com>  
- micro adjust a few timers for Season 4 Vault  
    Added nameplate cooldown timer for Add interrupts on Dathea  
    Also converted aerial slash Cd to namepate only on dathia  
    And fixed interrupt warning not showing on all difficulties on dathia  
- Bump alpha  
