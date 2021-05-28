# PixelPerfectAlign

Shows exact coordinates and alignment grid, to the physical pixel on your WoW window

Can be used for alignment or measurement of your UI, or before pretty screenshot or just to enjoy the sight of exactly 1 pixel grid/crosses rendered.

It will automatically use a square of even horizontal and vertical spacing of the crosses for standard aspect ratio like 4:3, 16:9, 16:10 and non standard ones too.

The optional cursor coordinates are shown in both the actual pixel coordinates and the UIParent coordinate spaces (and raw worldframe coordinates in 1.5+).

If you click while in this mode, you can start a measuring box and showing the corners coordinate and distance:

The measurements you made are now saved in a window once you click, so you can copy paste to save them (see screenshot images for example). 

Mouse over and click the minimap button or use `/ppa` to see commands or `/ppa conf` for config options, `/ppa toggle` to toggle grid on/off, `/ppa info` for display info, etc...
There are also optional keybindings for toggling grid and coordinates on/off as well as the display info.

If you find a case where the crosses aren't showing evenly or not exactly 1 pixel; please take a screen shot and comment about your setup, using /ppa bug

Most of the heavy lifting code is in https://github.com/mooreatv/MoLib a reusable library

MoLib can be used, like this addon, to draw on screen pixel perfect lines of exactly 1 pixel width/height or or UI elements like Blizzard textures without glitches when moved/placed.

Get the binary release using curse client or compatible addon manager or on wowinterface or on github

The source of the addon resides on https://github.com/mooreatv/PixelPerfectAlign

Releases detail/changes are on https://github.com/mooreatv/PixelPerfectAlign/releases

Screenshots etc on https://www.curseforge.com/wow/addons/pixel-perfect-align/screenshots

Works on both Classic 1.13.6 and Shadowlands
