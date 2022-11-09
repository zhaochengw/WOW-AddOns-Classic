-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

if WOW_PROJECT_ID == WOW_PROJECT_MAINLINE then
	FLO_ASPECT_SPELLS = {
		["HUNTER"] = {
			{ id = 186257, duration = 12 },
			{ id = 193530, duration = 20 },
			{ id = 61648, duration = 60 },
			{ id = 186289, duration = 15 },
			{ id = 186265, duration = 8 }
		}
	};
elseif WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
	FLO_ASPECT_SPELLS = {
		["HUNTER"] = {
			{ id = 13163 }, -- monkey
			{ id = 13165 }, -- hawk
			{ id = 5118 }, -- cheetah
			{ id = 13161 }, -- beast
			{ id = 13159 }, -- pack
			{ id = 20043 } -- nature
		}
	};
elseif WOW_PROJECT_ID == WOW_PROJECT_BURNING_CRUSADE_CLASSIC then
	FLO_ASPECT_SPELLS = {
		["HUNTER"] = {
			{ id = 13163 }, -- monkey
			{ id = 13165 }, -- hawk
			{ id = 5118 }, -- cheetah
			{ id = 13161 }, -- beast
			{ id = 13159 }, -- pack
			{ id = 20043 }, -- nature
			{ id = 34074 }, -- viper
			{ id = 61846 }, -- dragonhawk
		}
	};
elseif WOW_PROJECT_ID == WOW_PROJECT_WRATH_CLASSIC then
	FLO_ASPECT_SPELLS = {
		["HUNTER"] = {
			{ id = 13163 }, -- monkey
			{ id = 27044 }, -- hawk
			{ id = 5118 }, -- cheetah
			{ id = 13161 }, -- beast
			{ id = 13159 }, -- pack
			{ id = 49071 }, -- nature
			{ id = 34074 }, -- viper
			{ id = 61847 }, -- dragonhawk
		}
	};
end
