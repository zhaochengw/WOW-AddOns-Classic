FloAspectBar = {}

--- Events ---

function FloAspectBar.OnEvent(self, event, ...)
  -- Fired on a registered event
  if event == "ADDON_LOADED" then
    local addon_name = ...
    if addon_name == "FloAspectBar" then
      FloAspectBar.Msg("Unsupported Client Version!", true, 'FF0000')
    end
  end
end

--- Functions ---

function FloAspectBar.Msg(msg, printname, color)
  -- Print a message to the chat frame
  if not color then
    color = "FFC300"
  end

  if printname then
    DEFAULT_CHAT_FRAME:AddMessage("|cffd2b48c[San's FloAspectBar]|r |cff"..color..msg)
  else
    DEFAULT_CHAT_FRAME:AddMessage("|cff"..color..msg)
  end
end

FloAspectBar.Frame:SetScript("OnEvent", FloAspectBar.OnEvent)
FloAspectBar.Frame:RegisterEvent("ADDON_LOADED")
