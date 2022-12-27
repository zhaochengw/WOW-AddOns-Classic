## 1.47
- Bump TOC Interface version to 10.0.2

## 1.46
- Bump TOC Interface version to 10.0.0

## 1.45
- Bump TOC Interface version 9.2.7
- Add support for WotLK Classic
	- This is untested, please report any errors

## 1.44
- Add more textures from Inokis of Curse

## 1.43
- Add textures from Inokis of Curse
- Add support for Classic/BC Classic
	- This is untested, please report any errors

## 1.42
- Bump TOC Interface version to 9.2.5

## 1.41
- Add support for custom textures (contributed by @markgravity)

## 1.40
- Prevent indicators from being hidden by disabled higher-priority indicators

## 1.39
- Bump TOC Interface version to 9.1

## 1.38
- Add Target of Target indicator
- Refactor checking of other indicators to priority-based system

## 1.37
- Bump TOC Interface version to 9.0.5

## 1.36
- Bump TOC Interface version to 9.0.1

## 1.35
- Bump TOC Interface version to 8.3

## 1.34
- Remove mention of ElvUI from unit token error message
	- ElvUI fixed the issue on 2018-10-11:
	- https://git.tukui.org/elvui/elvui/issues/602#note_9808

## 1.33
- Bump TOC Interface version to 8.2
- Update library URLs in .pkgmeta

## 1.32
- Add missing translations to CurseForge

## 1.31
- Update license with reference to new CONTRIBUTORS file
- Add verification for missing nameplate unit tokens
	- This will throw a clear error when a nameplate doesn't have a unit token (which TNI requires to function) instead of throwing a generic usage error for the UnitIsUnit function.
	- This is usually caused by AddOns that replace the default nameplates, e.g. ElvUI or EKPlates.
- Improve number validation in the config GUI.
	- There are now usage messages for numeric options.
	- Width and Height are now restricted to positive numbers.
	- Opacity is now restricted to numbers between 0 and 1.
	- X and Y offsets now accept negative numbers.
	- This now uses Lua's built-in number parsing instead of relying on pattern matching.

## 1.30
- Update TOC Notes tag to reflect the current functionality

## 1.29
- Add config GUI
- Remove old config files

## 1.28
- Change indicators to display below most UI elements
- Prevent multiple indicators from displaying on the same unit
- Add separate config files for each unit
- Add config options to control the opacity of indicators

## 1.27
- Add support for a separate focus indicator

## 1.26
- Fix LibNameplateRegistry not being packaged correctly by the BigWigs packager script

## 1.25
- Bump TOC Interface version to 8.0
- Add .travis.yml file and TOC properties for the BigWigs packager script
	- https://www.wowinterface.com/forums/showthread.php?t=55801

## 1.24
- Add support for a separate mouseover indicator

## 1.23
- Add support for separate self target indicator options (for the class resource bars, which are implemented as a nameplate)
- Add per-target type option to show/hide target indicator

## 1.22
- Add support for separate friendly and hostile target indicator configurations

## 1.21
- Bump TOC Interface version to 7.3

## 1.20
- Another new release to try and fix CurseForge packager error. MrFlamegoat says it should be fixed now.

## 1.19
- New release to try and fix CurseForge packager error.

## 1.18
- Use consistent spelling of reticule in config.lua
- Fix comment of RedChevronArrow texture not mentioning OligoFriends' Curse profile
- Add Red Hunter's Mark Arrow texture provided by thisguyyouknow of Curse

## 1.17
- Bump TOC Interface version to 7.2
- Add textures from ContinuousQ of Curse
- Fix Notes tag in TOC to mention options in config.lua instead of core.lua

## 1.16
- Add explanation of when changes will take effect to config.lua

## 1.15
- Change the default texture back to Reticule
- Fix typo in file name of neon green arrow texture

## 1.14
- Move configuration variables into config.lua
- Move textures to Textures directory
- Add screenshots to the repository
	- They won't be packaged with the AddOn
- Add neon green arrow texture provided by Nokiya420 of Curse

## 1.13
- Fix LibStub and CallbackHandler not being included in the packaged AddOn

## 1.12
- Bump TOC Interface version to 7.1
- Update LibNameplateRegistry to 0.18T
- Change the `LNR_ERROR_FATAL_INCOMPATIBILITY` callback to use the correct `incompatibilityType` values and remove ones that are no longer used by LNR
- Remove handlers for callbacks that are no longer fired by LNR
- Remove Ace3 from the OptionalDeps and X-Embeds TOC tags
	- TNI doesn't actually use Ace3 at all
- Rename .pkgmeta to pkgmeta.yaml for CurseForge's new packager

## 1.11
- Bump TOC Interface version to 7.0
- Add to p3lim's AddOn Packager Proxy

## 1.10
- Add textures from Imithat of WoWI

## 1.09
- Bump TOC Interface version to 6.0

## 1.08
- Trim trailing spaces
- Add DEBUG flag to enable/disable debugging output
- Replace all debugging print() calls with debugprint() calls
- Wrap debugprint() calls in --@debug@/--@end-debug@ so CurseForge packager comments them out
- Add FindGlobals tools-used reference in .pkgmeta
- Add OptionalDeps and X-Embeds tags to TOC as recommended by LibNameplateRegistry
- Rewrite around LibNameplateRegistry-1.0
- Update for 5.4
- Add three new textures

## 1.07
- Added red/green 3D arrow and skull and crossbones textures provided by OligoFriends of Curse/WoWI
- Not updating LibNameplate for now, the latest alpha versions don't seem to work very well.

## 1.06
- Added red inverted chevron textures provided by OligoFriends of Curse/WoWI

## 1.05
- Updated LibNameplate-1.0 to r145 for the nameplate changes in 5.1. This version of the library is still in alpha, so please report any errors or strange behaviour.

## 1.04
- Added neon textures provided by mezmorizedck of Curse
- Renamed the reticule texture to Reticule.tga and changed the TEXTURE_PATH variable's default value to match

## 1.03
- Updated LibNameplate to version 1.0.36, which should fix the GetNumRaidMembers error
- Updated TOC to 5.0

## 1.02
- Added a red arrow texture provided by DohNotAgain of WoWI
- Added more detail to the comments at the top of core.lua, including stuff about custom textures, GIMP and texture contribution.

## 1.01
- Changed default texture to read targeting reticule contributed by Dridzt of WoW Interface.
- Doubled the default width/height

## 1.00
- AddOn created. Hooray!