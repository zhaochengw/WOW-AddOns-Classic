---@type RestockerAddon
local _, RS = ...

local list  = {} ---@type table<number, RsRestockItem>

---@type RestockerConf
Restocker   = Restocker or {}
RS_ADDON = RS

RS.defaults = {
  prefix = "|cff8d63ffRestocker|r ",
  color  = "8d63ff",
  slash  = "|cff8d63ff/rs|r "
}

RS.BAG_ICON = "Interface\\ICONS\\INV_Misc_Bag_10_Green" -- bag icon for add tooltip

function RS:Print(...)
  DEFAULT_CHAT_FRAME:AddMessage(RS.addonName .. "- " .. tostringall(...))
end

RS.slashPrefix = "|cff8d63ff/restocker|r "
RS.addonName   = "|cff8d63ffRestocker|r "

function RS.IsTBC()
  local function get_version()
    return select(4, GetBuildInfo())
  end

  local ui_ver = get_version()
  return ui_ver >= 20000 and ui_ver <= 29999
end

RS.TBC = RS.IsTBC()

function RS:Show()
  local menu = RS.MainFrame or RS:CreateMenu();
  menu:Show()
  return RS:Update()
end

function RS:Hide()
  local menu = RS.MainFrame or RS:CreateMenu();
  return menu:Hide()
end

function RS:Toggle()
  return RS.MainFrame:SetShown(not RS.MainFrame:IsShown()) or false
end

RS.commands = {
  show    = RS.defaults.slash .. "show - Show the addon",
  profile = {
    add    = RS.defaults.slash .. "profile add [name] - Adds a profile with [name]",
    delete = RS.defaults.slash .. "profile delete [name] - Deletes profile with [name]",
    rename = RS.defaults.slash .. "profile rename [name] - Renames current profile to [name]",
    copy   = RS.defaults.slash .. "profile copy [name] - Copies profile [name] into current profile.",
    config = RS.defaults.slash .. "config - Opens the interface options menu."
  }
}

--[[
  SLASH COMMANDS
]]
function RS:SlashCommand(args)
  local command, rest = strsplit(" ", args, 2)
  command             = command:lower()

  if command == "show" then
    RS:Show()

  elseif command == "profile" then
    if rest == "" or rest == nil then
      for _, v in pairs(RS.commands.profile) do
        RS.Print(v)
      end
      return
    end

    local subcommand, name = strsplit(" ", rest, 2)

    if subcommand == "add" then
      RS:AddProfile(name)

    elseif subcommand == "delete" then
      RS:DeleteProfile(name)

    elseif subcommand == "rename" then
      RS:RenameCurrentProfile(name)

    elseif subcommand == "copy" then
      RS:CopyProfile(name)
    end

  elseif command == "help" then

    for _, v in pairs(RS.commands) do
      if type(v) == "table" then
        for _, vv in pairs(v) do
          RS.Print(vv)
        end
      else
        RS.Print(v)
      end
    end
    return

  elseif command == "config" then
    InterfaceOptionsFrame_OpenToCategory(RS.optionsPanel)
    InterfaceOptionsFrame_OpenToCategory(RS.optionsPanel)
    return

  else
    RS:Toggle()
  end
  RS:Update()
end


--[[
  UPDATE
]]
function RS:Update()
  local currentProfile = Restocker.profiles[Restocker.currentProfile]
  wipe(list)

  for i, v in ipairs(currentProfile) do
    tinsert(list, v)
  end

  if Restocker.sortListAlphabetically then
    table.sort(list, function(a, b)
      return a.itemName < b.itemName
    end)

  elseif Restocker.sortListNumerically then
    table.sort(list, function(a, b)
      return a.amount > b.amount
    end)
  end

  for _, f in ipairs(RS.framepool) do
    f.isInUse = false
    f:SetParent(RS.hiddenFrame)
    f:Hide()
  end

  for _, item in ipairs(list) do
    local f = RS:GetFirstEmpty()
    f:SetParent(RS.MainFrame.scrollChild)
    f.isInUse = true
    f.editBox:SetText(tostring(item.amount or 0))
    f.reactionBox:SetText(tostring(item.reaction or 0))
    f.text:SetText(item.itemName)
    f:Show()
  end

  local height = 0
  for _, f in ipairs(RS.framepool) do
    if f.isInUse then
      height = height + 15
    end
  end
  RS.MainFrame.scrollChild:SetHeight(height)
end


--[[
  GET FIRST UNUSED SCROLLCHILD FRAME
]]
function RS:GetFirstEmpty()
  for i, frame in ipairs(RS.framepool) do
    if not frame.isInUse then
      return frame
    end
  end
  return RS:addListFrame()
end



