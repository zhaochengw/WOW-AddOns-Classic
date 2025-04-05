***********************************
Scrolling Combat Text Versions 6.2
***********************************

Website - http://grayhoof.wowinterface.com/

What is it? - A fairly simple but very configurable mod that adds damage, heals, and events (dodge, parry, windfury, etc...) as scrolling text above you character model, much like what already happens above your target. This makes it so you do not have to watch (or use) your regular combat chat window and gives it a "Final Fantasy" feel.

What can it do?

- Damage messages, with glancing and crushing indicators
- Heals (incoming and outgoing) and Overhealing (with healer ID's), with filtering for small heals.
- Outgoing heals can be shown over friendly player nameplates
- Spell Damage/Resists and Damage Type
- All "Miss" events (dodge, block, immune, etc...)
- Reflected Damage tracked and displayed (if available)
- Custom Colors for all text events
- Config file to setup custom events (self and target), capture data, and display it.
- Debuff/Buff gain and loss Messages
- Low Health and Mana Warnings with values, and optional sounds
- Rage/Mana/Energy Gains
- Enter and Leave Combat Messages
- Rogue Combo Points, 5 CP Alert Message
- Class Skill alerts (Execute, Overpower, CounterAttack, etc...)
- Honor, Reputation, Skill Gain
- Eight Animation Types (Verticle, Rainbow, Horizontal, Angled Down, Angled Up, Sprinkler, Curved HUD, Angled HUD)
- Five Fonts with option to pick up more using ShareMedia
- Two seperate Animation frames, each with their own settings. Assign any Event to either.
- Ability to flag any event as critical or as a text messages
- Sliders for text size, opacity, animation speed, movement speed, and on screen placement (with custom editbox)
- Now Based in Ace3.
- Settings saved per character by default, but supports all Ace3 Profiles
- Load/Delete settings from another character. Load built in Profiles.
- Localized to work in almost all WoW clients.

How do I use it? - First unzip it into your interface\addons directory. For more info on installing, please read install.txt. Now just run WoW and once logged in, type /sctmenu to get the options screen.

SCT_EVENT_CONFIG.LUA is used to setup custom message events. Please open up the file (notepad, etc...) and read the opening section to understand how to use it all. PLEASE NOTE - THIS IS THE MOST IMPORTANT FILE IN SCT. IF YOU DON'T READ IT AND USE IT, THEN YOU ARE MISSING OUT ON A TON OF WHAT SCT HAS TO OFFER IN CUSTOMIZATION

/sctdisplay is used to create your own custom messages.
Useage:
/sctdisplay 'message' red(0-10) green(0-10) blue(0-10)
Example: /sctdisplay 'Heal Me' 10 0 0 - This will display 'Heal Me' in bright red

FAQ
How do I get My Crits or My Hits to show? I would suggest you get SCTD: http://www.wowinterface.com/downloads/fileinfo.php?id=4913

I don't understand what the 2 frames are for! - Each frame lets you set different features. So you can set frame one using Sprinker animation and Default font, while frame 2 can be using Veritcle animation and Adventure font. You can then assign each event to a specfic frame using the radio buttons next to the events.

There's too many options. Help someone new see how things work! - Try out some of the new built in profiles. While on the options screen, click the "Profiles" button. At the top of the window will be a listing of some default profiles to try out. Maybe you'll fine one you like or it will spark some ideas for you to try.

How do I change the fonts? - You can now select from four fonts on the options page. You can also change the font of message and apply the font to the in game damage font used for your damage (requires relog)

I don't like friendly nameplates on. How do I make my heals appear over who I heal? - Friendly nameplates have to be on in order to show your heals. SCT will turn them on if you turn on the option, but you must manually turn them off if you don't like it (see Target keybindings).

I don't like the new spell icons, how do I turn them off? - There is an option to turn them off under the spell tab.

Support
Please post all errors and suggestions on http://grayhoof.wowinterface.com/ using the provided forms.

Version History
6.2 - Added icon support to the message frame. Added Dispel as a default event. Added Dispel and Cast events as custom event. Cleaned up string and cache code. Use 2.4.3 dispel events.
6.1 - Total rewrite of custom event code. sct_event_config.lua can be still be used for custom events (READ THE FILE), but in game option menu fully supports custom events now. Converted to a faster combat log system. Fix for nameplates in PvP. Fix some options not updating when copying or loading a profile. Convert to LibShareMedia-3.0.
6.01 - Added item buffs to buff events and fade events. Fixed interrupts causing errors with nameplates. Fixed timer call. Fix for custom damage and miss events. Fixed active skill names duplicating. Made fades use buff/debuff color. Fixed display usage message. Added CN translation. Allow fonts to scale down to size 8. Made Blizzard options frame movable. Made Blizzard dropdown clamp to the screen.
6.0 - Converted to WoW 2.4 Combat Log. Converted to Ace3. Custom events completely redone, make sure to read SCT_EVENT_CONFIG.LUA. Moved options menu to WoW 2.4 Addons Menu. Options menu reorganized to be much cleaner and simpler.
5.7 - Added optional EavesDrop style spell icons. Added damage filter. Added selfonly flag to debuff custom events. Made all font sizes change 1 step at a time.
5.61 - Fixed some minor bugs with SharedMedia and Messages.
5.6 - Added SharedMedia for fonts. Cleaned up Drain/Leech events. Added option to turn off WoW's 2.1 healing. Cleaned up Unit Nameplate code.
5.5 - Added Spell Name option. Added Truncating or Abbrevating of spell/buff names. Changed buff/debuff events to use SpecialEventsLib; allows for much better buff and debuff tracking. Added Test Button. Removed Light Mode. Added new Custom Event Buff types for much easier buff/debuff event tracking; see sct_event_config.lua for more info.
5.4 - Added Spell Reflection Tracking; only works when combat log reports events in correct order. Added ability to show outgoing heals over friendly nameplates; see FAQ for more info. Temporarily added manual execute/hammer tracking until blizzard fixes 60+ skill auto tracking. Added pet buffs to power gain tracking.
5.31 - Added Diablo Font. Fixed Chat Tab Tainting. Fixed Rampage event to use 20 rage. Fixed Overhealing bug. Fixed Gap Slider not working on all frames.
5.3 - Made spell colors editable. Added interruption events. Added killing blow events. Added Rampage Notification (not 100% prefect, but works most of the time). Cleaned up crit overlapping more. Fixed custom event sorting/parsing issues. Made heal filter based on total amount actually healed (so overhealing spam can be removed). Removed compost lib. Added SpecialEvents-Aura lib (will do more in future with it).
5.2 - Converted to WoW 2.0 standards. Added Text Alignment to Frame: Left, Center, Right, or HUD (based on position around HUD) justified. Added new HUD Curved Animation: moves in a semi circle around your character, ideal for use with curve based HUD bars. Added new HUD Angled Animation: moves in a slight angle around your character, ideal for use with angle based HUD bars. Added Gap Distance to HUD Animations to change the distance they are from center. Made Crits overlap less often. Made spammed text behave better. Made Custom events save to the event that triggers them after being found, improves performance over time.
5.11 - Added glancing and crushing indicators. Added outgoing HOT flag. Added Emblem font. Fixed slider edit box bug.
5.1 - Total new look for options window. Added mana gain filter. More speed optmizations around passed args and function calls. Modified custom events so only events for current class are loaded (make sure to use this for you own events). Option window opens while dead =). Converted all table iterators to use pairs().
5.01 - Slight speed optmizations around passed args and function calls. Added more default events to event file. Added buff counts. Made heal filter defaults to zero.
5.0 - Complete rewrite using Ace2 and ParserLib with more performance in mind. Two seperate animation frames. Angled Up, Sprinkler, and Flash Crit animations. New Skill event. Seperate Buff and Debuff fading. Sounds to health/mana warnings. Color spell damage by spell type. Toggle for Custom events (improves performance when off). Light mode, users WoW's new built in events to gain performance, at the cost of a few features. Sample messages when changing options. Editboxes to position sliders. Sounds to custom events. Healer filter option.
4.131 - Very minor bug fixes and updates.
4.13 - Made options frame its own LoadOnDemand mod, options frame is now moveable, added ability to set animation type for custom events, minor buf fixes and tweaks
4.12 - Mainly just bug fixes and code changes needed for SCTD and other future mods.
4.11 - Added your overhealing, all power gains, and FPS mode as options, Added various new damage/power events, Added CTMod support, changed underlying option format for better saving size, added enter/leave world event optimization, Added Spanish support, various minor bug fixes and tweaks.
4.1 - Added Message options for all events, Added Healer ID, Added Your Heals and Skill gain as events, Added new globalization event parser, Added FD check for hunters and low warnings, added most all chat events to a new sct_event_config variable for searching on custom events, added debug code to show chat events, added ismsg for custom events, Added message text options for positioning, fade duration, size, and font, localized option page, added flag to set in game damage to same font as SCT, many other minor tweaks and changes.
4.01 - Fixed rainbow text fade point, Fixed horizontal text Y offset, Improved Execute/Wrath messages, fixed custom events not occuring in index order, fixed resets when massive spam, made resets alpha based
4.0 - Added 3 new animations, 3 new fonts, text positioning, Execute/Wrath events, Reputation events, crit flag for all events, New Profile load/delete, better font sizing, font Outline options, font Direction options, removed troll berzerk message. Special Thanks to Dennie for his Chinese Version of SCT that provided the inspiration for most of these changes.

For full version history, please see here: http://grayhoof.wowinterface.com/portal.php?&id=41&pageid=11