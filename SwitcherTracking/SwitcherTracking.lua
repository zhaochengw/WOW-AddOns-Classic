SwitcherTracking = LibStub("AceAddon-3.0"):NewAddon("SwitcherTracking", "AceTimer-3.0", "AceConsole-3.0")
local icon = LibStub("LibDBIcon-1.0")
local SwitcherTrackingLDB = LibStub("LibDataBroker-1.1", true)
local addonName, ns = ...

local trackingValues = {
    minerals = 'Find Minerals',
    herbs = 'Find Herbs',
	fishs = 'Find Fishs',
}

local hunterValues = {
    minerals = 'Find Minerals',
    herbs = 'Find Herbs',
    hidden = 'Track Hidden',
    beasts = 'Track Beasts',
    dragonkin = 'Track Dragonkin',
    elementals = 'Track Elementals',
    undead = 'Track Undead',
    giants = 'Track Giants',
    humanoids = 'Track Humanoids',
    demons = 'Track Demons',
	fishs = 'Find Fishs',
}

local druidValues = {
    minerals = 'Find Minerals',
    herbs = 'Find Herbs',
    humanoids_druid = 'Track Humanoids',
	fishs = 'Find Fishs',
}

local classTrackingValues = trackingValues;

local playerClass, englishClass = UnitClass("player");

if englishClass == 'DRUID' then
    classTrackingValues = druidValues
elseif englishClass == 'HUNTER' then
    classTrackingValues = hunterValues
end

race, raceEn = UnitRace("player");

if raceEn == 'Dwarf' then
    classTrackingValues['treasure'] = 'Find Treasure'
end



local options = {
     
	name = 'SwitcherTracking',
	
	handler = SwitcherTracking,
    type = 'group',
    desc ='SwitcherTracking detail',
	
	args = {
		heading = {
		type = "description",
		name = 'To Start SwitcherTracking, use "/swt" to enable or disable.',
		fontSize = "large",
		order = 1,
		width = "full",	
		},
		heading2 = {
		type = "description",
		name = 'To change tracking types use "/swt opt"',
		fontSize = "large",
		order = 2,
		width = "full",	
		},
		type1 = {
            name = "First Type",
            desc = "First type to swap between",
            type = "select",
            values = classTrackingValues,
            get = 'GetType1',
            set = 'SetType1',
        },
        type2 = {
            name = "Second Type",
            desc = "Second type to swap between",
            type = "select",
            values = classTrackingValues,
            get = 'GetType2',
            set = 'SetType2',
        },
        castInterval = {
            name = "Toggle Interval",
            desc = "Time in seconds between toggle casts",
            type = "range",
            min = 2,
            max = 45,
            step = 1,
            get = 'GetCastInterval',
            set = 'SetCastInterval',
            width = "full",
        },
		icon_minimap = {
					type = "group",
					name = "Minimap Icon",
					desc = "Show/Hide Minimap Icon",
					order = 10,
					args = {
						minimapHide = {
							type = "toggle",
							
							name = "Show/Hide Minimap Icon",
							desc = "Show/Hide icon on the Minimap",
							get = function(info)
								return not SwitcherTracking.db.profile.minimaphide
								
							end,
							set = function(info, val)
								if val then 
								--icon:Show("SwitcherTracking")
								SwitcherTracking:toogle_MinimapButton(val)								
								else 
								icon:Hide("SwitcherTracking")
								end
							SwitcherTracking.db.profile.minimaphide = not val
							end,
								
		
						order = 11,
						}
					
					}
		}
	}
}



local defaults = {
 
	profile  = {
        type1 = "minerals",
        type2 = "herbs",
		minimaphide = true,
	}
}

