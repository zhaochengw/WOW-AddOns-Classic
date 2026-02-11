Merfin = Merfin or {}
local Merfin = Merfin

local screenWidth, screenHeight = GetPhysicalScreenSize()
local resolution = screenWidth >= 2560 and "QUAD_HD" or "FULL_HD"

local function GetProfileResolution()
  return resolution
end

Merfin.Left = function(newPositions, activeRegions, spacing, sizes, maxIcons)
  local totalIcons = #activeRegions

  if WeakAuras.IsOptionsOpen() and maxIcons then
    totalIcons = math.min(totalIcons, maxIcons)
  end

  local iconWidth = sizes.w
  local iconHeight = sizes.h
  local startX = 0

  for i = 1, totalIcons do
    local region = activeRegions[i]
    local xPos = startX - (i - 1) * (iconWidth + spacing)

    region.region:SetRegionWidth(iconWidth)
    region.region:SetRegionHeight(iconHeight)

    newPositions[i] = { xPos, 0 }
  end
end

Merfin.CenteredHorizontal = function(newPositions, activeRegions, spacing, sizes, maxIcons)
  local totalIcons = #activeRegions

  if WeakAuras.IsOptionsOpen() and maxIcons then
    totalIcons = math.min(totalIcons, maxIcons)
  end

  local iconWidth = sizes.w
  local iconHeight = sizes.h
  local totalWidth = totalIcons * iconWidth + (totalIcons - 1) * spacing
  local startX = -totalWidth / 2 + iconWidth / 2

  for i = 1, totalIcons do
    local region = activeRegions[i]
    local xPos = startX + (i - 1) * (iconWidth + spacing)

    region.region:SetRegionWidth(iconWidth)
    region.region:SetRegionHeight(iconHeight)

    newPositions[i] = { xPos, 0 }
  end
end

