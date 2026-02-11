local configRegistry = {}

Merfin = Merfin or {}

local function Log(message)
  --DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00[MerfinConfig]|r " .. tostring(message))
end

function Merfin.SetConfig(configName, configTable)
  if type(configName) ~= "string" then
    Log("Invalid configName passed to SetConfig")
    return
  end
  if type(configTable) ~= "table" then
    Log("Invalid configTable passed to SetConfig")
    return
  end
  configRegistry[configName] = configTable
  Log("Config '" .. configName .. "' registered.")
end

function Merfin.GetConfig(configName)
  if type(configName) ~= "string" then
    Log("Invalid configName passed to GetConfig")
    return nil
  end
  return configRegistry[configName]
end

function Merfin.HasConfig(configName)
  return configRegistry[configName] ~= nil
end
