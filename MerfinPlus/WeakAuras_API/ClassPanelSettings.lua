Merfin = Merfin or {}
local Merfin = Merfin

local screenWidth, screenHeight = GetPhysicalScreenSize()
local resolution = screenWidth >= 2560 and "QUAD_HD" or "FULL_HD"

local function GetProfileResolution()
  return resolution
end

local options = {

  ["CastBar"] = {
    ["QUAD_HD"] = {
      ["Healer"] = {
        ["barHeight"] = 25,
        ["barWidth"] = 644,
        ["autoStretch"] = false,
      },
    },
    ["FULL_HD"] = {
      ["Healer"] = {
        ["barHeight"] = 25,
        ["barWidth"] = 644,
        ["autoStretch"] = false,
      },
    },
  },

  ["RotationPanel"] = {
    ["QUAD_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeight"] = 40,
        ["iconWidth"] = 46,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
      ["Healer"] = {
        ["iconHeight"] = 37,
        ["iconWidth"] = 43,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
    },
    ["FULL_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeight"] = 38,
        ["iconWidth"] = 44,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
      ["Healer"] = {
        ["iconHeight"] = 37,
        ["iconWidth"] = 43,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
    },
  },

  ["MainPanel"] = {
    ["Ready"] = "Border",
    ["QUAD_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeightFirstRow"] = 42,
        ["iconWidthFirstRow"] = 42,
        ["iconHeightSecondRow"] = 40,
        ["iconWidthSecondRow"] = 40,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 8,
      },
      ["Healer"] = {
        ["iconHeight"] = 40,
        ["iconWidth"] = 40,
        ["spacing"] = -1,
        ["maxIcons"] = 10,
      },
    },
    ["FULL_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeightFirstRow"] = 40,
        ["iconWidthFirstRow"] = 40,
        ["iconHeightSecondRow"] = 38,
        ["iconWidthSecondRow"] = 38,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 8,
      },
      ["Healer"] = {
        ["iconHeight"] = 38,
        ["iconWidth"] = 38,
        ["spacing"] = -1,
        ["maxIcons"] = 10,
      },
    },
  },

  ["TopPanel"] = {
    ["QUAD_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeight"] = 32,
        ["iconWidth"] = 42,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 8,
      },
      ["Healer"] = {
        ["iconHeight"] = 30,
        ["iconWidth"] = 40,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 10,
      },
    },
    ["FULL_HD"] = {
      ["DPS/TANK"] = {
        ["iconHeight"] = 30,
        ["iconWidth"] = 40,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 8,
      },
      ["Healer"] = {
        ["iconHeight"] = 28,
        ["iconWidth"] = 38,
        ["spacing"] = -1,
        ["maxIcons"] = 14,
        ["maxIconsPerRow"] = 8,
      },
    },
  },

  ["CooldownOnPanel"] = {
    ["QUAD_HD"] = {
      ["ALL"] = {
        ["iconHeight"] = 37,
        ["iconWidth"] = 37,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
    },
    ["FULL_HD"] = {
      ["ALL"] = {
        ["iconHeight"] = 35,
        ["iconWidth"] = 35,
        ["spacing"] = -1,
        ["maxIcons"] = 6,
      },
    },
  },

  ["DefensivesEscapes"] = {
    ["QUAD_HD"] = {
      ["ALL"] = {
        ["iconHeight"] = 37,
        ["iconWidth"] = 37,
        ["spacing"] = -1,
        ["maxIcons"] = 7,
      },
    },
    ["FULL_HD"] = {
      ["ALL"] = {
        ["iconHeight"] = 35,
        ["iconWidth"] = 35,
        ["spacing"] = -1,
        ["maxIcons"] = 6,
      },
    },
  },
}

Merfin.GetOption = function(...)
  local keys = { ... }
  local value = options

  for _, key in ipairs(keys) do
    value = value[key]
    if value == nil then
      return nil
    end
  end

  return value
end

