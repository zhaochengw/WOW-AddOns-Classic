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
	local unpack = unpack;
	local rawset = rawset;
	local setmetatable = setmetatable;

-->
	local l10n = CT.l10n;

-->
MT.BuildEnv('UI-Shared');
-->		predef
-->		Shared
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
	MT._TextureFunc = {  };
	function MT._TextureFunc.CreateFlatBorder(Node, width)
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
	function MT._TextureFunc._SetTexture(Texture, Path, Coord, Color, Blend)
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
	function MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend)
		if def then
			return MT._TextureFunc._SetTexture(Texture, def.Path or Path, def.Coord or Coord, def.Color or Color, def.Blend or Blend);
		else
			return MT._TextureFunc._SetTexture(Texture, Path, Coord, Color, Blend);
		end
	end
	function MT._TextureFunc.SetNormalTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetNormalTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetNormalTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function MT._TextureFunc.SetPushedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetPushedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetPushedTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function MT._TextureFunc.SetDisabledTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetDisabledTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "ARTWORK");
			Texture:SetAllPoints();
			Widget:SetDisabledTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function MT._TextureFunc.SetHighlightTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetHighlightTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "HIGHLIGHT");
			Texture:SetAllPoints();
			Widget:SetHighlightTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function MT._TextureFunc.SetCheckedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetCheckedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "OVERLAY");
			Texture:SetAllPoints();
			Widget:SetCheckedTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end
	function MT._TextureFunc.SetDisabledCheckedTexture(Widget, def, Path, Coord, Color, Blend)
		local Texture = Widget:GetDisabledCheckedTexture();
		if Texture == nil then
			Texture = Widget:CreateTexture(nil, "OVERLAY");
			Texture:SetAllPoints();
			Widget:SetDisabledCheckedTexture(Texture);
		end
		return MT._TextureFunc.SetTexture(Texture, def, Path, Coord, Color, Blend);
	end

-->