function SwitcherTracking:OnInitialize()
    print('To Start switcherTracking, use /swt to enable. To change tracking types use /swt opt')

    self.db = LibStub("AceDB-3.0"):New("SwitcherTrackingCharDB", defaults, true)

    LibStub('AceConfig-3.0'):RegisterOptionsTable('SwitcherTracking', options)
    self.optionsFrame = LibStub('AceConfigDialog-3.0'):AddToBlizOptions('SwitcherTracking', 'SwitcherTracking : start or stop simply use /swt')
    self:RegisterChatCommand('swt', 'ChatCommand')
    self:RegisterChatCommand('SwitcherTracking', 'ChatCommand')

    -- Set default values
    SwitcherTracking.type1 = "minerals";
    SwitcherTracking.type2 = "herbs";
    SwitcherTracking.castInterval = "2";
    SwitcherTracking.IS_RUNNING = false;
	
			--icon minimap
		SwitcherTrackingLDB = SwitcherTrackingLDB:NewDataObject("SwitcherTracking", {
		type = "launcher",
		text = "SwitcherTracking",
		icon = "Interface\\Icons\\ability_townwatch",
		--icon = "Interface\\Icons\\Spell_nature_lightning",
		OnClick = 	function(_, button)                
--print(button)
					if button == "LeftButton" then 
						
						if LibStub("AceConfigDialog-3.0").OpenFrames["SwitcherTracking"] then
						LibStub("AceConfigDialog-3.0"):Close("SwitcherTracking")
						else
						LibStub("AceConfigDialog-3.0"):Open("SwitcherTracking")
						--InterfaceOptionsFrame_OpenToCategory("Profiles")
						end 
						
					end
					
					if button == "MiddleButton" then 
						

						InterfaceOptionsFrame_OpenToCategory("Profiles")
		
						
					end		
					
					if button == "RightButton" then 
							
						SwitcherTracking:ToggleTracking();					
								
							
						
					end
					
					end,
		OnTooltipShow = function(tt)
						tt:AddLine("SwitcherTracking version  : |cffffff00".."3.4.1".."|r")
						tt:AddLine("|cffffff00Click|Left to Hide/Show Options.")
						tt:AddLine("|cffffff00Click|Right to launch the switch tracking.")
						end,
		})

	
	if SwitcherTracking.db.profile.minimaphide == not true then
		icon:Register("SwitcherTracking", SwitcherTrackingLDB, SwitcherTracking.db.profile.minimapPos)
		SwitcherTracking:RegisterChatCommand("SwitcherTracking", "CommandSwitcherTracking")
		icon:Hide("SwitcherTracking")
		icon:Hide("SwitcherTracking")
		
	end

		
	

end
------------------------------------------
--- Show Hide Icon Minimap
------------------------------------------
function SwitcherTracking:toogle_MinimapButton(arg)	
	--print("arg",arg)
	if arg== true then

		if icon:IsRegistered("SwitcherTracking") then
		--print("registred",arg)
		else
		--print("Notregistred",arg)
		icon:Register("SwitcherTracking", SwitcherTrackingLDB, SwitcherTracking.db.profile.minimapPos)
		SwitcherTracking:RegisterChatCommand("SwitcherTracking", "CommandSwitcherTracking")		
		end
		icon:Show("SwitcherTracking")
		
	else
		icon:Hide("SwitcherTracking")
		
	end


end

function SwitcherTracking:ChatCommand(input)
    if not input or input:trim() == "" then
        SwitcherTracking:ToggleTracking();
    else
        if(input:trim() == 'opt') then
            InterfaceOptionsFrame_OpenToCategory(self.optionsFrame);
        else
            print('For change Options "/swt opt"? To start or stop simply use "/swt"');
        end
    end
end

function SwitcherTracking:ToggleTracking(input)
    if SwitcherTracking.IS_RUNNING then SwitcherTracking:StopTimer(); SwitcherTracking.IS_RUNNING = false else SwitcherTracking:StartTimer() SwitcherTracking.IS_RUNNING = true end
end

function SwitcherTracking:StartTimer()
    print('Starting SwitcherTracking, to stop type /swt again');

    self.trackingTimer = self:ScheduleRepeatingTimer('TimerFeedback', SwitcherTracking:GetCastInterval())
end

function SwitcherTracking:StopTimer()
    print('Stopping SwitcherTracking, to start type /swt again');

    self:CancelTimer(self.trackingTimer);
end

