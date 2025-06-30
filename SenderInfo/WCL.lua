local WCL = {}


--#region 非官方WCL


local function expand(name)
	local scoreMatch = string.match(name, "(%d+%.?%d*)%%")
	local scorePercent = scoreMatch and tonumber(scoreMatch) or 0
	local out = ""
	if scorePercent >= 100 then
		out = "|cFFE5CC80"
	elseif scorePercent >= 99 then
		out = "|cFFE26880"
	elseif scorePercent >= 95 then
		out = "|cFFFF8000"
	elseif scorePercent >= 75 then
		out = "|cFFA335EE"
	elseif scorePercent >= 50 then
		out = "|cFF0070FF"
	elseif scorePercent >= 25 then
		out = "|cFF1EFF00"
	else
		out = "|cFF666666"
	end

	local switch = {
		["r"] = function()
			return "RS"
		end,
		["V"] = function()
			return "VOA"
		end,
		["X"] = function()
			return "NAX"
		end,
		["D"] = function()
			return "ULD"
		end,
		["O"] = function()
			return "Onyxia"
		end,
		["T"] = function()
			return "TOC"
		end,
		["I"] = function()
			return "ICC"
		end,
		["A"] = function()
			return "|cFFE5CC80"
		end,
		["L"] = function()
			return "|cFFFF8000"
		end,
		["S"] = function()
			return "|cFFE26880"
		end,
		["N"] = function()
			return "|cFFBE8200"
		end,
		["E"] = function()
			return "|cFFA335EE"
		end,
		["R"] = function()
			return "|cFF0070FF"
		end,
		["U"] = function()
			return "|cFF1EFF00"
		end,
		["C"] = function()
			return "|cFF666666"
		end
	}

	local max = strlen(name)
	for j = 1, max do
		ts = strsub(name, j, j)
		local f = switch[ts]
		if f then
			out = out .. f()
		else
			out = out .. ts
		end
	end
	return out
end

local function cut_str(str)
	if str ~= nil then
		local s1, s2, s3 = strsplit("%", str);
		if s1 ~= nil then
			s1 = s1 .. "%"
			if s2 ~= nil and s2 ~= " " then
				s1 = s1 .. s2 .. "%"
			end
			return s1
		end
	end
	return nil
end

local function load_data(tname)
	if type(WP_Database) ~= "table" then
		return nil
	end
	local info = WP_Database[tname]
	if info then
		local data, uptime = strsplit("|", info);
		-- print(data,uptime)
		local y, m, d = strsplit("-", WP_Database["LASTUPDATE"], 3)
		local c = { year = tonumber(y), month = tonumber(m), day = tonumber(d), hour = 00, min = 00, sec = 00 }
		cc = time(c)
		cc = cc - tonumber(uptime) * 24 * 60 * 60
		return expand(data), "更新日期:" .. date("%Y-%m-%d", cc)
	end
	return nil
end

local function load_stopg(tname)
	if type(CTOPG_Database) == "table" then
		sname = tname .. "_" .. GetRealmName()
		if CTOPG_Database[sname] then
			return CTOPG_Database[sname]
		end
	end

	if type(STOPG_Database) == "table" then
		if STOPG_Database[tname] then
			return STOPG_Database[tname]
		end
	end

	return nil
end

local function load_stop(tname)
	if type(STOP_Database) ~= "table" then
		return nil
	end
	if STOP_Database[tname] then
		return { strsplit(',', STOP_Database[tname]) }
		-- return '本服全明星第' .. STOP_Database[tname]
	else
		return nil
	end
end

local function load_ttop(tname)
	if type(TTOP_Database) ~= "table" then
		return nil
	end
	name = tname .. "_" .. GetRealmName()
	if TTOP_Database[name] then
		return { strsplit(',', TTOP_Database[name]) }
		-- return '国服全明星第' .. TTOP_Database[tname]
	else
		return nil
	end
end

local function load_ctop(tname)
	if type(CTOP_Database) ~= "table" then
		return nil
	end
	name = tname .. "_" .. GetRealmName()
	if CTOP_Database[name] then
		return { strsplit(',', CTOP_Database[name]) }
		-- return '国服全明星第' .. CTOP_Database[tname]
	else
		return nil
	end
end

