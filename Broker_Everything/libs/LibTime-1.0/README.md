# LibTime-1.0 (WoW AddOn Library)
![Build](https://github.com/hizuro/LibTime-1.0/actions/workflows/bigwigsmods-packager.yml/badge.svg)
![Tag](https://img.shields.io/github/v/tag/hizuro/LibTime-1.0?style=flat-square)
![Downloads](https://img.shields.io/github/downloads/hizuro/LibTime-1.0/total?style=flat-square)
![Downloads](https://img.shields.io/github/downloads/hizuro/LibTime-1.0/latest/total?style=flat-square)
&nbsp; &nbsp; &nbsp; &nbsp;
[![Patreon](https://img.shields.io/badge/&zwj;-Patreon-gray?logo=patreon&color=red&style=flat-square)](https://www.patreon.com/bePatron?u=12558524)
[![Paypal](https://img.shields.io/badge/&zwj;-Paypal-gray?logo=paypal&color=blue&style=flat-square)](https://paypal.me/hizuro)
![Sponsors](https://img.shields.io/github/sponsors/hizuro?logo=github&style=flat-square)


## Description
A little library around date, time and GetGameTime and more...


## To use in addons
```lua
lib = LibStub("LibTime-1.0")
```

## API

### GetGameTime
This library detecting the seconds of server time. The fourth return value is a boolean to signalize sycronization. It needs min. a minute to get sync from login.
```lua
hours, minutes, seconds, secondsSynced = lib.GetGameTime( )
```

### GetLocalTime
```lua
hours, minutes, seconds = lib.GetLocalTime( )
```

### GetUTCTime
```lua
GetUTCTime( [<inSeconds>] )
```

**Example:**
```
hours, minutes, seconds = lib.GetUTCTime( )
seconds = lib.GetUTCTime(true) -- seconds since 1.1.1970 0:00
```

**Arguments:**
inSeconds - (optional) boolean

**Return values:**
hours - integer
minutes - integer
seconds - integer

### GetCountryTime
```lua
GetCountryTime( <countryId>[, <inSeconds> ] )
```
**Examples:**
```lua
hours, minutes, seconds, countryName = lib.GetCountryTime( 98 )
seconds = lib.GetCountryTime(17,true)
```

### GetTimeString
```lua
GetTimeString("GameTime|LocalTime|UTCTime|CountryTime"[, b24Hours[, displaySeconds[, countryId]]])
```

**Examples:**
```lua
"00:00" = lib.GetTimeString("GameTime",true)
"00:00:00" = lib.GetTimeString("LocalTime",true,true)
"00:00:00 AM" = lib.GetTimeString("UTCTime",false,true)
"00:00 PM" = lib.GetTimeString("CountryTime",false,false,23)
```

### iterateCountryList
```lua
for id, name in lib.iterateCountryList() do
end
```



## My other projects
* [On Curseforge](https://www.curseforge.com/members/hizuro_de/projects)
* [On Github](https://github.com/hizuro?tab=repositories)

## Disclaimer
> World of Warcraft© and Blizzard Entertainment© are all trademarks or registered trademarks of Blizzard Entertainment in the United States and/or other countries. These terms and all related materials, logos, and images are copyright © Blizzard Entertainment.
