--[[ Create ]]
zBar3 = CreateFrame("Frame",nil,UIParent,"SecureFrameTemplate")
zBar3:RegisterEvent("PLAYER_LOGIN")

--[[ Tables ]]
zBar3.plugins = {}
zBar3.bars    = {}
zBar3.buttons = {}

--[[ Common functions ]]
function zBar3:print(msg, r, g, b)
	DEFAULT_CHAT_FRAME:AddMessage(msg, r, g, b)
end

--[[ Event ]]
function zBar3:OnEvent(event, ...)
	if event == "PLAYER_LOGIN" then
		-- self init
		self:Init()
		-- plugins init
		for k,v in ipairs(self.plugins) do
		  assert(v.Load)
			v:Load()
		end
		-- bars init
		for name, bar in pairs(self.bars) do
		  bar:Init()
			bar:Reset()
		end
		-- buttonfacade support
		zButtonFacade:Load()
		-- init grid updater
		self:InitGridUpdater()
		
		-- Init All Buttons
		self:InitAllButtons()
	  
		-- init AfterCombat Events
		self:InitAfterCombat()

		-- register slash command
		self:RegisterSlash()
		-- welcome message
		self:print(format(zBar3.loc.Msg.Loaded, 'ff3300', self.version, self.author, 'ffee00'),.3,.8,1)
	
	elseif event == "PLAYER_REGEN_ENABLED" then
		if InCombatLockdown() then
			--print("zBar3: InCombatLockdown event = " .. event)
		else
			self:CallAfterCombat()
		end
	else
		self:UpdateGrids(event)
	end
end
zBar3:SetScript("OnEvent", zBar3.OnEvent)

--[[ Register Sub Addon ]]
-- the order of registeration will also effect when Initialize !
function zBar3:AddPlugin(obj, afterWho)
	-- insert behine the afterWho
	if afterWho then
		for k,v in ipairs(self.plugins) do
			if v == afterWho then
				table.insert(self.plugins, k+1, obj)
				return
			end
		end
	end
	-- otherwise just append it
	table.insert(self.plugins, obj)
end

--[[ Register a Bar ]]
function zBar3:AddBar(bar)
	self.bars[bar:GetName()] = bar

	-- inherit functions
	setmetatable(bar, {__index = zBarT})
end

--[[ Addon Init ]]
function zBar3:Init()
	-- version
	self.version = GetAddOnMetadata("zBar3", "Version")
	self.author  = GetAddOnMetadata("zBar3", "Author")

	-- data
	zBar3Data = zBar3Data or {
		version = zBar3.version,
		fullmode= 0,
	}

	-- Lite mode or Full mode
	if zBar3Data.fullmode then
		LoadAddOn("zBar3FullMode")
	end

	-- hidden frame
	self.hiddenFrame = CreateFrame("Frame")
	self.hiddenFrame:Hide()

	-- class
	self.class = select(2, UnitClass("player"))
end

local function zBar3Button_OnEnter(self)
  local bar = self:GetParent()
  if zTab:FreeOnEnter(self) then return end
  bar:SetAlpha(1)
  if not zBar3Data.hideTip then
    ActionButton_SetTooltip(self)
  end
end

local function zBar3Button_OnLeave(self)
  local bar = self:GetParent()
  bar:SetAlpha(zBar3Data[bar:GetName()].alpha)
  if not zBar3Data.hideTip then
    GameTooltip:Hide()
  end
end

function zBar3:InitAllButtons()
	-- hook scripts for all action buttons
	local name, bar, button
	for name, bar in pairs(self.bars) do
    for id = 1, bar:GetNumButtons() do
      button = _G[self.buttons[bar:GetName()..id]]
      if button then
        --if bar:GetID() <= 10 then
        if bar:GetAttribute("actionpage") then
          button:SetMovable(true)
          -- set button scripts
          button:SetScript("OnEnter", zBar3Button_OnEnter)
          button:SetScript("OnLeave", zBar3Button_OnLeave)
        end
        button:HookScript("OnEnter", function(self) zTab.OnPopup(self:GetParent():GetTab()) end)
        button:HookScript("OnLeave", function(self) zTab.OnFadeOut(self:GetParent():GetTab()) end)
      end
    end
	end