local function load_top(tname)
	if type(TOP_Database) ~= "table" then
		return nil
	end
	local name = tname .. "_" .. GetRealmName()

	if TOP_Database[name] then
		return { strsplit(',', TOP_Database[name]) }
		-- return '世界全明星第' .. TOP_Database[tname]
	else
		return nil
	end
end

local function UnofficialWclScoreValue(name)
	local showStr = ""
	local dstr = ""

	local guildName = GetGuildInfo(name)
	if (guildName ~= nil and guildName ~= "") then
		dstr = load_stopg(guildName)
		if dstr then
			showStr = showStr .. dstr
		end
	end
	dstr = load_top(name)
	if dstr then
		for i, title in ipairs(dstr) do
			if string.find(title, "^%d") ~= nil then
				title = '世界全明星第' .. title
			else
				title = expand(title)
			end
			showStr = showStr .. title
		end
	end
	dstr = load_ctop(name)
	if dstr then
		for i, title in ipairs(dstr) do
			if string.find(title, "^%d") ~= nil then
				title = '国服全明星第' .. title
			else
				title = expand(title)
			end
			showStr = showStr .. title
		end
	end
	dstr = load_ttop(name)
	if dstr then
		for i, title in ipairs(dstr) do
			if string.find(title, "^%d") ~= nil then
				title = '台服全明星第' .. title
			else
				title = expand(title)
			end
			showStr = showStr .. title
		end
	end
	dstr = load_stop(name)
	if dstr then
		for i, title in ipairs(dstr) do
			if string.find(title, "^%d") ~= nil then
				title = '本服全明星第' .. title
			else
				title = expand(title)
			end
			showStr = showStr .. title
		end
	end
	local data, ldate = load_data(name)
	dstr = cut_str(data)
	if dstr then
		showStr = showStr .. dstr
	end
	if ldate then
		showStr = showStr .. ldate
	end

	return showStr
end

-- a dictionary of format to match entity
local FORMAT_SEQUENCES = {
	["s"] = ".+",
	["c"] = ".",
	["%d*d"] = "%%-?%%d+",
	["[fg]"] = "%%-?%%d+%%.?%%d*",
	["%%%.%d[fg]"] = "%%-?%%d+%%.?%%d*",
}

-- a set of format sequences that are string-based, i.e. not numbers.
local STRING_BASED_SEQUENCES = {
	["s"] = true,
	["c"] = true,
}

