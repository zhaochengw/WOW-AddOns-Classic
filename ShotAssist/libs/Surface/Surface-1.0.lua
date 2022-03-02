--[[
Name: Surface-1.0
Revision: $Revision: 25931 $
Author: Haste/Otravi (troeks@gmail.com)
Website: http://fuxsake.net/f15-SurfaceLib.html
Documentation: http://fuxsake.net/t18-Documentation.html
SVN: http://svn.wowace.com/wowace/trunk/SurfaceLib/Surface-1.0/
Description: Shared handling of StatusBar textures between add ons.
Dependencies: AceLibrary, AceEvent-2.0
]]

local vmajor, vminor = "Surface-1.0", "$Revision: 25931 $"

if not AceLibrary then error(vmajor .. " requires AceLibrary.") end
if not AceLibrary:IsNewVersion(vmajor, vminor) then return end
if not AceLibrary:HasInstance("AceEvent-2.0") then error(vmajor .. " requires AceEvent-2.0.") end

local lib = {}

local textureTable = nil
local textureList = nil
local overrideTexture = nil

local function rebuildTextureList()
	if type(textureList) ~= "table" then textureList = {} end
	for k in pairs(textureList) do textureList[k] = nil end
	for k in pairs(textureTable) do
		rawset(textureList, #textureList + 1, k)
	end
end

local function filename(file)
	local filename = select(3, file:find("^.+\\(.+)$"))
	if type(filename) ~= "string" then error("Provided path does not contain a valid filename.") end
	local ext = filename:sub(-4)
	if ext == ".tga" or ".blp" then filename = filename:sub(1, filename:len() - 4) end
	return filename:lower()
end

function lib:Register(n, t)
	self:argCheck(n, 2, "string")
	self:argCheck(t, 3, "string")

	n = n:trim()
	if textureTable[n] or textureTable[n:lower()] or textureTable[n:upper()] then return end

	for _, v in pairs(textureTable) do
		if filename(t) == filename(v) then return end
	end

	textureTable[n] = t
	rebuildTextureList()

	self:TriggerEvent("Surface_Registered", n)
end

function lib:Fetch(n)
	self:argCheck(n, 2, "string")
	return (not overrideTexture and textureTable[n]) or (overrideTexture and textureTable[overrideTexture]) or textureTable.Blizzard
end

function lib:Iterate()
	return textureTable
end

function lib:List()
	rebuildTextureList()
	table.sort(textureList)
	return textureList
end

function lib:GetGlobal()
	return overrideTexture
end

function lib:SetGlobal(n)
	overrideTexture = textureTable[n] and n or nil
	self:TriggerEvent("Surface_SetGlobal", overrideTexture)
end

function lib:Usage()
	rebuildTextureList()
	table.sort(textureList)
	return "{" .. table.concat(textureList, " || ") .. "}"
end

function lib:IsValid(a1)
	return textureTable[a1] and true or false
end

local function activate(self, oldLib, oldDeactivate)
	if oldLib then
		textureTable = {}
		if type(oldLib.Iterate) == "function" then
			for k, v in pairs(oldLib:Iterate()) do
				textureTable[k] = v
			end
		end
		if type(oldLib.GetGlobal) == "function" then
			overrideTexture = oldLib:GetGlobal()
		end
	else
		textureTable = {Blizzard = "Interface\\TargetingFrame\\UI-StatusBar"}
	end
	if type(oldDeactivate) == "function" then oldDeactivate(oldLib) end
end

local function deactivate(self)
	for k in pairs(textureTable) do textureTable[k] = nil end
	for i in ipairs(textureList) do table.remove(textureList, i) end
	textureTable = nil
	textureList = nil
	overrideTexture = nil
end

local function external(self, major, instance)
	if major == "AceEvent-2.0" then
		instance:embed(self)
	end
end

AceLibrary:Register(lib, vmajor, vminor, activate, deactivate, external)
lib = nil