Merfin.GridLeftUp = function(newPositions, activeRegions, spacing, sizes, maxIconsPerRow, maxIcons)
  local totalIcons = math.min(#activeRegions, maxIcons)

  for i, region in ipairs(activeRegions) do
    if i > maxIcons then
      break
    end

    local row = math.floor((i - 1) / maxIconsPerRow)
    local col = (i - 1) % maxIconsPerRow

    local x = -col * (sizes.w + spacing)
    local y = row * (sizes.h + spacing)

    region.region:SetRegionWidth(sizes.w)
    region.region:SetRegionHeight(sizes.h)
    newPositions[i] = { x, y }
  end
end

Merfin.GridDown = function(newPositions, activeRegions, spacing, sizes, maxIconsPerRow, maxIcons)
  local iconHeightFirstRow = sizes[1].h
  local iconWidthFirstRow = sizes[1].w
  local iconHeightSecondRow = sizes[2].h
  local iconWidthSecondRow = sizes[2].w

  local totalIcons = math.min(#activeRegions, maxIcons)
  local iconsInFirstRow = math.min(maxIconsPerRow, totalIcons)
  local iconsInSecondRow = math.min(maxIconsPerRow, totalIcons - iconsInFirstRow)

  local offsetFirstRow = (iconsInFirstRow * (iconWidthFirstRow + spacing)) / 2 - (iconWidthFirstRow + spacing) / 2
  local offsetSecondRow = (iconsInSecondRow * (iconWidthSecondRow + spacing)) / 2 - (iconWidthSecondRow + spacing) / 2

  for i, region in ipairs(activeRegions) do
    if i > maxIcons then
      break
    end

    local row = math.floor((i - 1) / maxIconsPerRow)
    local col = (i - 1) % maxIconsPerRow

    if row == 0 then
      region.region:SetRegionWidth(iconWidthFirstRow)
      region.region:SetRegionHeight(iconHeightFirstRow)
      newPositions[i] = { col * (iconWidthFirstRow + spacing) - offsetFirstRow, 0 }
    else
      region.region:SetRegionWidth(iconWidthSecondRow)
      region.region:SetRegionHeight(iconHeightSecondRow)
      newPositions[i] = { col * (iconWidthSecondRow + spacing) - offsetSecondRow, -(iconHeightFirstRow + spacing) }
    end
  end
end

Merfin.GridUp = function(newPositions, activeRegions, spacing, sizes, maxIconsPerRow, maxIcons)
  local totalIcons = math.min(#activeRegions, maxIcons)
  local rows = math.ceil(totalIcons / maxIconsPerRow)

  for i, region in ipairs(activeRegions) do
    if i > maxIcons then
      break
    end

    local row = math.floor((i - 1) / maxIconsPerRow)
    local col = (i - 1) % maxIconsPerRow

    local iconsInRow = math.min(maxIconsPerRow, totalIcons - row * maxIconsPerRow)
    local totalWidth = iconsInRow * (sizes.w + spacing) - spacing
    local startX = -totalWidth / 2 + sizes.w / 2

    local x = startX + col * (sizes.w + spacing)
    local y = row * (sizes.h + spacing)

    region.region:SetRegionWidth(sizes.w)
    region.region:SetRegionHeight(sizes.h)
    newPositions[i] = { x, y }
  end
end

Merfin.GroupSortGrid = function(newPositions, activeRegions, settings)
  local totalIcons = math.min(#activeRegions, settings.maxIcons)
  local direction = settings.direction
  local maxIconsPerRow = settings.maxIconsPerRow
  local spacing = settings.spacing
  local iconSizes = settings.iconSizes

  local function getIconSize(row)
    return iconSizes[math.min(row, #iconSizes)]
  end

  local function calculatePosition(index)
    local row, col, x, y
    local size = getIconSize(math.floor((index - 1) / maxIconsPerRow) + 1)

    if direction == "DL" then
      row = math.floor((index - 1) / maxIconsPerRow)
      col = (index - 1) % maxIconsPerRow
      x = -col * (size[1] + spacing)
      y = -row * (size[2] + spacing)
    elseif direction == "DR" then
      row = math.floor((index - 1) / maxIconsPerRow)
      col = (index - 1) % maxIconsPerRow
      x = col * (size[1] + spacing)
      y = -row * (size[2] + spacing)
    elseif direction == "HD" then
      row = math.floor((index - 1) / maxIconsPerRow)
      col = (index - 1) % maxIconsPerRow
      x = col * (size[1] + spacing) - ((maxIconsPerRow * (size[1] + spacing)) / 2 - size[1] / 2)
      y = -row * (size[2] + spacing)
    elseif direction == "HU" then
      row = math.floor((index - 1) / maxIconsPerRow)
      col = (index - 1) % maxIconsPerRow
      x = col * (size[1] + spacing) - ((maxIconsPerRow * (size[1] + spacing)) / 2 - size[1] / 2)
      y = row * (size[2] + spacing)
    elseif direction == "RU" then
      col = (index - 1) % maxIconsPerRow
      row = math.floor((index - 1) / maxIconsPerRow)
      x = col * (size[1] + spacing)
      y = row * (size[2] + spacing)
    elseif direction == "RD" then
      col = (index - 1) % maxIconsPerRow
      row = math.floor((index - 1) / maxIconsPerRow)
      x = col * (size[1] + spacing)
      y = -row * (size[2] + spacing)
    elseif direction == "LU" then
      col = (index - 1) % maxIconsPerRow
      row = math.floor((index - 1) / maxIconsPerRow)
      x = -col * (size[1] + spacing)
      y = row * (size[2] + spacing)
    elseif direction == "LD" then
      col = (index - 1) % maxIconsPerRow
      row = math.floor((index - 1) / maxIconsPerRow)
      x = -col * (size[1] + spacing)
      y = -row * (size[2] + spacing)
    end
    return x, y
  end

  for i, region in ipairs(activeRegions) do
    if i > totalIcons then
      break
    end
    local x, y = calculatePosition(i)
    local size = getIconSize(math.floor((i - 1) / maxIconsPerRow) + 1)
    region.region:SetRegionWidth(size[1])
    region.region:SetRegionHeight(size[2])
    newPositions[i] = { x, y }
  end
end