end

--[[ Grid Stuff ]]
-- grid initialization should after all action button (especially extra buttons) created,
-- because action button will register events while creation
function zBar3:InitGridUpdater()
	self.showgrid = MultiBarLeftButton1:GetAttribute("showgrid")
	-- add events for grid, must after bars initial
	self:RegisterEvent("ACTIONBAR_SHOWGRID")
	self:RegisterEvent("ACTIONBAR_HIDEGRID")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	-- hooks for grid
	hooksecurefunc("MultiActionBar_ShowAllGrids",function()
		zBar3:IncGrid()
		zBar3:UpdateGrids()
	end)
	hooksecurefunc("MultiActionBar_HideAllGrids",function()
		zBar3:DecGrid()
		zBar3:UpdateGrids()
	end)
end

zBar3.gridUpdaters = {}
function zBar3:RegisterGridUpdater(bar)
	table.insert(self.gridUpdaters, bar)
end

function zBar3:IncGrid()
	self.showgrid = self.showgrid + 1
end

function zBar3:DecGrid()
	if self.showgrid > 0 then
		self.showgrid = self.showgrid - 1
	end
end

function zBar3:UpdateGrids(event, ...)
	-- event stuff
	if event == "ACTIONBAR_SHOWGRID" then
		zBar3:IncGrid()
	elseif event == "ACTIONBAR_HIDEGRID" then
		zBar3:DecGrid()
	else
		for i, bar in ipairs(zBar3.gridUpdaters) do
			self:SafeCallFunc(bar.UpdateGrid, bar)
		end
	end
end


--[[ CombatLockdown Stuff ]]

--[[

  while InCombatLockdown we can't call TAINT functions
  so push them to a stack, thus we can call them after combat

  Usage: SafeCallFunc(function, ...)
  Example:
    -- call object function
    SafeCallFunc(theFrame.SetWidth, theFrame, 256)
    -- call global function
    SafeCallFunc(UseActoin, 120, true, true)
    
]]

zBar3.AfterCombatCallList = {}

function zBar3:InitAfterCombat()
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
end

function zBar3:RegisterSafeCallObj(func, ...)
  --self.AfterCombatCallList[tostring(func)] = {func, {...}}
  table.insert(self.AfterCombatCallList, {func, {...}})
end

function zBar3:SafeCallFunc(func, ...)
  assert(type(func) == 'function', 
    'Wrong param for zBar3.SafeCallFunc, need a function type, got ' .. type(func))
    
	if InCombatLockdown() then
		zBar3:RegisterSafeCallObj(func, ...)
	else
	  func(...)
	end
end

function zBar3:CallAfterCombat()
	local index, pack
	for index, pack in pairs(self.AfterCombatCallList) do
		pack[1](unpack(pack[2]))
	end
	table.wipe(self.AfterCombatCallList)
end

--[[ Config ]]

function zBar3:Config(bar)
	if not zBarConfig then
		local name = 'zBar3Config'
		local loaded, reason = LoadAddOn(name)
		if ( not loaded ) then
			message(format(ADDON_LOAD_FAILED, name, _G["ADDON_"..reason]))
			return
		else
			zBarConfig:Load()
		end
	end
	zBarConfig:Openfor(bar)
end

function zBar3:RegisterSlash()
	SlashCmdList["ZBAR"] = function(msg)
		local offset = tonumber(msg)
		for name,bar in pairs(zBar3.bars) do
			if msg == "resetall" then
				bar:Reset(true)
			elseif offset then
				local pos = zBar3Data[bar:GetName()].pos or zBar3:GetDefault(bar, "pos")
				bar:GetTab():ClearAllPoints()
				if type(pos[2]) == "string" then
					bar:GetTab():SetPoint(pos[1],UIParent,pos[2],pos[3],pos[4] + offset/bar:GetTab():GetScale())
				else
					bar:GetTab():SetPoint(pos[1],UIParent,pos[1],pos[2],pos[3] + offset/bar:GetTab():GetScale())
				end
				zTab:SavePosition(bar:GetTab())
			else
				zBar3:Config(bar)
				return
			end
		end
	end
	SLASH_ZBAR1 = "/zbar"
end