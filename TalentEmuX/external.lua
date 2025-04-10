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
	local next = next;
	local strbyte, strchar, strsub, strsplit, strlower, strupper, strrep, strmatch = string.byte, string.char, string.sub, string.split, string.lower, string.upper, string.rep, string.match;
	local tinsert, concat = table.insert, table.concat;
	local tonumber, tostring = tonumber, tostring;
	local RegisterAddonMessagePrefix = C_ChatInfo ~= nil and C_ChatInfo.RegisterAddonMessagePrefix or RegisterAddonMessagePrefix;
	local IsAddonMessagePrefixRegistered = C_ChatInfo ~= nil and C_ChatInfo.IsAddonMessagePrefixRegistered or IsAddonMessagePrefixRegistered;
	-- local GetRegisteredAddonMessagePrefixes = C_ChatInfo ~= nil and C_ChatInfo.GetRegisteredAddonMessagePrefixes or GetRegisteredAddonMessagePrefixes;
	local SendAddonMessage = C_ChatInfo ~= nil and C_ChatInfo.SendAddonMessage or SendAddonMessage;
	local Ambiguate = Ambiguate;
	local GetClassInfo = C_CreatureInfo.GetClassInfo;
	local _G = _G;

-->
	local l10n = CT.l10n;

-->		constant
-->
MT.BuildEnv('EXTERNAL');
-->		predef
-->		EXTERNAL
	VT.ExternalCodec.wowhead = {
		ImportCode = function(codec, url)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				--	https://cn.classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				--	https://cn.classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
				--	https://classic.wowhead.com/talent-calc/embed/warrior/05004-055001-55250110500001051
				--	https://classic.wowhead.com/talent-calc/warrior/05004-055001-55250110500001051
				class, data = strmatch(url, "classic%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			elseif CT.BUILD == "BCC" then
				class, data = strmatch(url, "tbc%.wowhead%.com/talent%-calc.*/([^/]+)/([0-9%-]+)");
			elseif CT.BUILD == "WRATH" then
				--	https://www.wowhead.com/wotlk/talent-calc/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/talent-calc/death-knight/-32002350352203012300033101351-230200305003
				--	https://www.wowhead.com/wotlk/cn/talent-calc/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/cn/talent-calc/death-knight/-32002350352203012300033101351-230200305003
				--	https://www.wowhead.com/wotlk/cn/talent-calc/embed/death-knight/23050005-32005350352203012300033101351
				--	https://www.wowhead.com/wotlk/cn/talent-calc/embed/death-knight/-32002350352203012300033101351-230200305003
				class, data = strmatch(url, "wowhead%.com/wotlk/.*talent%-calc.*/([^/]+)/([0-9%-]+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = strupper(class);
				if class == "DEATH-KNIGHT" then
					class = "DEATHKNIGHT";
				end
				local ClassTDB = DT.TalentDB[class];
				local SpecList = DT.ClassSpec[class];
				if ClassTDB ~= nil and SpecList ~= nil then
					--(%d*)[%-]*(%d*)[%-]*(%d*)
					local d1, d2, d3 = strmatch(data, "(%d*)[%-]?(%d*)[%-]?(%d*)");
					if d1 and d2 and d3 then
						if d1 == "" and d2 == "" and d3 == "" then
							return class, "", DT.MAX_LEVEL;
						elseif d2 == "" and d3 == "" then
							return d1;
						else
							local l1 = #ClassTDB[SpecList[1]];
							if l1 > #d1 then
								data = d1 .. CT.RepeatedZero[l1 - #d1];
							else
								data = d1;
							end
							local l2  = #ClassTDB[SpecList[2]];
							if l2 > #d2 then
								data = data .. d2 .. CT.RepeatedZero[l2 - #d2] .. d3;
							else
								data = data .. d2 .. d3;
							end
							return class, DT.MAX_LEVEL, data;
						end
					end
				end
			end
			return nil;
		end,
		ExportCode = function(codec, Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for TreeIndex = 3, 1, -1 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				local topPos = 0;
				for TreeIndex = #ClassTDB[SpecList[TreeIndex]], 1, -1 do
					if TalentSet[TreeIndex] > 0 then
						topPos = TreeIndex;
						break;
					end
				end
				if topPos > 0 then
					for TreeIndex = topPos, 1, -1 do
						data = TalentSet[TreeIndex] .. data;
					end
				end
				if TreeIndex > 1 and data ~= "" then
					data = "-" .. data;
				end
			end
			local LOC = nil;
			if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
				LOC = "cn";
			elseif CT.LOCALE == "deDE" then
				LOC = "de";
			elseif CT.LOCALE == "esES" then
				LOC = "es";
			elseif CT.LOCALE == "frFR" then
				LOC = "fr";
			elseif CT.LOCALE == "itIT" then
				LOC = "it";
			elseif CT.LOCALE == "ptBR" then
				LOC = "pt";
			elseif CT.LOCALE == "ruRU" then
				LOC = "ru";
			elseif CT.LOCALE == "koKR" then
				LOC = "ko";
			end
			if CT.BUILD == "CLASSIC" then
				if LOC == nil then
					return "classic.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				else
					return LOC .. ".classic.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				end
			elseif CT.BUILD == "BCC" then
				if LOC == nil then
					return "tbc.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				else
					return LOC .. ".tbc.wowhead.com/talent-calc/" .. strlower(Frame.class) .. "/" .. data;
				end
			elseif CT.BUILD == "WRATH" then
				local class = strlower(Frame.class);
				if class == "deathknight" then
					class = "death-knight";
				end
				if LOC == nil then
					return "www.wowhead.com/wotlk/talent-calc/" .. class .. "/" .. data;
				else
					return "www.wowhead.com/wotlk/" .. LOC .. "/talent-calc/" .. class .. "/" .. data;
				end
			end
			return nil;
		end,
	};
	VT.ExternalCodec.nfu = {
		ImportCode = function(codec, url)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				--	http://www.nfuwow.com/talents/60/warrior/tal/0530500030200000000000000000000000054250110530001051
				class, data = strmatch(url, "nfuwow%.com/talents/60/([^/]+)/tal/(%d+)");
			elseif CT.BUILD == "BCC" then
				--	http://www.nfuwow.com/talents/warrior/index.html?350003013020000000000000000000000000000000000055511033010103531331
				class, data = strmatch(url, "nfuwow%.com/talents/([^/]+)/index.html%?(%d+)");
			elseif CT.BUILD == "WRATH" then
				--	http://www.nfuwow.com/talents/80/deathknight/index.html?0000000000000000000000000000320023503522030123000331013512300000000000000000000000000000
				class, data = strmatch(url, "nfuwow%.com/talents/80/([^/]+)/index.html%?(%d+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = strupper(class);
				if DT.TalentDB[class] then
					return class, DT.MAX_LEVEL, data;
				end
			end
			return nil;
		end,
		ExportCode = function(codec, Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local data = "";
			for TreeIndex = 1, 3 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
					data = data .. TalentSet[TreeIndex];
				end
			end
			if CT.BUILD == "CLASSIC" then
				return "www.nfuwow.com/talents/60/" .. strlower(Frame.class) .. "/tal/" .. data;
			elseif CT.BUILD == "BCC" then
				return "www.nfuwow.com/talents/" .. strlower(Frame.class) .. "/index.html?" .. data;
			elseif CT.BUILD == "WRATH" then
				return "www.nfuwow.com/talents/80/" .. strlower(Frame.class) .. "/index.html?" .. data;
			end
			return nil;
		end,
	};
	VT.ExternalCodec.wowfan = {
		--	WTF?
		declass = {
			["0"] = "DRUID",
			["o"] = "MAGE",
			["c"] = "HUNTER",
			["b"] = "PRIEST",
			["f"] = "ROGUE",
			["h"] = "SHAMAN",
			["s"] = "PALADIN",
			["I"] = "WARLOCK",
			["j"] = "DEATHKNIGHT",
			["L"] = "WARRIOR",
		},
		--[[
			00	0
			--
			01	z
			02	M
			03	c
			04	m
			05	V
			--
			10	o
			11	k
			12	R
			13	s
			14	a
			15	q
			--
			20	b
			21	d
			22	r
			23	f
			24	w
			25	i
			--
			30	h
			31	u
			32	G
			33	I
			34	N
			35	A
			--
			40	L
			41	p
			42	T
			43	j
			44	n
			45	y
			--
			50	x
			51	t
			52	g
			53	e
			54	v
			55	E
		--]]
		--[[
			--				p2
			--		0	1	2	3	4	5
			--
			--	0	0	z	M	c	m	V
			--
			--	1	o	k	R	s	a	q
			--
			--	2	b	d	r	f	w	i
			--
			p1	3	h	u	G	I	N	A
			--
			--	4	L	p	T	j	n	y
			--
			--	5	x	t	g	e	v	E
			--
			--	ASCII
				48	122	77	99	109	86
				111	107	82	115	97	113
				98	100	114	102	119	105
				104	117	71	73	78	65
				76	112	84	106	110	121
				120	116	103	101	118	69
			--
		--]]
		--[[
			0zMcmV
			okRsaq
			bdrfwi
			huGINA
			LpTjny
			xtgevE
			--
			0obhLx
			zkdupt
			MRrGTg
			csfIje
			mawNnv
			VqiAyE
		--]]
		base = {	--	base[p1][p2]
			[0] = {
				[0] = "0",
				[1] = "z",
				[2] = "M",
				[3] = "c",
				[4] = "m",
				[5] = "V",
			},
			[1] = {
				[0] = "o",
				[1] = "k",
				[2] = "R",
				[3] = "s",
				[4] = "a",
				[5] = "q",
			},
			[2] = {
				[0] = "b",
				[1] = "d",
				[2] = "r",
				[3] = "f",
				[4] = "w",
				[5] = "i",
			},
			[3] = {
				[0] = "h",
				[1] = "u",
				[2] = "G",
				[3] = "I",
				[4] = "N",
				[5] = "A",
			},
			[4] = {
				[0] = "L",
				[1] = "p",
				[2] = "T",
				[3] = "j",
				[4] = "n",
				[5] = "y",
			},
			[5] = {
				[0] = "x",
				[1] = "t",
				[2] = "g",
				[3] = "e",
				[4] = "v",
				[5] = "E",
			},
		},
		--	encode[p1p2] = code
		--	decode[code] = p1p2
		ImportCode = function(codec, url)
			local class, data = nil;
			if CT.BUILD == "CLASSIC" then
				class, data = strmatch(url, "60%.wowfan%.net/[e]*[n]*[/]*%?talent#(.)(.+)");
			elseif CT.BUILD == "BCC" then
				--	https://70.wowfan.net/talent/index.html?cn&druid&51402201050313520105110000000000000000000000000000000000000000
				class, data = strmatch(url, "70%.wowfan%.net/talent/index%.html%?[ce]n&([a-z]+)&(%d+)");
				if class ~= nil and data ~= nil then
					class = strupper(class);
					if DT.TalentDB[class] then
						return class, DT.MAX_LEVEL, data;
					end
				end
				return nil;
			elseif CT.BUILD == "WRATH" then
				class, data = strmatch(url, "80%.wowfan%.net/[e]*[n]*[/]*%?talent#(.)(.+)");
			else
				return nil;
			end
			if class ~= nil and data ~= nil then
				class = codec.declass[class];
				if class ~= nil then
					local ClassTDB = DT.TalentDB[class];
					local SpecList = DT.ClassSpec[class];
					if ClassTDB ~= nil and SpecList ~= nil then
						local decode = codec.decode;
						local dec = "";
						local SpecIndex = 1;
						local TreeTDB = ClassTDB[SpecList[SpecIndex]];
						local len = #TreeTDB;
						local pos = 0;
						for index = 1, #data do
							local v = strsub(data, index, index);
							if v == "Z" then
								if SpecIndex >= 3 then
									return class, DT.MAX_LEVEL, dec;
								end
								if pos < len then
									dec = dec .. CT.RepeatedZero[len - pos];
								end
								SpecIndex = SpecIndex + 1;
								TreeTDB = ClassTDB[SpecList[SpecIndex]];
								len = #TreeTDB;
								pos = 0;
							else
								if decode[v] == nil then
									return nil;
								end
								pos = pos + 2;
								if pos >= len then
									if pos == len then
										dec = dec .. decode[v];
									else
										dec = dec .. decode.short[v];
									end
									SpecIndex = SpecIndex + 1;
									if SpecIndex >= 3 then
										return class, DT.MAX_LEVEL, dec;
									end
									TreeTDB = ClassTDB[SpecList[SpecIndex]];
									len = #TreeTDB;
									pos = 0;
								else
									dec = dec .. decode[v];
								end
							end
						end
						return class, DT.MAX_LEVEL, dec;
					end
				end
			end
			return nil;
		end,
		ExportCode = function(codec, Frame)
			local TreeFrames = Frame.TreeFrames;
			local ClassTDB = DT.TalentDB[Frame.class];
			local SpecList = DT.ClassSpec[Frame.class];
			local url = nil;
			if CT.BUILD == "CLASSIC" then
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					url = "60.wowfan.net/?talent#";
				else
					url = "60.wowfan.net/en/?talent#";
				end
			elseif CT.BUILD == "BCC" then
				local data = "";
				for TreeIndex = 1, 3 do
					local TalentSet = TreeFrames[TreeIndex].TalentSet;
					for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
						data = data .. TalentSet[TreeIndex];
					end
				end
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					return "70.wowfan.net/talent/index.html?cn&" .. strlower(Frame.class) .. "&" .. data;
				else
					return "70.wowfan.net/talent/index.html?en&" .. strlower(Frame.class) .. "&" .. data;
				end
			elseif CT.BUILD == "WRATH" then
				if CT.LOCALE == "zhCN" or CT.LOCALE == "zhTW" then
					url = "80.wowfan.net/?talent#";
				else
					url = "80.wowfan.net/en/?talent#";
				end
			else
				return nil;
			end
			url = url .. codec.enclass[Frame.class];
			local ofs = 0;
			local encode = codec.encode;
			local data = "";
			for TreeIndex = 1, 3 do
				local TalentSet = TreeFrames[TreeIndex].TalentSet;
				for TreeIndex = 1, #ClassTDB[SpecList[TreeIndex]] do
					data = data .. TalentSet[TreeIndex];
				end
			end
			for SpecIndex = 1, 3 do
				local TreeTDB = ClassTDB[SpecList[SpecIndex]];
				local len = #TreeTDB;
				local sub = strsub(data, ofs + 1, ofs + len);
				local val = strmatch(sub, "^(.-)[0]*$");
				if val == "" then
					url = url .. "Z";
				else
					local num = #val;
					for index = 1, num, 2 do
						local pat = strsub(val, index, index + 1);
						if encode[pat] == nil then
							return nil;
						end
						url = url .. encode[pat];
					end
					if num < #sub then
						url = url .. "Z";
					end
				end
				--
				ofs = ofs + len;
			end
			for i = 1, 3 do
				if strsub(url, -1, -1) == "Z" then
					url = strsub(url, 1, -2);
				else
					break;
				end
			end
			return url;
		end,
		init = function(codec)
			local base = codec.base;
			local encode = {  };
			local decode = { short = {  }, };
			for p1 = 0, 5 do
				for p2 = 0, 5 do
					local c = base[p1][p2];
					encode[p1 .. p2] = c;
					decode[c] = p1 .. p2;
				end
				encode[tostring(p1)] = encode[p1 .. "0"];
				decode.short[base[p1][0]] = tostring(p1);
			end
			codec.encode = encode;
			codec.decode = decode;
			local declass = codec.declass;
			local enclass = {  };
			for c, class in next, declass do
				enclass[class] = c;
			end
			codec.enclass = enclass;
		end,
	};
	VT.ExternalAddOn["D4C"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, channel, msg)
			local temp = { strsplit("\t", msg) };
			if temp[1] == "V" or temp[1] == "GV" then
				tinsert(temp, 1, temp[4]);
				self.list[Ambiguate(sender, 'none')] = temp;
				return true;
			end
		end,
	};
	VT.ExternalAddOn["D4BC"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, channel, msg)
			local temp = { strsplit("\t", msg) };
			if temp[1] == "V" or temp[1] == "GV" then
				tinsert(temp, 1, temp[4]);
				self.list[Ambiguate(sender, 'none')] = temp;
				return true;
			end
		end,
	};
	VT.ExternalAddOn["D5"] = {
		addon = "DBM",
		list = {  },
		handler = function(self, sender, channel, msg)
			local temp = { strsplit("\t", msg) };
			if temp[3] == "V" or temp[3] == "GV" then
				tinsert(temp, 1, temp[6]);
				self.list[Ambiguate(sender, 'none')] = temp;
				return true;
			end
		end,
	};
	VT.ExternalAddOn["BigWigs"] = {
		addon = "BigWigs",
		list = {  },
		handler = function(self, sender, channel, msg)
			local temp = { strsplit("^", msg) };
			if temp[1] == "V" then
				tinsert(temp, 1, temp[2] .. "-" .. temp[3]);
				self.list[Ambiguate(sender, 'none')] = temp;
				return true;
			end
		end,
	};
	VT.ExternalAddOn["tdInspect"] = {
		addon = "tdInspect",
		serializer = LibStub('AceSerializer-3.0', true),
		class = {  },
		temp = {  },
		handler = function(self, sender, channel, msg)
			if self.serializer then
				local control, rest = strmatch(msg, "^([\001-\009])(.*)");
				if control then
					if control == "\001" then
						local key = sender .. channel;
						self.temp[key] = { rest, };
					elseif control == "\002" then
						local key = sender .. channel;
						local target = self.temp[key];
						if target ~= nil then
							target[#target + 1] = rest;
						end
					elseif control == "\003" then
						local key = sender .. channel;
						local target = self.temp[key];
						if target ~= nil then
							self.temp[key] = nil;
							target[#target + 1] = rest;
							return self:OnComm(sender, channel, self.serializer:Deserialize(concat(target, "")));
						end
					elseif control == "\004" then
						return self:OnComm(sender, channel, self.serializer:Deserialize(rest));
					else
					end
				else
					return self:OnComm(sender, channel, self.serializer:Deserialize(msg));
				end
			end
		end,
		OnComm = function(self, sender, channel, ok, cmd, ...)
			if not ok then
				return;
			elseif cmd == "Q" then
				--	暂时不回复，需要AceComm
			elseif cmd == "R" then
				--	旧版本？暂时忽略
			elseif cmd == "R2" then
				local protoVersion, class, race, level, equips, numGroup, activeGroup, talents, glyphs, runes = ...;
				local T = self:DecodeTalents(class, level, talents, numGroup, activeGroup);
				local G = self:DecodeGlyphs(glyphs, numGroup, activeGroup);
				local E = self:DecodeEquips(equips);
				local N = self:DecodeRunes(runes);
				local msg = T or "";
				if G then msg = msg .. G; end
				if E then msg = msg .. E; end
				if N then msg = msg .. N; end
				-- MT.Debug("tdInspect\nT =", T, "\nG =", G, "\nE =", E, "\nN =", N);
				return VT.__dep.__emulib.ProcV2Message("tdInspect", msg, channel, sender);
			end
		end,
		EncodeInteger = function(v)
			v = tonumber(v);
			if not v then
				return;
			end
			local s = {};
			local n;
			if v < 0 then
				s[1] = "-";
				v = -v;
			end
			while v > 0 do
				n = v % 128;
				s[#s + 1] = strchar(n + 128);
				v = (v - n) / 128;
			end
			return concat(s);
		end,
		DecodeInteger = function(code)
			if not code or code == "" then
				return;
			end
			local isNeg = strsub(code, 1, 1) == "-";
			local v = 0;
			local n;
			for i = #code, isNeg and 2 or 1, -1 do
				n = strbyte(strsub(code, i, i)) - 128;
				v = v * 128 + n;
			end
			return isNeg and -v or v;
		end,
		DecodeTalents = function(self, class, level, data, numGroup, activeGroup)
			if data then
				class = self.class[class];
				local talent1, talent2 = strsplit("!", data);
				local code1, lenc1, code2, lenc2;
				code1, lenc1 = self:DecodeTalent(class, level, talent1);
				if numGroup > 1 then
					code2, lenc2 = self:DecodeTalent(class, level, talent2);
				end
				local code = VT.__dep.__emulib.MergeTalentCodeV2(class, level, activeGroup, numGroup, code1, lenc1, code2, lenc2);
				return code;
			end
		end,
		DecodeTalent = function(self, class, level, talent)
			local ClassTDB = DT.TalentDB[class];
			local SpecList = DT.ClassSpec[class];
			local code = "";
			local lenc = 0;
			local p = { strsplit(":", talent) };
			for tab = 1, 3 do
				local r = "";
				local v = p[tab];
				if v then
					for index = 1, #v do
						local n = strbyte(v, index);
						if n >= 127 then n = n - 1; end
						if n >= 126 then n = n - 1; end
						if n >=  94 then n = n - 1; end
						if n >=  58 then n = n - 1; end
						if n >=  45 then n = n - 1; end
						n = n - 34;
						--
						local d = "";
						local k = 3;
						while n > 0 do
							d = (n % 6) .. d;
							n = (n - n % 6) / 6;
							k = k - 1;
						end
						while k > 0 do
							d = "0" .. d;
							k = k - 1;
						end
						r = r .. d;
					end
					--
					local num = #ClassTDB[SpecList[tab]];
					local len = #r;
					if len < num then
						r = r .. strrep("0", num - len);
					end
					lenc = lenc + num;
				else
					break;
				end
				code = code .. r;
			end
			return code, lenc;
		end,
		DecodeGlyph = function(self, glyph)
			local p = { strsplit(":", glyph) };
			for i = 1, #p do
				local id = self.DecodeInteger(p[i]);
				if id and self.GlyphInfo[id] then
					local info = self.GlyphInfo[id];
					p[i] = { info[1], info[2], info[3], info[4], };
				else
					p[i] = nil;
				end
			end
			return p;
		end,
		DecodeGlyphs = function(self, data, numGroup, activeGroup)
			if data and self.GlyphInfo then
				local glyph1, glyph2 = strsplit("!", data);
				local data1, data2;
				data1 = self:DecodeGlyph(glyph1);
				if numGroup > 1 then
					data2 = self:DecodeGlyph(glyph2);
				end
				local code = VT.__dep.__emulib.EncodeGlyphDataV2(numGroup, activeGroup, data1, data2)
				return code;
			end
		end,
		DecodeEquip = function(self, equip)
			local p = { strsplit(":", equip) };
			for i = 1, #p do
				p[i] = self.DecodeInteger(p[i]) or "";
			end
			local link = concat(p, ":");
			if link then
				return "item:" .. link;
			end
		end,
		DecodeEquips = function(self, data)
			if data then
				local equips = { strsplit("!", data) };
				for slot = 0, 19 do
					local equip = equips[slot];
					if equip then
						equips[slot] = self:DecodeEquip(equip);
					end
				end
				local code = VT.__dep.__emulib.EncodeEquipmentDataV2(equips);
				return code;
			end
		end,
		DecodeRune = function(self, rune)
			local p = { strsplit("!", rune) };
			local slot = self.DecodeInteger(p[1]);
			local id = self.DecodeInteger(p[2]);
			local icon = self.DecodeInteger(p[3]);
			if slot and id and icon then
				return slot, { id, icon, };
			end
		end,
		DecodeRunes = function(self, data)
			if data and VT.__dep.__emulib.CT.SUPPORT_ENGRAVING then
				local runes = { strsplit("!", data) };
				local res = {  };
				for i, v in next, runes do
					local slot, info = self:DecodeRune(v);
					if slot then
						res[slot] = info;
					end
				end
				local code = VT.__dep.__emulib.EncodeEngravingDataV2(res);
				return code;
			end
		end,
		Query = function(self, target, T, G, E)
			if self.serializer then
				SendAddonMessage("tdInspect", self.serializer:Serialize('Q', T, E, 2, G, E), 'WHISPER', target);
			end
		end,
		init = function(self)
			for class = 1, 20 do
				local info = GetClassInfo(class);
				if info and info.classFile then
					self.class[class] = info.classFile;
				end
			end
			if CT.TOCVERSION < 30000 then
			elseif CT.TOCVERSION < 40000 then
				--	https://wago.tools/db2/GlyphProperties?build=3.4.4.60063&page=1&sort%5BID%5D=asc
				self.GlyphInfo = {
					[2] = { 1, 0, 52084, 237634, },
					[21] = { 1, 162, 12320, 0, },
					[22] = { 1, 128, 12297, 0, },
					[61] = { 1, 2, 46831, 0, },
					[81] = { 1, 1, 52084, 0, },
					[82] = { 1, 128, 52085, 0, },
					[101] = { 1, 0, 0, 0, },
					[121] = { 1, 64, 46487, 132371, },
					[141] = { 1, 1, 54292, 237637, },
					[161] = { 1, 0, 54810, 237636, },
					[162] = { 1, 0, 54811, 237635, },
					[163] = { 1, 0, 54812, 237651, },
					[164] = { 1, 0, 54813, 237646, },
					[165] = { 1, 0, 54815, 237652, },
					[166] = { 1, 0, 54818, 237633, },
					[167] = { 1, 0, 54821, 237650, },
					[168] = { 1, 0, 54824, 237645, },
					[169] = { 1, 0, 54832, 237644, },
					[170] = { 1, 0, 54733, 237649, },
					[171] = { 1, 0, 54743, 237634, },
					[172] = { 1, 0, 54754, 237647, },
					[173] = { 1, 0, 54825, 237641, },
					[174] = { 1, 0, 54826, 237642, },
					[175] = { 1, 0, 54845, 237639, },
					[176] = { 1, 0, 54830, 237643, },
					[177] = { 1, 0, 54831, 237640, },
					[178] = { 1, 0, 54828, 237638, },
					[179] = { 1, 0, 54756, 237648, },
					[180] = { 1, 0, 54829, 237632, },
					[181] = { 1, 0, 54760, 237637, },
					[182] = { 1, 1, 54912, 0, },
					[183] = { 1, 0, 54922, 237650, },
					[184] = { 1, 0, 54925, 237644, },
					[185] = { 1, 0, 54923, 237633, },
					[186] = { 1, 0, 54924, 237637, },
					[187] = { 1, 0, 54926, 237639, },
					[188] = { 1, 0, 54927, 237632, },
					[189] = { 1, 0, 54928, 237641, },
					[190] = { 1, 0, 54929, 237640, },
					[191] = { 1, 0, 54930, 237647, },
					[192] = { 1, 0, 54931, 237651, },
					[193] = { 1, 0, 54934, 237643, },
					[194] = { 1, 0, 54935, 237648, },
					[195] = { 1, 0, 54936, 237649, },
					[196] = { 1, 0, 54937, 237652, },
					[197] = { 1, 0, 54938, 237635, },
					[198] = { 1, 0, 54939, 237636, },
					[199] = { 1, 0, 54940, 237646, },
					[200] = { 1, 0, 54943, 237645, },
					[211] = { 1, 0, 55436, 237639, },
					[212] = { 1, 0, 55437, 237640, },
					[213] = { 1, 0, 55449, 237636, },
					[214] = { 1, 0, 55454, 237638, },
					[215] = { 1, 0, 55442, 237646, },
					[216] = { 1, 0, 55439, 237652, },
					[217] = { 1, 0, 55455, 237642, },
					[218] = { 1, 0, 55450, 237635, },
					[219] = { 1, 0, 55447, 237647, },
					[220] = { 1, 0, 55451, 237637, },
					[221] = { 1, 0, 55443, 237643, },
					[222] = { 1, 0, 55456, 237649, },
					[223] = { 1, 0, 55440, 237651, },
					[224] = { 1, 0, 55438, 237633, },
					[225] = { 1, 0, 55448, 237648, },
					[226] = { 1, 0, 55453, 237641, },
					[227] = { 1, 0, 55441, 237644, },
					[228] = { 1, 0, 55446, 237645, },
					[229] = { 1, 0, 55444, 237632, },
					[230] = { 1, 0, 55452, 237634, },
					[231] = { 1, 0, 55445, 237650, },
					[251] = { 1, 0, 55675, 237634, },
					[252] = { 1, 0, 55677, 237633, },
					[253] = { 1, 0, 55684, 237635, },
					[254] = { 1, 0, 55678, 237639, },
					[255] = { 1, 0, 55679, 237637, },
					[256] = { 1, 0, 55683, 237652, },
					[257] = { 1, 0, 55686, 237641, },
					[258] = { 1, 0, 55673, 237651, },
					[259] = { 1, 0, 55691, 237642, },
					[260] = { 1, 0, 55688, 237644, },
					[261] = { 1, 0, 55681, 237650, },
					[262] = { 1, 0, 55689, 237636, },
					[263] = { 1, 0, 55672, 237647, },
					[264] = { 1, 0, 55680, 237645, },
					[265] = { 1, 0, 55676, 237648, },
					[266] = { 1, 0, 55674, 237632, },
					[267] = { 1, 0, 55690, 237640, },
					[268] = { 1, 0, 55682, 237638, },
					[269] = { 1, 0, 55687, 237643, },
					[270] = { 1, 0, 55692, 237649, },
					[271] = { 1, 0, 55685, 237646, },
					[272] = { 1, 0, 56242, 237650, },
					[273] = { 1, 0, 56235, 237644, },
					[274] = { 1, 0, 56218, 237647, },
					[275] = { 1, 0, 56241, 237646, },
					[276] = { 1, 0, 56232, 237634, },
					[277] = { 1, 0, 56244, 237637, },
					[278] = { 1, 0, 56246, 237638, },
					[279] = { 1, 0, 56249, 237636, },
					[280] = { 1, 0, 56238, 237635, },
					[281] = { 1, 0, 56224, 237648, },
					[282] = { 1, 0, 56217, 237645, },
					[283] = { 1, 0, 56228, 237651, },
					[284] = { 1, 0, 56248, 237641, },
					[285] = { 1, 0, 56226, 237649, },
					[286] = { 1, 0, 56240, 237632, },
					[287] = { 1, 0, 56229, 237639, },
					[288] = { 1, 0, 56216, 237640, },
					[289] = { 1, 0, 56231, 237633, },
					[290] = { 1, 0, 56250, 237652, },
					[291] = { 1, 0, 56233, 237642, },
					[292] = { 1, 0, 56247, 237643, },
					[311] = { 1, 0, 56360, 237635, },
					[312] = { 1, 0, 56363, 237637, },
					[313] = { 1, 0, 56381, 237650, },
					[314] = { 1, 0, 56365, 237641, },
					[315] = { 1, 0, 56380, 237632, },
					[316] = { 1, 0, 56368, 237651, },
					[317] = { 1, 0, 56369, 237646, },
					[318] = { 1, 0, 56376, 237647, },
					[319] = { 1, 0, 56370, 237634, },
					[320] = { 1, 0, 56384, 237648, },
					[321] = { 1, 0, 56372, 237633, },
					[322] = { 1, 0, 56377, 237644, },
					[323] = { 1, 0, 56374, 237643, },
					[324] = { 1, 0, 56371, 237649, },
					[325] = { 1, 0, 56366, 237645, },
					[326] = { 1, 0, 56383, 237652, },
					[327] = { 1, 0, 56367, 237639, },
					[328] = { 1, 0, 56382, 237640, },
					[329] = { 1, 0, 56375, 237638, },
					[330] = { 1, 0, 56364, 237642, },
					[331] = { 1, 0, 56373, 237636, },
					[351] = { 1, 0, 56824, 237647, },
					[352] = { 1, 0, 56841, 237648, },
					[353] = { 1, 0, 56857, 237635, },
					[354] = { 1, 0, 56833, 237637, },
					[355] = { 1, 0, 56851, 237641, },
					[356] = { 1, 0, 56830, 237632, },
					[357] = { 1, 0, 56850, 237643, },
					[358] = { 1, 0, 56844, 237649, },
					[359] = { 1, 0, 56845, 237633, },
					[360] = { 1, 0, 56847, 237639, },
					[361] = { 1, 0, 56829, 237652, },
					[362] = { 1, 0, 56846, 237650, },
					[363] = { 1, 0, 56856, 237636, },
					[364] = { 1, 0, 56836, 237640, },
					[365] = { 1, 0, 56828, 237644, },
					[366] = { 1, 0, 56832, 237645, },
					[367] = { 1, 0, 56849, 237646, },
					[368] = { 1, 0, 56826, 237651, },
					[369] = { 1, 0, 56842, 237634, },
					[370] = { 1, 0, 56838, 237638, },
					[371] = { 1, 0, 56848, 237642, },
					[391] = { 1, 0, 56808, 237634, },
					[392] = { 1, 0, 56813, 237650, },
					[393] = { 1, 0, 56800, 237647, },
					[394] = { 1, 0, 56818, 237645, },
					[395] = { 1, 0, 56820, 237636, },
					[396] = { 1, 0, 56806, 237638, },
					[397] = { 1, 0, 56799, 237648, },
					[398] = { 1, 0, 56802, 237635, },
					[399] = { 1, 0, 56803, 237637, },
					[400] = { 1, 0, 56804, 237652, },
					[401] = { 1, 0, 56812, 237641, },
					[402] = { 1, 0, 56814, 237640, },
					[403] = { 1, 0, 56809, 237632, },
					[404] = { 1, 0, 56807, 237646, },
					[405] = { 1, 0, 56819, 237651, },
					[406] = { 1, 0, 56801, 237644, },
					[407] = { 1, 0, 56798, 237643, },
					[408] = { 1, 0, 56805, 237642, },
					[409] = { 1, 0, 56821, 237649, },
					[410] = { 1, 0, 56810, 237633, },
					[411] = { 1, 0, 56811, 237639, },
					[431] = { 1, 1, 57856, 237645, },
					[432] = { 1, 1, 57858, 237641, },
					[433] = { 1, 1, 57855, 237635, },
					[434] = { 1, 1, 57857, 237650, },
					[435] = { 1, 1, 57862, 237632, },
					[436] = { 1, 1, 58133, 237635, },
					[438] = { 1, 1, 58132, 237638, },
					[439] = { 1, 1, 57866, 237641, },
					[440] = { 1, 1, 57870, 237636, },
					[441] = { 1, 1, 57903, 237642, },
					[442] = { 1, 1, 57902, 237642, },
					[443] = { 1, 1, 57904, 237646, },
					[444] = { 1, 1, 57900, 237650, },
					[445] = { 1, 1, 57924, 237652, },
					[446] = { 1, 1, 57926, 237647, },
					[447] = { 1, 1, 57927, 237637, },
					[448] = { 1, 1, 57928, 237633, },
					[449] = { 1, 1, 58136, 237638, },
					[450] = { 1, 1, 52648, 237639, },
					[451] = { 1, 1, 57925, 237644, },
					[452] = { 1, 1, 57937, 237646, },
					[453] = { 1, 1, 57958, 237643, },
					[454] = { 1, 1, 57979, 237645, },
					[455] = { 1, 1, 57955, 237634, },
					[456] = { 1, 1, 57947, 237651, },
					[457] = { 1, 1, 57954, 237632, },
					[458] = { 1, 1, 57985, 237651, },
					[459] = { 1, 1, 57987, 237645, },
					[460] = { 1, 1, 58009, 237640, },
					[461] = { 1, 1, 57986, 237633, },
					[462] = { 1, 1, 58015, 237652, },
					[463] = { 1, 1, 58228, 237641, },
					[464] = { 1, 1, 58032, 237635, },
					[465] = { 1, 1, 58027, 237649, },
					[466] = { 1, 1, 58017, 237637, },
					[467] = { 1, 1, 58033, 237647, },
					[468] = { 1, 1, 58039, 237652, },
					[469] = { 1, 1, 58038, 237638, },
					[470] = { 1, 1, 58058, 237640, },
					[471] = { 1, 1, 58135, 237648, },
					[472] = { 1, 1, 58134, 237648, },
					[473] = { 1, 1, 58059, 237644, },
					[474] = { 1, 1, 58055, 237639, },
					[475] = { 1, 1, 58063, 237634, },
					[476] = { 1, 1, 58057, 237643, },
					[477] = { 1, 1, 58079, 237648, },
					[478] = { 1, 1, 58070, 237649, },
					[479] = { 1, 1, 58081, 237636, },
					[480] = { 1, 1, 58080, 237637, },
					[481] = { 1, 1, 58107, 237648, },
					[482] = { 1, 1, 58094, 237640, },
					[483] = { 1, 1, 58095, 237632, },
					[484] = { 1, 1, 58096, 237646, },
					[485] = { 1, 1, 58097, 237647, },
					[486] = { 1, 1, 58099, 237648, },
					[487] = { 1, 1, 58098, 237643, },
					[488] = { 1, 1, 58104, 237639, },
					[489] = { 1, 0, 58368, 237640, },
					[490] = { 1, 0, 58369, 237636, },
					[491] = { 1, 0, 58355, 237647, },
					[492] = { 1, 0, 58366, 237633, },
					[493] = { 1, 0, 58388, 237646, },
					[494] = { 1, 0, 58367, 237639, },
					[495] = { 1, 0, 58372, 237637, },
					[496] = { 1, 0, 58357, 237648, },
					[497] = { 1, 0, 58377, 237651, },
					[498] = { 1, 0, 58365, 237649, },
					[499] = { 1, 0, 58386, 237632, },
					[500] = { 1, 0, 58385, 237635, },
					[501] = { 1, 0, 58364, 237643, },
					[502] = { 1, 0, 58375, 237644, },
					[503] = { 1, 0, 58376, 237634, },
					[504] = { 1, 0, 58387, 237641, },
					[505] = { 1, 0, 58384, 237652, },
					[506] = { 1, 0, 58353, 237638, },
					[507] = { 1, 0, 58356, 237642, },
					[508] = { 1, 0, 58382, 237645, },
					[509] = { 1, 0, 58370, 237650, },
					[511] = { 1, 0, 58613, 237634, },
					[512] = { 1, 0, 58623, 237642, },
					[513] = { 1, 0, 58616, 237636, },
					[514] = { 1, 1, 58640, 237636, },
					[515] = { 1, 0, 58673, 237647, },
					[516] = { 1, 0, 58620, 237640, },
					[518] = { 1, 1, 58677, 237651, },
					[519] = { 1, 0, 62259, 237648, },
					[520] = { 1, 0, 58629, 237645, },
					[521] = { 1, 0, 58647, 237635, },
					[522] = { 1, 1, 58680, 237638, },
					[523] = { 1, 0, 58625, 237651, },
					[524] = { 1, 0, 58631, 237637, },
					[525] = { 1, 0, 58671, 237646, },
					[526] = { 1, 0, 58657, 237641, },
					[527] = { 1, 0, 58686, 237645, },
					[528] = { 1, 0, 58669, 237638, },
					[529] = { 1, 0, 58642, 237632, },
					[530] = { 1, 0, 58618, 237644, },
					[531] = { 1, 0, 58635, 237643, },
					[532] = { 1, 0, 58676, 237649, },
					[551] = { 1, 1, 59219, 237633, },
					[552] = { 1, 1, 59289, 237634, },
					[553] = { 1, 1, 59309, 237635, },
					[554] = { 1, 1, 59307, 237650, },
					[555] = { 1, 1, 60200, 237649, },
					[556] = { 1, 0, 59327, 237633, },
					[557] = { 1, 0, 59332, 237639, },
					[558] = { 1, 0, 59336, 237650, },
					[559] = { 1, 0, 56420, 237634, },
					[560] = { 1, 0, 56414, 237642, },
					[561] = { 1, 0, 56416, 237638, },
					[571] = { 1, 1, 60200, 237652, },
					[591] = { 1, 0, 61205, 237647, },
					[611] = { 1, 1, 62126, 237652, },
					[612] = { 1, 1, 62132, 237650, },
					[613] = { 1, 1, 62135, 237634, },
					[631] = { 1, 0, 62080, 237634, },
					[651] = { 1, 0, 62210, 237648, },
					[671] = { 1, 0, 62969, 237632, },
					[672] = { 1, 0, 62970, 237633, },
					[673] = { 1, 0, 62971, 237634, },
					[674] = { 1, 0, 63055, 237635, },
					[675] = { 1, 0, 63056, 237636, },
					[676] = { 1, 0, 63057, 237637, },
					[677] = { 1, 0, 63065, 237638, },
					[691] = { 1, 0, 63066, 237639, },
					[692] = { 1, 0, 63067, 237640, },
					[693] = { 1, 0, 63068, 237641, },
					[694] = { 1, 0, 63069, 237642, },
					[695] = { 1, 0, 63086, 237643, },
					[696] = { 1, 0, 63090, 237644, },
					[697] = { 1, 0, 63091, 237645, },
					[698] = { 1, 0, 63092, 237646, },
					[699] = { 1, 0, 63093, 237647, },
					[700] = { 1, 0, 63095, 237648, },
					[701] = { 1, 0, 63218, 237649, },
					[702] = { 1, 0, 63219, 237650, },
					[703] = { 1, 0, 63220, 237651, },
					[704] = { 1, 0, 63222, 237652, },
					[705] = { 1, 0, 63223, 237632, },
					[706] = { 1, 0, 63224, 237633, },
					[707] = { 1, 0, 63225, 237634, },
					[708] = { 1, 0, 63229, 237635, },
					[709] = { 1, 0, 63231, 237636, },
					[710] = { 1, 0, 63235, 237637, },
					[711] = { 1, 0, 63237, 237638, },
					[712] = { 1, 0, 63246, 237639, },
					[713] = { 1, 0, 63248, 237640, },
					[714] = { 1, 0, 63249, 237641, },
					[715] = { 1, 0, 63252, 237642, },
					[716] = { 1, 0, 63253, 237643, },
					[731] = { 1, 0, 63254, 237644, },
					[732] = { 1, 0, 63256, 237645, },
					[733] = { 1, 0, 63268, 237646, },
					[734] = { 1, 0, 63269, 237647, },
					[735] = { 1, 0, 63270, 237648, },
					[736] = { 1, 0, 63271, 237649, },
					[737] = { 1, 0, 63273, 237650, },
					[751] = { 1, 0, 63279, 237651, },
					[752] = { 1, 0, 63280, 237652, },
					[753] = { 1, 0, 63291, 237632, },
					[754] = { 1, 0, 63298, 237633, },
					[755] = { 1, 0, 63302, 237634, },
					[756] = { 1, 0, 63303, 237635, },
					[757] = { 1, 0, 63304, 237636, },
					[758] = { 1, 0, 63309, 237637, },
					[759] = { 1, 0, 63310, 237638, },
					[760] = { 1, 0, 63320, 237639, },
					[761] = { 1, 0, 63312, 237640, },
					[762] = { 1, 0, 63324, 237641, },
					[763] = { 1, 0, 63325, 237642, },
					[764] = { 1, 0, 63326, 237643, },
					[765] = { 1, 0, 63327, 237644, },
					[766] = { 1, 0, 63328, 237645, },
					[767] = { 1, 0, 63329, 237646, },
					[768] = { 1, 0, 63330, 237647, },
					[769] = { 1, 0, 63331, 237648, },
					[770] = { 1, 0, 63332, 237649, },
					[771] = { 1, 0, 63333, 237650, },
					[772] = { 1, 0, 63334, 237651, },
					[773] = { 1, 0, 63335, 237652, },
					[791] = { 1, 0, 64199, 237652, },
					[811] = { 1, 0, 65243, 237639, },
					[831] = { 1, 0, 67598, 237643, },
					[851] = { 1, 1, 68164, 237640, },
					[871] = { 1, 0, 70937, 237641, },
					[891] = { 1, 0, 71013, 237633, },
					[911] = { 1, 0, 70947, 237651, },
					[1436] = { 1, 0, 405004, 237641, },
					[1437] = { 1, 0, 413895, 237635, },
					[1438] = { 1, 1, 414812, 237636, },
				};
			elseif CT.TOCVERSION < 50000 then
				--	https://wago.tools/db2/GlyphProperties?build=4.4.2.60142&page=1&sort%5BID%5D=asc
				self.GlyphInfo = {
					[161] = { 1, 0, 54810, 237636, },
					[162] = { 1, 0, 54811, 237635, },
					[163] = { 1, 0, 54812, 237651, },
					[164] = { 1, 2, 54813, 237646, },
					[165] = { 1, 2, 54815, 237652, },
					[166] = { 1, 2, 54818, 237633, },
					[167] = { 1, 0, 54821, 237650, },
					[168] = { 1, 2, 54824, 237645, },
					[169] = { 1, 0, 54832, 237644, },
					[170] = { 1, 0, 54733, 237649, },
					[171] = { 1, 2, 54743, 237634, },
					[172] = { 1, 2, 54754, 237647, },
					[173] = { 1, 0, 54825, 237641, },
					[174] = { 1, 2, 54826, 237642, },
					[175] = { 1, 2, 54845, 237639, },
					[176] = { 1, 2, 54830, 237643, },
					[177] = { 1, 0, 54831, 237640, },
					[178] = { 1, 0, 54828, 237638, },
					[179] = { 1, 2, 54756, 237648, },
					[180] = { 1, 2, 54829, 237632, },
					[181] = { 1, 0, 54760, 237637, },
					[183] = { 1, 2, 54922, 237650, },
					[184] = { 1, 0, 54925, 237644, },
					[185] = { 1, 0, 54923, 237633, },
					[186] = { 1, 0, 54924, 237637, },
					[187] = { 1, 0, 54926, 237639, },
					[188] = { 1, 2, 54927, 237632, },
					[189] = { 1, 0, 54928, 237641, },
					[190] = { 1, 1, 89401, 237640, },
					[191] = { 1, 0, 54930, 237647, },
					[192] = { 1, 0, 54931, 237651, },
					[193] = { 1, 2, 54934, 237643, },
					[194] = { 1, 0, 54935, 237648, },
					[195] = { 1, 2, 54936, 237649, },
					[196] = { 1, 2, 54937, 237652, },
					[197] = { 1, 0, 54938, 237635, },
					[198] = { 1, 0, 54939, 237636, },
					[199] = { 1, 0, 54940, 237646, },
					[200] = { 1, 2, 54943, 237645, },
					[211] = { 1, 2, 55436, 237639, },
					[212] = { 1, 0, 55437, 237640, },
					[213] = { 1, 0, 55449, 237636, },
					[214] = { 1, 2, 55454, 237638, },
					[215] = { 1, 2, 55442, 237646, },
					[216] = { 1, 2, 55439, 237652, },
					[217] = { 1, 2, 55455, 237642, },
					[218] = { 1, 0, 55450, 237635, },
					[219] = { 1, 2, 55447, 237647, },
					[220] = { 1, 2, 55451, 237637, },
					[221] = { 1, 0, 55443, 237643, },
					[222] = { 1, 0, 55456, 237649, },
					[223] = { 1, 0, 55440, 237651, },
					[224] = { 1, 0, 55438, 237633, },
					[225] = { 1, 0, 55448, 237648, },
					[226] = { 1, 2, 55453, 237641, },
					[227] = { 1, 0, 55441, 237644, },
					[228] = { 1, 2, 55446, 237645, },
					[229] = { 1, 2, 55444, 237632, },
					[230] = { 1, 0, 55452, 237634, },
					[231] = { 1, 2, 55445, 237650, },
					[251] = { 1, 0, 55675, 237634, },
					[252] = { 1, 0, 55677, 237633, },
					[253] = { 1, 0, 55684, 237635, },
					[254] = { 1, 0, 55678, 237639, },
					[255] = { 1, 2, 55679, 237637, },
					[256] = { 1, 0, 55683, 237652, },
					[257] = { 1, 0, 55686, 237641, },
					[258] = { 1, 2, 55673, 237651, },
					[259] = { 1, 0, 55691, 237642, },
					[260] = { 1, 0, 55688, 237644, },
					[261] = { 1, 2, 55681, 237650, },
					[262] = { 1, 2, 55689, 237636, },
					[263] = { 1, 2, 55672, 237647, },
					[264] = { 1, 2, 55680, 237645, },
					[265] = { 1, 0, 55676, 237648, },
					[266] = { 1, 2, 55674, 237632, },
					[267] = { 1, 0, 55690, 237640, },
					[268] = { 1, 2, 55682, 237638, },
					[269] = { 1, 2, 55687, 237643, },
					[270] = { 1, 0, 55692, 237649, },
					[271] = { 1, 0, 55685, 237646, },
					[272] = { 1, 2, 56242, 237650, },
					[273] = { 1, 2, 56235, 237644, },
					[274] = { 1, 2, 56218, 237647, },
					[275] = { 1, 2, 56241, 237646, },
					[276] = { 1, 0, 56232, 237634, },
					[277] = { 1, 0, 56244, 237637, },
					[278] = { 1, 2, 56246, 237638, },
					[279] = { 1, 0, 56249, 237636, },
					[280] = { 1, 1, 56238, 237635, },
					[281] = { 1, 0, 56224, 237648, },
					[282] = { 1, 0, 56217, 237645, },
					[283] = { 1, 2, 56228, 237651, },
					[284] = { 1, 2, 56248, 237641, },
					[285] = { 1, 0, 56226, 237649, },
					[286] = { 1, 0, 56240, 237632, },
					[287] = { 1, 2, 56229, 237639, },
					[289] = { 1, 0, 56231, 237633, },
					[290] = { 1, 0, 56250, 237652, },
					[291] = { 1, 2, 56233, 237642, },
					[292] = { 1, 0, 56247, 237643, },
					[312] = { 1, 2, 56363, 237637, },
					[313] = { 1, 0, 56381, 237650, },
					[314] = { 1, 0, 56365, 237641, },
					[315] = { 1, 0, 56380, 237632, },
					[316] = { 1, 2, 56368, 237651, },
					[318] = { 1, 0, 56376, 237647, },
					[319] = { 1, 2, 56370, 237634, },
					[320] = { 1, 2, 56384, 237648, },
					[321] = { 1, 0, 56372, 237633, },
					[322] = { 1, 2, 56377, 237644, },
					[323] = { 1, 0, 56374, 237643, },
					[325] = { 1, 0, 56366, 237645, },
					[326] = { 1, 2, 56383, 237652, },
					[328] = { 1, 2, 56382, 237640, },
					[329] = { 1, 0, 56375, 237638, },
					[330] = { 1, 2, 56364, 237642, },
					[331] = { 1, 0, 56373, 237636, },
					[351] = { 1, 2, 56824, 237647, },
					[352] = { 1, 2, 56841, 237648, },
					[353] = { 1, 0, 56857, 237635, },
					[354] = { 1, 0, 56833, 237637, },
					[355] = { 1, 0, 56851, 237641, },
					[356] = { 1, 0, 56830, 237632, },
					[357] = { 1, 0, 56850, 237643, },
					[358] = { 1, 0, 56844, 237649, },
					[359] = { 1, 0, 56845, 237633, },
					[360] = { 1, 0, 56847, 237639, },
					[361] = { 1, 0, 56829, 237652, },
					[362] = { 1, 0, 56846, 237650, },
					[363] = { 1, 2, 56856, 237636, },
					[364] = { 1, 0, 56836, 237640, },
					[365] = { 1, 2, 56828, 237644, },
					[366] = { 1, 2, 56832, 237645, },
					[367] = { 1, 0, 56849, 237646, },
					[368] = { 1, 2, 56826, 237651, },
					[369] = { 1, 2, 56842, 237634, },
					[371] = { 1, 0, 56848, 237642, },
					[391] = { 1, 2, 56808, 237634, },
					[392] = { 1, 0, 56813, 237650, },
					[393] = { 1, 2, 56800, 237647, },
					[394] = { 1, 0, 56818, 237645, },
					[395] = { 1, 0, 56820, 237636, },
					[396] = { 1, 0, 56806, 237638, },
					[397] = { 1, 0, 56799, 237648, },
					[398] = { 1, 2, 56802, 237635, },
					[399] = { 1, 0, 56803, 237637, },
					[400] = { 1, 0, 56804, 237652, },
					[401] = { 1, 0, 56812, 237641, },
					[402] = { 1, 2, 56814, 237640, },
					[403] = { 1, 0, 56809, 237632, },
					[404] = { 1, 2, 56807, 237646, },
					[405] = { 1, 0, 56819, 237651, },
					[406] = { 1, 2, 56801, 237644, },
					[407] = { 1, 0, 56798, 237643, },
					[409] = { 1, 2, 56821, 237649, },
					[410] = { 1, 2, 56810, 237633, },
					[411] = { 1, 0, 56811, 237639, },
					[431] = { 1, 1, 57856, 237645, },
					[432] = { 1, 1, 57858, 237641, },
					[433] = { 1, 1, 57855, 237635, },
					[434] = { 1, 1, 57857, 237650, },
					[435] = { 1, 0, 57862, 237632, },
					[439] = { 1, 1, 57866, 237641, },
					[440] = { 1, 1, 57870, 237636, },
					[441] = { 1, 1, 57903, 237642, },
					[442] = { 1, 1, 57902, 237642, },
					[443] = { 1, 1, 57904, 237646, },
					[445] = { 1, 1, 57924, 237652, },
					[447] = { 1, 1, 57927, 237637, },
					[448] = { 1, 1, 57928, 237633, },
					[449] = { 1, 1, 58136, 237638, },
					[450] = { 1, 1, 52648, 237639, },
					[451] = { 1, 1, 57925, 237644, },
					[452] = { 1, 1, 57937, 237646, },
					[453] = { 1, 1, 57958, 237643, },
					[454] = { 1, 1, 57979, 237645, },
					[455] = { 1, 0, 57955, 237634, },
					[456] = { 1, 1, 57947, 237651, },
					[457] = { 1, 1, 57954, 237632, },
					[458] = { 1, 1, 57985, 237651, },
					[459] = { 1, 1, 57987, 237645, },
					[460] = { 1, 1, 58009, 237640, },
					[461] = { 1, 1, 57986, 237633, },
					[462] = { 1, 1, 58015, 237652, },
					[463] = { 1, 1, 58228, 237641, },
					[464] = { 1, 1, 58032, 237635, },
					[465] = { 1, 1, 58027, 237649, },
					[466] = { 1, 1, 58017, 237637, },
					[467] = { 1, 1, 58033, 237647, },
					[468] = { 1, 1, 58039, 237652, },
					[469] = { 1, 1, 58038, 237638, },
					[470] = { 1, 1, 58058, 237640, },
					[471] = { 1, 1, 58135, 237648, },
					[473] = { 1, 1, 58059, 237644, },
					[474] = { 1, 1, 89646, 237639, },
					[476] = { 1, 1, 58057, 237643, },
					[477] = { 1, 1, 58079, 237648, },
					[478] = { 1, 1, 58070, 237649, },
					[479] = { 1, 1, 58081, 237636, },
					[480] = { 1, 1, 58080, 237637, },
					[481] = { 1, 1, 58107, 237648, },
					[482] = { 1, 1, 58094, 237640, },
					[483] = { 1, 1, 58095, 237632, },
					[484] = { 1, 1, 58096, 237646, },
					[485] = { 1, 0, 58097, 237647, },
					[486] = { 1, 1, 58099, 237648, },
					[487] = { 1, 0, 58098, 237643, },
					[488] = { 1, 1, 58104, 237639, },
					[489] = { 1, 2, 58368, 237640, },
					[490] = { 1, 1, 58369, 237636, },
					[491] = { 1, 0, 58355, 237647, },
					[492] = { 1, 0, 58366, 237633, },
					[493] = { 1, 2, 58388, 237646, },
					[494] = { 1, 2, 58367, 237639, },
					[495] = { 1, 0, 58372, 237637, },
					[496] = { 1, 0, 58357, 237648, },
					[497] = { 1, 0, 58377, 237651, },
					[499] = { 1, 2, 58386, 237632, },
					[500] = { 1, 2, 58385, 237635, },
					[501] = { 1, 2, 58364, 237643, },
					[502] = { 1, 2, 58375, 237644, },
					[504] = { 1, 0, 58387, 237641, },
					[505] = { 1, 0, 58384, 237652, },
					[507] = { 1, 0, 58356, 237642, },
					[508] = { 1, 0, 58382, 237645, },
					[509] = { 1, 2, 58370, 237650, },
					[512] = { 1, 0, 58623, 237642, },
					[513] = { 1, 2, 58616, 237636, },
					[514] = { 1, 1, 58640, 237636, },
					[515] = { 1, 0, 58673, 237647, },
					[516] = { 1, 0, 58620, 237640, },
					[518] = { 1, 1, 58677, 237651, },
					[519] = { 1, 0, 62259, 237648, },
					[520] = { 1, 2, 58629, 237645, },
					[521] = { 1, 2, 58647, 237635, },
					[522] = { 1, 1, 58680, 237638, },
					[524] = { 1, 2, 58631, 237637, },
					[525] = { 1, 2, 58671, 237646, },
					[526] = { 1, 0, 58657, 237641, },
					[527] = { 1, 2, 58686, 237645, },
					[528] = { 1, 2, 58669, 237638, },
					[529] = { 1, 2, 58642, 237632, },
					[530] = { 1, 0, 58618, 237644, },
					[531] = { 1, 0, 58635, 237643, },
					[532] = { 1, 0, 58676, 237649, },
					[551] = { 1, 1, 59219, 237633, },
					[552] = { 1, 0, 59289, 237634, },
					[553] = { 1, 1, 59309, 237635, },
					[554] = { 1, 1, 59307, 237650, },
					[555] = { 1, 1, 60200, 237649, },
					[556] = { 1, 0, 59327, 237633, },
					[557] = { 1, 0, 59332, 237639, },
					[558] = { 1, 2, 59336, 237650, },
					[559] = { 1, 0, 56420, 237634, },
					[560] = { 1, 0, 56414, 237642, },
					[561] = { 1, 2, 56416, 237638, },
					[591] = { 1, 2, 61205, 237647, },
					[611] = { 1, 0, 62126, 237652, },
					[612] = { 1, 1, 62132, 237650, },
					[613] = { 1, 1, 62135, 237634, },
					[631] = { 1, 0, 62080, 237634, },
					[651] = { 1, 2, 62210, 237648, },
					[671] = { 1, 2, 62969, 237632, },
					[672] = { 1, 0, 62970, 237633, },
					[673] = { 1, 2, 62971, 237634, },
					[674] = { 1, 2, 63055, 237635, },
					[675] = { 1, 0, 63056, 237636, },
					[676] = { 1, 0, 63057, 237637, },
					[677] = { 1, 2, 63065, 237638, },
					[691] = { 1, 2, 63066, 237639, },
					[692] = { 1, 2, 63067, 237640, },
					[693] = { 1, 0, 63068, 237641, },
					[694] = { 1, 0, 63069, 237642, },
					[695] = { 1, 0, 63086, 237643, },
					[696] = { 1, 2, 63090, 237644, },
					[697] = { 1, 0, 63091, 237645, },
					[698] = { 1, 2, 63092, 237646, },
					[699] = { 1, 1, 63093, 237647, },
					[700] = { 1, 0, 63095, 237648, },
					[701] = { 1, 0, 63218, 237649, },
					[702] = { 1, 2, 63219, 237650, },
					[703] = { 1, 2, 63220, 237651, },
					[704] = { 1, 2, 63222, 237652, },
					[705] = { 1, 0, 63223, 237632, },
					[706] = { 1, 2, 63224, 237633, },
					[707] = { 1, 0, 63225, 237634, },
					[708] = { 1, 2, 63229, 237635, },
					[709] = { 1, 2, 63231, 237636, },
					[710] = { 1, 2, 63235, 237637, },
					[711] = { 1, 0, 63237, 237638, },
					[712] = { 1, 0, 63246, 237639, },
					[713] = { 1, 0, 63248, 237640, },
					[714] = { 1, 2, 63249, 237641, },
					[715] = { 1, 2, 63252, 237642, },
					[716] = { 1, 2, 63253, 237643, },
					[731] = { 1, 0, 63254, 237644, },
					[732] = { 1, 0, 63256, 237645, },
					[733] = { 1, 2, 63268, 237646, },
					[734] = { 1, 0, 63269, 237647, },
					[735] = { 1, 0, 63270, 237648, },
					[736] = { 1, 2, 63271, 237649, },
					[737] = { 1, 2, 63273, 237650, },
					[751] = { 1, 2, 63279, 237651, },
					[752] = { 1, 0, 63280, 237652, },
					[753] = { 1, 0, 63291, 237632, },
					[754] = { 1, 0, 63298, 237633, },
					[755] = { 1, 2, 63302, 237634, },
					[756] = { 1, 2, 63303, 237635, },
					[757] = { 1, 2, 63304, 237636, },
					[758] = { 1, 0, 63309, 237637, },
					[759] = { 1, 0, 63310, 237638, },
					[760] = { 1, 0, 63320, 237639, },
					[761] = { 1, 0, 63312, 237640, },
					[762] = { 1, 2, 63324, 237641, },
					[763] = { 1, 0, 63325, 237642, },
					[764] = { 1, 1, 63326, 237643, },
					[765] = { 1, 1, 63327, 237644, },
					[766] = { 1, 0, 63328, 237645, },
					[767] = { 1, 0, 63329, 237646, },
					[768] = { 1, 0, 63330, 237647, },
					[769] = { 1, 0, 63331, 237648, },
					[771] = { 1, 2, 63333, 237650, },
					[773] = { 1, 2, 63335, 237652, },
					[831] = { 1, 0, 67598, 237643, },
					[851] = { 1, 1, 68164, 237640, },
					[871] = { 1, 0, 70937, 237641, },
					[911] = { 1, 2, 70947, 237651, },
					[920] = { 1, 1, 58136, 237638, },
					[923] = { 1, 1, 89749, 0, },
					[924] = { 1, 0, 89758, 237652, },
					[926] = { 1, 0, 56805, 237648, },
					[927] = { 1, 0, 89003, 0, },
					[928] = { 1, 2, 89926, 237651, },
					[929] = { 1, 0, 91299, 237652, },
					[930] = { 1, 0, 93466, 237636, },
					[931] = { 1, 0, 94372, 237648, },
					[932] = { 1, 0, 94374, 237638, },
					[933] = { 1, 2, 94382, 237643, },
					[934] = { 1, 0, 94386, 237643, },
					[935] = { 1, 0, 94388, 237643, },
					[936] = { 1, 2, 94390, 237643, },
					[937] = { 1, 1, 95212, 237634, },
					[945] = { 1, 0, 96279, 237650, },
					[948] = { 1, 0, 98397, 237652, },
					[950] = { 1, 2, 101052, 237641, },
					[961] = { 1, 1, 107906, 237645, },
				}
			end
		end,
	};

	MT.RegisterOnInit('EXTERNAL', function(LoggedIn)
		for prefix, addon in next, VT.ExternalAddOn do
			if addon.init ~= nil then
				addon:init();
			end
			if not IsAddonMessagePrefixRegistered(prefix) then
				RegisterAddonMessagePrefix(prefix);
			end
		end
		for media, codec in next, VT.ExternalCodec do
			if codec.init ~= nil then
				codec:init();
			end
			if codec.ExportCode ~= nil then
				VT.ExportButtonMenuDefinition.num = VT.ExportButtonMenuDefinition.num + 1;
				VT.ExportButtonMenuDefinition[VT.ExportButtonMenuDefinition.num] = {
					param = codec,
					text = media,
				};
			end
		end
	end);
	MT.RegisterOnLogin('EXTERNAL', function(LoggedIn)
	end);

-->
