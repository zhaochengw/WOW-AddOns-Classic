--[[--
	by ALA
--]]--
----------------------------------------------------------------------------------------------------
local __addon, __private = ...;
local MT = __private.MT;
local CT = __private.CT;
local VT = __private.VT;
local DT = __private.DT;

--		upvalue
	local pcall = pcall;
	local type = type;
	local next, unpack, rawset, rawget = next, unpack, rawset, rawget;
	local select = select;
	local wipe, tinsert, tremove = table.wipe, table.insert, table.remove;
	local strsplit, strsub, strupper, strmatch, format, gsub = string.split, string.sub, string.upper, string.match, string.format, string.gsub;
	local tostring, tonumber = tostring, tonumber;
	local min, max, floor, random = math.min, math.max, math.floor, math.random;
	local sin360, cos360 = sin, cos;
	local UnitLevel = UnitLevel;
	local GetItemInfo = GetItemInfo;
	local GetSpellInfo = GetSpellInfo;
	local FindSpellBookSlotBySpellID, PickupSpell = FindSpellBookSlotBySpellID, PickupSpell;
	local IsControlKeyDown = IsControlKeyDown;
	local IsAltKeyDown = IsAltKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
	local CreateFrame = CreateFrame;
	local GetMouseFocus = VT._comptb.GetMouseFocus;
	local GetCursorPosition = GetCursorPosition;
	local SetPortraitToTexture = SetPortraitToTexture;
	local _G = _G;
	local DressUpItemLink = DressUpItemLink;
	local ChatEdit_ChooseBoxForSend = ChatEdit_ChooseBoxForSend;
	local UIParent = UIParent;
	local GameTooltip = GameTooltip;
	local StaticPopupDialogs = StaticPopupDialogs;
	local StaticPopup_Show = StaticPopup_Show;

-->
	local l10n = CT.l10n;

-->		constant
	local TUISTYLE = {
		FrameBorderSize = 8,

		FrameXSizeMin_Style1 = 250,
		FrameYSizeMin_Style1 = 165,
		FrameXSizeMin_Style2 = 100,
		FrameYSizeMin_Style2 = 180,
		FrameHeaderYSize = 20,
		FrameFooterYSize = 24,

		FrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		FrameFontSizeLarge = 16,
		FrameFontSize = 14,
		FrameFontSizeMedium = 13,
		FrameFontSizeSmall = 10,
		FrameFontOutline = "OUTLINE",

		TreeFrameXToBorder = 1,
		TreeFrameYToBorder = 0,
		TreeFrameHeaderYSize = 0,
		TreeFrameFooterYSize = 20,
		TreeFrameSeqWidth = 1,
		TreeFrameLabelBackgroundTexCoord = { 0.05, 0.95, 0.05, 0.95, },
		TreeNodeSize = 40,
		TreeNodeXGap = 12,
		TreeNodeYGap = 12,
		TreeNodeXToBorder = 12,
		TreeNodeYToTop = 12,
		TreeNodeYToBottom = 10,
		TreeNodeFont = NumberFont_Shadow_Med:GetFont(),--=[[Fonts\ARHei.ttf]]--[[Fonts\FRIZQT__.TTF]],
		TreeNodeFontSize = 16,
		TreeNodeFontOutline = "OUTLINE",

		TalentDepArrowXSize = 16,
		TalentDepArrowYSize = 20,
		TalentDepBranchXSize = 8,

		SpellListFrameXSize = 200,
		SpellListFrameFont = SystemFont_Shadow_Med1:GetFont(),--=="Fonts\ARKai_T.ttf"
		SpellListFrameFontSize = 14,
		SpellListFrameFontOutline = "OUTLINE",
		SpellListFrameXToBorder = 2,
		SpellListFrameYToTop = 20,
		SpellListFrameYToBottom = 24,
		SpellListNodeHeight = 24,
		SpellListNodeIconTexCoord = { 0.05, 0.95, 0.05, 0.95, },
		SpellListSearchEditYSize = 16,
		SpellListSearchEditOkayXSize = 32,

		EquipmentFrameXSize = CT.TOCVERSION < 20000 and 280 or 340,
		EquipmentFrameXMaxSize = CT.TOCVERSION < 20000 and 640 or 765,
		EquipmentNodeSize = CT.TOCVERSION < 20000 and 36 or 38,
		EquipmentNodeGap = CT.TOCVERSION < 20000 and 4 or 6,
		EquipmentNodeXToBorder = 8,
		EquipmentNodeYToBorder = 8,
		EquipmentNodeTextGap = 4,
		EquipmentNodeLayout = {
			L = {  1,  2,  3, 15,  5, 19,  4,  9, },
			R = { 10,  6,  7,  8, 11, 12, 13, 14, },
			B = { 16, 17, 18,  0, },
		},
		EngravingNodeSize = 16;

		GlyphFrameSize = 200,
		PrimeGlyphNodeSize = 62,
		MajorGlyphNodeSize = 48,
		MinorGlyphNodeSize = 36,

		ControlButtonSize = 18,
		SideButtonSize = 25,
		SideButtonGap = 2,
		EditBoxXSize = 240,
		EditBoxYSize = 24,
		CurClassIndicatorSize = 34,

		TreeButtonXSize = 68,
		TreeButtonYSize = 18,
		TreeButtonGap = 4,

		IconTextDisabledColor = { 1.0, 1.0, 1.0, 1.0, },
		IconTextAvailableColor = { 0.0, 1.0, 0.0, 1.0, },
		IconTextMaxRankColor = { 1.0, 1.0, 0.0, 1.0, },
		IconToolTipCurRankColor = { 0.0, 1.0, 0.0, 1.0, },
		IconToolTipNextRankColor = { 0.0, 0.5, 1.0, 1.0, },
		IconToolTipNextRankDisabledColor = { 1.0, 0.0, 0.0, 1.0, },
		IconToolTipMaxRankColor = { 1.0, 0.5, 0.0, 1.0, },

	};
	local TTEXTURESET = {
		LIBDBICON = CT.TEXTUREICON,
		UNK = CT.TEXTUREUNK,
		SQUARE_HIGHLIGHT = CT.TEXTUREPATH .. [[CheckButtonHighlight]],
		NORMAL_HIGHLIGHT = CT.TEXTUREPATH .. [[UI-Panel-MinimizeButton-Highlight]],

		SEP_HORIZONTAL = {
			Path = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderLeft]],
			Coord = { 0.25, 0.3125, 0.0, 1.0, },
		},
		SEP_VERTICAL = {
			Path = CT.TEXTUREPATH .. [[UI-ChatFrame-BorderTop]],
			Coord = { 0.0, 1.0, 0.25, 0.3125, },
		},

		CONTROL = {
			NORMAL_COLOR = { 0.75, 0.75, 0.75, 1.0, },
			PUSHED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
			DISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
			HIGHLIGHT_COLOR = { 0.25, 0.25, 0.5, 1.0, },
			CHECKED_COLOR = { 0.75, 0.75, 0.75, 1.0, },
			CHECKEDDISABLED_COLOR = { 0.25, 0.25, 0.25, 1.0, },
		},

		CHECK = {
			Normal = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Pushed = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Disabled = {
				Path = CT.TEXTUREPATH .. [[CheckButtonBorder]],
			},
			Checked = {
				Path = CT.TEXTUREPATH .. [[CheckButtonCenter]],
			},
			CheckedDisabled = {
				Path = CT.TEXTUREPATH .. [[CheckButtonCenter]],
			},
		},

		ARROW = CT.TEXTUREPATH .. [[UI-TalentArrows]],
		ARROW_COORD = {
			[1] = {  8 / 64, 24 / 64, 40 / 64, 56 / 64, },	--vertical disable
			[2] = {  8 / 64, 24 / 64, 08 / 64, 26 / 64, },	--vertical enable
			[3] = { 40 / 64, 56 / 64, 40 / 64, 56 / 64, },	--horizontal disable
			[4] = { 40 / 64, 56 / 64,  8 / 64, 24 / 64, },	--horizontal enable
		},
		BRANCH = CT.TEXTUREPATH .. [[UI-TalentBranches]],
		BRANCH_COORD = {
			[1] = { 44 / 256, 54 / 256, 0.5, 1.0, },		--vertical disable
			[2] = { 44 / 256, 54 / 256, 0.0, 0.5, },		--vertical enable
			[3] = { 66 / 256, 98 / 256, 43 / 64, 53 / 64, },--horizontal disable
			[4] = { 66 / 256, 98 / 256, 11 / 64, 21 / 64, },--horizontal enable
			[5] = { 143 / 256, 153 / 256, 43 / 64, 53 / 64, },
			[6] = { 143 / 256, 153 / 256, 11 / 64, 21 / 64, },
		},

		ICON_LIGHT_COLOR = { 1.0, 1.0, 1.0, 1.0, },
		ICON_UNLIGHT_COLOR = { 0.250, 0.250, 0.250, 1.0, },
		ICON_HIGHLIGHT = {
			Coord = { 0.08, 0.92, 0.08, 0.92, },
			Color = { 0.0, 1.0, 1.0, },
			Blend = "ADD",
		},

		RESETTREE = {
			Backgroud = {
				Path = CT.TEXTUREPATH .. [[Arcane_Circular_Frame]],
				Coord = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
				Color = { 0.25, 0.25, 0.25, },
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[Arcane_Circular_Flash]],
				Coord = { 12 / 128, 118 / 128, 12 / 128, 118 / 128, },
			},
		},

		CLOSE = {
			Path = CT.TEXTUREPATH .. [[Close]],
		},
		RESETTOEMU = {
			Path = CT.TEXTUREPATH .. [[Close]],
		},
		RESETTOSET = {
			Path = CT.TEXTUREPATH .. [[Reset]],
		},
		EXPAND = {
			Path = CT.TEXTUREPATH .. [[Expand]],
		},
		SHRINK = {
			Path = CT.TEXTUREPATH .. [[Shrink]],
		},
		DROP = {
			Path = CT.TEXTUREPATH .. [[ArrowDown]],
		},
		RESETALL = {
			Path = CT.TEXTUREPATH .. [[Reset]],
		},

		TREEBUTTON = {
			Normal = {
				Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.5 },
			},
			Pushed = {
				Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.25 },
			},
			Highlight = {
				-- Path = CT.TEXTUREUNK,
				Coord = { 0.05, 0.95, 0.40, 0.70, },
				Color = { 1.0, 1.0, 1.0, 0.15 },
			},
			Indicator = {
				Coord = { 0.10, 0.90, 0.08, 0.92, },
				Color = { 0.0, 1.0, 1.0, },
			},
		},

		SPELLTAB = {
			Path = CT.TEXTUREPATH .. [[SpellList]],
		},
		APPLY = {
			Path = CT.TEXTUREPATH .. [[Apply]],
		},
		SETTING = {
			Path = CT.TEXTUREPATH .. [[Config]],
		},
		IMPORT = {
			Path = CT.TEXTUREPATH .. [[Import]],
		},
		EXPORT = {
			Path = CT.TEXTUREPATH .. [[Export]],
		},
		SAVE = {
			Path = CT.TEXTUREPATH .. [[Save]],
		},
		SEND = {
			Path = CT.TEXTUREPATH .. [[Send]],
		},
		EDIT_OKAY = {
			Path = CT.TEXTUREPATH .. [[Apply]],
		},

		CLASS = {
			Normal = {
				Path = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
			},
			Pushed = {
				Path = CT.TEXTUREPATH .. [[UI-Classes-Circles]],
			},
			Highlight = {
				Path = CT.TEXTUREPATH .. [[UI-Calendar-Button-Glow]],
				Coord = { 6 / 64, 57 / 64, 6 / 64, 57 / 64, },
				Color = { 0.0, 1.0, 0.0, 1.0, },
			},
			Indicator = {
				Path = CT.TEXTUREPATH .. [[EventNotificationGlow]],
				Coord = { 4 / 64, 60 / 64, 5 / 64, 61 / 64, },
				Color = { 0.0, 1.0, 0.0, 1.0, },
			},
		},

		EQUIPMENTTOGGLE = {
			Path = CT.TEXTUREPATH .. [[Equipment]],
		},
		EQUIPMENT = {
			Glow = {
				Path = [[Interface\Buttons\UI-ActionButton-Border]],
				Coord = { 0.25, 0.75, 0.25, 0.75, },
			},
			Highlight = {
				Path = [[Interface\Buttons\ActionbarFlyoutButton-FlyoutMidLeft]],
				Coord = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, },
			},
			Empty = {
				[0] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ammo]],
				[1] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Head]],
				[2] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Neck]],
				[3] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shoulder]],
				[4] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Shirt]],
				[5] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Chest]],
				[6] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Waist]],
				[7] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Legs]],
				[8] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Feet]],
				[9] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Wrists]],
				[10] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Hands]],
				[11] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Finger]],
				[12] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Rfinger]],
				[13] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
				[14] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Trinket]],
				[15] = [[Interface\Paperdoll\UI-Backpack-EmptySlot]],
				[16] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Mainhand]],
				[17] = [[Interface\Paperdoll\UI-PaperDoll-Slot-SecondaryHand]],
				[18] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Ranged]],
				[19] = [[Interface\Paperdoll\UI-PaperDoll-Slot-Tabard]],
			},
		},
		ENGRAVING = {
			Normal = {
				Path = CT.TEXTUREUNK,
			},
			Highlight = {
				Path = [[Interface\Buttons\ActionbarFlyoutButton-FlyoutMidLeft]],
				Coord = { 8 / 32, 24 / 32, 8 / 64, 24 / 64, },
			},
		},
	};

