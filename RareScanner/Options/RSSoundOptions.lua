-----------------------------------------------------------------------
-- AddOn namespace.
-----------------------------------------------------------------------
local ADDON_NAME, private = ...

local LibStub = _G.LibStub
local RareScanner = LibStub("AceAddon-3.0"):GetAddon("RareScanner")
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner", false)

local RSSoundOptions = private.NewLib("RareScannerSoundOptions")

-- RareScanner database libraries
local RSConfigDB = private.ImportLib("RareScannerConfigDB")

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")

local options

-----------------------------------------------------------------------
-- Sound channels
-----------------------------------------------------------------------

private.CHANNELS = {
	["Master"] = AL["CHANNEL_MASTER"],
	["SFX"] = AL["CHANNEL_SFX"],
	["Music"] = AL["CHANNEL_MUSIC"],
	["Ambience"] = AL["CHANNEL_AMBIENCE"],
	["Dialog"] = AL["CHANNEL_DIALOG"],
}

-----------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------

local function GetSoundList()
	local defaultList = {} 
	
	-- Add internal sounds
	for name, file in pairs (RSConstants.DEFAULT_SOUNDS) do
		defaultList[name] = file
	end
	
	-- Add custom sounds
	if (RSConfigDB.GetCustomSounds()) then
		for name, file in pairs (RSConfigDB.GetCustomSounds()) do
			defaultList[name] = string.format(RSConstants.EXTERNAL_SOUND_FOLDER, RSConfigDB.GetCustomSoundsFolder(), file)
		end
	end
	
	return defaultList;
end

local function AddNewSound(name)
	RSConfigDB.AddCustomSound(name)
	
	options.args[name] = {
		type = "group",
		name = name,
		handler = RareScanner,
		desc = name,
		args = {
			infoSound = {
				order = 0,
				type = "description",
				name = AL["SOUND_CUSTOM_FILE_INFO"],
			},
			infoSound1 = {
				order = 1,
				type = "description",
				name = function()
					return string.format(AL["SOUND_CUSTOM_FILE_INFO1"], RSConfigDB.GetCustomSoundsFolder())
				end,
			},
			infoSound2 = {
				order = 2,
				type = "description",
				name = AL["SOUND_CUSTOM_FILE_INFO2"],
			},
			infoSound3 = {
				order = 3,
				type = "description",
				name = string.format(AL["SOUND_CUSTOM_FILE_INFO3"], AL["SOUND_RELOAD"]),
			},
			infoSound4 = {
				order = 4,
				type = "description",
				name = AL["SOUND_CUSTOM_FILE_INFO4"],
			},
			infoSound5 = {
				order = 5,
				type = "description",
				name = AL["SOUND_CUSTOM_FILE_INFO5"],
			},
			file = {
				order = 6,
				type = "input",
				name = AL["SOUND_CUSTOM_FILE"],
				desc = function()
					return string.format(AL["SOUND_CUSTOM_FILE_DESC"], RSConfigDB.GetCustomSoundsFolder())
				end,
				get = function(_, value) 
					return RSConfigDB.GetCustomSound(name)
				end,
				set = function(_, value)
					RSConfigDB.AddCustomSound(name, value)
					
					-- Refresh lists
					options.args.soundPlayed.values = GetSoundList()
					options.args.soundObjectPlayed.values = GetSoundList()
				end,
				width = "full",
			},
			delete = {
				order = 7.1,
				name = AL["SOUND_DELETE"],
				desc = AL["SOUND_DELETE_DESC"],
				type = "execute",
				func = function()
					options.args[name] = nil
					RSConfigDB.DeleteCustomSound(name)
					
					-- Refresh lists
					options.args.soundPlayed.values = GetSoundList()
					options.args.soundObjectPlayed.values = GetSoundList()
				end,
				width = 0.8,
			},
			play = {
				order = 7.2,
				name = AL["SOUND_PLAY"],
				desc = AL["SOUND_PLAY_DESC"],
				type = "execute",
				func = function()
					if (RSConfigDB.GetCustomSound(name)) then
						PlaySoundFile(string.format(RSConstants.EXTERNAL_SOUND_FOLDER, RSConfigDB.GetCustomSoundsFolder(), RSConfigDB.GetCustomSound(name)), "Master")
					end
				end,
				width = 0.8,
			},
			reload = {
				order = 7.3,
				name = AL["SOUND_RELOAD"],
				desc = AL["SOUND_RELOAD_DESC"],
				type = "execute",
				func = function()
					ReloadUI()
				end,
				width = 0.8,
			},
		}
	}
end

-----------------------------------------------------------------------
-- Options tab: Sound
-----------------------------------------------------------------------

