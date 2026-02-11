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
	local type = type;
	local next = next;
	local tinsert = table.insert;
	local tremove = table.remove;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local UIParent = UIParent;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-Frame');
-->		predef
-->		Frame
	MT._FrameFunc = {  };
	function MT._FrameFunc.OnSizeChanged(Frame, width, height)
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
			obj:SetScale(Frame.ObjectScale);
		end
		Frame.TreeButtonsBar:SetScale(Frame.ObjectScale);
		Frame.SideAnchorTop:SetScale(Frame.ObjectScale);
		Frame.SideAnchorBottom:SetScale(Frame.ObjectScale);
		Frame.SpellListFrameContainer:SetWidth(CT.TUISTYLE.SpellListFrameXSize * Frame.ObjectScale);
		Frame.SpellListFrame:SetScale(Frame.ObjectScale);
		Frame.SpellListFrame:SetHeight(Frame:GetHeight() / Frame.ObjectScale);
		-- Frame.EquipmentFrameContainer:SetWidth(CT.TUISTYLE.EquipmentFrameXSize * Frame.ObjectScale);
		-- Frame.EquipmentContainer:SetScale(Frame.ObjectScale);
		-- Frame.EquipmentContainer:SetHeight(Frame:GetHeight() / Frame.ObjectScale);
		-- if VT.__support_glyph then
		-- 	Frame.GlyphContainer:SetScale(Frame.ObjectScale);
		-- end
		MT.UI.EquipmentFrameContainerResize(Frame.EquipmentFrameContainer);
	end
	function MT._FrameFunc.OnMouseDown(Frame, button)
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

					if x < left + CT.TUISTYLE.FrameBorderSize then
						if y < bottom + CT.TUISTYLE.FrameBorderSize then
							Frame:StartSizing("BOTTOMLEFT");
						elseif y > top - CT.TUISTYLE.FrameBorderSize then
							Frame:StartSizing("TOPLEFT");
						else
							Frame:StartSizing("LEFT");
						end
						Frame.isResizing = true;
					elseif x > right - CT.TUISTYLE.FrameBorderSize then
						if y < bottom + CT.TUISTYLE.FrameBorderSize then
							Frame:StartSizing("BOTTOMRIGHT");
						elseif y > top - CT.TUISTYLE.FrameBorderSize then
							Frame:StartSizing("TOPRIGHT");
						else
							Frame:StartSizing("RIGHT");
						end
						Frame.isResizing = true;
					elseif y < bottom + CT.TUISTYLE.FrameBorderSize then
						Frame:StartSizing("BOTTOM");
						Frame.isResizing = true;
					elseif y > top - CT.TUISTYLE.FrameBorderSize then
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
	function MT._FrameFunc.OnMouseUp(Frame, button)
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
	function MT._FrameFunc.OnShow(Frame)
		MT._FrameFunc.OnSizeChanged(Frame, Frame:GetWidth(), Frame:GetHeight());
		Frame.ApplyTalentsProgress:SetText("");
	end
	function MT._FrameFunc.OnHide(Frame)
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
			Frame:SetResizeBounds(CT.TUISTYLE.FrameXSizeMin_Style1, CT.TUISTYLE.FrameYSizeMin_Style1, 9999, 9999);
		else
			Frame:SetMinResize(CT.TUISTYLE.FrameXSizeMin_Style1, CT.TUISTYLE.FrameYSizeMin_Style1);
		end
		Frame:SetFrameStrata("HIGH");
		VT.__dep.uireimp._SetSimpleBackdrop(Frame, 0, 1, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, 1.0);

		if VT.SET.style == 1 then
			Frame:SetSize(CT.TUISTYLE.FrameXSizeDefault_Style1, CT.TUISTYLE.FrameYSizeDefault_Style1);
		elseif VT.SET.style == 2 then
			Frame:SetSize(CT.TUISTYLE.FrameXSizeDefault_Style2, CT.TUISTYLE.FrameYSizeDefault_Style2);
		end

		local Background = Frame:CreateTexture(nil, "BORDER");
		Background:SetAlpha(0.6);
		Background:SetPoint("BOTTOMLEFT");
		Background:SetPoint("TOPRIGHT");
		Frame.Background = Background;

		Frame.TreeFrames = MT.UI.CreateTreeFrames(Frame);
		Frame.SpecSpellFrame = MT.UI.CreateSpecSpellFrame(Frame);
		Frame.SpellListFrame, Frame.SpellListFrameContainer = MT.UI.CreateSpellListFrame(Frame);
		Frame.EquipmentFrameContainer, Frame.EquipmentContainer, Frame.GlyphContainer = MT.UI.CreateEquipmentFrame(Frame);

		MT.UI.CreateFrameSubObject(Frame);

		Frame:EnableMouse(true);
		Frame:SetMovable(true);
		Frame:SetResizable(true);
		Frame:SetClampedToScreen(true);

		Frame:Hide();

		Frame.CurTreeIndex = 1;
		MT.UI.FrameSetStyle(Frame, VT.SET.style);

		Frame:SetScript("OnMouseDown", MT._FrameFunc.OnMouseDown);
		Frame:SetScript("OnMouseUp", MT._FrameFunc.OnMouseUp);
		Frame:SetScript("OnSizeChanged", MT._FrameFunc.OnSizeChanged);
		Frame:SetScript("OnShow", MT._FrameFunc.OnShow);
		Frame:SetScript("OnHide", MT._FrameFunc.OnHide);

		MT.UI.FrameSetName(Frame, nil);
		MT.UI.FrameSetLevel(Frame, nil);
		MT.UI.FrameSetClass(Frame, CT.SELFCLASS);
		MT.UI.FrameSetTalent(Frame, nil);
		Frame.initialized = false;

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

-->
