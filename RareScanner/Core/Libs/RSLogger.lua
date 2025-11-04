-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibTime = LibStub("LibTime-1.0")

local RSLogger = private.NewLib("RareScannerLogger")

-- RareScanner libraries
local RSConstants = private.ImportLib("RareScannerConstants")

function RSLogger:CreateChatFrame(name)
	-- Closes current window if exists
	if (self.RARESCANNER_CHAT_FRAME) then
		local curChatName = GetChatWindowInfo(self.RARESCANNER_CHAT_FRAME:GetID());
		-- Avoids closing General or Combat Log
		if (curChatName ~= COMBAT_LOG and curChatName ~= COMMUNITIES_DEFAULT_CHANNEL_NAME) then
			FCF_Close(self.RARESCANNER_CHAT_FRAME);
		end
	end
		
	if (name) then		
		-- Show if it already exists
		local exists = false
		for i = 1, NUM_CHAT_WINDOWS do
			local chatName, _, _, _, _, _, shown, _, _, _ = GetChatWindowInfo(i);
			if (chatName == name) then
				self.RARESCANNER_CHAT_FRAME = _G["ChatFrame"..i]
				if (not shown) then
					SetChatWindowShown(i, true);
					FCF_DockFrame(self.RARESCANNER_CHAT_FRAME, i, true)
					if (ChatFrame1) then
						FCF_SelectDockFrame(ChatFrame1)
					end
				end
				exists = true
				break
			end
		end
		
		-- Creates a new window if it doesnt exist
		if (not exists) then
			self.RARESCANNER_CHAT_FRAME = FCF_OpenNewWindow(name)
			ChatFrame_RemoveAllMessageGroups(self.RARESCANNER_CHAT_FRAME)
			ChatFrame_RemoveAllChannels(self.RARESCANNER_CHAT_FRAME)
			if (ChatFrame1) then
				FCF_SelectDockFrame(ChatFrame1)
			end
		end
	else		
		self.RARESCANNER_CHAT_FRAME = nil
	end
end

function RSLogger:PrintMessage(message)
	-- Cannot use RSConfigDB in this class
	local printMessage
	if (private.db.display.displayTimestampChatMessage) then
		local timeStamp = LibTime.GetTimeString("LocalTime",true,true)
		printMessage = string.format("|cFFFCD6CD[%s] |cFF00FF00[RareScanner]: |cFFFFFFFF%s", timeStamp, message)
	else
		printMessage = string.format("|cFF00FF00[RareScanner]: |cFFFFFFFF%s", message)
	end
	
	-- Prints to custom chat frame or default
	if (self.RARESCANNER_CHAT_FRAME) then
		self.RARESCANNER_CHAT_FRAME:AddMessage(printMessage)
	else
		print(printMessage)
	end
end

function RSLogger:PrintDebugMessage(message)
	if (RSConstants.DEBUG_MODE) then
		local printMessage = string.format("|cFFDC143C[RareScanner]: |cFFFFFFFF%s", tostring(message))
	
		-- Prints to custom chat frame or default
		if (self.RARESCANNER_CHAT_FRAME) then
			self.RARESCANNER_CHAT_FRAME:AddMessage(printMessage)
		else
			print(printMessage)
		end
	end
end

function RSLogger:PrintDebugMessageEntityID(receivedEntityID, message)
	if (RSConstants.DEBUG_MODE and receivedEntityID and RSConstants.MAP_ENTITY_ID) then
		if (receivedEntityID == RSConstants.MAP_ENTITY_ID) then
			RSLogger:PrintDebugMessage(message)
		end
	end
end

function RSLogger:PrintDebugMessageItemID(receivedItemID, message)
	if (RSConstants.DEBUG_MODE and receivedItemID and RSConstants.LOOT_ITEM_ID) then
		if (receivedItemID == RSConstants.LOOT_ITEM_ID) then
			RSLogger:PrintDebugMessage(message)
		end
	end
end