local cache = setmetatable({}, { __mode = 'k' })
-- generate the deformat function for the pattern, or fetch from the cache.
local function get_deformat_function(pattern)
	local func = cache[pattern]
	if func then
		return func
	end

	-- escape the pattern, so that string.match can use it properly
	local unpattern = '^' .. pattern:gsub("([%(%)%.%*%+%-%[%]%?%^%$%%])", "%%%1") .. '$'

	-- a dictionary of index-to-boolean representing whether the index is a number rather than a string.
	local number_indexes = {}

	-- (if the pattern is a numbered format,) a dictionary of index-to-real index.
	local index_translation = nil

	-- the highest found index, also the number of indexes found.
	local highest_index
	if not pattern:find("%%1%$") then
		-- not a numbered format

		local i = 0
		while true do
			i = i + 1
			local first_index
			local first_sequence
			for sequence in pairs(FORMAT_SEQUENCES) do
				local index = unpattern:find("%%%%" .. sequence)
				if index and (not first_index or index < first_index) then
					first_index = index
					first_sequence = sequence
				end
			end
			if not first_index then
				break
			end
			unpattern = unpattern:gsub("%%%%" .. first_sequence, "(" .. FORMAT_SEQUENCES[first_sequence] .. ")", 1)
			number_indexes[i] = not STRING_BASED_SEQUENCES[first_sequence]
		end

		highest_index = i - 1
	else
		-- a numbered format

		local i = 0
		while true do
			i = i + 1
			local found_sequence
			for sequence in pairs(FORMAT_SEQUENCES) do
				if unpattern:find("%%%%" .. i .. "%%%$" .. sequence) then
					found_sequence = sequence
					break
				end
			end
			if not found_sequence then
				break
			end
			unpattern = unpattern:gsub("%%%%" .. i .. "%%%$" .. found_sequence,
				"(" .. FORMAT_SEQUENCES[found_sequence] .. ")", 1)
			number_indexes[i] = not STRING_BASED_SEQUENCES[found_sequence]
		end
		highest_index = i - 1

		i = 0
		index_translation = {}
		pattern:gsub("%%(%d)%$", function(w)
			i = i + 1
			index_translation[i] = tonumber(w)
		end)
	end

	if highest_index == 0 then
		cache[pattern] = do_nothing
	else
		--[=[
            -- resultant function looks something like this:
            local unpattern = ...
            return function(text)
                local a1, a2 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end

            -- or if it were a numbered pattern,
            local unpattern = ...
            return function(text)
                local a2, a1 = text:match(unpattern)
                if not a1 then
                    return nil, nil
                end
                return a1+0, a2
            end
        ]=]

		local t = {}
		t[#t + 1] = [=[
            return function(text)
                local ]=]

		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "a"
			if not index_translation then
				t[#t + 1] = i
			else
				t[#t + 1] = index_translation[i]
			end
		end

		t[#t + 1] = [=[ = text:match(]=]
		t[#t + 1] = ("%q"):format(unpattern)
		t[#t + 1] = [=[)
                if not a1 then
                    return ]=]

		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "nil"
		end

		t[#t + 1] = "\n"
		t[#t + 1] = [=[
                end
                ]=]

		t[#t + 1] = "return "
		for i = 1, highest_index do
			if i ~= 1 then
				t[#t + 1] = ", "
			end
			t[#t + 1] = "a"
			t[#t + 1] = i
			if number_indexes[i] then
				t[#t + 1] = "+0"
			end
		end
		t[#t + 1] = "\n"
		t[#t + 1] = [=[
            end
        ]=]

		t = table.concat(t, "")

		-- print(t)

		cache[pattern] = assert(loadstring(t))()
	end

	return cache[pattern]
end

function Deformat(text, pattern)
	if type(text) ~= "string" then
		error(("Argument #1 to `Deformat' must be a string, got %s (%s)."):format(type(text), text), 2)
	elseif type(pattern) ~= "string" then
		error(("Argument #2 to `Deformat' must be a string, got %s (%s)."):format(type(pattern), pattern), 2)
	end

	return get_deformat_function(pattern)(text)
end

function WCL.ShowUnofficialWclGuide()
	local guide = "检测到未安装WclPlayerScore-WotLK插件！\n\n" ..
		"SenderInfo的非官方WCL功能需要依赖WclPlayerScore-WotLK插件。\n\n" ..
		"请前往以下地址下载并安装：\n" ..
		"https://www.wowinterface.com/downloads/info26442-WCLPlayerScore-WotLK-CN.html\n\n" ..
		"安装步骤：\n" ..
		"1. 下载WclPlayerScore-WotLK插件\n" ..
		"2. 解压到Interface\\AddOns\\目录\n" ..
		"3. 确保目录结构为：Interface\\AddOns\\WclPlayerScore-WotLK\\\n" ..
		"4. 在游戏插件管理中启用该插件\n" ..
		"5. 重载插件（/reload）或重新登录游戏\n\n" ..
		"如果不想使用非官方WCL功能，请在插件设置中关闭。" ..
		"\n如有疑问请联系插件作者。" ..
		"\n反馈Q群:469058815。"

	if WCL.unofficialGuideFrame then
		WCL.unofficialGuideFrame:Show()
		return
	end

	local frame = CreateFrame("Frame", "SenderInfoUnofficialGuideFrame", UIParent, "BackdropTemplate")
	frame:SetSize(550, 450) -- 增加窗口大小以容纳复制按钮
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	})
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOP", frame, "TOP", 0, -20)
	title:SetText("SenderInfo 非官方WCL使用指南")

	local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
	closeButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	-- 创建下载链接区域
	local linkFrame = CreateFrame("Frame", nil, frame)
	linkFrame:SetSize(450, 60)
	linkFrame:SetPoint("TOP", frame, "TOP", 0, -80)

	-- 下载链接标签
	local linkLabel = linkFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	linkLabel:SetPoint("TOPLEFT", linkFrame, "TOPLEFT", 0, 0)
	linkLabel:SetText("下载地址：")
	linkLabel:SetJustifyH("LEFT")

	-- 下载链接文本
	local linkText = linkFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	linkText:SetPoint("TOPLEFT", linkLabel, "BOTTOMLEFT", 0, -5)
	linkText:SetPoint("RIGHT", linkFrame, "RIGHT", -80, 0) -- 为复制按钮留出空间
	linkText:SetText("https://www.wowinterface.com/downloads/info26442-WCLPlayerScore-WotLK-CN.html")
	linkText:SetJustifyH("LEFT")
	linkText:SetTextColor(0.4, 0.6, 1.0) -- 蓝色链接样式

	-- 复制按钮
	local copyButton = CreateFrame("Button", nil, linkFrame, "UIPanelButtonTemplate")
	copyButton:SetSize(60, 25)
	copyButton:SetPoint("TOPRIGHT", linkFrame, "TOPRIGHT", 0, -25)
	copyButton:SetText("复制")
	copyButton:SetScript("OnClick", function()
		-- 使用与官方WCL修复相同的复制方式
		if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
			local editBox = ChatEdit_ChooseBoxForSend()
			if editBox then
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("https://www.wowinterface.com/downloads/info26442-WCLPlayerScore-WotLK-CN.html")
				editBox:HighlightText()
				editBox:SetFocus()
			end
		end
		-- 显示复制成功提示
		copyButton:SetText("已复制")
		-- 2秒后恢复按钮文本
		C_Timer.After(2, function()
			copyButton:SetText("复制")
		end)
	end)

	-- 安装说明文本
	local installText = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	installText:SetPoint("TOPLEFT", linkFrame, "BOTTOMLEFT", 0, -20)
	installText:SetPoint("RIGHT", frame, "RIGHT", -20, 0)
	installText:SetText("安装步骤：\n" ..
		"1. 下载WclPlayerScore-WotLK插件\n" ..
		"2. 解压到Interface\\AddOns\\目录\n" ..
		"3. 确保目录结构为：Interface\\AddOns\\WclPlayerScore-WotLK\\\n" ..
		"4. 在游戏插件管理中启用该插件\n" ..
		"5. 重载插件（/reload）或重新登录游戏\n\n" ..
		"如果不想使用非官方WCL功能，请在插件设置中关闭。\n" ..
		"如有疑问请联系插件作者。\n" ..
		"反馈Q群:469058815。")
	installText:SetJustifyH("LEFT")
	installText:SetJustifyV("TOP")

	local okButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	okButton:SetSize(100, 25)
	okButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
	okButton:SetText("确定")
	okButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	WCL.unofficialGuideFrame = frame
end

--#endregion


function WCL.ShowFixGuide()
	local guide = "检测到Provider.lua未正确导出Private对象！\n\n" ..
		"请手动在以下文件末尾添加如下代码：\n" ..
		"\n路径：Interface/AddOns/ArchonTooltip/Provider.lua\n" ..
		"\n代码：\n_G[\"ArchonTooltipPrivate\"] = Private\n" ..
		"\n操作步骤：\n" ..
		"1. 用记事本或代码编辑器打开上述Provider.lua文件。\n" ..
		"2. 在文件最后一行添加：_G[\"ArchonTooltipPrivate\"] = Private  (注意=两边有空格)\n" ..
		"3. 保存文件并重载插件（/reload）。\n" ..
		"\n如果不想使用WCL功能,请在插件设置中关闭。" ..
		"\n如有疑问请联系插件作者。" ..
		"\n反馈Q群:469058815。"

	if WCL.guideFrame then
		WCL.guideFrame:Show()
		return
	end

	local frame = CreateFrame("Frame", "SenderInfoGuideFrame", UIParent, "BackdropTemplate")
	frame:SetSize(500, 400)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	})
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOP", frame, "TOP", 0, -20)
	title:SetText("SenderInfo 官方WCL使用指南")

	local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
	closeButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	local autoFixButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	autoFixButton:SetSize(120, 25)
	autoFixButton:SetPoint("BOTTOM", frame, "BOTTOM", -60, 20)
	autoFixButton:SetText("自动修复")
	autoFixButton:SetScript("OnClick", function()
		if WCL.guideFrame then
			WCL.guideFrame:Hide()
			WCL.guideFrame:SetParent(nil)
		end
		WCL.ShowAutoFixGuide()
	end)

	local okButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	okButton:SetSize(100, 25)
	okButton:SetPoint("BOTTOM", frame, "BOTTOM", 60, 20)
	okButton:SetText("确定")
	okButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -50)
	scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -40, 60)

	local textFrame = CreateFrame("Frame", nil, scrollFrame)
	textFrame:SetSize(scrollFrame:GetWidth(), 1)

	local text = textFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	text:SetPoint("TOPLEFT", textFrame, "TOPLEFT", 0, 0)
	text:SetPoint("RIGHT", textFrame, "RIGHT", 0, 0)
	text:SetJustifyH("LEFT")
	text:SetJustifyV("TOP")
	text:SetText(guide)

	textFrame:SetHeight(text:GetStringHeight())

	scrollFrame:SetScrollChild(textFrame)

	WCL.guideFrame = frame
end

function WCL.ShowAutoFixGuide()
	if WCL.autoFixFrame then
		WCL.autoFixFrame:Show()
		return
	end

	local frame = CreateFrame("Frame", "SenderInfoAutoFixFrame", UIParent, "BackdropTemplate")
	frame:SetSize(600, 500)
	frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	frame:SetBackdrop({
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 11, right = 12, top = 12, bottom = 11 }
	})
	frame:SetMovable(true)
	frame:EnableMouse(true)
	frame:RegisterForDrag("LeftButton")
	frame:SetScript("OnDragStart", frame.StartMoving)
	frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

	local title = frame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
	title:SetPoint("TOP", frame, "TOP", 0, -20)
	title:SetText("SenderInfo 官方WCL自动修复")

	local closeButton = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
	closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)
	closeButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	local scrollFrame = CreateFrame("ScrollFrame", nil, frame, "UIPanelScrollFrameTemplate")
	scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 20, -50)
	scrollFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -40, 80)

	local contentFrame = CreateFrame("Frame", nil, scrollFrame)
	contentFrame:SetSize(scrollFrame:GetWidth(), 1)

	local descText = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	descText:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, 0)
	descText:SetPoint("RIGHT", contentFrame, "RIGHT", 0, 0)
	descText:SetJustifyH("LEFT")
	descText:SetJustifyV("TOP")
	descText:SetText(
		"检测到您需要修复WCL功能！\n\n我们为您准备了自动修复脚本，请按以下步骤操作：\n\n1. 点击下方的'打开修复脚本'按钮\n2. 双击运行'官方WCL修复.bat'文件 (后缀.txt改为.bat)\n3. 按照脚本提示完成修复\n4. 在游戏聊天框中输入 /reload 重载插件 或者重新登录游戏\n请手动前往以下路径手动执行修复：")

	local pathFrame = CreateFrame("Frame", nil, contentFrame, "BackdropTemplate")
	pathFrame:SetSize(contentFrame:GetWidth() - 20, 40)
	pathFrame:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, -descText:GetStringHeight() - 20)
	pathFrame:SetBackdrop({
		bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
		edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
		tile = true,
		tileSize = 16,
		edgeSize = 1,
		insets = { left = 3, right = 3, top = 3, bottom = 3 }
	})
	pathFrame:SetBackdropColor(0.1, 0.1, 0.1, 0.8)
	pathFrame:SetBackdropBorderColor(0.6, 0.6, 0.6, 1)

	local pathText = pathFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
	pathText:SetPoint("CENTER", pathFrame, "CENTER", 0, 0)
	pathText:SetText("Interface\\AddOns\\SenderInfo\\官方WCL修复.bat")

	local copyButton = CreateFrame("Button", nil, pathFrame, "UIPanelButtonTemplate")
	copyButton:SetSize(80, 25)
	copyButton:SetPoint("RIGHT", pathFrame, "RIGHT", -5, 0)
	copyButton:SetText("复制路径")
	copyButton:SetScript("OnClick", function()
		if C_ChatInfo and C_ChatInfo.RegisterAddonMessagePrefix then
			local editBox = ChatEdit_ChooseBoxForSend()
			if editBox then
				ChatEdit_ActivateChat(editBox)
				editBox:SetText("Interface\\AddOns\\SenderInfo\\官方WCL修复.bat")
				editBox:HighlightText()
				editBox:SetFocus()
			end
		end
	end)

	local bottomText = contentFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
	bottomText:SetPoint("TOPLEFT", contentFrame, "TOPLEFT", 0, -descText:GetStringHeight() - 120)
	bottomText:SetPoint("RIGHT", contentFrame, "RIGHT", 0, 0)
	bottomText:SetJustifyH("LEFT")
	bottomText:SetJustifyV("TOP")
	bottomText:SetText("如有问题请联系插件作者\n反馈Q群: 469058815")

	local totalHeight = descText:GetStringHeight() + 120 + bottomText:GetStringHeight()
	contentFrame:SetHeight(totalHeight)

	scrollFrame:SetScrollChild(contentFrame)

	local okButton = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
	okButton:SetSize(100, 25)
	okButton:SetPoint("BOTTOM", frame, "BOTTOM", 0, 20)
	okButton:SetText("确定")
	okButton:SetScript("OnClick", function()
		frame:Hide()
		frame:SetParent(nil)
	end)

	WCL.autoFixFrame = frame