function RSSoundOptions.GetSoundOptions()	
	if (not options) then		
		options = {
			type = "group",
			order = 1,
			name = AL["SOUND"],
			handler = RareScanner,
			desc = AL["options"],
			args = {
				soundDisabled = {
					order = 0,
					name = AL["DISABLE_SOUND"],
					desc = AL["DISABLE_SOUND_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsPlayingSound() end,
					set = function(_, value)
						RSConfigDB.SetPlayingSound(value)
					end,
					width = "full",
				},
				soundObjectDisabled = {
					order = 1,
					name = AL["DISABLE_OBJECTS_SOUND"],
					desc = AL["DISABLE_OBJECTS_SOUND_DESC"],
					type = "toggle",
					get = function() return RSConfigDB.IsPlayingObjectsSound() end,
					set = function(_, value)
						RSConfigDB.SetPlayingObjectsSound(value)
					end,
					width = "full",
				},
				soundChannel = {
					order = 2.1,
					type = "select",
					name = AL["SOUND_CHANNEL"],
					desc = AL["SOUND_CHANNEL_DESC"],
					values = private.CHANNELS,
					get = function() return RSConfigDB.GetSoundChannel() end,
					set = function(_, value)
						RSConfigDB.SetSoundChannel(value)
					end,
					width = 1.5,
					disabled = function() return RSConfigDB.IsPlayingSound() and RSConfigDB.IsPlayingObjectsSound() end,
				},
				soundVolume = {
					order = 2.2,
					type = "range",
					name = AL["SOUND_VOLUME"],
					desc = AL["SOUND_VOLUME_DESC"],
					min	= 1,
					max	= 4,
					step = 1,
					bigStep = 1,
					get = function() return RSConfigDB.GetSoundVolume() end,
					set = function(_, value)
						RSConfigDB.SetSoundVolume(value)
					end,
					width = 1.5,
					disabled = function() return RSConfigDB.IsPlayingSound() and RSConfigDB.IsPlayingObjectsSound() end,
				},
				soundSeparator = {
					order = 3,
					type = "header",
					name = AL["SOUND_AUDIOS"],
				},
				soundPlayed = {
					order = 4.1,
					type = "select",
					dialogControl = 'LSM30_Sound',
					name = AL["ALARM_SOUND"],
					desc = AL["ALARM_SOUND_DESC"],
					values = GetSoundList(),
					get = function() return RSConfigDB.GetSoundPlayedWithNpcs() end,
					set = function(_, value)
						RSConfigDB.SetSoundPlayedWithNpcs(value)
					end,
					width = 1.5,
					disabled = function() return RSConfigDB.IsPlayingSound() end,
				},
				soundObjectPlayed = {
					order = 4.2,
					type = "select",
					dialogControl = 'LSM30_Sound',
					name = AL["ALARM_TREASURES_SOUND"],
					desc = AL["ALARM_TREASURES_SOUND_DESC"],
					values = GetSoundList(),
					get = function() return RSConfigDB.GetSoundPlayedWithObjects() end,
					set = function(_, value)
						RSConfigDB.SetSoundPlayedWithObjects(value)
					end,
					width = 1.5,
					disabled = function() return RSConfigDB.IsPlayingObjectsSound() end,
				},
				soundCustomFolder = {
					order = 5,
					type = "input",
					name = AL["SOUND_CUSTOM_FOLDER"],
					desc = AL["SOUND_CUSTOM_FOLDER_DESC"],
					get = function(_, value) return RSConfigDB.GetCustomSoundsFolder() end,
					set = function(_, value)
						RSConfigDB.SetCustomSoundsFolder(value)
					end,
					width = "full",
					validate = function(_, value)
						if (not value or value == '') then
							return false
						end
						
						return true
					end,
					disabled = function() return RSConfigDB.IsPlayingSound() and RSConfigDB.IsPlayingObjectsSound() end,
				},
				newCustomSound = {
					order = 6,
					type = "input",
					name = AL["SOUND_ADD"],
					desc = AL["SOUND_ADD_DESC"],
					get = function(_, value) return private.options_newCustomSound_input end,
					set = function(_, value)
						private.options_newCustomSound_input = value
						AddNewSound(private.options_newCustomSound_input);
					end,
					width = 1.5,
					validate = function(_, value)
						if (not value or value == '') then
							return false
						end
						
						return true
					end,
					disabled = function() return RSConfigDB.IsPlayingSound() and RSConfigDB.IsPlayingObjectsSound() end,
				},
			},
		}
		
		-- Preload already added custom sounds
		if (RSConfigDB.GetCustomSounds()) then
			for name, _ in pairs (RSConfigDB.GetCustomSounds()) do
				AddNewSound(name)
			end
		end
	end

	return options
end