--[[
  ADD PROFILE
]]
---@param newProfile string
function RS:AddProfile(newProfile)
  Restocker.currentProfile       = newProfile ---@type string
  Restocker.profiles[newProfile] = {} ---@type RsRestockItem

  local menu                     = RS.MainFrame or RS:CreateMenu()
  menu:Show()
  RS:Update()

  UIDropDownMenu_SetText(RS.MainFrame.profileDropDownMenu, Restocker.currentProfile)


end


--[[
  DELETE PROFILE
]]
function RS:DeleteProfile(profile)
  local currentProfile = Restocker.currentProfile

  if currentProfile == profile then
    if #Restocker.profiles > 1 then
      Restocker.profiles[currentProfile] = nil
      Restocker.currentProfile           = Restocker.profiles[1]
    else
      Restocker.profiles[currentProfile] = nil
      Restocker.currentProfile           = "default"
      Restocker.profiles.default         = {}
    end

  else
    Restocker.profiles[profile] = nil
  end

  UIDropDownMenu_SetText(RS.optionsPanel.deleteProfileMenu, "")
  local menu                    = RS.MainFrame or RS:CreateMenu()
  RS.profileSelectedForDeletion = ""
  UIDropDownMenu_SetText(RS.MainFrame.profileDropDownMenu, Restocker.currentProfile)

end

--[[
  RENAME PROFILE
]]
function RS:RenameCurrentProfile(newName)
  local currentProfile               = Restocker.currentProfile

  Restocker.profiles[newName]        = Restocker.profiles[currentProfile]
  Restocker.profiles[currentProfile] = nil

  Restocker.currentProfile           = newName

  UIDropDownMenu_SetText(RS.MainFrame.profileDropDownMenu, Restocker.currentProfile)
end


--[[
  CHANGE PROFILE
]]
function RS:ChangeProfile(newProfile)
  Restocker.currentProfile = newProfile

  UIDropDownMenu_SetText(RS.MainFrame.profileDropDownMenu, Restocker.currentProfile)
  --print(RS.defaults.prefix .. "current profile: ".. Restocker.currentProfile)
  RS:Update()

  if RS.bankIsOpen then
    RS:BANKFRAME_OPENED(true)
  end

  if RS.merchantIsOpen then
    RS:MERCHANT_SHOW()
  end
end

---@class RsRestockItem
---@field amount number
---@field reaction number
---@field itemName string

--[[
  COPY PROFILE
]]
function RS:CopyProfile(profileToCopy)
  local copyProfile                            = CopyTable(Restocker.profiles[profileToCopy])
  Restocker.profiles[Restocker.currentProfile] = copyProfile
  RS:Update()
end

function RS:loadSettings()
  if Restocker.autoBuy == nil then
    Restocker.autoBuy = true
  end
  if Restocker.restockFromBank == nil then
    Restocker.restockFromBank = true
  end

  if Restocker.profiles == nil then
    ---@type table<string, table<string, RsRestockItem>>
    Restocker.profiles = {}
  end
  if Restocker.profiles.default == nil then
    ---@type table<string, RsRestockItem>
    Restocker.profiles.default = {}
  end
  if Restocker.currentProfile == nil then
    Restocker.currentProfile = "default" ---@type string
  end

  if Restocker.framePos == nil then
    Restocker.framePos = {}
  end

  if Restocker.autoOpenAtBank == nil then
    Restocker.autoOpenAtBank = false
  end
  if Restocker.autoOpenAtMerchant == nil then
    Restocker.autoOpenAtMerchant = false
  end
  if Restocker.loginMessage == nil then
    Restocker.loginMessage = true
  end
end

---Print a text with "Restocker: " prefix in the game chat window
---@param t string
function RS.Print(t)
  local name = "Restocker"
  DEFAULT_CHAT_FRAME:AddMessage("|c80808080" .. name .. "|r: " .. t)
end

function RS.Dbg(t)
  local name = "RsDbg"
  DEFAULT_CHAT_FRAME:AddMessage("|cffbb3333" .. name .. "|r: " .. t)
end

--- This is executed before addon initialization is finished
local function Init()
  RS.currentlyRestocking = false
  RS.itemsRestocked      = {}
  RS.restockedItems      = false
  RS.framepool           = {}
  RS.hiddenFrame         = CreateFrame("Frame", nil, UIParent):Hide()
  RS:loadSettings()
  RS.SetupBankConstants()
end

RS.ICON_FORMAT = "|T%s:0:0:0:0:64:64:4:60:4:60|t"

---Creates a string which will display a picture in a FontString
---@param texture string - path to UI texture file (for example can come from
---  GetContainerItemInfo(bag, slot) or spell info etc
function RS.FormatTexture(texture)
  return string.format(RS.ICON_FORMAT, texture)
end

Init()