end

StaticPopupDialogs["SENDERINFO_OPEN_FOLDER"] = {
	text = "无法自动打开文件夹，请手动前往以下路径：\n\nInterface\\AddOns\\SenderInfo\\\n\n找到并双击运行'官方WCL修复.bat'文件。",
	button1 = "确定",
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
}

-- 检查插件目录是否存在
local function IsAddOnDirectoryExists(addonName)
	-- 检查插件是否已安装（不依赖加载状态）
	-- 方法1：检查插件是否在插件列表中
	if C_AddOns and C_AddOns.GetAddOnInfo then
		local name, title, notes, loadable, reason, security, newVersion = C_AddOns.GetAddOnInfo(addonName)
		if name and name ~= "" then
			return true
		end
	end

	-- 方法2：检查插件是否已加载（备用方案）
	if IsAddOnLoaded(addonName) then
		return true
	end

	-- 方法3：检查全局变量（如果插件注册了全局变量）
	if _G[addonName] then
		return true
	end

	return false
end

function WCL.Check(config)
	local showWCL = config.ShowWCL;
	local useOfficialWCL = config.UseOfficialWCL;
	local useUnofficialWCL = config.UseUnofficialWCL;

	if not showWCL then
		return;
	end

	if not useOfficialWCL and not useUnofficialWCL then
		--需要显示WCL 但是没选择使用官方的还是非官方的 必须选择其中一个 或者多个
		return;
	end

	if useOfficialWCL then
		-- 默认第三方WCL检查逻辑
		if not _G["ArchonTooltipPrivate"] then
			WCL.ShowFixGuide()
		end
	end

	if useUnofficialWCL then
		-- 非官方WCL检查逻辑 - 使用目录检查避免加载顺序问题
		if not IsAddOnDirectoryExists("WclPlayerScore-WotLK") then
			WCL.ShowUnofficialWclGuide()
		end
	end