function SwitcherTracking:TimerFeedback()
    -- Find Minerals - 136025
    -- Find Herbs  - 133939
    -- Track Hidden  - 132320
    -- Track Beasts  - 132328
    -- Track Dragonkin  - 134153
    -- Track Elementals  - 135861
    -- Track Undead  - 136142
    -- Track Demons  - 136217
    -- Track Giants  - 132275
    -- Track Humanoids  - 135942
    -- Track Humanoids (Druid)  - 132328
    -- Find Treasure (Dwarf) - 135725
    local trackingIDs = {
        minerals = {
            id_icon = 136025,
			id = 2580,
            spellName = "Find Minerals"
        },
		fishs = {
            id_icon = 133888,
			id = 43308,
            spellName = "Find fishs"
        },
		gaz = {
            id_icon = 136152,
			id = 30645,
            spellName = "Track gaz"
        },
        herbs = {
            id_icon = 133939,
			id = 2383,
            spellName = "Find Herbs"
        },
        hidden = {
            id_icon = 132320,
			id = nil ,
            spellName = "Track Hidden"
        },
        beasts = {
            id_icon = 132328,
			id =  1494,
            spellName = "Track Beasts"
        },
        dragonkin = {
            id_icon = 134153,
            id =  19879,
			spellName = "Track Dragonkin"
        },
        elementals = {
            id_icon = 135861,
            id =  10245,
			spellName = "Track Elementals"
        },
        undead = {
            id_icon = 136142,
            id =  10246,
			spellName = "Track Undead"
        },
        demons = {
            id_icon = 136217,
            id =  10239,
			spellName = "Track Demons"
        },
        giants = {
            id_icon = 132275,
            id = 19882,
			spellName = "Track Giants"
        },
        humanoids = {
            id_icon = 135942,
            id = 5225,
			spellName = "Track Humanoids"
        },
        humanoids_druid = {
            id_icon = 132328,
            id = 5225,
			spellName = "Track Humanoids"
        },
        treasure = {
            id_icon = 135725,
            id = 2481,
			spellName = "Find Treasure"
        }
    }

    local currentTracking = SwitcherTracking:GetCurrentTracking();

    if (UnitAffectingCombat("player") == false or IsMounted()) and IsStealthed() == false and IsResting() == false then
  
    local name, text, texture, startTimeMS, endTimeMS, isTradeSkill, notInterruptible, spellId = SwitcherTracking:UnitChannelInfo("player")
     
	  if name then
      -- nothing , wait 
	  else
	  
	  local personalTrackingId = ""
        --if currentTracking ~= trackingIDs[SwitcherTracking:GetType1()].id then
		if GetSpellLink(currentTracking) ~= GetSpellLink(trackingIDs[SwitcherTracking:GetType1()].id) then
		--print(GetSpellLink(currentTracking),GetSpellLink(trackingIDs[SwitcherTracking:GetType1()].id))

		personalTrackingId = trackingIDs[SwitcherTracking:GetType1()].id

		else
		personalTrackingId = trackingIDs[SwitcherTracking:GetType2()].id
		
		
      	
		end
		
		local count = C_Minimap.GetNumTrackingTypes();
		local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(personalTrackingId)		
		--print ("track:",personalTrackingId,name)
			for i=1,count do 
				local name_t, textureFileID, active, type, subType, spellID = C_Minimap.GetTrackingInfo(i);
						
					if name_t == name then
					--DEFAULT_CHAT_FRAME:AddMessage(name.." ("..category..")"..i);
					C_Minimap.SetTracking(i,true);
					end
			
			end
        
	end
   end
end



function SwitcherTracking:GetCastInterval(info)
    if self.db.profile.castInterval == nil or self.db.profile.castInterval == '' then
        return tonumber(SwitcherTracking.castInterval)
    end

    return tonumber(self.db.profile.castInterval)
end

function SwitcherTracking:SetCastInterval(info, newValue)
    self.db.profile.castInterval = newValue
end

function SwitcherTracking:GetType1(info)
    if self.db.profile.type1 == nil or self.db.profile.type1 == '' then
        return SwitcherTracking.type1
    end

    return self.db.profile.type1
end