-->
MT.BuildEnv('UI');
-->		predef
-->		UI
	local NodeBorderMT = {
		__index = function(Border, key)
			if key == 0 then
				return nil;
			elseif Border[1][key] then
				if type(Border[1][key]) == 'function' then
					local function func(Border, ...)
						Border[4][key](Border[4], ...);
						Border[3][key](Border[3], ...);
						Border[2][key](Border[2], ...);
						return Border[1][key](Border[1], ...);
					end
					Border[key] = func;
					return func;
				else
					return Border[1][key];
				end
			else
				return nil;
			end
		end,
		__newindex = function(Border, key, val)
			rawset(Border, key, val);
			if key ~= 0 and type(Border[1][key]) ~= 'function' then
				Border[1][key] = val;
				Border[2][key] = val;
				Border[3][key] = val;
				Border[4][key] = val;
			end
		end,
	};
	local function CreateFlatBorder(Node, width)
		local Border = {  };
		Border[1] = Node:CreateTexture(nil, "OVERLAY", nil, -8);
		Border[2] = Node:CreateTexture(nil, "OVERLAY", nil, -8);
		Border[3] = Node:CreateTexture(nil, "OVERLAY", nil, -8);
		Border[4] = Node:CreateTexture(nil, "OVERLAY", nil, -8);
		Border[1]:SetHeight(width);
		Border[2]:SetWidth(width);
		Border[3]:SetHeight(width);
		Border[4]:SetWidth(width);
		Border[1]:SetPoint("TOPLEFT");
		Border[1]:SetPoint("TOPRIGHT", -width, 0);
		Border[2]:SetPoint("TOPRIGHT");
		Border[2]:SetPoint("BOTTOMRIGHT", 0, width);
		Border[3]:SetPoint("BOTTOMRIGHT");
		Border[3]:SetPoint("BOTTOMLEFT", width, 0);
		Border[4]:SetPoint("BOTTOMLEFT");
		Border[4]:SetPoint("TOPLEFT", 0, -width);
		setmetatable(Border, NodeBorderMT);
		Border:SetColorTexture(0.0, 0.0, 0.0, 1.0);

		return Border;
	end
	local _TextureFunc = {  };
	function _TextureFunc._SetTexture(Texture, Path, Coord, Color, Blend)
		if Path then
			Texture:SetTexture(Path);
			if Color then
				Texture:SetVertexColor(Color[1] or 0.0, Color[2] or 0.0, Color[3] or 0.0, Color[4] or 1.0);
			end
			if Blend then
				Texture:SetBlendMode(Blend);
			end
		elseif Color then
			Texture:SetColorTexture(Color[1] or 0.0, Color[2] or 0.0, Color[3] or 0.0, Color[4] or 1.0);
		end
		if Coord then
			Texture:SetTexCoord(unpack(Coord));
		end
		return Texture;
	end
	function _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend)
		if def then
			return _TextureFunc._SetTexture(Texture, def.Path or Path, def.Coord or Coord, def.Color or Color, def.Blend or Blend);
		else
			return _TextureFunc._SetTexture(Texture, Path, Coord, Color, Blend);
		end
	end
	function _TextureFunc.SetNormalTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetNormalTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetNormalTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function _TextureFunc.SetPushedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetPushedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetPushedTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function _TextureFunc.SetDisabledTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetDisabledTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetDisabledTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function _TextureFunc.SetHighlightTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetHighlightTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "HIGHLIGHT");
			Texture:SetAllPoints();
			Widget:SetHighlightTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function _TextureFunc.SetCheckedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetCheckedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "OVERLAY");
			Texture:SetAllPoints();
			Widget:SetCheckedTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function _TextureFunc.SetDisabledCheckedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetDisabledCheckedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "OVERLAY");
			Texture:SetAllPoints();
			Widget:SetDisabledCheckedTexture(Texture);
		end
		return _TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	MT._TextureFunc = _TextureFunc;
	--[==[	Frame Definition
		Frame
					initialized		(bool)
					style			(num(identify))
					CurTreeIndex	(num)
					ClassTDB		(table)
					class			(string)
					level			(num)
					TotalUsedPoints	(num)
					TotalAvailablePoints	(num)
					data			(string)
					readOnly		(bool)
					name			(string)
					TreeButtonsBar					CurTreeIndicator	(texture)
					TreeButtons[]	(frame table)
					TreeFrames[]	(frame table)
													id					(identify)
													TreeNodes			(frame)
																					id					(identify)
																					MaxVal				(fontString)
																					MinVal				(fontString)
																					Split				(fontString)
																					active				(bool)
																					TalentSeq				(num)
													HSeq				(texture)
													VSep				(texture)
													TreeLabel			(fontstring)
													TreeLabelBackground			(texture)
													TalentSet			(table)
																					total
																					CountByTier			(num table)
																					TopCheckedTier		(num)
																					TopAvailableTier	(num)
													DependArrows		(table)
																					coordFamily			(num(identify))
													NodeDependArrows	(table-table)
													TreeTDB				(table)
	--]==]
	--
		function MT.UI.FrameSetName(Frame, name)				--	NAME CHANGED HERE ONLY	--	and MT.UI.FrameUpdateLabelText
			Frame.name = name;
			if name ~= nil then
				local cache = VT.TQueryCache[name];
				local objects = Frame.objects;
				objects.Name:SetText(name);
				if VT.__supreme and cache ~= nil and cache.PakData[1] ~= nil then
					local _, info = VT.__dep.__emulib.DecodeAddOnPackData(cache.PakData[1]);
					if info then
						objects.PackLabel:SetText(info);
						objects.PackLabel:Show();
					else
						objects.PackLabel:Hide();
					end
				else
					objects.PackLabel:Hide();
				end
				objects.ResetToEmuButton:Show();
				objects.ResetToSetButton:Hide();
				local ClassButtons = Frame.ClassButtons;
				for index = 1, #DT.IndexToClass do
					ClassButtons[index]:Hide();
				end
				objects.CurClassIndicator:Hide();
				local TreeFrames = Frame.TreeFrames;
				for TreeIndex = 1, 3 do
					wipe(TreeFrames[TreeIndex].TalentChanged);
				end
				if name ~= l10n.message then
					MT.UI.FrameSetBinding(Frame, name);
					if cache == nil or cache.EquData.Tick == nil then
						Frame.objects.EquipmentFrameButton:Hide();
						Frame.EquipmentFrameContainer:Hide();
						MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
					else
						Frame.objects.EquipmentFrameButton:Show();
					end
				else
					Frame.objects.EquipmentFrameButton:Hide();
					Frame.EquipmentFrameContainer:Hide();
					MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
				end
			else
				local objects = Frame.objects;
				objects.Name:SetText(l10n.Emulator);
				objects.PackLabel:Hide();
				objects.ResetToEmuButton:Hide();
				objects.ResetToSetButton:Hide();
				local ClassButtons = Frame.ClassButtons;
				for index = 1, #DT.IndexToClass do
					ClassButtons[index]:Show();
				end
				objects.CurClassIndicator:Show();
				objects.CurClassIndicator:ClearAllPoints();
				objects.CurClassIndicator:SetPoint("CENTER", ClassButtons[DT.ClassToIndex[Frame.class]]);
				MT.UI.FrameReleaseBinding(Frame);
				Frame.objects.EquipmentFrameButton:Hide();
				Frame.EquipmentFrameContainer:Hide();
				MT.Debug("EquipFrame", "MT.UI.FrameSetName Hide");
			end
		end
		function MT.UI.FrameSetLevel(Frame, level)				--	LEVEL CHANGED HERE ONLY
			if level == nil then
				Frame.level = DT.MAX_LEVEL;
				Frame.TotalUsedPoints = 0;
				Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(Frame.class, DT.MAX_LEVEL);
			else
				if type(level) == 'string' then
					level = tonumber(level);
				end
				Frame.level = level;
				Frame.TotalAvailablePoints = MT.GetLevelAvailablePoints(Frame.class, level);
			end
			MT.UI.FrameUpdateFooterText(Frame);
		end
		function MT.UI.FrameSetClass(Frame, class)				--	CLASS CHANGED HERE ONLY
			if class == nil then
				Frame.class = nil;
				Frame.ClassTDB = nil;
				Frame.initialized = false;
				Frame.objects.Name:SetTextColor(1.0, 1.0, 1.0, 1.0);
				Frame.objects.Label:SetTextColor(1.0, 1.0, 1.0, 1.0);
			else
				--	check class value
					local Type = type(class);
					if Type == 'number' then
						if DT.IndexToClass[class] == nil then
							MT.Debug("MT.UI.FrameSetClass", 1, "class", "number", class);
							return false;
						end
						class = DT.IndexToClass[class];
					elseif Type == 'table' then
						class = class.class;
						Type = type(class);
						if Type == 'number' then
							if DT.IndexToClass[class] == nil then
								MT.Debug("MT.UI.FrameSetClass", 2, "class", "table", "number", class);
								return false;
							end
							class = DT.IndexToClass[class];
						elseif Type ~= 'string' then
							MT.Debug("MT.UI.FrameSetClass", 3, "class", "table", Type, class);
							return false;
						else
							class = strupper(class);
							if DT.ClassToIndex[class] == nil then
								MT.Debug("MT.UI.FrameSetClass", 4, "class", "table", "string", class);
								return false;
							end
						end
					elseif Type == 'string' then
						class = strupper(class);
						if DT.ClassToIndex[class] == nil then
							local index = tonumber(class);
							if index ~= nil then
								class = DT.IndexToClass[index];
								if class == nil then
									MT.Debug("MT.UI.FrameSetClass", 5, "class", "string", index);
									return false;
								end
							end
						end
					else
						MT.Debug("MT.UI.FrameSetClass", 6, "class", Type);
						return false;
					end
				--

				local SpecList = DT.ClassSpec[class];
				if SpecList == nil then
					MT.Debug("MT.UI.FrameSetClass", 7, class, "SpecList == nil");
					return false;
				end
				local ClassTDB = DT.TalentDB[class];
				if ClassTDB == nil then
					MT.Debug("MT.UI.FrameSetClass", 8, class, "ClassTDB == nil");
					return false;
				end
				local TreeFrames = Frame.TreeFrames;
				local TreeButtons = Frame.TreeButtons;
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local SpecID = SpecList[TreeIndex];
					local TreeTDB = ClassTDB[SpecID];
					TreeFrame.SpecID = SpecID;

					local SpecTexture = DT.TalentSpecIcon[SpecID];
					local TreeButton = TreeButtons[TreeIndex];
					if SpecTexture ~= nil then
						TreeButton:SetNormalTexture(SpecTexture);
						TreeButton:SetPushedTexture(SpecTexture);
						TreeButton:SetHighlightTexture(SpecTexture);
						TreeButton.information = l10n.SPEC[SpecID];
						TreeButton.Title:SetText(l10n.SPEC[SpecID]);
					else
						TreeButton:SetNormalTexture(TTEXTURESET.UNK);
						TreeButton:SetPushedTexture(TTEXTURESET.UNK);
						TreeButton:SetHighlightTexture(TTEXTURESET.UNK);
					end
					TreeFrame.Background:SetTexture(DT.SpecBackground[SpecID]);
					TreeFrame.TreeLabel:SetText(l10n.SPEC[SpecID]);
					-- TreeFrame.TreeLabelBackground:SetTexture(SpecTexture);
					SetPortraitToTexture(TreeFrame.TreeLabelBackground, SpecTexture)
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] ~= nil then
							local Node = TreeNodes[TalentDef[10]];
							Node.TalentSeq = TalentSeq;
							Node:Show();
							local _, _, texture = GetSpellInfo(TalentDef[8][1]);
							if texture ~= nil then
								Node:SetNormalTexture(texture);
								Node:SetPushedTexture(texture);
								-- SetPortraitToTexture(Node:GetNormalTexture(), texture);
								-- SetPortraitToTexture(Node:GetPushedTexture(), texture);
							elseif TalentDef[9] ~= nil then
								Node:SetNormalTexture(TalentDef[9]);
								Node:SetPushedTexture(TalentDef[9]);
								-- SetPortraitToTexture(Node:GetNormalTexture(), TalentDef[9]);
								-- SetPortraitToTexture(Node:GetPushedTexture(), TalentDef[9]);
							else
								Node:SetNormalTexture(TTEXTURESET.UNK);
								Node:SetPushedTexture(TTEXTURESET.UNK);
								-- SetPortraitToTexture(Node:GetNormalTexture(), TTEXTURESET.UNK);
								-- SetPortraitToTexture(Node:GetPushedTexture(), TTEXTURESET.UNK);
							end
							Node.MaxVal:SetText(TalentDef[4]);
							Node.CurVal:SetText("0");

							local DepTSeq = TalentDef[11];
							if DepTSeq ~= nil then
								local Arrow = MT.UI.DependArrowGet(TreeFrame);
								MT.UI.DependArrowSet(Arrow, TalentDef[1] - TalentDef[5], TalentDef[2] - TalentDef[6], false, Node, TreeNodes[TreeTDB[DepTSeq][10]]);
								local DepArrows = TreeFrame.NodeDependArrows[DepTSeq];
								DepArrows[#DepArrows + 1] = Arrow;
							end

							if TalentDef[1] == 0 then
								if TalentDef[5] == nil then
									MT.UI.TreeNodeActivate(Node);
								end
							end
						end
					end
					TreeFrame.TreeTDB = TreeTDB;
				end

				local color = CT.RAID_CLASS_COLORS[class];
				Frame.objects.Name:SetTextColor(color.r, color.g, color.b, 1.0);
				Frame.objects.Label:SetTextColor(color.r, color.g, color.b, 1.0);
				Frame.Background:SetTexture(DT.ClassBackground[class][random(1, #DT.ClassBackground[class])]);

				Frame.class = class;
				Frame.ClassTDB = ClassTDB;
				Frame.initialized = true;

				if CT.SELFCLASS == class then
					Frame.ApplyTalentsButton:Show();
				else
					Frame.ApplyTalentsButton:Hide();
				end

				MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, class, MT.GetPointsReqLevel(class, Frame.TotalUsedPoints));
				MT.UI.FrameUpdateFooterText(Frame);
			end

			return true;
		end
		function MT.UI.FrameSetTalent(Frame, TalData, activeGroup)	--	TALENTDATA CHANGED HERE ONLY
			if TalData == nil or TalData == "" then
				Frame.TalData = nil;
				local Points = Frame.objects.Name.Points1;
				Frame.objects.Name:ClearAllPoints();
				Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
				Frame.label = nil;
				Frame.objects.Label:Hide();
				Frame.objects.ResetToSetButton:ClearAllPoints();
				Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
				Frame.objects.TalentGroupSelect:Hide();
			else
				--	check point value
					if not Frame.initialized then
						MT.Debug("MT.UI.FrameSetTalent", 1, "not initialized");
						return false;
					end
					if type(TalData) ~= 'table' then
						MT.Debug("MT.UI.FrameSetTalent", 2, type(TalData));
						return false;
					end
					if TalData[1] ~= "" and tonumber(TalData[1]) == nil then
						MT.Debug("MT.UI.FrameSetTalent", 3, TalData);
						return false;
					end
				--

				Frame.TalData = TalData;
				Frame.activeGroup = activeGroup or TalData.active or 1;

				local seldata = TalData[Frame.activeGroup];
				local TreeFrames = Frame.TreeFrames;
				local len = #seldata;
				local pos = 1;

				local sum = { 0, 0, 0, };
				for TreeIndex = 1, 3 do
					if pos > len then
						break;
					end
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						if pos > len then
							break;
						end
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] ~= nil then
							local val = strsub(seldata, pos, pos);
							val = tonumber(val);
							sum[TreeIndex] = sum[TreeIndex] + val;
						end
						pos = pos + 1;
					end
				end
				-- local primaryTreeIndex = nil;
				local TreeSeq = nil;
				local TreeOffset = nil;
				local o1, o2 = #TreeFrames[1].TreeTDB, #TreeFrames[2].TreeTDB;
				if CT.TOCVERSION >= 40000 and (sum[1] > 0 or sum[2] > 0 or sum[3] > 0) then
					if sum[1] >= sum[2] then
						if sum[1] >= sum[3] then
							-- primaryTreeIndex = 1;
							TreeSeq = { 1, 2, 3, };
							TreeOffset = { 0, o1, o1 + o2, };
						else
							-- primaryTreeIndex = 3
							TreeSeq = { 3, 1, 2, };
							TreeOffset = { o1 + o2, 0, o1, };
						end
					else
						if sum[2] >= sum[3] then
							-- primaryTreeIndex = 2;
							TreeSeq = { 2, 1, 3, };
							TreeOffset = { o1, 0, o1 + o2, };
						else
							-- primaryTreeIndex = 3;
							TreeSeq = { 3, 1, 2, };
							TreeOffset = { o1 + o2, 0, o1, };
						end
					end
				else
					TreeSeq = { 1, 2, 3, };
					TreeOffset = { 0, o1, o1 + o2, };
				end

				for i = 1, 3 do
					local TreeIndex = TreeSeq[i];
					local offset = TreeOffset[i];
					pos = offset + 1;
					if pos > len then
						break;
					end
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TreeTDB = TreeFrame.TreeTDB;
					local TalentSet = TreeFrame.TalentSet;
					for TalentSeq = 1, #TreeTDB do
						if pos > len then
							break;
						end
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] ~= nil then
							local val = strsub(seldata, pos, pos);
							val = tonumber(val);
							if val ~= 0 then
								local DepTSeq = TalentDef[11];
								if DepTSeq ~= nil and DepTSeq <= len then
									local depval = strsub(seldata, offset + DepTSeq, offset + DepTSeq);
									if depval ~= "0" then
										depval = tonumber(depval);
										local deppts = depval - TalentSet[DepTSeq];
										if deppts > 0 then
											MT.UI.TreeNodeChangePoint(TreeNodes[TreeTDB[DepTSeq][10]], deppts);
										end
									end
								end
								local pts = val - TalentSet[TalentSeq];
								if pts > 0 then
									local ret = MT.UI.TreeNodeChangePoint(TreeNodes[TalentDef[10]], pts);
									if ret < 0 then
										MT.Debug("MT.UI.FrameSetTalent", 4, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
									elseif ret > 0 then
										MT.Debug("MT.UI.FrameSetTalent", 5, ret, "tab", TreeIndex, "tier", TalentDef[1], "col", TalentDef[2], "maxPoints", TalentDef[4], "set", val, TalentDef, pos);
									end
								end
							end
						end
						pos = pos + 1;
					end
				end

				if TalData.num > 1 then
					local Points = Frame.objects.Name.Points2;
					Frame.objects.Name:ClearAllPoints();
					Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
					local val = TalData[Frame.activeGroup];
					local stats = MT.CountTreePoints(val, Frame.class);
					Frame.label = stats[1] .. "-" .. stats[2] .. "-" .. stats[3];
					Frame.objects.Label:SetText(Frame.label);
					Frame.objects.Label:Show();
					Frame.objects.ResetToSetButton:ClearAllPoints();
					Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Label, "RIGHT", 0, 0);
					Frame.objects.TalentGroupSelect:Show();
				else
					local Points = Frame.objects.Name.Points1;
					Frame.objects.Name:ClearAllPoints();
					Frame.objects.Name:SetPoint(Points[1], Points[2], Points[3], Points[4], Points[5]);
					Frame.label = nil;
					Frame.objects.Label:Hide();
					Frame.objects.ResetToSetButton:ClearAllPoints();
					Frame.objects.ResetToSetButton:SetPoint("LEFT", Frame.objects.Name, "RIGHT", 0, 0);
					Frame.objects.TalentGroupSelect:Hide();
				end
			end

			return true;
		end
		function MT.UI.FrameSetEditByRule(Frame, rule)			--	LOCKED CHANGED HERE ONLY
			rule = not not rule;
			if Frame.rule == rule then
				return;
			end
			Frame.rule = rule;
			--	all icons processed in 'SetClass'
			--	all icons but tie 1 processed in 'ChangePoint'
			local TreeFrames = Frame.TreeFrames;
			if rule then
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TalentSet = TreeFrame.TalentSet;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						if TalentSet[TalentSeq] == 0 then
							local TalentDef = TreeTDB[TalentSeq];
							if TalentDef[1] ~= nil then
								MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[TalentDef[10]]);
							end
						end
					end
				end
			else
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];
					local TreeNodes = TreeFrame.TreeNodes;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						local TalentDef = TreeTDB[TalentSeq];
						if TalentDef[1] ~= nil and TalentDef[1] == 0 then
							if TalentDef[5] == nil then
								MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[TalentDef[10]]);
							end
						else
							break;
						end
					end
				end
				MT.UI.FrameResetTalents(Frame);
			end
		end
		function MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule)
			MT.UI.FrameReset(Frame, true, false, true);
			if not MT.UI.FrameSetClass(Frame, class) then
				Frame:Hide();
				return false;
			end
			if TalData ~= nil then
				MT.UI.FrameSetTalent(Frame, TalData, activeGroup);
			end
			MT.UI.FrameSetLevel(Frame, level);
			MT.UI.FrameSetEditByRule(Frame, rule);
			MT.UI.FrameSetName(Frame, name);

			return true;
		end
		function MT.UI.TreeNodeChangePoint(Node, numPoints)		--	POINTS CHANGED HERE ONLY
			if not Node.active then
				return -1;
			end
			local TreeFrame = Node.TreeFrame;
			local Frame = TreeFrame.Frame;
			if Frame.readOnly then
				return -1;
			end
			if numPoints == 0 then
				return 1;
			elseif numPoints > 0 then	--	caps to available points
				local remainingPoints = Frame.TotalAvailablePoints - Frame.TotalUsedPoints;
				if remainingPoints <= 0 then
					return 2;
				elseif remainingPoints < numPoints then
					numPoints = remainingPoints;
				end
			end

			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			local TalentSeq = Node.TalentSeq;
			local TalentDef = TreeTDB[TalentSeq];	--	没必要验证，因为无效定义没有按钮

			if (numPoints > 0 and TalentSet[TalentSeq] == TalentDef[4]) or (numPoints < 0 and TalentSet[TalentSeq] == 0) then	--	increased from max_rank OR decreased from min_rank
				return 2;
			end

			if Node.free_edit then
				local ret = 0;

				if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
					if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
						ret = 4;
					end
					numPoints = TalentDef[4] - TalentSet[TalentSeq];
					TalentSet[TalentSeq] = TalentDef[4];
					MT.UI.TreeNodeSetTextColorMaxRank(Node);
					MT.UI.TreeNodeLight(Node);
				elseif TalentSet[TalentSeq] + numPoints <= 0 then
					if TalentSet[TalentSeq] + numPoints < 0 then
						ret = 5;
					end
					numPoints = -TalentSet[TalentSeq];
					TalentSet[TalentSeq] = 0;
					MT.UI.TreeNodeUnlight(Node);
					MT.UI.TreeNodeSetTextColorUnavailable(Node);
				else
					TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
					MT.UI.TreeNodeSetTextColorAvailable(Node);
					if numPoints > 0 then
						MT.UI.TreeNodeLight(Node);
						MT.UI.TreeNodeSetTextColorAvailable(Node);
					end
				end
				Node.CurVal:SetText(TalentSet[TalentSeq]);

				return ret;
			else
				local tier = TalentDef[1];
				local depby = TalentDef[12];
				if numPoints < 0 then	--	whether it can be decreased
					if depby ~= nil then		--	depended on by other
						for i = 1, #depby do
							if TalentSet[depby[i]] > 0 then
								return 3;
							end
						end
					end
					if TalentSet.TopCheckedTier >= tier + 1 then
						local numPointsLowerTier = 0;
						for i = 0, tier do
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
						end
						for i = tier + 1, TalentSet.TopCheckedTier do
							numPoints = max(numPoints, i * CT.NUM_POINTS_NEXT_TIER - numPointsLowerTier);
							if numPoints == 0 then
								return 3;
							end
							numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[i];
						end
					end
					if CT.TOCVERSION >= 40000 then
						if TalentSet.Total >= DT.PointsNeeded4SecondaryTree then
							local secondary = false;
							local TreeFrames = Frame.TreeFrames;
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame and TFrame.TalentSet.Total > 0 then
									secondary = true;
									break;
								end
							end
							if secondary and TalentSet.Total + numPoints < DT.PointsNeeded4SecondaryTree then
								numPoints = DT.PointsNeeded4SecondaryTree - TalentSet.Total;
								if numPoints == 0 then
									return 3;
								end
							end
						end
					end
				end

				local ret = 0;

				if TalentSet[TalentSeq] + numPoints >= TalentDef[4] then
					if TalentSet[TalentSeq] + numPoints > TalentDef[4] then
						ret = 4;
					end
					numPoints = TalentDef[4] - TalentSet[TalentSeq];
					TalentSet[TalentSeq] = TalentDef[4];
					MT.UI.TreeNodeSetTextColorMaxRank(Node);
					MT.UI.TreeNodeLight(Node);
					if depby ~= nil then
						for i = 1, #depby do
							MT.UI.TreeNodeActivate_RecheckPoint(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
						end
						local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
						for i = 1, #Arrows do
							MT.UI.DependArrowSetTexCoord(Arrows[i], true);
						end
					end
				elseif TalentSet[TalentSeq] + numPoints <= 0 then
					if TalentSet[TalentSeq] + numPoints < 0 then
						ret = 5;
					end
					numPoints = -TalentSet[TalentSeq];
					TalentSet[TalentSeq] = 0;
					MT.UI.TreeNodeUnlight(Node);
					MT.UI.TreeNodeSetTextColorAvailable(Node);
				else
					TalentSet[TalentSeq] = TalentSet[TalentSeq] + numPoints;
					MT.UI.TreeNodeSetTextColorAvailable(Node);
					if numPoints > 0 then
						MT.UI.TreeNodeLight(Node);
					end
				end
				Node.CurVal:SetText(TalentSet[TalentSeq]);

				if numPoints < 0 and depby ~= nil then	--	deactive talents that depend on this
					for i = 1, #depby do
						MT.UI.TreeNodeDeactive(TreeFrame.TreeNodes[TreeTDB[depby[i]][10]]);
					end
					local Arrows = TreeFrame.NodeDependArrows[TalentSeq];
					for i = 1, #Arrows do
						MT.UI.DependArrowSetTexCoord(Arrows[i], false);
					end
				end

				if CT.TOCVERSION >= 40000 then
					if TalentSet.Total >= DT.PointsNeeded4SecondaryTree then
						if numPoints < 0 and TalentSet.Total + numPoints < DT.PointsNeeded4SecondaryTree then
							local TreeFrames = Frame.TreeFrames;
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame then
									MT.UI.TreeNodesDeactiveTier(TFrame.TreeNodes, 0);
								end
							end
						end
					elseif TalentSet.Total + numPoints >= DT.PointsNeeded4SecondaryTree then
							local TreeFrames = Frame.TreeFrames;
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame then
									MT.UI.TreeNodesActivateTier(TFrame.TreeNodes, 0);
								end
							end
					elseif TalentSet.Total > 0 then
						if TalentSet.Total + numPoints <= 0 then
							local TreeFrames = Frame.TreeFrames;
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame then
									MT.UI.TreeNodesActivateTier(TFrame.TreeNodes, 0);
								end
							end
						end
					elseif TalentSet.Total == 0 then
						if numPoints > 0 then
							local TreeFrames = Frame.TreeFrames;
							local isPrimary = true;
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame and TFrame.TalentSet.Total > 0 then
									isPrimary = false;
									break;
								end
							end
							if isPrimary then
							for TreeIndex = 1, 3 do
								local TFrame = TreeFrames[TreeIndex];
								if TFrame ~= TreeFrame then
									MT.UI.TreeNodesDeactiveTier(TFrame.TreeNodes, 0);
								end
							end
							end
						end
					end
				end
				--	CountByTier			index begin from 0
				--	TopAvailableTier	begin from 0
				--	TopCheckedTier		begin from 0
				TalentSet.Total = TalentSet.Total + numPoints;
				TreeFrame.TreePoints:SetText(TalentSet.Total);
				TalentSet.CountByTier[TalentDef[1]] = TalentSet.CountByTier[TalentDef[1]] + numPoints;

				local TopAvailableTier = min(floor(TalentSet.Total / CT.NUM_POINTS_NEXT_TIER), DT.MAX_NUM_TIER - 1);
				if TopAvailableTier > TalentSet.TopAvailableTier then
					MT.UI.TreeNodesActivateTier(TreeFrame.TreeNodes, TopAvailableTier);
					TalentSet.TopAvailableTier = TopAvailableTier;
				elseif TopAvailableTier < TalentSet.TopAvailableTier then
					MT.UI.TreeNodesDeactiveTier(TreeFrame.TreeNodes, TalentSet.TopAvailableTier);
					TalentSet.TopAvailableTier = TopAvailableTier;
				end

				if numPoints < 0 then
					if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
						MT.UI.FrameHasRemainingPoints(Frame);
					end
					Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
				else
					Frame.TotalUsedPoints = Frame.TotalUsedPoints + numPoints;
					if Frame.TotalAvailablePoints == Frame.TotalUsedPoints then
						MT.UI.FrameNoRemainingPoints(Frame);
					end
				end

				TalentSet.TopCheckedTier = 0;
				for i = TopAvailableTier, 0, -1 do
					if TalentSet.CountByTier[i] > 0 then
						TalentSet.TopCheckedTier = i;
						break;
					end
				end
				--	if TalentSet.CountByTier[TalentSet.TopAvailableTier] == 0 then
				--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier - 1;
				--	else
				--		TalentSet.TopCheckedTier = TalentSet.TopAvailableTier;
				--	end

				if Frame.name ~= nil then
					local TalentChanged = TreeFrame.TalentChanged;
					if TalentChanged[TalentSeq] ~= nil then
						TalentChanged[TalentSeq] = TalentChanged[TalentSeq] + numPoints;
						if TalentChanged[TalentSeq] == 0 then
							TalentChanged[TalentSeq] = nil;
						end
					else
						TalentChanged[TalentSeq] = numPoints;
					end
				end

				MT.UI.SpellListFrameUpdate(Frame.SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));

				local EditBox = Frame.EditBox;
				if EditBox.type == "save" and not EditBox.charChanged then
					EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
				end

				MT.UI.FrameUpdateLabelText(Frame);
				if GetMouseFocus() == Node then
					MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TalentSet[TalentSeq], TalentDef[4])
				end

				return ret;
			end
		end
		function MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq)
			local TalentSet = TreeFrame.TalentSet;
			local TreeTDB = TreeFrame.TreeTDB;
			if TalentSet[TalentSeq] > 0 then
				local depby = TreeTDB[TalentSeq][12];
				if depby then
					for index = 1, #depby do
						MT.UI.TreeFrameResetTalentDependTree(TreeFrame, depby[index]);
					end
				end
				MT.UI.TreeNodeChangePoint(TreeFrame.TreeNodes[TreeTDB[TalentSeq][10]], -TalentSet[TalentSeq]);
			end
		end
		function MT.UI.TreeFrameResetTalents(TreeFrame)
			local TreeTDB = TreeFrame.TreeTDB;
			for TalentSeq = #TreeTDB, 1, -1 do
				MT.UI.TreeFrameResetTalentDependTree(TreeFrame, TalentSeq);
			end
		end
		function MT.UI.FrameResetTalents(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				MT.UI.TreeFrameResetTalents(TreeFrame);
			end
		end
		function MT.UI.FrameReset(Frame, ResetData, ResetName, ResetSetting)
			if ResetData ~= false then
				local TreeFrames = Frame.TreeFrames;
				for TreeIndex = 1, 3 do
					local TreeFrame = TreeFrames[TreeIndex];

					local TreeNodes = TreeFrame.TreeNodes;
					for i = 1, DT.MAX_NUM_TALENTS do
						TreeNodes[i]:Hide();
						TreeNodes[i].TalentSeq = nil;
						MT.UI.TreeNodeDeactive(TreeNodes[i]);
					end

					local TalentSet = TreeFrame.TalentSet;
					for i = 1, DT.MAX_NUM_TALENTS do
						TalentSet[i] = 0;
					end
					for Tier = 0, DT.MAX_NUM_TIER do
						TalentSet.CountByTier[Tier] = 0;
					end
					TalentSet.Total = 0;
					TalentSet.TopAvailableTier = 0;
					TalentSet.TopCheckedTier = 0;

					for i = 1, DT.MAX_NUM_TALENTS do
						wipe(TreeFrame.NodeDependArrows[i]);
					end

					local DependArrows = TreeFrame.DependArrows;
					for i = 1, #DependArrows do
						DependArrows[i]:Hide();
						DependArrows[i]:ClearAllPoints();
						DependArrows[i].Branch1:Hide();
						DependArrows[i].Branch1:ClearAllPoints();
						DependArrows[i].Corner:Hide();
						DependArrows[i].Branch2:Hide();
						DependArrows[i].Branch2:ClearAllPoints();
					end
					DependArrows.used = 0;

					TreeFrame.TreePoints:SetText("0");
				end

				MT.UI.FrameSetClass(Frame, nil);
				MT.UI.FrameSetLevel(Frame, nil);
				MT.UI.FrameSetTalent(Frame, nil);
			end
			if ResetName ~= false then
				MT.UI.FrameSetName(Frame, nil);
			end
			if ResetSetting ~= false then
				MT.UI.FrameSetEditByRule(Frame, false);
			end

			MT.UI.FrameUpdateLabelText(Frame);

			Frame.initialized = false;
		end
		function MT.UI.FrameNoRemainingPoints(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TreeNodes = TreeFrame.TreeNodes;
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil and TalentDef[4] ~= TalentSet[TalentSeq] then
						MT.UI.TreeNodeSetTextColorUnavailable(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
					end
				end
			end
		end
		function MT.UI.FrameHasRemainingPoints(Frame)
			local TreeFrames = Frame.TreeFrames;
			for TreeIndex = 1, 3 do
				local TreeFrame = TreeFrames[TreeIndex];
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TreeNodes = TreeFrame.TreeNodes;
				for TalentSeq = 1, #TreeTDB do
					local TalentDef = TreeTDB[TalentSeq];
					if TalentDef[1] ~= nil then
						if TalentDef[4] == TalentSet[TalentSeq] then
							--	MT.UI.TreeNodeSetTextColorMaxRank(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
						elseif TalentSet[TalentSeq] > 0 or TalentDef[1] == 0 then
							MT.UI.TreeNodeSetTextColorAvailable(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
						else
							local numPointsLowerTier = 0;
							for j = 0, TalentDef[1] - 1 do
								numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[j];
							end
							if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
								MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[MT.GetTreeNodeIndex(TalentDef)]);
							end
						end
					end
				end
			end
		end
		function MT.UI.FrameUpdateLabelText(Frame)
			local objects = Frame.objects;
			if Frame.name ~= nil then
				local should_show = false;
				for TreeIndex = 1, 3 do
					local TreeFrame = Frame.TreeFrames[TreeIndex];
					local TalentChanged = TreeFrame.TalentChanged;
					local TreeTDB = TreeFrame.TreeTDB;
					for TalentSeq = 1, #TreeTDB do
						if TalentChanged[TalentSeq] then
							should_show = true;
							break;
						end
					end
				end
				if should_show then
					objects.ResetToSetButton:Show();
					if Frame.label ~= nil then
						objects.Label:SetText(Frame.label .. l10n.LabelPointsChanged);
					else
						objects.Name:SetText(Frame.name .. l10n.LabelPointsChanged);
					end
				else
					objects.ResetToSetButton:Hide();
					if Frame.label ~= nil then
						objects.Label:SetText(Frame.label);
					else
						objects.Name:SetText(Frame.name);
					end
				end
			end
			MT.UI.FrameUpdateFooterText(Frame);
		end
		function MT.UI.FrameUpdateFooterText(Frame)
			local objects = Frame.objects;
			objects.PointsUsed:SetText(Frame.TotalUsedPoints);
			objects.PointsToLevel:SetText(MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));
			objects.PointsRemaining:SetText(MT.GetLevelAvailablePoints(Frame.class, Frame.level) - Frame.TotalUsedPoints);
		end
		function MT.UI.FrameSetStyle(Frame, style)
			local TreeFrames = Frame.TreeFrames;
			if Frame.style ~= style then
				Frame.style = style;
				if style == 1 then
					TreeFrames[1]:Show();
					TreeFrames[2]:Show();
					TreeFrames[3]:Show();
					TreeFrames[2]:ClearAllPoints();
					TreeFrames[2]:SetPoint("CENTER", Frame, "CENTER", 0, (TUISTYLE.FrameFooterYSize - TUISTYLE.FrameHeaderYSize) * 0.5);
					TreeFrames[1]:ClearAllPoints();
					TreeFrames[1]:SetPoint("TOPRIGHT", TreeFrames[2], "TOPLEFT");
					TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMLEFT");
					TreeFrames[3]:ClearAllPoints();
					TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPRIGHT");
					TreeFrames[3]:SetPoint("BOTTOMLEFT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[1].TreeLabel:Show();
					TreeFrames[2].TreeLabel:Show();
					TreeFrames[3].TreeLabel:Show();
					TreeFrames[1].TreeLabelBackground:Show();
					TreeFrames[2].TreeLabelBackground:Show();
					TreeFrames[3].TreeLabelBackground:Show();
					Frame.TreeButtonsBar:Hide();
					if Frame.SetResizeBounds ~= nil then
						Frame:SetResizeBounds(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1, 9999, 9999);
					else
						Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1);
					end

					local scale = (Frame:GetHeight() - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize);
					Frame.TreeFrameScale = scale;
					Frame:SetWidth(scale * TUISTYLE.TreeFrameXSizeTriple + TUISTYLE.TreeFrameXToBorder * 2);

					_TextureFunc.SetNormalTexture(Frame.objects.ExpandButton, TTEXTURESET.SHRINK, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(Frame.objects.ExpandButton, TTEXTURESET.SHRINK, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(Frame.objects.ExpandButton, TTEXTURESET.SHRINK, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				elseif style == 2 then
					TreeFrames[1]:Hide();
					TreeFrames[2]:Hide();
					TreeFrames[3]:Hide();
					TreeFrames[Frame.CurTreeIndex]:Show();
					TreeFrames[2]:ClearAllPoints();
					TreeFrames[2]:SetPoint("CENTER", Frame, "CENTER", 0, (TUISTYLE.FrameFooterYSize - TUISTYLE.FrameHeaderYSize) * 0.5);
					TreeFrames[1]:ClearAllPoints();
					TreeFrames[1]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
					TreeFrames[1]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[3]:ClearAllPoints();
					TreeFrames[3]:SetPoint("TOPLEFT", TreeFrames[2], "TOPLEFT");
					TreeFrames[3]:SetPoint("BOTTOMRIGHT", TreeFrames[2], "BOTTOMRIGHT");
					TreeFrames[1].TreeLabel:Hide();
					TreeFrames[2].TreeLabel:Hide();
					TreeFrames[3].TreeLabel:Hide();
					TreeFrames[1].TreeLabelBackground:Hide();
					TreeFrames[2].TreeLabelBackground:Hide();
					TreeFrames[3].TreeLabelBackground:Hide();
					Frame.TreeButtonsBar:Show();
					if Frame.SetResizeBounds ~= nil then
						Frame:SetResizeBounds(TUISTYLE.FrameXSizeMin_Style2, TUISTYLE.FrameYSizeMin_Style2, 9999, 9999);
					else
						Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style2, TUISTYLE.FrameYSizeMin_Style2);
					end

					local scale = (Frame:GetHeight() - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize);
					Frame.TreeFrameScale = scale;
					Frame:SetWidth(scale * TUISTYLE.TreeFrameXSizeSingle + TUISTYLE.TreeFrameXToBorder * 2);

					_TextureFunc.SetNormalTexture(Frame.objects.ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(Frame.objects.ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(Frame.objects.ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				else
					return;
				end
				MT.UI.TreeUpdate(Frame, Frame.CurTreeIndex, true);
				local PScale = UIParent:GetEffectiveScale();
				local FScale = Frame:GetEffectiveScale();
				if Frame:GetRight() * FScale <= UIParent:GetLeft() * PScale + 16 then
					Frame:ClearAllPoints();
					Frame:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMLEFT", Frame:GetBottom() * FScale / PScale, 16 * FScale / PScale);
				elseif Frame:GetLeft() * FScale >= UIParent:GetRight() * PScale - 16 then
					Frame:ClearAllPoints();
					Frame:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMRIGHT", Frame:GetBottom() * FScale / PScale, -16 * FScale / PScale);
				end
			end
		end
		function MT.UI.TreeNodeLight(Node)
			Node:GetNormalTexture():SetVertexColor(TTEXTURESET.ICON_LIGHT_COLOR[1], TTEXTURESET.ICON_LIGHT_COLOR[2], TTEXTURESET.ICON_LIGHT_COLOR[3], TTEXTURESET.ICON_LIGHT_COLOR[4]);
			Node:GetPushedTexture():SetVertexColor(TTEXTURESET.ICON_LIGHT_COLOR[1], TTEXTURESET.ICON_LIGHT_COLOR[2], TTEXTURESET.ICON_LIGHT_COLOR[3], TTEXTURESET.ICON_LIGHT_COLOR[4]);
		end
		function MT.UI.TreeNodeUnlight(Node)
			Node:GetNormalTexture():SetVertexColor(TTEXTURESET.ICON_UNLIGHT_COLOR[1], TTEXTURESET.ICON_UNLIGHT_COLOR[2], TTEXTURESET.ICON_UNLIGHT_COLOR[3], TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
			Node:GetPushedTexture():SetVertexColor(TTEXTURESET.ICON_UNLIGHT_COLOR[1], TTEXTURESET.ICON_UNLIGHT_COLOR[2], TTEXTURESET.ICON_UNLIGHT_COLOR[3], TTEXTURESET.ICON_UNLIGHT_COLOR[4]);
		end
		function MT.UI.TreeNodeSetTextColorAvailable(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextAvailableColor[1], TUISTYLE.IconTextAvailableColor[2], TUISTYLE.IconTextAvailableColor[3], TUISTYLE.IconTextAvailableColor[4]);
		end
		function MT.UI.TreeNodeSetTextColorUnavailable(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextDisabledColor[1], TUISTYLE.IconTextDisabledColor[2], TUISTYLE.IconTextDisabledColor[3], TUISTYLE.IconTextDisabledColor[4]);
		end
		function MT.UI.TreeNodeSetTextColorMaxRank(Node)
			Node.Split:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
			Node.MaxVal:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
			Node.CurVal:SetTextColor(TUISTYLE.IconTextMaxRankColor[1], TUISTYLE.IconTextMaxRankColor[2], TUISTYLE.IconTextMaxRankColor[3], TUISTYLE.IconTextMaxRankColor[4]);
		end
		function MT.UI.TreeNodeActivate(Node)	--	Light Node when points increased from 0 instead of activated
			Node.active = true;
			MT.UI.TreeNodeSetTextColorAvailable(Node);
		end
		function MT.UI.TreeNodeActivateMaxRank(Node)	--	Light Node when points increased from 0 instead of activated
			Node.active = true;
			MT.UI.TreeNodeSetTextColorMaxRank(Node);
		end
		function MT.UI.TreeNodeDeactive(Node)	--	Unlight Node certainly when deactived
			Node.active = false;
			MT.UI.TreeNodeSetTextColorUnavailable(Node);
			MT.UI.TreeNodeUnlight(Node);
		end
		function MT.UI.TreeNodeActivate_RecheckReq(Node)
			local TalentSeq = Node.TalentSeq;
			if TalentSeq ~= nil then
				local TreeFrame = Node.TreeFrame;
				local TalentSet = TreeFrame.TalentSet;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentDef = TreeTDB[TalentSeq];
				local DepTSeq = TalentDef[11];
				if DepTSeq == nil or TreeFrame.TalentSet[DepTSeq] == TreeTDB[DepTSeq][4] then
					if TalentSet[TalentSeq] >= TreeTDB[TalentSeq][4] then
						MT.UI.TreeNodeActivateMaxRank(Node)
					else
						MT.UI.TreeNodeActivate(Node);
					end
				end
			end
		end
		function MT.UI.TreeNodeActivate_RecheckPoint(Node)
			local TalentSeq = Node.TalentSeq;
			if TalentSeq > 0 then
				local TreeFrame = Node.TreeFrame;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TalentDef = TreeTDB[TalentSeq];
				if TalentDef[1] == 0 then
					MT.UI.TreeNodeActivate(Node);
				end
				local numPointsLowerTier = 0;
				for Tier = 0, TalentDef[1] - 1 do
					numPointsLowerTier = numPointsLowerTier + TalentSet.CountByTier[Tier];
				end
				if numPointsLowerTier >= TalentDef[1] * CT.NUM_POINTS_NEXT_TIER then
					MT.UI.TreeNodeActivate(Node);
				end
			end
		end
		function MT.UI.TreeNodesActivateTier(TreeNodes, tier)
			for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
				MT.UI.TreeNodeActivate_RecheckReq(TreeNodes[i]);
			end
		end
		function MT.UI.TreeNodesDeactiveTier(TreeNodes, tier)
			for i = tier * DT.MAX_NUM_COL + 1, (tier + 1) * DT.MAX_NUM_COL do
				MT.UI.TreeNodeDeactive(TreeNodes[i]);
			end
		end
		function MT.UI.DependArrowSetTexCoord(Arrow, enabled)
			local Branch1, Corner, Branch2, coordFamily = Arrow.Branch1, Arrow.Corner, Arrow.Branch2, Arrow.coordFamily;
			if coordFamily == 11 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[4][1], TTEXTURESET.ARROW_COORD[4][2], TTEXTURESET.ARROW_COORD[4][3], TTEXTURESET.ARROW_COORD[4][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[3][1], TTEXTURESET.ARROW_COORD[3][2], TTEXTURESET.ARROW_COORD[3][3], TTEXTURESET.ARROW_COORD[3][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 12 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[4][2], TTEXTURESET.ARROW_COORD[4][1], TTEXTURESET.ARROW_COORD[4][3], TTEXTURESET.ARROW_COORD[4][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[3][2], TTEXTURESET.ARROW_COORD[3][1], TTEXTURESET.ARROW_COORD[3][3], TTEXTURESET.ARROW_COORD[3][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 21 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 22 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 31 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 32 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][3], TTEXTURESET.ARROW_COORD[2][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 41 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][4], TTEXTURESET.ARROW_COORD[2][3]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			elseif coordFamily == 42 then
				if enabled then
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[2][1], TTEXTURESET.ARROW_COORD[2][2], TTEXTURESET.ARROW_COORD[2][4], TTEXTURESET.ARROW_COORD[2][3]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[2][1], TTEXTURESET.BRANCH_COORD[2][2], TTEXTURESET.BRANCH_COORD[2][3], TTEXTURESET.BRANCH_COORD[2][4]);
				else
					Arrow:SetTexCoord(TTEXTURESET.ARROW_COORD[1][1], TTEXTURESET.ARROW_COORD[1][2], TTEXTURESET.ARROW_COORD[1][3], TTEXTURESET.ARROW_COORD[1][4]);
					Branch1:SetTexCoord(TTEXTURESET.BRANCH_COORD[1][1], TTEXTURESET.BRANCH_COORD[1][2], TTEXTURESET.BRANCH_COORD[1][3], TTEXTURESET.BRANCH_COORD[1][4]);
				end
			end
			if coordFamily == 31 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][3], TTEXTURESET.BRANCH_COORD[6][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][3], TTEXTURESET.BRANCH_COORD[5][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 32 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][3], TTEXTURESET.BRANCH_COORD[6][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][3], TTEXTURESET.BRANCH_COORD[5][4]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 41 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][4], TTEXTURESET.BRANCH_COORD[6][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][4], TTEXTURESET.BRANCH_COORD[5][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			elseif coordFamily == 42 then
				if enabled then
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[6][2], TTEXTURESET.BRANCH_COORD[6][1], TTEXTURESET.BRANCH_COORD[6][4], TTEXTURESET.BRANCH_COORD[6][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[4][1], TTEXTURESET.BRANCH_COORD[4][2], TTEXTURESET.BRANCH_COORD[4][3], TTEXTURESET.BRANCH_COORD[4][4]);
				else
					Corner:SetTexCoord(TTEXTURESET.BRANCH_COORD[5][2], TTEXTURESET.BRANCH_COORD[5][1], TTEXTURESET.BRANCH_COORD[5][4], TTEXTURESET.BRANCH_COORD[5][3]);
					Branch2:SetTexCoord(TTEXTURESET.BRANCH_COORD[3][1], TTEXTURESET.BRANCH_COORD[3][2], TTEXTURESET.BRANCH_COORD[3][3], TTEXTURESET.BRANCH_COORD[3][4]);
				end
			end
		end
		function MT.UI.DependArrowSet(Arrow, verticalDist, horizontalDist, enabled, Node, DepNode)
			local Branch1, Corner, Branch2 = Arrow.Branch1, Arrow.Corner, Arrow.Branch2;
			local coordFamily = nil;
			if verticalDist == 0 then		--horizontal
				if horizontalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "LEFT", -TUISTYLE.TalentDepArrowXSize / 6, 0);
					Branch1:SetSize(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist, TUISTYLE.TalentDepBranchXSize);
					Branch1:SetPoint("LEFT", DepNode, "RIGHT");
					Branch1:SetPoint("RIGHT", Arrow, "CENTER");
					coordFamily = 11;
				elseif horizontalDist < 0 then
					horizontalDist = -horizontalDist;
					Arrow:SetPoint("CENTER", Node, "RIGHT", TUISTYLE.TalentDepArrowXSize / 6, 0);
					Branch1:SetSize(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist, TUISTYLE.TalentDepBranchXSize);
					Branch1:SetPoint("RIGHT", DepNode, "LEFT");
					Branch1:SetPoint("LEFT", Arrow, "CENTER");
					coordFamily = 12;
				end
				Corner:Hide();
				Branch2:Hide();
			elseif horizontalDist == 0 then	--vertical
				if verticalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "TOP", 0, TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist);
					Branch1:SetPoint("TOP", DepNode, "BOTTOM");
					Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
					coordFamily = 21;
				elseif verticalDist < 0 then
					verticalDist = -verticalDist;
					Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist);
					Branch1:SetPoint("BOTTOM", DepNode, "TOP");
					Branch1:SetPoint("TOP", Arrow, "CENTER");
					coordFamily = 22;
				end
				Corner:Hide();
				Branch2:Hide();
			else	--TODO
				if verticalDist > 0 then
					Arrow:SetPoint("CENTER", Node, "TOP", 0, TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetHeight(TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist + TUISTYLE.TreeNodeSize * 0.5 - TUISTYLE.TalentDepBranchXSize);
					--Branch1:SetPoint("TOP", DepNode, "CENTER");
					Branch1:SetPoint("BOTTOM", Arrow, "CENTER");
					Corner:SetPoint("BOTTOM", Branch1, "TOP");
					-- Branch2:SetWidth(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist + TUISTYLE.TreeNodeSize * 0.5);
					if horizontalDist > 0 then
						Branch2:SetPoint("LEFT", DepNode, "RIGHT");
						Branch2:SetPoint("BOTTOMRIGHT", Branch1, "TOPLEFT");
						coordFamily = 31;
					else
						Branch2:SetPoint("RIGHT", DepNode, "LEFT");
						Branch2:SetPoint("BOTTOMLEFT", Branch1, "TOPRIGHT");
						coordFamily = 32;
					end
				else
					verticalDist = -verticalDist;
					Arrow:SetPoint("CENTER", Node, "BOTTOM", 0, -TUISTYLE.TalentDepArrowYSize / 6);
					Branch1:SetHeight(TUISTYLE.TreeNodeSize * (verticalDist - 1) + TUISTYLE.TreeNodeYGap * verticalDist + TUISTYLE.TreeNodeSize * 0.5 - TUISTYLE.TalentDepBranchXSize);
					--Branch1:SetPoint("BOTTOM", DepNode, "CENTER");
					Branch1:SetPoint("TOP", Arrow, "CENTER");
					Corner:SetPoint("BOTTOM", Branch1, "TOP");
					-- Branch2:SetWidth(TUISTYLE.TreeNodeSize * (horizontalDist - 1) + TUISTYLE.TreeNodeXGap * horizontalDist + TUISTYLE.TreeNodeSize * 0.5);
					if horizontalDist > 0 then
						Branch2:SetPoint("LEFT", DepNode, "RIGHT");
						Branch2:SetPoint("TOPRIGHT", Branch1, "BOTTOMLEFT");
						coordFamily = 41;
					else
						Branch2:SetPoint("RIGHT", DepNode, "LEFT");
						Branch2:SetPoint("TOPLEFT", Branch1, "BOTTOMRIGHT");
						coordFamily = 42;
					end
				end
				Branch2:Show();
				Corner:Show();
			end
			Arrow:Show();
			Branch1:Show();
			Arrow.coordFamily = coordFamily;
			MT.UI.DependArrowSetTexCoord(Arrow, enabled);
		end
		function MT.UI.DependArrowCreate(TreeFrame)
			local Arrow = TreeFrame:CreateTexture(nil, "OVERLAY");
			Arrow:SetTexture(TTEXTURESET.ARROW);
			Arrow:SetSize(TUISTYLE.TalentDepArrowXSize, TUISTYLE.TalentDepArrowYSize);

			local Branch1 = TreeFrame:CreateTexture(nil, "ARTWORK");
			Branch1:SetWidth(TUISTYLE.TalentDepBranchXSize);
			Branch1:SetTexture(TTEXTURESET.BRANCH);

			local Corner = TreeFrame:CreateTexture(nil, "ARTWORK");
			Corner:SetSize(TUISTYLE.TalentDepBranchXSize, TUISTYLE.TalentDepBranchXSize);
			Corner:SetTexture(TTEXTURESET.BRANCH);
			Corner:Hide();

			local Branch2 = TreeFrame:CreateTexture(nil, "ARTWORK");
			Branch2:SetHeight(TUISTYLE.TalentDepBranchXSize);
			Branch2:SetTexture(TTEXTURESET.BRANCH);
			Branch2:Hide();

			Arrow.Branch1 = Branch1;
			Arrow.Corner = Corner;
			Arrow.Branch2 = Branch2;

			return Arrow;
		end
		function MT.UI.DependArrowGet(TreeFrame)
			local DependArrows = TreeFrame.DependArrows;
			DependArrows.used = DependArrows.used + 1;
			if DependArrows.used > #DependArrows then
				DependArrows[DependArrows.used] = MT.UI.DependArrowCreate(TreeFrame);
			end
			return DependArrows[DependArrows.used];
		end
		local function TooltipFrame_OnUpdate_Tooltip1(TooltipFrame, elasped)
			TooltipFrame.delay = TooltipFrame.delay - elasped;
			if TooltipFrame.delay > 0 then
				return;
			end
			TooltipFrame:SetScript("OnUpdate", nil);
			local Tooltip1 = TooltipFrame.Tooltip1;
			if Tooltip1:IsShown() then
				if TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip ~= nil then
					TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip1, Tooltip1.SpellID);
				end
				--Tooltip1:Show();
				TooltipFrame:SetWidth(Tooltip1:GetWidth());
				TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterRight:GetHeight());
				TooltipFrame:SetAlpha(1.0);
				Tooltip1:SetAlpha(1.0);
			else
				TooltipFrame:Hide();
			end
		end
		local function TooltipFrame_OnUpdate_Tooltip12(TooltipFrame, elasped)
			TooltipFrame.delay = TooltipFrame.delay - elasped;
			if TooltipFrame.delay > 0 then
				return;
			end
			TooltipFrame:SetScript("OnUpdate", nil);
			local Tooltip1 = TooltipFrame.Tooltip1;
			local Tooltip2 = TooltipFrame.Tooltip2;
			if Tooltip1:IsShown() or Tooltip2:IsShown() then
				if TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip ~= nil then
					TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip1, Tooltip1.SpellID);
					TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip(Tooltip2, Tooltip2.SpellID);
				end
				--Tooltip1:Show();
				--Tooltip2:Show();
				TooltipFrame:SetWidth(max(Tooltip1:GetWidth(), Tooltip2:GetWidth()));
				TooltipFrame:SetHeight(TooltipFrame.Tooltip1LabelLeft:GetHeight() + Tooltip1:GetHeight() + TooltipFrame.Tooltip1FooterLeft:GetHeight() + TooltipFrame.Tooltip2LabelLeft:GetHeight() + Tooltip2:GetHeight() + TooltipFrame.Tooltip2FooterLeft:GetHeight() - 8);
				TooltipFrame:SetAlpha(1.0);
				Tooltip1:SetAlpha(1.0);
				Tooltip2:SetAlpha(1.0);
			else
				TooltipFrame:Hide();
			end
		end
		function MT.UI.TooltipFrameSetTalent(TooltipFrame, Node, SpecID, reqPts, pts, spellTable, CurRank, MaxRank)
			local Tooltip1LabelLeft = TooltipFrame.Tooltip1LabelLeft;
			local Tooltip1LabelRight = TooltipFrame.Tooltip1LabelRight;
			local Tooltip1 = TooltipFrame.Tooltip1;

			local Tooltip1FooterLeft = TooltipFrame.Tooltip1FooterLeft;
			local Tooltip1FooterRight = TooltipFrame.Tooltip1FooterRight;

			local Tooltip2LabelLeft = TooltipFrame.Tooltip2LabelLeft;
			local Tooltip2LabelRight = TooltipFrame.Tooltip2LabelRight;
			local Tooltip2 = TooltipFrame.Tooltip2;

			local Tooltip2FooterLeft = TooltipFrame.Tooltip2FooterLeft;
			local Tooltip2FooterRight = TooltipFrame.Tooltip2FooterRight;

			TooltipFrame.OwnerFrame = Node.TreeFrame.Frame;
			TooltipFrame:ClearAllPoints();
			TooltipFrame:SetPoint("BOTTOMRIGHT", Node, "TOPLEFT", -4, 4);
			TooltipFrame:Show();
			TooltipFrame:SetAlpha(0.0);
			if CurRank == 0 then
				Tooltip1LabelLeft:Show();
				Tooltip1LabelLeft:SetText(l10n.NextRank);
				if Node.active then
					Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankColor[1], TUISTYLE.IconToolTipNextRankColor[2], TUISTYLE.IconToolTipNextRankColor[3], TUISTYLE.IconToolTipNextRankColor[4]);
					Tooltip1LabelRight:Hide();
				else
					Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
					if reqPts > pts then
						Tooltip1LabelRight:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
						Tooltip1LabelRight:Show();
						Tooltip1LabelRight:SetText(format(l10n.ReqPoints, pts, reqPts, l10n.SPEC[SpecID]));
					end
				end
				--Tooltip1:Show();
				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[1]);
				Tooltip1:SetAlpha(0.0);
				Tooltip1.SpellID = spellTable[1];
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip1FooterRight:SetText(tostring(spellTable[1]));

				Tooltip2LabelLeft:Hide();
				Tooltip2LabelRight:Hide();
				Tooltip2:Hide();
				Tooltip2FooterLeft:Hide();
				Tooltip2FooterRight:Hide();

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
			elseif CurRank == MaxRank then
				Tooltip1LabelLeft:Show();
				Tooltip1LabelLeft:SetText(l10n.MaxRank);
				Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipMaxRankColor[1], TUISTYLE.IconToolTipMaxRankColor[2], TUISTYLE.IconToolTipMaxRankColor[3], TUISTYLE.IconToolTipMaxRankColor[4]);
				Tooltip1LabelRight:Show();
				Tooltip1LabelRight:SetText(CurRank .. "/" .. MaxRank);
				Tooltip1LabelRight:SetTextColor(TUISTYLE.IconToolTipMaxRankColor[1], TUISTYLE.IconToolTipMaxRankColor[2], TUISTYLE.IconToolTipMaxRankColor[3], TUISTYLE.IconToolTipMaxRankColor[4]);
				--Tooltip1:Show();
				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[MaxRank]);
				Tooltip1:SetAlpha(0.0);
				Tooltip1.SpellID = spellTable[MaxRank];
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip1FooterRight:SetText(tostring(spellTable[MaxRank]));

				Tooltip2LabelLeft:Hide();
				Tooltip2LabelRight:Hide();
				Tooltip2:Hide();
				Tooltip2FooterLeft:Hide();
				Tooltip2FooterRight:Hide();

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip1);
			else
				Tooltip1LabelLeft:Show();
				Tooltip1LabelLeft:SetText(l10n.CurRank);
				Tooltip1LabelLeft:SetTextColor(TUISTYLE.IconToolTipCurRankColor[1], TUISTYLE.IconToolTipCurRankColor[2], TUISTYLE.IconToolTipCurRankColor[3], TUISTYLE.IconToolTipCurRankColor[4]);
				Tooltip1LabelRight:Show();
				Tooltip1LabelRight:SetText(CurRank .. "/" .. MaxRank);
				Tooltip1LabelRight:SetTextColor(TUISTYLE.IconToolTipCurRankColor[1], TUISTYLE.IconToolTipCurRankColor[2], TUISTYLE.IconToolTipCurRankColor[3], TUISTYLE.IconToolTipCurRankColor[4]);
				--Tooltip1:Show();
				Tooltip1:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip1:SetSpellByID(spellTable[CurRank]);
				Tooltip1:SetAlpha(0.0);
				Tooltip1.SpellID = spellTable[CurRank];
				Tooltip1FooterLeft:Show();
				Tooltip1FooterRight:Show();
				Tooltip1FooterRight:SetText(tostring(spellTable[CurRank]));

				Tooltip2LabelLeft:Show();
				Tooltip2LabelLeft:SetText(l10n.NextRank);
				if Node.active then
					if CurRank + 1 == MaxRank then
						Tooltip2LabelLeft:SetTextColor(TUISTYLE.IconToolTipMaxRankColor[1], TUISTYLE.IconToolTipMaxRankColor[2], TUISTYLE.IconToolTipMaxRankColor[3], TUISTYLE.IconToolTipMaxRankColor[4]);
					else
						Tooltip2LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankColor[1], TUISTYLE.IconToolTipNextRankColor[2], TUISTYLE.IconToolTipNextRankColor[3], TUISTYLE.IconToolTipNextRankColor[4]);
					end
				else
					Tooltip2LabelLeft:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
				end
				Tooltip2LabelRight:Show();
				Tooltip2LabelRight:SetText((CurRank + 1) .. "/" .. MaxRank);
				if Node.active then
					if CurRank + 1 == MaxRank then
						Tooltip2LabelRight:SetTextColor(TUISTYLE.IconToolTipMaxRankColor[1], TUISTYLE.IconToolTipMaxRankColor[2], TUISTYLE.IconToolTipMaxRankColor[3], TUISTYLE.IconToolTipMaxRankColor[4]);
					else
						Tooltip2LabelRight:SetTextColor(TUISTYLE.IconToolTipNextRankColor[1], TUISTYLE.IconToolTipNextRankColor[2], TUISTYLE.IconToolTipNextRankColor[3], TUISTYLE.IconToolTipNextRankColor[4]);
					end
				else
					Tooltip2LabelRight:SetTextColor(TUISTYLE.IconToolTipNextRankDisabledColor[1], TUISTYLE.IconToolTipNextRankDisabledColor[2], TUISTYLE.IconToolTipNextRankDisabledColor[3], TUISTYLE.IconToolTipNextRankDisabledColor[4]);
				end
				--Tooltip2:Show();
				Tooltip2:SetOwner(TooltipFrame, "ANCHOR_NONE");
				Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
				Tooltip2:SetSpellByID(spellTable[CurRank + 1]);
				Tooltip2:SetAlpha(0.0);
				Tooltip2.SpellID = spellTable[CurRank + 1];
				Tooltip2FooterLeft:Show();
				Tooltip2FooterRight:Show();
				Tooltip2FooterRight:SetText(tostring(spellTable[CurRank + 1]));

				TooltipFrame.delay = CT.TOOLTIP_UPDATE_DELAY;
				TooltipFrame:SetScript("OnUpdate", TooltipFrame_OnUpdate_Tooltip12);
			end
		end
		function MT.UI.SetTooltip(Node)
			local TreeFrame = Node.TreeFrame;
			local TalentSeq = Node.TalentSeq;
			local TalentDef = TreeFrame.TreeTDB[TalentSeq];
			if TalentDef ~= nil then
				MT.UI.TooltipFrameSetTalent(VT.TooltipFrame, Node, TreeFrame.SpecID, TalentDef[1] * 5, TreeFrame.TalentSet.Total, TalentDef[8], TreeFrame.TalentSet[TalentSeq], TalentDef[4]);
			else
				MT.UI.HideTooltip(Node);
			end
		end
		function MT.UI.HideTooltip(Node)
			local TooltipFrame = VT.TooltipFrame;
			TooltipFrame:Hide();
			TooltipFrame.Tooltip1:Hide();
			TooltipFrame.Tooltip2:Hide();
		end
		function MT.UI.SpellListFrameUpdate(SpellListFrame, class, level)
			local list = SpellListFrame.list;
			wipe(list);
			local pos = 0;
			list.class = class;
			local showAll = SpellListFrame.ShowAllSpell:GetChecked();
			local search = SpellListFrame.SearchEdit:GetText();
			if search == "" then search = nil; end
			local TreeFrames = SpellListFrame.Frame.TreeFrames;
			local ClassSDB = DT.SpellDB[class];
			if ClassSDB ~= nil then
				for index = 1, #ClassSDB do
					local SpellDef = ClassSDB[index];
					if not SpellDef.talent or TreeFrames[SpellDef.requireSpecIndex].TalentSet[SpellDef.requireIndex] > 0 then
						local NumLevel = #SpellDef;
						for Level = 1, NumLevel do
							local v = SpellDef[Level];
							if search == nil or strmatch(GetSpellInfo(v[2]), search) or strmatch(tostring(v[2]), search) then
								if v[1] <= level then
									if showAll then
										pos = pos + 1;
										list[pos] = v;
									elseif Level == NumLevel then
										pos = pos + 1;
										list[pos] = v;
									end
								else
									if not showAll then
										if Level > 1 then
											pos = pos + 1;
											list[pos] = SpellDef[Level - 1];
										end
									end
									break;
								end
							end
						end
					end
				end
				if not SpellListFrame.ScrollList:SetNumValue(#list) then
					SpellListFrame.ScrollList:Update();
				end
			end
		end
		function MT.UI.SpellListFrameToggle(Frame)
			local SpellListFrame, SpellListFrameContainer = Frame.SpellListFrame, Frame.SpellListFrameContainer;
			local SideAnchorTop = Frame.SideAnchorTop;
			local SideAnchorBottom = Frame.SideAnchorBottom;
			if SpellListFrameContainer:IsShown() then
				SpellListFrameContainer:Hide();
				SideAnchorTop:ClearAllPoints();
				SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				SideAnchorBottom:ClearAllPoints();
				SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
			else
				SpellListFrameContainer:Show();
				MT.UI.SpellListFrameUpdate(SpellListFrame, Frame.class, MT.GetPointsReqLevel(Frame.class, Frame.TotalUsedPoints));
				SideAnchorTop:ClearAllPoints();
				SideAnchorTop:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
				SideAnchorBottom:ClearAllPoints();
				SideAnchorBottom:SetPoint("TOPLEFT", SpellListFrameContainer, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", SpellListFrameContainer, "BOTTOMRIGHT", 2, 0);
			end
		end
		function MT.UI.EquipmentFrameContainerResize(EquipmentFrameContainer)
			local TreeFrameScale = EquipmentFrameContainer.Frame.TreeFrameScale;
			local EquipmentContainer = EquipmentFrameContainer.EquipmentContainer;
			local EquipmentNodes = EquipmentContainer.EquipmentNodes;
			local s = TUISTYLE.EquipmentNodeXToBorder * 2 + TUISTYLE.EquipmentNodeSize * 2 + TUISTYLE.EquipmentNodeTextGap * 2 + 8;
			local v = TUISTYLE.EquipmentFrameXSize - s;
			local L, R, B = TUISTYLE.EquipmentNodeLayout.L, TUISTYLE.EquipmentNodeLayout.R, TUISTYLE.EquipmentNodeLayout.B;
			local n = min(#L, #R);
			local m = -1;
			for i = 1, n do
				local l = EquipmentNodes[L[i]];
				local r = EquipmentNodes[R[i]];
				m = max(m, l.Ench:GetWidth() + r.Ench:GetWidth(), l.Name:GetWidth() + r.Gem:GetWidth(), l.Gem:GetWidth() + r.Name:GetWidth());
			end
			m = min(m, TUISTYLE.EquipmentFrameXMaxSize);
			if m > v then
				EquipmentContainer:SetWidth(m + s);
				EquipmentFrameContainer:SetWidth((m + s) * TreeFrameScale);
			else
				EquipmentContainer:SetWidth(TUISTYLE.EquipmentFrameXSize);
				EquipmentFrameContainer:SetWidth(TUISTYLE.EquipmentFrameXSize * TreeFrameScale);
			end
			EquipmentContainer:SetScale(TreeFrameScale);
			if VT.__support_glyph then
				EquipmentFrameContainer.GlyphContainer:SetScale(TreeFrameScale);
			end
		end
		local EquipmentFrameDelayUpdateList = {  };
		local function EquipmentFrameDelayUpdate()
			for EquipmentContainer, cache in next, EquipmentFrameDelayUpdateList do
				EquipmentFrameDelayUpdateList[EquipmentContainer] = nil;
				if EquipmentContainer.Frame:IsShown() then
					MT.UI.EquipmentContainerUpdate(EquipmentContainer, cache);
				end
			end
		end
		function MT.UI.EquipmentContainerUpdate(EquipmentContainer, cache)
			local EquData = cache.EquData;
			MT._TimerHalt(EquipmentFrameDelayUpdate);
			if EquData.AverageItemLevel_OKay then
				EquipmentContainer.AverageItemLevel:SetText(MT.ColorItemLevel(EquData.AverageItemLevel));
			else
				EquipmentContainer.AverageItemLevel:SetText(nil);
			end
			local recache = false;
			local EquipmentNodes = EquipmentContainer.EquipmentNodes;
			local SetInfo = {  };
			for slot = 0, 19 do
				local Node = EquipmentNodes[slot];
				local item = EquData[slot];
				Node.item = item;
				if item ~= nil then
					local name, link, quality, level, _, _, _, _, _, texture, _, _, _, _, _, setID = GetItemInfo(item);
					if link ~= nil then
						Node:SetNormalTexture(texture);
						local color = CT.ITEM_QUALITY_COLORS[quality];
						local r, g, b = color.r, color.g, color.b;
						Node.Glow:SetVertexColor(r, g, b);
						Node.Glow:Show();
						Node.ILvl:SetVertexColor(MT.GetItemLevelColor(level));
						Node.ILvl:SetText(level);
						Node.Name:SetVertexColor(r, g, b);
						Node.Name:SetText(name);
						local enchantable, enchanted, link, level, estr = MT.GetEnchantInfo(cache.class, slot, item);
						if enchantable then
							Node.Ench:SetText(enchanted and estr or l10n.EquipmentList_MissingEnchant);
						else
							Node.Ench:SetText("");
						end
						if VT.__support_gem then
							local A, T, M, R, Y, B, gstr = MT.ScanGemInfo(item, true);
							Node.Gem:SetText(gstr);
						end
						Node.link = link;
						if setID then
							SetInfo[setID] = (SetInfo[setID] or 0) + 1;
						end
					else
						Node:SetNormalTexture(TTEXTURESET.EQUIPMENT.Empty[Node.slot]);
						Node.Glow:Hide();
						Node.ILvl:SetText("");
						Node.Name:SetText("");
						Node.Ench:SetText("");
						Node.Gem:SetText("");
						Node.link = nil;
						recache = true;
					end
				else
					Node:SetNormalTexture(TTEXTURESET.EQUIPMENT.Empty[Node.slot]);
					Node.Glow:Hide();
					Node.ILvl:SetText("");
					Node.Name:SetText("");
					Node.Ench:SetText("");
					Node.Gem:SetText("");
					Node.link = nil;
				end
			end
			if recache then
				EquData.SetInfo = nil;
				EquipmentFrameDelayUpdateList[EquipmentContainer] = cache;
				MT._TimerStart(EquipmentFrameDelayUpdate, 0.5, 1);
			else
				EquData.SetInfo = SetInfo;
				for slot = 1, 18 do
					if EquData[slot] then
						MT.TouchItemTip(EquData[slot]);
					end
				end
			end
			MT.UI.EquipmentFrameContainerResize(EquipmentContainer.EquipmentFrameContainer);
		end
		function MT.UI.EngravingContainerUpdate(EquipmentContainer, cache)
			local EngData = cache.EngData;
			local EngravingNodes = EquipmentContainer.EngravingNodes;
			for slot = 0, 19 do
				local Node = EngravingNodes[slot];
				local info = EngData[slot];
				if info ~= nil and info[1] ~= nil then
					Node:Show();
					Node.id = info[1];
					Node:SetNormalTexture(info[2] or select(3, GetSpellInfo(info[1])) or TTEXTURESET.ENGRAVING_UNK);
				else
					Node:Hide();
				end
			end
			MT.UI.EquipmentFrameContainerResize(EquipmentContainer.EquipmentFrameContainer);
		end
		function MT.UI.EquipmentFrameToggle(Frame)
			local EquipmentFrameContainer = Frame.EquipmentFrameContainer;
			if EquipmentFrameContainer:IsShown() then
				EquipmentFrameContainer:Hide();
			else
				EquipmentFrameContainer:Show();
			end
		end
		function MT.UI.GlyphContainerUpdate(GlyphContainer, GlyData)
			local activeGroup = GlyphContainer.Frame.activeGroup;
			local GlyphNodes = GlyphContainer.GlyphNodes;
			if GlyData ~= nil and GlyData[activeGroup] ~= nil then
				local data = GlyData[activeGroup];
				for index = 1, #GlyphNodes do
					local Node = GlyphNodes[index];
					local info = data[index];
					Node.info = info;
					if info ~= nil then
						Node.SpellID = info[3];
						Node.Texture = info[4];
						Node.Glyph:Show();
						Node.Glyph:SetTexture(info[4]);
						-- SetPortraitToTexture(Node.Glyph, info[4]);
						local def = Node.def;
						if CT.BUILD == "WRATH" then
							Node.Background:SetTexCoord(def[7], def[8], def[9], def[10]);
						end
					else
						Node.SpellID = nil;
						Node.Texture = nil;
						Node.Glyph:Hide();
						local d0 = Node.d0;
						if CT.BUILD == "WRATH" then
							Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
						end
					end
				end
			else
				for index = 1, #GlyphNodes do
					local Node = GlyphNodes[index];
					Node.info = nil;
					Node.SpellID = nil;
					Node.Texture = info[4];
					Node.Glyph:Hide();
					local d0 = Node.d0;
					if CT.BUILD == "WRATH" then
						Node.Background:SetTexCoord(d0[7], d0[8], d0[9], d0[10]);
					end
				end
			end
		end
		function MT.UI.TreeFrameUpdateSize(Frame, width, height)
			local TreeFrames = Frame.TreeFrames;
			local style = Frame.style;
			if style == 1 then
				local scale = min((width - TUISTYLE.TreeFrameXToBorder * 2) / TUISTYLE.TreeFrameXSizeTriple, (height - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize));
				TreeFrames[1]:SetScale(scale);
				TreeFrames[2]:SetScale(scale);
				TreeFrames[3]:SetScale(scale);
				Frame.TreeFrameScale = scale;
			elseif style == 2 then
				local scale = min((width - TUISTYLE.TreeFrameXToBorder * 2) / TUISTYLE.TreeFrameXSizeSingle, (height - TUISTYLE.TreeFrameYToBorder * 2) / (TUISTYLE.TreeFrameYSize + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize));
				TreeFrames[1]:SetScale(scale);
				TreeFrames[2]:SetScale(scale);
				TreeFrames[3]:SetScale(scale);
				Frame.TreeFrameScale = scale;
			end
		end
		function MT.UI.TreeUpdate(Frame, TreeIndex, force_update)
			if Frame.style ~= 2 then
				return;
			end
			if TreeIndex <= 0 or TreeIndex > 3 then
				Frame.TreeButtonsBar.CurTreeIndicator:Hide();
				return;
			end
			local TreeFrames = Frame.TreeFrames;
			local TreeButtons = Frame.TreeButtons;
			if Frame.CurTreeIndex ~= TreeIndex or force_update then
				TreeFrames[Frame.CurTreeIndex]:Hide();
				TreeFrames[TreeIndex]:Show();
				Frame.CurTreeIndex = TreeIndex;
				local CurTreeIndicator = Frame.TreeButtonsBar.CurTreeIndicator;
				CurTreeIndicator:Show();
				CurTreeIndicator:ClearAllPoints();
				CurTreeIndicator:SetPoint("CENTER", TreeButtons[TreeIndex]);
				--	CurTreeIndicator:SetScale(1.5);
				--	for i = 1, 3 do
				--		if i == TreeIndex then
				--			TreeButtons[i]:SetSize(TUISTYLE.TreeButtonXSize * 1.28, TUISTYLE.TreeButtonYSize * 1.28);
				--		else
				--			TreeButtons[i]:SetSize(TUISTYLE.TreeButtonXSize * 0.86, TUISTYLE.TreeButtonYSize * 0.86);
				--		end
				--	end
			end
		end
	--	TooltipFrame
		function MT.UI.CreateTooltipFrame()
			local TooltipFrame = CreateFrame('FRAME', nil, UIParent);
			TooltipFrame:SetSize(1, 1);
			TooltipFrame:SetFrameStrata("FULLSCREEN");
			TooltipFrame:SetClampedToScreen(true);
			TooltipFrame:EnableMouse(false);
			VT.__dep.uireimp._SetSimpleBackdrop(TooltipFrame, 0, 1, 0.0, 0.0, 0.0, 0.75, 0.0, 0.0, 0.0, 1.0);
			TooltipFrame:Hide();
			TooltipFrame:Show();

			local Tooltip1LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip1LabelLeft:SetPoint("TOPLEFT", 6, -6);
			local Tooltip1LabelRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip1LabelRight:SetPoint("TOPRIGHT", -6, -6);
			local Tooltip1Name = "Emu_Tooltip1" .. (MT.GetUnifiedTime() + 1) .. random(1000000, 10000000);
			local Tooltip1 = CreateFrame('GAMETOOLTIP', Tooltip1Name, UIParent, "GameTooltipTemplate");
			Tooltip1:SetPoint("TOPLEFT", Tooltip1LabelLeft, "BOTTOMLEFT", 0, 6);
			if Tooltip1.NineSlice ~= nil then
				Tooltip1.NineSlice:SetAlpha(0.0);
				Tooltip1.NineSlice:Hide();
			end
			for _, v in next, { Tooltip1:GetRegions() } do
				if v:GetObjectType() == 'Texture' then
					v:Hide();
				end
			end
			Tooltip1.TextLeft1 = Tooltip1.TextLeft1 or _G[Tooltip1Name .. "TextLeft1"];
			Tooltip1.TextRight1 = Tooltip1.TextRight1 or _G[Tooltip1Name .. "TextRight1"];
			Tooltip1.TextLeft2 = Tooltip1.TextLeft2 or _G[Tooltip1Name .. "TextLeft2"];
			Tooltip1.TextRight2 = Tooltip1.TextRight2 or _G[Tooltip1Name .. "TextRight2"];

			local Tooltip1FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip1FooterLeft:SetPoint("TOPLEFT", Tooltip1, "BOTTOMLEFT", 12, 6);
			local Tooltip1FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			-- Tooltip1FooterRight:SetPoint("TOPRIGHT", Tooltip1, "BOTTOMRIGHT", -12, 6);
			Tooltip1FooterRight:SetPoint("TOP", Tooltip1, "BOTTOM", 0, 6);
			Tooltip1FooterRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);

			local Tooltip2LabelLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			Tooltip2LabelLeft:SetPoint("TOPLEFT", Tooltip1FooterLeft, "BOTTOMLEFT", -12, -4);
			local Tooltip2LabelRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipHeaderText");
			-- Tooltip2LabelRight:SetPoint("TOPRIGHT", Tooltip1FooterRight, "BOTTOMRIGHT", 0, -4);
			Tooltip2LabelRight:SetPoint("TOP", Tooltip1FooterRight, "BOTTOM", 0, -4);
			Tooltip2LabelRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);
			local Tooltip2Name = "Emu_Tooltip2" .. (MT.GetUnifiedTime() + 100) .. random(1000000, 10000000);
			local Tooltip2 = CreateFrame('GAMETOOLTIP', Tooltip2Name, UIParent, "GameTooltipTemplate");
			Tooltip2:SetPoint("TOPLEFT", Tooltip2LabelLeft, "BOTTOMLEFT", 0, 6);
			if Tooltip2.NineSlice ~= nil then
				Tooltip2.NineSlice:SetAlpha(0.0);
				Tooltip2.NineSlice:Hide();
			end
			for _, v in next, { Tooltip2:GetRegions() } do
				if v:GetObjectType() == 'Texture' then
					v:Hide();
				end
			end
			Tooltip2.TextLeft1 = Tooltip2.TextLeft1 or _G[Tooltip2Name .. "TextLeft1"];
			Tooltip2.TextRight1 = Tooltip2.TextRight1 or _G[Tooltip2Name .. "TextRight1"];
			Tooltip2.TextLeft2 = Tooltip2.TextLeft2 or _G[Tooltip2Name .. "TextLeft2"];
			Tooltip2.TextRight2 = Tooltip2.TextRight2 or _G[Tooltip2Name .. "TextRight2"];

			local Tooltip2FooterLeft = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			Tooltip2FooterLeft:SetPoint("TOPLEFT", Tooltip2, "BOTTOMLEFT", 12, 6);
			local Tooltip2FooterRight = TooltipFrame:CreateFontString(nil, "ARTWORK", "GameTooltipText");
			-- Tooltip2FooterRight:SetPoint("TOPRIGHT", Tooltip2, "BOTTOMRIGHT", -12, 6);
			Tooltip2FooterRight:SetPoint("TOP", Tooltip2, "BOTTOM", 0, 6);
			Tooltip2FooterRight:SetPoint("RIGHT", TooltipFrame, "RIGHT", -6, 0);

			Tooltip1LabelLeft:SetText("");
			Tooltip1LabelRight:SetText("");
			Tooltip2LabelLeft:SetText("");
			Tooltip2LabelRight:SetText("");

			Tooltip1FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip1FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip2FooterLeft:SetTextColor(0.25, 0.5, 1.0, 1.0);
			Tooltip2FooterRight:SetTextColor(0.25, 0.5, 1.0, 1.0);

			Tooltip1FooterLeft:SetText("id");
			Tooltip1FooterRight:SetText("");
			Tooltip2FooterLeft:SetText("id");
			Tooltip2FooterRight:SetText("");

			TooltipFrame.Tooltip1LabelLeft = Tooltip1LabelLeft;
			TooltipFrame.Tooltip1LabelRight = Tooltip1LabelRight;
			TooltipFrame.Tooltip1 = Tooltip1;

			TooltipFrame.Tooltip1FooterLeft = Tooltip1FooterLeft;
			TooltipFrame.Tooltip1FooterRight = Tooltip1FooterRight;

			TooltipFrame.Tooltip2LabelLeft = Tooltip2LabelLeft;
			TooltipFrame.Tooltip2LabelRight = Tooltip2LabelRight;
			TooltipFrame.Tooltip2 = Tooltip2;

			TooltipFrame.Tooltip2FooterLeft = Tooltip2FooterLeft;
			TooltipFrame.Tooltip2FooterRight = Tooltip2FooterRight;

			if _G.GetCurrentRegion() == 3 then	--	EU
				local function OnEvent(self, event, addon)
					--	SetSpellTooltip(self, id)
					if addon:lower() == "woweucn_tooltips" and _G.SetSpellTooltip ~= nil and type(_G.SetSpellTooltip) == 'function' and pcall(_G.SetSpellTooltip, Tooltip1, 5) then
						TooltipFrame.WoWeuCN_TooltipsSetSpellTooltip = _G.SetSpellTooltip;
						Tooltip1:Hide();
						TooltipFrame:UnregisterEvent("ADDON_LOADED");
						return true;
					else
						return false;
					end
				end
				if _G.IsAddOnLoaded("WoWeuCN_Tooltips") and OnEvent(TooltipFrame, "ADDON_LOADED", "WoWeuCN_Tooltips") then
				else
					TooltipFrame:RegisterEvent("ADDON_LOADED");
					TooltipFrame:SetScript("OnEvent", OnEvent);
				end
			end

			return TooltipFrame;
		end
	--	SpellListFrame
		local _SpellListFrameFunc = {  };
		function _SpellListFrameFunc.Node_OnEnter(Node)
			local index = Node:GetDataIndex();
			GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
			local data = Node.list[index];
			GameTooltip:SetSpellByID(data[2]);
			GameTooltip:Show();
			MT.After(0.1, function()
				if select(2, GameTooltip:GetSpell()) ~= data[2] then
					return;
				end
				if data[5] and data[1] > 0 then
					GameTooltip:AddDoubleLine(l10n.SpellList_GTTSpellLevel .. data[5], l10n.SpellList_GTTReqLevel .. data[1], 1.0, 0.75, 0.5, 1.0, 0.75, 0.5);
				elseif data[5] then
					GameTooltip:AddLine(l10n.SpellList_GTTSpellLevel .. data[5], 1.0, 0.75, 0.5);
				elseif data[1] > 0 then
					GameTooltip:AddLine(l10n.SpellList_GTTReqLevel .. data[1], 1.0, 0.75, 0.5);
				end
				if CT.SELFCLASS == Node.list.class then
					if not data[6] then
						if FindSpellBookSlotBySpellID(data[2]) then
							GameTooltip:AddLine(l10n.SpellList_GTTAvailable);
						else
							GameTooltip:AddLine(l10n.SpellList_GTTUnavailable);
						end
					end
				end
				if data[3] > 0 then
					local str;
					if data[3] >= 10000 then
						local c = data[3] % 100;
						local s = (data[3] % 10000 - c) / 100;
						local g = (data[3] - s) / 10000;
						str = format("|cffffbf00%d|r|TInterface\\MoneyFrame\\UI-GoldIcon:12:12:0:0|t|cffffffff%02d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", g, s, c);
					elseif data[3] >= 100 then
						local c = data[3] % 100;
						local s = (data[3] % 10000 - c) / 100;
						str = format("|cffffffff%d|r|TInterface\\MoneyFrame\\UI-SilverIcon:12:12:0:0|t|cffffaf7f%02d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", s, c);
					else
						str = format("|cffffaf7f%d|r|TInterface\\MoneyFrame\\UI-CopperIcon:12:12:0:0|t", data[3]);
					end
					GameTooltip:AddDoubleLine(l10n.SpellList_GTTTrainCost, str, 1, 1, 1, 1, 1, 1);
				end
				if data.race then
					local str = nil;
					for _, v in next, { strsplit("|", data.race) } do
						str = str == nil and (l10n.RACE[v] or v) or (str .. ", " .. (l10n.RACE[v] or v));
					end
					GameTooltip:AddLine(l10n.RACE.RACE .. ": " .. str, 1.0, 0.5, 0.25);
				end
				GameTooltip:Show();
			end);
		end
		function _SpellListFrameFunc.Node_OnLeave(Node)
			if GameTooltip:IsOwned(Node) then
				GameTooltip:Hide();
			end
		end
		function _SpellListFrameFunc.Node_OnClick(Node)
			if IsShiftKeyDown() then
				local index = Node:GetDataIndex();
				local data = Node.list[index];
				local link = VT._comptb._GetSpellLink(data[2]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			end
			Node.SearchEdit:ClearFocus();
		end
		function _SpellListFrameFunc.Node_OnDragStart(Node)
			Node:StopMovingOrSizing();
			local index = Node:GetDataIndex();
			local data = Node.list[index];
			if not data[6] and FindSpellBookSlotBySpellID(data[2]) then
				PickupSpell(data[2]);
			end
		end
		function _SpellListFrameFunc.CreateNode(Parent, index, buttonHeight)
			local Node = CreateFrame('BUTTON', nil, Parent);
			Node:SetHeight(buttonHeight);
			VT.__dep.uireimp._SetSimpleBackdrop(Node, 0, 1, 0.0, 0.0, 0.0, 0.25, 0.5, 0.5, 0.5, 0.25);
			Node:SetHighlightTexture("Interface\\FriendsFrame\\UI-FriendsFrame-HighlightBar");
			Node:EnableMouse(true);
			Node:Show();

			local Icon = Node:CreateTexture(nil, "OVERLAY");
			Icon:SetTexture("Interface\\Icons\\inv_misc_questionmark");
			Icon:SetTexCoord(TUISTYLE.SpellListNodeIconTexCoord[1], TUISTYLE.SpellListNodeIconTexCoord[2], TUISTYLE.SpellListNodeIconTexCoord[3], TUISTYLE.SpellListNodeIconTexCoord[4]);
			Icon:SetSize(buttonHeight - 4, buttonHeight - 4);
			Icon:SetPoint("LEFT", 4, 0);
			Node.Icon = Icon;

			local Title = Node:CreateFontString(nil, "OVERLAY");
			Title:SetFont(TUISTYLE.SpellListFrameFont, TUISTYLE.SpellListFrameFontSize, TUISTYLE.SpellListFrameFontOutline);
			Title:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
			Node.Title = Title;

			Node:SetScript("OnEnter", _SpellListFrameFunc.Node_OnEnter);
			Node:SetScript("OnLeave", _SpellListFrameFunc.Node_OnLeave);
			Node:SetScript("OnClick", _SpellListFrameFunc.Node_OnClick);
			Node:RegisterForDrag("LeftButton");
			Node:SetScript("OnDragStart", _SpellListFrameFunc.Node_OnDragStart);

			local SpellListFrame = Parent:GetParent():GetParent();
			Node.SpellListFrame = SpellListFrame;
			Node.list = SpellListFrame.list;
			Node.SearchEdit = SpellListFrame.SearchEdit;

			return Node;
		end
		function _SpellListFrameFunc.SetNode(Node, data_index)
			local list = Node.list;
			if data_index <= #list then
				local name, _, texture = GetSpellInfo(list[data_index][2]);
				SetPortraitToTexture(Node.Icon, texture);
				-- Node.Icon:SetTexture(texture);
				Node.Title:SetText(name);
				Node:Show();
				if GetMouseFocus() == Node then
					_SpellListFrameFunc.Node_OnEnter(Node);
				end
			else
				Node:Hide();
			end
		end
		function _SpellListFrameFunc.SearchEditCancel_OnClick(SearchEditCancel)
			SearchEditCancel.Edit:SetText("");
			SearchEditCancel.Edit:ClearFocus();
		end
		function _SpellListFrameFunc.SearchEditOKay_OnClick(SearchEditOKay)
			SearchEditOKay.Edit:ClearFocus();
		end
		function _SpellListFrameFunc.SearchEditOKay_OnEnable(SearchEditOKay)
			SearchEditOKay.Text:SetTextColor(1.0, 1.0, 1.0, 1.0);
		end
		function _SpellListFrameFunc.SearchEditOKay_OnDisable(SearchEditOKay)
			SearchEditOKay.Text:SetTextColor(1.0, 1.0, 1.0, 0.5);
		end
		function _SpellListFrameFunc.SearchEdit_OnEnterPressed(SearchEdit)
			SearchEdit:ClearFocus();
		end
		function _SpellListFrameFunc.SearchEdit_OnEscapePressed(SearchEdit)
			SearchEdit:ClearFocus();
		end
		function _SpellListFrameFunc.SearchEdit_OnTextChanged(SearchEdit, isUserInput)
			MT.UI.SpellListFrameUpdate(SearchEdit.SpellListFrame, SearchEdit.SpellListFrame.Frame.class, MT.GetPointsReqLevel(SearchEdit.SpellListFrame.Frame.class, SearchEdit.SpellListFrame.Frame.TotalUsedPoints));
			if not SearchEdit:HasFocus() and SearchEdit:GetText() == "" then
				SearchEdit.Note:Show();
			end
			if SearchEdit:GetText() == "" then
				SearchEdit.Cancel:Hide();
			else
				SearchEdit.Cancel:Show();
			end
		end
		function _SpellListFrameFunc.SearchEdit_OnEditFocusGained(SearchEdit)
			SearchEdit.Note:Hide();
			SearchEdit.OKay:Enable();
		end
		function _SpellListFrameFunc.SearchEdit_OnEditFocusLost(SearchEdit)
			if SearchEdit:GetText() == "" then SearchEdit.Note:Show(); end
			SearchEdit.OKay:Disable();
		end
		function _SpellListFrameFunc.ShowAllSpell_OnClick(ShowAllSpell)
			MT.UI.SpellListFrameUpdate(ShowAllSpell.SpellListFrame, ShowAllSpell.SpellListFrame.Frame.class, MT.GetPointsReqLevel(ShowAllSpell.SpellListFrame.Frame.class, ShowAllSpell.SpellListFrame.Frame.TotalUsedPoints));
		end
		function _SpellListFrameFunc.Close_OnClick(Close)
			MT.UI.SpellListFrameToggle(Close.SpellListFrame.Frame);
		end
		function MT.UI.CreateSpellListFrame(Frame)
			local SpellListFrameContainer = CreateFrame('FRAME', nil, Frame);
			SpellListFrameContainer:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 0, 0);
			SpellListFrameContainer:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 0, 0);
			SpellListFrameContainer:SetWidth(TUISTYLE.SpellListFrameXSize);
			VT.__dep.uireimp._SetSimpleBackdrop(SpellListFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);
			SpellListFrameContainer:Hide();
			local SpellListFrame = CreateFrame('FRAME', nil, SpellListFrameContainer);	--	Frame:GetName() .. "SpellListFrame"
			SpellListFrame:SetPoint("CENTER", SpellListFrameContainer);
			SpellListFrame:SetWidth(TUISTYLE.SpellListFrameXSize);
			SpellListFrame:Show();
			SpellListFrame.list = {  };
			local ScrollList = VT.__dep.__scrolllib.CreateScrollFrame(SpellListFrame, nil, nil, TUISTYLE.SpellListNodeHeight, _SpellListFrameFunc.CreateNode, _SpellListFrameFunc.SetNode);
			ScrollList:SetPoint("BOTTOMLEFT", TUISTYLE.SpellListFrameXToBorder, TUISTYLE.SpellListFrameYToBottom);
			ScrollList:SetPoint("TOPRIGHT", -TUISTYLE.SpellListFrameXToBorder, -TUISTYLE.SpellListFrameYToTop);
			SpellListFrame.ScrollList = ScrollList;

			local SearchEdit = CreateFrame('EDITBOX', nil, SpellListFrame);
			SearchEdit:SetSize(TUISTYLE.SpellListFrameXSize - 2 * TUISTYLE.SpellListFrameXToBorder - 2 - TUISTYLE.SpellListSearchEditOkayXSize, TUISTYLE.SpellListSearchEditYSize);
			SearchEdit:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeSmall, "OUTLINE");
			SearchEdit:SetAutoFocus(false);
			SearchEdit:SetJustifyH("LEFT");
			SearchEdit:Show();
			SearchEdit:EnableMouse(true);
			SearchEdit:SetPoint("TOPLEFT", SpellListFrame, TUISTYLE.SpellListFrameXToBorder, -2);
			local SearchEditTexture = SearchEdit:CreateTexture(nil, "ARTWORK");
			SearchEditTexture:SetPoint("TOPLEFT");
			SearchEditTexture:SetPoint("BOTTOMRIGHT");
			SearchEditTexture:SetTexture("Interface\\Buttons\\greyscaleramp64");
			SearchEditTexture:SetTexCoord(0.0, 0.25, 0.0, 0.25);
			SearchEditTexture:SetAlpha(0.75);
			SearchEditTexture:SetBlendMode("ADD");
			SearchEditTexture:SetVertexColor(0.25, 0.25, 0.25);
			SearchEdit.Texture = SearchEditTexture;
			local SearchEditNote = SearchEdit:CreateFontString(nil, "OVERLAY");
			SearchEditNote:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
			SearchEditNote:SetTextColor(1.0, 1.0, 1.0, 0.5);
			SearchEditNote:SetPoint("LEFT", 4, 0);
			SearchEditNote:SetText(l10n.SpellList_Search);
			SearchEditNote:Show();
			SearchEdit.Note = SearchEditNote;
			local SearchEditCancel = CreateFrame('BUTTON', nil, SearchEdit);
			SearchEditCancel:SetSize(TUISTYLE.SpellListSearchEditYSize, TUISTYLE.SpellListSearchEditYSize);
			SearchEditCancel:SetPoint("RIGHT", SearchEdit);
			SearchEditCancel:SetScript("OnClick", _SpellListFrameFunc.SearchEditCancel_OnClick);
			SearchEditCancel:Hide();
			SearchEditCancel:SetNormalTexture("interface\\petbattles\\deadpeticon");
			SearchEditCancel.Edit = SearchEdit;
			SearchEdit.Cancel = SearchEditCancel;
			local SearchEditOKay = CreateFrame('BUTTON', nil, SpellListFrame);
			SearchEditOKay:SetSize(TUISTYLE.SpellListSearchEditOkayXSize, TUISTYLE.SpellListSearchEditYSize);
			SearchEditOKay:SetPoint("LEFT", SearchEdit, "RIGHT", 4, 0);
			SearchEditOKay:SetScript("OnClick", _SpellListFrameFunc.SearchEditOKay_OnClick);
			SearchEditOKay:Disable();
			SearchEditOKay.Edit = SearchEdit;
			SearchEdit.OKay = SearchEditOKay;
			local SearchEditOKayTexture = SearchEditOKay:CreateTexture(nil, "ARTWORK");
			SearchEditOKayTexture:SetPoint("TOPLEFT");
			SearchEditOKayTexture:SetPoint("BOTTOMRIGHT");
			SearchEditOKayTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			SearchEditOKayTexture:SetAlpha(0.75);
			SearchEditOKayTexture:SetBlendMode("ADD");
			SearchEditOKay.Texture = SearchEditOKayTexture;
			local SearchEditOKayText = SearchEditOKay:CreateFontString(nil, "OVERLAY");
			SearchEditOKayText:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
			SearchEditOKayText:SetTextColor(1.0, 1.0, 1.0, 0.5);
			SearchEditOKayText:SetPoint("CENTER");
			SearchEditOKayText:SetText(l10n.SpellList_SearchOKay);
			SearchEditOKay.Text = SearchEditOKayText;
			SearchEditOKay:SetFontString(SearchEditOKayText);
			SearchEditOKay:SetPushedTextOffset(1, -1);
			SearchEditOKay:SetScript("OnEnable", _SpellListFrameFunc.SearchEditOKay_OnEnable);
			SearchEditOKay:SetScript("OnDisable", _SpellListFrameFunc.SearchEditOKay_OnDisable);
			SearchEdit:SetScript("OnEnterPressed", _SpellListFrameFunc.SearchEdit_OnEnterPressed);
			SearchEdit:SetScript("OnEscapePressed", _SpellListFrameFunc.SearchEdit_OnEscapePressed);
			SearchEdit:SetScript("OnTextChanged", _SpellListFrameFunc.SearchEdit_OnTextChanged);
			SearchEdit:SetScript("OnEditFocusGained", _SpellListFrameFunc.SearchEdit_OnEditFocusGained);
			SearchEdit:SetScript("OnEditFocusLost", _SpellListFrameFunc.SearchEdit_OnEditFocusLost);
			SearchEdit:ClearFocus();
			SearchEdit.SpellListFrame = SpellListFrame;
			SpellListFrame.SearchEdit = SearchEdit;
			SpellListFrame.SearchEditOKay = SearchEditOKay;

			local ShowAllSpell = CreateFrame('CHECKBUTTON', nil, SpellListFrame);
			_TextureFunc.SetNormalTexture(ShowAllSpell, TTEXTURESET.CHECK.Normal, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
			_TextureFunc.SetPushedTexture(ShowAllSpell, TTEXTURESET.CHECK.Pushed, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
			_TextureFunc.SetHighlightTexture(ShowAllSpell, TTEXTURESET.CHECK.Highlight, nil, nil, TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
			_TextureFunc.SetCheckedTexture(ShowAllSpell, TTEXTURESET.CHECK.Checked, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
			ShowAllSpell:SetSize(12, 12);
			ShowAllSpell:SetHitRectInsets(0, 0, 0, 0);
			ShowAllSpell:ClearAllPoints();
			ShowAllSpell:Show();
			ShowAllSpell:SetChecked(false);
			ShowAllSpell:SetPoint("BOTTOMRIGHT", -TUISTYLE.SpellListFrameXToBorder, 6);
			ShowAllSpell:SetScript("OnClick", _SpellListFrameFunc.ShowAllSpell_OnClick);
			ShowAllSpell.SpellListFrame = SpellListFrame;
			SpellListFrame.ShowAllSpell = ShowAllSpell;

			local ShowAllSpellLabel = SpellListFrame:CreateFontString(nil, "ARTWORK");
			ShowAllSpellLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeSmall, TUISTYLE.FrameFontOutline);
			ShowAllSpellLabel:SetText(l10n.SpellList_ShowAllSpell);
			ShowAllSpell.Name = ShowAllSpellLabel;
			ShowAllSpellLabel:SetPoint("RIGHT", ShowAllSpell, "LEFT", -2, 0);

			local Close = CreateFrame('BUTTON', nil, SpellListFrame);
			Close:SetSize(32, 16);
			Close:SetPoint("BOTTOMLEFT", 4, 6);
			Close:SetScript("OnClick", _SpellListFrameFunc.Close_OnClick);
			local CloseTexture = Close:CreateTexture(nil, "ARTWORK");
			CloseTexture:SetPoint("TOPLEFT");
			CloseTexture:SetPoint("BOTTOMRIGHT");
			CloseTexture:SetColorTexture(0.25, 0.25, 0.25, 0.5);
			CloseTexture:SetAlpha(0.75);
			CloseTexture:SetBlendMode("ADD");
			local CloseLabel = Close:CreateFontString(nil, "OVERLAY");
			CloseLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
			CloseLabel:SetTextColor(1.0, 1.0, 1.0, 0.5);
			CloseLabel:SetPoint("CENTER");
			CloseLabel:SetText(l10n.SpellList_Hide);
			Close:SetFontString(CloseLabel);
			Close:SetPushedTextOffset(1, -1);
			Close.SpellListFrame = SpellListFrame;
			SpellListFrame.Close = Close;

			SpellListFrame.Frame = Frame;
			SpellListFrameContainer.Frame = Frame;
			return SpellListFrame, SpellListFrameContainer;
		end
	--	EquipmentContainer & GlyphContainer
		local _LeftFunc = {  };
		function _LeftFunc.Node_OnEnter(Node)
			if Node.link ~= nil then
				GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
				GameTooltip:SetHyperlink(Node.link);
				MT.ColorItemSet(Node, GameTooltip);
				MT.ColorMetaGem(Node, GameTooltip);
			end
		end
		function _LeftFunc.Node_OnLeave(Node, motion)
			if GameTooltip:IsOwned(Node) then
				GameTooltip:Hide();
			end
		end
		function _LeftFunc.Node_OnClick(Node)
			if IsShiftKeyDown() then
				if Node.link ~= nil then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(Node.link);
				end
			elseif IsControlKeyDown() then
				if Node.link ~= nil then
					DressUpItemLink(Node.link);
				end
			end
		end
		function _LeftFunc.Container_OnShow(EquipmentFrameContainer)
			local Frame = EquipmentFrameContainer.Frame;
			if Frame.name ~= nil then
				MT.UI.EquipmentContainerUpdate(Frame.EquipmentContainer, VT.TQueryCache[Frame.name]);
				MT.UI.EngravingContainerUpdate(Frame.EquipmentContainer, VT.TQueryCache[Frame.name]);
				if VT.__support_glyph then
					MT.UI.GlyphContainerUpdate(Frame.GlyphContainer, VT.TQueryCache[Frame.name].GlyData);
				end
			end
		end
		function _LeftFunc.GlyphNode_OnEnter(Node)
			local SpellID = Node.SpellID;
			if SpellID ~= nil then
				GameTooltip:SetOwner(Node, "ANCHOR_RIGHT");
				GameTooltip:SetSpellByID(SpellID);
				GameTooltip:AddLine(Node.TypeText, 0.75, 0.75, 1.0);
				GameTooltip:Show();
			end
		end
		function _LeftFunc.GlyphNode_OnLeave(Node)
			GameTooltip:Hide();
		end
		function _LeftFunc.EngravingNode_OnEnter(Node)
			if Node.id ~= nil then
				GameTooltip:SetOwner(Node, "ANCHOR_LEFT");
				GameTooltip:SetSpellByID(Node.id);
			end
		end
		function _LeftFunc.EngravingNode_OnLeave(Node, motion)
			if GameTooltip:IsOwned(Node) then
				GameTooltip:Hide();
			end
		end
		function _LeftFunc.EngravingNode_OnClick(Node)
			-- if IsShiftKeyDown() then
			-- 	if Node.link ~= nil then
			-- 		local editBox = ChatEdit_ChooseBoxForSend();
			-- 		editBox:Show();
			-- 		editBox:SetFocus();
			-- 		editBox:Insert(Node.link);
			-- 	end
			-- elseif IsControlKeyDown() then
			-- 	if Node.link ~= nil then
			-- 		DressUpItemLink(Node.link);
			-- 	end
			-- end
		end
		function MT.UI.CreateEquipmentFrame(Frame)
			local EquipmentFrameContainer = CreateFrame('FRAME', nil, Frame);
			EquipmentFrameContainer:SetPoint("TOPRIGHT", Frame, "TOPLEFT", 0, 0);
			EquipmentFrameContainer:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", 0, 0);
			EquipmentFrameContainer:SetWidth(TUISTYLE.EquipmentFrameXSize);
			VT.__dep.uireimp._SetSimpleBackdrop(EquipmentFrameContainer, 0, 1, 0.0, 0.0, 0.0, 0.95, 0.0, 0.0, 0.0, 1.0);
			EquipmentFrameContainer:Hide();
			EquipmentFrameContainer:SetScript("OnShow", _LeftFunc.Container_OnShow);
			EquipmentFrameContainer.Frame = Frame;
			--
			local EquipmentContainer = CreateFrame('FRAME', nil, EquipmentFrameContainer);
			EquipmentContainer:SetSize(TUISTYLE.EquipmentFrameXSize, TUISTYLE.EquipmentContainerYSize);
			if VT.__support_glyph then
				EquipmentContainer:SetPoint("TOP", EquipmentFrameContainer);
			else
				EquipmentContainer:SetPoint("BOTTOM", EquipmentFrameContainer);
			end
			EquipmentContainer:Show();

			local AverageItemLevelLabel = EquipmentContainer:CreateFontString(nil, "ARTWORK");
			AverageItemLevelLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, "OUTLINE");
			AverageItemLevelLabel:SetPoint("BOTTOMRIGHT", EquipmentContainer, "TOP", -1, 2);
			AverageItemLevelLabel:SetText(l10n.EquipmentList_AverageItemLevel);
			local AverageItemLevel = EquipmentContainer:CreateFontString(nil, "ARTWORK");
			AverageItemLevel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, "OUTLINE");
			AverageItemLevel:SetPoint("BOTTOMLEFT", EquipmentContainer, "TOP", 1, 2);
			EquipmentContainer.AverageItemLevel = AverageItemLevel;

			local EquipmentNodes = {  };
			local EngravingNodes = {  };
			for slot = 0, 19 do
				local Node = CreateFrame('BUTTON', nil, EquipmentContainer);
				Node:SetSize(TUISTYLE.EquipmentNodeSize, TUISTYLE.EquipmentNodeSize);
				Node:Show();

				Node:EnableMouse(true);
				Node:SetScript("OnEnter", _LeftFunc.Node_OnEnter);
				Node:SetScript("OnLeave", _LeftFunc.Node_OnLeave);
				Node:SetScript("OnClick", _LeftFunc.Node_OnClick);

				Node:SetNormalTexture(TTEXTURESET.UNK);
				_TextureFunc.SetHighlightTexture(Node, TTEXTURESET.EQUIPMENT.Highlight);

				Node.Border = CreateFlatBorder(Node, 3);

				local Glow = Node:CreateTexture(nil, "OVERLAY");
				Glow:SetAllPoints();
				Glow:SetBlendMode("ADD");
				_TextureFunc.SetTexture(Glow, TTEXTURESET.EQUIPMENT.Glow);
				Glow:Show();
				Node.Glow = Glow;

				local ILvl = Node:CreateFontString(nil, "OVERLAY");
				ILvl:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, "OUTLINE");
				ILvl:SetPoint("BOTTOMRIGHT", Node, "BOTTOMRIGHT", 0, 2);
				Node.ILvl = ILvl;

				local Name = Node:CreateFontString(nil, "OVERLAY");
				Name:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
				Node.Name = Name;

				local Ench = Node:CreateFontString(nil, "OVERLAY");
				Ench:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
				Node.Ench = Ench;

				local Gem = Node:CreateFontString(nil, "OVERLAY");
				Gem:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
				Node.Gem = Gem;

				Node.EquipmentContainer = EquipmentContainer;
				Node.slot = slot;
				EquipmentNodes[slot] = Node;

				local Engr = CreateFrame('BUTTON', nil, Node);
				Engr:SetSize(TUISTYLE.EngravingNodeSize, TUISTYLE.EngravingNodeSize);
				Engr:Hide();

				Engr:EnableMouse(true);
				Engr:SetScript("OnEnter", _LeftFunc.EngravingNode_OnEnter);
				Engr:SetScript("OnLeave", _LeftFunc.EngravingNode_OnLeave);
				Engr:SetScript("OnClick", _LeftFunc.EngravingNode_OnClick);

				_TextureFunc.SetNormalTexture(Engr, TTEXTURESET.ENGRAVING.Normal);
				_TextureFunc.SetHighlightTexture(Engr, TTEXTURESET.ENGRAVING.Highlight);

				Engr.EquipmentContainer = EquipmentContainer;
				Engr.slot = slot;
				EngravingNodes[slot] = Engr;
			end
			local L, R, B = TUISTYLE.EquipmentNodeLayout.L, TUISTYLE.EquipmentNodeLayout.R, TUISTYLE.EquipmentNodeLayout.B;
			for index, slot in next, L do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("TOPLEFT", TUISTYLE.EquipmentNodeXToBorder, -TUISTYLE.EquipmentNodeYToBorder - (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) * (index - 1));
				Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("LEFT", Node, "RIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
				local Engr = EngravingNodes[slot];
				Engr:SetPoint("TOPLEFT", -2, 2);
			end
			for index, slot in next, R do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("TOPRIGHT", -TUISTYLE.EquipmentNodeXToBorder, -TUISTYLE.EquipmentNodeYToBorder - (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) * (index - 1));
				Node.Name:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Ench:SetPoint("RIGHT", Node, "LEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				Node.Gem:SetPoint("TOPRIGHT", Node, "TOPLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
				local Engr = EngravingNodes[slot];
				Engr:SetPoint("TOPRIGHT", 2, 2);
			end
			for index, slot in next, B do
				local Node = EquipmentNodes[slot];
				Node:SetPoint("BOTTOM",
					((index - 1) % 2 - 0.5) * (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap),
					(1 - floor((index - 1) / 2)) * (TUISTYLE.EquipmentNodeSize + TUISTYLE.EquipmentNodeGap) + TUISTYLE.EquipmentNodeYToBorder);
				if (index - 1) % 2 == 0 then
					Node.Name:SetPoint("TOPRIGHT", Node, "TOPLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Ench:SetPoint("RIGHT", Node, "LEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Gem:SetPoint("BOTTOMRIGHT", Node, "BOTTOMLEFT", -TUISTYLE.EquipmentNodeTextGap, 0);
					local Engr = EngravingNodes[slot];
					Engr:SetPoint("TOPLEFT", -2, 2);
				else
					Node.Name:SetPoint("TOPLEFT", Node, "TOPRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Ench:SetPoint("LEFT", Node, "RIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
					Node.Gem:SetPoint("BOTTOMLEFT", Node, "BOTTOMRIGHT", TUISTYLE.EquipmentNodeTextGap, 0);
					local Engr = EngravingNodes[slot];
					Engr:SetPoint("TOPRIGHT", -2, 2);
				end
			end
			EquipmentContainer.Frame = Frame;
			EquipmentContainer.EquipmentFrameContainer = EquipmentFrameContainer;
			EquipmentContainer.EquipmentNodes = EquipmentNodes;
			EquipmentContainer.EngravingNodes = EngravingNodes;
			EquipmentFrameContainer.EquipmentContainer = EquipmentContainer;
			--
			local GlyphContainer = nil;
			if VT.__support_glyph then
				GlyphContainer = CreateFrame('FRAME', nil, EquipmentFrameContainer);
				if CT.BUILD == "WRATH" then
					GlyphContainer:SetPoint("BOTTOM", EquipmentFrameContainer);
				else
					GlyphContainer:SetPoint("TOP", EquipmentFrameContainer, "BOTTOM");
				end
				GlyphContainer:SetSize(TUISTYLE.GlyphFrameSize, TUISTYLE.GlyphFrameSize);
				GlyphContainer:Show();
				local GlyphNodes = {  };
				--[[	wlk
							1
						3		5
						6		4
							2
				--]]
				--[[	cata
							7
						4	2	1
						  3   5
						8	6	9
						--
						146 Major = 1
						235	Minor = 2
						789	PRIME = 3
				--]]
				local NodesDef, RingCoord, HighlightCoord;
				if CT.BUILD == "WRATH" then
					NodesDef = {
						--	 type angle (         rgba        ) (                 coords                 )
						[0] = { 0,   0, 0.00, 0.00, 0.00, 1.00, 0.78125    , 0.91015625 , 0.69921875, 0.828125, },
						[1] = { 1,   0, 1.00, 0.25, 0.00, 1.00, 0.0        , 0.12890625 , 0.87109375, 1.0, },
						[2] = { 2, 180, 0.00, 0.25, 1.00, 1.00, 0.130859375, 0.259765625, 0.87109375, 1.0, },
						[3] = { 2, 300, 0.00, 0.25, 1.00, 1.00, 0.392578125, 0.521484375, 0.87109375, 1.0, },
						[4] = { 1, 120, 1.00, 0.25, 0.00, 1.00, 0.5234375  , 0.65234375 , 0.87109375, 1.0, },
						[5] = { 2,  60, 0.00, 0.25, 1.00, 1.00, 0.26171875 , 0.390625   , 0.87109375, 1.0, },
						[6] = { 1, 240, 1.00, 0.25, 0.00, 1.00, 0.654296875, 0.783203125, 0.87109375, 1.0, },
					};
					RingCoord = {
						[1] = { 0.787109375, 0.908203125, 0.033203125, 0.154296875, },
						[2] = { 0.787109375, 0.908203125, 0.033203125, 0.154296875, },
					};
					HighlightCoord = {
						[1] = { 0.765625, 0.927734375, 0.15625, 0.31640625, },
						[2] = { 0.765625, 0.927734375, 0.15625, 0.31640625, },
					};
				else
					NodesDef = {
						[0] = { 0,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[1] = { 1,  60, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[2] = { 2,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[3] = { 2, 240, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[4] = { 1, 300, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[5] = { 2, 120, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[6] = { 1, 180, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[7] = { 3,   0, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[8] = { 3, 240, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
						[9] = { 3, 120, 1.00, 1.00, 1.00, 1.00, 0.0, 1.0, 0.0, 1.0, },
					};
					RingCoord = {
						[1] = { 0.85839844, 0.92285156, 0.00097656, 0.06542969, },
						[2] = { 0.92480469, 0.98437500, 0.00097656, 0.06054688, },
						[3] = { 0.85839844, 0.93847656, 0.22265625, 0.30273438, },
					};
					HighlightCoord = {
						[1] = { 0.85839844, 0.93652344, 0.06738281, 0.14550781, },
						[2] = { 0.85839844, 0.93164063, 0.14746094, 0.22070313, },
						[3] = { 0.85839844, 0.95214844, 0.30468750, 0.39843750, },
					};
				end
				local SIZELOOKUP = {
					[1] = TUISTYLE.MajorGlyphNodeSize,
					[2] = TUISTYLE.MinorGlyphNodeSize,
					[3] = TUISTYLE.PrimeGlyphNodeSize,
				};
				--local R = TUISTYLE.GlyphFrameSize * 0.5 - size * 0.5 - 2;
				local RADIUSLOOKUP = {
					[1] = TUISTYLE.MinorGlyphNodeSize * 0.5 + TUISTYLE.MajorGlyphNodeSize * 0.5,
					[2] = TUISTYLE.MinorGlyphNodeSize * 0.5,
					[3] = TUISTYLE.MinorGlyphNodeSize * 0.75 + TUISTYLE.PrimeGlyphNodeSize * 0.5,
				};
				for index = 1, #NodesDef do
					local def = NodesDef[index];
					local size = SIZELOOKUP[def[1]];
					local R = RADIUSLOOKUP[def[1]];
					local Node = CreateFrame('BUTTON', nil, GlyphContainer);
					Node:SetSize(size, size);
					Node:SetPoint("CENTER", GlyphContainer, "CENTER", R * sin360(def[2]), R * cos360(def[2]) + TUISTYLE.EquipmentNodeXToBorder);
					Node:SetScript("OnEnter", _LeftFunc.GlyphNode_OnEnter);
					Node:SetScript("OnLeave", _LeftFunc.GlyphNode_OnLeave);
					if CT.BUILD == "WRATH" then
						local Setting = Node:CreateTexture(nil, "ARTWORK");
						Setting:SetSize(size * 1.2, size * 1.2);
						Setting:SetPoint("CENTER", 0, 0);
						Setting:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
						Setting:SetTexCoord(0.765625, 0.927734375, 0.15625, 0.31640625);
						local Background = Node:CreateTexture(nil, "BORDER");
						Background:SetSize(size * 1.2, size * 1.2);
						Background:SetPoint("CENTER", 0, 0);
						Background:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
						Background:SetTexCoord(0.78125, 0.91015625, 0.69921875, 0.828125);
						Node.Setting = Setting;
						Node.Background = Background;
					end
					local Highlight = Node:CreateTexture(nil, "BORDER");
					if CT.BUILD == "WRATH" then
						Highlight:SetSize(size * 1.2, size * 1.2);
					else
						Highlight:SetSize(size, size);
					end
					Highlight:SetPoint("CENTER", 0, 0);
					Highlight:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					local hc = HighlightCoord[def[1]];
					Highlight:SetTexCoord(hc[1], hc[2], hc[3], hc[4]);
					Highlight:SetVertexColor(1.0, 1.0, 1.0, 0.25);
					Highlight:SetBlendMode("ADD");
					Highlight:Hide();
					Node:SetHighlightTexture(Highlight);
					local Glyph = Node:CreateTexture(nil, "ARTWORK");
					Glyph:SetSize(size * 0.75, size * 0.75);
					Glyph:SetPoint("CENTER", 0, 0);
					Glyph:SetTexture([[Interface\Spellbook\UI-Glyph-Rune1]]);
					Glyph:SetVertexColor(def[3], def[4], def[5], def[6]);
					Glyph:SetBlendMode("BLEND");
					Glyph:Hide();
					local Ring = Node:CreateTexture(nil, "OVERLAY");
					Ring:SetSize(size * 0.86, size * 0.86);
					Ring:SetPoint("CENTER", 0, 1);
					Ring:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
					local rc = RingCoord[def[1]];
					Ring:SetTexCoord(rc[1], rc[2], rc[3], rc[4]);
					if CT.BUILD == "WRATH" then
						local Shine = Node:CreateTexture(nil, "OVERLAY");
						Shine:SetSize(size / 6, size / 6);
						Shine:SetPoint("CENTER", -size / 8, size / 6);
						Shine:SetTexture([[Interface\Spellbook\UI-GlyphFrame]]);
						Shine:SetTexCoord(0.9609375, 1.0, 0.921875, 0.9609375);
					end
					Node.Type = def[1];
					if Node.Type == 1 then
						Node.TypeText = l10n.MAJOR_GLYPH;
					elseif Node.Type == 2 then
						Node.TypeText = l10n.MINOR_GLYPH;
					else
						Node.TypeText = l10n.PRIME_GLYPH;
					end
					Node.ID = index;
					Node.Highlight = Highlight;
					Node.Glyph = Glyph;
					Node.Ring = Ring;
					Node.Shine = Shine;
					Node.def = def;
					Node.d0 = NodesDef[0];
					GlyphNodes[index] = Node;
				end
				GlyphContainer.Frame = Frame;
				GlyphContainer.EquipmentFrameContainer = EquipmentFrameContainer;
				GlyphContainer.GlyphNodes = GlyphNodes;
				EquipmentFrameContainer.GlyphContainer = GlyphContainer;
			end
			--
			return EquipmentFrameContainer, EquipmentContainer, GlyphContainer;
		end
	--	TreeFrame
		local _TreeFunc = {  };
		function _TreeFunc.Node_OnEnter(Node)
			MT.UI.SetTooltip(Node);
		end
		function _TreeFunc.Node_OnLeave(Node)
			MT.UI.HideTooltip(Node);
		end
		function _TreeFunc.Node_OnClick(Node, button)
			if IsShiftKeyDown() then
				local TreeFrame = Node.TreeFrame;
				local Frame = TreeFrame.Frame;
				local TreeTDB = TreeFrame.TreeTDB;
				local TalentSet = TreeFrame.TalentSet;
				local TalentSeq = Node.TalentSeq;
				local link = VT._comptb._GetSpellLink(TreeTDB[TalentSeq][8][TalentSet[TalentSeq] == 0 and 1 or TalentSet[TalentSeq]]);
				if link then
					local editBox = ChatEdit_ChooseBoxForSend();
					editBox:Show();
					editBox:SetFocus();
					editBox:Insert(link);
				end
			else
				if not Node.active then
					return;
				end
				if button == "LeftButton" then
					MT.UI.TreeNodeChangePoint(Node, 1);
				elseif button == "RightButton" then
					MT.UI.TreeNodeChangePoint(Node, -1);
				end
			end
		end
		function _TreeFunc.CreateNode(TreeFrame, id)
			local Node = CreateFrame('BUTTON', nil, TreeFrame);	--	TreeFrame:GetName() .. "TreeNode" .. id
			Node:SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);

			Node:Hide();
			Node:EnableMouse(true);
			Node:RegisterForClicks("LeftButtonUp", "RightButtonUp");
			Node:SetScript("OnClick", _TreeFunc.Node_OnClick);
			Node:SetScript("OnEnter", _TreeFunc.Node_OnEnter);
			Node:SetScript("OnLeave", _TreeFunc.Node_OnLeave);

			Node:SetNormalTexture(TTEXTURESET.UNK);
			Node:SetPushedTexture(TTEXTURESET.UNK);
			_TextureFunc.SetHighlightTexture(Node, TTEXTURESET.ICON_HIGHLIGHT, TTEXTURESET.SQUARE_HIGHLIGHT);

			Node.Border = CreateFlatBorder(Node, 3);

			local Split = Node:CreateFontString(nil, "OVERLAY", nil, 1);
			Split:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			Split:SetText("/");
			Split:SetPoint("CENTER", Node, "BOTTOMRIGHT", 0, 0);
			Node.Split = Split;
			local MaxVal = Node:CreateFontString(nil, "OVERLAY", nil, 1);
			MaxVal:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			MaxVal:SetText("1");
			MaxVal:SetPoint("LEFT", Split, "RIGHT", 0, 0);
			Node.MaxVal = MaxVal;
			local CurVal = Node:CreateFontString(nil, "OVERLAY", nil, 1);
			CurVal:SetFont(TUISTYLE.TreeNodeFont, TUISTYLE.TreeNodeFontSize, TUISTYLE.TreeNodeFontOutline)
			CurVal:SetText("");
			CurVal:SetPoint("RIGHT", Split, "LEFT", 0, 0);
			Node.CurVal = CurVal;

			local Overlay = Node:CreateTexture(nil, "OVERLAY");
			Overlay:SetAllPoints();
			Overlay:SetBlendMode("ADD");
			Node.Overlay = Overlay;

			Node.TreeFrame = TreeFrame;
			Node.id = id;
			Node.active = true;

			return Node;
		end
		function _TreeFunc.CreateNodes(TreeFrame)
			local TreeNodes = {  };
			local posX = 0;
			local posY = 0;
			for id = 1, DT.MAX_NUM_TALENTS do
				local Node = _TreeFunc.CreateNode(TreeFrame, id);
				Node:SetPoint("TOP", TreeFrame, "TOP", (TUISTYLE.TreeNodeSize + TUISTYLE.TreeNodeXGap) * (posX - DT.MAX_NUM_COL * 0.5 + 0.5), -TUISTYLE.TreeFrameHeaderYSize - TUISTYLE.TreeNodeYToTop - (TUISTYLE.TreeNodeSize + TUISTYLE.TreeNodeYGap) * posY);
				Node:Hide();
				TreeNodes[id] = Node;

				posX = posX + 1;
				if posX > 3 then
					posX = 0;
					posY = posY + 1;
				end
			end

			return TreeNodes;
		end
		function _TreeFunc.ResetTreeButton_OnClick(ResetTreeButton)
			local TreeFrame = ResetTreeButton.TreeFrame;
			MT.UI.TreeFrameResetTalents(TreeFrame);
		end
		function _TreeFunc.OnDragStart(TreeFrame, button)
			local Frame = TreeFrame.Frame;
			if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
				Frame:StartMoving();
			end
		end
		function _TreeFunc.OnDragStop(TreeFrame, button)
			TreeFrame.Frame:StopMovingOrSizing();
		end
		function MT.UI.CreateTreeFrames(Frame)
			local TreeFrames = {  };

			for TreeIndex = 1, 3 do
				local TreeFrame = CreateFrame('FRAME', nil, Frame);	--	Frame:GetName() .. "TreeFrame" .. TreeIndex
				TreeFrame:SetSize(TUISTYLE.TreeFrameXSizeSingle, TUISTYLE.TreeFrameYSize);

				TreeFrame:Show();
				TreeFrame:SetMouseClickEnabled(false);
				-- TreeFrame:EnableMouse(true);
				-- TreeFrame:SetMovable(true);
				-- TreeFrame:RegisterForDrag("LeftButton");
				-- TreeFrame:SetScript("OnShow", TreeFrame_OnShow);
				-- TreeFrame:SetScript("OnHide", TreeFrame_OnHide);
				-- TreeFrame:SetScript("OnDragStart", _TreeFunc.OnDragStart);
				-- TreeFrame:SetScript("OnDragStop", _TreeFunc.OnDragStop);

				local HSeq = {  };
				HSeq[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[1]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[1]:SetPoint("LEFT", TreeFrame, "TOPLEFT", 0, 0);
				HSeq[1]:SetPoint("RIGHT", TreeFrame, "TOPRIGHT", 0, 0);
				_TextureFunc.SetTexture(HSeq[1], TTEXTURESET.SEP_HORIZONTAL);
				HSeq[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[2]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[2]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, 0);
				HSeq[2]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, 0);
				_TextureFunc.SetTexture(HSeq[2], TTEXTURESET.SEP_HORIZONTAL);
				HSeq[3] = TreeFrame:CreateTexture(nil, "ARTWORK");
				HSeq[3]:SetHeight(TUISTYLE.TreeFrameSeqWidth);
				HSeq[3]:SetPoint("LEFT", TreeFrame, "BOTTOMLEFT", 0, TUISTYLE.TreeFrameFooterYSize);
				HSeq[3]:SetPoint("RIGHT", TreeFrame, "BOTTOMRIGHT", 0, TUISTYLE.TreeFrameFooterYSize);
				_TextureFunc.SetTexture(HSeq[3], TTEXTURESET.SEP_HORIZONTAL);
				TreeFrame.HSeq = HSeq;

				local VSep = {  };
				VSep[1] = TreeFrame:CreateTexture(nil, "ARTWORK");
				VSep[1]:SetWidth(TUISTYLE.TreeFrameSeqWidth);
				VSep[1]:SetPoint("TOP", TreeFrame, "TOPLEFT", 0, 0);
				VSep[1]:SetPoint("BOTTOM", TreeFrame, "BOTTOMLEFT", 0, 0);
				_TextureFunc.SetTexture(VSep[1], TTEXTURESET.SEP_VERTICAL);
				VSep[2] = TreeFrame:CreateTexture(nil, "ARTWORK");
				VSep[2]:SetWidth(TUISTYLE.TreeFrameSeqWidth);
				VSep[2]:SetPoint("TOP", TreeFrame, "TOPRIGHT", 0, 0);
				VSep[2]:SetPoint("BOTTOM", TreeFrame, "BOTTOMRIGHT", 0, 0);
				_TextureFunc.SetTexture(VSep[2], TTEXTURESET.SEP_VERTICAL);
				TreeFrame.VSep = VSep;

				local Background = TreeFrame:CreateTexture(nil, "BORDER");
				Background:SetAllPoints();
				Background:SetAlpha(0.6);
				local ratio = TUISTYLE.TreeFrameXSizeSingle / TUISTYLE.TreeFrameYSize;
				if ratio > 1.0 then
					Background:SetTexCoord(0.0, 1.0, (1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5);
				elseif ratio < 1.0 then
					Background:SetTexCoord((1.0 - ratio) * 0.5, (1.0 + ratio) * 0.5, 0.0, 1.0);
				end
				TreeFrame.Background = Background;

				TreeFrame.TreeNodes = _TreeFunc.CreateNodes(TreeFrame);

				local ResetTreeButtonBackgroud = TreeFrame:CreateTexture(nil, "ARTWORK");
				ResetTreeButtonBackgroud:SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);
				ResetTreeButtonBackgroud:SetPoint("CENTER", TreeFrame.TreeNodes[DT.MAX_NUM_TALENTS]);
				_TextureFunc.SetTexture(ResetTreeButtonBackgroud, TTEXTURESET.RESETTREE.Backgroud);
				TreeFrame.ResetTreeButtonBackgroud = ResetTreeButtonBackgroud;

				local ResetTreeButton = CreateFrame('BUTTON', nil, TreeFrame);
				ResetTreeButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				ResetTreeButton:SetPoint("CENTER", ResetTreeButtonBackgroud);
				_TextureFunc.SetHighlightTexture(ResetTreeButton, TTEXTURESET.RESETTREE.Highlight);
				ResetTreeButton:GetHighlightTexture():ClearAllPoints();
				ResetTreeButton:GetHighlightTexture():SetPoint("CENTER");
				ResetTreeButton:GetHighlightTexture():SetSize(TUISTYLE.TreeNodeSize, TUISTYLE.TreeNodeSize);
				ResetTreeButton:SetScript("OnClick", _TreeFunc.ResetTreeButton_OnClick);
				ResetTreeButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetTreeButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetTreeButton.information = l10n.ResetTreeButton;
				TreeFrame.ResetTreeButton = ResetTreeButton;
				ResetTreeButton.TreeFrame = TreeFrame;

				local TreePoints = TreeFrame:CreateFontString(nil, "ARTWORK");
				TreePoints:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeLarge, TUISTYLE.FrameFontOutline);
				TreePoints:SetPoint("CENTER", ResetTreeButton);
				TreePoints:SetTextColor(0.0, 1.0, 0.0, 1.0);
				TreePoints:SetText("0");
				TreeFrame.TreePoints = TreePoints;

				local TreeLabel = TreeFrame:CreateFontString(nil, "ARTWORK");
				TreeLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, "OUTLINE");
				TreeLabel:SetPoint("CENTER", TreeFrame, "BOTTOM", 0, TUISTYLE.TreeFrameFooterYSize * 0.5);
				TreeLabel:SetTextColor(0.9, 0.9, 0.9, 1.0);
				TreeFrame.TreeLabel = TreeLabel;
				local TreeLabelBackground = TreeFrame:CreateTexture(nil, "ARTWORK");
				TreeLabelBackground:SetSize(TUISTYLE.TreeFrameFooterYSize, TUISTYLE.TreeFrameFooterYSize);
				-- TreeLabelBackground:SetPoint("BOTTOMLEFT", TreeFrame, "BOTTOMLEFT", 0, 0);
				-- TreeLabelBackground:SetPoint("TOPRIGHT", TreeFrame, "BOTTOMRIGHT", 0, TUISTYLE.TreeFrameFooterYSize);
				TreeLabelBackground:SetPoint("RIGHT", TreeLabel, "LEFT", -4, 0);
				TreeLabelBackground:SetTexCoord(TUISTYLE.TreeFrameLabelBackgroundTexCoord[1], TUISTYLE.TreeFrameLabelBackgroundTexCoord[2], TUISTYLE.TreeFrameLabelBackgroundTexCoord[3], TUISTYLE.TreeFrameLabelBackgroundTexCoord[4]);
				TreeFrame.TreeLabelBackground = TreeLabelBackground;

				TreeFrame.Frame = Frame;
				TreeFrame.id = TreeIndex;
				TreeFrame.TalentSet = { CountByTier = {  }, Total = 0, TopAvailableTier = 0, TopCheckedTier = 0, };
				for i = 1, DT.MAX_NUM_TALENTS do
					TreeFrame.TalentSet[i] = 0;
				end
				for i = 0, DT.MAX_NUM_TIER do
					TreeFrame.TalentSet.CountByTier[i] = 0;
				end
				TreeFrame.TalentChanged = {  };
				TreeFrame.DependArrows = { used = 0, };
				TreeFrame.NodeDependArrows = {  };
				for i = 1, DT.MAX_NUM_TALENTS do
					TreeFrame.NodeDependArrows[i] = {  };
				end

				TreeFrames[TreeIndex] = TreeFrame;
			end

			return TreeFrames;
		end
	--	Frame sub objects
		local _SideFunc = {  };
		local function B()
		end
		--	Header
		function _SideFunc.CloseButton_OnClick(self, button)
			self.Frame:Hide();
		end
		function _SideFunc.ResetToEmuButton_OnClick(self)
			local Frame = self.Frame;
			MT.UI.FrameSetName(Frame, nil);
			MT.UI.FrameSetTalent(Frame, nil);
			MT.UI.FrameSetLevel(Frame, DT.MAX_LEVEL);
			self:Hide();
		end
		function _SideFunc.ResetToSetButton_OnClick(self)
			local Frame = self.Frame;
			local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
			local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
			MT.UI.FrameReset(Frame);
			MT.UI.FrameSetInfo(Frame, class, level, TalData, activeGroup, name, readOnly, rule);
			if ShowEquip then
				Frame.EquipmentFrameContainer:Show();
				MT.Debug("EquipFrame", "ResetToSet Show");
			end
			MT.CALLBACK.OnInventoryDataRecv(name);
			self:Hide();
		end
		VT.TalentGroupSelectMenuDefinition = {
			handler = function(button, Frame, val)
				local class, level, TalData, activeGroup, name, readOnly, rule =  Frame.class, Frame.level, Frame.TalData, Frame.activeGroup, Frame.name, Frame.readOnly, Frame.rule;
				local ShowEquip = Frame.EquipmentFrameContainer:IsShown();
				MT.UI.FrameReset(Frame);
				MT.UI.FrameSetInfo(Frame, class, level, TalData, val, name, readOnly, rule);
				if ShowEquip then
					Frame.EquipmentFrameContainer:Show();
					MT.Debug("EquipFrame", "TalentGroupSelect Show");
				end
				return MT.CALLBACK.OnInventoryDataRecv(name);
			end,
			num = 0,
		};
		function _SideFunc.TalentGroupSelect_OnClick(self)
			local Frame = self.Frame;
			local TalData = Frame.TalData;
			if TalData.num > 1 then
				for group = 1, TalData.num do
					local val = TalData[group];
					local stats = MT.CountTreePoints(val, Frame.class);
					VT.TalentGroupSelectMenuDefinition[group] = {
						param = group,
						text = (group == Frame.activeGroup) and ("|cff00ff00>|r " .. stats[1] .. "-" .. stats[2] .. "-" .. stats[3] .. " |cff00ff00<|r") or ("|cff000000>|r " .. stats[1] .. "-" .. stats[2] .. "-" .. stats[3] .. " |cff000000<|r"),
					};
				end
				VT.TalentGroupSelectMenuDefinition.num = TalData.num;
				VT.__dep.__menulib.ShowMenu(self, "BOTTOMRIGHT", VT.TalentGroupSelectMenuDefinition, self.Frame, false, true);
			end
		end
		--	Footer
		function _SideFunc.ExpandButton_OnClick(self)
			local Frame = self.Frame;
			if Frame.style ~= 2 then
				MT.UI.FrameSetStyle(Frame, 2);
				if VT.SET.singleFrame then
					VT.SET.style = 2;
				end
			else
				MT.UI.FrameSetStyle(Frame, 1);
				if VT.SET.singleFrame then
					VT.SET.style = 1;
				end
			end
		end
		function _SideFunc.ResetAllButton_OnClick(self)
			MT.UI.FrameResetTalents(self.Frame);
		end
		function _SideFunc.TreeButton_OnClick(self)
			MT.UI.TreeUpdate(self.Frame, self.id);
		end
		--	side
		VT.ClassButtonMenuDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR.savedTalent[val[1]] = nil;
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
				end
			end,
			num = 0,
		};
		function _SideFunc.ClassButton_OnClick(self, button)
			if button == "LeftButton" then
				local Frame = self.Frame;
				if Frame.class ~= self.class then
					MT.UI.FrameReset(Frame);
					MT.UI.FrameSetClass(Frame, self.class);
					local objects = Frame.objects;
					objects.CurClassIndicator:Show();
					objects.CurClassIndicator:ClearAllPoints();
					objects.CurClassIndicator:SetPoint("CENTER", Frame.ClassButtons[DT.ClassToIndex[Frame.class]]);
				end
			elseif button == "RightButton" then
				local class = self.class;
				if next(VT.VAR.savedTalent) == nil then
					return;
				end
				local Frame = self.Frame;
				local pos = 0;
				for title, code in next, VT.VAR.savedTalent do
					if VT.__dep.__emulib.GetClass(code) == class then
						pos = pos + 1;
						VT.ClassButtonMenuDefinition[pos] = {
							param = { title, code, },
							text = title,
						};
					end
				end
				VT.ClassButtonMenuDefinition.num = pos;
				if pos > 0 then
					VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.ClassButtonMenuDefinition, Frame);
				end
			end
		end
		function _SideFunc.SpellListButton_OnClick(self)
			MT.UI.SpellListFrameToggle(self.Frame);
		end
		StaticPopupDialogs["TalentEmu_ApplyTalents"] = {
			text = l10n.ApplyTalentsButton_Notify,
			button1 = l10n.OKAY,
			button2 = l10n.CANCEL,
			--	OnShow = function(self) end,
			OnAccept = function(self, Frame)
				MT.ApplyTalents(Frame);
			end,
			OnHide = function(self)
				self.which = nil;
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 1,
		};
		function _SideFunc.ApplyTalentsButton_OnClick(self)
			if UnitLevel('player') >= 10 then
				StaticPopup_Show("TalentEmu_ApplyTalents", nil, nil, self.Frame);
			end
		end
		function _SideFunc.SettingButton_OnClick(self)
			MT.OpenSetting();
		end
		function _SideFunc.ImportButton_OnClick(self)
			local EditBox = self.Frame.EditBox;
			if EditBox:IsShown() and EditBox.Parent == self then
				EditBox:Hide();
			else
				EditBox:ClearAllPoints();
				EditBox:SetPoint("LEFT", self, "RIGHT", TUISTYLE.EditBoxYSize + 4, 0);
				EditBox:SetText("");
				EditBox:Show();
				EditBox:SetFocus();
				EditBox.OKayButton:ClearAllPoints();
				EditBox.OKayButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
				--	EditBox.OKayButton:Show();
				EditBox.Parent = self;
				EditBox.type = "import";
			end
		end
		VT.ExportButtonMenuDefinition = {
			handler = function(button, Frame, codec)
				local code = codec:ExportCode(Frame);
				if code ~= nil then
					local EditBox = Frame.EditBox;
					EditBox:SetText(code);
					EditBox:Show();
					EditBox:SetFocus();
					EditBox:HighlightText();
					EditBox.type = "export";
				end
			end,
			num = 1,
			[1] = {
				param = MT,
				text = l10n.ExportButton_AllData,
			},
		};
		function _SideFunc.ExportButton_OnClick(self, button)
			local Frame = self.Frame;
			local EditBox = Frame.EditBox;
			if EditBox:IsShown() and EditBox.Parent == self then
				EditBox:Hide();
			else
				EditBox:ClearAllPoints();
				EditBox:SetPoint("LEFT", self, "RIGHT", 4, 0);
				EditBox.OKayButton:ClearAllPoints();
				EditBox.OKayButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 0);
				EditBox.Parent = self;
				if button == "LeftButton" then
					EditBox:SetText(MT.EncodeTalent(Frame));
					EditBox:Show();
					EditBox:SetFocus();
					EditBox:HighlightText();
					EditBox.type = "export";
				elseif button == "RightButton" then
					if VT.ExportButtonMenuDefinition.num > 0 then
						VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.ExportButtonMenuDefinition, Frame);
					end
				end
			end
		end
		VT.SaveButtonMenuDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR.savedTalent[val[1]] = nil;
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[1]);
				end
			end,
			num = 0,
		};
		VT.SaveButtonMenuAltDefinition = {
			handler = function(button, Frame, val)
				if IsShiftKeyDown() then
					VT.VAR[val[1]] = nil;
					for index = VT.SaveButtonMenuAltDefinition.num, 1, -1 do
						if VT.SaveButtonMenuAltDefinition[index].param[1] == val[1] then
							tremove(VT.SaveButtonMenuAltDefinition, index);
							VT.SaveButtonMenuAltDefinition.num = VT.SaveButtonMenuAltDefinition.num - 1;
						end
					end
				else
					VT.ImportIndex = VT.ImportIndex + 1;
					MT:ImportCode(Frame, val[2], "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "] " .. val[3]);
				end
			end,
			num = 0,
		}
		function _SideFunc.SaveButton_OnClick(self, button)
			if button == "LeftButton" then
				local Frame = self.Frame;
				local EditBox = Frame.EditBox;
				if EditBox:IsShown() and EditBox.Parent == self then
					EditBox:Hide();
				else
					EditBox:ClearAllPoints();
					EditBox:SetPoint("LEFT", self, "RIGHT", TUISTYLE.EditBoxYSize + 4, 0);
					EditBox:SetText(MT.GenerateTitleFromRawData(Frame));
					EditBox:Show();
					EditBox.OKayButton:ClearAllPoints();
					EditBox.OKayButton:SetPoint("LEFT", self, "RIGHT", 4, 0);
					EditBox.Parent = self;
					EditBox.type = "save";
				end
			elseif button == "RightButton" then
				if IsAltKeyDown() then
					if VT.SaveButtonMenuAltDefinition.num > 0 then
						VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuAltDefinition, self.Frame);
					end
				else
					if next(VT.VAR.savedTalent) == nil then
						return;
					end
					local pos = 0;
					for title, code in next, VT.VAR.savedTalent do
						pos = pos + 1;
						VT.SaveButtonMenuDefinition[pos] = {
							param = { title, code, },
							text = title,
						};
					end
					VT.SaveButtonMenuDefinition.num = pos;
					if pos > 0 then
						VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SaveButtonMenuDefinition, self.Frame);
					end
				end
			end
		end
		local channel_list = {
			"PARTY",
			"GUILD",
			"RAID",
			"BATTLEGROUND",
			"WHISPER",
		};
		VT.SendButtonMenuDefinition = {
			handler = function(button, Frame, val)
				return MT.CreateEmulator(Frame, val[1], val[2], val[3], l10n.message, false, false);
			end,
			num = 0,
		};
		function _SideFunc.SendButton_OnClick(self, button)
			local Frame = self.Frame;
			if button == "LeftButton" then
				MT.SendTalents(Frame);
			elseif button == "RightButton" then
				if VT.SendButtonMenuDefinition.num > 0 then
					VT.__dep.__menulib.ShowMenu(self, "TOPRIGHT", VT.SendButtonMenuDefinition, Frame);
				end
			end
		end
		function _SideFunc.EditBox_OnEnterPressed(self)
			if self.type == nil then
				return;
			end
			local Type = self.type;
			self.type = nil;
			self:ClearFocus();
			self:Hide();
			if Type == "import" then
				local code = self:GetText();
				if code ~= nil and code ~= "" then
					for media, codec in next, VT.ExternalCodec do
						local class, level, data = codec:ImportCode(code);
						if class ~= nil then
							VT.ImportIndex = VT.ImportIndex + 1;
							return MT.UI.FrameSetInfo(self.Frame, class, level, { data, nil, num = 1, active = 1, }, 1, "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "]");
						end
					end
					VT.ImportIndex = VT.ImportIndex + 1;
					return MT:ImportCode(self.Frame, code, "#" .. l10n.Import .. "[" .. VT.ImportIndex .. "]");
				end
			elseif Type == "save" then
				local title = self:GetText();
				if title == nil or title == "" then
					title = #VT.VAR.savedTalent + 1;
				end
				VT.VAR.savedTalent[title] = MT.EncodeTalent(self.Frame);
			end
		end
		function _SideFunc.EditBoxOKayButton_OnClick(self)
			return _SideFunc.EditBox_OnEnterPressed(self.EditBox);
		end
		function _SideFunc.EditBox_OnEscapePressed(EditBox)
			EditBox:SetText("");
			EditBox:ClearFocus();
			EditBox:Hide();
		end
		function _SideFunc.EditBox_OnShow(EditBox)
			EditBox.type = nil;
			EditBox.charChanged = nil;
		end
		function _SideFunc.EditBox_OnHide(EditBox)
			EditBox.type = nil;
			EditBox.charChanged = nil;
		end
		function _SideFunc.EditBox_OnChar(EditBox)
			EditBox.charChanged = true;
		end

		function _SideFunc.EquipmentFrameButton_OnClick(self)
			MT.UI.EquipmentFrameToggle(self.Frame);
		end

		function MT.UI.CreateFrameSubObject(Frame)
			local objects = {  };
			Frame.objects = objects;

			--	<Header>
				local Header = CreateFrame('FRAME', nil, Frame);
				Header:SetPoint("TOPLEFT");
				Header:SetPoint("TOPRIGHT");
				Header:SetHeight(TUISTYLE.FrameHeaderYSize);
				Frame.Header = Header;
				local Background = Header:CreateTexture(nil, "BACKGROUND");
				Background:SetAllPoints();
				Background:SetColorTexture(0.0, 0.0, 0.0, 0.5);
				Header.Background = Background;

				local CloseButton = CreateFrame('BUTTON', nil, Header);
				CloseButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				_TextureFunc.SetNormalTexture(CloseButton, TTEXTURESET.CLOSE, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
				_TextureFunc.SetPushedTexture(CloseButton, TTEXTURESET.CLOSE, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				_TextureFunc.SetHighlightTexture(CloseButton, TTEXTURESET.CLOSE, nil, nil, TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
				CloseButton:SetPoint("CENTER", Header, "RIGHT", -TUISTYLE.FrameHeaderYSize * 0.5, 0);
				CloseButton:Show();
				CloseButton:SetScript("OnClick", _SideFunc.CloseButton_OnClick);
				CloseButton:SetScript("OnEnter", MT.GeneralOnEnter);
				CloseButton:SetScript("OnLeave", MT.GeneralOnLeave);
				CloseButton.Frame = Frame;
				CloseButton.information = l10n.CloseButton;
				objects.CloseButton = CloseButton;

				local Name = Header:CreateFontString(nil, "ARTWORK");
				Name:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
				Name:SetText(l10n.Emulator);
				Name:SetPoint("CENTER", Header, "CENTER", 0, 0);
				Name.Points1 = { "CENTER", Header, "CENTER", 0, 0, };
				Name.Points2 = { "BOTTOM", Header, "TOP", 0, 4, };
				objects.Name = Name;

				local ResetToEmuButton = CreateFrame('BUTTON', nil, Header);
				ResetToEmuButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				_TextureFunc.SetNormalTexture(ResetToEmuButton, TTEXTURESET.RESETTOEMU, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
				_TextureFunc.SetPushedTexture(ResetToEmuButton, TTEXTURESET.RESETTOEMU, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				_TextureFunc.SetHighlightTexture(ResetToEmuButton, TTEXTURESET.RESETTOEMU, nil, nil, TTEXTURESET.CONTROL.HIGHLIGHT_COLOR);
				ResetToEmuButton:SetFrameLevel(ResetToEmuButton:GetFrameLevel() + 1);
				ResetToEmuButton:SetPoint("RIGHT", Name, "LEFT", 0, 0);
				ResetToEmuButton:SetScript("OnClick", _SideFunc.ResetToEmuButton_OnClick);
				ResetToEmuButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetToEmuButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetToEmuButton.Frame = Frame;
				ResetToEmuButton.information = l10n.ResetToEmuButton;
				objects.ResetToEmuButton = ResetToEmuButton;

				local PackLabel = Header:CreateFontString(nil, "ARTWORK");
				PackLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeLarge, TUISTYLE.FrameFontOutline);
				PackLabel:SetText("");
				PackLabel:SetPoint("BOTTOM", Name, "TOP", 0, 4);
				PackLabel:Hide();
				objects.PackLabel = PackLabel;

				local Label = Header:CreateFontString(nil, "ARTWORK");
				Label:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
				Label:SetPoint("CENTER", Header, "CENTER", 0, 0);
				Label:Hide();
				objects.Label = Label;

				local ResetToSetButton = CreateFrame('BUTTON', nil, Header);
				ResetToSetButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				_TextureFunc.SetNormalTexture(ResetToSetButton, TTEXTURESET.RESETTOSET, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
				_TextureFunc.SetPushedTexture(ResetToSetButton, TTEXTURESET.RESETTOSET, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				_TextureFunc.SetHighlightTexture(ResetToSetButton, TTEXTURESET.RESETTOSET, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				ResetToSetButton:SetFrameLevel(ResetToSetButton:GetFrameLevel() + 1);
				ResetToSetButton:SetPoint("LEFT", Label, "RIGHT", 0, 0);
				ResetToSetButton:SetScript("OnClick", _SideFunc.ResetToSetButton_OnClick);
				ResetToSetButton:SetScript("OnEnter", MT.GeneralOnEnter);
				ResetToSetButton:SetScript("OnLeave", MT.GeneralOnLeave);
				ResetToSetButton.Frame = Frame;
				ResetToSetButton.information = l10n.ResetToSetButton;
				objects.ResetToSetButton = ResetToSetButton;

				local TalentGroupSelect = CreateFrame('BUTTON', nil, Header);
				TalentGroupSelect:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
				_TextureFunc.SetNormalTexture(TalentGroupSelect, TTEXTURESET.DROP, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
				_TextureFunc.SetPushedTexture(TalentGroupSelect, TTEXTURESET.DROP, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				_TextureFunc.SetHighlightTexture(TalentGroupSelect, TTEXTURESET.DROP, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
				TalentGroupSelect:SetPoint("RIGHT", Label, "LEFT", 0, 0);
				TalentGroupSelect:SetScript("OnClick", _SideFunc.TalentGroupSelect_OnClick);
				TalentGroupSelect:SetScript("OnEnter", MT.GeneralOnEnter);
				TalentGroupSelect:SetScript("OnLeave", MT.GeneralOnLeave);
				TalentGroupSelect:Hide();
				TalentGroupSelect.Frame = Frame;
				TalentGroupSelect.information = l10n.TalentGroupSelect;
				objects.TalentGroupSelect = TalentGroupSelect;
			--	</Header>

			--	<Footer>
				--	Control
					local ExpandButton = CreateFrame('BUTTON', nil, Frame);
					ExpandButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
					_TextureFunc.SetNormalTexture(ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(ExpandButton, TTEXTURESET.EXPAND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					ExpandButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMRIGHT", -2, (TUISTYLE.FrameFooterYSize - TUISTYLE.ControlButtonSize) * 0.5);
					ExpandButton:Show();
					ExpandButton:SetScript("OnClick", _SideFunc.ExpandButton_OnClick);
					ExpandButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ExpandButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ExpandButton.Frame = Frame;
					ExpandButton.information = l10n.ExpandButton;
					objects.ExpandButton = ExpandButton;

					local ResetAllButton = CreateFrame('BUTTON', nil, Frame);
					ResetAllButton:SetSize(TUISTYLE.ControlButtonSize, TUISTYLE.ControlButtonSize);
					_TextureFunc.SetNormalTexture(ResetAllButton, TTEXTURESET.RESETALL, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(ResetAllButton, TTEXTURESET.RESETALL, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(ResetAllButton, TTEXTURESET.RESETALL, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					ResetAllButton:SetPoint("BOTTOMLEFT", Frame, "BOTTOMLEFT", 2, (TUISTYLE.FrameFooterYSize - TUISTYLE.ControlButtonSize) * 0.5);
					ResetAllButton:Show();
					ResetAllButton:SetScript("OnClick", _SideFunc.ResetAllButton_OnClick);
					ResetAllButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ResetAllButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ResetAllButton.Frame = Frame;
					ResetAllButton.information = l10n.ResetAllButton;
					objects.ResetAllButton = ResetAllButton;

					local CurPointsRemainingLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsRemainingLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
					CurPointsRemainingLabel:SetText(l10n.PointsRemaining);
					CurPointsRemainingLabel:SetPoint("CENTER", Frame, "BOTTOM", -15, TUISTYLE.FrameFooterYSize * 0.5);
					local PointsRemaining = Frame:CreateFontString(nil, "ARTWORK");
					PointsRemaining:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
					PointsRemaining:SetText("51");
					PointsRemaining:SetPoint("LEFT", CurPointsRemainingLabel, "RIGHT", 2, 0);
					CurPointsRemainingLabel:SetTextColor(0.5, 1.0, 1.0, 1.0);
					PointsRemaining:SetTextColor(0.5, 1.0, 1.0, 1.0);

					local PointsUsed = Frame:CreateFontString(nil, "ARTWORK");
					PointsUsed:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
					PointsUsed:SetText("0");
					PointsUsed:SetPoint("RIGHT", CurPointsRemainingLabel, "LEFT", -8, 0);
					local CurPointsUsedLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsUsedLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
					CurPointsUsedLabel:SetText(l10n.PointsUsed);
					CurPointsUsedLabel:SetPoint("RIGHT", PointsUsed, "LEFT", -2, 0);
					CurPointsUsedLabel:SetTextColor(0.5, 1.0, 0.5, 1.0);
					PointsUsed:SetTextColor(0.5, 1.0, 0.5, 1.0);

					local CurPointsReqLevelLabel = Frame:CreateFontString(nil, "ARTWORK");
					CurPointsReqLevelLabel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
					CurPointsReqLevelLabel:SetText(l10n.PointsToLevel);
					CurPointsReqLevelLabel:SetPoint("LEFT", PointsRemaining, "RIGHT", 8, 0);
					local PointsToLevel = Frame:CreateFontString(nil, "ARTWORK");
					PointsToLevel:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSize, TUISTYLE.FrameFontOutline);
					PointsToLevel:SetText("10");
					PointsToLevel:SetPoint("LEFT", CurPointsReqLevelLabel, "RIGHT", 2, 0);
					CurPointsReqLevelLabel:SetTextColor(1.0, 1.0, 0.5, 1.0);
					PointsToLevel:SetTextColor(1.0, 1.0, 0.5, 1.0);

					objects.CurPointsRemainingLabel = CurPointsRemainingLabel;
					objects.PointsRemaining = PointsRemaining;
					objects.CurPointsUsedLabel = CurPointsUsedLabel;
					objects.PointsUsed = PointsUsed;
					objects.CurPointsReqLevelLabel = CurPointsReqLevelLabel;
					objects.PointsToLevel = PointsToLevel;
				--

				--	Tree
					local TreeButtonsBar = CreateFrame('FRAME', nil, Frame);
					TreeButtonsBar:SetPoint("CENTER", Frame, "BOTTOM", 0, TUISTYLE.FrameFooterYSize + TUISTYLE.TreeFrameFooterYSize * 0.5);
					TreeButtonsBar:SetSize(TUISTYLE.TreeButtonXSize * 3 + TUISTYLE.TreeButtonGap * 2, TUISTYLE.TreeButtonYSize);
					Frame.TreeButtonsBar = TreeButtonsBar;
					local TreeButtons = {  };
					for TreeIndex = 1, 3 do
						local TreeButton = CreateFrame('BUTTON', nil, TreeButtonsBar);
						TreeButton:SetSize(TUISTYLE.TreeButtonXSize, TUISTYLE.TreeButtonYSize);
						_TextureFunc.SetNormalTexture(TreeButton, TTEXTURESET.TREEBUTTON.Normal);
						_TextureFunc.SetPushedTexture(TreeButton, TTEXTURESET.TREEBUTTON.Pushed);
						_TextureFunc.SetHighlightTexture(TreeButton, TTEXTURESET.TREEBUTTON.Highlight, TTEXTURESET.NORMAL_HIGHLIGHT);
						TreeButton:Show();
						TreeButton:SetScript("OnClick", _SideFunc.TreeButton_OnClick);
						TreeButton:SetScript("OnEnter", MT.GeneralOnEnter);
						TreeButton:SetScript("OnLeave", MT.GeneralOnLeave);
						TreeButton.id = TreeIndex;
						TreeButton.information = nil;
						local Title = TreeButton:CreateFontString(nil, "OVERLAY");
						Title:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, "OUTLINE");
						Title:SetTextColor(0.9, 0.9, 0.9, 1.0);
						Title:SetPoint("CENTER");
						Title:SetWidth(TUISTYLE.TreeButtonXSize);
						Title:SetMaxLines(1);
						TreeButton.Frame = Frame;
						TreeButton.Title = Title;
						TreeButtons[TreeIndex] = TreeButton;
					end
					TreeButtons[2]:SetPoint("CENTER", TreeButtonsBar, "CENTER", 0, 0);
					TreeButtons[1]:SetPoint("RIGHT", TreeButtons[2], "LEFT", -TUISTYLE.TreeButtonGap, 0);
					TreeButtons[3]:SetPoint("LEFT", TreeButtons[2], "RIGHT", TUISTYLE.TreeButtonGap, 0);
					Frame.TreeButtons = TreeButtons;

					local CurTreeIndicator = TreeButtonsBar:CreateTexture(nil, "OVERLAY");
					CurTreeIndicator:SetSize(TUISTYLE.TreeButtonXSize + 4, TUISTYLE.TreeButtonYSize + 4);
					CurTreeIndicator:SetBlendMode("ADD");
					_TextureFunc.SetTexture(CurTreeIndicator, TTEXTURESET.TREEBUTTON.Indicator, TTEXTURESET.SQUARE_HIGHLIGHT);
					CurTreeIndicator:Hide();
					TreeButtonsBar.CurTreeIndicator = CurTreeIndicator;
				--
			--	</Footer>

			--	<Side>
				local SideAnchorTop = CreateFrame('FRAME', nil, Frame);
				SideAnchorTop:SetWidth(1);
				Frame.SideAnchorTop = SideAnchorTop;
				SideAnchorTop:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorTop:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				--	Class
					local ClassButtons = {  };--DT.IndexToClass
					for index = 1, #DT.IndexToClass do
						local class = DT.IndexToClass[index];
						local ClassButton = CreateFrame('BUTTON', nil, SideAnchorTop);
						ClassButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
						local coord = CT.CLASS_ICON_TCOORDS[class];
						if coord then
							_TextureFunc.SetNormalTexture(ClassButton, TTEXTURESET.CLASS.Normal, nil, { coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 1 / 256, coord[4] - 1 / 256, });
							_TextureFunc.SetPushedTexture(ClassButton, TTEXTURESET.CLASS.Pushed, nil, { coord[1] + 1 / 256, coord[2] - 1 / 256, coord[3] + 0 / 256, coord[4] - 2 / 256, }, TTEXTURESET.CONTROL.PUSHED_COLOR);
						else
							_TextureFunc.SetNormalTexture(ClassButton, TTEXTURESET.CLASS.Normal, nil, { 0.75, 1.00, 0.75, 1.00, });
							_TextureFunc.SetPushedTexture(ClassButton, TTEXTURESET.CLASS.Pushed, nil, { 0.75, 1.00, 0.75, 1.00, }, TTEXTURESET.CONTROL.PUSHED_COLOR);
						end
						_TextureFunc.SetHighlightTexture(ClassButton, TTEXTURESET.CLASS.Highlight);
						ClassButton:SetPoint("TOPLEFT", SideAnchorTop, "TOPLEFT", 0, -(TUISTYLE.SideButtonSize + TUISTYLE.SideButtonGap) * (index - 1));
						ClassButton:Show();
						ClassButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
						ClassButton:SetScript("OnClick", _SideFunc.ClassButton_OnClick);
						ClassButton:SetScript("OnEnter", MT.GeneralOnEnter);
						ClassButton:SetScript("OnLeave", MT.GeneralOnLeave);
						ClassButton.id = index;
						ClassButton.class = class;
						ClassButton.Frame = Frame;
						ClassButton.information = "|c" .. CT.RAID_CLASS_COLORS[class].colorStr .. l10n.CLASS[class] .. "|r" .. l10n.ClassButton;
						ClassButtons[index] = ClassButton;
					end
					Frame.ClassButtons = ClassButtons;

					local CurClassIndicator = Frame:CreateTexture(nil, "OVERLAY");
					CurClassIndicator:SetSize(TUISTYLE.CurClassIndicatorSize, TUISTYLE.CurClassIndicatorSize);
					CurClassIndicator:SetBlendMode("ADD");
					_TextureFunc.SetTexture(CurClassIndicator, TTEXTURESET.CLASS.Indicator);
					CurClassIndicator:Show();
					Frame.objects.CurClassIndicator = CurClassIndicator;
				--

				local SideAnchorBottom = CreateFrame('FRAME', nil, Frame);
				SideAnchorBottom:SetWidth(1);
				Frame.SideAnchorBottom = SideAnchorBottom;
				SideAnchorBottom:SetPoint("TOPLEFT", Frame, "TOPRIGHT", 2, 0);
				SideAnchorBottom:SetPoint("BOTTOMLEFT", Frame, "BOTTOMRIGHT", 2, 0);
				--	Control
					local SpellListButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SpellListButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(SpellListButton, TTEXTURESET.SPELLTAB, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(SpellListButton, TTEXTURESET.SPELLTAB, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(SpellListButton, TTEXTURESET.SPELLTAB, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					SpellListButton:SetPoint("BOTTOMLEFT", SideAnchorBottom, "BOTTOMLEFT", 0, 0);
					SpellListButton:Show();
					SpellListButton:SetScript("OnClick", _SideFunc.SpellListButton_OnClick);
					SpellListButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SpellListButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SpellListButton.Frame = Frame;
					SpellListButton.information = l10n.SpellListButton;
					Frame.SpellListButton = SpellListButton;

					local ApplyTalentsButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ApplyTalentsButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(ApplyTalentsButton, TTEXTURESET.APPLY, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(ApplyTalentsButton, TTEXTURESET.APPLY, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(ApplyTalentsButton, TTEXTURESET.APPLY, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetDisabledTexture(ApplyTalentsButton, TTEXTURESET.APPLY, nil, nil, TTEXTURESET.CONTROL.DISABLED_COLOR);
					ApplyTalentsButton:SetPoint("BOTTOM", SpellListButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ApplyTalentsButton:Show();
					ApplyTalentsButton:SetScript("OnClick", _SideFunc.ApplyTalentsButton_OnClick);
					ApplyTalentsButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ApplyTalentsButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ApplyTalentsButton.Frame = Frame;
					ApplyTalentsButton.information = l10n.ApplyTalentsButton;
					Frame.ApplyTalentsButton = ApplyTalentsButton;
					local ApplyTalentsButtonProgress = ApplyTalentsButton:CreateFontString(nil, "ARTWORK");
					ApplyTalentsButtonProgress:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeMedium, TUISTYLE.FrameFontOutline);
					ApplyTalentsButtonProgress:SetPoint("LEFT", ApplyTalentsButton, "RIGHT", 4, 0);
					ApplyTalentsButton.Progress = ApplyTalentsButtonProgress;
					Frame.ApplyTalentsProgress = ApplyTalentsButtonProgress;

					local SettingButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SettingButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(SettingButton, TTEXTURESET.SETTING, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(SettingButton, TTEXTURESET.SETTING, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(SettingButton, TTEXTURESET.SETTING, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					SettingButton:SetPoint("BOTTOM", ApplyTalentsButton, "TOP", 0, TUISTYLE.SideButtonGap);
					SettingButton:Show();
					SettingButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SettingButton:SetScript("OnClick", _SideFunc.SettingButton_OnClick);
					SettingButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SettingButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SettingButton.Frame = Frame;
					SettingButton.information = l10n.SettingButton;
					Frame.SettingButton = SettingButton;

					local EditBox = CreateFrame('EDITBOX', nil, Frame);
					EditBox:SetSize(TUISTYLE.EditBoxXSize, TUISTYLE.EditBoxYSize);
					EditBox:SetFont(TUISTYLE.FrameFont, TUISTYLE.FrameFontSizeLarge, TUISTYLE.FrameFontOutline);
					EditBox:SetAutoFocus(false);
					EditBox:SetJustifyH("LEFT");
					EditBox:Hide();
					EditBox:EnableMouse(true);
					EditBox:SetScript("OnEnterPressed", _SideFunc.EditBox_OnEnterPressed);
					EditBox:SetScript("OnEscapePressed", _SideFunc.EditBox_OnEscapePressed);
					EditBox:SetScript("OnShow", _SideFunc.EditBox_OnShow);
					EditBox:SetScript("OnHide", _SideFunc.EditBox_OnHide);
					EditBox:SetScript("OnChar", _SideFunc.EditBox_OnChar);
					EditBox.Frame = Frame;
					Frame.EditBox = EditBox;
					local Texture = EditBox:CreateTexture(nil, "ARTWORK");
					Texture:SetPoint("TOPLEFT");
					Texture:SetPoint("BOTTOMRIGHT");
					Texture:SetTexture("Interface\\Buttons\\buttonhilight-square");
					Texture:SetTexCoord(0.25, 0.75, 0.25, 0.75);
					Texture:SetAlpha(0.36);
					Texture:SetVertexColor(1.0, 1.0, 1.0);
					EditBox.Texture = Texture;
					local EditBoxOKayButton = CreateFrame('BUTTON', nil, EditBox);
					EditBoxOKayButton:SetSize(TUISTYLE.EditBoxYSize, TUISTYLE.EditBoxYSize);
					_TextureFunc.SetNormalTexture(EditBoxOKayButton, TTEXTURESET.EDIT_OKAY, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(EditBoxOKayButton, TTEXTURESET.EDIT_OKAY, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(EditBoxOKayButton, TTEXTURESET.EDIT_OKAY, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					EditBoxOKayButton:SetPoint("LEFT", EditBox, "RIGHT", 0, 4);
					EditBoxOKayButton:Show();
					EditBoxOKayButton:SetScript("OnClick", _SideFunc.EditBoxOKayButton_OnClick);
					EditBoxOKayButton:SetScript("OnEnter", MT.GeneralOnEnter);
					EditBoxOKayButton:SetScript("OnLeave", MT.GeneralOnLeave);
					EditBoxOKayButton.EditBox = EditBox;
					EditBoxOKayButton.information = l10n.EditBoxOKayButton;
					EditBox.OKayButton = EditBoxOKayButton;

					local ImportButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ImportButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(ImportButton, TTEXTURESET.IMPORT, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(ImportButton, TTEXTURESET.IMPORT, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(ImportButton, TTEXTURESET.IMPORT, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					ImportButton:SetPoint("BOTTOM", SettingButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ImportButton:Show();
					ImportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					ImportButton:SetScript("OnClick", _SideFunc.ImportButton_OnClick);
					ImportButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ImportButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ImportButton.Frame = Frame;
					ImportButton.information = l10n.ImportButton;
					Frame.ImportButton = ImportButton;

					local ExportButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					ExportButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(ExportButton, TTEXTURESET.EXPORT, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(ExportButton, TTEXTURESET.EXPORT, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(ExportButton, TTEXTURESET.EXPORT, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					ExportButton:SetPoint("BOTTOM", ImportButton, "TOP", 0, TUISTYLE.SideButtonGap);
					ExportButton:Show();
					ExportButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					ExportButton:SetScript("OnClick", _SideFunc.ExportButton_OnClick);
					ExportButton:SetScript("OnEnter", MT.GeneralOnEnter);
					ExportButton:SetScript("OnLeave", MT.GeneralOnLeave);
					ExportButton.Frame = Frame;
					ExportButton.information = l10n.ExportButton;
					Frame.ExportButton = ExportButton;

					local SaveButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SaveButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(SaveButton, TTEXTURESET.SAVE, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(SaveButton, TTEXTURESET.SAVE, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(SaveButton, TTEXTURESET.SAVE, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					SaveButton:SetPoint("BOTTOM", ExportButton, "TOP", 0, TUISTYLE.SideButtonGap);
					SaveButton:Show();
					SaveButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SaveButton:SetScript("OnClick", _SideFunc.SaveButton_OnClick);
					SaveButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SaveButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SaveButton.Frame = Frame;
					SaveButton.information = l10n.SaveButton;
					Frame.SaveButton = SaveButton;

					local SendButton = CreateFrame('BUTTON', nil, SideAnchorBottom);
					SendButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(SendButton, TTEXTURESET.SEND, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(SendButton, TTEXTURESET.SEND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(SendButton, TTEXTURESET.SEND, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					SendButton:SetPoint("BOTTOM", SaveButton, "TOP", 0, TUISTYLE.SideButtonGap);
					SendButton:Show();
					SendButton:RegisterForClicks("LeftButtonUp", "RightButtonUp");
					SendButton:SetScript("OnClick", _SideFunc.SendButton_OnClick);
					SendButton:SetScript("OnEnter", MT.GeneralOnEnter);
					SendButton:SetScript("OnLeave", MT.GeneralOnLeave);
					SendButton.Frame = Frame;
					SendButton.information = l10n.SendButton;
					Frame.SendButton = SendButton;
				--

				--	Left
					local EquipmentFrameButton = CreateFrame('BUTTON', nil, Frame);
					EquipmentFrameButton:SetSize(TUISTYLE.SideButtonSize, TUISTYLE.SideButtonSize);
					_TextureFunc.SetNormalTexture(EquipmentFrameButton, TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, TTEXTURESET.CONTROL.NORMAL_COLOR);
					_TextureFunc.SetPushedTexture(EquipmentFrameButton, TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					_TextureFunc.SetHighlightTexture(EquipmentFrameButton, TTEXTURESET.EQUIPMENTTOGGLE, nil, nil, TTEXTURESET.CONTROL.PUSHED_COLOR);
					EquipmentFrameButton:SetPoint("BOTTOMRIGHT", Frame, "BOTTOMLEFT", -2, 0);
					EquipmentFrameButton:Hide();
					EquipmentFrameButton:SetScript("OnClick", _SideFunc.EquipmentFrameButton_OnClick);
					EquipmentFrameButton:SetScript("OnEnter", MT.GeneralOnEnter);
					EquipmentFrameButton:SetScript("OnLeave", MT.GeneralOnLeave);
					EquipmentFrameButton.information = l10n.EquipmentListButton;
					EquipmentFrameButton.Frame = Frame;
					Frame.objects.EquipmentFrameButton = EquipmentFrameButton;
				--
			--	</Side>

		end
	--	Frame
		local _FrameFunc = {  };
		function _FrameFunc.OnSizeChanged(Frame, width, height)
			width = Frame:GetWidth();
			height = Frame:GetHeight();
			Frame:SetClampRectInsets(width * 0.75, -width * 0.75, -height * 0.75, height * 0.75);
			--	Background 0,512;0,360
			local ratio = height / width;
			if ratio > 360 / 512 then
				Frame.Background:SetTexCoord(0.5 - 180 / 512 / ratio, 0.5 + 180 / 512 / ratio, 0.0, 360 / 512);
			elseif ratio < 360 / 512 then
				Frame.Background:SetTexCoord(0.0, 1.0, 180 / 512 - ratio / 2, 180 / 512 + ratio / 2);
			else
				Frame.Background:SetTexCoord(0.0, 1.0, 0.0, 360 / 512);
			end
			MT.UI.TreeFrameUpdateSize(Frame, width, height);
			for _, obj in next, Frame.objects do
				obj:SetScale(Frame.TreeFrameScale);
			end
			Frame.TreeButtonsBar:SetScale(Frame.TreeFrameScale);
			Frame.SideAnchorTop:SetScale(Frame.TreeFrameScale);
			Frame.SideAnchorBottom:SetScale(Frame.TreeFrameScale);
			Frame.SpellListFrameContainer:SetWidth(TUISTYLE.SpellListFrameXSize * Frame.TreeFrameScale);
			Frame.SpellListFrame:SetScale(Frame.TreeFrameScale);
			Frame.SpellListFrame:SetHeight(Frame:GetHeight() / Frame.TreeFrameScale);
			-- Frame.EquipmentFrameContainer:SetWidth(TUISTYLE.EquipmentFrameXSize * Frame.TreeFrameScale);
			-- Frame.EquipmentContainer:SetScale(Frame.TreeFrameScale);
			-- Frame.EquipmentContainer:SetHeight(Frame:GetHeight() / Frame.TreeFrameScale);
			-- if VT.__support_glyph then
			-- 	Frame.GlyphContainer:SetScale(Frame.TreeFrameScale);
			-- end
			MT.UI.EquipmentFrameContainerResize(Frame.EquipmentFrameContainer);
		end
		function _FrameFunc.OnMouseDown(Frame, button)
			if button == "LeftButton" then
				if VT.SET.resizable_border then
					if not Frame.isMoving and not Frame.isResizing and Frame:IsMovable() then
						local x, y = GetCursorPosition();
						local s = Frame:GetEffectiveScale();
						x = x / s;
						y = y / s;
						local bottom = Frame:GetBottom();
						local top = Frame:GetTop();
						local left = Frame:GetLeft();
						local right = Frame:GetRight();

						if x < left + TUISTYLE.FrameBorderSize then
							if y < bottom + TUISTYLE.FrameBorderSize then
								Frame:StartSizing("BOTTOMLEFT");
							elseif y > top - TUISTYLE.FrameBorderSize then
								Frame:StartSizing("TOPLEFT");
							else
								Frame:StartSizing("LEFT");
							end
							Frame.isResizing = true;
						elseif x > right - TUISTYLE.FrameBorderSize then
							if y < bottom + TUISTYLE.FrameBorderSize then
								Frame:StartSizing("BOTTOMRIGHT");
							elseif y > top - TUISTYLE.FrameBorderSize then
								Frame:StartSizing("TOPRIGHT");
							else
								Frame:StartSizing("RIGHT");
							end
							Frame.isResizing = true;
						elseif y < bottom + TUISTYLE.FrameBorderSize then
							Frame:StartSizing("BOTTOM");
							Frame.isResizing = true;
						elseif y > top - TUISTYLE.FrameBorderSize then
							Frame:StartSizing("TOP");
							Frame.isResizing = true;
						else
							Frame:StartMoving();
							Frame.isMoving = true;
						end
					end
				else
					Frame:StartMoving();
					Frame.isMoving = true;
				end
			end
		end
		function _FrameFunc.OnMouseUp(Frame, button)
			if button == "LeftButton" then
				if Frame.isMoving then
					Frame:StopMovingOrSizing()
					Frame.isMoving = false
				elseif Frame.isResizing then
					Frame:StopMovingOrSizing()
					Frame.isResizing = false
				end
			end
		end
		function _FrameFunc.OnShow(Frame)
			_FrameFunc.OnSizeChanged(Frame, Frame:GetWidth(), Frame:GetHeight());
			Frame.ApplyTalentsProgress:SetText("");
		end
		function _FrameFunc.OnHide(Frame)
			MT.UI.ReleaseFrame(Frame.id);
			if Frame.isMoving then
				Frame:StopMovingOrSizing();
				Frame.isMoving = false;
			end
			if Frame.isResizing then
				Frame:StopMovingOrSizing();
				Frame.isResizing = false;
			end
			if VT.TooltipFrame.OwnerFrame == Frame then
				VT.TooltipFrame:Hide();
			end
		end

		local temp_id = 0;
		function MT.UI.CreateFrame()
			temp_id = temp_id + 1;
			local Frame = CreateFrame('FRAME', nil, UIParent);
			Frame.id = temp_id;

			Frame:SetPoint("CENTER");
			if Frame.SetResizeBounds ~= nil then
				Frame:SetResizeBounds(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1, 9999, 9999);
			else
				Frame:SetMinResize(TUISTYLE.FrameXSizeMin_Style1, TUISTYLE.FrameYSizeMin_Style1);
			end
			Frame:SetFrameStrata("HIGH");
			VT.__dep.uireimp._SetSimpleBackdrop(Frame, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);

			if VT.SET.style == 1 then
				Frame:SetSize(TUISTYLE.FrameXSizeDefault_Style1, TUISTYLE.FrameYSizeDefault_Style1);
			elseif VT.SET.style == 2 then
				Frame:SetSize(TUISTYLE.FrameXSizeDefault_Style2, TUISTYLE.FrameYSizeDefault_Style2);
			end

			local Background = Frame:CreateTexture(nil, "BORDER");
			Background:SetAlpha(0.6);
			Background:SetPoint("BOTTOMLEFT");
			Background:SetPoint("TOPRIGHT");
			Frame.Background = Background;

			Frame.TreeFrames = MT.UI.CreateTreeFrames(Frame);
			Frame.SpellListFrame, Frame.SpellListFrameContainer = MT.UI.CreateSpellListFrame(Frame);
			Frame.EquipmentFrameContainer, Frame.EquipmentContainer, Frame.GlyphContainer = MT.UI.CreateEquipmentFrame(Frame);

			MT.UI.CreateFrameSubObject(Frame);

			Frame:EnableMouse(true);
			Frame:SetMovable(true);
			Frame:SetResizable(true);
			Frame:SetClampedToScreen(true);

			Frame:Hide();

			Frame:SetScript("OnMouseDown", _FrameFunc.OnMouseDown);
			Frame:SetScript("OnMouseUp", _FrameFunc.OnMouseUp);
			Frame:SetScript("OnSizeChanged", _FrameFunc.OnSizeChanged);
			Frame:SetScript("OnShow", _FrameFunc.OnShow);
			Frame:SetScript("OnHide", _FrameFunc.OnHide);

			Frame.CurTreeIndex = 1;
			MT.UI.FrameSetName(Frame, nil);
			MT.UI.FrameSetLevel(Frame, nil);
			MT.UI.FrameSetClass(Frame, CT.SELFCLASS);
			MT.UI.FrameSetTalent(Frame, nil);
			Frame.initialized = false;

			MT.UI.FrameSetStyle(Frame, VT.SET.style);

			return Frame;
		end

		function MT.UI.GetFrame(FrameID)
			local Frames = VT.Frames;
			local Frame = nil;
			if FrameID ~= nil then
				if FrameID <= temp_id then
					for i = 1, Frames.num do
						if Frames[i].id == FrameID then
							if i <= Frames.used then
								Frame = Frames[i];
							elseif i == Frames.used + 1 then
								Frame = Frames[i];
								Frames.used = i;
							else
								Frame = tremove(Frames, i);
								Frames.used = Frames.used + 1;
								tinsert(Frames, Frames.used, Frame);
							end
							break;
						end
					end
				end
			end
			if Frame == nil then
				if Frames.num > Frames.used then
					Frames.used = Frames.used + 1;
					Frame = Frames[Frames.used];
				else
					Frame = MT.UI.CreateFrame();
					Frames.num = Frames.num + 1;
					Frames[Frames.num] = Frame;
					Frames.used = Frames.num;
				end
			end
			Frame:Show();
			return Frame;
		end
		function MT.UI.GetLastFrame()
			local Frames = VT.Frames;
			return Frames.used > 0 and Frames[Frames.used] or nil;
		end
		function MT.UI.ReleaseFrame(FrameID)
			local Frames = VT.Frames;
			if Frames.used <= 0 then
				return;
			end
			for i = Frames.used, 1, -1 do
				local Frame = Frames[i];
				if FrameID == Frame.id then
					if i ~= Frames.used then
						tremove(Frames, i);
						tinsert(Frames, Frames.used, Frame);
					end
					Frames.used = Frames.used - 1;
					if Frame:IsShown() then
						Frame:Hide();
					end
					MT.UI.FrameReleaseBinding(Frame);
					MT.UI.FrameReset(Frame);
					break;
				end
			end
		end
		function MT.UI.ReleaseAllFramesButOne(id)
			local Frames = VT.Frames;
			for i = Frames.used, 1, -1 do
				local Frame = Frames[i];
				if Frame.id ~= id then
					Frame:Hide();
				end
			end
			if Frames.used == 1 then
				MT.UI.SetFrameID(Frames[1], 1);
			elseif Frames.used > 1 then
				MT.Debug("Emu Warn >> RelAllButOne", "USED NEQ 1, IS", Frames.used);
			end
		end
		function MT.UI.IsAllFramesSameStyle()
			local style = -1;
			local Frames = VT.Frames;
			for i = 1, Frames.used do
				local Frame = Frames[i];
				if Frame.style ~= style then
					if style == -1 then
						style = Frame.style;
					else
						style = nil;
						break;
					end
				end
			end
			return style;
		end
		function MT.UI.SetFrameID(Frame, FrameID)
			if Frame.id == FrameID then
				return;
			end
			local Frames = VT.Frames;
			for i = 1, Frames.num do
				if Frames[i].id == FrameID then
					Frame.id, Frames[i].id = FrameID, Frame.id;
					break;
				end
			end
		end
		function MT.UI.HideFrame(FrameID)
			if type(FrameID) == 'table' then
				FrameID:Hide();
			elseif type(FrameID) == 'number' then
				local Frames = VT.Frames;
				for i = Frames.used, 1, -1 do
					local Frame = Frames[i];
					if Frame.id == FrameID then
						Frame:Hide();
						break;
					end
				end
			end
		end
		function MT.UI.FrameReleaseBinding(Frame)
			if Frame ~= nil then
				if type(Frame) == 'number' then
					Frame = MT.UI.GetFrame(Frame);
					if Frame == nil then
						return;
					end
				end
				for Key, Frames in next, VT.NameBindingFrame do
					local num = #Frames;
					if num == 2 then
						if Frame == Frames[2] then
							VT.NameBindingFrame[Key] = nil;
						end
					elseif num > 2 then
						for i = num, 2, -1 do
							if Frame == Frames[i] then
								tremove(Frames, i);
								num = num - 1;
							end
						end
						if num < 2 then
							VT.NameBindingFrame[Key] = nil;
						end
					else
						VT.NameBindingFrame[Key] = nil;
					end
				end
			end
		end
		function MT.UI.FrameSetBinding(Frame, name)
			for Key, Frames in next, VT.NameBindingFrame do
				if Key ~= name then
					local num = #Frames;
					if num == 1 then
						if Frame == Frames[1] then
							VT.NameBindingFrame[Key] = nil;
						end
					elseif num > 1 then
						for i = num, 1, -1 do
							if Frame == Frames[i] then
								tremove(Frames, i);
								num = num - 1;
							end
						end
						if num <= 0 then
							VT.NameBindingFrame[Key] = nil;
						end
					else
						VT.NameBindingFrame[Key] = nil;
					end
				end
			end
			local Frames = VT.NameBindingFrame[name];
			if Frames ~= nil then
				local num = #Frames;
				if num >= 1 then
					for i = 1, num do
						if Frame == Frames[i] then
							return;
						end
					end
					Frames[num + 1] = Frame;
				else
					Frames[1] = Frame;
				end
			else
				VT.NameBindingFrame[name] = { Frame, };
			end
		end
		function MT.UI.FrameGetNameBinding(name)
			return VT.NameBindingFrame[name];
		end
		function MT.UI.IteratorFrames(func, ...)
			local Frames = VT.Frames;
			for i = Frames.used, 1, -1 do
				func(Frames[i], ...);
			end
		end
	--

	MT.RegisterOnInit('UI', function(LoggedIn)
		if CT.LOCALE == 'zhCN' or CT.LOCALE == 'zhTW' then
			TUISTYLE.FrameFontSizeSmall = TUISTYLE.FrameFontSizeMedium;
		end
		TUISTYLE.TreeFrameXSizeSingle = TUISTYLE.TreeNodeSize * DT.MAX_NUM_COL + TUISTYLE.TreeNodeXGap * (DT.MAX_NUM_COL - 1) + TUISTYLE.TreeNodeXToBorder * 2;
		TUISTYLE.TreeFrameXSizeTriple = TUISTYLE.TreeFrameXSizeSingle * 3;
		TUISTYLE.TreeFrameYSize = TUISTYLE.TreeFrameHeaderYSize + TUISTYLE.TreeNodeYToTop + TUISTYLE.TreeNodeSize * DT.MAX_NUM_TIER + TUISTYLE.TreeNodeYGap * (DT.MAX_NUM_TIER - 1) + TUISTYLE.TreeNodeYToBottom+ TUISTYLE.TreeFrameFooterYSize;
		TUISTYLE.FrameXSizeDefault_Style1 = TUISTYLE.TreeFrameXSizeTriple + TUISTYLE.TreeFrameXToBorder * 2;
		TUISTYLE.FrameYSizeDefault_Style1 = TUISTYLE.TreeFrameYSize + TUISTYLE.TreeFrameYToBorder * 2 + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize;
		TUISTYLE.FrameXSizeDefault_Style2 = TUISTYLE.TreeFrameXSizeSingle + TUISTYLE.TreeFrameXToBorder * 2;
		TUISTYLE.FrameYSizeDefault_Style2 = TUISTYLE.TreeFrameYSize + TUISTYLE.TreeFrameYToBorder * 2 + TUISTYLE.FrameHeaderYSize + TUISTYLE.FrameFooterYSize;
		TUISTYLE.EquipmentContainerYSize = TUISTYLE.EquipmentNodeYToBorder + TUISTYLE.EquipmentNodeSize * 10 + TUISTYLE.EquipmentNodeGap * 11 + TUISTYLE.EquipmentNodeYToBorder;
		VT.TooltipFrame = MT.UI.CreateTooltipFrame();
	end);
	MT.RegisterOnLogin('UI', function(LoggedIn)
	end);

-->