end

local function GetWclScore(config, content)
	if config.ShowWCLHideKills then
		if (string.find(content, "击杀")) then
			return nil
		end
	end

	return content
end

-- 官方WCL数据获取逻辑
function WCL.GetOfficialWclScore(config, name, realm)
	local ArchonTooltip = _G.ArchonTooltip
	if not ArchonTooltip then
		return nil
	end
	local Private = _G["ArchonTooltipPrivate"] or ArchonTooltip.Private or nil
	if not Private or not Private.GetProfile or not Private.GetProfileLines then
		return nil
	end
	local profile = Private.GetProfile(name, realm)
	if not profile then
		return nil
	end
	local lines = Private.GetProfileLines(profile)
	if not lines or #lines == 0 then
		return nil
	end

	local result = ""
	local showReverse = config.ShowWCLReverse or true;
	if showReverse then
		for i = #lines, 2, -1 do
			local score = GetWclScore(config, lines[i])
			if score then
				result = result .. score
			end
		end
	else
		for i = 2, #lines do
			local score = GetWclScore(config, lines[i])
			if score then
				result = result .. score
			end
		end
	end

	return result
end

-- 非官方WCL数据获取逻辑
function WCL.GetUnofficialWclScore(config, name, realm)
	return UnofficialWclScoreValue(name);
end

function WCL.GetWclScore(config, name, realm)
	local result = ""
	local useOfficialWCL = config.UseOfficialWCL;

	if useOfficialWCL then
		result = result .. WCL.GetOfficialWclScore(config, name, realm)
	end

	local useUnofficialWCL = config.UseUnofficialWCL;

	if useUnofficialWCL then
		if result ~= "" then
			result = result .. "\n"
		end
		result = result .. WCL.GetUnofficialWclScore(config, name, realm)
	end

	return result
end

_G.SenderInfoWCL = WCL
local __addon, __private = ...
__private.WCL = WCL
