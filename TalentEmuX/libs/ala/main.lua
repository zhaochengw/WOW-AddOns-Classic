--[[--
	by ALA
--]]--
local __version = 241201.0;
local GetAddOnInfo = GetAddOnInfo or C_AddOns.GetAddOnInfo;

local _G = _G;
_G.__ala_meta__ = _G.__ala_meta__ or {  };
local __ala_meta__ = _G.__ala_meta__;
if __ala_meta__.__minor ~= nil and __ala_meta__.__minor >= __version then
	return;
end
__ala_meta__.__minor = __version;


local _patch_version, _build_number, _build_date, _toc_version = GetBuildInfo();

__ala_meta__.TOC_VERSION = _toc_version;
if _toc_version < 20000 then
	__ala_meta__.MAX_LEVEL = 60;
	__ala_meta__.BUILD = "CLASSIC";
elseif _toc_version < 30000 then
	__ala_meta__.MAX_LEVEL = 70;
	__ala_meta__.BUILD = "BCC";
elseif _toc_version < 40000 then
	__ala_meta__.MAX_LEVEL = 80;
	__ala_meta__.BUILD = "WRATH";
elseif _toc_version < 50000 then
	__ala_meta__.MAX_LEVEL = 85;
	__ala_meta__.BUILD = "CATA";
elseif _toc_version < 60000 then
	__ala_meta__.MAX_LEVEL = 90;
	__ala_meta__.BUILD = "PANDARIA";
elseif _toc_version < 70000 then
	__ala_meta__.MAX_LEVEL = 100;
	__ala_meta__.BUILD = "DRAENOR";
elseif _toc_version < 80000 then
	__ala_meta__.MAX_LEVEL = 110;
	__ala_meta__.BUILD = "LEGION";
elseif _toc_version > 90000 then
	__ala_meta__.MAX_LEVEL = 60;
	__ala_meta__.BUILD = "RETAIL";
else
	__ala_meta__.MAX_LEVEL = GetMaxLevelForExpansionLevel(GetExpansionLevel()) or 60;
	__ala_meta__.BUILD = "UNKNOWN";
end
__ala_meta__.SELFBNTAG = select(2, BNGetInfo());
__ala_meta__.SELFGUID = UnitGUID('player');
__ala_meta__.SELFNAME = UnitName('player');
__ala_meta__.SELFREALM = GetRealmName();
__ala_meta__.SELFFULLNAME = __ala_meta__.SELFNAME .. "-" .. __ala_meta__.SELFREALM;
__ala_meta__.SELFFULLNAME_LEN = #(__ala_meta__.SELFFULLNAME);
__ala_meta__.SELFFACTION = UnitFactionGroup('player');
__ala_meta__.SELFLCLASS, __ala_meta__.SELFCLASS = UnitClass('player');

local _, name, desc, loadable, reason, security, newversion = GetAddOnInfo("!!!!!DebugMe");
__ala_meta__.__SYNC = {
	REALTIME = name ~= nil,
	ONLOGIN = false,
	ONLOGOUT = false,
};
__ala_meta__.__SYNCREALTIME = name ~= nil;
__ala_meta__.__SYNCONLOGIN = false;
__ala_meta__.__SYNCONLOGOUT = false;