Merfin.SetOption = function(value, ...)
  local keys = { ... }
  local tbl = options

  for i = 1, #keys - 1 do
    tbl = tbl[keys[i]]
    if tbl == nil then
      return false
    end
  end

  tbl[keys[#keys]] = value
  return true
end

Merfin.ResizeCastBar = function(auraName, isHealer)
  local region = WeakAuras.GetRegion(auraName)
  if not region then
    return
  end

  local resolution = GetProfileResolution()
  local options = Merfin.GetOption("CastBar", resolution, isHealer and "Healer" or "DPS/TANK")
  local barWidth, barHeight = options.barWidth, options.barHeight

  region:SetWidth(barWidth)
  region:SetHeight(barHeight)
end

Merfin.SetRotationPanel = function(newPositions, activeRegions, isHealer)
  local resolution = GetProfileResolution()

  local options = Merfin.GetOption("RotationPanel", resolution, isHealer and "Healer" or "DPS/TANK")

  local spacing = options.spacing
  local iconHeight, iconWidth = options.iconHeight, options.iconWidth
  local sizes = { w = iconWidth, h = iconHeight }
  local maxIcons = options.maxIcons

  Merfin.CenteredHorizontal(newPositions, activeRegions, spacing, sizes, maxIcons)
end

Merfin.SetMainPanel = function(newPositions, activeRegions, isHealer)
  local resolution = GetProfileResolution()

  if isHealer then
    local options = Merfin.GetOption("MainPanel", resolution, "Healer")
    local iconHeight, iconWidth, spacing, maxIcons =
      options.iconHeight, options.iconWidth, options.spacing, options.maxIcons
    Merfin.CenteredHorizontal(newPositions, activeRegions, spacing, { w = iconWidth, h = iconHeight }, maxIcons)
    return true
  end

  local options = Merfin.GetOption("MainPanel", resolution, "DPS/TANK")

  local iconHeightFirstRow, iconWidthFirstRow = options.iconHeightFirstRow, options.iconWidthFirstRow
  local iconHeightSecondRow, iconWidthSecondRow = options.iconHeightSecondRow, options.iconWidthSecondRow
  local sizes = {
    [1] = { w = iconWidthFirstRow, h = iconHeightFirstRow },
    [2] = { w = iconWidthSecondRow, h = iconHeightSecondRow },
  }
  local spacing = options.spacing
  local maxIconsPerRow = options.maxIconsPerRow
  local maxIcons = options.maxIcons

  Merfin.GridDown(newPositions, activeRegions, spacing, sizes, maxIconsPerRow, maxIcons)
end

Merfin.SetTopPanel = function(newPositions, activeRegions, isHealer)
  local resolution = GetProfileResolution()

  local options = Merfin.GetOption("TopPanel", resolution, isHealer and "Healer" or "DPS/TANK")

  local spacing = options.spacing
  local iconHeight, iconWidth = options.iconHeight, options.iconWidth
  local sizes = { w = iconWidth, h = iconHeight }
  local maxIconsPerRow = options.maxIconsPerRow
  local maxIcons = options.maxIcons

  Merfin.GridUp(newPositions, activeRegions, spacing, sizes, maxIconsPerRow, maxIcons)
end

Merfin.SetCooldownOnPanel = function(newPositions, activeRegions)
  local resolution = GetProfileResolution()

  local options = Merfin.GetOption("CooldownOnPanel", resolution, "ALL")

  local spacing = options.spacing
  local iconHeight, iconWidth = options.iconHeight, options.iconWidth
  local sizes = { w = iconWidth, h = iconHeight }
  local maxIconsPerRow = options.maxIconsPerRow
  local maxIcons = options.maxIcons

  Merfin.Left(newPositions, activeRegions, spacing, sizes, maxIcons)
end

Merfin.SetDefensivesEscapesPanel = function(newPositions, activeRegions)
  local resolution = GetProfileResolution()
  local options = Merfin.GetOption("DefensivesEscapes", resolution, "ALL")

  local spacing = options.spacing
  local iconHeight, iconWidth = options.iconHeight, options.iconWidth
  local sizes = { w = iconWidth, h = iconHeight }
  local maxIcons = options.maxIcons

  Merfin.Left(newPositions, activeRegions, spacing, sizes, maxIcons)
end
