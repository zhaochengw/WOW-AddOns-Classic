--[[--
	alex/ALA	Please Keep WOW Addon open-source & Reduce barriers for others.
	复用代码请在显著位置标注来源【ALA@网易有爱】
	喜欢加密和乱码的亲，请ALT+F4
--]]--
local ADDON, NS = ...;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
__ala_meta__.misc = NS;
local _G = _G;

do
	if NS.__fenv == nil then
		NS.__fenv = setmetatable({  },
				{
					__index = _G,
					__newindex = function(t, key, value)
						rawset(t, key, value);
						print("ain assign global", key, value);
						return value;
					end,
				}
			);
	end
	setfenv(1, NS.__fenv);
end

local pGUID = UnitGUID('player');
local _EventHandler = CreateFrame("FRAME");
NS.realmID = GetRealmID();
NS.pGUID = pGUID;


local function PLAYER_ENTERING_WORLD()
	_EventHandler:UnregisterEvent("PLAYER_ENTERING_WORLD");
	if alaMiscSV == nil then
		_G.alaMiscSV = {
			instance_timer_sv = {
				enabled = true,
				locked = false,
				realm_timer = {  };
				char_timer = {  },
				pos = { "CENTER", "UIParent", "CENTER", 320, -160, },
			},
			target_warn_sv = {
				[pGUID] = { on = false, locked = false, },
			},
			honor_sv = {
				rankText = false,
				honorKillColorName = true,
				honorKillDetail = true,
			},
		};
	else
		alaMiscSV.target_warn_sv[pGUID] = alaMiscSV.target_warn_sv[pGUID] or { on = false, locked = false, };
		alaMiscSV.WA = alaMiscSV.WA or {  };
		--	instance_timer_sv	processed by itself
	end
	if _G.InstLockSV then
		alaMiscSV.instance_timer_sv = _G.InstLockSV;
	else
		_G.InstLockSV = alaMiscSV.instance_timer_sv;
	end
	alaMiscSV._version = 20200713.0;
	-- if GetLocale() == 'zhCN' or GetLocale == 'zhTW' then
	-- 	LOOT_PROMOTE = "提升为物品分配者";
	-- end
	--
	if _G.__ala_meta__.wa then
		_G.__ala_meta__.wa.WA_WrapSetSubPath("alaMisc");
	end
end

_EventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
_EventHandler:SetScript("OnEvent", PLAYER_ENTERING_WORLD);

local function alam_GetConfig(misc, key)
	if misc == "instance_timer" then
		return NS.InstanceLockeddownTimer.GetConfig(key);
		-- return alaMiscSV.instance_timer_sv.set[pGUID][key];
	elseif misc == "target_warn" then
		return alaMiscSV.target_warn_sv[pGUID][key];
	elseif misc == "honor" then
		return alaMiscSV.honor_sv[key];
	end
end

if select(2, GetAddOnInfo('\33\33\33\49\54\51\85\73\33\33\33')) then
	_G._163_ALAMISC_GETCONFIG = alam_GetConfig;
end
