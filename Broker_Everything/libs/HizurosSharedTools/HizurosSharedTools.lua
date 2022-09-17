
local MAJOR, MINOR = "HizurosSharedTools", 2;
local lib = LibStub:NewLibrary(MAJOR, MINOR);
if not lib then return end

local _G,string,tonumber,rawset,type = _G,string,tonumber,rawset,type

local LC = LibStub("LibColors-1.0");
local C = LC.color;
LC.colorset({
	["curseforge"] = "ff8000", --"F16436"
	["github"] = "adbac7",
});

local L = setmetatable({},{
	__index = function(t,k)
		local v = tostring(k);
		rawset(t,k,v);
		return v;
	end
});

L["ThxSpecial"] = "Special thanks at..."
L["ThxLocale"] = "Thanks for the translations..."
L["ThxSupport"] = "Thanks for the support..."

if LOCALE_deDE then
	L["ThxSpecial"] = "Speziellen Dank an..."
	L["ThxLocale"] = "Danke für die Übersetzungen..."
	L["ThxSupport"] = "Danke für die Unterstützung..."
	L["Credit"] = "Anerkennung"
	L["Thanks at..."] = "Danke an..."
end

--== colorized print ==--
do
	local defaultColors = {"20b0ff","00ff00","ff6060","44ffff","ffff00","ff8800","ff44ff","ffffff"};
	-- If you want your own colors add a table named printColors in your addon namespace.
	-- count of entries is not limited.

	local function colorize(ns,...)
		if not ns.addon then
			ConsolePrint(MAJOR,debugstack())
		end
		local colors = ns.printColors or defaultColors; --
		local t,c,a1 = {tostringall(...)},1,...;
		if type(a1)=="boolean" then tremove(t,1); end
		if a1~=false then
			tinsert(t,1,"|cff"..colors[1]..((a1==true and ns.addon_short) or (a1=="||" and "||") or ns.addon or "oops").."|r"..(a1~="||" and HEADER_COLON or ""));
			c=2;
		end
		for i=c, #t do
			if not t[i]:find("\124c") then
				t[i],c = "|cff"..colors[c]..t[i].."|r", c<#colors and c+1 or 1;
			end
		end
		return unpack(t);
	end

	local function ns_print(ns,...)
		print(colorize(ns,...));
	end

	local function ns_debug(ns,...)
		ConsolePrint(date("|cff999999%X|r"),colorize(ns,"<debug>",...));
	end

	local function ns_debugPrint(ns,...)
		if not ns.debugMode then return end
		print(colorize(ns,"<debug>",...));
	end

	function lib.RegisterPrint(ns,addon,short)
		ns.addon,ns.addon_short = addon,short;
		ns.print,ns.debug,ns.debugPrint = ns_print,ns_debug,ns_debugPrint;
	end
end

-- for internal use
local ns = {debugMode=true};
lib.RegisterPrint(ns,MAJOR,"HzST");


