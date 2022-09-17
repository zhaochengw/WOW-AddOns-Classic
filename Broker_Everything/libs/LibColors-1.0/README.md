# LibColors-1.0 (WoW AddOn Library)
![Build](https://github.com/hizuro/LibColors-1.0/actions/workflows/bigwigsmods-packager.yml/badge.svg)
![Tag](https://img.shields.io/github/v/tag/hizuro/LibColors-1.0?style=flat-square)
![Downloads](https://img.shields.io/github/downloads/hizuro/LibColors-1.0/total?style=flat-square)
![Downloads](https://img.shields.io/github/downloads/hizuro/LibColors-1.0/latest/total?style=flat-square)
&nbsp; &nbsp; &nbsp; &nbsp;
[![Patreon](https://img.shields.io/badge/&zwj;-Patreon-gray?logo=patreon&color=red&style=flat-square)](https://www.patreon.com/bePatron?u=12558524)
[![Paypal](https://img.shields.io/badge/&zwj;-Paypal-gray?logo=paypal&color=blue&style=flat-square)](https://paypal.me/hizuro)
![Sponsors](https://img.shields.io/github/sponsors/hizuro?logo=github&style=flat-square)

## Short description
A library to easy coloring strings by hex codes, color tables, class names, color names and more.

## Supported types

* hex code with 8 and 6 characters. `[<alpha>]<red><green><blue>` like 9E342C (alpha is optional)
* color table in two variants: `{ <red[number]>, <green[number]>, <blue[number]>, <alpha[number](optional)> }` or `{ ["r"] = <{ <red[number]>, ["g"] = <green[number]>, ["b"] = <blue[number]>, ["a"] = <alpha[number](optional)> }`
* class names supports english and localized names on non english clients
* ITEM_QUALITY_COLORS as quality[number] and lower string version of ITEM_QUALITY[number]_DESC
* or keywords
  * playerclass will be relaced with the current players class color
* second parameter must not be a string to coloring it
  * not set second parameter returns hex color code
  * the string "colortable" as second parameter returns the requested color as color table

## To use in addons

```lua
lib = LibStub("LibColors-1.0")
```

## API

### num2hex
Convert a number between 0 and 1 into a hex code between 00 and ff

```lua
string = lib:num2hex( number )
```

### colorTable2HexCode
Converts numeric or associative color tables into a 8 character long hex color code.

```lua
assoc_table = { r = 0.8, g = 0.8, b = 0.1, a = 1 }
numeric_table = {
	0.8, -- red
	0.8, -- green
	0.8, -- blue
	1 -- alpha
}
string = lib:colorTable2HexCode( table )
```

Any not defined or nil table entry will be ignored.
An empty table returns the hex code for the color white.

### hexCode2ColorTable
Converts a hex code into a color table

```lua
table = lib:hexCode2ColorTable( string )
```

### coloset
Add a single color code

```lua
lib:colorset( string, string or table )
```

or add a list of color codes

```lua
table = { ["color name"] = color string or color table } lib:colorset( table )
```

### color
Create a colored string like `|c<color><string>|r`

```lua
string = lib:color( color, string )
```

as first parameter you can use colors names, color tables or keywords
currently implemented keyword for color are "playerclass"
as second parameter you can use normal text or a keyword
currently implemented keyword for second parameter are "colortable"
that returns the requested color as colortable.

### getNames
the parameter are optional and used to return matching color names.

```lua
table = lib:getNames( [string] )
```

## Available colors

### Direct integrated

```lua
colors = {
	-- basic colors
	yellow = "ffff00",
	orange = "ff8000",
	red = "ff0000",
	violet = "ff00ff",
	blue = "0000ff",
	cyan = "00ffff",
	green = "00ff00",
	black = "000000",
	gray = "808080",
	white = "ffffff",
	-- wow money colors
	money_gold = "ffd700",
	money_silver = "eeeeef",
	money_copper = "f0a55f",
}
```

### Color sets in extra files
You can find 3 files named colors_<name>.lua in the directory and in LibColors-1.0.xml the lines to use it.
The sources for the color sets are on top of the files.


## My other projects
* [On Curseforge](https://www.curseforge.com/members/hizuro_de/projects)
* [On Github](https://github.com/hizuro?tab=repositories)

## Disclaimer
> World of Warcraft© and Blizzard Entertainment© are all trademarks or registered trademarks of Blizzard Entertainment in the United States and/or other countries. These terms and all related materials, logos, and images are copyright © Blizzard Entertainment.
