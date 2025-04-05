--[[
  MoLib (Database part) -- (c) 2019 moorea@ymail.com (MooreaTv)
  Covered by the GNU Lesser General Public License v3.0 (LGPLv3)
  NO WARRANTY
  (contact the author if you need a different license)
]] --
-- our name, our empty default (and unused) anonymous ns
local addonName, _ns = ...

local ML = _G[addonName]

ML.modb = {} -- assumes saved var will restore the actual DB

--[[
  Time series DB

  option 1 : pooling
    live/dead combat/not combat    resting/not resting   level, xp, hp, gold [,mana]

    gold increase: loot, [trading, selling at vendors buying at vendors]
    gold decrease: repair, trading

  option 2 : events


  normalize stuff:
  - item db : classic vs mainline
  - seller db ?

  - region/realm

  - submitted id (by battle.net)

  ]]