function SwitcherTracking:GetCurrentTracking()
    local count = C_Minimap.GetNumTrackingTypes();
    for i=1,count do 
        local name, textureFileID, active, type, subType, spellID = C_Minimap.GetTrackingInfo(i);
	--print(name, textureFileID, active, type, subType, spellID)
	if type == "spell" then
            -- DEFAULT_CHAT_FRAME:AddMessage("Tracking Info ID: "..i.." and name: "..name.." and type:"..type);
            --print("Tracking Info ID: ",i," and name: ",name," and type:",type);
			if active == true then
	        return name
			
            -- DEFAULT_CHAT_FRAME:AddMessage("active");
            end
        end
    end
end

function SwitcherTracking:FindTrackingID(checkme)
    local count = C_Minimap.GetNumTrackingTypes();
    for i=1,count do 
        local name, textureFileID, active, type, subType, spellID = C_Minimap.GetTrackingInfo(i);
        if checkme == name then
	    return i
        end
    end
end

function SwitcherTracking:SetType1(info, newValue)
    self.db.profile.type1 = newValue
end

function SwitcherTracking:GetType2(info)
    if self.db.profile.type2 == nil or self.db.profile.type2 == '' then
        return SwitcherTracking.type2
    end

    return self.db.profile.type2
end

function SwitcherTracking:SetType2(info, newValue)
    self.db.profile.type2 = newValue
end

-- Fix to get options page to open correct
do
    local function get_panel_name(panel)
        local tp = type(panel)
        local cat = INTERFACEOPTIONS_ADDONCATEGORIES
        if tp == "string" then
            for i = 1, #cat do
                local p = cat[i]
                if p.name == panel then
                    if p.parent then
                        return get_panel_name(p.parent)
                    else
                        return panel
                    end
                end
            end
        elseif tp == "table" then
            for i = 1, #cat do
                local p = cat[i]
                if p == panel then
                    if p.parent then
                        return get_panel_name(p.parent)
                    else
                        return panel.name
                    end
                end
            end
        end
    end

    local function InterfaceOptionsFrame_OpenToCategory_Fix(panel)
        if doNotRun or InCombatLockdown() then return end
        local panelName = get_panel_name(panel)
        if not panelName then return end -- if its not part of our list return early
        local noncollapsedHeaders = {}
        local shownpanels = 0
        local mypanel
        local t = {}
        local cat = INTERFACEOPTIONS_ADDONCATEGORIES
        for i = 1, #cat do
            local panel = cat[i]
            if not panel.parent or noncollapsedHeaders[panel.parent] then
                if panel.name == panelName then
                    panel.collapsed = true
                    t.element = panel
                    InterfaceOptionsListButton_ToggleSubCategories(t)
                    noncollapsedHeaders[panel.name] = true
                    mypanel = shownpanels + 1
                end
                if not panel.collapsed then
                    noncollapsedHeaders[panel.name] = true
                end
                shownpanels = shownpanels + 1
            end
        end
        local Smin, Smax = InterfaceOptionsFrameAddOnsListScrollBar:GetMinMaxValues()
        if shownpanels > 15 and Smin < Smax then
            local val = (Smax/(shownpanels-15))*(mypanel-2)
            InterfaceOptionsFrameAddOnsListScrollBar:SetValue(val)
        end
        doNotRun = true
        InterfaceOptionsFrame_OpenToCategory(panel)
        doNotRun = false
    end

    hooksecurefunc("InterfaceOptionsFrame_OpenToCategory", InterfaceOptionsFrame_OpenToCategory_Fix)
end

function SwitcherTracking:UnitChannelInfo(unit)
    if UnitIsUnit(unit, "player") then return ChannelInfo() end
        local guid = UnitGUID(unit)
        local cast = casters[guid]
        if cast then
            local castType, name, icon, startTimeMS, endTimeMS, spellID = unpack(cast)
            -- Curse of Tongues doesn't matter that much for channels, skipping
            if castType == "CHANNEL" and endTimeMS > GetTime()*1000 then
                return name, nil, icon, startTimeMS, endTimeMS, nil, false, spellID
            end
    end
end
