--[=[
	ChatTransmit
--]=]

local Myself, Private = ...;

local CFMEH = ChatFrame_MessageEventHandler;

local SelfName = UnitName('player');
local Realm = GetRealmName();
local SelfName2 = SelfName .. "-" .. Realm;

Private.Print = print;
function Private.Debug(...)
	Private.Print(">>", ...);
end


local _TChatFrames = {  };
for i = 1, 10 do
	_TChatFrames[i] = _G["ChatFrame" .. i];
end
function Private.ChatFrameHasType(ChatFrame, ctype)
	if ctype == "WHISPER_INFORM" then
		ctype = "WHISPER";
	end
	local messageTypeList = ChatFrame.messageTypeList;
	if messageTypeList ~= nil then
		for i = 1, #messageTypeList do
			if messageTypeList[i] == ctype then
				return true;
			end
		end
	end
	return false;
end
function Private.SimulateChatMessage(ctype, sender, msg, GUID)
	local MSG = "▲" .. msg;
	local etype = "CHAT_MSG_" .. ctype;
	for i = 1, 10 do
		if i ~= 2 and _TChatFrames[i] ~= nil and Private.ChatFrameHasType(_TChatFrames[i], ctype) then
			-- msg, sender, lang, channelName, player2, Flags, zoneChannelID, channelIndex, channelBaseName, langID, lineID, GUID, bnSenderID
			CFMEH(_TChatFrames[i], etype, MSG, sender, "", "", sender, "", 0, 0, "", nil, 1, GUID, nil, false, false, false);
		end
	end

	-- WhisperPop自动忽略以[]开头的消息
	local WhisperPop = _G.WhisperPop;
	if WhisperPop then
		if WhisperPop[etype] then
			WhisperPop[etype](WhisperPop, msg, sender, "", "", sender, "", 0, 0, "", nil, 1, GUID, nil, false, false, false);
		end
	end
end

local _CommDistributor = {
	-- OnComm = function(ctype, GUID, sender, msg) Private.Debug("Comm", ctype, GUID, sender, msg); end,
	OnDelayCheckFailure = function(ctype, GUID, sender, msg)
		-- Private.Debug("Failure", ctype, GUID, sender, msg);
		if sender == SelfName or sender == SelfName2 then
			if ctype == "WHISPER_INFORM" then
				return;
			end
			if ctype == "WHISPER" then
				Private.SimulateChatMessage("WHISPER_INFORM", sender, msg, GUID);
			end
			Private.SimulateChatMessage(ctype, sender, msg, GUID);
		else
			Private.SimulateChatMessage(ctype, sender, msg, GUID);
		end

	end,
	-- OnDelayCheckSuccess = function(ctype, GUID, sender, msg) Private.Debug("Success", ctype, GUID, sender, msg); end,
};

local _Driver = CreateFrame('FRAME');
_Driver:RegisterEvent("ADDON_LOADED");
_Driver:SetScript("OnEvent", function(self, event, param)
	if event == "ADDON_LOADED" and param == Myself then
		self:UnregisterEvent("ADDON_LOADED");
		local __ctranslib = __ala_meta__.__ctranslib;
		if __ctranslib ~= nil then
			__ctranslib.RegisterCommmDistributor(_CommDistributor);
		end
	end
end);