--== shared credits page ==--
do
	local donation_platforms = {PP="Paypal",PA="Patreon",GH="Github"};

	local myAddOns = {
		"AFK_fullscreen","AuctionSellers","BestSellButton","Broker_Everything","CommunityInfo","FarmHud","FollowerLocationInfo","GarrisonRandomNPCs",
		"GatherMate2_ImportExport","GuildApplicantTracker","HizurosToolbox","HzFontPack1","LFR_of_the_past","QuickRoutes","StayClassy","TooltipRealmInfo",
		-- don't sort by name. add new at the end
	};

	local supporter = {
		-- special mentions
		{"battlenet","liquidbase", false,"/", "deathknight","Merith", false,"(Author of DuffedUI)"},false,false,{"For idea and first code to add quest level to quest tracker :)",11},
		{"battlenet","pas06",      false,"/", "curseforge","Bullseiify"   },{"deDE",4,6,10,7,16},false,{"For idea to the keystroke replace function",11},
		{"github","TegraGG (Github)"},      false,false,{"For helpfull pull request on github.",16},
		{"github","bruteostrich (Github)"}, false,false,{"For helpfull pull request on github.",6},

		-- donations

		-- localizations
		{"curseforge","Nelfym"},		{"frFR",1},false,false,
		{"curseforge","pczombie09"},	{"koKR",1},false,false,
		{"curseforge","KARMA_Zz"},		{"ruRU",1},false,false,
		{"curseforge","BNS333"},		{"zhTW",1},false,false,
		{"curseforge","ZamestoTV"},		{"ruRU",2,5,9,13,15},false,false,
		{"curseforge","Nierhain"},		{"deDE",4},false,false,
		{"curseforge","Braincell1980"},	{"frFR",4,13},false,false,
		{"curseforge","netaras"},		{"koKR",4,6},false,false,
		{"curseforge","적셔줄게"},		{"koKR",4},false,false,
		{"curseforge","cikichen"},		{"zhCN",4,"zhTW",4},false,false,
		{"curseforge","sanxy00"},		{"zhCN",4},false,false,
		{"curseforge","雪夜霜刀"},		{"zhCN",4},false,false,
		{"curseforge","半熟魷魚"},		{"zhTW",4},false,false,
		{"curseforge","Lightuky"},		{"frFR",5},false,false,
		{"curseforge","TomasRipley"},	{"ruRU",5},false,false,
		{"curseforge","Dathwada"},		{"deDE",6},false,false,
		{"curseforge","supahmexman"},	{"esES",6},false,false,
		{"curseforge","justregular16"},	{"esMX",6},false,false,
		{"curseforge","Zickwik"},		{"frFR",6},false,false,
		{"curseforge","oxscott"},		{"itIT",6},false,false,
		{"curseforge","g0ldenev1l"},	{"zhCN",6},false,false,
		{"curseforge","mccma"},			{"zhTW",6},false,false,
		{"curseforge","Tumbleweed_DSA"},{"deDE",7},false,false,
		{"curseforge","Dabeuliou"},		{"frFR",7},false,false,
		{"curseforge","unrealcrom96"},	{"koKR",7},false,false,
		{"curseforge","Canettieri"},	{"ptBR",7},false,false,
		{"curseforge","dropdb"},		{"ruRU",7},false,false,
		{"curseforge","Igara86"},		{"ruRU",7},false,false,
		{"curseforge","Ananhaid"},		{"zhCN",7},false,false,
	}

	--local foreignAddOns = {}

	local creditTemplate = {type="group",order=200,name=L["Credit"],args={
		thanks={type="description",order=0,fontSize="large",name=C("dkyellow",L["Thanks at..."])},
		thanksLine={type="header",order=1,name=""}
	}};

	local supporterTemplate = {
		type="group",inline=true,width="normal",order=0,name="",
		args={
			label={type="description",order=1,fontSize="large"},
			reasons={type="description",order=2,fontSize="medium"}
		}
	};
	local descLargeTemplate = {type="description",order=0,fontSize="large"}
	local headerTemplate = {type="header",order=0,name=""};

	local function thisAddOn(addon,tbl)
		local res,obj = {};
		for _,value in ipairs(tbl) do
			if type(value)=="string" then
				obj = value;
			elseif value==true then
				tinsert(res,obj);
			elseif myAddOns[value]==addon then
				tinsert(res,obj);
			end
		end
		if #res>0 then
			return res;
		end
		return false;
	end

	local function Supporter_GetName(entry)
		local name = {};
		if type(entry)=="table" then
			for n=1, #entry, 2 do
				local color,nameStr = entry[n], entry[n+1];
				if color then
					tinsert(name,C(color,nameStr));
				else
					tinsert(name,nameStr);
				end
			end
		else
			tinsert(name,entry);
		end
		return table.concat(name," ");
	end

	local function Supporter_GetLanguages(entries)
		local unique,res = {},{}
		for i,v in ipairs(entries) do
			local value = v:upper();
			if value=="PTPT" and not LFG_LIST_LANGUAGE_PTPT then
				-- blizzard using on eu clients LFG_LIST_LANGUAGE_PTBR instead of LFG_LIST_LANGUAGE_PTPT
				value = LFG_LIST_LANGUAGE_PTBR;
			elseif _G["LFG_LIST_LANGUAGE_"..value] then
				value = _G["LFG_LIST_LANGUAGE_"..value];
			end
			if not unique[value] then
				tinsert(res,value);
				unique[value] = true;
			end
		end
		return table.concat(res,", ");
	end

	local function Supporter_GetDonationPlatforms(entries)
		for i,v in ipairs(entries) do
			entries[i] = donation_platforms[v] or v;
		end
		return table.concat(entries,", ");
	end

	local function Supporter_AddStyle(addon,credit)
		local specials,donations,translations,special,donation,translation = {},{},{},3,2,1;

		if credit.args.thanks then
			credit.args.thanks.hidden=true
			credit.args.thanksLine.hidden=true
		end

		local prev = false;

		local sIndex,hasNoEntries = {1,1,1},true;
		for s=1, #supporter, 4 do
			local name = Supporter_GetName(supporter[s]);
			for r=3,1,-1 do
				local rInvert = 3-r;
				local rIndex,objs = s+r;
				if supporter[rIndex] then
					objs = thisAddOn(addon,supporter[rIndex]);
				end
				if objs then
					local res = {name};
					local width = "normal";
					if r==1 then -- translations
						tinsert(res,Supporter_GetLanguages(objs));
					elseif r==2 then -- donations
						tinsert(res,Supporter_GetDonationPlatforms(objs));
					else -- specials
						tAppendAll(res,objs);
						width="full";
					end
					local entry = CopyTable(descLargeTemplate);
					entry.order = rInvert*1000+sIndex[r];
					entry.name = table.concat(res,"|n");
					entry.width = width;
					credit.args["supporter-"..s.."-"..r] = entry;
					sIndex[r] = sIndex[r] + 1;
				end
				if objs and not credit.args["header-"..r] then
					credit.args["header-"..r] = CopyTable(descLargeTemplate);
					credit.args["header-"..r].order = rInvert*1000;
					credit.args["header-"..r].name = C("cyan",(r==1 and L["ThxLocale"]) or (r==2 and L["ThxSupport"]) or L["ThxSpecial"]);

					if prev then
						credit.args[prev].name = "|n"..credit.args[prev].name;
					end

					prev = "header-"..r;
					hasNoEntries = false
				end
			end
		end
		return hasNoEntries;
	end

	function lib.AddCredit(addon,creditSection,style)
		local credit = CopyTable(creditTemplate);
		credit.name = addon.." / "..L["Credit"]
		--credit.args = {};
		if tonumber(order) then
			credit.order = order;
		end

		-- add supporter
		local isEmpty = Supporter_AddStyle(addon,credit);

		if isEmpty then
			return;
		end

		-- register
		if type(creditSection)=="table" then
			Mixin(creditSection,credit.args);
		else
			-- add own sub option table
			LibStub("AceConfigRegistry-3.0"):RegisterOptionsTable(addon.."/Credit", credit);
			LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addon.."/Credit", "Credit", addon);
		end
	end
