local _, MerfinPlus = ...

local LSM = LibStub("LibSharedMedia-3.0")

function MerfinPlus:RegisterBars()
  LSM:Register("statusbar", "Flatt", [[Interface\Addons\MerfinPlus\Media\statusbar\Flatt.blp]])
  LSM:Register("statusbar", "Merfin Main Texture", [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinTexture.blp]])
  LSM:Register(
    "statusbar",
    "Merfin Plater Border",
    [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinBorderPlater.tga]]
  )
  LSM:Register(
    "statusbar",
    "Merfin Plater Border (1px)",
    [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinBorderPlater_1px.tga]]
  )

  LSM:Register("statusbar", "MerfinMain", [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinMain.tga]])
  LSM:Register("statusbar", "MerfinMainDark", [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinMainDark.tga]])
  LSM:Register("statusbar", "MerfinMainLeft", [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinMainLeft.tga]])
  LSM:Register("statusbar", "MerfinMainRight", [[Interface\Addons\MerfinPlus\Media\statusbar\MerfinMainRight.tga]])
end