end

--== Blizz option panel functions ==--
do
	local function CalculateOffset(panel)
		local pType = type(panel);
		local buttonCount = #InterfaceOptionsFrameAddOns.buttons;
		local buttonHeight = InterfaceOptionsFrameAddOns.buttons[1]:GetHeight();

		local elementsBefore = 0;
		for i, element in next, INTERFACEOPTIONS_ADDONCATEGORIES do
			if not element.hidden then
				if (pType=="string" and element.name==panel) or (pType=="table" and element==panel) then
					break;
				end
				elementsBefore = elementsBefore + 1;
			end
		end

		if elementsBefore>buttonCount then
			ns:print(elementsBefore,buttonCount);
			return elementsBefore + 1 - buttonCount;
		end

		return 0;
	end

	local function BlizzOptions_ExpandOnShowHook(self)
		local p = false;
		for i, button in next, InterfaceOptionsFrameAddOns.buttons do
			if button.element then
				if button.element.name == self.name then
					p = button
				end
			end
		end
		if p and p.element.collapsed then
			OptionsListButtonToggle_OnClick(p.toggle)
			local offset = CalculateOffset();
			if offset>0 then
				-- SetOffset(offset)
			end
		end
	end

	function lib.BlizzOptions_ExpandOnShow(opts)
		if opts.hasExpandOnShowHook then return end
		--opts:HookScript("OnShow", BlizzOptions_ExpandOnShowHook);
		opts.hasExpandOnShowHook = true;
	end

	function lib.InterfaceOptionsFrame_OpenToCategory(panel)
		InterfaceOptionsFrame_OpenToCategory(panel);

		local offset = CalculateOffset(panel);
		if offset>0 then
			if InterfaceOptionsFrame.selectedTab==1 then
				InterfaceOptionsFrame.selectedTab=2;
				InterfaceOptionsFrame_TabOnClick();
			end
			FauxScrollFrame_SetOffset(InterfaceOptionsFrameAddOnsList,offset);
			InterfaceOptionsFrameAddOnsList:SetVerticalScroll(offset);
			--FauxScrollFrame_GetOffset(InterfaceOptionsFrameAddOnsList)
		end

		InterfaceOptionsFrame_OpenToCategory(panel);
	end
end
