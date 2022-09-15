
	----------------------------------------------------------------------
	-- Leatrix Plus Flight
	----------------------------------------------------------------------

	local void, Leatrix_Plus = ...
	local L = Leatrix_Plus.L

	-- Function to load flight data (load-on-demand)
	function Leatrix_Plus:LoadFlightData()

		Leatrix_Plus["FlightData"] = {

			----------------------------------------------------------------------
			--	Horde
			----------------------------------------------------------------------

			["Horde"] = {

				-- Horde: Eastern Kingdoms
				[1415] = {

					-- Horde: Acherus (Eastern Plaguelands)
					["0.62:0.34:0.61:0.35:0.61:0.28:0.58:0.06"] = 392, -- Acherus: The Ebon Hold, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.62:0.34:0.61:0.35:0.58:0.25:0.59:0.19"] = 234, -- Acherus: The Ebon Hold, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.62:0.34:0.61:0.35:0.58:0.25"] = 169, -- Acherus: The Ebon Hold, Light's Hope Chapel, Tranquillien
					["0.62:0.34:0.61:0.35:0.61:0.28"] = 145, -- Acherus: The Ebon Hold, Light's Hope Chapel, Zul'Aman
					["0.62:0.34:0.61:0.35"] = 52, -- Acherus: The Ebon Hold, Light's Hope Chapel
					["0.62:0.34:0.61:0.35:0.51:0.36"] = 147, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River
					["0.62:0.34:0.61:0.35:0.51:0.36:0.45:0.37"] = 223, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River, The Bulwark
					["0.62:0.34:0.61:0.35:0.51:0.36:0.42:0.37"] = 307, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River, Undercity
					["0.62:0.34:0.61:0.35:0.51:0.36:0.46:0.43:0.37:0.41"] = 350, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River, Tarren Mill, The Sepulcher
					["0.62:0.34:0.61:0.35:0.51:0.36:0.46:0.43"] = 247, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River, Tarren Mill
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46"] = 282, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.62:0.34:0.61:0.35:0.59:0.45"] = 189, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 595, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 540, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 606, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 763, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 777, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.62:0.34:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 836, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.62:0.34:0.61:0.35:0.42:0.37"] = 310, -- Acherus: The Ebon Hold, Light's Hope Chapel, Undercity
					["0.62:0.34:0.61:0.35:0.42:0.37:0.37:0.41"] = 345, -- Acherus: The Ebon Hold, Light's Hope Chapel, Undercity, The Sepulcher
					["0.62:0.34:0.61:0.35:0.59:0.45:0.46:0.43"] = 348, -- Acherus: The Ebon Hold, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.62:0.34:0.61:0.35:0.42:0.37:0.45:0.37"] = 328, -- Acherus: The Ebon Hold, Light's Hope Chapel, Undercity, The Bulwark
					["0.62:0.34:0.61:0.35:0.58:0.25:0.59:0.19:0.58:0.06"] = 417, -- Acherus: The Ebon Hold, Light's Hope Chapel, Tranquillien, Silvermoon City, Shattered Sun Staging Area

					-- Horde: Booty Bay (Stranglethorn Vale)
					["0.41:0.93:0.42:0.86"] = 75, -- Booty Bay, Grom'gol
					["0.41:0.93:0.54:0.79"] = 240, -- Booty Bay, Stonard
					["0.41:0.93:0.42:0.86:0.50:0.69"] = 273, -- Booty Bay, Grom'gol, Flame Crest
					["0.41:0.93:0.50:0.66"] = 315, -- Booty Bay, Kargath
					["0.41:0.93:0.42:0.86:0.50:0.69:0.46:0.65"] = 304, -- Booty Bay, Grom'gol, Flame Crest, Thorium Point
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 789, -- Booty Bay, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.41:0.93:0.50:0.66:0.42:0.37"] = 811, -- Booty Bay, Kargath, Undercity
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43"] = 692, -- Booty Bay, Kargath, Hammerfall, Tarren Mill
					["0.41:0.93:0.50:0.66:0.55:0.46"] = 576, -- Booty Bay, Kargath, Hammerfall
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45"] = 665, -- Booty Bay, Kargath, Hammerfall, Revantusk Village
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 804, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 920, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 986, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 897, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 1145, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.41:0.93:0.50:0.66:0.42:0.37:0.61:0.35"] = 1000, -- Booty Bay, Kargath, Undercity, Light's Hope Chapel
					["0.41:0.93:0.50:0.66:0.46:0.65"] = 370, -- Booty Bay, Kargath, Thorium Point
					["0.41:0.93:0.50:0.66:0.50:0.69"] = 381, -- Booty Bay, Kargath, Flame Crest
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 760, -- Booty Bay, Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.41:0.93:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 792, -- Booty Bay, Kargath, Hammerfall, Tarren Mill, Thondroril River
					["0.41:0.93:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 864, -- Booty Bay, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.41:0.93:0.50:0.66:0.42:0.37:0.46:0.43"] = 881, -- Booty Bay, Kargath, Undercity, Tarren Mill

					-- Horde: Flame Crest (Burning Steppes)
					["0.50:0.69:0.42:0.86:0.41:0.93"] = 284, -- Flame Crest, Grom'gol, Booty Bay
					["0.50:0.69:0.42:0.86"] = 207, -- Flame Crest, Grom'gol
					["0.50:0.69:0.54:0.79"] = 192, -- Flame Crest, Stonard
					["0.50:0.69:0.50:0.66"] = 81, -- Flame Crest, Kargath
					["0.50:0.69:0.46:0.65"] = 62, -- Flame Crest, Thorium Point
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 557, -- Flame Crest, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.50:0.69:0.50:0.66:0.42:0.37"] = 578, -- Flame Crest, Kargath, Undercity
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43"] = 458, -- Flame Crest, Kargath, Hammerfall, Tarren Mill
					["0.50:0.69:0.50:0.66:0.55:0.46"] = 343, -- Flame Crest, Kargath, Hammerfall
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45"] = 433, -- Flame Crest, Kargath, Hammerfall, Revantusk Village
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 571, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 687, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 754, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 912, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 665, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.50:0.69:0.50:0.66:0.41:0.93"] = 378, -- Flame Crest, Kargath, Booty Bay
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 527, -- Flame Crest, Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.50:0.69:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 559, -- Flame Crest, Kargath, Hammerfall, Tarren Mill, Thondroril River
					["0.50:0.69:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 632, -- Flame Crest, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.50:0.69:0.50:0.66:0.42:0.37:0.46:0.43"] = 645, -- Flame Crest, Kargath, Undercity, Tarren Mill
					["0.50:0.69:0.50:0.66:0.42:0.37:0.61:0.35"] = 767, -- Flame Crest, Kargath, Undercity, Light's Hope Chapel

					-- Horde: Grom'gol (Stranglethorn Vale)
					["0.42:0.86:0.41:0.93"] = 78, -- Grom'gol, Booty Bay
					["0.42:0.86:0.54:0.79"] = 173, -- Grom'gol, Stonard
					["0.42:0.86:0.50:0.69"] = 198, -- Grom'gol, Flame Crest
					["0.42:0.86:0.50:0.66"] = 246, -- Grom'gol, Kargath
					["0.42:0.86:0.50:0.69:0.46:0.65"] = 230, -- Grom'gol, Flame Crest, Thorium Point
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 722, -- Grom'gol, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.42:0.86:0.50:0.66:0.42:0.37"] = 743, -- Grom'gol, Kargath, Undercity
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43"] = 624, -- Grom'gol, Kargath, Hammerfall, Tarren Mill
					["0.42:0.86:0.50:0.66:0.55:0.46"] = 508, -- Grom'gol, Kargath, Hammerfall
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45"] = 597, -- Grom'gol, Kargath, Hammerfall, Revantusk Village
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 736, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 851, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 918, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.42:0.86:0.50:0.66:0.46:0.65"] = 302, -- Grom'gol, Kargath, Thorium Point
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 829, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 1077, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 692, -- Grom'gol, Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.42:0.86:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 724, -- Grom'gol, Kargath, Hammerfall, Tarren Mill, Thondroril River
					["0.42:0.86:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 797, -- Grom'gol, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.42:0.86:0.50:0.66:0.42:0.37:0.46:0.43"] = 810, -- Grom'gol, Kargath, Undercity, Tarren Mill
					["0.42:0.86:0.50:0.66:0.42:0.37:0.59:0.45"] = 952, -- Grom'gol, Kargath, Undercity, Revantusk Village

					-- Horde: Hammerfall (Arathi Highlands)
					["0.55:0.46:0.50:0.66:0.41:0.93"] = 556, -- Hammerfall, Kargath, Booty Bay
					["0.55:0.46:0.50:0.66:0.42:0.86"] = 497, -- Hammerfall, Kargath, Grom'gol
					["0.55:0.46:0.50:0.66:0.54:0.79"] = 482, -- Hammerfall, Kargath, Stonard
					["0.55:0.46:0.50:0.66:0.50:0.69"] = 326, -- Hammerfall, Kargath, Flame Crest
					["0.55:0.46:0.50:0.66"] = 259, -- Hammerfall, Kargath
					["0.55:0.46:0.50:0.66:0.46:0.65"] = 315, -- Hammerfall, Kargath, Thorium Point
					["0.55:0.46:0.59:0.45"] = 91, -- Hammerfall, Revantusk Village
					["0.55:0.46:0.59:0.45:0.61:0.35"] = 229, -- Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 345, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 411, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.55:0.46:0.42:0.37"] = 259, -- Hammerfall, Undercity
					["0.55:0.46:0.46:0.43"] = 117, -- Hammerfall, Tarren Mill
					["0.55:0.46:0.46:0.43:0.37:0.41"] = 215, -- Hammerfall, Tarren Mill, The Sepulcher
					["0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 322, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.55:0.46:0.46:0.43:0.42:0.37:0.61:0.35:0.61:0.28"] = 532, -- Hammerfall, Tarren Mill, Undercity, Light's Hope Chapel, Zul'Aman
					["0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 571, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.55:0.46:0.46:0.43:0.42:0.37:0.61:0.35"] = 441, -- Hammerfall, Tarren Mill, Undercity, Light's Hope Chapel
					["0.55:0.46:0.46:0.43:0.45:0.37"] = 185, -- Hammerfall, Tarren Mill, The Bulwark
					["0.55:0.46:0.46:0.43:0.51:0.36"] = 217, -- Hammerfall, Tarren Mill, Thondroril River
					["0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 290, -- Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Horde: Kargath (Badlands)
					["0.50:0.66:0.41:0.93"] = 298, -- Kargath, Booty Bay
					["0.50:0.66:0.42:0.86"] = 239, -- Kargath, Grom'gol
					["0.50:0.66:0.54:0.79"] = 225, -- Kargath, Stonard
					["0.50:0.66:0.50:0.69"] = 68, -- Kargath, Flame Crest
					["0.50:0.66:0.46:0.65"] = 56, -- Kargath, Thorium Point
					["0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 477, -- Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.50:0.66:0.42:0.37"] = 498, -- Kargath, Undercity
					["0.50:0.66:0.55:0.46:0.46:0.43"] = 379, -- Kargath, Hammerfall, Tarren Mill
					["0.50:0.66:0.55:0.46"] = 263, -- Kargath, Hammerfall
					["0.50:0.66:0.55:0.46:0.59:0.45"] = 353, -- Kargath, Hammerfall, Revantusk Village
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 490, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 606, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 673, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 585, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 832, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.50:0.66:0.42:0.37:0.61:0.35"] = 686, -- Kargath, Undercity, Light's Hope Chapel
					["0.50:0.66:0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 870, -- Kargath, Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.50:0.66:0.42:0.37:0.37:0.41"] = 532, -- Kargath, Undercity, The Sepulcher
					["0.50:0.66:0.42:0.37:0.46:0.43"] = 565, -- Kargath, Undercity, Tarren Mill
					["0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 447, -- Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 479, -- Kargath, Hammerfall, Tarren Mill, Thondoril River
					["0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 551, -- Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.50:0.66:0.42:0.37:0.51:0.36"] = 582, -- Kargath, Undercity, Thondoril River
					["0.50:0.66:0.42:0.37:0.45:0.37"] = 517, -- Kargath, Undercity, The Bulwark
					["0.50:0.66:0.42:0.37:0.59:0.45"] = 706, -- Kargath, Undercity, Revantusk Village

					-- Horde: Light's Hope Chapel (Eastern Plaguelands)
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 789, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 730, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 716, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 560, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 492, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 548, -- Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.61:0.35:0.59:0.45:0.55:0.46"] = 234, -- Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.61:0.35:0.59:0.45"] = 141, -- Light's Hope Chapel, Revantusk Village
					["0.61:0.35:0.58:0.25"] = 118, -- Light's Hope Chapel, Tranquillien
					["0.61:0.35:0.58:0.25:0.59:0.19"] = 186, -- Light's Hope Chapel, Tranquillien, Silvermoon City (was 184, changed to 190 by GurnsyTV on CurseForge, changed to 186 by Jon Kipp Lauesen)
					["0.61:0.35:0.59:0.45:0.46:0.43"] = 301, -- Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.61:0.35:0.42:0.37"] = 262, -- Light's Hope Chapel, Undercity
					["0.61:0.35:0.42:0.37:0.37:0.41"] = 294, -- Light's Hope Chapel, Undercity, The Sepulcher
					["0.61:0.35:0.42:0.37:0.46:0.43"] = 326, -- Light's Hope Chapel, Undercity, Tarren Mill
					["0.61:0.35:0.42:0.37:0.46:0.43:0.55:0.46"] = 444, -- Light's Hope Chapel, Undercity, Tarren Mill, Hammerfall (was 262, changed by B R)
					["0.61:0.35:0.61:0.28"] = 98, -- Light's Hope Chapel, Zul'Aman
					["0.61:0.35:0.42:0.37:0.50:0.66"] = 673, -- Light's Hope Chapel, Undercity, Kargath
					["0.61:0.35:0.61:0.28:0.58:0.06"] = 344, -- Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.61:0.35:0.42:0.37:0.50:0.66:0.42:0.86"] = 911, -- Light's Hope Chapel, Undercity, Kargath, Grom'gol
					["0.61:0.35:0.42:0.37:0.50:0.66:0.50:0.69"] = 740, -- Light's Hope Chapel, Undercity, Kargath, Flame Crest
					["0.61:0.35:0.58:0.25:0.59:0.19:0.58:0.06"] = 368, -- Light's Hope Chapel, Tranquillien, Silvermoon City, Shattered Sun Staging Area
					["0.61:0.35:0.42:0.37:0.50:0.66:0.46:0.65"] = 729, -- Light's Hope Chapel, Undercity, Kargath, Thorium Point
					["0.61:0.35:0.42:0.37:0.50:0.66:0.41:0.93"] = 970, -- Light's Hope Chapel, Undercity, Kargath, Booty Bay
					["0.61:0.35:0.42:0.37:0.50:0.66:0.54:0.79"] = 896, -- Light's Hope Chapel, Undercity, Kargath, Stonard
					["0.61:0.35:0.42:0.37:0.45:0.37"] = 280, -- Light's Hope Chapel, Undercity, The Bulwark
					["0.61:0.35:0.51:0.36:0.45:0.37"] = 174, -- Light's Hope Chapel, Thondroril River, The Bulwark
					["0.61:0.35:0.51:0.36"] = 99, -- Light's Hope Chapel, Thondroril River
					["0.61:0.35:0.62:0.34"] = 65, -- Light's Hope Chapel, Acherus: The Ebon Hold
					["0.61:0.35:0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 629, -- Light's Hope Chapel, Thondoril River, Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.61:0.35:0.51:0.36:0.46:0.43:0.37:0.41"] = 302, -- Light's Hope Chapel, Thondoril River, Tarren Mill, The Sepulcher
					["0.61:0.35:0.51:0.36:0.42:0.37:0.50:0.66"] = 677, -- Light's Hope Chapel, Thondoril River, Undercity, Kargath
					["0.61:0.35:0.51:0.36:0.46:0.43"] = 198, -- Light's Hope Chapel, Thondoril River, Tarren Mill
					["0.61:0.35:0.61:0.28:0.58:0.06:0.59:0.19"] = 509, -- Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area, Silvermoon City

					-- Horde: Revantusk Village (The Hinterlands)
					["0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 648, -- Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 589, -- Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 575, -- Revantusk Village, Hammerfall, Kargath, Stonard
					["0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 419, -- Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.59:0.45:0.55:0.46:0.50:0.66"] = 351, -- Revantusk Village, Hammerfall, Kargath
					["0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 407, -- Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.59:0.45:0.46:0.43:0.37:0.41"] = 257, -- Revantusk Village, Tarren Mill, The Sepulcher
					["0.59:0.45:0.42:0.37"] = 284, -- Revantusk Village, Undercity
					["0.59:0.45:0.46:0.43"] = 159, -- Revantusk Village, Tarren Mill
					["0.59:0.45:0.55:0.46"] = 93, -- Revantusk Village, Hammerfall
					["0.59:0.45:0.61:0.35"] = 139, -- Revantusk Village, Light's Hope Chapel
					["0.59:0.45:0.61:0.35:0.58:0.25"] = 255, -- Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 322, -- Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.59:0.45:0.42:0.37:0.50:0.66:0.41:0.93"] = 993, -- Revantusk Village, Undercity, Kargath, Booty Bay
					["0.59:0.45:0.61:0.35:0.61:0.28"] = 232, -- Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 481, -- Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.59:0.45:0.42:0.37:0.50:0.66:0.46:0.65"] = 752, -- Revantusk Village, Undercity, Kargath, Thorium Point
					["0.59:0.45:0.42:0.37:0.50:0.66:0.54:0.79"] = 920, -- Revantusk Village, Undercity, Kargath, Stonard
					["0.59:0.45:0.46:0.43:0.45:0.37"] = 228, -- Revantusk Village, Tarren Mill, The Bulwark
					["0.59:0.45:0.61:0.35:0.51:0.36"] = 236, -- Revantusk Village, Light's Hope Chapel, Thondroril River
					["0.59:0.45:0.61:0.35:0.62:0.34"] = 200, -- Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.59:0.45:0.42:0.37:0.50:0.66"] = 697, -- Revantusk Village, Undercity, Kargath

					-- Horde: Shattered Sun Staging Area (Isle of Quel'Danas)
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 1117, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 1058, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.58:0.06:0.61:0.28"] = 233, -- Shattered Sun Staging Area, Zul'Aman
					["0.58:0.06:0.59:0.19"] = 167, -- Shattered Sun Staging Area, Silvermoon City
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 876, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 1044, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45"] = 469, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 820, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 888, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46"] = 562, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.58:0.06:0.61:0.28:0.61:0.35"] = 329, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel
					["0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.46:0.43"] = 629, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.58:0.06:0.59:0.19:0.58:0.25"] = 231, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien
					["0.58:0.06:0.61:0.28:0.61:0.35:0.42:0.37"] = 590, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Undercity
					["0.58:0.06:0.61:0.28:0.61:0.35:0.42:0.37:0.37:0.41"] = 623, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Undercity, The Sepulcher
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 1129, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37"] = 602, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 1060, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard 
					["0.58:0.06:0.61:0.28:0.61:0.35:0.51:0.36:0.45:0.37"] = 504, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Thondroril River, The Bulwark
					["0.58:0.06:0.61:0.28:0.61:0.35:0.51:0.36"] = 427, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Thondroril River
					["0.58:0.06:0.61:0.28:0.61:0.35:0.62:0.34"] = 394, -- Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.46:0.43"] = 641, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35"] = 346, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel
					["0.58:0.06:0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 1139, -- Shattered Sun Staging Area, Silvermoon City, Tranquillien, Light's Hope Chapel, Thondoril River, Tarren Mill, Hammerfall, Kargath, Stonard

					-- Horde: Silvermoon City (Eversong Woods)
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 963, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 904, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 890, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 733, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 667, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 722, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46"] = 408, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45"] = 316, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village
					["0.59:0.19:0.58:0.25:0.61:0.35"] = 179, -- Silvermoon City, Tranquillien, Light's Hope Chapel
					["0.59:0.19:0.58:0.25"] = 65, -- Silvermoon City, Tranquillien
					["0.59:0.19:0.58:0.25:0.61:0.35:0.59:0.45:0.46:0.43"] = 475, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37"] = 437, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37:0.37:0.41"] = 469, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity, The Sepulcher
					["0.59:0.19:0.58:0.25:0.61:0.28"] = 111, -- Silvermoon City, Tranquillien, Zul'Aman
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37:0.46:0.43:0.55:0.46"] = 619, -- Silbermond, Tristessa, Kapelle des hoffnungsvollen Lichts, Unterstadt, Tarrens Mühle, Hammerfall
					["0.59:0.19:0.58:0.06"] = 185, -- Silvermoon City, Shattered Sun Staging Area
					["0.59:0.19:0.58:0.06:0.61:0.28"] = 415, -- Silvermoon City, Shattered Sun Staging Area, Zul'Aman
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37:0.50:0.66:0.54:0.79"] = 1071, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity, Kargath, Stonard
					["0.59:0.19:0.58:0.06:0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 1240, -- Silvermoon City, Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.59:0.19:0.58:0.25:0.61:0.35:0.42:0.37:0.45:0.37"] = 456, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Undercity, The Bulwark
					["0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36"] = 276, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Thondroril River
					["0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36:0.45:0.37"] = 351, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Thondroril River, The Bulwark
					["0.59:0.19:0.58:0.25:0.61:0.35:0.62:0.34"] = 240, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36:0.46:0.43"] = 375, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Thondoril River, Tarren Mill
					["0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36:0.42:0.37"] = 435, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Thondoril River, Undercity
					["0.59:0.19:0.58:0.06:0.61:0.28:0.61:0.35"] = 522, -- Silvermoon City, Shattered Sun Staging Area, Zul'Aman, Light's Hope Chapel (Tomas Nilsson reported 512)
					["0.59:0.19:0.58:0.25:0.61:0.35:0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 1046, -- Silvermoon City, Tranquillien, Light's Hope Chapel, Thondoril River, Tarren Mill, Hammerfall, Kargath, Booty Bay

					-- Horde: Stonard (Swamp of Sorrows)
					["0.54:0.79:0.41:0.93"] = 230, -- Stonard, Booty Bay
					["0.54:0.79:0.42:0.86"] = 179, -- Stonard, Grom'gol
					["0.54:0.79:0.50:0.69"] = 176, -- Stonard, Flame Crest
					["0.54:0.79:0.50:0.66"] = 231, -- Stonard, Kargath
					["0.54:0.79:0.50:0.69:0.46:0.65"] = 208, -- Stonard, Flame Crest, Thorium Point
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 707, -- Stonard, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.54:0.79:0.50:0.66:0.42:0.37"] = 728, -- Stonard, Kargath, Undercity
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43"] = 608, -- Stonard, Kargath, Hammerfall, Tarren Mill
					["0.54:0.79:0.50:0.66:0.55:0.46"] = 493, -- Stonard, Kargath, Hammerfall
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45"] = 582, -- Stonard, Kargath, Hammerfall, Revantusk Village
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 720, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 836, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 903, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.54:0.79:0.50:0.66:0.46:0.65"] = 287, -- Stonard, Kargath, Thorium Point
					["0.54:0.79:0.50:0.66:0.42:0.37:0.61:0.35"] = 917, -- Stonard, Kargath, Undercity, Light's Hope Chapel
					["0.54:0.79:0.50:0.66:0.42:0.37:0.46:0.43"] = 795, -- Stonard, Kargath, Undercity, Tarren Mill
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 814, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 1062, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.54:0.79:0.50:0.66:0.42:0.37:0.37:0.41"] = 762, -- Stonard, Kargath, Undercity, The Sepulcher
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 677, -- Stonard, Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 708, -- Stonard, Kargath, Hammerfall, Tarren Mill, Thondoril River
					["0.54:0.79:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 781, -- Stonard, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.54:0.79:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36:0.61:0.35"] = 804, -- Stonard, Kargath, Hammerfall, Tarren Mill, Thondoril River, Light's Hope Chapel

					-- Horde: Tarren Mill (Hillsbrad Foothills)
					["0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 673, -- Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 614, -- Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 600, -- Tarren Mill, Hammerfall, Kargath, Stonard
					["0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 443, -- Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.46:0.43:0.55:0.46:0.50:0.66"] = 377, -- Tarren Mill, Hammerfall, Kargath
					["0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 432, -- Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.46:0.43:0.55:0.46"] = 118, -- Tarren Mill, Hammerfall
					["0.46:0.43:0.59:0.45"] = 160, -- Tarren Mill, Revantusk Village
					["0.46:0.43:0.59:0.45:0.61:0.35"] = 299, -- Tarren Mill, Revantusk Village, Light's Hope Chapel
					["0.46:0.43:0.59:0.45:0.61:0.35:0.58:0.25"] = 415, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.46:0.43:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 481, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.46:0.43:0.42:0.37"] = 139, -- Tarren Mill, Undercity
					["0.46:0.43:0.37:0.41"] = 99, -- Tarren Mill, The Sepulcher
					["0.46:0.43:0.42:0.37:0.61:0.35"] = 325, -- Tarren Mill, Undercity, Light's Hope Chapel
					["0.46:0.43:0.42:0.37:0.61:0.35:0.61:0.28"] = 416, -- Tarren Mill, Undercity, Light's Hope Chapel, Zul'Aman
					["0.46:0.43:0.59:0.45:0.61:0.35:0.61:0.28"] = 393, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.46:0.43:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 640, -- Tarren Mill, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.46:0.43:0.42:0.37:0.50:0.66:0.42:0.86"] = 787, -- Tarren Mill, Undercity, Kargath, Grom'gol
					["0.46:0.43:0.42:0.37:0.50:0.66"] = 550, -- Tarren Mill, Undercity, Kargath
					["0.46:0.43:0.42:0.37:0.50:0.66:0.54:0.79"] = 773, -- Tarren Mill, Undercity, Kargath, Stonard
					["0.46:0.43:0.45:0.37"] = 69, -- Tarren Mill, The Bulwark
					["0.46:0.43:0.51:0.36"] = 101, -- Tarren Mill, Thondroril River
					["0.46:0.43:0.51:0.36:0.61:0.35:0.62:0.34"] = 257, -- Tarren Mill, Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.46:0.43:0.51:0.36:0.61:0.35"] = 196, -- Tarren Mill, Thondoril River, Light's Hope Chapel

					-- Horde: The Bulwark (Tirisfal Glades)
					["0.45:0.37:0.42:0.37:0.61:0.35:0.58:0.25"] = 400, -- The Bulwark, Undercity, Light's Hope Chapel, Tranquillien
					["0.45:0.37:0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 466, -- The Bulwark, Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.45:0.37:0.51:0.36:0.61:0.35:0.61:0.28:0.58:0.06"] = 505, -- The Bulwark, Thondroril River, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.45:0.37:0.46:0.43:0.37:0.41"] = 177, -- The Bulwark, Tarren Mill, The Sepulcher
					["0.45:0.37:0.42:0.37"] = 90, -- The Bulwark, Undercity
					["0.45:0.37:0.42:0.37:0.61:0.35"] = 283, -- The Bulwark, Undercity, Light's Hope Chapel
					["0.45:0.37:0.46:0.43"] = 74, -- The Bulwark, Tarren Mill
					["0.45:0.37:0.46:0.43:0.55:0.46"] = 191, -- The Bulwark, Tarren Mill, Hammerfall
					["0.45:0.37:0.46:0.43:0.59:0.45"] = 233, -- The Bulwark, Tarren Mill, Revantusk Village
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 505, -- The Bulwark, Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66"] = 449, -- The Bulwark, Tarren Mill, Hammerfall, Kargath
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 516, -- The Bulwark, Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 745, -- The Bulwark, Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 686, -- The Bulwark, Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.45:0.37:0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 672, -- The Bulwark, Tarren Mill, Hammerfall, Kargath, Stonard
					["0.45:0.37:0.51:0.36"] = 68, -- The Bulwark, Thondroril River
					["0.45:0.37:0.51:0.36:0.61:0.35"] = 164, -- The Bulwark, Thondroril River, Light's Hope Chapel
					["0.45:0.37:0.51:0.36:0.61:0.35:0.58:0.25"] = 281, -- The Bulwark, Thondroril River, Light's Hope Chapel, Tranquillien
					["0.45:0.37:0.51:0.36:0.61:0.35:0.58:0.25:0.59:0.19"] = 348, -- The Bulwark, Thondroril River, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.45:0.37:0.51:0.36:0.61:0.35:0.61:0.28"] = 257, -- The Bulwark, Thondroril River, Light's Hope Chapel, Zul'Aman
					["0.45:0.37:0.51:0.36:0.61:0.35:0.62:0.34"] = 224, -- The Bulwark, Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.45:0.37:0.42:0.37:0.37:0.41"] = 128, -- The Bulwark, Undercity, The Sepulcher

					-- Horde: The Sepulcher (Silverpine Forest)
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 767, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 708, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 695, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Stonard
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 538, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66"] = 471, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath
					["0.37:0.41:0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 526, -- The Sepulcher, Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.37:0.41:0.46:0.43:0.55:0.46"] = 212, -- The Sepulcher, Tarren Mill, Hammerfall
					["0.37:0.41:0.46:0.43:0.59:0.45"] = 255, -- The Sepulcher, Tarren Mill, Revantusk Village
					["0.37:0.41:0.42:0.37:0.61:0.35"] = 299, -- The Sepulcher, Undercity, Light's Hope Chapel
					["0.37:0.41:0.42:0.37:0.61:0.35:0.58:0.25"] = 415, -- The Sepulcher, Undercity, Light's Hope Chapel, Tranquillien
					["0.37:0.41:0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 483, -- The Sepulcher, Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.37:0.41:0.42:0.37"] = 112, -- The Sepulcher, Undercity
					["0.37:0.41:0.46:0.43"] = 95, -- The Sepulcher, Tarren Mill
					["0.37:0.41:0.42:0.37:0.61:0.35:0.61:0.28"] = 392, -- The Sepulcher, Undercity, Light's Hope Chapel, Zul'Aman
					["0.37:0.41:0.42:0.37:0.61:0.35:0.61:0.28:0.58:0.06"] = 639, -- The Sepulcher, Undercity, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.37:0.41:0.46:0.43:0.45:0.37"] = 164, -- The Sepulcher, Tarren Mill, The Bulwark
					["0.37:0.41:0.46:0.43:0.51:0.36"] = 196, -- The Sepulcher, Tarren Mill, Thondroril River
					["0.37:0.41:0.46:0.43:0.51:0.36:0.61:0.35:0.62:0.34"] = 352, -- The Sepulcher, Tarren Mill, Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Horde: Thondroril River (Western Plaguelands)
					["0.51:0.36:0.61:0.35:0.58:0.25:0.59:0.19"] = 280, -- Thondroril River, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.51:0.36:0.45:0.37"] = 76, -- Thondroril River, The Bulwark
					["0.51:0.36:0.61:0.35:0.61:0.28:0.58:0.06"] = 438, -- Thondroril River, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.51:0.36:0.61:0.35"] = 96, -- Thondroril River, Light's Hope Chapel
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.42:0.86"] = 714, -- Thondroril River, Tarren Mill, Hammerfall, Kargath, Grom'gol
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.41:0.93"] = 773, -- Thondroril River, Tarren Mill, Hammerfall, Kargath, Booty Bay
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.50:0.69"] = 543, -- Thondroril River, Tarren Mill, Hammerfall, Kargath, Flame Crest
					["0.51:0.36:0.61:0.35:0.61:0.28"] = 190, -- Thondroril River, Light's Hope Chapel, Zul'Aman
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.46:0.65"] = 531, -- Thondroril River, Tarren Mill, Hammerfall, Kargath, Thorium Point
					["0.51:0.36:0.42:0.37"] = 160, -- Thondroril River, Undercity
					["0.51:0.36:0.46:0.43:0.37:0.41"] = 204, -- Thondroril River, Tarren Mill, The Sepulcher
					["0.51:0.36:0.46:0.43"] = 101, -- Thondroril River, Tarren Mill
					["0.51:0.36:0.61:0.35:0.59:0.45"] = 234, -- Thondroril River, Light's Hope Chapel, Revantusk Village
					["0.51:0.36:0.61:0.35:0.58:0.25"] = 214, -- Thondroril River, Light's Hope Chapel, Tranquillien
					["0.51:0.36:0.46:0.43:0.55:0.46"] = 218, -- Thondroril River, Tarren Mill, Hammerfall
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66:0.54:0.79"] = 700, -- Thondroril River, Tarren Mill, Hammerfall, Kargath, Stonard
					["0.51:0.36:0.46:0.43:0.55:0.46:0.50:0.66"] = 476, -- Thondroril River, Tarren Mill, Hammerfall, Kargath
					["0.51:0.36:0.61:0.35:0.62:0.34"] = 156, -- Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Horde: Thorium Point (Searing Gorge)
					["0.46:0.65:0.50:0.69:0.42:0.86:0.41:0.93"] = 312, -- Thorium Point, Flame Crest, Grom'gol, Booty Bay
					["0.46:0.65:0.50:0.69:0.42:0.86"] = 234, -- Thorium Point, Flame Crest, Grom'gol
					["0.46:0.65:0.50:0.69:0.54:0.79"] = 218, -- Thorium Point, Flame Crest, Stonard
					["0.46:0.65:0.50:0.69"] = 61, -- Thorium Point, Flame Crest
					["0.46:0.65:0.50:0.66"] = 70, -- Thorium Point, Kargath
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43:0.37:0.41"] = 545, -- Thorium Point, Kargath, Hammerfall, Tarren Mill, The Sepulcher
					["0.46:0.65:0.50:0.66:0.42:0.37"] = 566, -- Thorium Point, Kargath, Undercity
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43"] = 446, -- Thorium Point, Kargath, Hammerfall, Tarren Mill
					["0.46:0.65:0.50:0.66:0.55:0.46"] = 332, -- Thorium Point, Kargath, Hammerfall
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45"] = 420, -- Thorium Point, Kargath, Hammerfall, Revantusk Village
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35"] = 559, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25"] = 674, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.58:0.25:0.59:0.19"] = 741, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.46:0.65:0.50:0.66:0.42:0.86"] = 307, -- Thorium Point, Kargath, Grom'gol
					["0.46:0.65:0.50:0.66:0.54:0.79"] = 294, -- Thorium Point, Kargath, Stonard
					["0.46:0.65:0.50:0.66:0.41:0.93"] = 366, -- Thorium Point, Kargath, Booty Bay
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28"] = 652, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.61:0.28:0.58:0.06"] = 900, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.46:0.65:0.50:0.66:0.42:0.37:0.59:0.45"] = 775, -- Thorium Point, Kargath, Undercity, Revantusk Village
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43:0.45:0.37"] = 515, -- Thorium Point, Kargath, Hammerfall, Tarren Mill, The Bulwark
					["0.46:0.65:0.50:0.66:0.55:0.46:0.46:0.43:0.51:0.36"] = 547, -- Thorium Point, Kargath, Hammerfall, Tarren Mill, Thondroril River
					["0.46:0.65:0.50:0.66:0.55:0.46:0.59:0.45:0.61:0.35:0.62:0.34"] = 619, -- Thorium Point, Kargath, Hammerfall, Revantusk Village, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Horde: Tranquillien (Ghostlands)
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 900, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 841, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 827, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 671, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 604, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 659, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.58:0.25:0.61:0.35:0.59:0.45:0.55:0.46"] = 345, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.58:0.25:0.61:0.35:0.59:0.45"] = 253, -- Tranquillien, Light's Hope Chapel, Revantusk Village
					["0.58:0.25:0.61:0.35"] = 116, -- Tranquillien, Light's Hope Chapel
					["0.58:0.25:0.59:0.19"] = 74, -- Tranquillien, Silvermoon City
					["0.58:0.25:0.61:0.35:0.42:0.37"] = 373, -- Tranquillien, Light's Hope Chapel, Undercity
					["0.58:0.25:0.61:0.35:0.42:0.37:0.37:0.41"] = 406, -- Tranquillien, Light's Hope Chapel, Undercity, The Sepulcher
					["0.58:0.25:0.61:0.35:0.59:0.45:0.46:0.43"] = 412, -- Tranquillien, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.58:0.25:0.61:0.28"] = 52, -- Tranquillien, Zul'Aman
					["0.58:0.25:0.59:0.19:0.58:0.06"] = 257, -- Tranquillien, Silvermoon City, Shattered Sun Staging Area
					["0.58:0.25:0.61:0.35:0.42:0.37:0.46:0.43:0.55:0.46"] = 556, -- Tranquillien, Light's Hope Chapel, Undercity, Tarren Mill, Hammerfall
					["0.58:0.25:0.61:0.35:0.42:0.37:0.45:0.37"] = 393, -- Tranquillien, Light's Hope Chapel, Undercity, The Bulwark
					["0.58:0.25:0.61:0.35:0.51:0.36:0.45:0.37"] = 288, -- Tranquillien, Light's Hope Chapel, Thondroril River, The Bulwark
					["0.58:0.25:0.61:0.35:0.51:0.36"] = 213, -- Tranquillien, Light's Hope Chapel, Thondroril River
					["0.58:0.25:0.61:0.35:0.62:0.34"] = 177, -- Tranquillien, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.58:0.25:0.61:0.35:0.51:0.36:0.42:0.37"] = 372, -- Tranquillien, Light's Hope Chapel, Thondoril River, Undercity

					-- Horde: Undercity (Tirisfal Glades)
					["0.42:0.37:0.50:0.66:0.41:0.93"] = 785, -- Undercity, Kargath, Booty Bay
					["0.42:0.37:0.50:0.66:0.42:0.86"] = 725, -- Undercity, Kargath, Grom'gol
					["0.42:0.37:0.50:0.66:0.54:0.79"] = 712, -- Undercity, Kargath, Stonard
					["0.42:0.37:0.50:0.66:0.50:0.69"] = 555, -- Undercity, Kargath, Flame Crest
					["0.42:0.37:0.50:0.66"] = 489, -- Undercity, Kargath
					["0.42:0.37:0.50:0.66:0.46:0.65"] = 544, -- Undercity, Kargath, Thorium Point
					["0.42:0.37:0.37:0.41"] = 106, -- Undercity, The Sepulcher
					["0.42:0.37:0.46:0.43"] = 141, -- Undercity, Tarren Mill
					["0.42:0.37:0.55:0.46"] = 301, -- Undercity, Hammerfall
					["0.42:0.37:0.59:0.45"] = 284, -- Undercity, Revantusk Village
					["0.42:0.37:0.61:0.35"] = 261, -- Undercity, Light's Hope Chapel
					["0.42:0.37:0.61:0.35:0.58:0.25"] = 378, -- Undercity, Light's Hope Chapel, Tranquillien
					["0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19"] = 444, -- Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City
					["0.42:0.37:0.61:0.35:0.61:0.28"] = 356, -- Undercity, Light's Hope Chapel, Zul'Aman
					["0.42:0.37:0.61:0.35:0.61:0.28:0.58:0.06"] = 601, -- Undercity, Light's Hope Chapel, Zul'Aman, Shattered Sun Staging Area
					["0.42:0.37:0.45:0.37"] = 89, -- Undercity, The Bulwark
					["0.42:0.37:0.51:0.36"] = 153, -- Undercity, Thondroril River
					["0.42:0.37:0.51:0.36:0.61:0.35:0.62:0.34"] = 309, -- Undercity, Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.42:0.37:0.61:0.35:0.62:0.34"] = 318, -- Undercity, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.42:0.37:0.61:0.35:0.58:0.25:0.59:0.19:0.58:0.06"] = 627, -- Undercity, Light's Hope Chapel, Tranquillien, Silvermoon City, Shattered Sun Staging Area
					["0.42:0.37:0.51:0.36:0.61:0.35:0.58:0.25:0.59:0.19"] = 438, -- Undercity, Thondoril River, Light's Hope Chapel, Tranquillien, Silvermoon City

					-- Horde: Zul'Aman
					["0.61:0.28:0.58:0.25"] = 52, -- Zul'Aman, Tranquillien
					["0.61:0.28:0.58:0.25:0.59:0.19"] = 118, -- Zul'Aman, Tranquillien, Silvermoon City
					["0.61:0.28:0.61:0.35:0.42:0.37"] = 362, -- Zul'Aman, Light's Hope Chapel, Undercity
					["0.61:0.28:0.61:0.35"] = 102, -- Zul'Aman, Light's Hope Chapel
					["0.61:0.28:0.61:0.35:0.42:0.37:0.37:0.41"] = 395, -- Zul'Aman, Light's Hope Chapel, Undercity, The Sepulcher
					["0.61:0.28:0.61:0.35:0.59:0.45"] = 244, -- Zul'Aman, Light's Hope Chapel, Revantusk Village
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46"] = 335, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall
					["0.61:0.28:0.61:0.35:0.59:0.45:0.46:0.43"] = 401, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Tarren Mill
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.41:0.93"] = 889, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Booty Bay
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.42:0.86"] = 831, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Grom'gol
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.54:0.79"] = 817, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Stonard
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.50:0.69"] = 661, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Flame Crest
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66:0.46:0.65"] = 648, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath, Thorium Point
					["0.61:0.28:0.61:0.35:0.59:0.45:0.55:0.46:0.50:0.66"] = 593, -- Zul'Aman, Light's Hope Chapel, Revantusk Village, Hammerfall, Kargath
					["0.61:0.28:0.58:0.06"] = 252, -- Zul'Aman, Shattered Sun Staging Area
					["0.61:0.28:0.58:0.06:0.59:0.19"] = 416, -- Zul'Aman, Shattered Sun Staging Area, Silvermoon City
					["0.61:0.28:0.61:0.35:0.51:0.36:0.45:0.37"] = 275, -- Zul'Aman, Light's Hope Chapel, Thondroril River, The Bulwark
					["0.61:0.28:0.61:0.35:0.51:0.36"] = 201, -- Zul'Aman, Light's Hope Chapel, Thondroril River
					["0.61:0.28:0.61:0.35:0.62:0.34"] = 166, -- Zul'Aman, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.61:0.28:0.61:0.35:0.51:0.36:0.46:0.43"] = 300, -- Zul'Aman, Light's Hope Chapel, Thondoril River, Tarren Mill

				},

				-- Horde: Kalimdor
				[1414] = {

					-- Horde: Bloodvenom Post (Felwood)
					["0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80"] = 518, -- Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan
					["0.46:0.30:0.56:0.53:0.44:0.69:0.42:0.79"] = 623, -- Bloodvenom Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 619, -- Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.46:0.30:0.56:0.53:0.55:0.73"] = 426, -- Bloodvenom Post, Crossroads, Freewind Post
					["0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 434, -- Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64"] = 373, -- Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.46:0.30:0.56:0.53:0.53:0.61"] = 315, -- Bloodvenom Post, Crossroads, Camp Taurajo
					["0.46:0.30:0.56:0.53:0.44:0.69"] = 493, -- Bloodvenom Post, Crossroads, Camp Mojache
					["0.46:0.30:0.41:0.37:0.41:0.47:0.32:0.58"] = 398, -- Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.46:0.30:0.56:0.53:0.45:0.56"] = 347, -- Bloodvenom Post, Crossroads, Thunder Bluff
					["0.46:0.30:0.56:0.53"] = 241, -- Bloodvenom Post, Crossroads
					["0.46:0.30:0.56:0.53:0.61:0.55"] = 292, -- Bloodvenom Post, Crossroads, Ratchet
					["0.46:0.30:0.63:0.44"] = 259, -- Bloodvenom Post, Orgrimmar
					["0.46:0.30:0.50:0.35:0.55:0.42"] = 151, -- Bloodvenom Post, Emerald Sanctuary, Splintertree Post
					["0.46:0.30:0.41:0.37:0.41:0.47"] = 256, -- Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.46:0.30:0.41:0.37"] = 136, -- Bloodvenom Post, Zoram'gar Outpost
					["0.46:0.30:0.50:0.35"] = 69, -- Bloodvenom Post, Emerald Sanctuary
					["0.46:0.30:0.63:0.36"] = 234, -- Bloodvenom Post, Valormok
					["0.46:0.30:0.64:0.23"] = 190, -- Bloodvenom Post, Everlook
					["0.46:0.30:0.54:0.21"] = 166, -- Bloodvenom Post, Moonglade
					["0.46:0.30:0.41:0.37:0.55:0.42"] = 309, -- Bloodvenom Post, Zoram'gar Outpost, Splintertree Post

					-- Horde: Brackenwall Village (Dustwallow Marsh)
					["0.57:0.64:0.61:0.80"] = 205, -- Brackenwall Village, Gadgetzan
					["0.57:0.64:0.55:0.73:0.44:0.69:0.42:0.79"] = 357, -- Brackenwall Village, Freewind Post, Camp Mojache, Cenarion Hold
					["0.57:0.64:0.55:0.73:0.61:0.80:0.50:0.76"] = 298, -- Brackenwall Village, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.57:0.64:0.55:0.73"] = 105, -- Brackenwall Village, Freewind Post
					["0.57:0.64:0.58:0.70"] = 62, -- Brackenwall Village, Mudsprocket
					["0.57:0.64:0.55:0.73:0.44:0.69"] = 227, -- Brackenwall Village, Freewind Post, Camp Mojache
					["0.57:0.64:0.53:0.61"] = 49, -- Brackenwall Village, Camp Taurajo
					["0.57:0.64:0.45:0.56"] = 225, -- Brackenwall Village, Thunder Bluff
					["0.57:0.64:0.53:0.61:0.45:0.56:0.32:0.58"] = 321, -- Brackenwall Village, Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.47"] = 276, -- Brackenwall Village, Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.57:0.64:0.56:0.53"] = 162, -- Brackenwall Village, Crossroads
					["0.57:0.64:0.61:0.55"] = 90, -- Brackenwall Village, Ratchet
					["0.57:0.64:0.63:0.44"] = 217, -- Brackenwall Village, Orgrimmar
					["0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42"] = 273, -- Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post
					["0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36"] = 279, -- Brackenwall Village, Ratchet, Orgrimmar, Valormok
					["0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 351, -- Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.37"] = 357, -- Brackenwall Village, Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30"] = 380, -- Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post
					["0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 501, -- Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 408, -- Brackenwall Village, Ratchet, Orgrimmar, Valormok, Everlook

					-- Horde: Camp Mojache (The Barrens)
					["0.44:0.69:0.42:0.79"] = 130, -- Camp Mojache, Cenarion Hold
					["0.44:0.69:0.42:0.79:0.50:0.76"] = 222, -- Camp Mojache, Cenarion Hold, Marshal's Refuge
					["0.44:0.69:0.61:0.80"] = 201, -- Camp Mojache, Gadgetzan
					["0.44:0.69:0.55:0.73"] = 107, -- Camp Mojache, Freewind Post
					["0.44:0.69:0.55:0.73:0.58:0.70"] = 176, -- Camp Mojache, Freewind Post, Mudsprocket
					["0.44:0.69:0.55:0.73:0.57:0.64"] = 203, -- Camp Mojache, Freewind Post, Brackenwall Village
					["0.44:0.69:0.55:0.73:0.53:0.61"] = 245, -- Camp Mojache, Freewind Post, Camp Taurajo
					["0.44:0.69:0.55:0.73:0.57:0.64:0.61:0.55"] = 290, -- Camp Mojache, Freewind Post, Brackenwall Village, Ratchet
					["0.44:0.69:0.56:0.53"] = 265, -- Camp Mojache, Crossroads
					["0.44:0.69:0.45:0.56"] = 259, -- Camp Mojache, Thunder Bluff
					["0.44:0.69:0.32:0.58"] = 200, -- Camp Mojache, Shadowprey Village
					["0.44:0.69:0.32:0.58:0.41:0.47"] = 400, -- Camp Mojache, Shadowprey Village, Sun Rock Retreat
					["0.44:0.69:0.56:0.53:0.41:0.37"] = 495, -- Camp Mojache, Crossroads, Zoram'gar Outpost
					["0.44:0.69:0.56:0.53:0.55:0.42"] = 427, -- Camp Mojache, Crossroads, Splintertree Post
					["0.44:0.69:0.56:0.53:0.63:0.44"] = 381, -- Camp Mojache, Crossroads, Orgrimmar
					["0.44:0.69:0.56:0.53:0.63:0.36"] = 428, -- Camp Mojache, Crossroads, Valormok
					["0.44:0.69:0.56:0.53:0.55:0.42:0.50:0.35"] = 505, -- Camp Mojache, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.44:0.69:0.56:0.53:0.46:0.30"] = 518, -- Camp Mojache, Crossroads, Bloodvenom Post
					["0.44:0.69:0.56:0.53:0.46:0.30:0.54:0.21"] = 639, -- Camp Mojache, Crossroads, Bloodvenom Post, Moonglade
					["0.44:0.69:0.56:0.53:0.63:0.36:0.64:0.23"] = 557, -- Camp Mojache, Crossroads, Valormok, Everlook
					["0.44:0.69:0.55:0.73:0.61:0.80:0.50:0.76"] = 301, -- Camp Mojache, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.44:0.69:0.56:0.53:0.61:0.55"] = 316, -- Camp Mojache, Crossroads, Ratchet
					["0.44:0.69:0.56:0.53:0.63:0.44:0.64:0.23"] = 621, -- Camp Mojache, Crossroads, Orgrimmar, Everlook
					["0.44:0.69:0.56:0.53:0.41:0.47"] = 415, -- Camp Mojache, Crossroads, Sun Rock Retreat
					["0.44:0.69:0.55:0.73:0.57:0.64:0.61:0.55:0.63:0.44"] = 386, -- Camp Mojache, Freewind Post, Brackenwall Village, Ratchet, Orgrimmar
					["0.44:0.69:0.56:0.53:0.53:0.61"] = 338, -- Camp Mojache, Crossroads, Camp Taurajo

					-- Horde: Camp Taurajo (The Barrens)
					["0.53:0.61:0.55:0.73:0.61:0.80"] = 218, -- Camp Taurajo, Freewind Post, Gadgetzan
					["0.53:0.61:0.55:0.73:0.44:0.69:0.42:0.79"] = 378, -- Camp Taurajo, Freewind Post, Camp Mojache, Cenarion Hold
					["0.53:0.61:0.55:0.73:0.61:0.80:0.50:0.76"] = 319, -- Camp Taurajo, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.53:0.61:0.55:0.73"] = 125, -- Camp Taurajo, Freewind Post
					["0.53:0.61:0.57:0.64:0.58:0.70"] = 121, -- Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.53:0.61:0.57:0.64"] = 60, -- Camp Taurajo, Brackenwall Village
					["0.53:0.61:0.55:0.73:0.44:0.69"] = 248, -- Camp Taurajo, Freewind Post, Camp Mojache
					["0.53:0.61:0.45:0.56:0.32:0.58"] = 273, -- Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.53:0.61:0.45:0.56"] = 114, -- Camp Taurajo, Thunder Bluff
					["0.53:0.61:0.56:0.53"] = 79, -- Camp Taurajo, Crossroads
					["0.53:0.61:0.56:0.53:0.61:0.55"] = 130, -- Camp Taurajo, Crossroads, Ratchet
					["0.53:0.61:0.56:0.53:0.63:0.44"] = 195, -- Camp Taurajo, Crossroads, Orgrimmar
					["0.53:0.61:0.56:0.53:0.55:0.42"] = 241, -- Camp Taurajo, Crossroads, Splintertree Post
					["0.53:0.61:0.56:0.53:0.41:0.47"] = 228, -- Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.53:0.61:0.56:0.53:0.41:0.37"] = 309, -- Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.53:0.61:0.56:0.53:0.55:0.42:0.50:0.35"] = 319, -- Camp Taurajo, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.53:0.61:0.56:0.53:0.63:0.36"] = 242, -- Camp Taurajo, Crossroads, Valormok
					["0.53:0.61:0.56:0.53:0.46:0.30"] = 332, -- Camp Taurajo, Crossroads, Bloodvenom Post
					["0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 453, -- Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.53:0.61:0.56:0.53:0.63:0.36:0.64:0.23"] = 372, -- Camp Taurajo, Crossroads, Valormok, Everlook
					["0.53:0.61:0.56:0.53:0.44:0.69"] = 330, -- Camp Taurajo, Crossroads, Camp Mojache
					["0.53:0.61:0.56:0.53:0.63:0.44:0.64:0.23"] = 435, -- Camp Taurajo, Crossroads, Orgrimmar, Everlook
					["0.53:0.61:0.55:0.73:0.58:0.70"] = 194, -- Camp Taurajo, Freewind Post, Mudsprocket

					-- Horde: Cenarion Hold (Silithus)
					["0.42:0.79:0.61:0.80"] = 242, -- Cenarion Hold, Gadgetzan
					["0.42:0.79:0.50:0.76"] = 97, -- Cenarion Hold, Marshal's Refuge
					["0.42:0.79:0.44:0.69:0.55:0.73"] = 237, -- Cenarion Hold, Camp Mojache, Freewind Post
					["0.42:0.79:0.44:0.69:0.55:0.73:0.58:0.70"] = 306, -- Cenarion Hold, Camp Mojache, Freewind Post, Mudsprocket
					["0.42:0.79:0.44:0.69:0.55:0.73:0.57:0.64"] = 332, -- Cenarion Hold, Camp Mojache, Freewind Post, Brackenwall Village
					["0.42:0.79:0.44:0.69:0.55:0.73:0.53:0.61"] = 374, -- Cenarion Hold, Camp Mojache, Freewind Post, Camp Taurajo
					["0.42:0.79:0.44:0.69"] = 131, -- Cenarion Hold, Camp Mojache
					["0.42:0.79:0.44:0.69:0.32:0.58"] = 330, -- Cenarion Hold, Camp Mojache, Shadowprey Village
					["0.42:0.79:0.44:0.69:0.45:0.56"] = 390, -- Cenarion Hold, Camp Mojache, Thunder Bluff
					["0.42:0.79:0.44:0.69:0.56:0.53"] = 394, -- Cenarion Hold, Camp Mojache, Crossroads
					["0.42:0.79:0.44:0.69:0.55:0.73:0.57:0.64:0.61:0.55"] = 420, -- Cenarion Hold, Camp Mojache, Freewind Post, Brackenwall Village, Ratchet
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.44"] = 511, -- Cenarion Hold, Camp Mojache, Crossroads, Orgrimmar
					["0.42:0.79:0.44:0.69:0.56:0.53:0.55:0.42"] = 556, -- Cenarion Hold, Camp Mojache, Crossroads, Splintertree Post
					["0.42:0.79:0.44:0.69:0.32:0.58:0.41:0.47"] = 528, -- Cenarion Hold, Camp Mojache, Shadowprey Village, Sun Rock Retreat
					["0.42:0.79:0.44:0.69:0.56:0.53:0.41:0.37"] = 624, -- Cenarion Hold, Camp Mojache, Crossroads, Zoram'gar Outpost
					["0.42:0.79:0.44:0.69:0.56:0.53:0.55:0.42:0.50:0.35"] = 634, -- Cenarion Hold, Camp Mojache, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.42:0.79:0.44:0.69:0.56:0.53:0.46:0.30"] = 647, -- Cenarion Hold, Camp Mojache, Crossroads, Bloodvenom Post
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.36"] = 557, -- Cenarion Hold, Camp Mojache, Crossroads, Valormok
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.36:0.64:0.23"] = 686, -- Cenarion Hold, Camp Mojache, Crossroads, Valormok, Everlook
					["0.42:0.79:0.44:0.69:0.56:0.53:0.46:0.30:0.54:0.21"] = 769, -- Cenarion Hold, Camp Mojache, Crossroads, Bloodvenom Post, Moonglade
					["0.42:0.79:0.44:0.69:0.56:0.53:0.61:0.55"] = 446, -- Cenarion Hold, Camp Mojache, Crossroads, Ratchet
					["0.42:0.79:0.44:0.69:0.56:0.53:0.63:0.44:0.64:0.23"] = 750, -- Cenarion Hold, Camp Mojache, Crossroads, Orgrimmar, Everlook
					["0.42:0.79:0.61:0.80:0.63:0.44"] = 591, -- Cenarion Hold, Gadgetzan, Orgrimmar
					["0.42:0.79:0.50:0.76:0.61:0.80:0.55:0.73"] = 292, -- Cenarion Hold, Marshal's Refuge, Gadgetzan, Freewind Post
					["0.42:0.79:0.61:0.80:0.55:0.73"] = 328, -- Cenarion Hold, Gadgetzan, Freewind Post
					["0.42:0.79:0.50:0.76:0.61:0.80:0.55:0.73:0.53:0.61"] = 428, -- Cenarion Hold, Marshal's Refuge, Gadgetzan, Freewind Post, Camp Taurajo

					-- Horde: Crossroads (The Barrens)
					["0.56:0.53:0.44:0.69:0.42:0.79"] = 382, -- Crossroads, Camp Mojache, Cenarion Hold
					["0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 379, -- Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.56:0.53:0.61:0.80"] = 303, -- Crossroads, Gadgetzan
					["0.56:0.53:0.55:0.73"] = 184, -- Crossroads, Freewind Post
					["0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 193, -- Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.56:0.53:0.57:0.64"] = 162, -- Crossroads, Brackenwall Village
					["0.56:0.53:0.53:0.61"] = 74, -- Crossroads, Camp Taurajo
					["0.56:0.53:0.44:0.69"] = 252, -- Crossroads, Camp Mojache
					["0.56:0.53:0.45:0.56:0.32:0.58"] = 266, -- Crossroads, Thunder Bluff, Shadowprey Village
					["0.56:0.53:0.45:0.56"] = 107, -- Crossroads, Thunder Bluff
					["0.56:0.53:0.41:0.47"] = 150, -- Crossroads, Sun Rock Retreat
					["0.56:0.53:0.55:0.42"] = 162, -- Crossroads, Splintertree Post
					["0.56:0.53:0.63:0.44"] = 117, -- Crossroads, Orgrimmar
					["0.56:0.53:0.61:0.55"] = 52, -- Crossroads, Ratchet
					["0.56:0.53:0.63:0.36"] = 164, -- Crossroads, Valormok
					["0.56:0.53:0.55:0.42:0.50:0.35"] = 241, -- Crossroads, Splintertree Post, Emerald Sanctuary
					["0.56:0.53:0.41:0.37"] = 230, -- Crossroads, Zoram'gar Outpost
					["0.56:0.53:0.46:0.30"] = 254, -- Crossroads, Bloodvenom Post
					["0.56:0.53:0.46:0.30:0.54:0.21"] = 375, -- Crossroads, Bloodvenom Post, Moonglade
					["0.56:0.53:0.63:0.36:0.64:0.23"] = 293, -- Crossroads, Valormok, Everlook
					["0.56:0.53:0.61:0.55:0.61:0.80:0.50:0.76"] = 395, -- Crossroads, Ratchet, Gadgetzan, Marshal's Refuge

					-- Horde: Emerald Sanctuary (Felwood)
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80"] = 514, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post, Gadgetzan
					["0.50:0.35:0.55:0.42:0.56:0.53:0.44:0.69:0.42:0.79"] = 618, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 615, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.55:0.42:0.56:0.53:0.55:0.73"] = 421, -- Emerald Sanctuary, Splintertree Post, Crossroads, Freewind Post
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 430, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64"] = 368, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.50:0.35:0.55:0.42:0.56:0.53:0.53:0.61"] = 310, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Taurajo
					["0.50:0.35:0.55:0.42:0.56:0.53:0.44:0.69"] = 489, -- Emerald Sanctuary, Splintertree Post, Crossroads, Camp Mojache
					["0.50:0.35:0.41:0.37:0.41:0.47:0.32:0.58"] = 378, -- Emerald Sanctuary, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.50:0.35:0.55:0.42:0.56:0.53:0.45:0.56"] = 343, -- Emerald Sanctuary, Splintertree Post, Crossroads, Thunder Bluff
					["0.50:0.35:0.55:0.42:0.56:0.53"] = 237, -- Emerald Sanctuary, Splintertree Post, Crossroads
					["0.50:0.35:0.55:0.42:0.63:0.44:0.61:0.55"] = 280, -- Emerald Sanctuary, Splintertree Post, Orgrimmar, Ratchet
					["0.50:0.35:0.55:0.42:0.63:0.44"] = 173, -- Emerald Sanctuary, Splintertree Post, Orgrimmar
					["0.50:0.35:0.55:0.42"] = 84, -- Emerald Sanctuary, Splintertree Post
					["0.50:0.35:0.41:0.37:0.41:0.47"] = 235, -- Emerald Sanctuary, Zoram'gar Outpost, Sun Rock Retreat
					["0.50:0.35:0.41:0.37"] = 115, -- Emerald Sanctuary, Zoram'gar Outpost
					["0.50:0.35:0.46:0.30"] = 80, -- Emerald Sanctuary, Bloodvenom Post
					["0.50:0.35:0.55:0.42:0.63:0.36"] = 169, -- Emerald Sanctuary, Splintertree Post, Valormok
					["0.50:0.35:0.46:0.30:0.64:0.23"] = 226, -- Emerald Sanctuary, Bloodvenom Post, Everlook
					["0.50:0.35:0.46:0.30:0.54:0.21"] = 203, -- Emerald Sanctuary, Bloodvenom Post, Moonglade
					["0.50:0.35:0.46:0.30:0.56:0.53:0.61:0.55"] = 330, -- Emerald Sanctuary, Bloodvenom Post, Crossroads, Ratchet
					["0.50:0.35:0.55:0.42:0.63:0.36:0.64:0.23"] = 298, -- Emerald Sanctuary, Splintertree Post, Valormok, Everlook
					["0.50:0.35:0.55:0.42:0.63:0.44:0.64:0.23"] = 413, -- Emerald Sanctuary, Splintertree Post, Orgrimmar, Everlook

					-- Horde: Everlook (Winterspring)
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80"] = 575, -- Everlook, Valormok, Crossroads, Freewind Post, Gadgetzan
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73"] = 483, -- Everlook, Valormok, Crossroads, Freewind Post
					["0.64:0.23:0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 676, -- Everlook, Valormok, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.64:0.23:0.63:0.36:0.56:0.53:0.44:0.69:0.42:0.79"] = 680, -- Everlook, Valormok, Crossroads, Camp Mojache, Cenarion Hold
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 491, -- Everlook, Valormok, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64"] = 430, -- Everlook, Valormok, Crossroads, Camp Taurajo, Brackenwall Village
					["0.64:0.23:0.63:0.36:0.56:0.53:0.53:0.61"] = 371, -- Everlook, Valormok, Crossroads, Camp Taurajo
					["0.64:0.23:0.63:0.36:0.56:0.53:0.44:0.69"] = 550, -- Everlook, Valormok, Crossroads, Camp Mojache
					["0.64:0.23:0.63:0.36:0.45:0.56:0.32:0.58"] = 544, -- Everlook, Valormok, Thunder Bluff, Shadowprey Village
					["0.64:0.23:0.63:0.36:0.45:0.56"] = 385, -- Everlook, Valormok, Thunder Bluff
					["0.64:0.23:0.63:0.36:0.56:0.53"] = 299, -- Everlook, Valormok, Crossroads
					["0.64:0.23:0.63:0.36:0.63:0.44:0.61:0.55"] = 342, -- Everlook, Valormok, Orgrimmar, Ratchet
					["0.64:0.23:0.63:0.44"] = 243, -- Everlook, Orgrimmar
					["0.64:0.23:0.63:0.36:0.55:0.42"] = 228, -- Everlook, Valormok, Splintertree Post
					["0.64:0.23:0.63:0.36:0.56:0.53:0.41:0.47"] = 448, -- Everlook, Valormok, Crossroads, Sun Rock Retreat
					["0.64:0.23:0.46:0.30:0.41:0.37"] = 296, -- Everlook, Bloodvenom Post, Zoram'gar Outpost
					["0.64:0.23:0.46:0.30:0.50:0.35"] = 229, -- Everlook, Bloodvenom Post, Emerald Sanctuary
					["0.64:0.23:0.63:0.36"] = 135, -- Everlook, Valormok
					["0.64:0.23:0.46:0.30"] = 195, -- Everlook, Bloodvenom Post
					["0.64:0.23:0.54:0.21"] = 135, -- Everlook, Moonglade
					["0.64:0.23:0.63:0.44:0.56:0.53:0.45:0.56"] = 457, -- Everlook, Orgrimmar, Crossroads, Thunder Bluff
					["0.64:0.23:0.63:0.44:0.61:0.55"] = 351, -- Everlook, Orgrimmar, Ratchet
					["0.64:0.23:0.63:0.44:0.55:0.42"] = 333, -- Everlook, Orgrimmar, Splintertree Post
					["0.64:0.23:0.63:0.44:0.61:0.55:0.61:0.80"] = 591, -- Everlook, Orgrimmar, Ratchet, Gadgetzan
					["0.64:0.23:0.63:0.44:0.56:0.53:0.44:0.69"] = 602, -- Everlook, Orgrimmar, Crossroads, Camp Mojache
					["0.64:0.23:0.63:0.36:0.55:0.42:0.50:0.35"] = 306, -- Everlook, Valormok, Splintertree Post, Emerald Sanctuary
					["0.64:0.23:0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76"] = 696, -- Everlook, Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.64:0.23:0.46:0.30:0.41:0.37:0.41:0.47"] = 416, -- Everlook, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.64:0.23:0.46:0.30:0.41:0.37:0.41:0.47:0.32:0.58"] = 558, -- Everlook, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.64:0.23:0.63:0.44:0.55:0.42:0.50:0.35"] = 411, -- Everlook, Orgrimmar, Splintertree Post, Emerald Sanctuary

					-- Horde: Freewind Post (Thousand Needles)
					["0.55:0.73:0.44:0.69:0.42:0.79"] = 252, -- Freewind Post, Camp Mojache, Cenarion Hold
					["0.55:0.73:0.61:0.80:0.50:0.76"] = 194, -- Freewind Post, Gadgetzan, Marshal's Refuge
					["0.55:0.73:0.61:0.80"] = 93, -- Freewind Post, Gadgetzan
					["0.55:0.73:0.58:0.70"] = 69, -- Freewind Post, Mudsprocket
					["0.55:0.73:0.57:0.64"] = 96, -- Freewind Post, Brackenwall Village
					["0.55:0.73:0.53:0.61"] = 137, -- Freewind Post, Camp Taurajo
					["0.55:0.73:0.44:0.69"] = 123, -- Freewind Post, Camp Mojache
					["0.55:0.73:0.44:0.69:0.32:0.58"] = 323, -- Freewind Post, Camp Mojache, Shadowprey Village
					["0.55:0.73:0.45:0.56"] = 223, -- Freewind Post, Thunder Bluff
					["0.55:0.73:0.56:0.53"] = 192, -- Freewind Post, Crossroads
					["0.55:0.73:0.57:0.64:0.61:0.55"] = 184, -- Freewind Post, Brackenwall Village, Ratchet
					["0.55:0.73:0.57:0.64:0.61:0.55:0.63:0.44"] = 279, -- Freewind Post, Brackenwall Village, Ratchet, Orgrimmar
					["0.55:0.73:0.56:0.53:0.55:0.42"] = 354, -- Freewind Post, Crossroads, Splintertree Post
					["0.55:0.73:0.56:0.53:0.41:0.47"] = 342, -- Freewind Post, Crossroads, Sun Rock Retreat
					["0.55:0.73:0.56:0.53:0.41:0.37"] = 422, -- Freewind Post, Crossroads, Zoram'gar Outpost
					["0.55:0.73:0.56:0.53:0.46:0.30"] = 445, -- Freewind Post, Crossroads, Bloodvenom Post
					["0.55:0.73:0.56:0.53:0.55:0.42:0.50:0.35"] = 432, -- Freewind Post, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.55:0.73:0.56:0.53:0.63:0.36"] = 355, -- Freewind Post, Crossroads, Valormok
					["0.55:0.73:0.56:0.53:0.63:0.36:0.64:0.23"] = 484, -- Freewind Post, Crossroads, Valormok, Everlook
					["0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 566, -- Freewind Post, Crossroads, Bloodvenom Post, Moonglade
					["0.55:0.73:0.56:0.53:0.63:0.44"] = 308, -- Freewind Post, Crossroads, Orgrimmar
					["0.55:0.73:0.45:0.56:0.32:0.58"] = 382, -- Freewind Post, Thunder Bluff, Shadowprey Village
					["0.55:0.73:0.56:0.53:0.61:0.55"] = 243, -- Freewind Post, Crossroads, Ratchet
					["0.55:0.73:0.61:0.80:0.63:0.44"] = 443, -- Freewind Post, Gadgetzan, Orgrimmar
					["0.55:0.73:0.45:0.56:0.63:0.44:0.55:0.42"] = 519, -- Freewind Post, Thunder Bluff, Orgrimmar, Splintertree Post

					-- Horde: Gadgetzan (Tanaris)
					["0.61:0.80:0.42:0.79"] = 233, -- Gadgetzan, Cenarion Hold
					["0.61:0.80:0.50:0.76"] = 108, -- Gadgetzan, Marshal's Refuge
					["0.61:0.80:0.55:0.73"] = 87, -- Gadgetzan, Freewind Post
					["0.61:0.80:0.55:0.73:0.58:0.70"] = 155, -- Gadgetzan, Freewind Post, Mudsprocket
					["0.61:0.80:0.57:0.64"] = 194, -- Gadgetzan, Brackenwall Village
					["0.61:0.80:0.55:0.73:0.53:0.61"] = 223, -- Gadgetzan, Freewind Post, Camp Taurajo
					["0.61:0.80:0.44:0.69"] = 199, -- Gadgetzan, Camp Mojache
					["0.61:0.80:0.44:0.69:0.32:0.58"] = 399, -- Gadgetzan, Camp Mojache, Shadowprey Village
					["0.61:0.80:0.45:0.56"] = 304, -- Gadgetzan, Thunder Bluff
					["0.61:0.80:0.56:0.53"] = 300, -- Gadgetzan, Crossroads
					["0.61:0.80:0.61:0.55"] = 243, -- Gadgetzan, Ratchet
					["0.61:0.80:0.63:0.44"] = 350, -- Gadgetzan, Orgrimmar
					["0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42"] = 429, -- Gadgetzan, Ratchet, Orgrimmar, Splintertree Post
					["0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.47"] = 427, -- Gadgetzan, Freewind Post, Crossroads, Sun Rock Retreat
					["0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.37"] = 508, -- Gadgetzan, Freewind Post, Crossroads, Zoram'gar Outpost
					["0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 507, -- Gadgetzan, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30"] = 531, -- Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post
					["0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36"] = 434, -- Gadgetzan, Ratchet, Orgrimmar, Valormok
					["0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 564, -- Gadgetzan, Ratchet, Orgrimmar, Valormok, Everlook
					["0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 652, -- Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post, Moonglade
					["0.61:0.80:0.45:0.56:0.32:0.58"] = 463, -- Gadgetzan, Thunder Bluff, Shadowprey Village
					["0.61:0.80:0.56:0.53:0.53:0.61"] = 374, -- Gadgetzan, Crossroads, Camp Taurajo
					["0.61:0.80:0.61:0.55:0.63:0.44:0.64:0.23"] = 580, -- Gadgetzan, Ratchet, Orgrimmar, Everlook
					["0.61:0.80:0.57:0.64:0.58:0.70"] = 255, -- Gadgetzan, Brackenwall Village, Mudsprocket
					["0.61:0.80:0.55:0.73:0.56:0.53:0.63:0.36"] = 441, -- Gadgetzan, Freewind Post, Crossroads, Valormok

					-- Horde: Marshal's Refuge (Un'Goro Crater)
					["0.50:0.76:0.42:0.79"] = 100, -- Marshal's Refuge, Cenarion Hold
					["0.50:0.76:0.61:0.80"] = 113, -- Marshal's Refuge, Gadgetzan
					["0.50:0.76:0.61:0.80:0.55:0.73"] = 200, -- Marshal's Refuge, Gadgetzan, Freewind Post
					["0.50:0.76:0.61:0.80:0.55:0.73:0.58:0.70"] = 268, -- Marshal's Refuge, Gadgetzan, Freewind Post, Mudsprocket
					["0.50:0.76:0.61:0.80:0.55:0.73:0.57:0.64"] = 294, -- Marshal's Refuge, Gadgetzan, Freewind Post, Brackenwall Village
					["0.50:0.76:0.61:0.80:0.55:0.73:0.53:0.61"] = 336, -- Marshal's Refuge, Gadgetzan, Freewind Post, Camp Taurajo
					["0.50:0.76:0.42:0.79:0.44:0.69"] = 224, -- Marshal's Refuge, Cenarion Hold, Camp Mojache
					["0.50:0.76:0.42:0.79:0.44:0.69:0.32:0.58"] = 424, -- Marshal's Refuge, Cenarion Hold, Camp Mojache, Shadowprey Village
					["0.50:0.76:0.61:0.80:0.45:0.56"] = 416, -- Marshal's Refuge, Gadgetzan, Thunder Bluff
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53"] = 392, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads
					["0.50:0.76:0.61:0.80:0.61:0.55"] = 354, -- Marshal's Refuge, Gadgetzan, Ratchet
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44"] = 450, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42"] = 540, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Splintertree Post
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.47"] = 540, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Sun Rock Retreat
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.41:0.37"] = 621, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Zoram'gar Outpost
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 618, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30"] = 645, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36"] = 546, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Valormok
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 675, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Valormok, Everlook
					["0.50:0.76:0.61:0.80:0.55:0.73:0.56:0.53:0.46:0.30:0.54:0.21"] = 766, -- Marshal's Refuge, Gadgetzan, Freewind Post, Crossroads, Bloodvenom Post, Moonglade
					["0.50:0.76:0.61:0.80:0.44:0.69"] = 312, -- Marshal's Refuge, Gadgetzan, Camp Mojache
					["0.50:0.76:0.61:0.80:0.61:0.55:0.63:0.44:0.64:0.23"] = 691, -- Marshal's Refuge, Gadgetzan, Ratchet, Orgrimmar, Everlook
					["0.50:0.76:0.61:0.80:0.44:0.69:0.32:0.58"] = 512, -- Marshal's Refuge, Gadgetzan, Camp Mojache, Shadowprey Village
					["0.50:0.76:0.61:0.80:0.57:0.64:0.53:0.61"] = 354, -- Marshal's Refuge, Gadgetzan, Brackenwall Village, Camp Taurajo
					["0.50:0.76:0.61:0.80:0.57:0.64"] = 306, -- Marshal's Refuge, Gadgetzan, Brackenwall Village

					-- Horde: Moonglade (Moonglade)
					["0.54:0.21:0.46:0.30:0.56:0.53:0.44:0.69:0.42:0.79"] = 734, -- Moonglade, Bloodvenom Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 730, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73"] = 537, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 545, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.54:0.21:0.46:0.30:0.56:0.53:0.55:0.73:0.61:0.80"] = 629, -- Moonglade, Bloodvenom Post, Crossroads, Freewind Post, Gadgetzan
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61:0.57:0.64"] = 484, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.54:0.21:0.46:0.30:0.56:0.53:0.53:0.61"] = 426, -- Moonglade, Bloodvenom Post, Crossroads, Camp Taurajo
					["0.54:0.21:0.46:0.30:0.56:0.53:0.44:0.69"] = 604, -- Moonglade, Bloodvenom Post, Crossroads, Camp Mojache
					["0.54:0.21:0.46:0.30:0.41:0.37:0.41:0.47:0.32:0.58"] = 515, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.54:0.21:0.46:0.30:0.56:0.53:0.45:0.56"] = 459, -- Moonglade, Bloodvenom Post, Crossroads, Thunder Bluff
					["0.54:0.21:0.46:0.30:0.56:0.53"] = 353, -- Moonglade, Bloodvenom Post, Crossroads
					["0.54:0.21:0.46:0.30:0.56:0.53:0.61:0.55"] = 404, -- Moonglade, Bloodvenom Post, Crossroads, Ratchet
					["0.54:0.21:0.64:0.23:0.63:0.36:0.63:0.44"] = 377, -- Moonglade, Everlook, Valormok, Orgrimmar
					["0.54:0.21:0.46:0.30:0.50:0.35:0.55:0.42"] = 269, -- Moonglade, Bloodvenom Post, Emerald Sanctuary, Splintertree Post
					["0.54:0.21:0.46:0.30:0.41:0.37:0.41:0.47"] = 373, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.54:0.21:0.46:0.30:0.41:0.37"] = 253, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost
					["0.54:0.21:0.46:0.30:0.50:0.35"] = 186, -- Moonglade, Bloodvenom Post, Emerald Sanctuary
					["0.54:0.21:0.64:0.23:0.63:0.36"] = 276, -- Moonglade, Everlook, Valormok
					["0.54:0.21:0.64:0.23"] = 142, -- Moonglade, Everlook
					["0.54:0.21:0.46:0.30"] = 157, -- Moonglade, Bloodvenom Post
					["0.54:0.21:0.46:0.30:0.50:0.35:0.55:0.42:0.63:0.44"] = 358, -- Moonglade, Bloodvenom Post, Emerald Sanctuary, Splintertree Post, Orgrimmar
					["0.54:0.21:0.64:0.23:0.63:0.44"] = 384, -- Moonglade, Everlook, Orgrimmar
					["0.54:0.21:0.46:0.30:0.63:0.44"] = 371, -- Moonglade, Bloodvenom Post, Orgrimmar
					["0.54:0.21:0.64:0.23:0.63:0.44:0.61:0.55:0.57:0.64"] = 592, -- Moonglade, Everlook, Orgrimmar, Ratchet, Brackenwall Village
					["0.54:0.21:0.46:0.30:0.63:0.36"] = 339, -- Moonglade, Bloodvenom Post, Valormok
					["0.54:0.21:0.64:0.23:0.63:0.36:0.55:0.42"] = 370, -- Moonglade, Everlook, Valormok, Splintertree Post
					["0.54:0.21:0.64:0.23:0.63:0.36:0.56:0.53:0.44:0.69"] = 692, -- Moonglade, Everlook, Valormok, Crossroads, Camp Mojache
					["0.54:0.21:0.64:0.23:0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76:0.42:0.79"] = 933, -- Moonglade, Everlook, Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.54:0.21:0.46:0.30:0.56:0.53:0.45:0.56:0.32:0.58"] = 618, -- Moonglade, Bloodvenom Post, Crossroads, Thunder Bluff, Shadowprey Village
					["0.54:0.21:0.64:0.23:0.63:0.36:0.55:0.42:0.50:0.35"] = 448, -- Moonglade, Everlook, Valormok, Splintertree Post, Emerald Sanctuary
					["0.54:0.21:0.46:0.30:0.41:0.37:0.55:0.42"] = 426, -- Moonglade, Bloodvenom Post, Zoram'gar Outpost, Splintertree Post

					-- Horde: Mudsprocket (Dustwallow Marsh)
					["0.58:0.70:0.55:0.73:0.44:0.69:0.42:0.79"] = 324, -- Mudsprocket, Freewind Post, Camp Mojache, Cenarion Hold
					["0.58:0.70:0.55:0.73:0.61:0.80:0.50:0.76"] = 265, -- Mudsprocket, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.58:0.70:0.55:0.73"] = 71, -- Mudsprocket, Freewind Post
					["0.58:0.70:0.55:0.73:0.61:0.80"] = 164, -- Mudsprocket, Freewind Post, Gadgetzan
					["0.58:0.70:0.55:0.73:0.44:0.69"] = 194, -- Mudsprocket, Freewind Post, Camp Mojache
					["0.58:0.70:0.57:0.64"] = 63, -- Mudsprocket, Brackenwall Village
					["0.58:0.70:0.57:0.64:0.53:0.61"] = 111, -- Mudsprocket, Brackenwall Village, Camp Taurajo
					["0.58:0.70:0.57:0.64:0.53:0.61:0.45:0.56:0.32:0.58"] = 383, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Thunder Bluff, Shadowprey Village
					["0.58:0.70:0.57:0.64:0.53:0.61:0.45:0.56"] = 224, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Thunder Bluff
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53"] = 189, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads
					["0.58:0.70:0.57:0.64:0.61:0.55"] = 150, -- Mudsprocket, Brackenwall Village, Ratchet
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44"] = 245, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42"] = 334, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.47"] = 338, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Sun Rock Retreat
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.41:0.37"] = 419, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Zoram'gar Outpost
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 412, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36"] = 340, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Valormok
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30"] = 442, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post
					["0.58:0.70:0.57:0.64:0.53:0.61:0.56:0.53:0.46:0.30:0.54:0.21"] = 563, -- Mudsprocket, Brackenwall Village, Camp Taurajo, Crossroads, Bloodvenom Post, Moonglade
					["0.58:0.70:0.57:0.64:0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 469, -- Mudsprocket, Brackenwall Village, Ratchet, Orgrimmar, Valormok, Everlook
					["0.58:0.70:0.55:0.73:0.45:0.56"] = 294, -- Mudsprocket, Freewind Post, Thunder Bluff
					["0.58:0.70:0.55:0.73:0.56:0.53:0.61:0.55"] = 314, -- Mudsprocket, Freewind Post, Crossroads, Ratchet
					["0.58:0.70:0.55:0.73:0.53:0.61"] = 209, -- Mudsprocket, Freewind Post, Camp Taurajo
					["0.58:0.70:0.57:0.64:0.63:0.44"] = 279, -- Mudsprocket, Brackenwall Village, Orgrimmar
					["0.58:0.70:0.55:0.73:0.56:0.53:0.63:0.44"] = 379, -- Mudsprocket, Freewind Post, Crossroads, Orgrimmar
					["0.58:0.70:0.55:0.73:0.44:0.69:0.32:0.58"] = 394, -- Mudsprocket, Freewind Post, Camp Mojache, Shadowprey Village

					-- Horde: Orgrimmar (Durotar)
					["0.63:0.44:0.61:0.80"] = 417, -- Orgrimmar, Gadgetzan
					["0.63:0.44:0.56:0.53:0.44:0.69:0.42:0.79"] = 492, -- Orgrimmar, Crossroads, Camp Mojache, Cenarion Hold
					["0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76"] = 454, -- Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.63:0.44:0.56:0.53:0.55:0.73"] = 292, -- Orgrimmar, Crossroads, Freewind Post
					["0.63:0.44:0.61:0.55:0.57:0.64:0.58:0.70"] = 268, -- Orgrimmar, Ratchet, Brackenwall Village, Mudsprocket
					["0.63:0.44:0.57:0.64"] = 229, -- Orgrimmar, Brackenwall Village
					["0.63:0.44:0.56:0.53:0.53:0.61"] = 181, -- Orgrimmar, Crossroads, Camp Taurajo
					["0.63:0.44:0.56:0.53:0.44:0.69"] = 361, -- Orgrimmar, Crossroads, Camp Mojache
					["0.63:0.44:0.56:0.53:0.45:0.56:0.32:0.58"] = 373, -- Orgrimmar, Crossroads, Thunder Bluff, Shadowprey Village
					["0.63:0.44:0.45:0.56"] = 224, -- Orgrimmar, Thunder Bluff (David Galindo suggested 233)
					["0.63:0.44:0.56:0.53"] = 110, -- Orgrimmar, Crossroads
					["0.63:0.44:0.61:0.55"] = 108, -- Orgrimmar, Ratchet
					["0.63:0.44:0.63:0.36"] = 95, -- Orgrimmar, Valormok
					["0.63:0.44:0.55:0.42"] = 90, -- Orgrimmar, Splintertree Post
					["0.63:0.44:0.56:0.53:0.41:0.47"] = 258, -- Orgrimmar, Crossroads, Sun Rock Retreat
					["0.63:0.44:0.55:0.42:0.41:0.37"] = 249, -- Orgrimmar, Splintertree Post, Zoram'gar Outpost
					["0.63:0.44:0.55:0.42:0.50:0.35"] = 168, -- Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.63:0.44:0.46:0.30"] = 252, -- Orgrimmar, Bloodvenom Post
					["0.63:0.44:0.63:0.36:0.64:0.23:0.54:0.21"] = 358, -- Orgrimmar, Valormok, Everlook, Moonglade
					["0.63:0.44:0.64:0.23"] = 240, -- Orgrimmar, Everlook
					["0.63:0.44:0.55:0.42:0.50:0.35:0.46:0.30:0.54:0.21"] = 371, -- Orgrimmar, Splintertree Post, Emerald Sanctuary, Bloodvenom Post, Moonglade
					["0.63:0.44:0.56:0.53:0.41:0.37"] = 339, -- Orgrimmar, Crossroads, Zoram'gar Outpost
					["0.63:0.44:0.64:0.23:0.54:0.21"] = 374, -- Orgrimmar, Everlook, Moonglade
					["0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76:0.42:0.79"] = 549, -- Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.63:0.44:0.57:0.64:0.58:0.70"] = 289, -- Orgrimmar, Brackenwall Village, Mudsprocket
					["0.63:0.44:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76:0.42:0.79"] = 581, -- Orgrimmar, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.63:0.44:0.61:0.80:0.42:0.79"] = 650, -- Orgrimmar, Gadgetzan, Cenarion Hold
					["0.63:0.44:0.45:0.56:0.53:0.61"] = 312, -- Orgrimmar, Thunder Bluff, Camp Taurajo
					["0.63:0.44:0.45:0.56:0.55:0.73"] = 429, -- Orgrimmar, Thunder Bluff, Freewind Post
					["0.63:0.44:0.56:0.53:0.55:0.73:0.58:0.70"] = 361, -- Orgrimmar, Crossroads, Freewind Post, Mudsprocket
					["0.63:0.44:0.46:0.30:0.50:0.35"] = 278, -- Orgrimmar, Bloodvenom Post, Emerald Sanctuary
					["0.63:0.44:0.61:0.55:0.57:0.64:0.55:0.73:0.44:0.69:0.32:0.58"] = 633, -- Orgrimmar, Ratchet, Brackenwall Village, Freewind Post, Camp Mojache, Shadowprey Village
					["0.63:0.44:0.56:0.53:0.41:0.47:0.32:0.58"] = 400, -- Orgrimmar, Crossroads, Sun Rock Retreat, Shadowprey Village
					["0.63:0.44:0.45:0.56:0.41:0.47"] = 407, -- Orgrimmar, Thunder Bluff, Sun Rock Retreat
					["0.63:0.44:0.56:0.53:0.41:0.37:0.50:0.35"] = 459, -- Orgrimmar, Crossroads, Zoram'gar Outpost, Emerald Sanctuary

					-- Horde: Ratchet (The Barrens)
					["0.61:0.55:0.61:0.80:0.50:0.76:0.42:0.79"] = 443, -- Ratchet, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.61:0.55:0.61:0.80:0.50:0.76"] = 347, -- Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.55:0.57:0.64:0.55:0.73"] = 204, -- Ratchet, Brackenwall Village, Freewind Post
					["0.61:0.55:0.61:0.80"] = 241, -- Ratchet, Gadgetzan
					["0.61:0.55:0.56:0.53:0.44:0.69"] = 320, -- Ratchet, Crossroads, Camp Mojache
					["0.61:0.55:0.57:0.64:0.58:0.70"] = 161, -- Ratchet, Brackenwall Village, Mudsprocket
					["0.61:0.55:0.57:0.64"] = 101, -- Ratchet, Brackenwall Village
					["0.61:0.55:0.56:0.53:0.53:0.61"] = 141, -- Ratchet, Crossroads, Camp Taurajo
					["0.61:0.55:0.56:0.53:0.45:0.56:0.32:0.58"] = 334, -- Ratchet, Crossroads, Thunder Bluff, Shadowprey Village
					["0.61:0.55:0.56:0.53:0.45:0.56"] = 175, -- Ratchet, Crossroads, Thunder Bluff (Elena Liakhovskaia reported 70)
					["0.61:0.55:0.56:0.53"] = 69, -- Ratchet, Crossroads
					["0.61:0.55:0.56:0.53:0.41:0.47"] = 218, -- Ratchet, Crossroads, Sun Rock Retreat
					["0.61:0.55:0.63:0.44:0.55:0.42"] = 190, -- Ratchet, Orgrimmar, Splintertree Post -- CHANGE from 101 to 191 (Basse, Nate Sander, Lori Payne, Video Games, Josh Romey, Nelson Egger II)
					["0.61:0.55:0.63:0.44"] = 101, -- Ratchet, Orgrimmar
					["0.61:0.55:0.63:0.44:0.63:0.36"] = 196, -- Ratchet, Orgrimmar, Valormok
					["0.61:0.55:0.63:0.44:0.55:0.42:0.50:0.35"] = 269, -- Ratchet, Orgrimmar, Splintertree Post, Emerald Sanctuary
					["0.61:0.55:0.56:0.53:0.41:0.37"] = 299, -- Ratchet, Crossroads, Zoram'gar Outpost
					["0.61:0.55:0.56:0.53:0.46:0.30"] = 321, -- Ratchet, Crossroads, Bloodvenom Post
					["0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23:0.54:0.21"] = 458, -- Ratchet, Orgrimmar, Valormok, Everlook, Moonglade
					["0.61:0.55:0.63:0.44:0.63:0.36:0.64:0.23"] = 325, -- Ratchet, Orgrimmar, Valormok, Everlook
					["0.61:0.55:0.56:0.53:0.55:0.73"] = 253, -- Ratchet, Crossroads, Freewind Post
					["0.61:0.55:0.63:0.44:0.64:0.23"] = 341, -- Ratchet, Orgrimmar, Everlook
					["0.61:0.55:0.56:0.53:0.46:0.30:0.54:0.21"] = 443, -- Ratchet, Crossroads, Bloodvenom Post, Moonglade
					["0.61:0.55:0.56:0.53:0.55:0.73:0.58:0.70"] = 322, -- Ratchet, Crossroads, Freewind Post, Mudsprocket
					["0.61:0.55:0.63:0.44:0.55:0.42:0.41:0.37"] = 349, -- Ratchet, Orgrimmar, Splintertree Post, Zoram'gar Outpost
					["0.61:0.55:0.56:0.53:0.41:0.37:0.50:0.35"] = 420, -- Ratchet, Crossroads, Zoram'gar Outpost, Emerald Sanctuary
					["0.61:0.55:0.63:0.44:0.45:0.56"] = 326, -- Ratchet, Orgrimmar, Thunder Bluff
					["0.61:0.55:0.63:0.44:0.45:0.56:0.53:0.61"] = 413, -- Trinquete, Orgrimmar, Cima del Trueno, Campamento Taurajo
					["0.61:0.55:0.56:0.53:0.55:0.42"] = 231, -- Ratchet, Crossroads, Splintertree Post

					-- Horde: Shadowprey Village (Desolace)
					["0.32:0.58:0.44:0.69:0.42:0.79"] = 326, -- Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.32:0.58:0.44:0.69:0.42:0.79:0.50:0.76"] = 417, -- Shadowprey Village, Camp Mojache, Cenarion Hold, Marshal's Refuge
					["0.32:0.58:0.44:0.69:0.55:0.73:0.61:0.80"] = 395, -- Shadowprey Village, Camp Mojache, Freewind Post, Gadgetzan
					["0.32:0.58:0.44:0.69:0.55:0.73"] = 303, -- Shadowprey Village, Camp Mojache, Freewind Post
					["0.32:0.58:0.44:0.69"] = 196, -- Shadowprey Village, Camp Mojache
					["0.32:0.58:0.44:0.69:0.55:0.73:0.58:0.70"] = 372, -- Shadowprey Village, Camp Mojache, Freewind Post, Mudsprocket
					["0.32:0.58:0.45:0.56:0.53:0.61:0.57:0.64"] = 323, -- Shadowprey Village, Thunder Bluff, Camp Taurajo, Brackenwall Village
					["0.32:0.58:0.45:0.56:0.53:0.61"] = 265, -- Shadowprey Village, Thunder Bluff, Camp Taurajo
					["0.32:0.58:0.45:0.56:0.56:0.53:0.61:0.55"] = 332, -- Shadowprey Village, Thunder Bluff, Crossroads, Ratchet
					["0.32:0.58:0.45:0.56:0.56:0.53"] = 281, -- Shadowprey Village, Thunder Bluff, Crossroads
					["0.32:0.58:0.45:0.56"] = 178, -- Shadowprey Village, Thunder Bluff
					["0.32:0.58:0.41:0.47"] = 199, -- Shadowprey Village, Sun Rock Retreat
					["0.32:0.58:0.45:0.56:0.56:0.53:0.55:0.42"] = 443, -- Shadowprey Village, Thunder Bluff, Crossroads, Splintertree Post
					["0.32:0.58:0.45:0.56:0.63:0.44"] = 386, -- Shadowprey Village, Thunder Bluff, Orgrimmar
					["0.32:0.58:0.45:0.56:0.63:0.36"] = 429, -- Shadowprey Village, Thunder Bluff, Valormok
					["0.32:0.58:0.41:0.47:0.41:0.37:0.50:0.35"] = 441, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Emerald Sanctuary
					["0.32:0.58:0.41:0.47:0.41:0.37"] = 320, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost
					["0.32:0.58:0.41:0.47:0.41:0.37:0.46:0.30"] = 457, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post
					["0.32:0.58:0.41:0.47:0.41:0.37:0.46:0.30:0.54:0.21"] = 581, -- Shadowprey Village, Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post, Moonglade
					["0.32:0.58:0.45:0.56:0.63:0.36:0.64:0.23"] = 558, -- Shadowprey Village, Thunder Bluff, Valormok, Everlook
					["0.32:0.58:0.45:0.56:0.55:0.73"] = 382, -- Shadowprey Village, Thunder Bluff, Freewind Post
					["0.32:0.58:0.45:0.56:0.53:0.61:0.57:0.64:0.58:0.70"] = 384, -- Shadowprey Village, Thunder Bluff, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.32:0.58:0.45:0.56:0.61:0.80"] = 469, -- Shadowprey Village, Thunder Bluff, Gadgetzan
					["0.32:0.58:0.44:0.69:0.55:0.73:0.61:0.80:0.50:0.76"] = 497, -- Shadowprey Village, Camp Mojache, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.32:0.58:0.41:0.47:0.56:0.53:0.63:0.44"] = 465, -- Shadowprey Village, Sun Rock Retreat, Crossroads, Orgrimmar
					["0.32:0.58:0.45:0.56:0.63:0.44:0.64:0.23"] = 626, -- Shadowprey Village, Thunder Bluff, Orgrimmar, Everlook
					["0.32:0.58:0.45:0.56:0.63:0.36:0.64:0.23:0.54:0.21"] = 691, -- Shadowprey Village, Thunder Bluff, Valormok, Everlook, Moonglade
					["0.32:0.58:0.41:0.47:0.56:0.53:0.55:0.73"] = 533, -- Shadowprey Village, Sun Rock Retreat, Crossroads, Freewind Post
					["0.32:0.58:0.41:0.47:0.56:0.53"] = 348, -- Shadowprey Village, Sun Rock Retreat, Crossroads
					["0.32:0.58:0.45:0.56:0.56:0.53:0.55:0.42:0.50:0.35"] = 521, -- Shadowprey Village, Thunder Bluff, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.32:0.58:0.41:0.47:0.56:0.53:0.61:0.55"] = 400, -- Schattenflucht, Sonnenfels, Das Wegekreuz, Ratschet

					-- Horde: Splintertree Post (Ashenvale)
					["0.55:0.42:0.56:0.53:0.44:0.69:0.42:0.79"] = 541, -- Splintertree Post, Crossroads, Camp Mojache, Cenarion Hold
					["0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 538, -- Splintertree Post, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.55:0.42:0.56:0.53:0.55:0.73"] = 345, -- Splintertree Post, Crossroads, Freewind Post
					["0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 354, -- Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.55:0.42:0.56:0.53:0.55:0.73:0.61:0.80"] = 436, -- Splintertree Post, Crossroads, Freewind Post, Gadgetzan
					["0.55:0.42:0.56:0.53:0.53:0.61:0.57:0.64"] = 292, -- Splintertree Post, Crossroads, Camp Taurajo, Brackenwall Village
					["0.55:0.42:0.56:0.53:0.53:0.61"] = 234, -- Splintertree Post, Crossroads, Camp Taurajo
					["0.55:0.42:0.56:0.53:0.44:0.69"] = 412, -- Splintertree Post, Crossroads, Camp Mojache
					["0.55:0.42:0.56:0.53:0.45:0.56:0.32:0.58"] = 426, -- Splintertree Post, Crossroads, Thunder Bluff, Shadowprey Village
					["0.55:0.42:0.56:0.53:0.45:0.56"] = 267, -- Splintertree Post, Crossroads, Thunder Bluff
					["0.55:0.42:0.56:0.53"] = 160, -- Splintertree Post, Crossroads
					["0.55:0.42:0.63:0.44:0.61:0.55"] = 203, -- Splintertree Post, Orgrimmar, Ratchet
					["0.55:0.42:0.63:0.44"] = 96, -- Splintertree Post, Orgrimmar
					["0.55:0.42:0.63:0.36"] = 92, -- Splintertree Post, Valormok
					["0.55:0.42:0.50:0.35"] = 85, -- Splintertree Post, Emerald Sanctuary
					["0.55:0.42:0.41:0.37"] = 166, -- Splintertree Post, Zoram'gar Outpost
					["0.55:0.42:0.41:0.37:0.41:0.47"] = 287, -- Splintertree Post, Zoram'gar Outpost, Sun Rock Retreat
					["0.55:0.42:0.50:0.35:0.46:0.30"] = 163, -- Splintertree Post, Emerald Sanctuary, Bloodvenom Post
					["0.55:0.42:0.50:0.35:0.46:0.30:0.54:0.21"] = 287, -- Splintertree Post, Emerald Sanctuary, Bloodvenom Post, Moonglade
					["0.55:0.42:0.63:0.36:0.64:0.23"] = 221, -- Splintertree Post, Valormok, Everlook
					["0.55:0.42:0.56:0.53:0.61:0.55"] = 212, -- Splintertree Post, Crossroads, Ratchet
					["0.55:0.42:0.56:0.53:0.41:0.47"] = 310, -- Splintertree Post, Crossroads, Sun Rock Retreat
					["0.55:0.42:0.63:0.44:0.46:0.30"] = 348, -- Splintertree Post, Orgrimmar, Bloodvenom Post
					["0.55:0.42:0.41:0.37:0.46:0.30"] = 303, -- Splintertree Post, Zoram'gar Outpost, Bloodvenom Post
					["0.55:0.42:0.63:0.36:0.64:0.23:0.54:0.21"] = 354, -- Splintertree Post, Valormok, Everlook, Moonglade
					["0.55:0.42:0.63:0.44:0.64:0.23"] = 336, -- Splintertree Post, Orgrimmar, Everlook
					["0.55:0.42:0.41:0.37:0.41:0.47:0.32:0.58"] = 429, -- Splintertree Post, Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village

					-- Horde: Sun Rock Retreat (Stonetalon Mountains)
					["0.41:0.47:0.56:0.53:0.55:0.73:0.61:0.80"] = 426, -- Sun Rock Retreat, Crossroads, Freewind Post, Gadgetzan
					["0.41:0.47:0.32:0.58:0.44:0.69:0.42:0.79"] = 469, -- Sun Rock Retreat, Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.41:0.47:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 527, -- Sun Rock Retreat, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.41:0.47:0.56:0.53:0.55:0.73"] = 333, -- Sun Rock Retreat, Crossroads, Freewind Post
					["0.41:0.47:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 342, -- Sun Rock Retreat, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.41:0.47:0.56:0.53:0.53:0.61:0.57:0.64"] = 281, -- Sun Rock Retreat, Crossroads, Camp Taurajo, Brackenwall Village
					["0.41:0.47:0.56:0.53:0.53:0.61"] = 223, -- Sun Rock Retreat, Crossroads, Camp Taurajo
					["0.41:0.47:0.32:0.58:0.44:0.69"] = 339, -- Sun Rock Retreat, Shadowprey Village, Camp Mojache
					["0.41:0.47:0.32:0.58"] = 143, -- Sun Rock Retreat, Shadowprey Village
					["0.41:0.47:0.45:0.56"] = 175, -- Sun Rock Retreat, Thunder Bluff
					["0.41:0.47:0.56:0.53"] = 150, -- Sun Rock Retreat, Crossroads
					["0.41:0.47:0.56:0.53:0.61:0.55"] = 201, -- Sun Rock Retreat, Crossroads, Ratchet (was 200, changed to 150 by William Black, changed back to 201 by Oliver Snith)
					["0.41:0.47:0.56:0.53:0.63:0.44"] = 266, -- Sun Rock Retreat, Crossroads, Orgrimmar
					["0.41:0.47:0.41:0.37:0.55:0.42"] = 294, -- Sun Rock Retreat, Zoram'gar Outpost, Splintertree Post
					["0.41:0.47:0.56:0.53:0.63:0.36"] = 313, -- Sun Rock Retreat, Crossroads, Valormok
					["0.41:0.47:0.56:0.53:0.63:0.36:0.64:0.23"] = 442, -- Sun Rock Retreat, Crossroads, Valormok, Everlook
					["0.41:0.47:0.41:0.37:0.50:0.35"] = 242, -- Sun Rock Retreat, Zoram'gar Outpost, Emerald Sanctuary
					["0.41:0.47:0.41:0.37:0.46:0.30"] = 257, -- Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post
					["0.41:0.47:0.41:0.37:0.46:0.30:0.54:0.21"] = 382, -- Sun Rock Retreat, Zoram'gar Outpost, Bloodvenom Post, Moonglade
					["0.41:0.47:0.41:0.37"] = 121, -- Sun Rock Retreat, Zoram'gar Outpost
					["0.41:0.47:0.56:0.53:0.55:0.42"] = 312, -- Sun Rock Retreat, Crossroads, Splintertree Post
					["0.41:0.47:0.45:0.56:0.63:0.44:0.55:0.42"] = 471, -- Sun Rock Retreat, Thunder Bluff, Orgrimmar, Splintertree Post
					["0.41:0.47:0.45:0.56:0.63:0.44"] = 382, -- Sun Rock Retreat, Thunder Bluff, Orgrimmar

					-- Horde: Thunder Bluff (Mulgore)
					["0.45:0.56:0.44:0.69:0.42:0.79"] = 381, -- Thunder Bluff, Camp Mojache, Cenarion Hold
					["0.45:0.56:0.61:0.80:0.50:0.76"] = 395, -- Thunder Bluff, Gadgetzan, Marshal's Refuge
					["0.45:0.56:0.55:0.73"] = 204, -- Thunder Bluff, Freewind Post
					["0.45:0.56:0.61:0.80"] = 290, -- Thunder Bluff, Gadgetzan
					["0.45:0.56:0.53:0.61:0.57:0.64:0.58:0.70"] = 206, -- Thunder Bluff, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.45:0.56:0.57:0.64"] = 239, -- Thunder Bluff, Brackenwall Village
					["0.45:0.56:0.53:0.61"] = 87, -- Thunder Bluff, Camp Taurajo (Steven Martin suggested 97 but testing showed 87)
					["0.45:0.56:0.44:0.69"] = 252, -- Thunder Bluff, Camp Mojache
					["0.45:0.56:0.32:0.58"] = 159, -- Thunder Bluff, Shadowprey Village
					["0.45:0.56:0.41:0.47"] = 182, -- Thunder Bluff, Sun Rock Retreat
					["0.45:0.56:0.56:0.53"] = 103, -- Thunder Bluff, Crossroads
					["0.45:0.56:0.56:0.53:0.61:0.55"] = 154, -- Thunder Bluff, Crossroads, Ratchet
					["0.45:0.56:0.63:0.44"] = 207, -- Thunder Bluff, Orgrimmar
					["0.45:0.56:0.56:0.53:0.55:0.42"] = 265, -- Thunder Bluff, Crossroads, Splintertree Post
					["0.45:0.56:0.63:0.36"] = 251, -- Thunder Bluff, Valormok
					["0.45:0.56:0.56:0.53:0.55:0.42:0.50:0.35"] = 343, -- Thunder Bluff, Crossroads, Splintertree Post, Emerald Sanctuary
					["0.45:0.56:0.56:0.53:0.46:0.30"] = 355, -- Thunder Bluff, Crossroads, Bloodvenom Post
					["0.45:0.56:0.41:0.37"] = 265, -- Thunder Bluff, Zoram'gar Outpost
					["0.45:0.56:0.63:0.36:0.64:0.23:0.54:0.21"] = 513, -- Thunder Bluff, Valormok, Everlook, Moonglade
					["0.45:0.56:0.63:0.36:0.64:0.23"] = 380, -- Thunder Bluff, Valormok, Everlook
					["0.45:0.56:0.61:0.80:0.50:0.76:0.42:0.79"] = 490, -- Thunder Bluff, Gadgetzan, Marshal's Refuge, Cenarion Hold
					["0.45:0.56:0.63:0.44:0.64:0.23"] = 448, -- Thunder Bluff, Orgrimmar, Everlook
					["0.45:0.56:0.56:0.53:0.46:0.30:0.54:0.21"] = 477, -- Thunder Bluff, Crossroads, Bloodvenom Post, Moonglade
					["0.45:0.56:0.63:0.44:0.61:0.55"] = 315, -- Thunder Bluff, Orgrimmar, Ratchet

					-- Horde: Valormok (Azshara)
					["0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80"] = 441, -- Valormok, Crossroads, Freewind Post, Gadgetzan
					["0.63:0.36:0.56:0.53:0.44:0.69:0.42:0.79"] = 545, -- Valormok, Crossroads, Camp Mojache, Cenarion Hold
					["0.63:0.36:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 541, -- Valormok, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.63:0.36:0.56:0.53:0.55:0.73"] = 348, -- Valormok, Crossroads, Freewind Post
					["0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 356, -- Valormok, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.63:0.36:0.56:0.53:0.53:0.61:0.57:0.64"] = 295, -- Valormok, Crossroads, Camp Taurajo, Brackenwall Village
					["0.63:0.36:0.56:0.53:0.53:0.61"] = 237, -- Valormok, Crossroads, Camp Taurajo
					["0.63:0.36:0.56:0.53:0.44:0.69"] = 415, -- Valormok, Crossroads, Camp Mojache
					["0.63:0.36:0.45:0.56:0.32:0.58"] = 409, -- Valormok, Thunder Bluff, Shadowprey Village
					["0.63:0.36:0.45:0.56"] = 250, -- Valormok, Thunder Bluff
					["0.63:0.36:0.56:0.53"] = 164, -- Valormok, Crossroads
					["0.63:0.36:0.63:0.44:0.61:0.55"] = 208, -- Valormok, Orgrimmar, Ratchet
					["0.63:0.36:0.63:0.44"] = 101, -- Valormok, Orgrimmar
					["0.63:0.36:0.55:0.42"] = 94, -- Valormok, Splintertree Post
					["0.63:0.36:0.56:0.53:0.41:0.47"] = 313, -- Valormok, Crossroads, Sun Rock Retreat
					["0.63:0.36:0.55:0.42:0.41:0.37"] = 253, -- Valormok, Splintertree Post, Zoram'gar Outpost
					["0.63:0.36:0.55:0.42:0.50:0.35"] = 172, -- Valormok, Splintertree Post, Emerald Sanctuary
					["0.63:0.36:0.46:0.30"] = 233, -- Valormok, Bloodvenom Post
					["0.63:0.36:0.64:0.23:0.54:0.21"] = 264, -- Valormok, Everlook, Moonglade
					["0.63:0.36:0.64:0.23"] = 131, -- Valormok, Everlook
					["0.63:0.36:0.46:0.30:0.54:0.21"] = 349, -- Valormok, Bloodvenom Post, Moonglade
					["0.63:0.36:0.63:0.44:0.61:0.55:0.61:0.80:0.50:0.76"] = 555, -- Valormok, Orgrimmar, Ratchet, Gadgetzan, Marshal's Refuge

					-- Horde: Zoram'gar Outpost (Ashenvale)
					["0.41:0.37:0.56:0.53:0.55:0.73:0.61:0.80"] = 512, -- Zoram'gar Outpost, Crossroads, Freewind Post, Gadgetzan
					["0.41:0.37:0.41:0.47:0.32:0.58:0.44:0.69:0.42:0.79"] = 589, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village, Camp Mojache, Cenarion Hold
					["0.41:0.37:0.56:0.53:0.55:0.73:0.61:0.80:0.50:0.76"] = 611, -- Zoram'gar Outpost, Crossroads, Freewind Post, Gadgetzan, Marshal's Refuge
					["0.41:0.37:0.56:0.53:0.55:0.73"] = 419, -- Zoram'gar Outpost, Crossroads, Freewind Post
					["0.41:0.37:0.56:0.53:0.53:0.61:0.57:0.64:0.58:0.70"] = 428, -- Zoram'gar Outpost, Crossroads, Camp Taurajo, Brackenwall Village, Mudsprocket
					["0.41:0.37:0.56:0.53:0.53:0.61:0.57:0.64"] = 366, -- Zoram'gar Outpost, Crossroads, Camp Taurajo, Brackenwall Village
					["0.41:0.37:0.56:0.53:0.53:0.61"] = 309, -- Zoram'gar Outpost, Crossroads, Camp Taurajo
					["0.41:0.37:0.41:0.47:0.32:0.58:0.44:0.69"] = 459, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village, Camp Mojache
					["0.41:0.37:0.41:0.47:0.32:0.58"] = 264, -- Zoram'gar Outpost, Sun Rock Retreat, Shadowprey Village
					["0.41:0.37:0.45:0.56"] = 247, -- Zoram'gar Outpost, Thunder Bluff
					["0.41:0.37:0.56:0.53"] = 235, -- Zoram'gar Outpost, Crossroads
					["0.41:0.37:0.56:0.53:0.61:0.55"] = 287, -- Zoram'gar Outpost, Crossroads, Ratchet
					["0.41:0.37:0.55:0.42:0.63:0.44"] = 262, -- Zoram'gar Outpost, Splintertree Post, Orgrimmar
					["0.41:0.37:0.55:0.42"] = 173, -- Zoram'gar Outpost, Splintertree Post
					["0.41:0.37:0.41:0.47"] = 121, -- Zoram'gar Outpost, Sun Rock Retreat
					["0.41:0.37:0.50:0.35"] = 122, -- Zoram'gar Outpost, Emerald Sanctuary
					["0.41:0.37:0.46:0.30"] = 138, -- Zoram'gar Outpost, Bloodvenom Post
					["0.41:0.37:0.55:0.42:0.63:0.36"] = 258, -- Zoram'gar Outpost, Splintertree Post, Valormok
					["0.41:0.37:0.46:0.30:0.64:0.23"] = 285, -- Zoram'gar Outpost, Bloodvenom Post, Everlook
					["0.41:0.37:0.46:0.30:0.54:0.21"] = 263, -- Zoram'gar Outpost, Bloodvenom Post, Moonglade
					["0.41:0.37:0.56:0.53:0.63:0.44"] = 352, -- Zoram'gar Outpost, Crossroads, Orgrimmar
					["0.41:0.37:0.45:0.56:0.32:0.58"] = 407, -- Zoram'gar Outpost, Thunder Bluff, Shadowprey Village
					["0.41:0.37:0.45:0.56:0.63:0.44"] = 455, -- Zoram'gar Outpost, Thunder Bluff, Orgrimmar

				},

				-- Horde: Outland
				[1945] = {

					-- Horde: Altar of Sha'tar (Shadowmoon Valley)
					["0.81:0.77:0.66:0.77"] = 67, -- Altar of Sha'tar, Shadowmoon Village
					["0.81:0.77:0.51:0.73:0.44:0.67"] = 193, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath
					["0.81:0.77:0.51:0.73"] = 140, -- Altar of Sha'tar, Stonebreaker Hold
					["0.81:0.77:0.51:0.73:0.65:0.50"] = 263, -- Altar of Sha'tar, Stonebreaker Hold, Thrallmar
					["0.81:0.77:0.51:0.73:0.44:0.67:0.23:0.50"] = 329, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.81:0.77:0.51:0.73:0.44:0.67:0.29:0.62"] = 274, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Garadar
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 398, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 463, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 446, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51"] = 272, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 378, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 403, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.81:0.77:0.51:0.73:0.65:0.50:0.68:0.63"] = 328, -- Altar of Sha'tar, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.81:0.77:0.51:0.73:0.65:0.50:0.79:0.54"] = 333, -- Altar of Sha'tar, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.81:0.77:0.51:0.73:0.44:0.67:0.54:0.57"] = 269, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Falcon Watch
					["0.81:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 342, -- Altar of Sha'tar, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 378, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 398, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.81:0.77:0.66:0.77:0.51:0.73"] = 140, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67"] = 194, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.29:0.62"] = 274, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Garadar
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 445, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.81:0.77:0.66:0.77:0.51:0.73:0.65:0.50"] = 263, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Thrallmar
					["0.81:0.77:0.66:0.77:0.51:0.73:0.65:0.50:0.79:0.54"] = 333, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51"] = 272, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 403, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 474, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 342, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 463, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.23:0.50"] = 329, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.81:0.77:0.66:0.77:0.51:0.73:0.44:0.67:0.54:0.57"] = 269, -- Altar of Sha'tar, Shadowmoon Village, Stonebreaker Hold, Shattrath, Falcon Watch

					-- Horde: Area 52 (Netherstorm)
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 357, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 342, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 343, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 273, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 204, -- Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 292, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 224, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.58:0.27:0.49:0.36:0.44:0.51"] = 137, -- Area 52, Mok'Nathal Village, Swamprat Post
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 306, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.58:0.27:0.49:0.36:0.44:0.51:0.23:0.50"] = 248, -- Area 52, Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.58:0.27:0.38:0.32"] = 108, -- Area 52, Thunderlord Stronghold
					["0.58:0.27:0.49:0.36"] = 64, -- Area 52, Mok'Nathal Village
					["0.58:0.27:0.42:0.28"] = 82, -- Area 52, Evergrove (was 80, Michael Kartoz reported 86 so changed to 82)
					["0.58:0.27:0.63:0.18"] = 47, -- Area 52, The Stormspire
					["0.58:0.27:0.72:0.28"] = 66, -- Area 52, Cosmowrench
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 437, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.58:0.27:0.38:0.32:0.44:0.51:0.54:0.57"] = 287, -- Area 52, Thunderlord Stronghold, Swamprat Post, Falcon Watch
					["0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 420, -- Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67"] = 311, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.58:0.27:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 359, -- Area 52, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 443, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.58:0.27:0.38:0.32:0.44:0.51"] = 224, -- Area 52, Thunderlord Stronghold, Swamprat Post
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 379, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.58:0.27:0.38:0.32:0.23:0.50"] = 257, -- Area 52, Thunderlord Stronghold, Zabra'jin
					["0.58:0.27:0.38:0.32:0.23:0.50:0.29:0.62"] = 335, -- Area 52, Thunderlord Stronghold, Zabra'jin, Garadar
					["0.58:0.27:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 430, -- Area 52, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 507, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 524, -- Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.58:0.27:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 424, -- Area 52, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge

					-- Horde: Cosmowrench (Netherstorm)
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 420, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 401, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 406, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 336, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 264, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 355, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 287, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51"] = 204, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 371, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.23:0.50"] = 312, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.72:0.28:0.58:0.27:0.38:0.32"] = 173, -- Cosmowrench, Area 52, Thunderlord Stronghold
					["0.72:0.28:0.58:0.27:0.49:0.36"] = 129, -- Cosmowrench, Area 52, Mok'Nathal Village
					["0.72:0.28:0.58:0.27:0.42:0.28"] = 146, -- Cosmowrench, Area 52, Evergrove
					["0.72:0.28:0.58:0.27"] = 64, -- Cosmowrench, Area 52
					["0.72:0.28:0.63:0.18"] = 61, -- Cosmowrench, The Stormspire
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 484, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.72:0.28:0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67"] = 374, -- Cosmowrench, Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.72:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 501, -- Cosmowrench, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.72:0.28:0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 442, -- Cosmowrench, Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.72:0.28:0.58:0.27:0.38:0.32:0.44:0.51"] = 288, -- Cosmowrench, Area 52, Thunderlord Stronghold, Swamprat Post
					["0.72:0.28:0.63:0.18:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 457, -- Cosmowrench, The Stormspire, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.72:0.28:0.58:0.27:0.38:0.32:0.23:0.50"] = 320, -- Cosmowrench, Area 52, Thunderlord Stronghold, Zabra'jin
					["0.72:0.28:0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.29:0.62"] = 456, -- Cosmowrench, Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Garadar
					["0.72:0.28:0.63:0.18:0.38:0.32:0.44:0.51:0.44:0.67"] = 409, -- Cosmowrench, The Stormspire, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.72:0.28:0.58:0.27:0.38:0.32:0.23:0.50:0.29:0.62"] = 398, -- Cosmowrench, Area 52, Thunderlord Stronghold, Zabra'jin, Garadar
					["0.72:0.28:0.58:0.27:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 571, -- Cosmowrench, Area 52, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars

					-- Horde: Evergrove (Blade's Edge Mountains)
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 371, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 353, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 358, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 287, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.42:0.28:0.38:0.32:0.44:0.51:0.54:0.57"] = 215, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Falcon Watch
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 306, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67"] = 238, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.42:0.28:0.38:0.32:0.44:0.51"] = 152, -- Evergrove, Thunderlord Stronghold, Swamprat Post
					["0.42:0.28:0.38:0.32:0.23:0.50:0.29:0.62"] = 262, -- Evergrove, Thunderlord Stronghold, Zabra'jin, Garadar
					["0.42:0.28:0.38:0.32:0.23:0.50"] = 184, -- Evergrove, Thunderlord Stronghold, Zabra'jin
					["0.42:0.28:0.38:0.32"] = 36, -- Evergrove, Thunderlord Stronghold
					["0.42:0.28:0.38:0.32:0.49:0.36"] = 91, -- Evergrove, Thunderlord Stronghold, Mok'Nathal Village
					["0.42:0.28:0.58:0.27"] = 78, -- Evergrove, Area 52
					["0.42:0.28:0.58:0.27:0.72:0.28"] = 143, -- Evergrove, Area 52, Cosmowrench
					["0.42:0.28:0.58:0.27:0.63:0.18"] = 125, -- Evergrove, Area 52, The Stormspire
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 435, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 452, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.42:0.28:0.38:0.32:0.44:0.51:0.44:0.67:0.29:0.62"] = 319, -- Evergrove, Thunderlord Stronghold, Swamprat Post, Shattrath, Garadar
					["0.42:0.28:0.38:0.32:0.63:0.18"] = 192, -- Evergrove, Thunderlord Stronghold, The Stormspire
					["0.42:0.28:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 301, -- Evergrove, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath

					-- Horde: Falcon Watch (Hellfire Peninsula)
					["0.54:0.57:0.44:0.67:0.51:0.73:0.66:0.77"] = 204, -- Falcon Watch, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.54:0.57:0.65:0.50:0.68:0.63"] = 138, -- Falcon Watch, Thrallmar, Spinebreaker Ridge (suggestion of 74 by Jeremiah Wilson)
					["0.54:0.57:0.65:0.50:0.79:0.54"] = 143, -- Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.54:0.57:0.65:0.50"] = 73, -- Falcon Watch, Thrallmar
					["0.54:0.57:0.44:0.67:0.51:0.73"] = 139, -- Falcon Watch, Shattrath, Stonebreaker Hold
					["0.54:0.57:0.44:0.67"] = 71, -- Falcon Watch, Shattrath
					["0.54:0.57:0.44:0.51"] = 69, -- Falcon Watch, Swamprat Post (Infarkt reported 90)
					["0.54:0.57:0.29:0.62"] = 132, -- Falcon Watch, Garadar
					["0.54:0.57:0.23:0.50"] = 150, -- Falcon Watch, Zabra'jin
					["0.54:0.57:0.44:0.51:0.38:0.32"] = 174, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 201, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.54:0.57:0.44:0.51:0.49:0.36"] = 139, -- Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 199, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 260, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 242, -- Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.54:0.57:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 286, -- Falcon Watch, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.54:0.57:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 269, -- Falcon Watch, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27"] = 271, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 319, -- Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire

					-- Horde: Garadar (Nagrand)
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77"] = 210, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.29:0.62:0.44:0.67:0.51:0.73"] = 145, -- Garadar, Shattrath, Stonebreaker Hold
					["0.29:0.62:0.44:0.67"] = 77, -- Garadar, Shattrath
					["0.29:0.62:0.54:0.57:0.65:0.50:0.68:0.63"] = 266, -- Garadar, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.29:0.62:0.54:0.57:0.65:0.50:0.79:0.54"] = 270, -- Garadar, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.29:0.62:0.54:0.57:0.65:0.50"] = 199, -- Garadar, Falcon Watch, Thrallmar
					["0.29:0.62:0.54:0.57"] = 126, -- Garadar, Falcon Watch
					["0.29:0.62:0.44:0.67:0.44:0.51"] = 156, -- Garadar, Shattrath, Swamprat Post
					["0.29:0.62:0.23:0.50"] = 67, -- Garadar, Zabra'jin
					["0.29:0.62:0.23:0.50:0.38:0.32"] = 177, -- Garadar, Zabra'jin, Thunderlord Stronghold
					["0.29:0.62:0.23:0.50:0.38:0.32:0.42:0.28"] = 203, -- Garadar, Zabra'jin, Thunderlord Stronghold, Evergrove
					["0.29:0.62:0.44:0.67:0.44:0.51:0.49:0.36"] = 227, -- Garadar, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27"] = 274, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27:0.72:0.28"] = 339, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.29:0.62:0.23:0.50:0.38:0.32:0.58:0.27:0.63:0.18"] = 322, -- Garadar, Zabra'jin, Thunderlord Stronghold, Area 52, The Stormspire
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 291, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.29:0.62:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 274, -- Garadar, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.29:0.62:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 282, -- Garadar, Shattrath, Sumpfrattenposten, Dorf der Mok'Nathal, Area 52
					["0.29:0.62:0.23:0.50:0.44:0.51"] = 175, -- Garadar, Zabra'jin, Swamprat Post
					["0.29:0.62:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 359, -- Garadar, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.29:0.62:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 287, -- Garadar, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.29:0.62:0.44:0.67:0.44:0.51:0.38:0.32"] = 262, -- Garadar, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.29:0.62:0.44:0.67:0.65:0.50"] = 205, -- Garadar, Shattrath, Thrallmar
					["0.29:0.62:0.23:0.50:0.38:0.32:0.49:0.36"] = 233, -- Garadar, Zabra'jin, Thunderlord Stronghold, Mok'Nathal Village

					-- Horde: Hellfire Peninsula (Hellfire Peninsula) (Dark Portal)
					["0.79:0.54:0.65:0.50:0.51:0.73:0.66:0.77"] = 252, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.79:0.54:0.65:0.50:0.68:0.63"] = 125, -- Hellfire Peninsula, Thrallmar, Spinebreaker Ridge
					["0.79:0.54:0.65:0.50"] = 59, -- Hellfire Peninsula, Thrallmar (Edward Barroso reported 81)
					["0.79:0.54:0.54:0.57"] = 122, -- Hellfire Peninsula, Falcon Watch
					["0.79:0.54:0.65:0.50:0.51:0.73"] = 188, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold
					["0.79:0.54:0.54:0.57:0.44:0.67"] = 193, -- Hellfire Peninsula, Falcon Watch, Shattrath
					["0.79:0.54:0.54:0.57:0.44:0.51"] = 190, -- Hellfire Peninsula, Falcon Watch, Swamprat Post
					["0.79:0.54:0.54:0.57:0.29:0.62"] = 253, -- Hellfire Peninsula, Falcon Watch, Garadar
					["0.79:0.54:0.54:0.57:0.23:0.50"] = 271, -- Hellfire Peninsula, Falcon Watch, Zabra'jin
					["0.79:0.54:0.54:0.57:0.44:0.51:0.38:0.32"] = 295, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.79:0.54:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 321, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36"] = 261, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 316, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 381, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.79:0.54:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 364, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.79:0.54:0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 316, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.79:0.54:0.65:0.50:0.51:0.73:0.66:0.77:0.81:0.77"] = 333, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.79:0.54:0.65:0.50:0.51:0.73:0.44:0.67"] = 241, -- Hellfire Peninsula, Thrallmar, Stonebreaker Hold, Shattrath
					["0.79:0.54:0.65:0.50:0.44:0.67"] = 182, -- Hellfire Peninsula, Thrallmar, Shattrath
					["0.79:0.54:0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27"] = 392, -- Hellfire Peninsula, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.79:0.54:0.65:0.50:0.44:0.67:0.23:0.50"] = 316, -- Hellfire Peninsula, Thrallmar, Shattrath, Zabra'jin

					-- Horde: Mok'Nathal Village (Blade's Edge Mountains)
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 292, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 274, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 279, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 208, -- Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.49:0.36:0.44:0.51:0.54:0.57"] = 136, -- Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 228, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.49:0.36:0.44:0.51:0.44:0.67"] = 160, -- Mok'Nathal Village, Swamprat Post, Shattrath
					["0.49:0.36:0.44:0.51"] = 74, -- Mok'Nathal Village, Swamprat Post
					["0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 243, -- Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.49:0.36:0.44:0.51:0.23:0.50"] = 185, -- Mok'Nathal Village, Swamprat Post, Zabra'jin
					["0.49:0.36:0.38:0.32"] = 63, -- Mok'Nathal Village, Thunderlord Stronghold
					["0.49:0.36:0.38:0.32:0.42:0.28"] = 88, -- Mok'Nathal Village, Thunderlord Stronghold, Evergrove (Fabio Finger reported 64)
					["0.49:0.36:0.58:0.27"] = 57, -- Mok'Nathal Village, Area 52
					["0.49:0.36:0.58:0.27:0.72:0.28"] = 122, -- Mok'Nathal Village, Area 52, Cosmowrench
					["0.49:0.36:0.58:0.27:0.63:0.18"] = 104, -- Mok'Nathal Village, Area 52, The Stormspire
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 374, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 357, -- Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.49:0.36:0.38:0.32:0.23:0.50:0.44:0.67"] = 359, -- Mok'Nathal Village, Thunderlord Stronghold, Zabra'jin, Shattrath
					["0.49:0.36:0.38:0.32:0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77"] = 492, -- Mok'Nathal Village, Thunderlord Stronghold, Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village

					-- Horde: Sanctum of the Stars (Shadowmoon Valley)
					["0.78:0.85:0.66:0.77"] = 61, -- Sanctum of the Stars, Shadowmoon Village
					["0.78:0.85:0.51:0.73"] = 134, -- Sanctum of the Stars, Stonebreaker Hold
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 397, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.78:0.85:0.51:0.73:0.44:0.67"] = 187, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath
					["0.78:0.85:0.51:0.73:0.65:0.50:0.68:0.63"] = 322, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.78:0.85:0.51:0.73:0.44:0.67:0.29:0.62"] = 268, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Garadar
					["0.78:0.85:0.51:0.73:0.65:0.50"] = 257, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar
					["0.78:0.85:0.51:0.73:0.44:0.67:0.23:0.50"] = 323, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 439, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 457, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.78:0.85:0.51:0.73:0.65:0.50:0.79:0.54"] = 327, -- Sanctum of the Stars, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51"] = 266, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 392, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.78:0.85:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 371, -- Sanctum of the Stars, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 439, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67"] = 187, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.29:0.62"] = 268, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Garadar
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 397, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Thunderlord Stronghold, Evergrove
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 392, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.78:0.85:0.66:0.77:0.51:0.73"] = 134, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51"] = 266, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 468, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 372, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.54:0.57"] = 263, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Falcon Watch
					["0.78:0.85:0.66:0.77:0.51:0.73:0.65:0.50"] = 257, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Thrallmar
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.23:0.50"] = 323, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.78:0.85:0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 457, -- Sanctum of the Stars, Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench

					-- Horde: Shadowmoon Village (Shadowmoon Valley)
					["0.66:0.77:0.51:0.73"] = 73, -- Shadowmoon Village, Stonebreaker Hold
					["0.66:0.77:0.51:0.73:0.44:0.67"] = 126, -- Shadowmoon Village, Stonebreaker Hold, Shattrath
					["0.66:0.77:0.51:0.73:0.44:0.67:0.29:0.62"] = 207, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Garadar
					["0.66:0.77:0.51:0.73:0.44:0.67:0.23:0.50"] = 262, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Zabra'jin
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51"] = 205, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post
					["0.66:0.77:0.51:0.73:0.44:0.67:0.54:0.57"] = 202, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Falcon Watch
					["0.66:0.77:0.51:0.73:0.65:0.50:0.68:0.63"] = 262, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.66:0.77:0.51:0.73:0.65:0.50:0.79:0.54"] = 267, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.66:0.77:0.51:0.73:0.65:0.50"] = 196, -- Shadowmoon Village, Stonebreaker Hold, Thrallmar
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 276, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 311, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 336, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove (Kristopher Williamson reported 73, not changed)
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 331, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 397, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 379, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.66:0.77:0.78:0.85"] = 66, -- Shadowmoon Village, Sanctum of the Stars
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 407, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.66:0.77:0.81:0.77"] = 85, -- Shadowmoon Village, Altar of Sha'tar
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.72:0.28"] = 473, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.66:0.77:0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 455, -- Shadowmoon Village, Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire

					-- Horde: Shattrath (Terokkar Forest)
					["0.44:0.67:0.23:0.50"] = 136, -- Shattrath, Zabra'jin
					["0.44:0.67:0.29:0.62"] = 81, -- Shattrath, Garadar
					["0.44:0.67:0.44:0.51"] = 79, -- Shattrath, Swamprat Post
					["0.44:0.67:0.54:0.57"] = 77, -- Shattrath, Falcon Watch
					["0.44:0.67:0.51:0.73"] = 69, -- Shattrath, Stonebreaker Hold
					["0.44:0.67:0.51:0.73:0.66:0.77"] = 133, -- Shattrath, Stonebreaker Hold, Shadowmoon Village (anders brøndum bach reported 150)
					["0.44:0.67:0.54:0.57:0.65:0.50:0.68:0.63"] = 215, -- Shattrath, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.44:0.67:0.54:0.57:0.65:0.50:0.79:0.54"] = 220, -- Shattrath, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.44:0.67:0.54:0.57:0.65:0.50"] = 150, -- Shattrath, Falcon Watch, Thrallmar (Mirko Riemann reported 78, not changed yet)
					["0.44:0.67:0.44:0.51:0.49:0.36"] = 150, -- Shattrath, Swamprat Post, Mok'Nathal Village
					["0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 211, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.44:0.67:0.44:0.51:0.38:0.32"] = 185, -- Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 205, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 253, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 270, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 215, -- Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.72:0.28"] = 347, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 198, -- Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 282, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 329, -- Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire
					["0.44:0.67:0.51:0.73:0.65:0.50"] = 193, -- Shattrath, Stonebreaker Hold, Thrallmar
					["0.44:0.67:0.44:0.51:0.38:0.32:0.63:0.18"] = 341, -- Shattrath, Swamprat Post, Thunderlord Stronghold, The Stormspire
					["0.44:0.67:0.51:0.73:0.65:0.50:0.68:0.63"] = 257, -- Shattrath, Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.42:0.28"] = 286, -- Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Evergrove
					["0.44:0.67:0.23:0.50:0.38:0.32:0.58:0.27"] = 344, -- Shattrath, Zabra'jin, Thunderlord Stronghold, Area 52
					["0.44:0.67:0.65:0.50"] = 132, -- Shattrath, Thrallmar
					["0.44:0.67:0.65:0.50:0.79:0.54"] = 202, -- Shattrath, Thrallmar, Hellfire Peninsula
					["0.44:0.67:0.65:0.50:0.68:0.63"] = 197, -- Shattrath, Thrallmar, Spinebreaker Ridge
					["0.44:0.67:0.44:0.51:0.38:0.32:0.63:0.18:0.72:0.28"] = 409, -- Shattrath, Swamprat Post, Thunderlord Stronghold, The Stormspire, Cosmowrench
					["0.44:0.67:0.23:0.50:0.38:0.32:0.42:0.28"] = 272, -- Shattrath, Zabra'jin, Thunderlord Stronghold, Evergrove

					-- Horde: Spinebreaker Ridge (Hellfire Peninsula)
					["0.68:0.63:0.65:0.50:0.54:0.57:0.29:0.62"] = 263, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Garadar
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.67"] = 200, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Shattrath
					["0.68:0.63:0.65:0.50:0.51:0.73"] = 190, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold
					["0.68:0.63:0.65:0.50:0.51:0.73:0.66:0.77"] = 255, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.68:0.63:0.65:0.50:0.79:0.54"] = 133, -- Spinebreaker Ridge, Thrallmar, Hellfire Peninsula
					["0.68:0.63:0.65:0.50"] = 62, -- Spinebreaker Ridge, Thrallmar
					["0.68:0.63:0.65:0.50:0.54:0.57"] = 129, -- Spinebreaker Ridge, Thrallmar, Falcon Watch
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51"] = 198, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post
					["0.68:0.63:0.65:0.50:0.54:0.57:0.23:0.50"] = 280, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Zabra'jin
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32"] = 303, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 330, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36"] = 268, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 327, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 389, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.68:0.63:0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 373, -- Spinebreaker Ridge, Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.68:0.63:0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 319, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.68:0.63:0.65:0.50:0.51:0.73:0.66:0.77:0.81:0.77"] = 335, -- Spinebreaker Ridge, Thrallmar, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.68:0.63:0.65:0.50:0.44:0.67"] = 185, -- Spinebreaker Ridge, Thrallmar, Shattrath

					-- Horde: Stonebreaker Hold (Terokkar Forest)
					["0.51:0.73:0.66:0.77"] = 68, -- Stonebreaker Hold, Shadowmoon Village
					["0.51:0.73:0.65:0.50:0.68:0.63"] = 191, -- Stonebreaker Hold, Thrallmar, Spinebreaker Ridge
					["0.51:0.73:0.65:0.50:0.79:0.54"] = 195, -- Stonebreaker Hold, Thrallmar, Hellfire Peninsula
					["0.51:0.73:0.65:0.50"] = 125, -- Stonebreaker Hold, Thrallmar
					["0.51:0.73:0.44:0.67:0.54:0.57"] = 132, -- Stonebreaker Hold, Shattrath, Falcon Watch
					["0.51:0.73:0.44:0.67"] = 56, -- Stonebreaker Hold, Shattrath
					["0.51:0.73:0.44:0.67:0.29:0.62"] = 137, -- Stonebreaker Hold, Shattrath, Garadar
					["0.51:0.73:0.44:0.67:0.44:0.51"] = 135, -- Stonebreaker Hold, Shattrath, Swamprat Post
					["0.51:0.73:0.44:0.67:0.23:0.50"] = 193, -- Stonebreaker Hold, Shattrath, Zabra'jin
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32"] = 242, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.42:0.28"] = 266, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36"] = 207, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27"] = 261, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 330, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.51:0.73:0.44:0.67:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 313, -- Stonebreaker Hold, Shattrath, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.51:0.73:0.66:0.77:0.78:0.85"] = 133, -- Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.51:0.73:0.66:0.77:0.81:0.77"] = 149, -- Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 385, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27:0.72:0.28"] = 403, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.51:0.73:0.44:0.67:0.44:0.51:0.38:0.32:0.58:0.27"] = 338, -- Stonebreaker Hold, Shattrath, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.51:0.73:0.65:0.50:0.54:0.57"] = 192, -- Stonebreaker Hold, Thrallmar, Falcon Watch
					["0.51:0.73:0.65:0.50:0.54:0.57:0.44:0.51"] = 260, -- Stonebreaker Hold, Thrallmar, Falcon Watch, Swamprat Post
					["0.51:0.73:0.65:0.50:0.54:0.57:0.29:0.62"] = 324, -- Stonebreaker Hold, Thrallmar, Falcon Watch, Garadar

					-- Horde: Swamprat Post (Zangarmarsh)
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 220, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 201, -- Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 206, -- Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.44:0.51:0.54:0.57:0.65:0.50"] = 136, -- Swamprat Post, Falcon Watch, Thrallmar
					["0.44:0.51:0.54:0.57"] = 61, -- Swamprat Post, Falcon Watch
					["0.44:0.51:0.44:0.67:0.51:0.73"] = 155, -- Swamprat Post, Shattrath, Stonebreaker Hold
					["0.44:0.51:0.44:0.67"] = 86, -- Swamprat Post, Shattrath
					["0.44:0.51:0.44:0.67:0.29:0.62"] = 168, -- Swamprat Post, Shattrath, Garadar
					["0.44:0.51:0.23:0.50"] = 111, -- Swamprat Post, Zabra'jin
					["0.44:0.51:0.38:0.32"] = 106, -- Swamprat Post, Thunderlord Stronghold
					["0.44:0.51:0.38:0.32:0.42:0.28"] = 132, -- Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.44:0.51:0.49:0.36"] = 71, -- Swamprat Post, Mok'Nathal Village
					["0.44:0.51:0.49:0.36:0.58:0.27"] = 126, -- Swamprat Post, Mok'Nathal Village, Area 52
					["0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 193, -- Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 174, -- Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 284, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 301, -- Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.44:0.51:0.38:0.32:0.58:0.27"] = 202, -- Swamprat Post, Thunderlord Stronghold, Area 52
					["0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 250, -- Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire
					["0.44:0.51:0.54:0.57:0.65:0.50:0.51:0.73"] = 264, -- Swamprat Post, Falcon Watch, Thrallmar, Stonebreaker Hold
					["0.44:0.51:0.44:0.67:0.65:0.50"] = 215, -- Swamprat Post, Shattrath, Thrallmar

					-- Horde: The Stormspire (Netherstorm)
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 410, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 390, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 395, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57:0.65:0.50"] = 326, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch, Thrallmar
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.54:0.57"] = 254, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Falcon Watch
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73"] = 345, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67"] = 277, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51"] = 191, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.29:0.62"] = 359, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Garadar
					["0.63:0.18:0.38:0.32:0.23:0.50"] = 294, -- The Stormspire, Thunderlord Stronghold, Zabra'jin
					["0.63:0.18:0.58:0.27:0.49:0.36"] = 118, -- The Stormspire, Area 52, Mok'Nathal Village
					["0.63:0.18:0.38:0.32"] = 147, -- The Stormspire, Thunderlord Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.28"] = 132, -- The Stormspire, Area 52, Evergrove
					["0.63:0.18:0.58:0.27"] = 53, -- The Stormspire, Area 52
					["0.63:0.18:0.72:0.28"] = 69, -- The Stormspire, Cosmowrench
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 474, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.63:0.18:0.38:0.32:0.44:0.51:0.44:0.67"] = 348, -- The Stormspire, Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.63:0.18:0.58:0.27:0.49:0.36:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 490, -- The Stormspire, Area 52, Mok'Nathal Village, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.63:0.18:0.38:0.32:0.23:0.50:0.29:0.62"] = 372, -- The Stormspire, Thunderlord Stronghold, Zabra'jin, Garadar
					["0.63:0.18:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 481, -- The Stormspire, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.63:0.18:0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 397, -- The Stormspire, Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.63:0.18:0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 417, -- The Stormspire, Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.63:0.18:0.38:0.32:0.44:0.51"] = 262, -- The Stormspire, Thunderlord Stronghold, Swamprat Post
					["0.63:0.18:0.38:0.32:0.23:0.50:0.44:0.67"] = 443, -- The Stormspire, Thunderlord Stronghold, Zabra'jin, Shattrath

					-- Horde: Thrallmar (Hellfire Peninsula)
					["0.65:0.50:0.51:0.73:0.66:0.77"] = 192, -- Thrallmar, Stonebreaker Hold, Shadowmoon Village
					["0.65:0.50:0.68:0.63"] = 66, -- Thrallmar, Spinebreaker Ridge
					["0.65:0.50:0.79:0.54"] = 70, -- Thrallmar, Hellfire Peninsula
					["0.65:0.50:0.54:0.57"] = 66, -- Thrallmar, Falcon Watch
					["0.65:0.50:0.51:0.73"] = 129, -- Thrallmar, Stonebreaker Hold
					["0.65:0.50:0.54:0.57:0.44:0.67"] = 138, -- Thrallmar, Falcon Watch, Shattrath (Taylor Morris reported 67)
					["0.65:0.50:0.54:0.57:0.44:0.51"] = 135, -- Thrallmar, Falcon Watch, Swamprat Post
					["0.65:0.50:0.54:0.57:0.29:0.62"] = 199, -- Thrallmar, Falcon Watch, Garadar
					["0.65:0.50:0.54:0.57:0.23:0.50"] = 217, -- Thrallmar, Falcon Watch, Zabra'jin
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32"] = 242, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.42:0.28"] = 267, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Evergrove
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36"] = 206, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27"] = 262, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.63:0.18"] = 309, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, The Stormspire
					["0.65:0.50:0.54:0.57:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 327, -- Thrallmar, Falcon Watch, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.65:0.50:0.51:0.73:0.66:0.77:0.78:0.85"] = 257, -- Thrallmar, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27"] = 338, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52
					["0.65:0.50:0.51:0.73:0.66:0.77:0.81:0.77"] = 273, -- Thrallmar, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27:0.63:0.18"] = 385, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52, The Stormspire
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.58:0.27:0.72:0.28"] = 403, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.65:0.50:0.51:0.73:0.44:0.67"] = 182, -- Thrallmar, Stonebreaker Hold, Shattrath
					["0.65:0.50:0.54:0.57:0.44:0.51:0.38:0.32:0.63:0.18:0.72:0.28"] = 465, -- Thrallmar, Falcon Watch, Swamprat Post, Thunderlord Stronghold, The Stormspire, Cosmowrench
					["0.65:0.50:0.44:0.67"] = 123, -- Thrallmar, Shattrath
					["0.65:0.50:0.44:0.67:0.23:0.50"] = 257, -- Thrallmar, Shattrath, Zabra'jin
					["0.65:0.50:0.54:0.57:0.23:0.50:0.38:0.32"] = 328, -- Thrallmar, Falcon Watch, Zabra'jin, Thunderlord Stronghold
					["0.65:0.50:0.54:0.57:0.23:0.50:0.38:0.32:0.58:0.27"] = 424, -- Thrallmar, Falcon Watch, Zabra'jin, Thunderlord Stronghold, Area 52

					-- Horde: Thunderlord Stronghold (Blade's Edge Mountains)
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77"] = 335, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.68:0.63"] = 316, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50:0.79:0.54"] = 322, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.38:0.32:0.44:0.51:0.54:0.57:0.65:0.50"] = 251, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch, Thrallmar
					["0.38:0.32:0.44:0.51:0.54:0.57"] = 179, -- Thunderlord Stronghold, Swamprat Post, Falcon Watch
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73"] = 271, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold
					["0.38:0.32:0.44:0.51:0.44:0.67"] = 202, -- Thunderlord Stronghold, Swamprat Post, Shattrath
					["0.38:0.32:0.44:0.51"] = 116, -- Thunderlord Stronghold, Swamprat Post
					["0.38:0.32:0.23:0.50:0.29:0.62"] = 227, -- Thunderlord Stronghold, Zabra'jin, Garadar
					["0.38:0.32:0.23:0.50"] = 149, -- Thunderlord Stronghold, Zabra'jin
					["0.38:0.32:0.49:0.36"] = 55, -- Thunderlord Stronghold, Mok'Nathal Village
					["0.38:0.32:0.42:0.28"] = 26, -- Thunderlord Stronghold, Evergrove
					["0.38:0.32:0.58:0.27"] = 97, -- Thunderlord Stronghold, Area 52
					["0.38:0.32:0.58:0.27:0.72:0.28"] = 163, -- Thunderlord Stronghold, Area 52, Cosmowrench
					["0.38:0.32:0.63:0.18"] = 158, -- Thunderlord Stronghold, The Stormspire
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 416, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.38:0.32:0.44:0.51:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 400, -- Thunderlord Stronghold, Swamprat Post, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.38:0.32:0.23:0.50:0.44:0.67"] = 297, -- Thunderlord Stronghold, Zabra'jin, Shattrath

					-- Horde: Zabra'jin (Zangarmarsh)
					["0.23:0.50:0.29:0.62"] = 81, -- Zabra'jin, Garadar
					["0.23:0.50:0.44:0.67"] = 151, -- Zabra'jin, Shattrath
					["0.23:0.50:0.44:0.67:0.51:0.73"] = 220, -- Zabra'jin, Shattrath, Stonebreaker Hold
					["0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77"] = 284, -- Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village
					["0.23:0.50:0.54:0.57:0.65:0.50:0.68:0.63"] = 287, -- Zabra'jin, Falcon Watch, Thrallmar, Spinebreaker Ridge
					["0.23:0.50:0.54:0.57:0.65:0.50:0.79:0.54"] = 290, -- Zabra'jin, Falcon Watch, Thrallmar, Hellfire Peninsula
					["0.23:0.50:0.54:0.57:0.65:0.50"] = 220, -- Zabra'jin, Falcon Watch, Thrallmar
					["0.23:0.50:0.54:0.57"] = 147, -- Zabra'jin, Falcon Watch
					["0.23:0.50:0.44:0.51"] = 112, -- Zabra'jin, Swamprat Post
					["0.23:0.50:0.38:0.32"] = 113, -- Zabra'jin, Thunderlord Stronghold
					["0.23:0.50:0.38:0.32:0.42:0.28"] = 139, -- Zabra'jin, Thunderlord Stronghold, Evergrove
					["0.23:0.50:0.38:0.32:0.49:0.36"] = 168, -- Zabra'jin, Thunderlord Stronghold, Mok'Nathal Village
					["0.23:0.50:0.38:0.32:0.58:0.27"] = 209, -- Zabra'jin, Thunderlord Stronghold, Area 52
					["0.23:0.50:0.38:0.32:0.58:0.27:0.63:0.18"] = 257, -- Zabra'jin, Thunderlord Stronghold, Area 52, The Stormspire
					["0.23:0.50:0.38:0.32:0.58:0.27:0.72:0.28"] = 275, -- Zabra'jin, Thunderlord Stronghold, Area 52, Cosmowrench
					["0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77:0.78:0.85"] = 349, -- Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village, Sanctum of the Stars
					["0.23:0.50:0.44:0.51:0.49:0.36:0.58:0.27:0.72:0.28"] = 304, -- Zabra'jin, Swamprat Post, Mok'Nathal Village, Area 52, Cosmowrench
					["0.23:0.50:0.44:0.67:0.51:0.73:0.66:0.77:0.81:0.77"] = 365, -- Zabra'jin, Shattrath, Stonebreaker Hold, Shadowmoon Village, Altar of Sha'tar
					["0.23:0.50:0.44:0.67:0.51:0.73:0.65:0.50"] = 343, -- Zabra'jin, Shattrath, Stonebreaker Hold, Thrallmar

				},

				-- Horde: Northrend
				[113] = {

					----------------------------------------------------------------------
					-- Horde: Borean Tundra
					----------------------------------------------------------------------

					-- Horde: Borean Tundra: Amber Ledge
					["0.17:0.53:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38"] = 187, -- Amber Ledge, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.17:0.53:0.15:0.57"] = 28, -- Amber Ledge, Warsong Hold
					["0.17:0.53:0.18:0.47"] = 23, -- Amber Ledge, Bor'gorok Outpost
					["0.17:0.53:0.18:0.47:0.24:0.40"] = 61, -- Amber Ledge, Bor'gorok Outpost, River's Heart
					["0.17:0.53:0.12:0.53"] = 25, -- Amber Ledge, Transitus Shield
					["0.17:0.53:0.29:0.54:0.29:0.57"] = 68, -- Amber Ledge, Taunka'le Village, Unu'pe
					["0.17:0.53:0.29:0.54:0.45:0.51:0.59:0.55:0.85:0.73"] = 289, -- Amber Ledge, Taunka'le Village, Agmar's Hammer, Venomspite, New Agamand
					["0.17:0.53:0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 309, -- Amber Ledge, Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing

					-- Horde: Borean Tundra: Bor'gorok Outpost
					["0.18:0.47:0.29:0.54"] = 78, -- Bor'gorok Outpost, Taunka'le Village
					["0.18:0.47:0.24:0.40:0.28:0.28"] = 143, -- Bor'gorok Outpost, River's Heart, Death's Rise
					["0.18:0.47:0.24:0.40:0.52:0.38"] = 251, -- Bor'gorok Outpost, River's Heart, Dalaran
					["0.18:0.47:0.24:0.40"] = 58, -- Bor'gorok Outpost, River's Heart
					["0.18:0.47:0.17:0.53"] = 57, -- Bor'gorok Outpost, Amber Ledge
					["0.18:0.47:0.17:0.53:0.12:0.53"] = 92, -- Bor'gorok Outpost, Amber Ledge, Transitus Shield
					["0.18:0.47:0.24:0.40:0.52:0.38:0.56:0.36"] = 273, -- Bor'gorok Outpost, River's Heart, Dalaran, The Argent Vanguard
					["0.18:0.47:0.15:0.57"] = 72, -- Bor'gorok Outpost, Warsong Hold
					["0.18:0.47:0.29:0.54:0.45:0.51:0.59:0.55:0.85:0.73"] = 439, -- Bor'gorok Outpost, Taunka'le Village, Agmar's Hammer, Venomspite, New Agamand
					["0.18:0.47:0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 469, -- Bor'gorok Outpost, Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing

					-- Horde: Borean Tundra: Taunka'le Village
					["0.29:0.54:0.29:0.57"] = 30, -- Taunka'le Village, Unu'pe
					["0.29:0.54:0.31:0.43"] = 72, -- Taunka'le Village, Warsong Camp
					["0.29:0.54:0.18:0.47:0.24:0.40"] = 129, -- Taunka'le Village, Bor'gorok Outpost, River's Heart
					["0.29:0.54:0.45:0.51:0.59:0.55:0.85:0.73"] = 362, -- Taunka'le Village, Agmar's Hammer, Venomspite, New Agamand
					["0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38"] = 208, -- Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.29:0.54:0.17:0.53"] = 76, -- Taunka'le Village, Amber Ledge
					["0.29:0.54:0.18:0.47"] = 73, -- Taunka'le Village, Bor'gorok Outpost
					["0.29:0.54:0.15:0.57"] = 85, -- Taunka'le Village, Warsong Hold
					["0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38:0.60:0.40"] = 255, -- Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran, Sunreaver's Command
					["0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 392, -- Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing
					["0.29:0.54:0.45:0.51:0.59:0.55:0.74:0.62:0.74:0.71"] = 328, -- Taunka'le Village, Agmar's Hammer, Venomspite, Apothecary Camp, Kamagua
					["0.29:0.54:0.45:0.51:0.59:0.55:0.74:0.62"] = 274, -- Taunka'le Village, Agmar's Hammer, Venomspite, Apothecary Camp
					["0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59"] = 319, -- Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof
					["0.29:0.54:0.45:0.51:0.54:0.52:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 399, -- Taunka'le Village, Agmar's Hammer, Wyrmrest Temple, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.51"] = 335, -- Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Oneqwah

					-- Horde: Borean Tundra: Transitus Shield (Coldarra)
					["0.12:0.53:0.17:0.53:0.15:0.57"] = 58, -- Transitus Shield, Amber Ledge, Warsong Hold
					["0.12:0.53:0.17:0.53:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38"] = 216, -- Transitus Shield, Amber Ledge, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.12:0.53:0.17:0.53"] = 31, -- Transitus Shield, Amber Ledge
					["0.12:0.53:0.17:0.53:0.18:0.47:0.24:0.40"] = 90, -- Transitus Shield, Amber Ledge, Bor'gorok Outpost, River's Heart
					["0.12:0.53:0.17:0.53:0.18:0.47"] = 52, -- Transitus Shield, Amber Ledge, Bor'gorok Outpost
					["0.12:0.53:0.17:0.53:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38:0.62:0.36:0.73:0.25"] = 306, -- Transitus Shield, Amber Ledge, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran, K3, Camp Tunka'lo
					["0.12:0.53:0.17:0.53:0.29:0.54:0.29:0.57"] = 97, -- Transitus Shield, Amber Ledge, Taunka'le Village, Unu'pe
					["0.12:0.53:0.17:0.53:0.29:0.54:0.45:0.51:0.59:0.55:0.85:0.73"] = 318, -- Transitus Shield, Amber Ledge, Taunka'le Village, Agmar's Hammer, Venomspite, New Agamand
					["0.12:0.53:0.17:0.53:0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.51"] = 300, -- Transitus Shield, Amber Ledge, Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Oneqwah
					["0.12:0.53:0.17:0.53:0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 338, -- Transitus Shield, Amber Ledge, Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing

					-- Horde: Borean Tundra: Unu'pe
					["0.29:0.57:0.29:0.54"] = 22, -- Unu'pe, Taunka'le Village
					["0.29:0.57:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38"] = 230, -- Unu'pe, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.29:0.57:0.29:0.54:0.17:0.53:0.12:0.53"] = 133, -- Unu'pe, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.29:0.57:0.15:0.57"] = 88, -- Unu'pe, Warsong Hold
					["0.29:0.57:0.49:0.58"] = 119, -- Unu'pe, Moa'ki
					["0.29:0.57:0.29:0.54:0.45:0.51"] = 113, -- Unu'pe, Taunka'le Village, Agmar's Hammer
					["0.29:0.57:0.49:0.58:0.59:0.55:0.70:0.55"] = 238, -- Unu'pe, Moa'ki, Venomspite, Conquest Hold
					["0.29:0.57:0.49:0.58:0.74:0.71:0.85:0.73"] = 364, -- Unu'pe, Moa'ki, Kamagua, New Agamand
					["0.29:0.57:0.49:0.58:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 395, -- Unu'pe, Moa'ki, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing
					["0.29:0.57:0.49:0.58:0.74:0.71"] = 302, -- Unu'pe, Moa'ki, Kamagua
					["0.29:0.57:0.49:0.58:0.59:0.55:0.74:0.62"] = 277, -- Unu'pe, Moa'ki, Venomspite, Apothecary Camp
					["0.29:0.57:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38:0.62:0.36"] = 275, -- Unu'pe, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran, K3
					["0.29:0.57:0.49:0.58:0.59:0.55:0.69:0.42"] = 285, -- Unu'pe, Moa'ki, Venomspite, Light's Breach
					["0.29:0.57:0.49:0.58:0.59:0.55:0.70:0.55:0.84:0.59"] = 322, -- Unu'pe, Moa'ki, Venomspite, Conquest Hold, Camp Winterhoof
					["0.29:0.57:0.49:0.58:0.59:0.55:0.70:0.55:0.84:0.51"] = 339, -- Unu'pe, Moa'ki, Venomspite, Conquest Hold, Camp Oneqwah
					["0.29:0.57:0.49:0.58:0.59:0.55:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 419, -- Unu'pe, Moa'ki, Venomspite, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak

					-- Horde: Borean Tundra: Warsong Hold
					["0.15:0.57:0.29:0.57:0.49:0.58:0.74:0.71"] = 394, -- Warsong Hold, Unu'pe, Moa'ki, Kamagua
					["0.15:0.57:0.17:0.53:0.12:0.53"] = 72, -- Warsong Hold, Amber Ledge, Transitus Shield
					["0.15:0.57:0.18:0.47"] = 69, -- Warsong Hold, Bor'gorok Outpost
					["0.15:0.57:0.29:0.54:0.45:0.51:0.48:0.44:0.52:0.38"] = 294, -- Warsong Hold, Taunka'le Village, Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.15:0.57:0.17:0.53"] = 36, -- Warsong Hold, Amber Ledge
					["0.15:0.57:0.17:0.53:0.18:0.47:0.24:0.40"] = 125, -- Warsong Hold, Amber Ledge, Bor'gorok Outpost, River's Heart
					["0.15:0.57:0.29:0.54"] = 87, -- Warsong Hold, Taunka'le Village
					["0.15:0.57:0.29:0.57"] = 93, -- Warsong Hold, Unu'pe
					["0.15:0.57:0.29:0.54:0.31:0.43"] = 157, -- Warsong Hold, Taunka'le Village, Warsong Camp
					["0.15:0.57:0.29:0.54:0.45:0.51:0.59:0.55:0.85:0.73"] = 448, -- Warsong Hold, Taunka'le Village, Agmar's Hammer, Venomspite, New Agamand
					["0.15:0.57:0.29:0.54:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 478, -- Warsong Hold, Taunka'le Village, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing

					----------------------------------------------------------------------
					-- Horde: Crystalsong Forest
					----------------------------------------------------------------------

					-- Horde: Crystalsong Forest: Sunreaver's Command
					["0.60:0.40:0.52:0.38"] = 56, -- Sunreaver's Command, Dalaran
					["0.60:0.40:0.64:0.42"] = 38, -- Sunreaver's Command, Ebon Watch
					["0.60:0.40:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62"] = 213, -- Sunreaver's Command, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp
					["0.60:0.40:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62:0.85:0.73"] = 305, -- Sunreaver's Command, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp, New Agamand
					["0.60:0.40:0.52:0.38:0.48:0.44"] = 116, -- Sunreaver's Command, Dalaran, Kor'koron Vanguard
					["0.60:0.40:0.52:0.38:0.31:0.43"] = 205, -- Sunreaver's Command, Dalaran, Warsong Camp

					----------------------------------------------------------------------
					-- Horde: Dalaran
					----------------------------------------------------------------------

					-- Horde: Dalaran
					["0.52:0.38:0.56:0.36"] = 33, -- Dalaran, The Argent Vanguard
					["0.52:0.38:0.62:0.36"] = 55, -- Dalaran, K3
					["0.52:0.38:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62:0.85:0.73"] = 348, -- Dalaran, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp, New Agamand
					["0.52:0.38:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62:0.74:0.71"] = 310, -- Dalaran, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp, Kamagua
					["0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38"] = 186, -- Dalaran, Ebon Watch, The Argent Stand, Zim'Torga
					["0.52:0.38:0.48:0.44"] = 73, -- Dalaran, Kor'koron Vanguard
					["0.52:0.38:0.52:0.34"] = 40, -- Dalaran, Crusaders' Pinnacle
					["0.52:0.38:0.60:0.40"] = 57, -- Dalaran, Sunreaver's Command
					["0.52:0.38:0.64:0.42"] = 81, -- Dalaran, Ebon Watch
					["0.52:0.38:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62"] = 257, -- Dalaran, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp
					["0.52:0.38:0.64:0.42:0.69:0.42:0.84:0.51:0.84:0.59"] = 279, -- Dalaran, Ebon Watch, Light's Breach, Camp Oneqwah, Camp Winterhoof
					["0.52:0.38:0.49:0.58"] = 160, -- Dalaran, Moa'ki
					["0.52:0.38:0.64:0.42:0.69:0.42:0.84:0.51:0.95:0.63"] = 336, -- Dalaran, Ebon Watch, Light's Breach, Camp Oneqwah, Vengeance Landing
					["0.52:0.38:0.48:0.44:0.45:0.51"] = 125, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer
					["0.52:0.38:0.64:0.42:0.69:0.42:0.70:0.55"] = 200, -- Dalaran, Ebon Watch, Light's Breach, Conquest Hold
					["0.52:0.38:0.48:0.44:0.45:0.51:0.29:0.54:0.29:0.57"] = 266, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village, Unu'pe
					["0.52:0.38:0.54:0.52"] = 122, -- Dalaran, Wyrmrest Temple
					["0.52:0.38:0.48:0.44:0.59:0.55"] = 163, -- Dalaran, Kor'koron Vanguard, Venomspite
					["0.52:0.38:0.48:0.44:0.45:0.51:0.29:0.54"] = 236, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village
					["0.52:0.38:0.64:0.42:0.69:0.42:0.84:0.51"] = 231, -- Dalaran, Ebon Watch, Light's Breach, Camp Oneqwah
					["0.52:0.38:0.48:0.44:0.45:0.51:0.29:0.54:0.17:0.53"] = 311, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village, Amber Ledge
					["0.52:0.38:0.64:0.42:0.72:0.40"] = 145, -- Dalaran, Ebon Watch, The Argent Stand
					["0.52:0.38:0.48:0.44:0.45:0.51:0.29:0.54:0.15:0.57"] = 320, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village, Warsong Hold
					["0.52:0.38:0.48:0.44:0.45:0.51:0.29:0.54:0.17:0.53:0.12:0.53"] = 347, -- Dalaran, Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.52:0.38:0.24:0.40:0.18:0.47"] = 265, -- Dalaran, River's Heart, Bor'gorok Outpost
					["0.52:0.38:0.24:0.40"] = 212, -- Dalaran, River's Heart
					["0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 239, -- Dalaran, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.52:0.38:0.64:0.42:0.69:0.42"] = 126, -- Dalaran, Ebon Watch, Light's Breach
					["0.52:0.38:0.62:0.36:0.73:0.25"] = 145, -- Dalaran, K3, Camp Tunka'lo
					["0.52:0.38:0.62:0.36:0.60:0.25"] = 130, -- Dalaran, K3, Grom'arsh Crash-Site, Grom'arsh Crash-Site
					["0.52:0.38:0.31:0.43"] = 161, -- Dalaran, Warsong Camp
					["0.52:0.38:0.52:0.34:0.28:0.28"] = 207, -- Dalaran, Crusaders' Pinnacle, Death's Rise

					----------------------------------------------------------------------
					-- Horde: Dragonblight
					----------------------------------------------------------------------

					-- Horde: Dragonblight: Agmar's Hammer
					["0.45:0.51:0.48:0.44:0.52:0.38"] = 121, -- Agmar's Hammer, Kor'koron Vanguard, Dalaran
					["0.45:0.51:0.49:0.58"] = 64, -- Agmar's Hammer, Moa'ki
					["0.45:0.51:0.48:0.44"] = 65, -- Agmar's Hammer, Kor'koron Vanguard
					["0.45:0.51:0.54:0.52"] = 52, -- Agmar's Hammer, Wyrmrest Temple
					["0.45:0.51:0.59:0.55"] = 88, -- Agmar's Hammer, Venomspite
					["0.45:0.51:0.59:0.55:0.85:0.73"] = 273, -- Agmar's Hammer, Venomspite, New Agamand

					-- Horde: Dragonblight: Kor'koron Vanguard
					["0.48:0.44:0.52:0.38"] = 56, -- Kor'koron Vanguard, Dalaran
					["0.48:0.44:0.52:0.38:0.60:0.40"] = 103, -- Kor'koron Vanguard, Dalaran, Sunreaver's Command
					["0.48:0.44:0.45:0.51:0.29:0.54"] = 164, -- Kor'koron Vanguard, Agmar's Hammer, Taunka'le Village
					["0.48:0.44:0.54:0.52"] = 67, -- Kor'koron Vanguard, Wyrmrest Temple
					["0.48:0.44:0.45:0.51"] = 53, -- Kor'koron Vanguard, Agmar's Hammer
					["0.48:0.44:0.45:0.51:0.49:0.58"] = 114, -- Kor'koron Vanguard, Agmar's Hammer, Moa'ki
					["0.48:0.44:0.59:0.55"] = 90, -- Kor'koron Vanguard, Venomspite
					["0.48:0.44:0.52:0.38:0.56:0.36"] = 79, -- Kor'koron Vanguard, Dalaran, The Argent Vanguard
					["0.48:0.44:0.64:0.42:0.72:0.40"] = 171, -- Kor'koron Vanguard, Ebon Watch, The Argent Stand

					-- Horde: Dragonblight: Moa'ki
					["0.49:0.58:0.45:0.51:0.31:0.43:0.24:0.40"] = 255, -- Moa'ki, Agmar's Hammer, Warsong Camp, River's Heart
					["0.49:0.58:0.52:0.38"] = 123, -- Moa'ki, Dalaran
					["0.49:0.58:0.45:0.51"] = 65, -- Moa'ki, Agmar's Hammer
					["0.49:0.58:0.54:0.52"] = 49, -- Moa'ki, Wyrmrest Temple
					["0.49:0.58:0.59:0.55"] = 62, -- Moa'ki, Venomspite
					["0.49:0.58:0.29:0.57"] = 133, -- Moa'ki, Unu'pe
					["0.49:0.58:0.59:0.55:0.70:0.55:0.84:0.51"] = 222, -- Moa'ki, Venomspite, Conquest Hold, Camp Oneqwah
					["0.49:0.58:0.52:0.38:0.62:0.36:0.60:0.25:0.64:0.19"] = 293, -- Moa'ki, Dalaran, K3, Grom'arsh Crash-Site, Ulduar
					["0.49:0.58:0.29:0.57:0.29:0.54"] = 154, -- Moa'ki, Unu'pe, Taunka'le Village

					-- Horde: Dragonblight: Venomspite
					["0.59:0.55:0.54:0.52:0.52:0.38"] = 149, -- Venomspite, Wyrmrest Temple, Dalaran
					["0.59:0.55:0.54:0.52"] = 52, -- Venomspite, Wyrmrest Temple
					["0.59:0.55:0.49:0.58"] = 83, -- Venomspite, Moa'ki
					["0.59:0.55:0.45:0.51"] = 133, -- Venomspite, Agmar's Hammer
					["0.59:0.55:0.48:0.44"] = 121, -- Venomspite, Kor'koron Vanguard
					["0.59:0.55:0.70:0.55"] = 60, -- Venomspite, Conquest Hold
					["0.59:0.55:0.74:0.62"] = 99, -- Venomspite, Apothecary Camp

					-- Horde: Dragonblight: Wyrmrest Temple
					["0.54:0.52:0.52:0.38"] = 65, -- Wyrmrest Temple, Dalaran
					["0.54:0.52:0.45:0.51"] = 47, -- Wyrmrest Temple, Agmar's Hammer
					["0.54:0.52:0.49:0.58"] = 36, -- Wyrmrest Temple, Moa'ki
					["0.54:0.52:0.59:0.55"] = 35, -- Wyrmrest Temple, Venomspite
					["0.54:0.52:0.48:0.44"] = 45, -- Wyrmrest Temple, Kor'koron Vanguard
					["0.54:0.52:0.64:0.42:0.60:0.40"] = 89, -- Wyrmrest Temple, Ebon Watch, Sunreaver's Command
					["0.54:0.52:0.52:0.38:0.56:0.36"] = 79, -- Wyrmrest Temple, Dalaran, The Argent Vanguard
					["0.54:0.52:0.45:0.51:0.29:0.54"] = 120, -- Wyrmrest Temple, Agmar's Hammer, Taunka'le Village
					["0.54:0.52:0.59:0.55:0.85:0.73"] = 158, -- Wyrmrest Temple, Venomspite, New Agamand

					----------------------------------------------------------------------
					-- Horde: Grizzly Hills
					----------------------------------------------------------------------

					-- Horde: Grizzly Hills: Camp Oneqwah
					["0.84:0.51:0.70:0.55:0.59:0.55:0.49:0.58:0.29:0.57:0.15:0.57"] = 483, -- Camp Oneqwah, Conquest Hold, Venomspite, Moa'ki, Unu'pe, Warsong Hold
					["0.84:0.51:0.78:0.38:0.82:0.31"] = 147, -- Camp Oneqwah, Zim'Torga, Gundrak
					["0.84:0.51:0.70:0.55"] = 96, -- Camp Oneqwah, Conquest Hold
					["0.84:0.51:0.70:0.55:0.59:0.55"] = 183, -- Camp Oneqwah, Conquest Hold, Venomspite
					["0.84:0.51:0.69:0.42:0.64:0.42:0.54:0.52:0.45:0.51:0.29:0.54:0.17:0.53:0.12:0.53"] = 512, -- Camp Oneqwah, Light's Breach, Ebon Watch, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38:0.31:0.43"] = 346, -- Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran, Warsong Camp
					["0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38:0.24:0.40"] = 397, -- Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran, River's Heart
					["0.84:0.51:0.69:0.42:0.64:0.42:0.54:0.52:0.45:0.51"] = 291, -- Camp Oneqwah, Light's Breach, Ebon Watch, Wyrmrest Temple, Agmar's Hammer
					["0.84:0.51:0.70:0.55:0.59:0.55:0.49:0.58:0.29:0.57"] = 395, -- Camp Oneqwah, Conquest Hold, Venomspite, Moa'ki, Unu'pe

					-- Horde: Grizzly Hills: Conquest Hold
					["0.70:0.55:0.74:0.62"] = 57, -- Conquest Hold, Apothecary Camp
					["0.70:0.55:0.69:0.42:0.64:0.42:0.52:0.38"] = 186, -- Conquest Hold, Light's Breach, Ebon Watch, Dalaran
					["0.70:0.55:0.84:0.59"] = 85, -- Conquest Hold, Camp Winterhoof
					["0.70:0.55:0.84:0.51"] = 102, -- Conquest Hold, Camp Oneqwah
					["0.70:0.55:0.74:0.62:0.85:0.73"] = 149, -- Conquest Hold, Apothecary Camp, New Agamand
					["0.70:0.55:0.69:0.42:0.72:0.40:0.78:0.38"] = 164, -- Conquest Hold, Light's Breach, The Argent Stand, Zim'Torga
					["0.70:0.55:0.59:0.55:0.54:0.52"] = 139, -- Conquest Hold, Venomspite, Wyrmrest Temple

					----------------------------------------------------------------------
					-- Horde: Howling Fjord
					----------------------------------------------------------------------

					-- Horde: Howling Fjord: Apothecary Camp
					["0.74:0.62:0.74:0.71"] = 54, -- Apothecary Camp, Kamagua
					["0.74:0.62:0.84:0.59"] = 60, -- Apothecary Camp, Camp Winterhoof
					["0.74:0.62:0.85:0.73"] = 93, -- Apothecary Camp, New Agamand
					["0.74:0.62:0.70:0.55:0.69:0.42:0.64:0.42:0.52:0.38"] = 232, -- Apothecary Camp, Conquest Hold, Light's Breach, Ebon Watch, Dalaran
					["0.74:0.62:0.84:0.59:0.95:0.63"] = 133, -- Apothecary Camp, Camp Winterhoof, Vengeance Landing
					["0.74:0.62:0.84:0.59:0.84:0.51"] = 118, -- Apothecary Camp, Camp Winterhoof, Camp Oneqwah
					["0.74:0.62:0.70:0.55"] = 48, -- Apothecary Camp, Conquest Hold
					["0.74:0.62:0.59:0.55"] = 118, -- Apothecary Camp, Venomspite
					["0.74:0.62:0.59:0.55:0.54:0.52"] = 169, -- Apothecary Camp, Venomspite, Wyrmrest Temple
					["0.74:0.62:0.59:0.55:0.49:0.58"] = 200, -- Apothecary Camp, Venomspite, Moa'ki
					["0.74:0.62:0.59:0.55:0.49:0.58:0.29:0.57"] = 331, -- Apothecary Camp, Venomspite, Moa'ki, Unu'pe
					["0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.29:0.54"] = 349, -- Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village

					-- Horde: Howling Fjord: Camp Oneqwah
					["0.84:0.51:0.84:0.59"] = 49, -- Camp Oneqwah, Camp Winterhoof
					["0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38"] = 199, -- Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran
					["0.84:0.51:0.84:0.59:0.74:0.62"] = 106, -- Camp Oneqwah, Camp Winterhoof, Apothecary Camp
					["0.84:0.51:0.95:0.63"] = 106, -- Camp Oneqwah, Vengeance Landing

					-- Horde: Howling Fjord: Camp Winterhoof
					["0.84:0.59:0.85:0.73"] = 80, -- Camp Winterhoof, New Agamand
					["0.84:0.59:0.95:0.63"] = 75, -- Camp Winterhoof, Vengeance Landing
					["0.84:0.59:0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38"] = 257, -- Camp Winterhoof, Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran
					["0.84:0.59:0.84:0.51"] = 58, -- Camp Winterhoof, Camp Oneqwah
					["0.84:0.59:0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38:0.56:0.36"] = 277, -- Camp Winterhoof, Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran, The Argent Vanguard
					["0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.48:0.44"] = 291, -- Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Kor'koron Vanguard
					["0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.31:0.43"] = 409, -- Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Warsong Camp
					["0.84:0.59:0.74:0.62"] = 57, -- Camp Winterhoof, Apothecary Camp
					["0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52"] = 226, -- Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple
					["0.84:0.59:0.74:0.62:0.59:0.55:0.49:0.58:0.29:0.57"] = 387, -- Camp Winterhoof, Apothecary Camp, Venomspite, Moa'ki, Unu'pe

					-- Horde: Howling Fjord: Kamagua
					["0.74:0.71:0.85:0.73"] = 64, -- Kamagua, New Agamand
					["0.74:0.71:0.74:0.62:0.70:0.55:0.69:0.42:0.64:0.42:0.52:0.38"] = 288, -- Kamagua, Apothecary Camp, Conquest Hold, Light's Breach, Ebon Watch, Dalaran
					["0.74:0.71:0.74:0.62:0.84:0.59:0.84:0.51:0.78:0.38"] = 265, -- Kamagua, Apothecary Camp, Camp Winterhoof, Camp Oneqwah, Zim'Torga
					["0.74:0.71:0.74:0.62"] = 56, -- Kamagua, Apothecary Camp
					["0.74:0.71:0.85:0.73:0.95:0.63"] = 143, -- Kamagua, New Agamand, Vengeance Landing
					["0.74:0.71:0.49:0.58:0.29:0.57"] = 326, -- Kamagua, Moa'ki, Unu'pe
					["0.74:0.71:0.74:0.62:0.84:0.59:0.84:0.51:0.78:0.38:0.82:0.31"] = 318, -- Kamagua, Apothecary Camp, Camp Winterhoof, Camp Oneqwah, Zim'Torga, Gundrak
					["0.74:0.71:0.49:0.58:0.29:0.57:0.29:0.54"] = 348, -- Kamagua, Moa'ki, Unu'pe, Taunka'le Village

					-- Horde: Howling Fjord: New Agamand
					["0.85:0.73:0.74:0.62:0.70:0.55:0.69:0.42:0.64:0.42:0.52:0.38"] = 335, -- New Agamand, Apothecary Camp, Conquest Hold, Light's Breach, Ebon Watch, Dalaran
					["0.85:0.73:0.95:0.63"] = 80, -- New Agamand, Vengeance Landing
					["0.85:0.73:0.74:0.71"] = 77, -- New Agamand, Kamagua
					["0.85:0.73:0.84:0.59:0.84:0.51"] = 136, -- New Agamand, Camp Winterhoof, Camp Oneqwah
					["0.85:0.73:0.74:0.62"] = 104, -- New Agamand, Apothecary Camp
					["0.85:0.73:0.84:0.59"] = 80, -- New Agamand, Camp Winterhoof
					["0.85:0.73:0.74:0.62:0.70:0.55"] = 150, -- New Agamand, Apothecary Camp, Conquest Hold
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57"] = 402, -- New Agamand, Kamagua, Moa'ki, Unu'pe
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57:0.15:0.57"] = 489, -- New Agamand, Kamagua, Moa'ki, Unu'pe, Warsong Hold
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57:0.29:0.54:0.17:0.53:0.12:0.53"] = 534, -- New Agamand, Kamagua, Moa'ki, Unu'pe, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57:0.29:0.54:0.17:0.53"] = 498, -- New Agamand, Kamagua, Moa'ki, Unu'pe, Taunka'le Village, Amber Ledge
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57:0.29:0.54:0.18:0.47"] = 496, -- New Agamand, Kamagua, Moa'ki, Unu'pe, Taunka'le Village, Bor'gorok Outpost
					["0.85:0.73:0.74:0.71:0.49:0.58:0.29:0.57:0.29:0.54"] = 424, -- New Agamand, Kamagua, Moa'ki, Unu'pe, Taunka'le Village
					["0.85:0.73:0.59:0.55:0.54:0.52:0.45:0.51:0.31:0.43:0.24:0.40"] = 506, -- New Agamand, Venomspite, Wyrmrest Temple, Agmar's Hammer, Warsong Camp, River's Heart
					["0.85:0.73:0.59:0.55:0.54:0.52:0.45:0.51:0.31:0.43"] = 429, -- New Agamand, Venomspite, Wyrmrest Temple, Agmar's Hammer, Warsong Camp
					["0.85:0.73:0.74:0.62:0.70:0.55:0.69:0.42:0.64:0.42:0.52:0.38:0.52:0.34:0.28:0.28"] = 528, -- New Agamand, Apothecary Camp, Conquest Hold, Light's Breach, Ebon Watch, Dalaran, Crusaders' Pinnacle, Death's Rise

					-- Horde: Howling Fjord: Vengeance Landing
					["0.95:0.63:0.85:0.73"] = 88, -- Vengeance Landing, New Agamand
					["0.95:0.63:0.85:0.73:0.74:0.71"] = 163, -- Vengeance Landing, New Agamand, Kamagua
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.49:0.58"] = 330, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Moa'ki
					["0.95:0.63:0.84:0.51:0.69:0.42:0.64:0.42:0.52:0.38"] = 303, -- Vengeance Landing, Camp Oneqwah, Light's Breach, Ebon Watch, Dalaran
					["0.95:0.63:0.84:0.51"] = 105, -- Vengeance Landing, Camp Oneqwah
					["0.95:0.63:0.84:0.59:0.74:0.62"] = 130, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.49:0.58:0.29:0.57:0.15:0.57"] = 548, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Moa'ki, Unu'pe, Warsong Hold
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.29:0.54:0.17:0.53:0.12:0.53"] = 589, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.29:0.54:0.17:0.53"] = 554, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village, Amber Ledge
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.49:0.58:0.29:0.57"] = 461, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Moa'ki, Unu'pe
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.29:0.54:0.18:0.47"] = 550, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village, Bor'gorok Outpost
					["0.95:0.63:0.84:0.59"] = 74, -- Vengeance Landing, Camp Winterhoof
					["0.95:0.63:0.84:0.51:0.78:0.38"] = 197, -- Vengeance Landing, Camp Oneqwah, Zim'Torga
					["0.95:0.63:0.84:0.59:0.74:0.62:0.59:0.55:0.54:0.52:0.45:0.51:0.29:0.54"] = 478, -- Vengeance Landing, Camp Winterhoof, Apothecary Camp, Venomspite, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village

					----------------------------------------------------------------------
					-- Horde: Icecrown
					----------------------------------------------------------------------

					-- Horde: Icecrown: Argent Tournament Grounds

					-- Horde: Icecrown: Death's Rise
					["0.28:0.28:0.38:0.21"] = 94, -- Death's Rise, The Shadow Vault
					["0.28:0.28:0.38:0.21:0.49:0.21"] = 170, -- Death's Rise, The Shadow Vault, Argent Tournament Grounds
					["0.28:0.28:0.52:0.34:0.56:0.36:0.52:0.38"] = 238, -- Death's Rise, Crusaders' Pinnacle, The Argent Vanguard, Dalaran
					["0.28:0.28:0.31:0.43"] = 114, -- Death's Rise, Warsong Camp
					["0.28:0.28:0.31:0.43:0.29:0.54:0.29:0.57"] = 223, -- Death's Rise, Warsong Camp, Taunka'le Village, Unu'pe

					-- Horde: Icecrown: The Argent Vanguard
					["0.56:0.36:0.52:0.38"] = 32, -- The Argent Vanguard, Dalaran
					["0.56:0.36:0.52:0.38:0.60:0.40"] = 78, -- The Argent Vanguard, Dalaran, Sunreaver's Command
					["0.56:0.36:0.52:0.38:0.48:0.44"] = 93, -- The Argent Vanguard, Dalaran, Kor'koron Vanguard
					["0.56:0.36:0.52:0.38:0.62:0.36"] = 77, -- The Argent Vanguard, Dalaran, K3
					["0.56:0.36:0.52:0.34:0.31:0.43"] = 186, -- The Argent Vanguard, Crusaders' Pinnacle, Warsong Camp
					["0.56:0.36:0.52:0.38:0.64:0.42"] = 98, -- The Argent Vanguard, Dalaran, Ebon Watch
					["0.56:0.36:0.52:0.38:0.24:0.40"] = 232, -- The Argent Vanguard, Dalaran, River's Heart
					["0.56:0.36:0.52:0.38:0.64:0.42:0.69:0.42:0.84:0.51:0.84:0.59"] = 296, -- The Argent Vanguard, Dalaran, Ebon Watch, Light's Breach, Camp Oneqwah, Camp Winterhoof
					["0.56:0.36:0.52:0.34:0.31:0.43:0.29:0.54"] = 266, -- The Argent Vanguard, Crusaders' Pinnacle, Warsong Camp, Taunka'le Village

					-- Horde: Icecrown: The Shadow Vault

					----------------------------------------------------------------------
					-- Horde: Sholazar Basin
					----------------------------------------------------------------------

					-- Horde: Sholazar Basin: River's Heart
					["0.24:0.40:0.31:0.43"] = 129, -- River's Heart, Warsong Camp
					["0.24:0.40:0.18:0.47:0.29:0.54"] = 209, -- River's Heart, Bor'gorok Outpost, Taunka'le Village
					["0.24:0.40:0.52:0.38:0.64:0.42:0.69:0.42:0.84:0.51"] = 626, -- River's Heart, Dalaran, Ebon Watch, Light's Breach, Camp Oneqwah
					["0.24:0.40:0.52:0.38"] = 302, -- River's Heart, Dalaran
					["0.24:0.40:0.18:0.47"] = 94, -- River's Heart, Bor'gorok Outpost
					["0.24:0.40:0.18:0.47:0.15:0.57"] = 201, -- River's Heart, Bor'gorok Outpost, Warsong Hold
					["0.24:0.40:0.18:0.47:0.17:0.53"] = 177, -- River's Heart, Bor'gorok Outpost, Amber Ledge
					["0.24:0.40:0.28:0.28"] = 140, -- River's Heart, Death's Rise
					["0.24:0.40:0.18:0.47:0.17:0.53:0.12:0.53"] = 231, -- River's Heart, Bor'gorok Outpost, Amber Ledge, Transitus Shield
					["0.24:0.40:0.31:0.43:0.45:0.51:0.59:0.55:0.85:0.73"] = 684, -- River's Heart, Warsong Camp, Agmar's Hammer, Venomspite, New Agamand
					["0.24:0.40:0.31:0.43:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 728, -- River's Heart, Warsong Camp, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing

					----------------------------------------------------------------------
					-- Horde: The Storm Peaks
					----------------------------------------------------------------------

					-- Horde: The Storm Peaks: Bouldercrag's Refuge
					["0.57:0.21:0.64:0.19"] = 45, -- Bouldercrag's Refuge, Ulduar

					-- Horde: The Storm Peaks: Camp Tunka'lo
					["0.73:0.25:0.78:0.38:0.82:0.31"] = 152, -- Camp Tunka'lo, Zim'Torga, Gundrak
					["0.73:0.25:0.62:0.36:0.52:0.38"] = 186, -- Camp Tunka'lo, K3, Dalaran

					-- Horde: The Storm Peaks: Grom'arsh Crash-Site
					["0.60:0.25:0.56:0.36:0.52:0.38"] = 111, -- Grom'arsh Crash-Site, The Argent Vanguard, Dalaran

					-- Horde: The Storm Peaks: K3
					["0.62:0.36:0.52:0.38"] = 72, -- K3, Dalaran
					["0.62:0.36:0.64:0.42:0.72:0.40"] = 107, -- K3, Ebon Watch, The Argent Stand
					["0.62:0.36:0.52:0.38:0.56:0.36"] = 94, -- K3, Dalaran, The Argent Vanguard
					["0.62:0.36:0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62:0.74:0.71"] = 272, -- K3, Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp, Kamagua

					-- Horde: The Storm Peaks: Ulduar
					["0.64:0.19:0.73:0.25"] = 88, -- Ulduar, Camp Tunka'lo
					["0.64:0.19:0.78:0.38:0.82:0.31"] = 207, -- Ulduar, Zim'Torga, Gundrak

					----------------------------------------------------------------------
					-- Horde: Wintergrasp
					----------------------------------------------------------------------

					-- Horde: Wintergrasp: Warsong Camp
					["0.31:0.43:0.24:0.40"] = 77, -- Warsong Camp, River's Heart
					["0.31:0.43:0.29:0.54"] = 81, -- Warsong Camp, Taunka'le Village
					["0.31:0.43:0.52:0.38"] = 141, -- Warsong Camp, Dalaran
					["0.31:0.43:0.24:0.40:0.18:0.47"] = 131, -- Warsong Camp, River's Heart, Bor'gorok Outpost
					["0.31:0.43:0.29:0.54:0.29:0.57"] = 109, -- Warsong Camp, Taunka'le Village, Unu'pe
					["0.31:0.43:0.29:0.54:0.17:0.53:0.12:0.53"] = 191, -- Warsong Camp, Taunka'le Village, Amber Ledge, Transitus Shield
					["0.31:0.43:0.45:0.51:0.59:0.55:0.85:0.73"] = 371, -- Warsong Camp, Agmar's Hammer, Venomspite, New Agamand
					["0.31:0.43:0.45:0.51:0.59:0.55:0.70:0.55:0.84:0.59:0.95:0.63"] = 401, -- Warsong Camp, Agmar's Hammer, Venomspite, Conquest Hold, Camp Winterhoof, Vengeance Landing
					["0.31:0.43:0.45:0.51:0.49:0.58"] = 161, -- Warsong Camp, Agmar's Hammer, Moa'ki
					["0.31:0.43:0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 365, -- Warsong Camp, Dalaran, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.31:0.43:0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38"] = 312, -- Warsong Camp, Dalaran, Ebon Watch, The Argent Stand, Zim'Torga

					----------------------------------------------------------------------
					-- Horde: Zul'Drak
					----------------------------------------------------------------------

					-- Horde: Zul'Drak: The Argent Stand
					["0.72:0.40:0.69:0.42"] = 25, -- The Argent Stand, Light's Breach
					["0.72:0.40:0.78:0.38"] = 42, -- The Argent Stand, Zim'Torga
					["0.72:0.40:0.78:0.38:0.82:0.31"] = 95, -- The Argent Stand, Zim'Torga, Gundrak
					["0.72:0.40:0.64:0.42"] = 53, -- The Argent Stand, Ebon Watch
					["0.72:0.40:0.64:0.42:0.52:0.38"] = 120, -- The Argent Stand, Ebon Watch, Dalaran
					["0.72:0.40:0.64:0.42:0.52:0.38:0.56:0.36"] = 141, -- The Argent Stand, Ebon Watch, Dalaran, The Argent Vanguard
					["0.72:0.40:0.84:0.51:0.84:0.59"] = 148, -- The Argent Stand, Camp Oneqwah, Camp Winterhoof

					-- Horde: Zul'Drak: Ebon Watch
					["0.64:0.42:0.69:0.42"] = 45, -- Ebon Watch, Light's Breach
					["0.64:0.42:0.72:0.40"] = 65, -- Ebon Watch, The Argent Stand
					["0.64:0.42:0.72:0.40:0.78:0.38"] = 105, -- Ebon Watch, The Argent Stand, Zim'Torga
					["0.64:0.42:0.52:0.38"] = 68, -- Ebon Watch, Dalaran
					["0.64:0.42:0.62:0.36"] = 41, -- Ebon Watch, K3
					["0.64:0.42:0.69:0.42:0.70:0.55:0.74:0.62"] = 175, -- Ebon Watch, Light's Breach, Conquest Hold, Apothecary Camp
					["0.64:0.42:0.52:0.38:0.56:0.36"] = 89, -- Ebon Watch, Dalaran, The Argent Vanguard

					-- Horde: Zul'Drak: Gundrak
					["0.82:0.31:0.78:0.38"] = 56, -- Gundrak, Zim'Torga
					["0.82:0.31:0.78:0.38:0.72:0.40"] = 109, -- Gundrak, Zim'Torga, The Argent Stand
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.52:0.38"] = 227, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Dalaran
					["0.82:0.31:0.78:0.38:0.84:0.51"] = 138, -- Gundrak, Zim'Torga, Camp Oneqwah
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.60:0.40"] = 187, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Sunreaver's Command
					["0.82:0.31:0.78:0.38:0.72:0.40:0.69:0.42"] = 132, -- Gundrak, Zim'Torga, The Argent Stand, Light's Breach
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.45:0.51:0.29:0.54"] = 430, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.49:0.58:0.29:0.57"] = 434, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Moa'ki, Unu'pe
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.52:0.38:0.31:0.43"] = 374, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Dalaran, Warsong Camp

					-- Horde: Zul'Drak: Light's Breach
					["0.69:0.42:0.64:0.42"] = 41, -- Light's Breach, Ebon Watch
					["0.69:0.42:0.70:0.55"] = 75, -- Light's Breach, Conquest Hold
					["0.69:0.42:0.72:0.40"] = 44, -- Light's Breach, The Argent Stand
					["0.69:0.42:0.64:0.42:0.52:0.38"] = 107, -- Light's Breach, Ebon Watch, Dalaran
					["0.69:0.42:0.64:0.42:0.54:0.52:0.49:0.58"] = 183, -- Light's Breach, Ebon Watch, Wyrmrest Temple, Moa'ki
					["0.69:0.42:0.64:0.42:0.54:0.52:0.49:0.58:0.29:0.57"] = 314, -- Light's Breach, Ebon Watch, Wyrmrest Temple, Moa'ki, Unu'pe

					-- Horde: Zul'Drak: Zim'Torga
					["0.78:0.38:0.72:0.40"] = 54, -- Zim'Torga, The Argent Stand
					["0.78:0.38:0.72:0.40:0.69:0.42"] = 77, -- Zim'Torga, The Argent Stand, Light's Breach
					["0.78:0.38:0.72:0.40:0.64:0.42"] = 105, -- Zim'Torga, The Argent Stand, Ebon Watch
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.45:0.51:0.29:0.54:0.15:0.57"] = 459, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village, Warsong Hold
					["0.78:0.38:0.72:0.40:0.64:0.42:0.52:0.38:0.24:0.40:0.18:0.47"] = 424, -- Zim'Torga, The Argent Stand, Ebon Watch, Dalaran, River's Heart, Bor'gorok Outpost
					["0.78:0.38:0.72:0.40:0.64:0.42:0.48:0.44"] = 213, -- Zim'Torga, The Argent Stand, Ebon Watch, Kor'koron Vanguard
					["0.78:0.38:0.84:0.51"] = 83, -- Zim'Torga, Camp Oneqwah
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.45:0.51:0.29:0.54"] = 374, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Agmar's Hammer, Taunka'le Village

				},

			},

			----------------------------------------------------------------------
			--	Alliance
			----------------------------------------------------------------------

			["Alliance"] = {

				[1415] = {

					-- Alliance: Acherus (Eastern Plaguelands)
					["0.62:0.34:0.61:0.35:0.58:0.06"] = 385, -- Acherus: The Ebon Hold, Light's Hope Chapel, Shattered Sun Staging Area
					["0.62:0.34:0.61:0.35"] = 50, -- Acherus: The Ebon Hold, Light's Hope Chapel
					["0.62:0.34:0.61:0.35:0.51:0.36"] = 149, -- Acherus: The Ebon Hold, Light's Hope Chapel, Thondoril River
					["0.62:0.34:0.61:0.35:0.61:0.28"] = 151, -- Acherus: The Ebon Hold, Light's Hope Chapel, Zul'Aman
					["0.62:0.34:0.61:0.35:0.48:0.39"] = 198, -- Acherus: The Ebon Hold, Light's Hope Chapel, Chillwind Camp
					["0.62:0.34:0.61:0.35:0.50:0.42"] = 210, -- Acherus: The Ebon Hold, Light's Hope Chapel, Aerie Peak
					["0.62:0.34:0.61:0.35:0.50:0.42:0.44:0.45"] = 272, -- Acherus: The Ebon Hold, Light's Hope Chapel, Aerie Peak, Southshore
					["0.62:0.34:0.61:0.35:0.50:0.42:0.51:0.47"] = 280, -- Acherus: The Ebon Hold, Light's Hope Chapel, Aerie Peak, Refuge Pointe
					["0.62:0.34:0.61:0.35:0.50:0.42:0.44:0.45:0.45:0.56"] = 380, -- Acherus: The Ebon Hold, Light's Hope Chapel, Aerie Peak, Southshore, Menethil Harbor
					["0.62:0.34:0.61:0.35:0.47:0.59"] = 416, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge
					["0.62:0.34:0.61:0.35:0.50:0.42:0.51:0.47:0.53:0.61"] = 450, -- Acherus: The Ebon Hold, Light's Hope Chapel, Aerie Peak, Refuge Pointe, Thelsamar
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65"] = 464, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72"] = 548, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73"] = 576, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 580, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 638, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 717, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 638, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 654, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.62:0.34:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 760, -- Acherus: The Ebon Hold, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Booty Bay

					-- Alliance: Aerie Peak (The Hinterlands)
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 633, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 527, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 512, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73"] = 448, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 504, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 583, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 446, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72"] = 414, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65"] = 324, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point
					["0.50:0.42:0.51:0.47:0.53:0.61"] = 246, -- Aerie Peak, Refuge Pointe, Thelsamar
					["0.50:0.42:0.47:0.59"] = 256, -- Aerie Peak, Ironforge
					["0.50:0.42:0.44:0.45:0.45:0.56"] = 176, -- Aerie Peak, Southshore, Menethil Harbor
					["0.50:0.42:0.51:0.47"] = 75, -- Aerie Peak, Refuge Pointe
					["0.50:0.42:0.44:0.45"] = 68, -- Aerie Peak, Southshore
					["0.50:0.42:0.48:0.39"] = 53, -- Aerie Peak, Chillwind Camp
					["0.50:0.42:0.61:0.35"] = 164, -- Aerie Peak, Light's Hope Chapel
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.50:0.75"] = 547, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Lakeshire
					["0.50:0.42:0.47:0.59:0.41:0.73:0.55:0.81"] = 592, -- Aerie Peak, Ironforge, Stormwind, Nethergarde Keep
					["0.50:0.42:0.47:0.59:0.41:0.73:0.41:0.93"] = 614, -- Aerie Peak, Ironforge, Stormwind, Booty Bay
					["0.50:0.42:0.47:0.59:0.41:0.73:0.47:0.79"] = 531, -- Aerie Peak, Ironforge, Stormwind, Darkshire
					["0.50:0.42:0.47:0.59:0.41:0.73"] = 429, -- Aerie Peak, Ironforge, Stormwind
					["0.50:0.42:0.47:0.59:0.41:0.73:0.50:0.75"] = 527, -- Aerie Peak, Ironforge, Stormwind, Lakeshire
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.47:0.79"] = 550, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Darkshire
					["0.50:0.42:0.61:0.35:0.61:0.28"] = 262, -- Aerie Peak, Light's Hope Chapel, Zul'Aman
					["0.50:0.42:0.61:0.35:0.58:0.06"] = 501, -- Aerie Peak, Light's Hope Chapel, Shattered Sun Staging Area
					["0.50:0.42:0.44:0.45:0.45:0.56:0.53:0.61"] = 339, -- Aerie Peak, Southshore, Menethil Harbor, Thelsamar
					["0.50:0.42:0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.55:0.81"] = 611, -- Aerie Peak, Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Nethergarde Keep
					["0.50:0.42:0.47:0.59:0.47:0.65"] = 302, -- Aerie Peak, Ironforge, Thorium Point
					["0.50:0.42:0.47:0.59:0.41:0.73:0.43:0.82"] = 508, -- Aerie Peak, Ironforge, Stormwind, Rebel Camp
					["0.50:0.42:0.48:0.39:0.51:0.36"] = 107, -- Aerie Peak, Chillwind Camp, Thondroril River
					["0.50:0.42:0.61:0.35:0.62:0.34"] = 233, -- Aerie Peak, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.50:0.42:0.47:0.59:0.47:0.65:0.41:0.73"] = 413, -- Aerie Peak, Ironforge, Thorium Point, Stormwind
					["0.50:0.42:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 598, -- Aerie Peak, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.50:0.42:0.47:0.59:0.41:0.73:0.52:0.72"] = 568, -- Aerie Peak, Ironforge, Stormwind, Morgan's Vigil
					["0.50:0.42:0.47:0.59:0.53:0.61"] = 323, -- Aerie Peak, Ironforge, Thelsamar

					-- Alliance: Booty Bay (Stranglethorn Vale)
					["0.41:0.93:0.39:0.80"] = 148, -- Booty Bay, Sentinel Hill
					["0.41:0.93:0.43:0.82"] = 118, -- Booty Bay, Rebel Camp
					["0.41:0.93:0.47:0.79"] = 167, -- Booty Bay, Darkshire
					["0.41:0.93:0.43:0.82:0.47:0.79:0.55:0.81"] = 252, -- Booty Bay, Rebel Camp, Darkshire, Nethergarde Keep
					["0.41:0.93:0.43:0.82:0.47:0.79:0.50:0.75"] = 215, -- Booty Bay, Rebel Camp, Darkshire, Lakeshire
					["0.41:0.93:0.43:0.82:0.47:0.79:0.50:0.75:0.52:0.72"] = 276, -- Booty Bay, Rebel Camp, Darkshire, Lakeshire, Morgan's Vigil
					["0.41:0.93:0.41:0.73"] = 200, -- Booty Bay, Stormwind
					["0.41:0.93:0.41:0.73:0.47:0.65"] = 318, -- Booty Bay, Stormwind, Thorium Point
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61"] = 397, -- Booty Bay, Stormwind, Thorium Point, Thelsamar
					["0.41:0.93:0.41:0.73:0.47:0.59"] = 401, -- Booty Bay, Stormwind, Ironforge (howieyard27@aol.com reported 200, not changed yet)
					["0.41:0.93:0.41:0.73:0.47:0.59:0.45:0.56"] = 472, -- Booty Bay, Stormwind, Ironforge, Menethil Harbor
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 560, -- Booty Bay, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.41:0.93:0.41:0.73:0.47:0.59:0.44:0.45"] = 573, -- Booty Bay, Stormwind, Ironforge, Southshore
					["0.41:0.93:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 632, -- Booty Bay, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.41:0.93:0.41:0.73:0.47:0.59:0.48:0.39"] = 614, -- Booty Bay, Stormwind, Ironforge, Chillwind Camp
					["0.41:0.93:0.41:0.73:0.47:0.59:0.61:0.35"] = 708, -- Booty Bay, Stormwind, Ironforge, Light's Hope Chapel
					["0.41:0.93:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 806, -- Booty Bay, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.41:0.93:0.41:0.73:0.47:0.59:0.51:0.47"] = 562, -- Booty Bay, Stormwind, Ironforge, Refuge Pointe
					["0.41:0.93:0.41:0.73:0.47:0.59:0.53:0.61"] = 460, -- Booty Bay, Stormwind, Ironforge, Thelsamar
					["0.41:0.93:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 633, -- Booty Bay, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.41:0.93:0.47:0.79:0.55:0.81"] = 258, -- Booty Bay, Darkshire, Nethergarde Keep
					["0.41:0.93:0.47:0.79:0.50:0.75"] = 222, -- Booty Bay, Darkshire, Lakeshire
					["0.41:0.93:0.41:0.73:0.47:0.59:0.58:0.06"] = 465, -- Booty Bay, Stormwind, Ironforge, Shattered Sun Staging Area
					["0.41:0.93:0.41:0.73:0.55:0.81"] = 363, -- Booty Bay, Stormwind, Nethergarde Keep
					["0.41:0.93:0.41:0.73:0.47:0.59:0.48:0.39:0.51:0.36"] = 667, -- Booty Bay, Stormwind, Ironforge, Chillwind Camp, Thondroril River
					["0.41:0.93:0.41:0.73:0.47:0.59:0.61:0.35:0.62:0.34"] = 774, -- Booty Bay, Stormwind, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.41:0.93:0.39:0.80:0.50:0.75"] = 277, -- Booty Bay, Sentinel Hill, Lakeshire

					-- Alliance: Chillwind Camp (Western Plaguelands)
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 603, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Booty Bay (was 662, changed by Roman Seidelsohn)
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 481, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 497, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 482, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 560, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 423, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72"] = 395, -- Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73"] = 418, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind
					["0.48:0.39:0.47:0.59:0.47:0.65"] = 309, -- Chillwind Camp, Ironforge, Thorium Point
					["0.48:0.39:0.50:0.42:0.51:0.47:0.53:0.61"] = 308, -- Chillwind Camp, Aerie Peak, Refuge Pointe, Thelsamar
					["0.48:0.39:0.47:0.59"] = 259, -- Chillwind Camp, Ironforge
					["0.48:0.39:0.44:0.45:0.45:0.56"] = 193, -- Chillwind Camp, Southshore, Menethil Harbor
					["0.48:0.39:0.50:0.42:0.51:0.47"] = 138, -- Chillwind Camp, Aerie Peak, Refuge Pointe
					["0.48:0.39:0.44:0.45"] = 86, -- Chillwind Camp, Southshore
					["0.48:0.39:0.50:0.42"] = 66, -- Chillwind Camp, Aerie Peak
					["0.48:0.39:0.61:0.35"] = 146, -- Chillwind Camp, Light's Hope Chapel
					["0.48:0.39:0.47:0.59:0.41:0.73:0.41:0.93"] = 617, -- Chillwind Camp, Ironforge, Stormwind, Baie-du-Butin, Booty Bay
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.50:0.75"] = 516, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Lakeshire
					["0.48:0.39:0.47:0.59:0.41:0.73:0.50:0.75"] = 531, -- Chillwind Camp, Ironforge, Stormwind, Lakeshire
					["0.48:0.39:0.47:0.59:0.41:0.73"] = 433, -- Chillwind Camp, Ironforge, Stormwind
					["0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 581, -- Chillwind Camp, Ironforge, Thorium Point, Stormwind, Nethergarde Keep
					["0.48:0.39:0.61:0.35:0.61:0.28"] = 244, -- Chillwind Camp, Light's Hope Chapel, Zul'Aman
					["0.48:0.39:0.61:0.35:0.58:0.06"] = 482, -- Chillwind Camp, Light's Hope Chapel, Shattered Sun Staging Area
					["0.48:0.39:0.47:0.59:0.41:0.73:0.55:0.81"] = 595, -- Chillwind Camp, Ironforge, Stormwind, Nethergarde Keep
					["0.48:0.39:0.44:0.45:0.51:0.47:0.53:0.61"] = 327, -- Chillwind Camp, Southshore, Refuge Pointe, Thelsamar
					["0.48:0.39:0.44:0.45:0.51:0.47"] = 157, -- Chillwind Camp, Southshore, Refuge Pointe
					["0.48:0.39:0.47:0.59:0.41:0.73:0.43:0.82"] = 512, -- Chillwind Camp, Ironforge, Stormwind, Rebel Camp
					["0.48:0.39:0.47:0.59:0.41:0.73:0.47:0.79"] = 534, -- Chillwind Camp, Ironforge, Stormwind, Darkshire
					["0.48:0.39:0.47:0.59:0.41:0.73:0.52:0.72"] = 572, -- Chillwind Camp, Ironforge, Stormwind, Morgan's Vigil
					["0.48:0.39:0.51:0.36"] = 54, -- Chillwind Camp, Thondroril River
					["0.48:0.39:0.61:0.35:0.62:0.34"] = 214, -- Chillwind Camp, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.48:0.39:0.47:0.59:0.51:0.47"] = 428, -- Chillwind Camp, Ironforge, Refuge Pointe

					-- Alliance: Darkshire (Duskwood)
					["0.47:0.79:0.41:0.93"] = 171, -- Darkshire, Booty Bay
					["0.47:0.79:0.43:0.82"] = 48, -- Darkshire, Rebel Camp
					["0.47:0.79:0.39:0.80"] = 93, -- Darkshire, Sentinel Hill
					["0.47:0.79:0.41:0.73"] = 88, -- Darkshire, Stormwind
					["0.47:0.79:0.50:0.75"] = 60, -- Darkshire, Lakeshire
					["0.47:0.79:0.55:0.81"] = 97, -- Darkshire, Nethergarde Keep
					["0.47:0.79:0.50:0.75:0.52:0.72"] = 120, -- Darkshire, Lakeshire, Morgan's Vigil
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61"] = 270, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65"] = 188, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59"] = 268, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 337, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor (was 417, changed to 337 by Roman Seidelsohn)
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 432, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 439, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 504, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak (was 582, changed by Mediana via email)
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 575, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.44:0.45"] = 548, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Southshore
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 674, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.47:0.79:0.41:0.73:0.47:0.59:0.45:0.56"] = 361, -- Darkshire, Stormwind, Ironforge, Menethil Harbor
					["0.47:0.79:0.41:0.73:0.47:0.59"] = 291, -- Darkshire, Stormwind, Ironforge
					["0.47:0.79:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 522, -- Darkshire, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.47:0.79:0.41:0.73:0.47:0.59:0.44:0.45"] = 462, -- Darkshire, Stormwind, Ironforge, Southshore
					["0.47:0.79:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 521, -- Darkshire, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.47:0.79:0.41:0.73:0.47:0.59:0.48:0.39"] = 503, -- Darkshire, Stormwind, Ironforge, Chillwind Camp
					["0.47:0.79:0.41:0.73:0.47:0.59:0.51:0.47"] = 451, -- Darkshire, Stormwind, Ironforge, Refuge Pointe
					["0.47:0.79:0.41:0.73:0.47:0.59:0.53:0.61"] = 348, -- Darkshire, Stormwind, Ironforge, Thelsamar
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 480, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp (changed to 480 by Kory Krebs and jody stapleton, was 534)
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.58:0.06"] = 333, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Shattered Sun Staging Area
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39:0.51:0.36"] = 533, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp, Thondroril River
					["0.47:0.79:0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.62:0.34"] = 641, -- Darkshire, Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.47:0.79:0.41:0.73:0.47:0.65"] = 208, -- Darkshire, Stormwind, Thorium Point

					-- Alliance: Ironforge (Dun Morogh)
					["0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 381, -- Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 260, -- Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 275, -- Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 260, -- Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 338, -- Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 201, -- Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.47:0.59:0.47:0.65:0.52:0.72"] = 173, -- Ironforge, Thorium Point, Morgan's Vigil
					["0.47:0.59:0.41:0.73"] = 210, -- Ironforge, Stormwind (Tatiana Beaklini suggested 215)
					["0.47:0.59:0.47:0.65"] = 87, -- Ironforge, Thorium Point
					["0.47:0.59:0.53:0.61"] = 101, -- Ironforge, Thelsamar
					["0.47:0.59:0.45:0.56"] = 115, -- Ironforge, Menethil Harbor
					["0.47:0.59:0.51:0.47"] = 204, -- Ironforge, Refuge Pointe
					["0.47:0.59:0.44:0.45"] = 216, -- Ironforge, Southshore
					["0.47:0.59:0.50:0.42"] = 299, -- Ironforge, Aerie Peak
					["0.47:0.59:0.48:0.39"] = 258, -- Ironforge, Chillwind Camp (Sexy Steven reported 106)
					["0.47:0.59:0.61:0.35"] = 349, -- Ironforge, Light's Hope Chapel
					["0.47:0.59:0.61:0.35:0.61:0.28"] = 445, -- Ironforge, Light's Hope Chapel, Zul'Aman
					["0.47:0.59:0.41:0.73:0.43:0.82"] = 290, -- Ironforge, Stormwind, Rebel Camp
					["0.47:0.59:0.41:0.73:0.39:0.80"] = 275, -- Ironforge, Stormwind, Sentinel Hill
					["0.47:0.59:0.41:0.73:0.50:0.75"] = 310, -- Ironforge, Stormwind, Lakeshire (was 309, changed to 211 by Dylan, changed back to 310 by Trev B and Steevan BARBOYON so 310 is correct)
					["0.47:0.59:0.41:0.73:0.55:0.81"] = 373, -- Ironforge, Stormwind, Nethergarde Keep
					["0.47:0.59:0.41:0.73:0.47:0.79"] = 313, -- Ironforge, Stormwind, Darkshire
					["0.47:0.59:0.47:0.65:0.41:0.73:0.50:0.75"] = 295, -- Ironforge, Thorium Point, Stormwind, Lakeshire
					["0.47:0.59:0.41:0.73:0.41:0.93"] = 396, -- Ironforge, Stormwind, Booty Bay
					["0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 359, -- Ironforge, Thorium Point, Stormwind, Nethergarde Keep
					["0.47:0.59:0.47:0.65:0.41:0.73:0.47:0.79"] = 298, -- Ironforge, Thorium Point, Stormwind, Darkshire
					["0.47:0.59:0.41:0.73:0.52:0.72"] = 350, -- Ironforge, Stormwind, Morgan's Vigil
					["0.47:0.59:0.58:0.06"] = 101, -- Ironforge, Shattered Sun Staging Area (was 100, changed to 111 by Maximilian Wittig, changed back to 99 by many others, changed to 100 by Oliver, changed to 101 by Daehoon Oh who reported 105)
					["0.47:0.59:0.58:0.06:0.61:0.28"] = 330, -- Ironforge, Shattered Sun Staging Area, Zul'Aman
					["0.47:0.59:0.48:0.39:0.51:0.36"] = 311, -- Ironforge, Chillwind Camp, Thondroril River
					["0.47:0.59:0.61:0.35:0.62:0.34"] = 415, -- Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Alliance: Lakeshire (Redridge Mountains)
					["0.50:0.75:0.47:0.79:0.43:0.82:0.41:0.93"] = 218, -- Lakeshire, Darkshire, Rebel Camp, Booty Bay
					["0.50:0.75:0.47:0.79:0.55:0.81"] = 148, -- Lakeshire, Darkshire, Nethergarde Keep
					["0.50:0.75:0.47:0.79"] = 60, -- Lakeshire, Darkshire
					["0.50:0.75:0.47:0.79:0.43:0.82"] = 104, -- Lakeshire, Darkshire, Rebel Camp
					["0.50:0.75:0.39:0.80"] = 133, -- Lakeshire, Sentinel Hill
					["0.50:0.75:0.41:0.73"] = 113, -- Lakeshire, Stormwind
					["0.50:0.75:0.52:0.72"] = 61, -- Lakeshire, Morgan's Vigil
					["0.50:0.75:0.52:0.72:0.47:0.65"] = 129, -- Lakeshire, Morgan's Vigil, Thorium Point
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61"] = 210, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59"] = 209, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 278, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 374, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 379, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Southshore (was 489, changed by Isaac Guinn and Georgi Georgiev)
					["0.50:0.75:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 445, -- Lakeshire, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 421, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp (was 475, changed to 421 by Christian Bösherz and Jonathon Hicks)
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 540, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel (Embracefate reported 515)
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.44:0.45"] = 489, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Southshore
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 614, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.50:0.75:0.41:0.73:0.47:0.59"] = 315, -- Lakeshire, Stormwind, Ironforge
					["0.50:0.75:0.41:0.73:0.47:0.59:0.45:0.56"] = 385, -- Lakeshire, Stormwind, Ironforge, Menethil Harbor
					["0.50:0.75:0.41:0.73:0.47:0.59:0.53:0.61"] = 373, -- Lakeshire, Stormwind, Ironforge, Thelsamar
					["0.50:0.75:0.41:0.73:0.55:0.81"] = 276, -- Seenhain, Sturmwind, Burg Nethergarde
					["0.50:0.75:0.41:0.73:0.47:0.59:0.48:0.39"] = 528, -- Lakeshire, Stormwind, Ironforge, Chillwind Camp
					["0.50:0.75:0.41:0.73:0.47:0.59:0.44:0.45"] = 487, -- Lakeshire, Stormwind, Ironforge, Southshore
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.58:0.06"] = 273, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Shattered Sun Staging Area
					["0.50:0.75:0.47:0.79:0.41:0.93"] = 228, -- Lakeshire, Darkshire, Booty Bay
					["0.50:0.75:0.41:0.73:0.47:0.65"] = 232, -- Lakeshire, Stormwind, Thorium Point
					["0.50:0.75:0.41:0.73:0.47:0.59:0.51:0.47"] = 475, -- Lakeshire, Stormwind, Ironforge, Refuge Pointe
					["0.50:0.75:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 474, -- Lakeshire, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.50:0.75:0.39:0.80:0.43:0.82"] = 196, -- Lakeshire, Sentinel Hill, Rebel Camp
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39:0.51:0.36"] = 474, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp, Thondroril River
					["0.50:0.75:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.62:0.34"] = 582, -- Lakeshire, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.50:0.75:0.41:0.73:0.47:0.65:0.53:0.61"] = 311, -- Lakeshire, Stormwind, Thorium Point, Thelsamar
					["0.50:0.75:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 547, -- Lakeshire, Stormwind, Ironforge, Refuge Pointe, Aerie Peak

					-- Alliance: Light's Hope Chapel (Eastern Plaguelands)
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 712, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 590, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 606, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 591, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 669, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 532, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72"] = 503, -- Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73"] = 527, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind
					["0.61:0.35:0.47:0.59:0.47:0.65"] = 417, -- Light's Hope Chapel, Ironforge, Thorium Point
					["0.61:0.35:0.50:0.42:0.51:0.47:0.53:0.61"] = 403, -- Light's Hope Chapel, Aerie Peak, Refuge Pointe, Thelsamar
					["0.61:0.35:0.47:0.59"] = 369, -- Light's Hope Chapel, Ironforge
					["0.61:0.35:0.50:0.42:0.44:0.45:0.45:0.56"] = 333, -- Light's Hope Chapel, Aerie Peak, Southshore, Menethil Harbor
					["0.61:0.35:0.50:0.42:0.51:0.47"] = 232, -- Light's Hope Chapel, Aerie Peak, Refuge Pointe
					["0.61:0.35:0.50:0.42:0.44:0.45"] = 225, -- Light's Hope Chapel, Aerie Peak, Southshore
					["0.61:0.35:0.50:0.42"] = 163, -- Light's Hope Chapel, Aerie Peak
					["0.61:0.35:0.48:0.39"] = 149, -- Light's Hope Chapel, Chillwind Camp
					["0.61:0.35:0.61:0.28"] = 104, -- Light's Hope Chapel, Zul'Aman
					["0.61:0.35:0.48:0.39:0.44:0.45"] = 226, -- Light's Hope Chapel, Chillwind Camp, Southshore
					["0.61:0.35:0.47:0.59:0.41:0.73"] = 541, -- Light's Hope Chapel, Ironforge, Stormwind
					["0.61:0.35:0.58:0.06"] = 339, -- Light's Hope Chapel, Shattered Sun Staging Area
					["0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 690, -- Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Nethergarde
					["0.61:0.35:0.47:0.59:0.41:0.73:0.55:0.81"] = 704, -- Light's Hope Chapel, Ironforge, Stormwind, Nethergarde Keep
					["0.61:0.35:0.47:0.59:0.53:0.61"] = 434, -- Light's Hope Chapel, Ironforge, Thelsamar
					["0.61:0.35:0.48:0.39:0.44:0.45:0.45:0.56"] = 334, -- Light's Hope Chapel, Chillwind Camp, Southshore, Menethil Harbor
					["0.61:0.35:0.47:0.59:0.41:0.73:0.47:0.79"] = 643, -- Light's Hope Chapel, Ironforge, Stormwind, Darkshire
					["0.61:0.35:0.48:0.39:0.44:0.45:0.51:0.47"] = 298, -- Light's Hope Chapel, Chillwind Camp, Southshore, Refuge Pointe
					["0.61:0.35:0.51:0.36"] = 102, -- Light's Hope Chapel, Thondroril River
					["0.61:0.35:0.62:0.34"] = 71, -- Light's Hope Chapel, Acherus: The Ebon Hold
					["0.61:0.35:0.47:0.59:0.41:0.73:0.52:0.72"] = 680, -- Light's Hope Chapel, Ironforge, Stormwind, Morgan's Vigil
					["0.61:0.35:0.47:0.59:0.41:0.73:0.41:0.93"] = 726, -- Light's Hope Chapel, Ironforge, Stormwind, Booty Bay

					-- Alliance: Menethil Harbor (Wetlands)
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 429, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 323, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 307, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Sentinel Hill (was 324, changed to 307 by advocate@wrath-wow.com)
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73"] = 244, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 309, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 386, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 250, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72"] = 221, -- Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil
					["0.45:0.56:0.47:0.59:0.47:0.65"] = 135, -- Menethil Harbor, Ironforge, Thorium Point
					["0.45:0.56:0.53:0.61"] = 163, -- Menethil Harbor, Thelsamar
					["0.45:0.56:0.47:0.59"] = 89, -- Menethil Harbor, Ironforge
					["0.45:0.56:0.51:0.47"] = 114, -- Menethil Harbor, Refuge Pointe
					["0.45:0.56:0.44:0.45"] = 107, -- Menethil Harbor, Southshore
					["0.45:0.56:0.44:0.45:0.50:0.42"] = 176, -- Menethil Harbor, Southshore, Aerie Peak
					["0.45:0.56:0.44:0.45:0.48:0.39"] = 186, -- Menethil Harbor, Southshore, Chillwind Camp
					["0.45:0.56:0.44:0.45:0.48:0.39:0.61:0.35"] = 324, -- Menethil Harbor, Southshore, Chillwind Camp, Light's Hope Chapel
					["0.45:0.56:0.47:0.59:0.41:0.73:0.41:0.93"] = 445, -- Menethil Harbor, Ironforge, Stormwind, Booty Bay
					["0.45:0.56:0.47:0.59:0.41:0.73"] = 260, -- Menethil Harbor, Ironforge, Stormwind
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 407, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Nethergarde Keep
					["0.45:0.56:0.47:0.59:0.41:0.73:0.39:0.80"] = 323, -- Menethil Harbor, Ironforge, Stormwind, Sentinel Hill
					["0.45:0.56:0.47:0.59:0.41:0.73:0.50:0.75"] = 358, -- Menethil Harbor, Ironforge, Stormwind, Lakeshire
					["0.45:0.56:0.47:0.59:0.41:0.73:0.47:0.79"] = 362, -- Menethil Harbor, Ironforge, Stormwind, Darkshire
					["0.45:0.56:0.47:0.59:0.41:0.73:0.43:0.82"] = 339, -- Menethil Harbor, Ironforge, Stormwind, Rebel Camp
					["0.45:0.56:0.47:0.59:0.41:0.73:0.55:0.81"] = 422, -- Menethil Harbor, Ironforge, Stormwind, Nethergarde Keep
					["0.45:0.56:0.44:0.45:0.48:0.39:0.61:0.35:0.61:0.28"] = 422, -- Menethil Harbor, Southshore, Chillwind Camp, Light's Hope Chapel, Zul'Aman
					["0.45:0.56:0.47:0.59:0.58:0.06"] = 153, -- Menethil Harbor, Ironforge, Shattered Sun Staging Area
					["0.45:0.56:0.47:0.59:0.48:0.39"] = 309, -- Menethil Harbor, Ironforge, Chillwind Camp
					["0.45:0.56:0.51:0.47:0.50:0.42"] = 185, -- Menethil Harbor, Refuge Pointe, Aerie Peak
					["0.45:0.56:0.44:0.45:0.48:0.39:0.51:0.36"] = 236, -- Menethil Harbor, Southshore, Chillwind Camp, Thondroril River
					["0.45:0.56:0.44:0.45:0.48:0.39:0.61:0.35:0.62:0.34"] = 392, -- Menethil Harbor, Southshore, Chillwind Camp, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.50:0.75"] = 343, -- Menethil Harbor, Ironforge, Thorium Point, Stormwind, Lakeshire
					["0.45:0.56:0.44:0.45:0.50:0.42:0.61:0.35"] = 339, -- Menethil Harbor, Southshore, Aerie Peak, Light's Hope Chapel

					-- Alliance: Morgan's Vigil (Burning Steppes)
					["0.52:0.72:0.50:0.75:0.47:0.79:0.43:0.82:0.41:0.93"] = 278, -- Morgan's Vigil, Lakeshire, Darkshire, Rebel Camp, Booty Bay
					["0.52:0.72:0.50:0.75:0.47:0.79:0.43:0.82"] = 165, -- Morgan's Vigil, Lakeshire, Darkshire, Rebel Camp
					["0.52:0.72:0.50:0.75:0.39:0.80"] = 195, -- Morgan's Vigil, Lakeshire, Sentinel Hill
					["0.52:0.72:0.41:0.73"] = 151, -- Morgan's Vigil, Stormwind
					["0.52:0.72:0.50:0.75:0.47:0.79"] = 121, -- Morgan's Vigil, Lakeshire, Darkshire
					["0.52:0.72:0.55:0.81"] = 198, -- Morgan's Vigil, Nethergarde Keep
					["0.52:0.72:0.50:0.75"] = 64, -- Morgan's Vigil, Lakeshire
					["0.52:0.72:0.47:0.65:0.53:0.61"] = 172, -- Morgan's Vigil, Thorium Point, Thelsamar
					["0.52:0.72:0.47:0.65"] = 91, -- Morgan's Vigil, Thorium Point
					["0.52:0.72:0.47:0.65:0.47:0.59"] = 171, -- Morgan's Vigil, Thorium Point, Ironforge
					["0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 240, -- Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 335, -- Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 342, -- Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 407, -- Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak (was 436, changed by Ludvig - Angelis0712)
					["0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 383, -- Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 478, -- Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.52:0.72:0.47:0.65:0.47:0.59:0.50:0.42:0.48:0.39"] = 437, -- Morgan's Vigil, Thorium Point, Ironforge, Aerie Peak, Chillwind Camp
					["0.52:0.72:0.41:0.73:0.47:0.59"] = 354, -- Morgan's Vigil, Stormwind, Ironforge
					["0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 576, -- Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.52:0.72:0.41:0.73:0.47:0.59:0.45:0.56"] = 423, -- Morgan's Vigil, Stormwind, Ironforge, Menethil Harbor
					["0.52:0.72:0.41:0.73:0.47:0.59:0.53:0.61"] = 411, -- Morgan's Vigil, Stormwind, Ironforge, Thelsamar
					["0.52:0.72:0.47:0.65:0.47:0.59:0.58:0.06"] = 236, -- Morgan's Vigil, Thorium Point, Ironforge, Shattered Sun Staging Area
					["0.52:0.72:0.50:0.75:0.47:0.79:0.41:0.93"] = 289, -- Morgan's Vigil, Lakeshire, Darkshire, Booty Bay
					["0.52:0.72:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 586, -- Morgan's Vigil, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.52:0.72:0.41:0.73:0.47:0.59:0.61:0.35"] = 660, -- Morgan's Vigil, Stormwind, Ironforge, Light's Hope Chapel
					["0.52:0.72:0.41:0.73:0.47:0.59:0.48:0.39"] = 566, -- Morgan's Vigil, Stormwind, Ironforge, Chillwind Camp
					["0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39:0.51:0.36"] = 436, -- Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp, Thondroril River
					["0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.62:0.34"] = 544, -- Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.52:0.72:0.41:0.73:0.41:0.93"] = 336, -- Morgan's Vigil, Stormwind, Booty Bay
					["0.52:0.72:0.41:0.73:0.47:0.59:0.44:0.45"] = 525, -- Morgan's Vigil, Stormwind, Ironforge, Southshore

					-- Alliance: Nethergarde Keep (Blasted Lands)
					["0.55:0.81:0.47:0.79:0.43:0.82:0.41:0.93"] = 251, -- Nethergarde Keep, Darkshire, Rebel Camp, Booty Bay
					["0.55:0.81:0.47:0.79:0.43:0.82"] = 138, -- Nethergarde Keep, Darkshire, Rebel Camp
					["0.55:0.81:0.47:0.79:0.39:0.80"] = 183, -- Nethergarde Keep, Darkshire, Sentinel Hill
					["0.55:0.81:0.41:0.73"] = 189, -- Nethergarde Keep, Stormwind
					["0.55:0.81:0.47:0.79"] = 91, -- Nethergarde Keep, Darkshire
					["0.55:0.81:0.47:0.79:0.50:0.75"] = 150, -- Nethergarde Keep, Darkshire, Lakeshire
					["0.55:0.81:0.52:0.72"] = 207, -- Nethergarde Keep, Morgan's Vigil
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61"] = 359, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar
					["0.55:0.81:0.52:0.72:0.47:0.65"] = 278, -- Nethergarde Keep, Morgan's Vigil, Thorium Point
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59"] = 357, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.45:0.56"] = 426, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Menethil Harbor
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47"] = 522, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.44:0.45"] = 528, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Southshore
					["0.55:0.81:0.52:0.72:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 593, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39"] = 570, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35"] = 664, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 763, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.55:0.81:0.47:0.79:0.41:0.93"] = 262, -- Nethergarde Keep, Darkshire, Booty Bay
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.45:0.56"] = 451, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Menethil Harbor
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 611, -- Nethergarde Keep, Darkshire, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.48:0.39"] = 594, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Chillwind Camp
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.65"] = 298, -- Nethergarde Keep, Darkshire, Stormwind, Thorium Point
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 612, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.51:0.47"] = 541, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Refuge Pointe
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.53:0.61"] = 439, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Thelsamar
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.58:0.06"] = 422, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Shattered Sun Staging Area
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59"] = 381, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.44:0.45"] = 552, -- Burg Nethergarde, Dunkelhain, Sturmwind, Eisenschmiede, Süderstade
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.65:0.53:0.61"] = 377, -- Nethergarde Keep, Darkshire, Stormwind, Thorium Point, Thelsamar
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.61:0.35"] = 687, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Light's Hope Chapel
					["0.55:0.81:0.41:0.73:0.47:0.59:0.53:0.61"] = 450, -- Nethergarde Keep, Stormwind, Ironforge, Thelsamar
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 540, -- Nethergarde Keep, Darkshire, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.48:0.39:0.51:0.36"] = 623, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Chillwind Camp, Thondroril River
					["0.55:0.81:0.52:0.72:0.47:0.65:0.47:0.59:0.61:0.35:0.62:0.34"] = 731, -- Nethergarde Keep, Morgan's Vigil, Thorium Point, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.55:0.81:0.47:0.79:0.41:0.73:0.47:0.59:0.44:0.45:0.50:0.42"] = 622, -- Nethergarde Keep, Darkshire, Stormwind, Ironforge, Southshore, Aerie Peak

					-- Alliance: Rebel Camp (Stranglethorn Vale)
					["0.43:0.82:0.41:0.93"] = 116, -- Rebel Camp, Booty Bay
					["0.43:0.82:0.39:0.80"] = 66, -- Rebel Camp, Sentinel Hill
					["0.43:0.82:0.41:0.73"] = 98, -- Rebel Camp, Stormwind
					["0.43:0.82:0.47:0.79:0.55:0.81"] = 139, -- Rebel Camp, Darkshire, Nethergarde Keep
					["0.43:0.82:0.47:0.79"] = 48, -- Rebel Camp, Darkshire
					["0.43:0.82:0.47:0.79:0.50:0.75"] = 102, -- Rebel Camp, Darkshire, Lakeshire
					["0.43:0.82:0.47:0.79:0.50:0.75:0.52:0.72"] = 163, -- Rebel Camp, Darkshire, Lakeshire, Morgan's Vigil
					["0.43:0.82:0.41:0.73:0.47:0.65"] = 218, -- Rebel Camp, Stormwind, Thorium Point
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61"] = 296, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar
					["0.43:0.82:0.41:0.73:0.47:0.59"] = 300, -- Rebel Camp, Stormwind, Ironforge
					["0.43:0.82:0.41:0.73:0.47:0.59:0.45:0.56"] = 370, -- Rebel Camp, Stormwind, Ironforge, Menethil Harbor
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 459, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.43:0.82:0.41:0.73:0.47:0.59:0.44:0.45"] = 472, -- Rebel Camp, Stormwind, Ironforge, Southshore
					["0.43:0.82:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 531, -- Rebel Camp, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.43:0.82:0.41:0.73:0.47:0.59:0.48:0.39"] = 513, -- Rebel Camp, Stormwind, Ironforge, Chillwind Camp (was 567, changed by SchinknBrot on CurseForge and Alexander Vestbjerg)
					["0.43:0.82:0.41:0.73:0.47:0.59:0.61:0.35"] = 676, -- Rebel Camp, Stormwind, Ironforge, Light's Hope Chapel
					["0.43:0.82:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 704, -- Rebel Camp, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.43:0.82:0.41:0.73:0.47:0.59:0.51:0.47"] = 461, -- Rebel Camp, Stormwind, Ironforge, Refuge Pointe
					["0.43:0.82:0.41:0.73:0.47:0.59:0.53:0.61"] = 358, -- Rebel Camp, Stormwind, Ironforge, Thelsamar
					["0.43:0.82:0.41:0.73:0.47:0.59:0.58:0.06"] = 365, -- Rebel Camp, Stormwind, Ironforge, Shattered Sun Staging Area
					["0.43:0.82:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 532, -- Rebel Camp, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.43:0.82:0.39:0.80:0.50:0.75"] = 196, -- Rebel Camp, Sentinel Hill, Lakeshire
					["0.43:0.82:0.41:0.73:0.47:0.59:0.48:0.39:0.51:0.36"] = 566, -- Rebel Camp, Stormwind, Ironforge, Chillwind Camp, Thondroril River
					["0.43:0.82:0.41:0.73:0.47:0.59:0.61:0.35:0.62:0.34"] = 673, -- Rebel Camp, Stormwind, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Alliance: Refuge Pointe (Arathi Highlands)
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 558, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 436, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 452, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 429, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 509, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 371, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.51:0.47:0.53:0.61:0.47:0.65:0.52:0.72"] = 339, -- Refuge Pointe, Thelsamar, Thorium Point, Morgan's Vigil
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73"] = 373, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind
					["0.51:0.47:0.53:0.61:0.47:0.65"] = 249, -- Refuge Pointe, Thelsamar, Thorium Point
					["0.51:0.47:0.53:0.61"] = 171, -- Refuge Pointe, Thelsamar
					["0.51:0.47:0.47:0.59"] = 270, -- Refuge Pointe, Ironforge
					["0.51:0.47:0.45:0.56"] = 126, -- Refuge Pointe, Menethil Harbor
					["0.51:0.47:0.44:0.45"] = 87, -- Refuge Pointe, Southshore
					["0.51:0.47:0.50:0.42"] = 72, -- Refuge Pointe, Aerie Peak
					["0.51:0.47:0.50:0.42:0.48:0.39"] = 123, -- Refuge Pointe, Aerie Peak, Chillwind Camp
					["0.51:0.47:0.50:0.42:0.61:0.35"] = 233, -- Refuge Pointe, Aerie Peak, Light's Hope Chapel
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.41:0.93"] = 570, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Booty Bay
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73"] = 386, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.39:0.80"] = 449, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Sentinel Hill
					["0.51:0.47:0.47:0.59:0.41:0.73"] = 440, -- Refuge Pointe, Ironforge, Stormwind
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.47:0.79"] = 488, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Darkshire
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.43:0.82"] = 464, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Rebel Camp
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.55:0.81"] = 548, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Nethergarde Keep
					["0.51:0.47:0.45:0.56:0.47:0.59:0.41:0.73:0.50:0.75"] = 484, -- Refuge Pointe, Menethil Harbor, Ironforge, Stormwind, Lakeshire
					["0.51:0.47:0.50:0.42:0.61:0.35:0.58:0.06"] = 569, -- Refuge Pointe, Aerie Peak, Light's Hope Chapel, Shattered Sun Staging Area
					["0.51:0.47:0.44:0.45:0.48:0.39"] = 166, -- Refuge Pointe, Southshore, Chillwind Camp
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.47:0.79"] = 475, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Darkshire
					["0.51:0.47:0.50:0.42:0.61:0.35:0.61:0.28"] = 332, -- Refuge Pointe, Aerie Peak, Light's Hope Chapel, Zul'Aman
					["0.51:0.47:0.50:0.42:0.48:0.39:0.51:0.36"] = 175, -- Refuge Pointe, Aerie Peak, Chillwind Camp, Thondroril River
					["0.51:0.47:0.50:0.42:0.61:0.35:0.62:0.34"] = 302, -- Refuge Pointe, Aerie Peak, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.51:0.47:0.53:0.61:0.47:0.65:0.41:0.73:0.55:0.81"] = 536, -- Refuge Pointe, Thelsamar, Thorium Point, Stormwind, Nethergarde Keep
					["0.51:0.47:0.47:0.59:0.48:0.39"] = 477, -- Refuge Pointe, Ironforge, Chillwind Camp

					-- Alliance: Sentinel Hill (Westfall)
					["0.39:0.80:0.41:0.93"] = 185, -- Sentinel Hill, Booty Bay
					["0.39:0.80:0.43:0.82"] = 62, -- Sentinel Hill, Rebel Camp
					["0.39:0.80:0.47:0.79:0.55:0.81"] = 186, -- Sentinel Hill, Darkshire, Nethergarde Keep
					["0.39:0.80:0.47:0.79"] = 97, -- Sentinel Hill, Darkshire
					["0.39:0.80:0.50:0.75"] = 130, -- Sentinel Hill, Lakeshire
					["0.39:0.80:0.50:0.75:0.52:0.72"] = 190, -- Sentinel Hill, Lakeshire, Morgan's Vigil
					["0.39:0.80:0.41:0.73"] = 86, -- Sentinel Hill, Stormwind
					["0.39:0.80:0.41:0.73:0.47:0.65"] = 205, -- Sentinel Hill, Stormwind, Thorium Point
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61"] = 284, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar
					["0.39:0.80:0.41:0.73:0.47:0.59"] = 288, -- Sentinel Hill, Stormwind, Ironforge
					["0.39:0.80:0.41:0.73:0.47:0.59:0.45:0.56"] = 358, -- Sentinel Hill, Stormwind, Ironforge, Menethil Harbor
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 447, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.39:0.80:0.41:0.73:0.47:0.59:0.44:0.45"] = 460, -- Sentinel Hill, Stormwind, Ironforge, Southshore
					["0.39:0.80:0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 376, -- Sentinel Hill, Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.39:0.80:0.41:0.73:0.47:0.59:0.48:0.39"] = 555, -- Sentinel Hill, Stormwind, Ironforge, Chillwind Camp
					["0.39:0.80:0.41:0.73:0.47:0.59:0.61:0.35"] = 595, -- Sentinel Hill, Stormwind, Ironforge, Light's Hope Chapel
					["0.39:0.80:0.41:0.73:0.47:0.59:0.53:0.61"] = 346, -- Sentinel Hill, Stormwind, Ironforge, Thelsamar
					["0.39:0.80:0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 693, -- Sentinel Hill, Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.39:0.80:0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 519, -- Sentinel Hill, Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.39:0.80:0.41:0.73:0.47:0.59:0.51:0.47"] = 449, -- Sentinel Hill, Stormwind, Ironforge, Refuge Pointe
					["0.39:0.80:0.41:0.73:0.47:0.59:0.58:0.06"] = 352, -- Sentinel Hill, Stormwind, Ironforge, Shattered Sun Staging Area
					["0.39:0.80:0.41:0.73:0.47:0.59:0.48:0.39:0.51:0.36"] = 554, -- Sentinel Hill, Stormwind, Ironforge, Chillwind Camp, Thondroril River
					["0.39:0.80:0.41:0.73:0.47:0.59:0.61:0.35:0.62:0.34"] = 661, -- Sentinel Hill, Stormwind, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Alliance: Shattered Sun Staging Area (Isle of Quel'Danas)
					["0.58:0.06:0.61:0.35"] = 324, -- Shattered Sun Staging Area, Light's Hope Chapel
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73"] = 849, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind
					["0.58:0.06:0.61:0.35:0.48:0.39"] = 470, -- Shattered Sun Staging Area, Light's Hope Chapel, Chillwind Camp
					["0.58:0.06:0.61:0.35:0.47:0.59"] = 690, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge
					["0.58:0.06:0.61:0.35:0.50:0.42"] = 483, -- Shattered Sun Staging Area, Light's Hope Chapel, Aerie Peak
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 1033, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72"] = 822, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 991, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 912, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 928, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 912, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65"] = 738, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point
					["0.58:0.06:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 854, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.58:0.06:0.61:0.35:0.50:0.42:0.51:0.47"] = 553, -- Shattered Sun Staging Area, Light's Hope Chapel, Aerie Peak, Refuge Pointe
					["0.58:0.06:0.61:0.35:0.50:0.42:0.51:0.47:0.53:0.61"] = 723, -- Shattered Sun Staging Area, Light's Hope Chapel, Aerie Peak, Refuge Pointe, Thelsamar
					["0.58:0.06:0.61:0.35:0.50:0.42:0.44:0.45"] = 545, -- Shattered Sun Staging Area, Light's Hope Chapel, Aerie Peak, Southshore
					["0.58:0.06:0.61:0.35:0.50:0.42:0.44:0.45:0.45:0.56"] = 653, -- Shattered Sun Staging Area, Light's Hope Chapel, Aerie Peak, Southshore, Menethil Harbor
					["0.58:0.06:0.61:0.28"] = 233, -- Shattered Sun Staging Area, Zul'Aman (Yunus Gürbüz reported 242 but my own testing shows 233) (Will Hausenfluck reported 134)
					["0.58:0.06:0.61:0.35:0.47:0.59:0.41:0.73"] = 864, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Stormwind
					["0.58:0.06:0.61:0.35:0.47:0.59:0.41:0.73:0.55:0.81"] = 1027, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Stormwind, Nethergarde Keep
					["0.58:0.06:0.61:0.35:0.47:0.59:0.41:0.73:0.47:0.79"] = 965, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Stormwind, Darkshire
					["0.58:0.06:0.61:0.35:0.51:0.36"] = 424, -- Shattered Sun Staging Area, Light's Hope Chapel, Thondroril River
					["0.58:0.06:0.61:0.35:0.47:0.59:0.41:0.73:0.41:0.93"] = 1050, -- Shattered Sun Staging Area, Light's Hope Chapel, Ironforge, Stormwind, Booty Bay
					["0.58:0.06:0.61:0.35:0.48:0.39:0.44:0.45:0.45:0.56"] = 680, -- Shattered Sun Staging Area, Light's Hope Chapel, Chillwind Camp, Southshore, Menethil Harbor

					-- Alliance: Southshore (Hillsbrad Foothills)
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 539, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Booty Bay (was 597, changed by Daniel Hoedt and Robert Keller)
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 430, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 433, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 417, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 496, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 359, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.52:0.72"] = 327, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Morgan's Vigil
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73"] = 354, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65"] = 243, -- Southshore, Menethil Harbor, Ironforge, Thorium Point
					["0.44:0.45:0.51:0.47:0.53:0.61"] = 244, -- Southshore, Refuge Pointe, Thelsamar
					["0.44:0.45:0.47:0.59"] = 207, -- Southshore, Ironforge
					["0.44:0.45:0.45:0.56"] = 110, -- Southshore, Menethil Harbor
					["0.44:0.45:0.51:0.47"] = 74, -- Southshore, Refuge Pointe
					["0.44:0.45:0.50:0.42"] = 71, -- Southshore, Aerie Peak
					["0.44:0.45:0.48:0.39"] = 81, -- Southshore, Chillwind Camp (Will Hausenfluck reported 44)
					["0.44:0.45:0.48:0.39:0.61:0.35"] = 219, -- Southshore, Chillwind Camp, Light's Hope Chapel
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73"] = 370, -- Southshore, Menethil Harbor, Ironforge, Stormwind
					["0.44:0.45:0.45:0.56:0.47:0.59:0.47:0.65:0.41:0.73:0.55:0.81"] = 517, -- Southshore, Menethil Harbor, Ironforge, Thorium Point, Stormwind, Nethergarde Keep
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.41:0.93"] = 554, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Booty Bay
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.43:0.82"] = 449, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Rebel Camp
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.39:0.80"] = 433, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Sentinel Hill
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.50:0.75"] = 468, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Lakeshire
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.47:0.79"] = 472, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Darkshire
					["0.44:0.45:0.48:0.39:0.61:0.35:0.58:0.06"] = 555, -- Southshore, Chillwind Camp, Light's Hope Chapel, Shattered Sun Staging Area
					["0.44:0.45:0.48:0.39:0.61:0.35:0.61:0.28"] = 318, -- Southshore, Chillwind Camp, Light's Hope Chapel, Zul'Aman
					["0.44:0.45:0.45:0.56:0.53:0.61"] = 273, -- Southshore, Menethil Harbor, Thelsamar
					["0.44:0.45:0.47:0.59:0.41:0.73"] = 373, -- Southshore, Ironforge, Stormwind
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.55:0.81"] = 532, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Nethergarde Keep
					["0.44:0.45:0.47:0.59:0.41:0.73:0.50:0.75"] = 471, -- Southshore, Ironforge, Stormwind, Lakeshire
					["0.44:0.45:0.48:0.39:0.51:0.36"] = 131, -- Southshore, Chillwind Camp, Thondroril River
					["0.44:0.45:0.48:0.39:0.61:0.35:0.62:0.34"] = 286, -- Southshore, Chillwind Camp, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.44:0.45:0.45:0.56:0.47:0.59:0.41:0.73:0.52:0.72"] = 508, -- Southshore, Menethil Harbor, Ironforge, Stormwind, Morgan's Vigil

					-- Alliance: Stormwind (Elwynn Forest)
					["0.41:0.73:0.41:0.93"] = 200, -- Stormwind, Booty Bay
					["0.41:0.73:0.55:0.81"] = 176, -- Stormwind, Nethergarde Keep
					["0.41:0.73:0.43:0.82"] = 93, -- Stormwind, Rebel Camp
					["0.41:0.73:0.39:0.80"] = 78, -- Stormwind, Sentinel Hill
					["0.41:0.73:0.47:0.79"] = 116, -- Stormwind, Darkshire
					["0.41:0.73:0.50:0.75"] = 113, -- Stormwind, Lakeshire
					["0.41:0.73:0.52:0.72"] = 157, -- Stormwind, Morgan's Vigil
					["0.41:0.73:0.47:0.65"] = 133, -- Stormwind, Thorium Point
					["0.41:0.73:0.47:0.65:0.53:0.61"] = 212, -- Stormwind, Thorium Point, Thelsamar
					["0.41:0.73:0.47:0.59"] = 216, -- Stormwind, Ironforge
					["0.41:0.73:0.47:0.59:0.45:0.56"] = 286, -- Stormwind, Ironforge, Menethil Harbor
					["0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47"] = 375, -- Stormwind, Thorium Point, Thelsamar, Refuge Pointe
					["0.41:0.73:0.47:0.59:0.44:0.45"] = 387, -- Stormwind, Ironforge, Southshore
					["0.41:0.73:0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 446, -- Stormwind, Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.41:0.73:0.47:0.59:0.48:0.39"] = 429, -- Stormwind, Ironforge, Chillwind Camp
					["0.41:0.73:0.47:0.59:0.61:0.35"] = 523, -- Stormwind, Ironforge, Light's Hope Chapel
					["0.41:0.73:0.47:0.59:0.61:0.35:0.61:0.28"] = 621, -- Stormwind, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.41:0.73:0.47:0.59:0.53:0.61"] = 274, -- Stormwind, Ironforge, Thelsamar
					["0.41:0.73:0.47:0.59:0.51:0.47"] = 377, -- Stormwind, Ironforge, Refuge Pointe
					["0.41:0.73:0.47:0.59:0.50:0.42:0.44:0.45"] = 497, -- Stormwind, Ironforge, Aerie Peak, Southshore
					["0.41:0.73:0.47:0.59:0.50:0.42"] = 304, -- Stormwind, Ironforge, Aerie Peak
					["0.41:0.73:0.47:0.59:0.50:0.42:0.48:0.39"] = 484, -- Stormwind, Ironforge, Aerie Peak, Chillwind Camp
					["0.41:0.73:0.47:0.59:0.51:0.47:0.50:0.42"] = 448, -- Stormwind, Ironforge, Refuge Pointe, Aerie Peak
					["0.41:0.73:0.47:0.59:0.58:0.06"] = 281, -- Stormwind, Ironforge, Shattered Sun Staging Area
					["0.41:0.73:0.47:0.59:0.44:0.45:0.50:0.42"] = 457, -- Stormwind, Ironforge, Southshore, Aerie Peak
					["0.41:0.73:0.47:0.59:0.48:0.39:0.51:0.36"] = 482, -- Stormwind, Ironforge, Chillwind Camp, Thondroril River
					["0.41:0.73:0.47:0.59:0.61:0.35:0.62:0.34"] = 589, -- Stormwind, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Alliance: Thelsamar (Loch Modan)
					["0.53:0.61:0.47:0.65:0.41:0.73:0.41:0.93"] = 390, -- Thelsamar, Thorium Point, Stormwind, Booty Bay
					["0.53:0.61:0.47:0.65:0.41:0.73:0.43:0.82"] = 284, -- Thelsamar, Thorium Point, Stormwind, Rebel Camp
					["0.53:0.61:0.47:0.65:0.41:0.73:0.39:0.80"] = 269, -- Thelsamar, Thorium Point, Stormwind, Sentinel Hill
					["0.53:0.61:0.47:0.65:0.41:0.73"] = 206, -- Thelsamar, Thorium Point, Stormwind
					["0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 262, -- Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.53:0.61:0.47:0.65:0.52:0.72:0.55:0.81"] = 341, -- Thelsamar, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.53:0.61:0.47:0.65:0.52:0.72:0.50:0.75"] = 204, -- Thelsamar, Thorium Point, Morgan's Vigil, Lakeshire
					["0.53:0.61:0.47:0.65:0.52:0.72"] = 172, -- Thelsamar, Thorium Point, Morgan's Vigil
					["0.53:0.61:0.47:0.65"] = 82, -- Thelsamar, Thorium Point
					["0.53:0.61:0.47:0.59"] = 109, -- Thelsamar, Ironforge
					["0.53:0.61:0.45:0.56"] = 153, -- Thelsamar, Menethil Harbor
					["0.53:0.61:0.51:0.47"] = 164, -- Thelsamar, Refuge Pointe
					["0.53:0.61:0.51:0.47:0.44:0.45"] = 250, -- Thelsamar, Refuge Pointe, Southshore
					["0.53:0.61:0.51:0.47:0.50:0.42"] = 235, -- Thelsamar, Refuge Pointe, Aerie Peak
					["0.53:0.61:0.51:0.47:0.50:0.42:0.48:0.39"] = 285, -- Thelsamar, Refuge Pointe, Aerie Peak, Chillwind Camp
					["0.53:0.61:0.51:0.47:0.50:0.42:0.61:0.35"] = 396, -- Thelsamar, Refuge Pointe, Aerie Peak, Light's Hope Chapel
					["0.53:0.61:0.47:0.59:0.41:0.73:0.39:0.80"] = 340, -- Thelsamar, Ironforge, Stormwind, Sentinel Hill
					["0.53:0.61:0.47:0.59:0.41:0.73"] = 277, -- Thelsamar, Ironforge, Stormwind
					["0.53:0.61:0.51:0.47:0.50:0.42:0.61:0.35:0.61:0.28"] = 495, -- Thelsamar, Refuge Pointe, Aerie Peak, Light's Hope Chapel, Zul'Aman
					["0.53:0.61:0.47:0.59:0.41:0.73:0.47:0.79"] = 379, -- Thelsamar, Ironforge, Stormwind, Darkshire
					["0.53:0.61:0.47:0.59:0.41:0.73:0.50:0.75"] = 376, -- Thelsamar, Ironforge, Stormwind, Lakeshire
					["0.53:0.61:0.47:0.59:0.41:0.73:0.43:0.82"] = 355, -- Thelsamar, Ironforge, Stormwind, Rebel Camp
					["0.53:0.61:0.47:0.59:0.41:0.73:0.41:0.93"] = 461, -- Thelsamar, Ironforge, Stormwind, Booty Bay
					["0.53:0.61:0.47:0.59:0.58:0.06"] = 175, -- Thelsamar, Ironforge, Shattered Sun Staging Area
					["0.53:0.61:0.47:0.65:0.41:0.73:0.47:0.79"] = 307, -- Thelsamar, Thorium Point, Stormwind, Darkshire
					["0.53:0.61:0.47:0.59:0.41:0.73:0.55:0.81"] = 440, -- Thelsamar, Ironforge, Stormwind, Nethergarde Keep
					["0.53:0.61:0.47:0.65:0.41:0.73:0.55:0.81"] = 368, -- Thelsamar, Thorium Point, Stormwind, Nethergarde Keep
					["0.53:0.61:0.51:0.47:0.44:0.45:0.48:0.39"] = 329, -- Thelsamar, Refuge Pointe, Southshore, Chillwind Camp
					["0.53:0.61:0.51:0.47:0.50:0.42:0.48:0.39:0.51:0.36"] = 339, -- Thelsamar, Refuge Pointe, Aerie Peak, Chillwind Camp, Thondroril River
					["0.53:0.61:0.51:0.47:0.50:0.42:0.61:0.35:0.62:0.34"] = 465, -- Thelsamar, Refuge Pointe, Aerie Peak, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.53:0.61:0.45:0.56:0.44:0.45"] = 254, -- Thelsamar, Menethil Harbor, Southshore

					-- Alliance: Thondroril River (Western Plaguelands)
					["0.51:0.36:0.48:0.39:0.50:0.42"] = 123, -- Thondroril River, Chillwind Camp, Aerie Peak
					["0.51:0.36:0.48:0.39"] = 59, -- Thondroril River, Chillwind Camp
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 655, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 550, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72"] = 443, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil
					["0.51:0.36:0.48:0.39:0.44:0.45"] = 135, -- Thondroril River, Chillwind Camp, Southshore
					["0.51:0.36:0.48:0.39:0.50:0.42:0.51:0.47:0.53:0.61"] = 365, -- Thondroril River, Chillwind Camp, Aerie Peak, Refuge Pointe, Thelsamar
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 613, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.51:0.36:0.61:0.35:0.58:0.06"] = 433, -- Thondroril River, Light's Hope Chapel, Shattered Sun Staging Area
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73"] = 471, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Stormwind
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72"] = 443, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 534, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 534, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65"] = 359, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point
					["0.51:0.36:0.48:0.39:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 476, -- Thondroril River, Chillwind Camp, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.51:0.36:0.48:0.39:0.47:0.59"] = 312, -- Thondroril River, Chillwind Camp, Ironforge
					["0.51:0.36:0.48:0.39:0.44:0.45:0.45:0.56"] = 242, -- Thondroril River, Chillwind Camp, Southshore, Menethil Harbor
					["0.51:0.36:0.48:0.39:0.50:0.42:0.51:0.47"] = 195, -- Thondroril River, Chillwind Camp, Aerie Peak, Refuge Pointe
					["0.51:0.36:0.61:0.35"] = 98, -- Thondroril River, Light's Hope Chapel (Sexy Steven reported 27)
					["0.51:0.36:0.61:0.35:0.61:0.28"] = 197, -- Thondroril River, Light's Hope Chapel, Zul'Aman
					["0.51:0.36:0.61:0.35:0.62:0.34"] = 165, -- Thondoril River, Light's Hope Chapel, Acherus: The Ebon Hold

					-- Alliance: Thorium Point (Searing Gorge)
					["0.47:0.65:0.41:0.73:0.41:0.93"] = 310, -- Thorium Point, Stormwind, Booty Bay
					["0.47:0.65:0.41:0.73:0.43:0.82"] = 206, -- Thorium Point, Stormwind, Rebel Camp
					["0.47:0.65:0.41:0.73:0.39:0.80"] = 190, -- Thorium Point, Stormwind, Sentinel Hill
					["0.47:0.65:0.41:0.73"] = 126, -- Thorium Point, Stormwind
					["0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 181, -- Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.47:0.65:0.52:0.72:0.55:0.81"] = 260, -- Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.47:0.65:0.52:0.72:0.50:0.75"] = 122, -- Thorium Point, Morgan's Vigil, Lakeshire
					["0.47:0.65:0.52:0.72"] = 90, -- Thorium Point, Morgan's Vigil
					["0.47:0.65:0.53:0.61"] = 88, -- Thorium Point, Thelsamar
					["0.47:0.65:0.47:0.59"] = 94, -- Thorium Point, Ironforge
					["0.47:0.65:0.47:0.59:0.45:0.56"] = 159, -- Thorium Point, Ironforge, Menethil Harbor
					["0.47:0.65:0.53:0.61:0.51:0.47"] = 251, -- Thorium Point, Thelsamar, Refuge Pointe
					["0.47:0.65:0.47:0.59:0.44:0.45"] = 261, -- Thorium Point, Ironforge, Southshore (was 370, changed by Yannick Jacoby)
					["0.47:0.65:0.53:0.61:0.51:0.47:0.50:0.42"] = 323, -- Thorium Point, Thelsamar, Refuge Pointe, Aerie Peak
					["0.47:0.65:0.47:0.59:0.48:0.39"] = 302, -- Thorium Point, Ironforge, Chillwind Camp
					["0.47:0.65:0.47:0.59:0.61:0.35"] = 398, -- Thorium Point, Ironforge, Light's Hope Chapel
					["0.47:0.65:0.47:0.59:0.61:0.35:0.61:0.28"] = 495, -- Thorium Point, Ironforge, Light's Hope Chapel, Zul'Aman
					["0.47:0.65:0.41:0.73:0.47:0.79"] = 228, -- Thorium Point, Stormwind, Darkshire
					["0.47:0.65:0.41:0.73:0.55:0.81"] = 289, -- Thorium Point, Stormwind, Nethergarde Keep
					["0.47:0.65:0.41:0.73:0.50:0.75"] = 224, -- Thorium Point, Stormwind, Lakeshire
					["0.47:0.65:0.47:0.59:0.58:0.06"] = 155, -- Thorium Point, Ironforge, Shattered Sun Staging Area
					["0.47:0.65:0.47:0.59:0.48:0.39:0.51:0.36"] = 355, -- Thorium Point, Ironforge, Chillwind Camp, Thondroril River
					["0.47:0.65:0.47:0.59:0.61:0.35:0.62:0.34"] = 463, -- Thorium Point, Ironforge, Light's Hope Chapel, Acherus: The Ebon Hold
					["0.47:0.65:0.47:0.59:0.44:0.45:0.50:0.42"] = 330, -- Thorium Point, Ironforge, Southshore, Aerie Peak

					-- Alliance: Zul'Aman (Ghostlands)
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73"] = 631, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind
					["0.61:0.28:0.61:0.35:0.47:0.59"] = 473, -- Zul'Aman, Light's Hope Chapel, Ironforge
					["0.61:0.28:0.61:0.35"] = 107, -- Zul'Aman, Light's Hope Chapel
					["0.61:0.28:0.61:0.35:0.50:0.42:0.44:0.45"] = 328, -- Zul'Aman, Light's Hope Chapel, Aerie Peak, Southshore
					["0.61:0.28:0.61:0.35:0.48:0.39"] = 253, -- Zul'Aman, Light's Hope Chapel, Chillwind Camp
					["0.61:0.28:0.61:0.35:0.50:0.42:0.51:0.47"] = 337, -- Zul'Aman, Light's Hope Chapel, Aerie Peak, Refuge Pointe
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75:0.47:0.79"] = 696, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire, Darkshire
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.43:0.82"] = 710, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Rebel Camp
					["0.61:0.28:0.61:0.35:0.50:0.42:0.44:0.45:0.45:0.56"] = 436, -- Zul'Aman, Light's Hope Chapel, Aerie Peak, Southshore, Menethil Harbor
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.55:0.81"] = 775, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Nethergarde Keep
					["0.61:0.28:0.61:0.35:0.50:0.42"] = 266, -- Zul'Aman, Light's Hope Chapel, Aerie Peak
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.41:0.93"] = 818, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Booty Bay
					["0.61:0.28:0.61:0.35:0.50:0.42:0.51:0.47:0.53:0.61"] = 506, -- Zul'Aman, Light's Hope Chapel, Aerie Peak, Refuge Pointe, Thelsamar
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72:0.50:0.75"] = 637, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil, Lakeshire
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.52:0.72"] = 605, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Morgan's Vigil
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65:0.41:0.73:0.39:0.80"] = 695, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point, Stormwind, Sentinel Hill
					["0.61:0.28:0.58:0.06"] = 252, -- Zul'Aman, Shattered Sun Staging Area
					["0.61:0.28:0.61:0.35:0.47:0.59:0.47:0.65"] = 521, -- Zul'Aman, Light's Hope Chapel, Ironforge, Thorium Point
					["0.61:0.28:0.61:0.35:0.47:0.59:0.41:0.73:0.55:0.81"] = 809, -- Zul'Aman, Light's Hope Chapel, Ironforge, Stormwind, Nethergarde Keep
					["0.61:0.28:0.61:0.35:0.47:0.59:0.41:0.73"] = 647, -- Zul'Aman, Light's Hope Chapel, Ironforge, Stormwind
					["0.61:0.28:0.61:0.35:0.62:0.34"] = 175, -- Zul'Aman, Light's Hope Chapel, Acherus: The Ebon Hold

				},

				-- Alliance: Kalimdor
				[1414] = {

					-- Alliance: Blood Watch (Bloodmyst Isle)
					["0.22:0.18:0.21:0.26"] = 77, -- Blood Watch, The Exodar

					-- Alliance: The Exodar (The Exodar)
					["0.21:0.26:0.22:0.18"] = 77, -- The Exodar, Blood Watch

					-- Alliance: Astranaar (Ashenvale)
					["0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 511, -- Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.46:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 631, -- Astranaar, Ratchet, Gadgetzan, Cenarion Hold
					["0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 538, -- Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 457, -- Astranaar, Ratchet, Theramore, Thalanaar
					["0.46:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 357, -- Astranaar, Ratchet, Theramore, Mudsprocket
					["0.46:0.40:0.64:0.67"] = 388, -- Astranaar, Theramore
					["0.46:0.40:0.61:0.55:0.60:0.81"] = 434, -- Astranaar, Ratchet, Gadgetzan
					["0.46:0.40:0.61:0.55"] = 194, -- Astranaar, Ratchet
					["0.46:0.40:0.39:0.40:0.40:0.51"] = 279, -- Astranaar, Stonetalon Peak, Nijel's Point
					["0.46:0.40:0.39:0.40"] = 153, -- Astranaar, Stonetalon Peak
					["0.46:0.40:0.61:0.40"] = 148, -- Astranaar, Talrendis Point
					["0.46:0.40:0.58:0.39"] = 134, -- Astranaar, Forest Song
					["0.46:0.40:0.50:0.35"] = 79, -- Astranaar, Emerald Sanctuary
					["0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 296, -- Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.46:0.40:0.50:0.35:0.53:0.26"] = 206, -- Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.46:0.40:0.50:0.35:0.53:0.26:0.55:0.21"] = 265, -- Astranaar, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.46:0.40:0.43:0.25"] = 149, -- Astranaar, Auberdine
					["0.46:0.40:0.43:0.25:0.42:0.16"] = 233, -- Astranaar, Auberdine, Rut'theran Village
					["0.46:0.40:0.43:0.25:0.53:0.26"] = 338, -- Astranaar, Auberdine, Talonbranch Glade
					["0.46:0.40:0.43:0.25:0.40:0.51"] = 440, -- Astranaar, Auberdine, Nijel's Point
					["0.46:0.40:0.61:0.40:0.65:0.23"] = 327, -- Astranaar, Talrendis Point, Everlook
					["0.46:0.40:0.43:0.25:0.31:0.69"] = 621, -- Astranaar, Auberdine, Feathermoon
					["0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69:0.48:0.70"] = 666, -- Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon, Thalanaar
					["0.46:0.40:0.43:0.25:0.53:0.26:0.65:0.23"] = 427, -- Astranaar, Auberdine, Talonbranch Glade, Everlook
					["0.46:0.40:0.64:0.67:0.48:0.70"] = 551, -- Astranaar, Theramore, Thalanaar

					-- Alliance: Auberdine (Darkshore)
					["0.43:0.25:0.31:0.69"] = 473, -- Auberdine, Feathermoon
					["0.43:0.25:0.31:0.69:0.42:0.79"] = 623, -- Auberdine, Feathermoon, Cenarion Hold
					["0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 700, -- Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.43:0.25:0.64:0.67:0.48:0.70"] = 602, -- Auberdine, Theramore, Thalanaar
					["0.43:0.25:0.64:0.67:0.58:0.70"] = 503, -- Auberdine, Theramore, Mudsprocket
					["0.43:0.25:0.64:0.67"] = 443, -- Auberdine, Theramore
					["0.43:0.25:0.64:0.67:0.60:0.81"] = 596, -- Auberdine, Theramore, Gadgetzan
					["0.43:0.25:0.46:0.40:0.61:0.55"] = 361, -- Auberdine, Astranaar, Ratchet
					["0.43:0.25:0.40:0.51"] = 291, -- Auberdine, Nijel's Point
					["0.43:0.25:0.39:0.40"] = 181, -- Auberdine, Stonetalon Peak
					["0.43:0.25:0.46:0.40"] = 168, -- Auberdine, Astranaar
					["0.43:0.25:0.46:0.40:0.50:0.35"] = 246, -- Auberdine, Astranaar, Emerald Sanctuary
					["0.43:0.25:0.46:0.40:0.58:0.39"] = 302, -- Auberdine, Astranaar, Forest Song
					["0.43:0.25:0.61:0.40"] = 300, -- Auberdine, Talrendis Point
					["0.43:0.25:0.55:0.21:0.65:0.23"] = 270, -- Auberdine, Moonglade, Everlook
					["0.43:0.25:0.53:0.26"] = 190, -- Auberdine, Talonbranch Glade
					["0.43:0.25:0.55:0.21"] = 151, -- Auberdine, Moonglade
					["0.43:0.25:0.42:0.16"] = 84, -- Auberdine, Rut'theran Village
					["0.43:0.25:0.53:0.26:0.65:0.23"] = 279, -- Auberdine, Talonbranch Glade, Everlook
					["0.43:0.25:0.31:0.69:0.48:0.70"] = 627, -- Auberdine, Feathermoon, Thalanaar
					["0.43:0.25:0.64:0.67:0.61:0.55"] = 552, -- Auberdine, Theramore, Ratchet
					["0.43:0.25:0.46:0.40:0.61:0.55:0.60:0.81:0.48:0.70:0.58:0.70"] = 863, -- Auberdine, Astranaar, Ratchet, Gadgetzan, Thalanaar, Mudsprocket
					["0.43:0.25:0.61:0.40:0.58:0.39"] = 326, -- Auberdine, Talrendis Point, Forest Song
					["0.43:0.25:0.61:0.40:0.65:0.23"] = 478, -- Auberdine, Talrendis Point, Everlook
					["0.43:0.25:0.46:0.40:0.61:0.55:0.60:0.81"] = 602, -- Auberdine, Astranaar, Trinquete, Gadgetzan

					-- Alliance: Cenarion Hold (Silithus)
					["0.42:0.79:0.31:0.69"] = 175, -- Cenarion Hold, Feathermoon
					["0.42:0.79:0.31:0.69:0.48:0.70"] = 329, -- Cenarion Hold, Feathermoon, Thalanaar
					["0.42:0.79:0.50:0.76"] = 92, -- Cenarion Hold, Marshal's Refuge
					["0.42:0.79:0.60:0.81"] = 189, -- Cenarion Hold, Gadgetzan
					["0.42:0.79:0.60:0.81:0.64:0.67:0.58:0.70"] = 399, -- Cenarion Hold, Gadgetzan, Theramore, Mudsprocket
					["0.42:0.79:0.60:0.81:0.64:0.67"] = 342, -- Cenarion Hold, Gadgetzan, Theramore
					["0.42:0.79:0.60:0.81:0.61:0.55"] = 435, -- Cenarion Hold, Gadgetzan, Ratchet
					["0.42:0.79:0.31:0.69:0.40:0.51"] = 402, -- Cenarion Hold, Feathermoon, Nijel's Point
					["0.42:0.79:0.31:0.69:0.40:0.51:0.39:0.40"] = 521, -- Cenarion Hold, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.42:0.79:0.60:0.81:0.61:0.55:0.46:0.40"] = 630, -- Cenarion Hold, Gadgetzan, Ratchet, Astranaar
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 694, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 587, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40"] = 562, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 740, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.42:0.79:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 821, -- Cenarion Hold, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.42:0.79:0.31:0.69:0.43:0.25:0.55:0.21"] = 793, -- Cenarion Hold, Feathermoon, Auberdine, Moonglade
					["0.42:0.79:0.31:0.69:0.43:0.25"] = 642, -- Cenarion Hold, Feathermoon, Auberdine
					["0.42:0.79:0.31:0.69:0.43:0.25:0.42:0.16"] = 726, -- Cenarion Hold, Feathermoon, Auberdine, Rut'theran Village
					["0.42:0.79:0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35"] = 709, -- Cenarion Hold, Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary
					["0.42:0.79:0.31:0.69:0.43:0.25:0.55:0.21:0.65:0.23"] = 911, -- Cenarion Hold, Feathermoon, Auberdine, Moonglade, Everlook
					["0.42:0.79:0.60:0.81:0.48:0.70"] = 366, -- Cenarion Hold, Gadgetzan, Thalanaar
					["0.42:0.79:0.31:0.69:0.43:0.25:0.53:0.26"] = 832, -- Cenarion Hold, Feathermoon, Auberdine, Talonbranch Glade
					["0.42:0.79:0.60:0.81:0.64:0.67:0.40:0.51"] = 668, -- Cenarion Hold, Gadgetzan, Theramore, Nijel's Point

					-- Alliance: Emerald Sanctuary (Felwood)
					["0.50:0.35:0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 592, -- Emerald Sanctuary, Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 696, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 602, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 523, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 499, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 424, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 361, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore
					["0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55"] = 263, -- Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet
					["0.50:0.35:0.46:0.40:0.39:0.40:0.40:0.51"] = 361, -- Emerald Sanctuary, Astranaar, Stonetalon Peak, Nijel's Point
					["0.50:0.35:0.46:0.40:0.39:0.40"] = 234, -- Emerald Sanctuary, Astranaar, Stonetalon Peak
					["0.50:0.35:0.46:0.40"] = 81, -- Emerald Sanctuary, Astranaar
					["0.50:0.35:0.58:0.39"] = 103, -- Emerald Sanctuary, Forest Song
					["0.50:0.35:0.58:0.39:0.61:0.40"] = 128, -- Emerald Sanctuary, Forest Song, Talrendis Point
					["0.50:0.35:0.53:0.26:0.65:0.23"] = 218, -- Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.50:0.35:0.53:0.26:0.55:0.21"] = 187, -- Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.50:0.35:0.53:0.26"] = 128, -- Emerald Sanctuary, Talonbranch Glade
					["0.50:0.35:0.46:0.40:0.43:0.25"] = 229, -- Emerald Sanctuary, Astranaar, Auberdine
					["0.50:0.35:0.46:0.40:0.43:0.25:0.42:0.16"] = 313, -- Emerald Sanctuary, Astranaar, Auberdine, Rut'theran Village
					["0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 618, -- Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81"] = 514, -- Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan
					["0.50:0.35:0.46:0.40:0.61:0.55"] = 274, -- Emerald Sanctuary, Astranaar, Ratchet
					["0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67"] = 374, -- Emerald Sanctuary, Astranaar, Ratchet, Theramore
					["0.50:0.35:0.53:0.26:0.43:0.25"] = 297, -- Emerald Sanctuary, Talonbranch Glade, Auberdine
					["0.50:0.35:0.53:0.26:0.43:0.25:0.42:0.16"] = 381, -- Emerald Sanctuary, Talonbranch Glade, Auberdine, Rut'theran Village
					["0.50:0.35:0.46:0.40:0.61:0.40"] = 228, -- Emerald Sanctuary, Astranaar, Talrendis Point
					["0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 537, -- Emerald Sanctuary, Astranaar, Ratchet, Theramore, Thalanaar
					["0.50:0.35:0.46:0.40:0.43:0.25:0.31:0.69"] = 701, -- Emerald Sanctuary, Astranaar, Auberdine, Feathermoon
					["0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 711, -- Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan, Cenarion Hold
					["0.50:0.35:0.46:0.40:0.64:0.67:0.60:0.81:0.50:0.76"] = 728, -- Emerald Sanctuary, Astranaar, Theramore, Gadgetzan, Marshal's Refuge
					["0.50:0.35:0.46:0.40:0.64:0.67"] = 468, -- Emerald Sanctuary, Astranaar, Theramore
					["0.50:0.35:0.46:0.40:0.64:0.67:0.60:0.81"] = 624, -- Emerald Sanctuary, Astranaar, Theramore, Gadgetzan

					-- Alliance: Everlook (Winterspring)
					["0.65:0.23:0.55:0.21:0.43:0.25:0.31:0.69"] = 724, -- Everlook, Moonglade, Auberdine, Feathermoon
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 734, -- Everlook, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 641, -- Everlook, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 562, -- Everlook, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 462, -- Everlook, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67"] = 399, -- Everlook, Talrendis Point, Ratchet, Theramore
					["0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81"] = 537, -- Everlook, Talrendis Point, Ratchet, Gadgetzan
					["0.65:0.23:0.61:0.40:0.61:0.55"] = 301, -- Everlook, Talrendis Point, Ratchet
					["0.65:0.23:0.55:0.21:0.43:0.25:0.40:0.51"] = 542, -- Everlook, Moonglade, Auberdine, Nijel's Point
					["0.65:0.23:0.55:0.21:0.43:0.25:0.39:0.40"] = 433, -- Everlook, Moonglade, Auberdine, Stonetalon Peak
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40"] = 295, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.65:0.23:0.53:0.26:0.50:0.35"] = 216, -- Everlook, Talonbranch Glade, Emerald Sanctuary
					["0.65:0.23:0.61:0.40:0.58:0.39"] = 191, -- Everlook, Talrendis Point, Forest Song
					["0.65:0.23:0.61:0.40"] = 167, -- Everlook, Talrendis Point
					["0.65:0.23:0.55:0.21"] = 111, -- Everlook, Moonglade
					["0.65:0.23:0.53:0.26"] = 107, -- Everlook, Talonbranch Glade
					["0.65:0.23:0.55:0.21:0.43:0.25"] = 252, -- Everlook, Moonglade, Auberdine
					["0.65:0.23:0.55:0.21:0.43:0.25:0.42:0.16"] = 335, -- Everlook, Moonglade, Auberdine, Rut'theran Village
					["0.65:0.23:0.53:0.26:0.43:0.25"] = 277, -- Everlook, Talonbranch Glade, Auberdine
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 834, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.65:0.23:0.55:0.21:0.43:0.25:0.31:0.69:0.42:0.79"] = 874, -- Everlook, Moonglade, Auberdine, Feathermoon, Cenarion Hold
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67"] = 590, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Theramore
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55"] = 489, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet
					["0.65:0.23:0.55:0.21:0.43:0.25:0.64:0.67:0.60:0.81"] = 847, -- Everlook, Moonglade, Auberdine, Theramore, Gadgetzan
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 740, -- Everlook, Talrendis Point, Ratchet, Theramore, Thalanaar, Feathermoon
					["0.65:0.23:0.53:0.26:0.43:0.25:0.42:0.16"] = 361, -- Everlook, Talonbranch Glade, Auberdine, Rut'theran Village
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 752, -- Long-guet, Clairière de Griffebranche, Sanctuaire d'émeraude, Astranaar, Cabestan, Theramore, Thalanaar
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81"] = 730, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan
					["0.65:0.23:0.61:0.40:0.46:0.40"] = 316, -- Everlook, Talrendis Point, Astranaar
					["0.65:0.23:0.55:0.21:0.43:0.25:0.46:0.40"] = 419, -- Everlook, Moonglade, Auberdine, Astranaar
					["0.65:0.23:0.61:0.40:0.46:0.40:0.39:0.40"] = 470, -- Everlook, Talrendis Point, Astranaar, Stonetalon Peak
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.39:0.40"] = 450, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Stonetalon Peak
					["0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.40:0.51"] = 733, -- Everlook, Talrendis Point, Ratchet, Theramore, Nijel's Point
					["0.65:0.23:0.53:0.26:0.50:0.35:0.58:0.39"] = 319, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Forest Song
					["0.65:0.23:0.53:0.26:0.43:0.25:0.31:0.69"] = 749, -- Everlook, Talonbranch Glade, Auberdine, Feathermoon
					["0.65:0.23:0.61:0.40:0.46:0.40:0.50:0.35"] = 394, -- Everlook, Talrendis Point, Astranaar, Emerald Sanctuary
					["0.65:0.23:0.53:0.26:0.43:0.25:0.64:0.67:0.60:0.81"] = 872, -- Everlook, Talonbranch Glade, Auberdine, Theramore, Gadgetzan
					["0.65:0.23:0.55:0.21:0.43:0.25:0.46:0.40:0.50:0.35"] = 497, -- Everlook, Moonglade, Auberdine, Astranaar, Emerald Sanctuary
					["0.65:0.23:0.55:0.21:0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 951, -- Everlook, Moonglade, Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.65:0.23:0.55:0.21:0.43:0.25:0.64:0.67"] = 694, -- Everlook, Moonglade, Auberdine, Theramore
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 807, -- Everlook, Talonbranch Glade, Emerald Sanctuary, Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.65:0.23:0.61:0.40:0.58:0.39:0.50:0.35"] = 298, -- Everlook, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.65:0.23:0.53:0.26:0.43:0.25:0.40:0.51"] = 568, -- Everlook, Talonbranch Glade, Auberdine, Nijel's Point
					["0.65:0.23:0.61:0.40:0.46:0.40:0.43:0.25:0.42:0.16"] = 549, -- Everlook, Talrendis Point, Astranaar, Auberdine, Rut'theran Village
					["0.65:0.23:0.55:0.21:0.43:0.25:0.46:0.40:0.61:0.55"] = 612, -- Everlook, Moonglade, Auberdine, Astranaar, Ratchet
					["0.65:0.23:0.53:0.26:0.50:0.35:0.46:0.40:0.64:0.67:0.60:0.81"] = 840, -- Vista Eterna, Claro Ramaespolón, Santuario Esmeralda, Astranaar, Theramore, Gadgetzan

					-- Alliance: Feathermoon (Feralas)
					["0.31:0.69:0.42:0.79"] = 153, -- Feathermoon, Cenarion Hold
					["0.31:0.69:0.42:0.79:0.50:0.76"] = 242, -- Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.31:0.69:0.48:0.70"] = 155, -- Feathermoon, Thalanaar
					["0.31:0.69:0.48:0.70:0.58:0.70"] = 240, -- Feathermoon, Thalanaar, Mudsprocket
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67"] = 292, -- Feathermoon, Thalanaar, Mudsprocket, Theramore
					["0.31:0.69:0.48:0.70:0.60:0.81"] = 326, -- Feathermoon, Thalanaar, Gadgetzan
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55"] = 406, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Ratchet
					["0.31:0.69:0.40:0.51"] = 227, -- Feathermoon, Nijel's Point
					["0.31:0.69:0.40:0.51:0.39:0.40"] = 346, -- Feathermoon, Nijel's Point, Stonetalon Peak
					["0.31:0.69:0.40:0.51:0.39:0.40:0.46:0.40"] = 500, -- Feathermoon, Nijel's Point, Stonetalon Peak, Astranaar
					["0.31:0.69:0.40:0.51:0.39:0.40:0.46:0.40:0.50:0.35"] = 578, -- Feathermoon, Nijel's Point, Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 550, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40"] = 524, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 703, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.31:0.69:0.43:0.25:0.55:0.21"] = 618, -- Feathermoon, Auberdine, Moonglade
					["0.31:0.69:0.43:0.25:0.53:0.26"] = 657, -- Feathermoon, Auberdine, Talonbranch Glade
					["0.31:0.69:0.43:0.25"] = 468, -- Feathermoon, Auberdine
					["0.31:0.69:0.43:0.25:0.42:0.16"] = 552, -- Feathermoon, Auberdine, Rut'theran Village
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.55"] = 429, -- Feathermoon, Thalanaar, Theramore, Ratchet
					["0.31:0.69:0.40:0.51:0.64:0.67"] = 535, -- Feathermoon, Nijel's Point, Theramore
					["0.31:0.69:0.40:0.51:0.64:0.67:0.60:0.81"] = 690, -- Feathermoon, Nijel's Point, Theramore, Gadgetzan
					["0.31:0.69:0.42:0.79:0.60:0.81:0.64:0.67"] = 491, -- Feathermoon, Cenarion Hold, Gadgetzan, Theramore
					["0.31:0.69:0.48:0.70:0.60:0.81:0.50:0.76"] = 430, -- Feathermoon, Thalanaar, Gadgetzan, Marshal's Refuge
					["0.31:0.69:0.43:0.25:0.39:0.40"] = 649, -- Feathermoon, Auberdine, Stonetalon Peak
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 724, -- Feathermoon, Thalanaar, Theramore, Talrendis Point, Everlook
					["0.31:0.69:0.43:0.25:0.55:0.21:0.65:0.23"] = 737, -- Feathermoon, Auberdine, Moonglade, Everlook
					["0.31:0.69:0.48:0.70:0.64:0.67"] = 314, -- Mondfederfeste, Thalanaar, Theramore
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 601, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 656, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.31:0.69:0.48:0.70:0.60:0.81:0.61:0.55"] = 570, -- Feathermoon, Thalanaar, Gadgetzan, Ratchet
					["0.31:0.69:0.40:0.51:0.64:0.67:0.58:0.70"] = 598, -- Feathermoon, Nijel's Point, Theramore, Mudsprocket
					["0.31:0.69:0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35"] = 680, -- Feathermoon, Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar, Emerald Sanctuary
					["0.31:0.69:0.42:0.79:0.60:0.81"] = 338, -- Feathermoon, Cenarion Hold, Gadgetzan
					["0.31:0.69:0.40:0.51:0.39:0.40:0.46:0.40:0.61:0.55"] = 694, -- Feathermoon, Nijel's Point, Stonetalon Peak, Astranaar, Ratchet
					["0.31:0.69:0.40:0.51:0.64:0.67:0.61:0.55"] = 649, -- Feathermoon, Nijel's Point, Theramore, Ratchet
					["0.31:0.69:0.40:0.51:0.64:0.67:0.60:0.81:0.50:0.76"] = 794, -- Feathermoon, Nijel's Point, Theramore, Gadgetzan, Marshal's Refuge
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35"] = 701, -- Feathermoon, Thalanaar, Theramore, Ratchet, Astranaar, Emerald Sanctuary
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 623, -- Feathermoon, Thalanaar, Theramore, Ratchet, Astranaar
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.58:0.39"] = 757, -- Feathermoon, Thalanaar, Theramore, Ratchet, Astranaar, Forest Song 
					["0.31:0.69:0.48:0.70:0.64:0.67:0.61:0.40"] = 546, -- Feathermoon, Thalanaar, Theramore, Talrendis Point
					["0.31:0.69:0.43:0.25:0.53:0.26:0.65:0.23"] = 746, -- Feathermoon, Auberdine, Talonbranch Glade, Everlook
					["0.31:0.69:0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 1167, -- Feathermoon, Auberdine, Theramore, Gadgetzan, Marshal's Refuge

					-- Alliance: Forest Song (Ashenvale)
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 602, -- Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar, Feathermoon
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 596, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 503, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 424, -- Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 324, -- Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 261, -- Forest Song, Talrendis Point, Ratchet, Theramore
					["0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 400, -- Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.58:0.39:0.61:0.40:0.61:0.55"] = 163, -- Forest Song, Talrendis Point, Ratchet
					["0.58:0.39:0.46:0.40:0.39:0.40:0.40:0.51"] = 421, -- Forest Song, Astranaar, Stonetalon Peak, Nijel's Point
					["0.58:0.39:0.46:0.40:0.39:0.40"] = 295, -- Forest Song, Astranaar, Stonetalon Peak
					["0.58:0.39:0.46:0.40"] = 141, -- Forest Song, Astranaar
					["0.58:0.39:0.50:0.35"] = 111, -- Forest Song, Emerald Sanctuary
					["0.58:0.39:0.61:0.40"] = 28, -- Forest Song, Talrendis Point
					["0.58:0.39:0.61:0.40:0.65:0.23"] = 207, -- Forest Song, Talrendis Point, Everlook
					["0.58:0.39:0.50:0.35:0.53:0.26"] = 238, -- Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.58:0.39:0.50:0.35:0.53:0.26:0.55:0.21"] = 297, -- Forest Song, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.58:0.39:0.46:0.40:0.43:0.25"] = 290, -- Forest Song, Astranaar, Auberdine
					["0.58:0.39:0.46:0.40:0.43:0.25:0.42:0.16"] = 374, -- Forest Song, Astranaar, Auberdine, Rut'theran Village
					["0.58:0.39:0.46:0.40:0.61:0.55:0.64:0.67"] = 436, -- Forest Song, Astranaar, Ratchet, Theramore
					["0.58:0.39:0.46:0.40:0.43:0.25:0.55:0.21"] = 441, -- Forest Song, Astranaar, Auberdine, Moonglade
					["0.58:0.39:0.46:0.40:0.61:0.55"] = 335, -- Forest Song, Astranaar, Ratchet
					["0.58:0.39:0.46:0.40:0.43:0.25:0.31:0.69"] = 762, -- Forest Song, Astranaar, Auberdine, Feathermoon
					["0.58:0.39:0.50:0.35:0.53:0.26:0.65:0.23"] = 328, -- Forest Song, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.58:0.39:0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69:0.48:0.70"] = 807, -- Forest Song, Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon, Thalanaar
					["0.58:0.39:0.61:0.40:0.43:0.25:0.39:0.40"] = 510, -- Forest Song, Talrendis Point, Auberdine, Stonetalon Peak
					["0.58:0.39:0.46:0.40:0.61:0.55:0.60:0.81"] = 576, -- Forest Song, Astranaar, Ratchet, Gadgetzan
					["0.58:0.39:0.46:0.40:0.64:0.67"] = 529, -- Forest Song, Astranaar, Theramore
					["0.58:0.39:0.46:0.40:0.64:0.67:0.48:0.70"] = 692, -- Forest Song, Astranaar, Theramore, Thalanaar
					["0.58:0.39:0.50:0.35:0.53:0.26:0.43:0.25:0.64:0.67:0.60:0.81"] = 1002, -- Forest Song, Emerald Sanctuary, Talonbranch Glade, Auberdine, Theramore, Gadgetzan

					-- Alliance: Gadgetzan (Tanaris)
					["0.60:0.81:0.48:0.70:0.31:0.69"] = 354, -- Gadgetzan, Thalanaar, Feathermoon
					["0.60:0.81:0.42:0.79"] = 197, -- Gadgetzan, Cenarion Hold
					["0.60:0.81:0.50:0.76"] = 104, -- Gadgetzan, Marshal's Refuge
					["0.60:0.81:0.48:0.70"] = 177, -- Gadgetzan, Thalanaar
					["0.60:0.81:0.64:0.67:0.58:0.70"] = 212, -- Gadgetzan, Theramore, Mudsprocket
					["0.60:0.81:0.64:0.67"] = 154, -- Gadgetzan, Theramore
					["0.60:0.81:0.61:0.55"] = 247, -- Gadgetzan, Ratchet
					["0.60:0.81:0.64:0.67:0.40:0.51"] = 481, -- Gadgetzan, Theramore, Nijel's Point
					["0.60:0.81:0.61:0.55:0.46:0.40:0.39:0.40"] = 596, -- Gadgetzan, Ratchet, Astranaar, Stonetalon Peak
					["0.60:0.81:0.61:0.55:0.46:0.40"] = 442, -- Gadgetzan, Ratchet, Astranaar
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 506, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 400, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.60:0.81:0.61:0.55:0.61:0.40"] = 374, -- Gadgetzan, Ratchet, Talrendis Point
					["0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 553, -- Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 634, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 663, -- Gadgetzan, Ratchet, Talrendis Point, Everlook, Moonglade
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25"] = 591, -- Gadgetzan, Ratchet, Astranaar, Auberdine
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 675, -- Gadgetzan, Ratchet, Astranaar, Auberdine, Rut'theran Village
					["0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26"] = 648, -- Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 738, -- Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35"] = 521, -- Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary
					["0.60:0.81:0.64:0.67:0.61:0.40"] = 387, -- Gadgetzan, Theramore, Talrendis Point
					["0.60:0.81:0.64:0.67:0.43:0.25:0.42:0.16"] = 672, -- Gadgetzan, Theramore, Auberdine, Rut'theran Village
					["0.60:0.81:0.64:0.67:0.46:0.40:0.50:0.35"] = 596, -- Gadgetzan, Theramore, Astranaar, Emerald Sanctuary
					["0.60:0.81:0.64:0.67:0.46:0.40"] = 518, -- Gadgetzan, Theramore, Astranaar
					["0.60:0.81:0.61:0.55:0.46:0.40:0.58:0.39"] = 576, -- Gadgetzan, Ratchet, Astranaar, Forest Song
					["0.60:0.81:0.64:0.67:0.46:0.40:0.39:0.40"] = 672, -- Gadgetzan, Theramore, Astranaar, Stonetalon Peak
					["0.60:0.81:0.64:0.67:0.40:0.51:0.31:0.69"] = 712, -- Gadgetzan, Theramore, Nijel's Point, Feathermoon
					["0.60:0.81:0.64:0.67:0.43:0.25"] = 588, -- Gadgetzan, Theramore, Auberdine
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.53:0.26"] = 780, -- Gadgetzan, Ratchet, Astranaar, Auberdine, Talonbranch Glade
					["0.60:0.81:0.64:0.67:0.46:0.40:0.58:0.39"] = 652, -- Gadgetzan, Theramore, Astranaar, Forest Song
					["0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26:0.55:0.21"] = 692, -- Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.60:0.81:0.48:0.70:0.31:0.69:0.40:0.51"] = 581, -- Gadgetzan, Thalanaar, Feathermoon, Nijel's Point
					["0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.55:0.21"] = 741, -- Gadgetzan, Ratchet, Astranaar, Auberdine, Moonglade
					["0.60:0.81:0.48:0.70:0.58:0.70"] = 263, -- Gadgetzan, Thalanaar, Mudsprocket
					["0.60:0.81:0.64:0.67:0.43:0.25:0.53:0.26:0.50:0.35"] = 880, -- Gadgetzan, Theramore, Auberdine, Talonbranch Glade, Emerald Sanctuary
					["0.60:0.81:0.61:0.55:0.61:0.40:0.53:0.26"] = 657, -- Gadgetzan, Ratchet, Talrendis Point, Talonbranch Glade

					-- Alliance: Marshal's Refuge (Un'Goro Crater)
					["0.50:0.76:0.42:0.79:0.31:0.69"] = 258, -- Marshal's Refuge, Cenarion Hold, Feathermoon
					["0.50:0.76:0.42:0.79"] = 94, -- Marshal's Refuge, Cenarion Hold
					["0.50:0.76:0.60:0.81:0.48:0.70"] = 281, -- Marshal's Refuge, Gadgetzan, Thalanaar
					["0.50:0.76:0.60:0.81:0.64:0.67:0.58:0.70"] = 315, -- Marshal's Refuge, Gadgetzan, Theramore, Mudsprocket
					["0.50:0.76:0.60:0.81:0.64:0.67"] = 257, -- Marshal's Refuge, Gadgetzan, Theramore
					["0.50:0.76:0.60:0.81"] = 104, -- Marshal's Refuge, Gadgetzan (Liam Walt reported 111 but my own test reports 104)
					["0.50:0.76:0.60:0.81:0.61:0.55"] = 351, -- Marshal's Refuge, Gadgetzan, Ratchet
					["0.50:0.76:0.42:0.79:0.31:0.69:0.40:0.51"] = 485, -- Marshal's Refuge, Cenarion Hold, Feathermoon, Nijel's Point
					["0.50:0.76:0.42:0.79:0.31:0.69:0.40:0.51:0.39:0.40"] = 605, -- Marshal's Refuge, Cenarion Hold, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40"] = 545, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 609, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39"] = 503, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40"] = 477, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23"] = 656, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Everlook
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 765, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Everlook, Moonglade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 737, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25"] = 694, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Auberdine
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 778, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Auberdine, Rut'theran Village
					["0.50:0.76:0.60:0.81:0.48:0.70:0.31:0.69"] = 458, -- Marshal's Refuge, Gadgetzan, Thalanaar, Feathermoon
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.58:0.39"] = 680, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Forest Song
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35"] = 624, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary
					["0.50:0.76:0.60:0.81:0.64:0.67:0.40:0.51:0.31:0.69"] = 815, -- Marshal's Refuge, Gadgetzan, Theramore, Nijel's Point, Feathermoon
					["0.50:0.76:0.60:0.81:0.64:0.67:0.43:0.25:0.42:0.16"] = 776, -- Marshal's Refuge, Gadgetzan, Theramore, Auberdine, Rut'theran Village
					["0.50:0.76:0.60:0.81:0.61:0.55:0.61:0.40:0.53:0.26"] = 760, -- Marshal's Refuge, Gadgetzan, Ratchet, Talrendis Point, Talonbranch Glade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26"] = 752, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 841, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.50:0.76:0.60:0.81:0.64:0.67:0.43:0.25"] = 691, -- Marshal's Refuge, Gadgetzan, Theramore, Auberdine 
					["0.50:0.76:0.60:0.81:0.61:0.55:0.46:0.40:0.43:0.25:0.55:0.21:0.65:0.23"] = 963, -- Marshal's Refuge, Gadgetzan, Ratchet, Astranaar, Auberdine, Moonglade, Everlook
					["0.50:0.76:0.60:0.81:0.64:0.67:0.46:0.40"] = 621, -- Marshal's Refuge, Gadgetzan, Theramore, Astranaar
					["0.50:0.76:0.60:0.81:0.64:0.67:0.40:0.51"] = 584, -- Marshal's Refuge, Gadgetzan, Theramore, Nijel's Point

					-- Alliance: Moonglade (Moonglade)
					["0.55:0.21:0.43:0.25:0.31:0.69"] = 614, -- Moonglade, Auberdine, Feathermoon
					["0.55:0.21:0.43:0.25:0.31:0.69:0.42:0.79"] = 764, -- Moonglade, Auberdine, Feathermoon, Cenarion Hold
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 755, -- Moonglade, Everlook, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81"] = 651, -- Moonglade, Everlook, Talrendis Point, Ratchet, Gadgetzan
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 576, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67"] = 513, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 675, -- Moonglade, Everlook, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.55:0.21:0.65:0.23:0.61:0.40:0.61:0.55"] = 415, -- Moonglade, Everlook, Talrendis Point, Ratchet
					["0.55:0.21:0.43:0.25:0.40:0.51"] = 433, -- Moonglade, Auberdine, Nijel's Point
					["0.55:0.21:0.43:0.25:0.39:0.40"] = 323, -- Moonglade, Auberdine, Stonetalon Peak
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40"] = 253, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.55:0.21:0.53:0.26:0.50:0.35"] = 174, -- Moonglade, Talonbranch Glade, Emerald Sanctuary
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39"] = 277, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song
					["0.55:0.21:0.65:0.23:0.61:0.40"] = 281, -- Moonglade, Everlook, Talrendis Point
					["0.55:0.21:0.65:0.23"] = 119, -- Moonglade, Everlook
					["0.55:0.21:0.53:0.26"] = 62, -- Moonglade, Talonbranch Glade
					["0.55:0.21:0.43:0.25"] = 142, -- Moonglade, Auberdine
					["0.55:0.21:0.43:0.25:0.42:0.16"] = 226, -- Moonglade, Auberdine, Rut'theran Village
					["0.55:0.21:0.43:0.25:0.64:0.67:0.60:0.81"] = 738, -- Moonglade, Auberdine, Theramore, Gadgetzan
					["0.55:0.21:0.43:0.25:0.64:0.67"] = 585, -- Moonglade, Auberdine, Theramore
					["0.55:0.21:0.43:0.25:0.46:0.40:0.58:0.39"] = 443, -- Moonglade, Auberdine, Astranaar, Forest Song
					["0.55:0.21:0.43:0.25:0.46:0.40:0.61:0.55"] = 503, -- Mondlichtung, Auberdine, Astranaar, Ratschet
					["0.55:0.21:0.43:0.25:0.46:0.40"] = 310, -- Moonglade, Auberdine, Astranaar
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 776, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55"] = 447, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 710, -- Reflet-de-Lune, Clairière de Griffebranche, Sanctuaire d'émeraude, Astranaar, Cabestan, Theramore, Thalanaar
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 535, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40"] = 302, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81"] = 689, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan
					["0.55:0.21:0.43:0.25:0.46:0.40:0.50:0.35"] = 388, -- Moonglade, Auberdine, Astranaar, Emerald Sanctuary
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67"] = 548, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Theramore
					["0.55:0.21:0.43:0.25:0.64:0.67:0.48:0.70"] = 744, -- Moonglade, Auberdine, Theramore, Thalanaar
					["0.55:0.21:0.43:0.25:0.64:0.67:0.58:0.70"] = 644, -- Moonglade, Auberdine, Theramore, Mudsprocket
					["0.55:0.21:0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 842, -- Moonglade, Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.55:0.21:0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 792, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.55:0.21:0.43:0.25:0.64:0.67:0.61:0.55"] = 693, -- Moonglade, Auberdine, Theramore, Ratchet
					["0.55:0.21:0.65:0.23:0.61:0.40:0.64:0.67:0.60:0.81"] = 675, -- Moonglade, Everlook, Talrendis Point, Theramore, Gadgetzan
					["0.55:0.21:0.43:0.25:0.61:0.40"] = 442, -- Moonglade, Auberdine, Talrendis Point
					["0.55:0.21:0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55"] = 436, -- Moonglade, Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet
					["0.55:0.21:0.43:0.25:0.31:0.69:0.48:0.70"] = 769, -- Moonglade, Auberdine, Feathermoon, Thalanaar

					-- Alliance: Mudsprocket (Dustwallow Marsh)
					["0.58:0.70:0.48:0.70:0.31:0.69"] = 283, -- Mudsprocket, Thalanaar, Feathermoon
					["0.58:0.70:0.64:0.67:0.60:0.81:0.42:0.79"] = 405, -- Mudsprocket, Theramore, Gadgetzan, Cenarion Hold
					["0.58:0.70:0.64:0.67:0.60:0.81:0.50:0.76"] = 312, -- Mudsprocket, Theramore, Gadgetzan, Marshal's Refuge
					["0.58:0.70:0.48:0.70"] = 105, -- Mudsprocket, Thalanaar
					["0.58:0.70:0.64:0.67"] = 52, -- Mudsprocket, Theramore
					["0.58:0.70:0.64:0.67:0.60:0.81"] = 209, -- Mudsprocket, Theramore, Gadgetzan
					["0.58:0.70:0.64:0.67:0.61:0.55"] = 167, -- Mudsprocket, Theramore, Ratchet
					["0.58:0.70:0.64:0.67:0.40:0.51"] = 386, -- Mudsprocket, Theramore, Nijel's Point
					["0.58:0.70:0.64:0.67:0.40:0.51:0.39:0.40"] = 505, -- Mudsprocket, Theramore, Nijel's Point, Stonetalon Peak
					["0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 361, -- Mudsprocket, Theramore, Ratchet, Astranaar
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 416, -- Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 310, -- Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.58:0.70:0.64:0.67:0.61:0.40"] = 285, -- Mudsprocket, Theramore, Talrendis Point
					["0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 463, -- Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 544, -- Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 573, -- Mudsprocket, Theramore, Talrendis Point, Everlook, Moonglade
					["0.58:0.70:0.64:0.67:0.43:0.25"] = 492, -- Mudsprocket, Theramore, Auberdine
					["0.58:0.70:0.64:0.67:0.43:0.25:0.42:0.16"] = 576, -- Mudsprocket, Theramore, Auberdine, Rut'theran Village
					["0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.58:0.39"] = 496, -- Mudsprocket, Theramore, Ratchet, Astranaar, Forest Song
					["0.58:0.70:0.64:0.67:0.40:0.51:0.31:0.69"] = 618, -- Mudsprocket, Theramore, Nijel's Point, Feathermoon
					["0.58:0.70:0.48:0.70:0.60:0.81"] = 277, -- Bourbe-à-brac, Thalanaar, Gadgetzan
					["0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.39:0.40"] = 515, -- Bourbe-à-brac, Theramore, Ratchet, Astranaar, Stonetalon Peak
					["0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35"] = 440, -- Mudsprocket, Theramore, Ratchet, Astranaar, Emerald Sanctuary

					-- Alliance: Nijel's Point (Desolace)
					["0.40:0.51:0.31:0.69"] = 232, -- Nijel's Point, Feathermoon
					["0.40:0.51:0.31:0.69:0.42:0.79"] = 381, -- Nijel's Point, Feathermoon, Cenarion Hold
					["0.40:0.51:0.31:0.69:0.42:0.79:0.50:0.76"] = 470, -- Nijel's Point, Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.40:0.51:0.31:0.69:0.48:0.70"] = 387, -- Nijel's Point, Feathermoon, Thalanaar
					["0.40:0.51:0.64:0.67:0.58:0.70"] = 370, -- Nijel's Point, Theramore, Mudsprocket
					["0.40:0.51:0.64:0.67"] = 308, -- Nijel's Point, Theramore
					["0.40:0.51:0.64:0.67:0.60:0.81"] = 464, -- Nijel's Point, Theramore, Gadgetzan
					["0.40:0.51:0.64:0.67:0.61:0.55"] = 422, -- Nijel's Point, Theramore, Ratchet
					["0.40:0.51:0.39:0.40:0.46:0.40:0.61:0.40"] = 421, -- Nijel's Point, Stonetalon Peak, Astranaar, Talrendis Point
					["0.40:0.51:0.39:0.40:0.46:0.40:0.58:0.39"] = 408, -- Nijel's Point, Stonetalon Peak, Astranaar, Forest Song
					["0.40:0.51:0.39:0.40:0.46:0.40:0.50:0.35"] = 351, -- Nijel's Point, Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.40:0.51:0.39:0.40:0.46:0.40"] = 274, -- Nijel's Point, Stonetalon Peak, Astranaar
					["0.40:0.51:0.39:0.40"] = 120, -- Nijel's Point, Stonetalon Peak
					["0.40:0.51:0.43:0.25"] = 282, -- Nijel's Point, Auberdine
					["0.40:0.51:0.43:0.25:0.42:0.16"] = 367, -- Nijel's Point, Auberdine, Rut'theran Village
					["0.40:0.51:0.43:0.25:0.53:0.26"] = 471, -- Nijel's Point, Auberdine, Talonbranch Glade
					["0.40:0.51:0.43:0.25:0.55:0.21"] = 433, -- Nijel's Point, Auberdine, Moonglade
					["0.40:0.51:0.43:0.25:0.55:0.21:0.65:0.23"] = 552, -- Nijel's Point, Auberdine, Moonglade, Everlook
					["0.40:0.51:0.43:0.25:0.46:0.40"] = 449, -- Nijel's Point, Auberdine, Astranaar
					["0.40:0.51:0.64:0.67:0.48:0.70"] = 471, -- Nijel's Point, Theramore, Thalanaar
					["0.40:0.51:0.39:0.40:0.46:0.40:0.61:0.55"] = 466, -- Nijel's Point, Stonetalon Peak, Astranaar, Ratchet
					["0.40:0.51:0.64:0.67:0.60:0.81:0.50:0.76"] = 568, -- Nijel's Point, Theramore, Gadgetzan, Marshal's Refuge
					["0.40:0.51:0.43:0.25:0.46:0.40:0.50:0.35"] = 528, -- Nijel's Point, Auberdine, Astranaar, Emerald Sanctuary
					["0.40:0.51:0.43:0.25:0.53:0.26:0.65:0.23"] = 560, -- Nijel's Point, Auberdine, Talonbranch Glade, Everlook
					["0.40:0.51:0.31:0.69:0.48:0.70:0.60:0.81"] = 557, -- Nijel's Point, Feathermoon, Thalanaar, Gadgetzan
					["0.40:0.51:0.39:0.40:0.46:0.40:0.61:0.55:0.60:0.81"] = 708, -- Nijel's Point, Stonetalon Peak, Astranaar, Ratchet, Gadgetzan
					["0.40:0.51:0.43:0.25:0.46:0.40:0.61:0.55:0.60:0.81"] = 884, -- Nijel's Point, Auberdine, Astranaar, Ratchet, Gadgetzan

					-- Alliance: Ratchet (The Barrens)
					["0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 446, -- Ratchet, Theramore, Thalanaar, Feathermoon
					["0.61:0.55:0.60:0.81:0.42:0.79"] = 442, -- Ratchet, Gadgetzan, Cenarion Hold
					["0.61:0.55:0.60:0.81:0.50:0.76"] = 349, -- Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.55:0.64:0.67:0.48:0.70"] = 268, -- Ratchet, Theramore, Thalanaar
					["0.61:0.55:0.64:0.67:0.58:0.70"] = 168, -- Ratchet, Theramore, Mudsprocket
					["0.61:0.55:0.64:0.67"] = 106, -- Ratchet, Theramore
					["0.61:0.55:0.60:0.81"] = 245, -- Ratchet, Gadgetzan
					["0.61:0.55:0.61:0.40"] = 130, -- Ratchet, Talrendis Point
					["0.61:0.55:0.61:0.40:0.58:0.39"] = 155, -- Ratchet, Talrendis Point, Forest Song
					["0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35"] = 262, -- Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.61:0.55:0.46:0.40"] = 197, -- Ratchet, Astranaar
					["0.61:0.55:0.46:0.40:0.39:0.40"] = 352, -- Ratchet, Astranaar, Stonetalon Peak
					["0.61:0.55:0.64:0.67:0.40:0.51"] = 439, -- Ratchet, Theramore, Nijel's Point
					["0.61:0.55:0.46:0.40:0.43:0.25:0.42:0.16"] = 430, -- Ratchet, Astranaar, Auberdine, Rut'theran Village
					["0.61:0.55:0.46:0.40:0.43:0.25"] = 345, -- Ratchet, Astranaar, Auberdine
					["0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 389, -- Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.61:0.55:0.61:0.40:0.65:0.23:0.55:0.21"] = 420, -- Ratchet, Talrendis Point, Everlook, Moonglade
					["0.61:0.55:0.61:0.40:0.65:0.23"] = 310, -- Ratchet, Talrendis Point, Everlook
					["0.61:0.55:0.46:0.40:0.50:0.35"] = 276, -- Ratchet, Astranaar, Emerald Sanctuary
					["0.61:0.55:0.46:0.40:0.58:0.39"] = 332, -- Ratchet, Astranaar, Forest Song
					["0.61:0.55:0.64:0.67:0.43:0.25:0.42:0.16"] = 629, -- Ratchet, Theramore, Auberdine, Rut'theran Village
					["0.61:0.55:0.46:0.40:0.39:0.40:0.40:0.51"] = 477, -- Ratchet, Astranaar, Stonetalon Peak, Nijel's Point
					["0.61:0.55:0.61:0.40:0.43:0.25:0.42:0.16"] = 515, -- Ratchet, Talrendis Point, Auberdine, Rut'theran Village
					["0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26"] = 403, -- Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.61:0.55:0.60:0.81:0.48:0.70"] = 421, -- Ratchet, Gadgetzan, Thalanaar
					["0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 493, -- Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.61:0.55:0.64:0.67:0.43:0.25"] = 545, -- Ratchet, Theramore, Auberdine
					["0.61:0.55:0.46:0.40:0.43:0.25:0.55:0.21:0.65:0.23"] = 615, -- Ratchet, Astranaar, Auberdine, Moonglade, Everlook
					["0.61:0.55:0.46:0.40:0.43:0.25:0.53:0.26"] = 535, -- Ratchet, Astranaar, Auberdine, Talonbranch Glade
					["0.61:0.55:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26:0.55:0.21"] = 449, -- Ratchet, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade, Moonglade
					["0.61:0.55:0.46:0.40:0.43:0.25:0.40:0.51"] = 636, -- Ratchet, Astranaar, Auberdine, Nijel's Point
					["0.61:0.55:0.64:0.67:0.40:0.51:0.31:0.69"] = 671, -- Ratchet, Theramore, Nijel's Point, Feathermoon
					["0.61:0.55:0.60:0.81:0.48:0.70:0.31:0.69:0.40:0.51"] = 825, -- Ratchet, Gadgetzan, Thalanaar, Feathermoon, Nijel's Point

					-- Alliance: Rut'theran Village (Teldrassil)
					["0.42:0.16:0.43:0.25:0.31:0.69"] = 557, -- Rut'theran Village, Auberdine, Feathermoon
					["0.42:0.16:0.43:0.25:0.31:0.69:0.42:0.79"] = 708, -- Rut'theran Village, Auberdine, Feathermoon, Cenarion Hold
					["0.42:0.16:0.43:0.25:0.64:0.67:0.60:0.81:0.50:0.76"] = 785, -- Rut'theran Village, Auberdine, Theramore, Gadgetzan, Marshal's Refuge
					["0.42:0.16:0.43:0.25:0.64:0.67:0.48:0.70"] = 687, -- Rut'theran Village, Auberdine, Theramore, Thalanaar
					["0.42:0.16:0.43:0.25:0.64:0.67:0.60:0.81"] = 681, -- Rut'theran Village, Auberdine, Theramore, Gadgetzan
					["0.42:0.16:0.43:0.25:0.64:0.67:0.58:0.70"] = 587, -- Rut'theran Village, Auberdine, Theramore, Mudsprocket
					["0.42:0.16:0.43:0.25:0.64:0.67"] = 528, -- Rut'theran Village, Auberdine, Theramore
					["0.42:0.16:0.43:0.25:0.46:0.40:0.61:0.55"] = 446, -- Rut'theran Village, Auberdine, Astranaar, Ratchet
					["0.42:0.16:0.43:0.25:0.40:0.51"] = 376, -- Rut'theran Village, Auberdine, Nijel's Point
					["0.42:0.16:0.43:0.25:0.61:0.40"] = 385, -- Rut'theran Village, Auberdine, Talrendis Point
					["0.42:0.16:0.43:0.25:0.46:0.40:0.58:0.39"] = 387, -- Rut'theran Village, Auberdine, Astranaar, Forest Song
					["0.42:0.16:0.43:0.25:0.46:0.40:0.50:0.35"] = 331, -- Rut'theran Village, Auberdine, Astranaar, Emerald Sanctuary
					["0.42:0.16:0.43:0.25:0.46:0.40"] = 252, -- Rut'theran Village, Auberdine, Astranaar
					["0.42:0.16:0.43:0.25:0.39:0.40"] = 267, -- Rut'theran Village, Auberdine, Stonetalon Peak
					["0.42:0.16:0.43:0.25"] = 86, -- Rut'theran Village, Auberdine
					["0.42:0.16:0.43:0.25:0.53:0.26"] = 274, -- Rut'theran Village, Auberdine, Talonbranch Glade
					["0.42:0.16:0.43:0.25:0.55:0.21"] = 236, -- Rut'theran Village, Auberdine, Moonglade
					["0.42:0.16:0.43:0.25:0.55:0.21:0.65:0.23"] = 355, -- Rut'theran Village, Auberdine, Moonglade, Everlook
					["0.42:0.16:0.43:0.25:0.53:0.26:0.65:0.23"] = 363, -- Rut'theran Village, Auberdine, Talonbranch Glade, Everlook
					["0.42:0.16:0.43:0.25:0.61:0.40:0.65:0.23"] = 564, -- Rut'theran Village, Auberdine, Talrendis Point, Everlook
					["0.42:0.16:0.43:0.25:0.64:0.67:0.61:0.55"] = 637, -- Rut'theran Village, Auberdine, Theramore, Ratchet
					["0.42:0.16:0.43:0.25:0.64:0.67:0.60:0.81:0.42:0.79"] = 878, -- Rut'theran Village, Auberdine, Theramore, Gadgetzan, Cenarion Hold
					["0.42:0.16:0.43:0.25:0.61:0.40:0.58:0.39"] = 410, -- Rut'theran Village, Auberdine, Talrendis Point, Forest Song
					["0.42:0.16:0.43:0.25:0.53:0.26:0.50:0.35"] = 378, -- Rut'theran Village, Auberdine, Talonbranch Glade, Emerald Sanctuary
					["0.42:0.16:0.43:0.25:0.46:0.40:0.61:0.55:0.60:0.81"] = 687, -- Rut'theran Village, Auberdine, Astranaar, Ratchet, Gadgetzan
					["0.42:0.16:0.43:0.25:0.31:0.69:0.48:0.70"] = 712, -- Rut'theran Village, Auberdine, Feathermoon, Thalanaar

					-- Alliance: Stonetalon Peak (Stonetalon Mountains)
					["0.39:0.40:0.40:0.51:0.31:0.69"] = 359, -- Stonetalon Peak, Nijel's Point, Feathermoon
					["0.39:0.40:0.40:0.51:0.31:0.69:0.42:0.79"] = 508, -- Stonetalon Peak, Nijel's Point, Feathermoon, Cenarion Hold
					["0.39:0.40:0.40:0.51:0.31:0.69:0.42:0.79:0.50:0.76"] = 596, -- Stonetalon Peak, Nijel's Point, Feathermoon, Cenarion Hold, Marshal's Refuge
					["0.39:0.40:0.40:0.51:0.31:0.69:0.48:0.70"] = 513, -- Stonetalon Peak, Nijel's Point, Feathermoon, Thalanaar
					["0.39:0.40:0.40:0.51:0.64:0.67:0.58:0.70"] = 497, -- Stonetalon Peak, Nijel's Point, Theramore, Mudsprocket
					["0.39:0.40:0.40:0.51:0.64:0.67"] = 434, -- Stonetalon Peak, Nijel's Point, Theramore
					["0.39:0.40:0.40:0.51:0.64:0.67:0.60:0.81"] = 591, -- Stonetalon Peak, Nijel's Point, Theramore, Gadgetzan
					["0.39:0.40:0.46:0.40:0.61:0.55"] = 348, -- Stonetalon Peak, Astranaar, Ratchet
					["0.39:0.40:0.40:0.51"] = 126, -- Stonetalon Peak, Nijel's Point
					["0.39:0.40:0.46:0.40"] = 154, -- Stonetalon Peak, Astranaar
					["0.39:0.40:0.46:0.40:0.50:0.35"] = 234, -- Stonetalon Peak, Astranaar, Emerald Sanctuary
					["0.39:0.40:0.46:0.40:0.58:0.39"] = 288, -- Stonetalon Peak, Astranaar, Forest Song
					["0.39:0.40:0.46:0.40:0.61:0.40"] = 303, -- Stonetalon Peak, Astranaar, Talrendis Point
					["0.39:0.40:0.43:0.25:0.55:0.21:0.65:0.23"] = 447, -- Stonetalon Peak, Auberdine, Moonglade, Everlook
					["0.39:0.40:0.46:0.40:0.50:0.35:0.53:0.26"] = 361, -- Stonetalon Peak, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.39:0.40:0.43:0.25:0.55:0.21"] = 328, -- Stonetalon Peak, Auberdine, Moonglade
					["0.39:0.40:0.43:0.25"] = 177, -- Stonetalon Peak, Auberdine
					["0.39:0.40:0.43:0.25:0.42:0.16"] = 261, -- Stonetalon Peak, Auberdine, Rut'theran Village
					["0.39:0.40:0.40:0.51:0.64:0.67:0.61:0.55"] = 549, -- Stonetalon Peak, Nijel's Point, Theramore, Ratchet
					["0.39:0.40:0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 612, -- Stonetalon Peak, Astranaar, Ratchet, Theramore, Thalanaar
					["0.39:0.40:0.43:0.25:0.53:0.26"] = 367, -- Stonetalon Peak, Auberdine, Talonbranch Glade

					-- Alliance: Talonbranch Glade (Felwood)
					["0.53:0.26:0.43:0.25:0.31:0.69"] = 660, -- Talonbranch Glade, Auberdine, Feathermoon
					["0.53:0.26:0.43:0.25:0.31:0.69:0.42:0.79"] = 810, -- Talonbranch Glade, Auberdine, Feathermoon, Cenarion Hold
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 731, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 652, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 552, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.64:0.67"] = 489, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Theramore
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55:0.60:0.81"] = 627, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet, Gadgetzan
					["0.53:0.26:0.50:0.35:0.58:0.39:0.61:0.40:0.61:0.55"] = 391, -- Talonbranch Glade, Emerald Sanctuary, Forest Song, Talrendis Point, Ratchet
					["0.53:0.26:0.43:0.25:0.40:0.51"] = 478, -- Talonbranch Glade, Auberdine, Nijel's Point
					["0.53:0.26:0.50:0.35:0.46:0.40:0.39:0.40"] = 363, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Stonetalon Peak
					["0.53:0.26:0.50:0.35:0.46:0.40"] = 209, -- Talonbranch Glade, Emerald Sanctuary, Astranaar
					["0.53:0.26:0.50:0.35"] = 129, -- Talonbranch Glade, Emerald Sanctuary
					["0.53:0.26:0.50:0.35:0.58:0.39"] = 232, -- Talonbranch Glade, Emerald Sanctuary, Forest Song
					["0.53:0.26:0.61:0.40"] = 283, -- Talonbranch Glade, Talrendis Point
					["0.53:0.26:0.65:0.23"] = 107, -- Talonbranch Glade, Everlook
					["0.53:0.26:0.55:0.21"] = 67, -- Talonbranch Glade, Moonglade
					["0.53:0.26:0.43:0.25:0.42:0.16"] = 272, -- Talonbranch Glade, Auberdine, Rut'theran Village
					["0.53:0.26:0.43:0.25"] = 188, -- Talonbranch Glade, Auberdine
					["0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 747, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan, Marshal's Refuge
					["0.53:0.26:0.43:0.25:0.64:0.67:0.60:0.81"] = 783, -- Talonbranch Glade, Auberdine, Theramore, Gadgetzan
					["0.53:0.26:0.43:0.25:0.46:0.40"] = 356, -- Talonbranch Glade, Auberdine, Astranaar
					["0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55"] = 402, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet
					["0.53:0.26:0.43:0.25:0.39:0.40"] = 369, -- Talonbranch Glade, Auberdine, Stonetalon Peak
					["0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.60:0.81"] = 643, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Gadgetzan
					["0.53:0.26:0.61:0.40:0.58:0.39"] = 308, -- Talonbranch Glade, Talrendis Point, Forest Song
					["0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67"] = 502, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Theramore
					["0.53:0.26:0.50:0.35:0.46:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 665, -- Talonbranch Glade, Emerald Sanctuary, Astranaar, Ratchet, Theramore, Thalanaar
					["0.53:0.26:0.65:0.23:0.61:0.40:0.61:0.55:0.60:0.81"] = 640, -- Talonbranch Glade, Everlook, Talrendis Point, Ratchet, Gadgetzan

					-- Alliance: Talrendis Point (Azshara)
					["0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70:0.31:0.69"] = 574, -- Talrendis Point, Ratchet, Theramore, Thalanaar, Feathermoon
					["0.61:0.40:0.61:0.55:0.60:0.81:0.42:0.79"] = 569, -- Talrendis Point, Ratchet, Gadgetzan, Cenarion Hold
					["0.61:0.40:0.61:0.55:0.60:0.81:0.50:0.76"] = 476, -- Talrendis Point, Ratchet, Gadgetzan, Marshal's Refuge
					["0.61:0.40:0.61:0.55:0.64:0.67:0.48:0.70"] = 397, -- Talrendis Point, Ratchet, Theramore, Thalanaar
					["0.61:0.40:0.61:0.55:0.64:0.67:0.58:0.70"] = 297, -- Talrendis Point, Ratchet, Theramore, Mudsprocket
					["0.61:0.40:0.64:0.67"] = 241, -- Talrendis Point, Theramore
					["0.61:0.40:0.61:0.55:0.60:0.81"] = 373, -- Talrendis Point, Ratchet, Gadgetzan
					["0.61:0.40:0.61:0.55"] = 135, -- Talrendis Point, Ratchet (Brian Villarreal suggested 129)
					["0.61:0.40:0.46:0.40:0.39:0.40:0.40:0.51"] = 431, -- Talrendis Point, Astranaar, Stonetalon Peak, Nijel's Point
					["0.61:0.40:0.46:0.40:0.39:0.40"] = 305, -- Talrendis Point, Astranaar, Stonetalon Peak
					["0.61:0.40:0.46:0.40"] = 153, -- Talrendis Point, Astranaar
					["0.61:0.40:0.58:0.39:0.50:0.35"] = 132, -- Talrendis Point, Forest Song, Emerald Sanctuary
					["0.61:0.40:0.58:0.39"] = 26, -- Talrendis Point, Forest Song
					["0.61:0.40:0.53:0.26"] = 284, -- Talrendis Point, Talonbranch Glade
					["0.61:0.40:0.65:0.23:0.55:0.21"] = 289, -- Talrendis Point, Everlook, Moonglade
					["0.61:0.40:0.65:0.23"] = 179, -- Talrendis Point, Everlook
					["0.61:0.40:0.46:0.40:0.43:0.25:0.42:0.16"] = 383, -- Talrendis Point, Astranaar, Auberdine, Rut'theran Village
					["0.61:0.40:0.43:0.25"] = 301, -- Talrendis Point, Auberdine
					["0.61:0.40:0.64:0.67:0.60:0.81"] = 397, -- Talrendis Point, Theramore, Gadgetzan
					["0.61:0.40:0.46:0.40:0.50:0.35"] = 229, -- Talrendis Point, Astranaar, Emerald Sanctuary
					["0.61:0.40:0.43:0.25:0.42:0.16"] = 386, -- Talrendis Point, Auberdine, Rut'theran Village
					["0.61:0.40:0.46:0.40:0.39:0.40:0.40:0.51:0.31:0.69"] = 662, -- Talrendis Point, Astranaar, Stonetalon Peak, Nijel's Point, Feathermoon
					["0.61:0.40:0.64:0.67:0.48:0.70:0.31:0.69"] = 581, -- Talrendis Point, Theramore, Thalanaar, Feathermoon

					-- Alliance: Thalanaar
					["0.48:0.70:0.31:0.69"] = 179, -- Thalanaar, Feathermoon
					["0.48:0.70:0.31:0.69:0.42:0.79"] = 329, -- Thalanaar, Feathermoon, Cenarion Hold
					["0.48:0.70:0.60:0.81:0.50:0.76"] = 274, -- Thalanaar, Gadgetzan, Marshal's Refuge
					["0.48:0.70:0.60:0.81"] = 171, -- Thalanaar, Gadgetzan
					["0.48:0.70:0.58:0.70"] = 86, -- Thalanaar, Mudsprocket
					["0.48:0.70:0.64:0.67"] = 159, -- Thalanaar, Theramore
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55"] = 253, -- Thalanaar, Mudsprocket, Theramore, Ratchet
					["0.48:0.70:0.31:0.69:0.40:0.51"] = 405, -- Thalanaar, Feathermoon, Nijel's Point
					["0.48:0.70:0.31:0.69:0.40:0.51:0.39:0.40"] = 524, -- Thalanaar, Feathermoon, Nijel's Point, Stonetalon Peak
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 447, -- Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 502, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39"] = 396, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40"] = 370, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23"] = 548, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 629, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 658, -- Thalanaar, Mudsprocket, Theramore, Talrendis Point, Everlook, Moonglade
					["0.48:0.70:0.58:0.70:0.64:0.67:0.43:0.25"] = 577, -- Thalanaar, Mudsprocket, Theramore, Auberdine
					["0.48:0.70:0.58:0.70:0.64:0.67:0.43:0.25:0.42:0.16"] = 661, -- Thalanaar, Mudsprocket, Theramore, Auberdine, Rut'theran Village
					["0.48:0.70:0.64:0.67:0.61:0.55"] = 275, -- Thalanaar, Theramore, Ratchet
					["0.48:0.70:0.64:0.67:0.46:0.40:0.39:0.40"] = 683, -- Thalanaar, Theramore, Astranaar, Stonetalon Peak
					["0.48:0.70:0.64:0.67:0.43:0.25"] = 599, -- Thalanaar, Theramore, Auberdine
					["0.48:0.70:0.64:0.67:0.43:0.25:0.42:0.16"] = 683, -- Thalanaar, Theramore, Auberdine, Rut'theran Village
					["0.48:0.70:0.64:0.67:0.40:0.51"] = 494, -- Thalanaar, Theramore, Nijel's Point
					["0.48:0.70:0.58:0.70:0.64:0.67:0.40:0.51"] = 472, -- Thalanaar, Mudsprocket, Theramore, Nijel's Point
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 742, -- Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.48:0.70:0.60:0.81:0.61:0.55"] = 416, -- Thalanaar, Gadgetzan, Ratchet
					["0.48:0.70:0.64:0.67:0.61:0.55:0.46:0.40"] = 469, -- Thalanaar, Theramore, Cabestan, Astranaar
					["0.48:0.70:0.31:0.69:0.43:0.25"] = 646, -- Thalanaar, Feathermoon, Auberdine
					["0.48:0.70:0.58:0.70:0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35"] = 526, -- Thalanaar, Mudsprocket, Theramore, Ratchet, Astranaar, Emerald Sanctuary
					["0.48:0.70:0.64:0.67:0.46:0.40"] = 529, -- Thalanaar, Theramore, Astranaar

					-- Alliance: Theramore (Dustwallow Marsh)
					["0.64:0.67:0.48:0.70:0.31:0.69"] = 340, -- Theramore, Thalanaar, Feathermoon
					["0.64:0.67:0.60:0.81:0.42:0.79"] = 354, -- Theramore, Gadgetzan, Cenarion Hold
					["0.64:0.67:0.60:0.81:0.50:0.76"] = 261, -- Theramore, Gadgetzan, Marshal's Refuge
					["0.64:0.67:0.48:0.70"] = 162, -- Theramore, Thalanaar
					["0.64:0.67:0.58:0.70"] = 64, -- Theramore, Mudsprocket
					["0.64:0.67:0.60:0.81"] = 157, -- Theramore, Gadgetzan
					["0.64:0.67:0.61:0.55"] = 115, -- Theramore, Ratchet
					["0.64:0.67:0.40:0.51"] = 334, -- Theramore, Nijel's Point
					["0.64:0.67:0.40:0.51:0.39:0.40"] = 453, -- Theramore, Nijel's Point, Stonetalon Peak
					["0.64:0.67:0.46:0.40"] = 369, -- Theramore, Astranaar
					["0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35"] = 366, -- Theramore, Talrendis Point, Forest Song, Emerald Sanctuary
					["0.64:0.67:0.61:0.40:0.58:0.39"] = 259, -- Theramore, Talrendis Point, Forest Song
					["0.64:0.67:0.61:0.40"] = 234, -- Theramore, Talrendis Point
					["0.64:0.67:0.61:0.40:0.65:0.23"] = 412, -- Theramore, Talrendis Point, Everlook
					["0.64:0.67:0.61:0.40:0.58:0.39:0.50:0.35:0.53:0.26"] = 494, -- Theramore, Talrendis Point, Forest Song, Emerald Sanctuary, Talonbranch Glade
					["0.64:0.67:0.61:0.40:0.65:0.23:0.55:0.21"] = 523, -- Theramore, Talrendis Point, Everlook, Moonglade
					["0.64:0.67:0.43:0.25"] = 440, -- Theramore, Auberdine
					["0.64:0.67:0.43:0.25:0.42:0.16"] = 524, -- Theramore, Auberdine, Rut'theran Village
					["0.64:0.67:0.61:0.55:0.46:0.40:0.39:0.40"] = 464, -- Theramore, Ratchet, Astranaar, Stonetalon Peak
					["0.64:0.67:0.40:0.51:0.31:0.69"] = 567, -- Theramore, Nijel's Point, Feathermoon
					["0.64:0.67:0.61:0.55:0.46:0.40:0.58:0.39"] = 443, -- Theramore, Ratchet, Astranaar, Forest Song
					["0.64:0.67:0.43:0.25:0.39:0.40"] = 621, -- Theramore, Auberdine, Stonetalon Peak
					["0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35"] = 388, -- Theramore, Ratchet, Astranaar, Emerald Sanctuary
					["0.64:0.67:0.43:0.25:0.53:0.26"] = 629, -- Theramore, Auberdine, Talonbranch Glade
					["0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26:0.65:0.23"] = 605, -- Theramore, Ratchet, Astranaar, Emerald Sanctuary, Talonbranch Glade, Everlook
					["0.64:0.67:0.61:0.40:0.53:0.26"] = 516, -- Theramore, Talrendis Point, Talonbranch Glade (was 234, changed by Michael Keller)
					["0.64:0.67:0.46:0.40:0.58:0.39"] = 504, -- Theramore, Astranaar, Forest Song
					["0.64:0.67:0.61:0.55:0.46:0.40:0.50:0.35:0.53:0.26"] = 516, -- Theramore, Ratschet, Astranaar, Emerald Sanctuary, Talonbranch Glade
					["0.64:0.67:0.60:0.81:0.42:0.79:0.31:0.69"] = 520, -- Theramore, Gadgetzan, Cenarion Hold, Feathermoon
					["0.64:0.67:0.46:0.40:0.39:0.40"] = 524, -- Theramore, Astranaar, Stonetalon Peak
					["0.64:0.67:0.43:0.25:0.55:0.21:0.65:0.23"] = 710, -- Theramore, Auberdine, Moonglade, Everlook
					["0.64:0.67:0.46:0.40:0.50:0.35"] = 448, -- Theramore, Astranaar, Emerald Sanctuary

				},

				-- Alliance: Outland
				[1945] = {

					-- Alliance: Allerian Stronghold (Terokkar Forest)
					["0.55:0.77:0.27:0.74"] = 149, -- Allerian Stronghold, Telaar
					["0.55:0.77:0.44:0.67"] = 75, -- Allerian Stronghold, Shattrath (Luis C. reported 82, not changed yet)
					["0.55:0.77:0.69:0.85"] = 79, -- Allerian Stronghold, Wildhammer Stronghold
					["0.55:0.77:0.65:0.58"] = 96, -- Allerian Stronghold, Honor Hold
					["0.55:0.77:0.65:0.58:0.79:0.55"] = 156, -- Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.55:0.77:0.65:0.58:0.52:0.51"] = 170, -- Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.55:0.77:0.44:0.67:0.38:0.50"] = 158, -- Allerian Stronghold, Shattrath, Telredor
					["0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 221, -- Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 227, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 249, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 280, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 311, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 358, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 375, -- Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.55:0.77:0.69:0.85:0.81:0.77"] = 161, -- Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.55:0.77:0.69:0.85:0.78:0.85"] = 121, -- Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.55:0.77:0.65:0.58:0.75:0.50"] = 150, -- Allerian Stronghold, Honor Hold, Shatter Point
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.63:0.18"] = 404, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar, The Stormspire
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27"] = 368, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Area 52
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.42:0.28"] = 300, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Evergrove
					["0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27:0.72:0.28"] = 433, -- Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Area 52, Cosmowrench

					-- Alliance: Altar of Sha'tar (Shadowmoon Valley)
					["0.81:0.77:0.69:0.85"] = 81, -- Altar of Sha'tar, Wildhammer Stronghold
					["0.81:0.77:0.55:0.77:0.44:0.67"] = 254, -- Altar of Sha'tar, Allerian Stronghold, Shattrath
					["0.81:0.77:0.55:0.77:0.65:0.58:0.75:0.50"] = 330, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Shatter Point
					["0.81:0.77:0.55:0.77:0.65:0.58:0.79:0.55"] = 336, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.81:0.77:0.55:0.77"] = 182, -- Altar of Sha'tar, Allerian Stronghold
					["0.81:0.77:0.55:0.77:0.65:0.58"] = 276, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold
					["0.81:0.77:0.55:0.77:0.27:0.74"] = 330, -- Altar of Sha'tar, Allerian Stronghold, Telaar
					["0.81:0.77:0.55:0.77:0.65:0.58:0.52:0.51"] = 351, -- Altar of Sha'tar, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50"] = 338, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 400, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 555, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 537, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 406, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 489, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.81:0.77:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 458, -- Altar of Sha'tar, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67"] = 254, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 338, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor
					["0.81:0.77:0.69:0.85:0.55:0.77:0.27:0.74"] = 329, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Telaar
					["0.81:0.77:0.69:0.85:0.55:0.77:0.65:0.58"] = 276, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Honor Hold
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 537, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 428, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.81:0.77:0.69:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 350, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.81:0.77:0.69:0.85:0.55:0.77"] = 181, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 489, -- Altar der Sha'tar, Wildhammerfeste, Allerias Feste, Shattrath, Telredor, Toshleys Station, Area 52
					["0.81:0.77:0.69:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 329, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Shatter Point
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 400, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 459, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 406, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.81:0.77:0.69:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 336, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 555, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27"] = 547, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Area 52
					["0.81:0.77:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.42:0.28"] = 479, -- Altar of Sha'tar, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Evergrove

					-- Alliance: Area 52 (Netherstorm)
					["0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 290, -- Area 52, Toshley's Station, Telredor, Telaar
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 262, -- Area 52, Toshley's Station, Telredor, Shattrath
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 337, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 414, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 333, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 395, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 247, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.58:0.27:0.42:0.37:0.38:0.50"] = 165, -- Area 52, Toshley's Station, Telredor
					["0.58:0.27:0.32:0.34:0.27:0.44"] = 202, -- Area 52, Sylvanaar, Orebor Harborage
					["0.58:0.27:0.32:0.34"] = 127, -- Area 52, Sylvanaar
					["0.58:0.27:0.42:0.37"] = 93, -- Area 52, Toshley's Station
					["0.58:0.27:0.42:0.28"] = 80, -- Area 52, Evergrove
					["0.58:0.27:0.72:0.28"] = 66, -- Area 52, Cosmowrench
					["0.58:0.27:0.63:0.18"] = 47, -- Area 52, The Stormspire
					["0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 388, -- Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 495, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 456, -- Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.58:0.27:0.32:0.34:0.38:0.50:0.44:0.67"] = 305, -- Area 52, Sylvanaar, Telredor, Shattrath
					["0.58:0.27:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77"] = 380, -- Area 52, Sylvanaar, Telredor, Shattrath, Allerian Stronghold
					["0.58:0.27:0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58"] = 377, -- Area 52, Sylvanaar, Telredor, Temple of Telhamat, Honor Hold
					["0.58:0.27:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 499, -- Area 52, Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.58:0.27:0.32:0.34:0.38:0.50:0.27:0.74"] = 332, -- Area 52, Sylvanaar, Telredor, Telaar
					["0.58:0.27:0.32:0.34:0.38:0.50:0.52:0.51"] = 290, -- Area 52, Sylvanaar, Telredor, Temple of Telhamat
					["0.58:0.27:0.32:0.34:0.38:0.50"] = 208, -- Area 52, Sylvanaar, Telredor
					["0.58:0.27:0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 431, -- Area 52, Sylvanaar, Telredor, Temple of Telhamat, Honor Hold, Shatter Point

					-- Alliance: Cosmowrench (Netherstorm)
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 353, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Telaar
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 326, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 401, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 478, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 396, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 458, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 310, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50"] = 229, -- Cosmowrench, Area 52, Toshley's Station, Telredor
					["0.72:0.28:0.58:0.27:0.32:0.34:0.27:0.44"] = 266, -- Cosmowrench, Area 52, Sylvanaar, Orebor Harborage
					["0.72:0.28:0.58:0.27:0.42:0.37"] = 157, -- Cosmowrench, Area 52, Toshley's Station
					["0.72:0.28:0.58:0.27:0.32:0.34"] = 192, -- Cosmowrench, Area 52, Sylvanaar
					["0.72:0.28:0.58:0.27:0.42:0.28"] = 145, -- Cosmowrench, Area 52, Evergrove
					["0.72:0.28:0.58:0.27"] = 64, -- Cosmowrench, Area 52
					["0.72:0.28:0.63:0.18"] = 61, -- Cosmowrench, The Stormspire
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 451, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 559, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.72:0.28:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 520, -- Cosmowrench, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.72:0.28:0.63:0.18:0.32:0.34:0.38:0.50"] = 296, -- Cosmowrench, The Stormspire, Sylvanaar, Telredor
					["0.72:0.28:0.58:0.27:0.32:0.34:0.38:0.50:0.44:0.67"] = 369, -- Cosmowrench, Area 52, Sylvanaar, Telredor, Shattrath
					["0.72:0.28:0.58:0.27:0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58"] = 441, -- Cosmowrench, Area 52, Sylvanaar, Telredor, Temple of Telhamat, Honor Hold

					-- Alliance: Evergrove (Blade's Edge Mountains)
					["0.42:0.28:0.42:0.37:0.38:0.50:0.27:0.74"] = 240, -- Evergrove, Toshley's Station, Telredor, Telaar
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67"] = 213, -- Evergrove, Toshley's Station, Telredor, Shattrath
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 287, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 366, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 284, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 346, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51"] = 197, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat
					["0.42:0.28:0.42:0.37:0.38:0.50"] = 116, -- Evergrove, Toshley's Station, Telredor
					["0.42:0.28:0.32:0.34:0.27:0.44"] = 130, -- Evergrove, Sylvanaar, Orebor Harborage
					["0.42:0.28:0.42:0.37"] = 44, -- Evergrove, Toshley's Station
					["0.42:0.28:0.32:0.34"] = 54, -- Evergrove, Sylvanaar
					["0.42:0.28:0.58:0.27"] = 78, -- Evergrove, Area 52
					["0.42:0.28:0.58:0.27:0.63:0.18"] = 124, -- Evergrove, Area 52, The Stormspire
					["0.42:0.28:0.58:0.27:0.72:0.28"] = 143, -- Evergrove, Area 52, Cosmowrench
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 407, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.42:0.28:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 428, -- Evergrove, Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.42:0.28:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 446, -- Evergrove, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.42:0.28:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 339, -- Evergrove, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.42:0.28:0.32:0.34:0.38:0.50:0.27:0.74"] = 261, -- Evergrove, Sylvanaar, Telredor, Telaar
					["0.42:0.28:0.32:0.34:0.38:0.50:0.44:0.67"] = 234, -- Evergrove, Sylvanaar, Telredor, Shattrath
					["0.42:0.28:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77"] = 308, -- Evergrove, Sylvanaar, Telredor, Shattrath, Allerian Stronghold
					["0.42:0.28:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 386, -- Evergrove, Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.42:0.28:0.32:0.34:0.38:0.50"] = 137, -- Evergrove, Sylvanaar, Telredor

					-- Alliance: Hellfire Peninsula (Hellfire Peninsula) (Dark Portal)
					["0.79:0.55:0.65:0.58:0.44:0.67:0.27:0.74"] = 277, -- Hellfire Peninsula, Honor Hold, Shattrath, Telaar
					["0.79:0.55:0.65:0.58:0.44:0.67"] = 190, -- Hellfire Peninsula, Honor Hold, Shattrath
					["0.79:0.55:0.65:0.58:0.55:0.77"] = 188, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85"] = 266, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.79:0.55:0.65:0.58"] = 73, -- Hellfire Peninsula, Honor Hold
					["0.79:0.55:0.52:0.51"] = 115, -- Hellfire Peninsula, Temple of Telhamat
					["0.79:0.55:0.52:0.51:0.38:0.50"] = 196, -- Hellfire Peninsula, Temple of Telhamat, Telredor
					["0.79:0.55:0.52:0.51:0.38:0.50:0.27:0.44"] = 259, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Orebor Harborage
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37"] = 265, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station
					["0.79:0.55:0.52:0.51:0.38:0.50:0.32:0.34"] = 287, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Sylvanaar
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 317, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 348, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 413, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.79:0.55:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 396, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.79:0.55:0.75:0.50"] = 28, -- Hellfire Peninsula, Shatter Point
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 348, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.79:0.55:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 308, -- Hellfire Peninsula, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.79:0.55:0.52:0.51:0.38:0.50:0.27:0.74"] = 321, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Telaar
					["0.79:0.55:0.52:0.51:0.38:0.50:0.32:0.34:0.42:0.28"] = 339, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Sylvanaar, Evergrove
					["0.79:0.55:0.52:0.51:0.38:0.50:0.32:0.34:0.58:0.27"] = 406, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Sylvanaar, Area 52
					["0.79:0.55:0.52:0.51:0.38:0.50:0.32:0.34:0.63:0.18"] = 441, -- Hellfire Peninsula, Temple of Telhamat, Telredor, Sylvanaar, The Stormspire

					-- Alliance: Honor Hold (Hellfire Peninsula)
					["0.65:0.58:0.44:0.67:0.27:0.74"] = 207, -- Honor Hold, Shattrath, Telaar
					["0.65:0.58:0.44:0.67"] = 120, -- Honor Hold, Shattrath
					["0.65:0.58:0.55:0.77"] = 118, -- Honor Hold, Allerian Stronghold
					["0.65:0.58:0.55:0.77:0.69:0.85"] = 196, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.65:0.58:0.79:0.55"] = 64, -- Honor Hold, Hellfire Peninsula
					["0.65:0.58:0.52:0.51"] = 76, -- Honor Hold, Temple of Telhamat
					["0.65:0.58:0.52:0.51:0.38:0.50"] = 156, -- Honor Hold, Temple of Telhamat, Telredor
					["0.65:0.58:0.52:0.51:0.38:0.50:0.27:0.44"] = 219, -- Honor Hold, Temple of Telhamat, Telredor, Orebor Harborage
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37"] = 225, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station
					["0.65:0.58:0.52:0.51:0.38:0.50:0.32:0.34"] = 248, -- Honor Hold, Temple of Telhamat, Telredor, Sylvanaar
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 278, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 309, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 356, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 374, -- Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.65:0.58:0.75:0.50"] = 57, -- Honor Hold, Shatter Point
					["0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 278, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 238, -- Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.65:0.58:0.44:0.67:0.38:0.50:0.27:0.44"] = 266, -- Honor Hold, Shattrath, Telredor, Orebor Harborage
					["0.65:0.58:0.44:0.67:0.38:0.50"] = 203, -- Honor Hold, Shattrath, Telredor
					["0.65:0.58:0.52:0.51:0.38:0.50:0.32:0.34:0.58:0.27"] = 366, -- Honor Hold, Temple of Telhamat, Telredor, Sylvanaar, Area 52
					["0.65:0.58:0.55:0.77:0.27:0.74"] = 267, -- Honor Hold, Allerian Stronghold, Telaar
					["0.65:0.58:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 403, -- Honor Hold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire

					-- Alliance: Orebor Harborage (Zangarmarsh)
					["0.27:0.44:0.38:0.50:0.27:0.74"] = 177, -- Orebor Harborage, Telredor, Telaar
					["0.27:0.44:0.38:0.50:0.44:0.67"] = 150, -- Orebor Harborage, Telredor, Shattrath
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77"] = 225, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 302, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58"] = 221, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 282, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.27:0.44:0.38:0.50:0.52:0.51"] = 134, -- Orebor Harborage, Telredor, Temple of Telhamat
					["0.27:0.44:0.38:0.50"] = 53, -- Orebor Harborage, Telredor
					["0.27:0.44:0.32:0.34"] = 65, -- Orebor Harborage, Sylvanaar
					["0.27:0.44:0.32:0.34:0.42:0.37"] = 122, -- Orebor Harborage, Sylvanaar, Toshley's Station
					["0.27:0.44:0.32:0.34:0.42:0.28"] = 116, -- Orebor Harborage, Sylvanaar, Evergrove
					["0.27:0.44:0.32:0.34:0.58:0.27"] = 184, -- Orebor Harborage, Sylvanaar, Area 52
					["0.27:0.44:0.32:0.34:0.58:0.27:0.72:0.28"] = 249, -- Orebor Harborage, Sylvanaar, Area 52, Cosmowrench
					["0.27:0.44:0.32:0.34:0.63:0.18"] = 219, -- Orebor Harborage, Sylvanaar, The Stormspire
					["0.27:0.44:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 275, -- Orebor Harborage, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 384, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.27:0.44:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 253, -- Orebor Harborage, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.27:0.44:0.38:0.50:0.44:0.67:0.65:0.58"] = 261, -- Orebor Harborage, Telredor, Shattrath, Honor Hold
					["0.27:0.44:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 344, -- Orebor Harborage, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars

					-- Alliance: Sanctum of the Stars (Shadowmoon Valley)
					["0.78:0.85:0.55:0.77:0.44:0.67"] = 215, -- Sanctum of the Stars, Allerian Stronghold, Shattrath
					["0.78:0.85:0.55:0.77"] = 142, -- Sanctum of the Stars, Allerian Stronghold
					["0.78:0.85:0.69:0.85"] = 42, -- Sanctum of the Stars, Wildhammer Stronghold
					["0.78:0.85:0.55:0.77:0.27:0.74"] = 290, -- Sanctum of the Stars, Allerian Stronghold, Telaar
					["0.78:0.85:0.55:0.77:0.65:0.58"] = 237, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold
					["0.78:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 296, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.78:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 290, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Shatter Point
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 450, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.78:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 311, -- Sanctum of the Stars, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 298, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 515, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 389, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 361, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.78:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 366, -- Sanctum of the Stars, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 419, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67"] = 215, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath
					["0.78:0.85:0.69:0.85:0.55:0.77"] = 142, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 389, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.78:0.85:0.69:0.85:0.55:0.77:0.65:0.58"] = 237, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Honor Hold
					["0.78:0.85:0.69:0.85:0.55:0.77:0.27:0.74"] = 290, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Telaar
					["0.78:0.85:0.69:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 296, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.78:0.85:0.69:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 290, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Shatter Point
					["0.78:0.85:0.69:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 311, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 298, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 361, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 516, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 367, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 498, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 450, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.78:0.85:0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.42:0.28"] = 440, -- Sanctum of the Stars, Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar, Evergrove

					-- Alliance: Shatter Point (Hellfire Peninsula)
					["0.75:0.50:0.79:0.55"] = 33, -- Shatter Point, Hellfire Peninsula
					["0.75:0.50:0.65:0.58"] = 57, -- Shatter Point, Honor Hold
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 334, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85"] = 252, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.75:0.50:0.65:0.58:0.55:0.77"] = 174, -- Shatter Point, Honor Hold, Allerian Stronghold
					["0.75:0.50:0.65:0.58:0.52:0.51"] = 132, -- Shatter Point, Honor Hold, Temple of Telhamat
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50"] = 213, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor
					["0.75:0.50:0.65:0.58:0.44:0.67"] = 175, -- Shatter Point, Honor Hold, Shattrath
					["0.75:0.50:0.65:0.58:0.44:0.67:0.27:0.74"] = 263, -- Shatter Point, Honor Hold, Shattrath, Telaar
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 430, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 364, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.27:0.44"] = 275, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Orebor Harborage
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 412, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.75:0.50:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 294, -- Shatter Point, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37"] = 282, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 334, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.75:0.50:0.65:0.58:0.52:0.51:0.38:0.50:0.32:0.34"] = 303, -- Shatter Point, Honor Hold, Temple of Telhamat, Telredor, Sylvanaar

					-- Alliance: Shattrath (Terokkar Forest)
					["0.44:0.67:0.27:0.74"] = 88, -- Shattrath, Telaar
					["0.44:0.67:0.55:0.77"] = 75, -- Shattrath, Allerian Stronghold (r-beauvais@hotmail.com reported 38)
					["0.44:0.67:0.55:0.77:0.69:0.85"] = 153, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.44:0.67:0.65:0.58:0.79:0.55"] = 172, -- Shattrath, Honor Hold, Hellfire Peninsula
					["0.44:0.67:0.65:0.58"] = 111, -- Shattrath, Honor Hold (Juniardo reported 157)
					["0.44:0.67:0.38:0.50:0.52:0.51"] = 165, -- Shattrath, Telredor, Temple of Telhamat
					["0.44:0.67:0.38:0.50"] = 84, -- Shattrath, Telredor
					["0.44:0.67:0.38:0.50:0.27:0.44"] = 146, -- Shattrath, Telredor, Orebor Harborage
					["0.44:0.67:0.38:0.50:0.42:0.37"] = 152, -- Shattrath, Telredor, Toshley's Station
					["0.44:0.67:0.38:0.50:0.32:0.34"] = 175, -- Shattrath, Telredor, Sylvanaar
					["0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 205, -- Shattrath, Telredor, Toshley's Station, Evergrove
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 235, -- Shattrath, Telredor, Toshley's Station, Area 52
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 301, -- Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 284, -- Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] =  235, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.44:0.67:0.65:0.58:0.75:0.50"] = 165, -- Shattrath, Honor Hold, Shatter Point
					["0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 195, -- Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27:0.72:0.28"] = 359, -- Shattrath, Telredor, Sylvanaar, Area 52, Cosmowrench
					["0.44:0.67:0.65:0.58:0.52:0.51"] = 185, -- Shattrath, Honor Hold, Temple of Telhamat
					["0.44:0.67:0.38:0.50:0.32:0.34:0.63:0.18"] = 329, -- Shattrath, Telredor, Sylvanaar, The Stormspire
					["0.44:0.67:0.38:0.50:0.32:0.34:0.58:0.27"] = 294, -- Shattrath, Telredor, Sylvanaar, Area 52
					["0.44:0.67:0.38:0.50:0.32:0.34:0.42:0.28"] = 226, -- Shattrath, Telredor, Sylvanaar, Evergrove
					["0.44:0.67:0.38:0.50:0.32:0.34:0.63:0.18:0.72:0.28"] = 398, -- Shattrath, Telredor, Sylvanaar, The Stormspire, Cosmowrench

					-- Alliance: Sylvanaar (Blade's Edge Mountains)
					["0.32:0.34:0.38:0.50:0.27:0.74"] = 207, -- Sylvanaar, Telredor, Telaar
					["0.32:0.34:0.38:0.50:0.44:0.67"] = 179, -- Sylvanaar, Telredor, Shattrath
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77"] = 255, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 332, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58"] = 251, -- Sylvanaar, Telredor, Temple of Telhamat, Honor Hold
					["0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 312, -- Sylvanaar, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.32:0.34:0.38:0.50:0.52:0.51"] = 164, -- Sylvanaar, Telredor, Temple of Telhamat
					["0.32:0.34:0.38:0.50"] = 82, -- Sylvanaar, Telredor
					["0.32:0.34:0.27:0.44"] = 76, -- Sylvanaar, Orebor Harborage
					["0.32:0.34:0.42:0.37"] = 57, -- Sylvanaar, Toshley's Station
					["0.32:0.34:0.42:0.28"] = 51, -- Sylvanaar, Evergrove
					["0.32:0.34:0.58:0.27"] = 119, -- Sylvanaar, Area 52
					["0.32:0.34:0.63:0.18"] = 155, -- Sylvanaar, The Stormspire
					["0.32:0.34:0.58:0.27:0.72:0.28"] = 185, -- Sylvanaar, Area 52, Cosmowrench
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 373, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.32:0.34:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 305, -- Sylvanaar, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 413, -- Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.32:0.34:0.38:0.50:0.44:0.67:0.65:0.58"] = 289, -- Sylvanaar, Telredor, Shattrath, Honor Hold

					-- Alliance: Telaar (Nagrand)
					["0.27:0.74:0.44:0.67"] = 88, -- Telaar, Shattrath
					["0.27:0.74:0.55:0.77"] = 122, -- Telaar, Allerian Stronghold
					["0.27:0.74:0.55:0.77:0.69:0.85"] = 200, -- Telaar, Allerian Stronghold, Wildhammer Stronghold
					["0.27:0.74:0.44:0.67:0.65:0.58:0.79:0.55"] = 260, -- Telaar, Shattrath, Honor Hold, Hellfire Peninsula
					["0.27:0.74:0.44:0.67:0.65:0.58"] = 199, -- Telaar, Shattrath, Honor Hold
					["0.27:0.74:0.38:0.50:0.52:0.51"] = 208, -- Telaar, Telredor, Temple of Telhamat
					["0.27:0.74:0.38:0.50"] = 126, -- Telaar, Telredor
					["0.27:0.74:0.38:0.50:0.27:0.44"] = 189, -- Telaar, Telredor, Orebor Harborage
					["0.27:0.74:0.38:0.50:0.42:0.37"] = 195, -- Telaar, Telredor, Toshley's Station
					["0.27:0.74:0.38:0.50:0.32:0.34"] = 217, -- Telaar, Telredor, Sylvanaar
					["0.27:0.74:0.38:0.50:0.42:0.37:0.42:0.28"] = 248, -- Telaar, Telredor, Toshley's Station, Evergrove
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27"] = 280, -- Telaar, Telredor, Toshley's Station, Area 52
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 344, -- Telaar, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.27:0.74:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 327, -- Telaar, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.27:0.74:0.55:0.77:0.69:0.85:0.81:0.77"] = 281, -- Telaar, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.27:0.74:0.44:0.67:0.65:0.58:0.75:0.50"] = 253, -- Telaar, Shattrath, Honor Hold, Shatter Point
					["0.27:0.74:0.55:0.77:0.69:0.85:0.78:0.85"] = 241, -- Telaar, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.27:0.74:0.38:0.50:0.32:0.34:0.42:0.28"] = 269, -- Telaar, Telredor, Sylvanaar, Evergrove
					["0.27:0.74:0.38:0.50:0.32:0.34:0.58:0.27"] = 336, -- Telaar, Telredor, Sylvanaar, Area 52
					["0.27:0.74:0.44:0.67:0.65:0.58:0.52:0.51"] = 273, -- Telaar, Shattrath, Honor Hold, Temple of Telhamat
					["0.27:0.74:0.38:0.50:0.32:0.34:0.58:0.27:0.72:0.28"] = 402, -- Telaar, Telredor, Sylvanaar, Area 52, Cosmowrench

					-- Alliance: Telredor (Zangarmarsh)
					["0.38:0.50:0.27:0.74"] = 125, -- Telredor, Telaar
					["0.38:0.50:0.44:0.67"] = 97, -- Telredor, Shattrath
					["0.38:0.50:0.44:0.67:0.55:0.77"] = 172, -- Telredor, Shattrath, Allerian Stronghold
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 250, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.38:0.50:0.52:0.51:0.65:0.58"] = 169, -- Telredor, Temple of Telhamat, Honor Hold
					["0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 230, -- Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.38:0.50:0.52:0.51"] = 82, -- Telredor, Temple of Telhamat
					["0.38:0.50:0.27:0.44"] = 63, -- Telredor, Orebor Harborage
					["0.38:0.50:0.32:0.34"] = 91, -- Telredor, Sylvanaar
					["0.38:0.50:0.42:0.37"] = 69, -- Telredor, Toshley's Station
					["0.38:0.50:0.42:0.37:0.42:0.28"] = 121, -- Telredor, Toshley's Station, Evergrove
					["0.38:0.50:0.42:0.37:0.58:0.27"] = 153, -- Telredor, Toshley's Station, Area 52
					["0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 219, -- Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 200, -- Telredor, Toshley's Station, Area 52, The Stormspire
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 331, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 223, -- Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 292, -- Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.38:0.50:0.32:0.34:0.58:0.27:0.72:0.28"] = 276, -- Telredor, Sylvanaar, Area 52, Cosmowrench
					["0.38:0.50:0.32:0.34:0.42:0.28"] = 142, -- Telredor, Sylvanaar, Evergrove
					["0.38:0.50:0.44:0.67:0.65:0.58"] = 208, -- Telredor, Shattrath, Honor Hold
					["0.38:0.50:0.52:0.51:0.65:0.58:0.55:0.77"] = 284, -- Telredor, Temple of Telhamat, Honor Hold, Allerian Stronghold
					["0.38:0.50:0.32:0.34:0.63:0.18"] = 245, -- Telredor, Sylvanaar, The Stormspire

					-- Alliance: Temple of Telhamat (Hellfire Peninsula)
					["0.52:0.51:0.38:0.50:0.27:0.74"] = 206, -- Temple of Telhamat, Telredor, Telaar
					["0.52:0.51:0.38:0.50:0.44:0.67"] = 178, -- Temple of Telhamat, Telredor, Shattrath
					["0.52:0.51:0.65:0.58:0.55:0.77"] = 203, -- Temple of Telhamat, Honor Hold, Allerian Stronghold
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85"] = 281, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold
					["0.52:0.51:0.65:0.58"] = 88, -- Temple of Telhamat, Honor Hold
					["0.52:0.51:0.65:0.58:0.79:0.55"] = 149, -- Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.52:0.51:0.38:0.50"] = 81, -- Temple of Telhamat, Telredor
					["0.52:0.51:0.38:0.50:0.27:0.44"] = 144, -- Temple of Telhamat, Telredor, Orebor Harborage
					["0.52:0.51:0.38:0.50:0.42:0.37"] = 150, -- Temple of Telhamat, Telredor, Toshley's Station
					["0.52:0.51:0.38:0.50:0.32:0.34"] = 172, -- Temple of Telhamat, Telredor, Sylvanaar
					["0.52:0.51:0.38:0.50:0.42:0.37:0.42:0.28"] = 203, -- Temple of Telhamat, Telredor, Toshley's Station, Evergrove
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27"] = 233, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 280, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.52:0.51:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 298, -- Temple of Telhamat, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.52:0.51:0.65:0.58:0.75:0.50"] = 142, -- Temple of Telhamat, Honor Hold, Shatter Point
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85:0.81:0.77"] = 362, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.52:0.51:0.65:0.58:0.55:0.77:0.69:0.85:0.78:0.85"] = 323, -- Temple of Telhamat, Honor Hold, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.52:0.51:0.65:0.58:0.44:0.67"] = 204, -- Temple of Telhamat, Honor Hold, Shattrath
					["0.52:0.51:0.38:0.50:0.32:0.34:0.42:0.28"] = 223, -- Temple of Telhamat, Telredor, Sylvanaar, Evergrove

					-- Alliance: The Stormspire (Netherstorm)
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.27:0.74"] = 341, -- The Stormspire, Area 52, Toshley's Station, Telredor, Telaar
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67"] = 315, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 390, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 467, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 386, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 448, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51"] = 302, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50"] = 220, -- The Stormspire, Area 52, Toshley's Station, Telredor
					["0.63:0.18:0.32:0.34:0.27:0.44"] = 230, -- The Stormspire, Sylvanaar, Orebor Harborage
					["0.63:0.18:0.58:0.27:0.42:0.37"] = 146, -- The Stormspire, Area 52, Toshley's Station
					["0.63:0.18:0.32:0.34"] = 154, -- The Stormspire, Sylvanaar
					["0.63:0.18:0.58:0.27:0.42:0.28"] = 132, -- The Stormspire, Area 52, Evergrove
					["0.63:0.18:0.58:0.27"] = 53, -- The Stormspire, Area 52
					["0.63:0.18:0.72:0.28"] = 69, -- The Stormspire, Cosmowrench
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 440, -- The Stormspire, Area 52, Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 549, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.63:0.18:0.58:0.27:0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 509, -- The Stormspire, Area 52, Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.63:0.18:0.32:0.34:0.38:0.50:0.44:0.67"] = 332, -- The Stormspire, Sylvanaar, Telredor, Shattrath
					["0.63:0.18:0.32:0.34:0.38:0.50"] = 236, -- The Stormspire, Sylvanaar, Telredor
					["0.63:0.18:0.32:0.34:0.38:0.50:0.27:0.74"] = 360, -- The Stormspire, Sylvanaar, Telredor, Telaar
					["0.63:0.18:0.32:0.34:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 485, -- The Stormspire, Sylvanaar, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold

					-- Alliance: Toshley's Station (Blade's Edge Mountains)
					["0.42:0.37:0.38:0.50:0.27:0.74"] = 197, -- Toshley's Station, Telredor, Telaar (was 265, changed to 197 by kaungmo@gmail.com and Thomas Jespersen)
					["0.42:0.37:0.38:0.50:0.44:0.67"] = 170, -- Toshley's Station, Telredor, Shattrath
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77"] = 245, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85"] = 321, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold
					["0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.79:0.55"] = 302, -- Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Hellfire Peninsula
					["0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58"] = 241, -- Toshley's Station, Telredor, Temple of Telhamat, Honor Hold
					["0.42:0.37:0.38:0.50:0.52:0.51"] = 154, -- Toshley's Station, Telredor, Temple of Telhamat
					["0.42:0.37:0.38:0.50"] = 73, -- Toshley's Station, Telredor
					["0.42:0.37:0.32:0.34:0.27:0.44"] = 134, -- Toshley's Station, Sylvanaar, Orebor Harborage
					["0.42:0.37:0.32:0.34"] = 60, -- Toshley's Station, Sylvanaar
					["0.42:0.37:0.42:0.28"] = 53, -- Toshley's Station, Evergrove
					["0.42:0.37:0.58:0.27"] = 84, -- Toshley's Station, Area 52
					["0.42:0.37:0.58:0.27:0.63:0.18"] = 132, -- Toshley's Station, Area 52, The Stormspire
					["0.42:0.37:0.58:0.27:0.72:0.28"] = 150, -- Toshley's Station, Area 52, Cosmowrench
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.81:0.77"] = 403, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Altar of Sha'tar
					["0.42:0.37:0.38:0.50:0.52:0.51:0.65:0.58:0.75:0.50"] = 295, -- Toshley's Station, Telredor, Temple of Telhamat, Honor Hold, Shatter Point
					["0.42:0.37:0.38:0.50:0.44:0.67:0.55:0.77:0.69:0.85:0.78:0.85"] = 364, -- Toshley's Station, Telredor, Shattrath, Allerian Stronghold, Wildhammer Stronghold, Sanctum of the Stars
					["0.42:0.37:0.38:0.50:0.27:0.74:0.55:0.77"] = 318, -- Toshley's Station, Telredor, Telaar, Allerian Stronghold

					-- Alliance: Wildhammer Stronghold (Shadowmoon Valley)
					["0.69:0.85:0.55:0.77:0.27:0.74"] = 249, -- Wildhammer Stronghold, Allerian Stronghold, Telaar
					["0.69:0.85:0.55:0.77:0.44:0.67"] = 174, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath
					["0.69:0.85:0.55:0.77"] = 101, -- Wildhammer Stronghold, Allerian Stronghold
					["0.69:0.85:0.55:0.77:0.65:0.58"] = 196, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold
					["0.69:0.85:0.55:0.77:0.65:0.58:0.79:0.55"] = 256, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Hellfire Peninsula
					["0.69:0.85:0.55:0.77:0.65:0.58:0.52:0.51"] = 270, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Temple of Telhamat
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50"] = 257, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.27:0.44"] = 320, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Orebor Harborage
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37"] = 326, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34"] = 348, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.42:0.28"] = 379, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Evergrove
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27"] = 409, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.72:0.28"] = 475, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, Cosmowrench
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.42:0.37:0.58:0.27:0.63:0.18"] = 457, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Toshley's Station, Area 52, The Stormspire
					["0.69:0.85:0.81:0.77"] = 84, -- Wildhammer Stronghold, Altar of Sha'tar
					["0.69:0.85:0.55:0.77:0.65:0.58:0.75:0.50"] = 250, -- Wildhammer Stronghold, Allerian Stronghold, Honor Hold, Shatter Point
					["0.69:0.85:0.78:0.85"] = 43, -- Wildhammer Stronghold, Sanctum of the Stars
					["0.69:0.85:0.55:0.77:0.44:0.67:0.38:0.50:0.32:0.34:0.63:0.18"] = 503, -- Wildhammer Stronghold, Allerian Stronghold, Shattrath, Telredor, Sylvanaar, The Stormspire

				},

				-- Alliance: Northrend
				[113] = {

					----------------------------------------------------------------------
					-- Alliance: Borean Tundra
					----------------------------------------------------------------------

					-- Alliance: Borean Tundra: Amber Ledge
					["0.17:0.53:0.12:0.53"] = 25, -- Amber Ledge, Transitus Shield
					["0.17:0.53:0.21:0.49"] = 24, -- Amber Ledge, Fizzcrank Airstrip
					["0.17:0.53:0.21:0.49:0.24:0.40:0.52:0.38"] = 194, -- Amber Ledge, Fizzcrank Airstrip, River's Heart, Dalaran
					["0.17:0.53:0.21:0.49:0.24:0.40"] = 65, -- Amber Ledge, Fizzcrank Airstrip, River's Heart
					["0.17:0.53:0.21:0.49:0.24:0.40:0.52:0.38:0.56:0.36"] = 209, -- Amber Ledge, Fizzcrank Airstrip, River's Heart, Dalaran, The Argent Vanguard
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.73:0.54:0.88:0.60"] = 316, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.17:0.53:0.21:0.49:0.29:0.57:0.49:0.58:0.74:0.71:0.88:0.72"] = 320, -- Amber Ledge, Fizzcrank Airstrip, Unu'pe, Moa'ki, Kamagua, Valgarde Port
					["0.17:0.53:0.21:0.49:0.29:0.57:0.49:0.58:0.74:0.71"] = 267, -- Amber Ledge, Fizzcrank Airstrip, Unu'pe, Moa'ki, Kamagua
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.73:0.54"] = 239, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Amberpine Lodge
					["0.17:0.53:0.21:0.49:0.24:0.40:0.52:0.38:0.56:0.36:0.57:0.33:0.57:0.21"] = 278, -- Amber Ledge, Fizzcrank Airstrip, River's Heart, Dalaran, The Argent Vanguard, Frosthold, Bouldercrag's Refuge
					["0.17:0.53:0.22:0.61"] = 45, -- Amber Ledge, Valiance Keep
					["0.17:0.53:0.21:0.49:0.29:0.57"] = 66, -- Amber Ledge, Fizzcrank Airstrip, Unu'pe
					["0.17:0.53:0.21:0.49:0.42:0.53"] = 112, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest
					["0.17:0.53:0.21:0.49:0.42:0.53:0.41:0.43"] = 154, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Valiance Landing Camp
					["0.17:0.53:0.21:0.49:0.42:0.53:0.46:0.46"] = 164, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Fordragon Hold
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.76:0.67"] = 273, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Westguard Keep
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.73:0.54:0.83:0.46"] = 293, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Amberpine Lodge, Westfall Brigade
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.64:0.42:0.72:0.40:0.78:0.38"] = 300, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Ebon Watch, The Argent Stand, Zim'Torga
					["0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.64:0.42:0.72:0.40"] = 273, -- Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Ebon Watch, The Argent Stand

					-- Alliance: Borean Tundra: Fizzcrank Airstrip
					["0.21:0.49:0.17:0.53"] = 45, -- Fizzcrank Airstrip, Amber Ledge
					["0.21:0.49:0.17:0.53:0.12:0.53"] = 81, -- Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.21:0.49:0.22:0.61"] = 71, -- Fizzcrank Airstrip, Valiance Keep
					["0.21:0.49:0.29:0.57"] = 66, -- Fizzcrank Airstrip, Unu'pe
					["0.21:0.49:0.24:0.40:0.52:0.38"] = 257, -- Fizzcrank Airstrip, River's Heart, Dalaran
					["0.21:0.49:0.24:0.40"] = 64, -- Fizzcrank Airstrip, River's Heart
					["0.21:0.49:0.24:0.40:0.28:0.28"] = 149, -- Fizzcrank Airstrip, River's Heart, Death's Rise
					["0.21:0.49:0.24:0.40:0.52:0.38:0.56:0.36:0.57:0.33"] = 318, -- Fizzcrank Airstrip, River's Heart, Dalaran, The Argent Vanguard, Frosthold
					["0.21:0.49:0.29:0.57:0.49:0.58:0.74:0.71:0.88:0.72"] = 446, -- Fizzcrank Airstrip, Unu'pe, Moa'ki, Kamagua, Valgarde Port
					["0.21:0.49:0.42:0.53:0.60:0.52:0.73:0.54:0.88:0.60"] = 438, -- Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.21:0.49:0.42:0.53"] = 133, -- Fizzcrank Airstrip, Stars' Rest
					["0.21:0.49:0.42:0.53:0.60:0.52:0.76:0.67"] = 374, -- Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Westguard Keep

					-- Alliance: Borean Tundra: Transitus Shield (Coldarra)
					["0.12:0.53:0.17:0.53:0.21:0.49:0.24:0.40"] = 95, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, River's Heart
					["0.12:0.53:0.17:0.53"] = 30, -- Transitus Shield, Amber Ledge
					["0.12:0.53:0.17:0.53:0.21:0.49"] = 53, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip
					["0.12:0.53:0.17:0.53:0.22:0.61"] = 74, -- Transitus Shield, Amber Ledge, Valiance Keep
					["0.12:0.53:0.17:0.53:0.21:0.49:0.24:0.40:0.52:0.38"] = 224, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, River's Heart, Dalaran
					["0.12:0.53:0.17:0.53:0.21:0.49:0.29:0.57"] = 96, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Unu'pe
					["0.12:0.53:0.17:0.53:0.21:0.49:0.42:0.53:0.46:0.46"] = 193, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Fordragon Hold
					["0.12:0.53:0.17:0.53:0.21:0.49:0.29:0.57:0.49:0.58"] = 174, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Unu'pe, Moa'ki
					["0.12:0.53:0.17:0.53:0.21:0.49:0.29:0.57:0.49:0.58:0.74:0.71:0.88:0.72"] = 349, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Unu'pe, Moa'ki, Kamagua, Valgarde Port
					["0.12:0.53:0.17:0.53:0.21:0.49:0.24:0.40:0.28:0.28"] = 151, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, River's Heart, Death's Rise
					["0.12:0.53:0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.73:0.54:0.88:0.60"] = 344, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.12:0.53:0.17:0.53:0.21:0.49:0.42:0.53:0.60:0.52:0.76:0.67"] = 301, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Stars' Rest, Wintergarde Keep, Westguard Keep
					["0.12:0.53:0.17:0.53:0.21:0.49:0.29:0.57:0.49:0.58:0.74:0.71"] = 296, -- Transitus Shield, Amber Ledge, Fizzcrank Airstrip, Unu'pe, Moa'ki, Kamagua

					-- Alliance: Borean Tundra: Unu'pe
					["0.29:0.57:0.22:0.61"] = 60, -- Unu'pe, Valiance Keep
					["0.29:0.57:0.42:0.53"] = 98, -- Unu'pe, Stars' Rest
					["0.29:0.57:0.49:0.58:0.52:0.38"] = 240, -- Unu'pe, Moa'ki, Dalaran
					["0.29:0.57:0.49:0.58:0.74:0.71:0.88:0.72"] = 382, -- Unu'pe, Moa'ki, Kamagua, Valgarde Port
					["0.29:0.57:0.21:0.49"] = 79, -- Unu'pe, Fizzcrank Airstrip
					["0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54:0.88:0.60"] = 387, -- Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.29:0.57:0.49:0.58:0.74:0.71"] = 302, -- Unu'pe, Moa'ki, Kamagua
					["0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54"] = 273, -- Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge
					["0.29:0.57:0.49:0.58"] = 118, -- Unu'pe, Moa'ki
					["0.29:0.57:0.49:0.58:0.52:0.38:0.56:0.36:0.57:0.33"] = 300, -- Unu'pe, Moa'ki, Dalaran, The Argent Vanguard, Frosthold
					["0.29:0.57:0.22:0.61:0.17:0.53:0.12:0.53"] = 158, -- Unu'pe, Valiance Keep, Amber Ledge, Transitus Shield
					["0.29:0.57:0.22:0.61:0.17:0.53"] = 122, -- Unu'pe, Valiance Keep, Amber Ledge
					["0.29:0.57:0.21:0.49:0.24:0.40"] = 142, -- Unu'pe, Fizzcrank Airstrip, River's Heart
					["0.29:0.57:0.49:0.58:0.60:0.52:0.76:0.67"] = 323, -- Unu'pe, Moa'ki, Wintergarde Keep, Westguard Keep
					["0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54:0.83:0.46"] = 353, -- Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge, Westfall Brigade
					["0.29:0.57:0.49:0.58:0.60:0.52:0.64:0.42:0.72:0.40:0.78:0.38"] = 364, -- Unu'pe, Moa'ki, Wintergarde Keep, Ebon Watch, The Argent Stand, Zim'Torga

					-- Alliance: Borean Tundra: Valiance Keep
					["0.22:0.61:0.29:0.57:0.49:0.58:0.74:0.71"] = 365, -- Valiance Keep, Unu'pe, Moa'ki, Kamagua
					["0.22:0.61:0.29:0.57"] = 65, -- Valiance Keep, Unu'pe
					["0.22:0.61:0.21:0.49"] = 76, -- Valiance Keep, Fizzcrank Airstrip
					["0.22:0.61:0.17:0.53:0.12:0.53"] = 99, -- Valiance Keep, Amber Ledge, Transitus Shield
					["0.22:0.61:0.42:0.53:0.46:0.46:0.52:0.38"] = 285, -- Valiance Keep, Stars' Rest, Fordragon Hold, Dalaran
					["0.22:0.61:0.29:0.57:0.49:0.58:0.74:0.71:0.88:0.72"] = 445, -- Valiance Keep, Unu'pe, Moa'ki, Kamagua, Valgarde Port
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54:0.88:0.60"] = 450, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.22:0.61:0.21:0.49:0.24:0.40"] = 137, -- Valiance Keep, Fizzcrank Airstrip, River's Heart
					["0.22:0.61:0.17:0.53"] = 64, -- Valiance Keep, Amber Ledge
					["0.22:0.61:0.42:0.53"] = 146, -- Valiance Keep, Stars' Rest
					["0.22:0.61:0.21:0.49:0.24:0.40:0.28:0.28"] = 223, -- Valiance Keep, Fizzcrank Airstrip, River's Heart, Death's Rise
					["0.22:0.61:0.29:0.57:0.49:0.58"] = 181, -- Valiance Keep, Unu'pe, Moa'ki
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54"] = 337, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge
					["0.22:0.61:0.29:0.57:0.49:0.58:0.54:0.52"] = 230, -- Valiance Keep, Unu'pe, Moa'ki, Wyrmrest Temple
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52"] = 266, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep
					["0.22:0.61:0.42:0.53:0.41:0.43"] = 208, -- Valiance Keep, Stars' Rest, Valiance Landing Camp
					["0.22:0.61:0.42:0.53:0.46:0.46"] = 220, -- Valiance Keep, Stars' Rest, Fordragon Hold
					["0.22:0.61:0.42:0.53:0.46:0.46:0.52:0.38:0.56:0.36:0.57:0.33:0.57:0.21"] = 411, -- Valiance Keep, Stars' Rest, Fordragon Hold, Dalaran, The Argent Vanguard, Frosthold, Bouldercrag's Refuge
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.76:0.67"] = 386, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Westguard Keep
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.73:0.54:0.83:0.46"] = 417, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Amberpine Lodge, Westfall Brigade
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.64:0.42:0.72:0.40:0.78:0.38"] = 427, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Ebon Watch, The Argent Stand, Zim'Torga
					["0.22:0.61:0.29:0.57:0.49:0.58:0.60:0.52:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 481, -- Valiance Keep, Unu'pe, Moa'ki, Wintergarde Keep, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak

					----------------------------------------------------------------------
					-- Alliance: Crystalsong Forest
					----------------------------------------------------------------------

					-- Alliance: Crystalsong Forest: Windrunner's Overlook
					["0.59:0.43:0.64:0.42"] = 46, -- Windrunner's Overlook, Ebon Watch
					["0.59:0.43:0.62:0.36"] = 47, -- Windrunner's Overlook, K3
					["0.59:0.43:0.52:0.38"] = 48, -- Windrunner's Overlook, Dalaran
					["0.59:0.43:0.60:0.52"] = 77, -- Windrunner's Overlook, Wintergarde Keep
					["0.59:0.43:0.60:0.52:0.54:0.52"] = 124, -- Windrunner's Overlook, Wintergarde Keep, Wyrmrest Temple
					["0.59:0.43:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 390, -- Windrunner's Overlook, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.59:0.43:0.60:0.52:0.49:0.58"] = 169, -- Windrunner's Overlook, Wintergarde Keep, Moa'ki
					["0.59:0.43:0.62:0.36:0.57:0.33"] = 90, -- Windrunner's Overlook, K3, Frosthold
					["0.59:0.43:0.60:0.52:0.76:0.67:0.74:0.71"] = 246, -- Windrunner's Overlook, Wintergarde Keep, Westguard Keep, Kamagua
					["0.59:0.43:0.60:0.52:0.76:0.67"] = 197, -- Windrunner's Overlook, Wintergarde Keep, Westguard Keep
					["0.59:0.43:0.60:0.52:0.76:0.67:0.88:0.72"] = 266, -- Windrunner's Overlook, Wintergarde Keep, Westguard Keep, Valgarde Port

					----------------------------------------------------------------------
					-- Alliance: Dalaran
					----------------------------------------------------------------------

					-- Alliance: Dalaran
					["0.52:0.38:0.54:0.52"] = 122, -- Dalaran, Wyrmrest Temple
					["0.52:0.38:0.59:0.43:0.60:0.52"] = 128, -- Dalaran, Windrunner's Overlook, Wintergarde Keep
					["0.52:0.38:0.59:0.43:0.60:0.52:0.76:0.67:0.88:0.72"] = 317, -- Dalaran, Windrunner's Overlook, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.52:0.38:0.59:0.43:0.60:0.52:0.73:0.54"] = 199, -- Dalaran, Windrunner's Overlook, Wintergarde Keep, Amberpine Lodge
					["0.52:0.38:0.64:0.42:0.72:0.40:0.83:0.46:0.88:0.60"] = 301, -- Dalaran, Ebon Watch, The Argent Stand, Westfall Brigade, Fort Wildervar
					["0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38"] = 185, -- Dalaran, Ebon Watch, The Argent Stand, Zim'Torga
					["0.52:0.38:0.59:0.43:0.60:0.52:0.76:0.67"] = 248, -- Dalaran, Windrunner's Overlook, Wintergarde Keep, Westguard Keep
					["0.52:0.38:0.24:0.40"] = 212, -- Dalaran, River's Heart
					["0.52:0.38:0.64:0.42:0.72:0.40:0.83:0.46"] = 216, -- Dalaran, Ebon Watch, The Argent Stand, Westfall Brigade
					["0.52:0.38:0.59:0.43:0.60:0.52:0.76:0.67:0.74:0.71"] = 298, -- Dalaran, Windrunner's Overlook, Wintergarde Keep, Westguard Keep, Kamagua
					["0.52:0.38:0.46:0.46:0.42:0.53"] = 174, -- Dalaran, Fordragon Hold, Stars' Rest
					["0.52:0.38:0.49:0.58"] = 160, -- Dalaran, Moa'ki
					["0.52:0.38:0.41:0.43"] = 115, -- Dalaran, Valiance Landing Camp
					["0.52:0.38:0.59:0.43"] = 53, -- Dalaran, Windrunner's Overlook
					["0.52:0.38:0.46:0.46:0.42:0.53:0.29:0.57"] = 270, -- Dalaran, Fordragon Hold, Stars' Rest, Unu'pe
					["0.52:0.38:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 239, -- Dalaran, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.52:0.38:0.56:0.36:0.57:0.33"] = 72, -- Dalaran, The Argent Vanguard, Frosthold
					["0.52:0.38:0.46:0.46:0.42:0.53:0.22:0.61"] = 302, -- Dalaran, Fordragon Hold, Stars' Rest, Valiance Keep
					["0.52:0.38:0.62:0.36"] = 55, -- Dalaran, K3
					["0.52:0.38:0.24:0.40:0.21:0.49:0.17:0.53:0.12:0.53"] = 353, -- Dalaran, River's Heart, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.52:0.38:0.24:0.40:0.21:0.49:0.17:0.53"] = 317, -- Dalaran, River's Heart, Fizzcrank Airstrip, Amber Ledge
					["0.52:0.38:0.24:0.40:0.21:0.49"] = 274, -- Dalaran, River's Heart, Fizzcrank Airstrip
					["0.52:0.38:0.46:0.46"] = 100, -- Dalaran, Fordragon Hold
					["0.52:0.38:0.52:0.34:0.28:0.28"] = 206, -- Dalaran, Crusaders' Pinnacle, Death's Rise
					["0.52:0.38:0.64:0.42"] = 82, -- Dalaran, Ebon Watch
					["0.52:0.38:0.64:0.42:0.72:0.40"] = 145, -- Dalaran, Ebon Watch, The Argent Stand
					["0.52:0.38:0.64:0.42:0.69:0.42"] = 126, -- Dalaran, Ebon Watch, Light's Breach
					["0.52:0.38:0.49:0.21"] = 123, -- Dalaran, Argent Tournament Grounds
					["0.52:0.38:0.56:0.36:0.57:0.33:0.57:0.21"] = 136, -- Dalaran, The Argent Vanguard, Frosthold, Bouldercrag's Refuge

					----------------------------------------------------------------------
					-- Alliance: Dragonblight
					----------------------------------------------------------------------

					-- Alliance: Dragonblight: Fordragon Hold
					["0.46:0.46:0.42:0.53"] = 74, -- Fordragon Hold, Stars' Rest
					["0.46:0.46:0.54:0.52:0.49:0.58"] = 118, -- Fordragon Hold, Wyrmrest Temple, Moa'ki
					["0.46:0.46:0.54:0.52"] = 65, -- Fordragon Hold, Wyrmrest Temple
					["0.46:0.46:0.52:0.38:0.59:0.43"] = 109, -- Fordragon Hold, Dalaran, Windrunner's Overlook
					["0.46:0.46:0.52:0.38"] = 66, -- Fordragon Hold, Dalaran
					["0.46:0.46:0.60:0.52"] = 88, -- Fordragon Hold, Wintergarde Keep
					["0.46:0.46:0.42:0.53:0.22:0.61"] = 202, -- Fordragon Hold, Stars' Rest, Valiance Keep
					["0.46:0.46:0.60:0.52:0.76:0.67:0.88:0.72"] = 276, -- Fordragon Hold, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.46:0.46:0.60:0.52:0.76:0.67:0.74:0.71"] = 257, -- Fordragon Hold, Wintergarde Keep, Westguard Keep, Kamagua
					["0.46:0.46:0.42:0.53:0.29:0.57"] = 171, -- Fordragon Hold, Stars' Rest, Unu'pe
					["0.46:0.46:0.60:0.52:0.76:0.67"] = 208, -- Fordragon Hold, Wintergarde Keep, Westguard Keep
					["0.46:0.46:0.42:0.53:0.21:0.49:0.17:0.53"] = 243, -- Fordragon Hold, Stars' Rest, Fizzcrank Airstrip, Amber Ledge

					-- Alliance: Dragonblight: Moa'ki
					["0.49:0.58:0.42:0.53"] = 55, -- Moa'ki, Stars' Rest
					["0.49:0.58:0.42:0.53:0.41:0.43"] = 118, -- Moa'ki, Stars' Rest, Valiance Landing Camp
					["0.49:0.58:0.52:0.38"] = 123, -- Moa'ki, Dalaran
					["0.49:0.58:0.54:0.52"] = 49, -- Moa'ki, Wyrmrest Temple
					["0.49:0.58:0.60:0.52"] = 86, -- Moa'ki, Wintergarde Keep
					["0.49:0.58:0.54:0.52:0.46:0.46"] = 106, -- Moa'ki, Wyrmrest Temple, Fordragon Hold
					["0.49:0.58:0.60:0.52:0.76:0.67"] = 205, -- Moa'ki, Wintergarde Keep, Westguard Keep
					["0.49:0.58:0.74:0.71:0.88:0.72"] = 265, -- Moa'ki, Kamagua, Valgarde Port
					["0.49:0.58:0.29:0.57"] = 133, -- Moa'ki, Unu'pe
					["0.49:0.58:0.74:0.71"] = 185, -- Moa'ki, Kamagua
					["0.49:0.58:0.60:0.52:0.73:0.54:0.88:0.60"] = 271, -- Moa'ki, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.49:0.58:0.42:0.53:0.22:0.61"] = 184, -- Moa'ki, Stars' Rest, Valiance Keep
					["0.49:0.58:0.60:0.52:0.59:0.43"] = 150, -- Moa'ki, Wintergarde Keep, Windrunner's Overlook

					-- Alliance: Dragonblight: Stars' Rest
					["0.42:0.53:0.49:0.58"] = 72, -- Stars' Rest, Moa'ki
					["0.42:0.53:0.46:0.46"] = 82, -- Stars' Rest, Fordragon Hold
					["0.42:0.53:0.41:0.43"] = 67, -- Stars' Rest, Valiance Landing Camp
					["0.42:0.53:0.54:0.52"] = 90, -- Stars' Rest, Wyrmrest Temple
					["0.42:0.53:0.60:0.52"] = 125, -- Stars' Rest, Wintergarde Keep
					["0.42:0.53:0.46:0.46:0.52:0.38"] = 147, -- Stars' Rest, Fordragon Hold, Dalaran
					["0.42:0.53:0.46:0.46:0.52:0.38:0.56:0.36"] = 170, -- Stars' Rest, Fordragon Hold, Dalaran, The Argent Vanguard
					["0.42:0.53:0.29:0.57"] = 100, -- Stars' Rest, Unu'pe
					["0.42:0.53:0.60:0.52:0.59:0.43"] = 189, -- Stars' Rest, Wintergarde Keep, Windrunner's Overlook
					["0.42:0.53:0.60:0.52:0.76:0.67:0.88:0.72"] = 313, -- Stars' Rest, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.42:0.53:0.46:0.46:0.52:0.38:0.62:0.36"] = 193, -- Stars' Rest, Fordragon Hold, Dalaran, K3
					["0.42:0.53:0.49:0.58:0.74:0.71"] = 254, -- Stars' Rest, Moa'ki, Kamagua
					["0.42:0.53:0.22:0.61"] = 133, -- Stars' Rest, Valiance Keep
					["0.42:0.53:0.21:0.49:0.17:0.53"] = 172, -- Stars' Rest, Fizzcrank Airstrip, Amber Ledge

					-- Alliance: Dragonblight: Wintergarde Keep
					["0.60:0.52:0.54:0.52"] = 55, -- Wintergarde Keep, Wyrmrest Temple
					["0.60:0.52:0.59:0.43:0.52:0.38"] = 119, -- Wintergarde Keep, Windrunner's Overlook, Dalaran
					["0.60:0.52:0.49:0.58"] = 99, -- Wintergarde Keep, Moa'ki
					["0.60:0.52:0.42:0.53"] = 115, -- Wintergarde Keep, Stars' Rest
					["0.60:0.52:0.46:0.46"] = 96, -- Wintergarde Keep, Fordragon Hold
					["0.60:0.52:0.46:0.46:0.41:0.43"] = 156, -- Wintergarde Keep, Fordragon Hold, Valiance Landing Camp
					["0.60:0.52:0.69:0.42"] = 89, -- Wintergarde Keep, Light's Breach
					["0.60:0.52:0.73:0.54"] = 77, -- Wintergarde Keep, Amberpine Lodge
					["0.60:0.52:0.76:0.67:0.88:0.72"] = 195, -- Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.60:0.52:0.64:0.42:0.72:0.40:0.78:0.38"] = 168, -- Wintergarde Keep, Ebon Watch, The Argent Stand, Zim'Torga
					["0.60:0.52:0.42:0.53:0.29:0.57"] = 211, -- Wintergarde Keep, Stars' Rest, Unu'pe
					["0.60:0.52:0.59:0.43"] = 72, -- Wintergarde Keep, Windrunner's Overlook
					["0.60:0.52:0.64:0.42:0.62:0.36:0.57:0.33"] = 148, -- Wintergarde Keep, Ebon Watch, K3, Frosthold
					["0.60:0.52:0.64:0.42:0.62:0.36"] = 105, -- Wintergarde Keep, Ebon Watch, K3
					["0.60:0.52:0.73:0.54:0.88:0.60"] = 191, -- Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.60:0.52:0.42:0.53:0.22:0.61"] = 242, -- Wintergarde Keep, Stars' Rest, Valiance Keep

					-- Alliance: Dragonblight: Wyrmrest Temple
					["0.54:0.52:0.60:0.52"] = 36, -- Wyrmrest Temple, Wintergarde Keep
					["0.54:0.52:0.60:0.52:0.59:0.43"] = 78, -- Wyrmrest Temple, Wintergarde Keep, Windrunner's Overlook
					["0.54:0.52:0.46:0.46"] = 39, -- Wyrmrest Temple, Fordragon Hold
					["0.54:0.52:0.49:0.58"] = 36, -- Wyrmrest Temple, Moa'ki
					["0.54:0.52:0.42:0.53"] = 45, -- Wyrmrest Temple, Stars' Rest
					["0.54:0.52:0.52:0.38"] = 65, -- Wyrmrest Temple, Dalaran
					["0.54:0.52:0.42:0.53:0.29:0.57"] = 109, -- Wyrmrest Temple, Stars' Rest, Unu'pe
					["0.54:0.52:0.46:0.46:0.41:0.43"] = 79, -- Wyrmrest Temple, Fordragon Hold, Valiance Landing Camp
					["0.54:0.52:0.42:0.53:0.22:0.61"] = 129, -- Wyrmrest Temple, Stars' Rest, Valiance Keep
					["0.54:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 157, -- Wyrmrest Temple, Stars' Rest, Fizzcrank Airstrip, Amber Ledge

					----------------------------------------------------------------------
					-- Alliance: Grizzly Hills
					----------------------------------------------------------------------

					-- Alliance: Grizzly Hills: Amberpine Lodge
					["0.73:0.54:0.76:0.67"] = 84, -- Amberpine Lodge, Westguard Keep
					["0.73:0.54:0.76:0.67:0.74:0.71"] = 134, -- Amberpine Lodge, Westguard Keep, Kamagua
					["0.73:0.54:0.76:0.67:0.88:0.72"] = 152, -- Amberpine Lodge, Westguard Keep, Valgarde Port
					["0.73:0.54:0.88:0.60"] = 117, -- Amberpine Lodge, Fort Wildervar
					["0.73:0.54:0.69:0.42:0.64:0.42:0.52:0.38"] = 173, -- Amberpine Lodge, Light's Breach, Ebon Watch, Dalaran
					["0.73:0.54:0.83:0.46"] = 84, -- Amberpine Lodge, Westfall Brigade
					["0.73:0.54:0.69:0.42:0.72:0.40:0.78:0.38"] = 150, -- Amberpine Lodge, Light's Breach, The Argent Stand, Zim'Torga
					["0.73:0.54:0.60:0.52:0.42:0.53:0.22:0.61"] = 318, -- Amberpine Lodge, Wintergarde Keep, Stars' Rest, Valiance Keep
					["0.73:0.54:0.69:0.42:0.64:0.42:0.62:0.36:0.57:0.33"] = 189, -- Amberpine Lodge, Light's Breach, Ebon Watch, K3, Frosthold
					["0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 396, -- Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.73:0.54:0.60:0.52:0.42:0.53"] = 190, -- Amberpine Lodge, Wintergarde Keep, Stars' Rest
					["0.73:0.54:0.60:0.52:0.49:0.58"] = 175, -- Amberpine Lodge, Wintergarde Keep, Moa'ki

					-- Alliance: Grizzly Hills: Westfall Brigade
					["0.83:0.46:0.73:0.54"] = 79, -- Westfall Brigade, Amberpine Lodge
					["0.83:0.46:0.78:0.38"] = 73, -- Westfall Brigade, Zim'Torga
					["0.83:0.46:0.72:0.40"] = 82, -- Westfall Brigade, The Argent Stand
					["0.83:0.46:0.72:0.40:0.64:0.42:0.52:0.38"] = 201, -- Westfall Brigade, The Argent Stand, Ebon Watch, Dalaran
					["0.83:0.46:0.88:0.60"] = 85, -- Westfall Brigade, Fort Wildervar
					["0.83:0.46:0.78:0.38:0.64:0.19:0.57:0.21"] = 275, -- Westfall Brigade, Zim'Torga, Ulduar, Bouldercrag's Refuge
					["0.83:0.46:0.73:0.54:0.76:0.67"] = 162, -- Westfall Brigade, Amberpine Lodge, Westguard Keep
					["0.83:0.46:0.88:0.60:0.88:0.72"] = 159, -- Westfall Brigade, Fort Wildervar, Valgarde Port
					["0.83:0.46:0.73:0.54:0.76:0.67:0.74:0.71"] = 211, -- Westfall Brigade, Amberpine Lodge, Westguard Keep, Kamagua
					["0.83:0.46:0.73:0.54:0.60:0.52:0.42:0.53:0.22:0.61"] = 394, -- Westfall Brigade, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Valiance Keep
					["0.83:0.46:0.73:0.54:0.60:0.52:0.42:0.53:0.29:0.57"] = 363, -- Westfall Brigade, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Unu'pe
					["0.83:0.46:0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 472, -- Westfall Brigade, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.83:0.46:0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 436, -- Westfall Brigade, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge
					["0.83:0.46:0.73:0.54:0.60:0.52:0.42:0.53"] = 266, -- Westfall Brigade, Amberpine Lodge, Wintergarde Keep, Stars' Rest

					----------------------------------------------------------------------
					-- Alliance: Howling Fjord
					----------------------------------------------------------------------

					-- Alliance: Howling Fjord: Fort Wildervar
					["0.88:0.60:0.83:0.46"] = 98, -- Fort Wildervar, Westfall Brigade
					["0.88:0.60:0.88:0.72"] = 74, -- Fort Wildervar, Valgarde Port
					["0.88:0.60:0.76:0.67"] = 81, -- Fort Wildervar, Westguard Keep
					["0.88:0.60:0.76:0.67:0.74:0.71"] = 130, -- Fort Wildervar, Westguard Keep, Kamagua
					["0.88:0.60:0.73:0.54"] = 97, -- Fort Wildervar, Amberpine Lodge
					["0.88:0.60:0.83:0.46:0.78:0.38"] = 170, -- Fort Wildervar, Westfall Brigade, Zim'Torga
					["0.88:0.60:0.83:0.46:0.78:0.38:0.82:0.31"] = 223, -- Fort Wildervar, Westfall Brigade, Zim'Torga, Gundrak
					["0.88:0.60:0.73:0.54:0.60:0.52:0.46:0.46:0.41:0.43:0.24:0.40"] = 463, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Fordragon Hold, Valiance Landing Camp, River's Heart
					["0.88:0.60:0.73:0.54:0.69:0.42:0.64:0.42:0.52:0.38"] = 267, -- Fort Wildervar, Amberpine Lodge, Light's Breach, Ebon Watch, Dalaran
					["0.88:0.60:0.83:0.46:0.72:0.40"] = 179, -- Fort Wildervar, Westfall Brigade, The Argent Stand
					["0.88:0.60:0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49"] = 412, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip
					["0.88:0.60:0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 491, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.88:0.60:0.73:0.54:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 455, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge
					["0.88:0.60:0.73:0.54:0.60:0.52:0.42:0.53:0.22:0.61"] = 413, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Valiance Keep
					["0.88:0.60:0.73:0.54:0.60:0.52:0.49:0.58"] = 270, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Moa'ki
					["0.88:0.60:0.73:0.54:0.69:0.42"] = 162, -- Fort Wildervar, Amberpine Lodge, Light's Breach
					["0.88:0.60:0.73:0.54:0.60:0.52"] = 178, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep
					["0.88:0.60:0.73:0.54:0.69:0.42:0.64:0.42:0.62:0.36"] = 241, -- Fort Wildervar, Amberpine Lodge, Light's Breach, Ebon Watch, K3
					["0.88:0.60:0.73:0.54:0.69:0.42:0.64:0.42"] = 201, -- Fort Wildervar, Amberpine Lodge, Light's Breach, Ebon Watch
					["0.88:0.60:0.73:0.54:0.60:0.52:0.42:0.53:0.29:0.57"] = 382, -- Fort Wildervar, Amberpine Lodge, Wintergarde Keep, Stars' Rest, Unu'pe

					-- Alliance: Howling Fjord: Kamagua
					["0.74:0.71:0.76:0.67"] = 37, -- Kamagua, Westguard Keep
					["0.74:0.71:0.88:0.72"] = 81, -- Kamagua, Valgarde Port
					["0.74:0.71:0.76:0.67:0.88:0.60"] = 121, -- Kamagua, Westguard Keep, Fort Wildervar
					["0.74:0.71:0.76:0.67:0.73:0.54"] = 112, -- Kamagua, Westguard Keep, Amberpine Lodge
					["0.74:0.71:0.49:0.58:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 455, -- Kamagua, Moa'ki, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.74:0.71:0.76:0.67:0.60:0.52:0.54:0.52"] = 236, -- Kamagua, Westguard Keep, Wintergarde Keep, Wyrmrest Temple
					["0.74:0.71:0.49:0.58:0.29:0.57"] = 327, -- Kamagua, Moa'ki, Unu'pe
					["0.74:0.71:0.49:0.58:0.42:0.53:0.22:0.61"] = 377, -- Kamagua, Moa'ki, Stars' Rest, Valiance Keep
					["0.74:0.71:0.49:0.58"] = 195, -- Kamagua, Moa'ki
					["0.74:0.71:0.76:0.67:0.60:0.52"] = 188, -- Kamagua, Westguard Keep, Wintergarde Keep
					["0.74:0.71:0.76:0.67:0.73:0.54:0.83:0.46"] = 195, -- Kamagua, Westguard Keep, Amberpine Lodge, Westfall Brigade
					["0.74:0.71:0.49:0.58:0.42:0.53"] = 249, -- Kamagua, Moa'ki, Stars' Rest
					["0.74:0.71:0.76:0.67:0.60:0.52:0.46:0.46"] = 277, -- Kamagua, Westguard Keep, Wintergarde Keep, Fordragon Hold
					["0.74:0.71:0.49:0.58:0.42:0.53:0.41:0.43"] = 312, -- Kamagua, Moa'ki, Stars' Rest, Valiance Landing Camp
					["0.74:0.71:0.76:0.67:0.73:0.54:0.69:0.42:0.72:0.40:0.78:0.38"] = 260, -- Kamagua, Westguard Keep, Amberpine Lodge, Light's Breach, The Argent Stand, Zim'Torga
					["0.74:0.71:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.59:0.43"] = 249, -- Kamagua, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, Windrunner's Overlook
					["0.74:0.71:0.49:0.58:0.42:0.53:0.21:0.49:0.17:0.53"] = 418, -- Kamagua, Moa'ki, Stars' Rest, Fizzcrank Airstrip, Amber Ledge
					["0.74:0.71:0.49:0.58:0.29:0.57:0.21:0.49"] = 405, -- Kamagua, Moa'ki, Unu'pe, Fizzcrank Airstrip

					-- Alliance: Howling Fjord: Valgarde Port, Howling Fjord
					["0.88:0.72:0.88:0.60"] = 71, -- Valgarde Port, Fort Wildervar
					["0.88:0.72:0.76:0.67"] = 70, -- Valgarde Port, Westguard Keep
					["0.88:0.72:0.74:0.71"] = 96, -- Valgarde Port, Kamagua
					["0.88:0.72:0.76:0.67:0.73:0.54"] = 144, -- Valgarde Port, Westguard Keep, Amberpine Lodge
					["0.88:0.72:0.88:0.60:0.83:0.46"] = 168, -- Valgarde Port, Fort Wildervar, Westfall Brigade
					["0.88:0.72:0.74:0.71:0.49:0.58"] = 290, -- Valgarde Port, Kamagua, Moa'ki
					["0.88:0.72:0.76:0.67:0.60:0.52:0.42:0.53:0.22:0.61"] = 455, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Stars' Rest, Valiance Keep
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.52:0.38"] = 315, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, Dalaran
					["0.88:0.72:0.88:0.60:0.83:0.46:0.78:0.38"] = 241, -- Valgarde Port, Fort Wildervar, Westfall Brigade, Zim'Torga
					["0.88:0.72:0.88:0.60:0.83:0.46:0.72:0.40"] = 249, -- Valgarde Port, Fort Wildervar, Westfall Brigade, The Argent Stand
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.62:0.36:0.57:0.33"] = 332, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, K3, Frosthold
					["0.88:0.72:0.74:0.71:0.49:0.58:0.29:0.57"] = 421, -- Valgarde Port, Kamagua, Moa'ki, Unu'pe
					["0.88:0.72:0.76:0.67:0.60:0.52:0.42:0.53"] = 329, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Stars' Rest
					["0.88:0.72:0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 534, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.88:0.72:0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49"] = 454, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip
					["0.88:0.72:0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 498, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge
					["0.88:0.72:0.76:0.67:0.60:0.52"] = 220, -- Valgarde Port, Westguard Keep, Wintergarde Keep
					["0.88:0.72:0.76:0.67:0.60:0.52:0.54:0.52"] = 268, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Wyrmrest Temple
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42"] = 211, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach
					["0.88:0.72:0.88:0.60:0.83:0.46:0.78:0.38:0.82:0.31"] = 294, -- Valgarde Port, Fort Wildervar, Westfall Brigade, Zim'Torga, Gundrak
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42"] = 249, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.62:0.36"] = 289, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, K3
					["0.88:0.72:0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.59:0.43"] = 282, -- Valgarde Port, Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, Windrunner's Overlook
					["0.88:0.72:0.76:0.67:0.60:0.52:0.46:0.46"] = 310, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Fordragon Hold
					["0.88:0.72:0.76:0.67:0.60:0.52:0.46:0.46:0.41:0.43"] = 369, -- Valgarde Port, Westguard Keep, Wintergarde Keep, Fordragon Hold, Valiance Landing Camp

					-- Alliance: Howling Fjord: Westguard Keep
					["0.76:0.67:0.74:0.71"] = 52, -- Westguard Keep, Kamagua
					["0.76:0.67:0.88:0.72"] = 70, -- Westguard Keep, Valgarde Port
					["0.76:0.67:0.88:0.60"] = 86, -- Westguard Keep, Fort Wildervar
					["0.76:0.67:0.73:0.54"] = 77, -- Westguard Keep, Amberpine Lodge
					["0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.52:0.38"] = 248, -- Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, Dalaran
					["0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42:0.62:0.36"] = 222, -- Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch, K3
					["0.76:0.67:0.60:0.52:0.42:0.53:0.29:0.57"] = 357, -- Westguard Keep, Wintergarde Keep, Stars' Rest, Unu'pe
					["0.76:0.67:0.60:0.52:0.42:0.53"] = 260, -- Westguard Keep, Wintergarde Keep, Stars' Rest
					["0.76:0.67:0.73:0.54:0.83:0.46"] = 160, -- Westguard Keep, Amberpine Lodge, Westfall Brigade
					["0.76:0.67:0.60:0.52"] = 152, -- Westguard Keep, Wintergarde Keep
					["0.76:0.67:0.60:0.52:0.54:0.52"] = 200, -- Westguard Keep, Wintergarde Keep, Wyrmrest Temple
					["0.76:0.67:0.73:0.54:0.69:0.42:0.72:0.40"] = 186, -- Westguard Keep, Amberpine Lodge, Light's Breach, The Argent Stand
					["0.76:0.67:0.73:0.54:0.69:0.42"] = 143, -- Westguard Keep, Amberpine Lodge, Light's Breach
					["0.76:0.67:0.73:0.54:0.69:0.42:0.72:0.40:0.78:0.38"] = 226, -- Westguard Keep, Amberpine Lodge, Light's Breach, The Argent Stand, Zim'Torga
					["0.76:0.67:0.73:0.54:0.69:0.42:0.64:0.42"] = 182, -- Westguard Keep, Amberpine Lodge, Light's Breach, Ebon Watch
					["0.76:0.67:0.60:0.52:0.42:0.53:0.22:0.61"] = 387, -- Westguard Keep, Wintergarde Keep, Stars' Rest, Valiance Keep
					["0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 429, -- Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge
					["0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 465, -- Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.76:0.67:0.60:0.52:0.42:0.53:0.21:0.49"] = 385, -- Westguard Keep, Wintergarde Keep, Stars' Rest, Fizzcrank Airstrip
					["0.76:0.67:0.60:0.52:0.46:0.46:0.41:0.43:0.24:0.40"] = 437, -- Westguard Keep, Wintergarde Keep, Fordragon Hold, Valiance Landing Camp, River's Heart

					----------------------------------------------------------------------
					-- Alliance: Icecrown
					----------------------------------------------------------------------

					-- Alliance: Icecrown: Argent Tournament Grounds

					-- Alliance: Icecrown: Death's Rise
					["0.28:0.28:0.52:0.34:0.56:0.36:0.52:0.38"] = 238, -- Death's Rise, Crusaders' Pinnacle, The Argent Vanguard, Dalaran
					["0.28:0.28:0.41:0.43:0.46:0.46"] = 222, -- Death's Rise, Valiance Landing Camp, Fordragon Hold
					["0.28:0.28:0.41:0.43:0.46:0.46:0.60:0.52:0.76:0.67:0.88:0.72"] = 497, -- Death's Rise, Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.28:0.28:0.41:0.43"] = 173, -- Death's Rise, Valiance Landing Camp
					["0.28:0.28:0.24:0.40"] = 118, -- Death's Rise, River's Heart
					["0.28:0.28:0.24:0.40:0.21:0.49"] = 178, -- Death's Rise, River's Heart, Fizzcrank Airstrip

					-- Alliance: Icecrown: The Argent Vanguard
					["0.56:0.36:0.57:0.33"] = 40, -- The Argent Vanguard, Frosthold
					["0.56:0.36:0.52:0.38"] = 33, -- The Argent Vanguard, Dalaran
					["0.56:0.36:0.52:0.38:0.59:0.43:0.60:0.52"] = 148, -- The Argent Vanguard, Dalaran, Windrunner's Overlook, Wintergarde Keep
					["0.56:0.36:0.52:0.38:0.24:0.40"] = 232, -- The Argent Vanguard, Dalaran, River's Heart
					["0.56:0.36:0.52:0.38:0.62:0.36"] = 77, -- The Argent Vanguard, Dalaran, K3
					["0.56:0.36:0.52:0.38:0.24:0.40:0.21:0.49"] = 294, -- The Argent Vanguard, Dalaran, River's Heart, Fizzcrank Airstrip

					----------------------------------------------------------------------
					-- Alliance: Sholazar Basin
					----------------------------------------------------------------------

					-- Alliance: Sholazar Basin: River's Heart
					["0.24:0.40:0.21:0.49"] = 104, -- River's Heart, Fizzcrank Airstrip
					["0.24:0.40:0.52:0.38"] = 302, -- River's Heart, Dalaran
					["0.24:0.40:0.41:0.43:0.46:0.46:0.60:0.52:0.73:0.54:0.88:0.60"] = 705, -- River's Heart, Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.24:0.40:0.52:0.38:0.56:0.36"] = 335, -- River's Heart, Dalaran, The Argent Vanguard
					["0.24:0.40:0.21:0.49:0.17:0.53:0.12:0.53"] = 223, -- River's Heart, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.24:0.40:0.41:0.43:0.46:0.46:0.60:0.52:0.76:0.67:0.88:0.72"] = 711, -- River's Heart, Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.24:0.40:0.41:0.43"] = 225, -- River's Heart, Valiance Landing Camp
					["0.24:0.40:0.21:0.49:0.22:0.61"] = 208, -- River's Heart, Fizzcrank Airstrip, Valiance Keep
					["0.24:0.40:0.21:0.49:0.17:0.53"] = 169, -- River's Heart, Fizzcrank Airstrip, Amber Ledge
					["0.24:0.40:0.28:0.28"] = 141, -- River's Heart, Death's Rise
					["0.24:0.40:0.52:0.38:0.64:0.42:0.72:0.40:0.83:0.46"] = 604, -- River's Heart, Dalaran, Ebon Watch, The Argent Stand, Westfall Brigade

					----------------------------------------------------------------------
					-- Alliance: The Storm Peaks
					----------------------------------------------------------------------

					-- Alliance: The Storm Peaks: Bouldercrag's Refuge
					["0.57:0.21:0.57:0.33:0.56:0.36:0.52:0.38"] = 143, -- Bouldercrag's Refuge, Frosthold, The Argent Vanguard, Dalaran
					["0.57:0.21:0.64:0.19"] = 44, -- Bouldercrag's Refuge, Ulduar
					["0.57:0.21:0.57:0.33:0.62:0.36"] = 127, -- Bouldercrag's Refuge, Frosthold, K3
					["0.57:0.21:0.57:0.33"] = 80, -- Bouldercrag's Refuge, Frosthold
					["0.57:0.21:0.49:0.21:0.52:0.34:0.28:0.28"] = 297, -- Bouldercrag's Refuge, Argent Tournament Grounds, Crusaders' Pinnacle, Death's Rise
					["0.57:0.21:0.64:0.19:0.78:0.38:0.82:0.31"] = 251, -- Bouldercrag's Refuge, Ulduar, Zim'Torga, Gundrak

					-- Alliance: The Storm Peaks: Frosthold
					["0.57:0.33:0.56:0.36:0.52:0.34"] = 61, -- Frosthold, The Argent Vanguard, Crusaders' Pinnacle
					["0.57:0.33:0.62:0.36"] = 49, -- Frosthold, K3
					["0.57:0.33:0.56:0.36:0.52:0.38"] = 64, -- Frosthold, The Argent Vanguard, Dalaran
					["0.57:0.33:0.56:0.36:0.52:0.38:0.24:0.40:0.21:0.49:0.17:0.53"] = 369, -- Frosthold, The Argent Vanguard, Dalaran, River's Heart, Fizzcrank Airstrip, Amber Ledge
					["0.57:0.33:0.56:0.36:0.52:0.38:0.46:0.46:0.42:0.53:0.29:0.57"] = 323, -- Frosthold, The Argent Vanguard, Dalaran, Fordragon Hold, Stars' Rest, Unu'pe
					["0.57:0.33:0.56:0.36:0.52:0.38:0.24:0.40:0.21:0.49"] = 326, -- Frosthold, The Argent Vanguard, Dalaran, River's Heart, Fizzcrank Airstrip
					["0.57:0.33:0.62:0.36:0.64:0.42:0.60:0.52:0.76:0.67"] = 273, -- Frosthold, K3, Ebon Watch, Wintergarde Keep, Westguard Keep
					["0.57:0.33:0.57:0.21"] = 65, -- Frosthold, Bouldercrag's Refuge
					["0.57:0.33:0.62:0.36:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 250, -- Frosthold, K3, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.57:0.33:0.56:0.36:0.52:0.38:0.46:0.46:0.42:0.53:0.22:0.61"] = 354, -- Frosthold, The Argent Vanguard, Dalaran, Fordragon Hold, Stars' Rest, Valiance Keep

					-- Alliance: The Storm Peaks: K3
					["0.62:0.36:0.57:0.33"] = 43, -- K3, Frosthold
					["0.62:0.36:0.64:0.42"] = 44, -- K3, Ebon Watch
					["0.62:0.36:0.59:0.43"] = 54, -- K3, Windrunner's Overlook
					["0.62:0.36:0.52:0.38"] = 72, -- K3, Dalaran
					["0.62:0.36:0.64:0.42:0.54:0.52:0.42:0.53:0.22:0.61"] = 327, -- K3, Ebon Watch, Wyrmrest Temple, Stars' Rest, Valiance Keep
					["0.62:0.36:0.57:0.33:0.56:0.36"] = 77, -- K3, Frosthold, The Argent Vanguard
					["0.62:0.36:0.64:0.42:0.69:0.42:0.73:0.54"] = 172, -- K3, Ebon Watch, Light's Breach, Amberpine Lodge
					["0.62:0.36:0.64:0.42:0.60:0.52"] = 105, -- K3, Ebon Watch, Wintergarde Keep
					["0.62:0.36:0.64:0.42:0.60:0.52:0.76:0.67"] = 225, -- K3, Ebon Watch, Wintergarde Keep, Westguard Keep
					["0.62:0.36:0.64:0.42:0.60:0.52:0.76:0.67:0.88:0.72"] = 293, -- K3, Ebon Watch, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.62:0.36:0.64:0.42:0.72:0.40:0.83:0.46:0.88:0.60"] = 263, -- K3, Ebon Watch, The Argent Stand, Westfall Brigade, Fort Wildervar

					-- Alliance: The Storm Peaks: Ulduar
					["0.64:0.19:0.57:0.33:0.56:0.36:0.52:0.38"] = 167, -- Ulduar, Frosthold, The Argent Vanguard, Dalaran

					----------------------------------------------------------------------
					-- Alliance: Wintergrasp
					----------------------------------------------------------------------

					-- Alliance: Wintergrasp: Valiance Landing Camp
					["0.41:0.43:0.46:0.46"] = 49, -- Valiance Landing Camp, Fordragon Hold
					["0.41:0.43:0.46:0.46:0.64:0.42:0.72:0.40:0.78:0.38:0.82:0.31"] = 325, -- Valiance Landing Camp, Fordragon Hold, Ebon Watch, The Argent Stand, Zim'Torga, Gundrak
					["0.41:0.43:0.46:0.46:0.60:0.52:0.76:0.67:0.88:0.72"] = 325, -- Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.41:0.43:0.46:0.46:0.64:0.42:0.69:0.42"] = 212, -- Valiance Landing Camp, Fordragon Hold, Ebon Watch, Light's Breach
					["0.41:0.43:0.24:0.40"] = 137, -- Valiance Landing Camp, River's Heart
					["0.41:0.43:0.46:0.46:0.60:0.52:0.73:0.54:0.88:0.60"] = 321, -- Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Amberpine Lodge, Fort Wildervar
					["0.41:0.43:0.42:0.53"] = 81, -- Valiance Landing Camp, Stars' Rest
					["0.41:0.43:0.46:0.46:0.60:0.52"] = 136, -- Valiance Landing Camp, Fordragon Hold, Wintergarde Keep
					["0.41:0.43:0.46:0.46:0.60:0.52:0.76:0.67:0.74:0.71"] = 306, -- Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Westguard Keep, Kamagua
					["0.41:0.43:0.46:0.46:0.60:0.52:0.76:0.67"] = 256, -- Valiance Landing Camp, Fordragon Hold, Wintergarde Keep, Westguard Keep
					["0.41:0.43:0.24:0.40:0.21:0.49:0.17:0.53"] = 241, -- Valiance Landing Camp, River's Heart, Fizzcrank Airstrip, Amber Ledge

					----------------------------------------------------------------------
					-- Alliance: Zul'Drak
					----------------------------------------------------------------------

					-- Alliance: Zul'Drak: Ebon Watch
					["0.64:0.42:0.69:0.42"] = 45, -- Ebon Watch, Light's Breach
					["0.64:0.42:0.59:0.43"] = 34, -- Ebon Watch, Windrunner's Overlook
					["0.64:0.42:0.54:0.52:0.42:0.53:0.22:0.61"] = 284, -- Ebon Watch, Wyrmrest Temple, Stars' Rest, Valiance Keep
					["0.64:0.42:0.60:0.52"] = 62, -- Ebon Watch, Wintergarde Keep
					["0.64:0.42:0.52:0.38"] = 68, -- Ebon Watch, Dalaran
					["0.64:0.42:0.72:0.40:0.83:0.46"] = 135, -- Ebon Watch, The Argent Stand, Westfall Brigade
					["0.64:0.42:0.60:0.52:0.76:0.67:0.88:0.72"] = 251, -- Ebon Watch, Wintergarde Keep, Westguard Keep, Valgarde Port
					["0.64:0.42:0.72:0.40"] = 64, -- Ebon Watch, The Argent Stand
					["0.64:0.42:0.60:0.52:0.76:0.67:0.74:0.71"] = 232, -- Ebon Watch, Wintergarde Keep, Westguard Keep, Kamagua

					-- Alliance: Zul'Drak: Gundrak
					["0.82:0.31:0.78:0.38"] = 56, -- Gundrak, Zim'Torga
					["0.82:0.31:0.78:0.38:0.72:0.40"] = 109, -- Gundrak, Zim'Torga, The Argent Stand
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.52:0.38"] = 228, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Dalaran
					["0.82:0.31:0.78:0.38:0.72:0.40:0.69:0.42"] = 132, -- Gundrak, Zim'Torga, The Argent Stand, Light's Breach
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42:0.59:0.43"] = 194, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch, Windrunner's Overlook
					["0.82:0.31:0.78:0.38:0.83:0.46:0.88:0.60:0.88:0.72"] = 270, -- Gundrak, Zim'Torga, Westfall Brigade, Fort Wildervar, Valgarde Port
					["0.82:0.31:0.78:0.38:0.83:0.46:0.88:0.60"] = 197, -- Gundrak, Zim'Torga, Westfall Brigade, Fort Wildervar
					["0.82:0.31:0.78:0.38:0.72:0.40:0.64:0.42"] = 161, -- Gundrak, Zim'Torga, The Argent Stand, Ebon Watch

					-- Alliance: Zul'Drak: Light's Breach
					["0.69:0.42:0.72:0.40"] = 44, -- Light's Breach, The Argent Stand
					["0.69:0.42:0.64:0.42"] = 40, -- Light's Breach, Ebon Watch
					["0.69:0.42:0.64:0.42:0.52:0.38"] = 107, -- Light's Breach, Ebon Watch, Dalaran
					["0.69:0.42:0.72:0.40:0.78:0.38"] = 85, -- Light's Breach, The Argent Stand, Zim'Torga
					["0.69:0.42:0.73:0.54"] = 84, -- Light's Breach, Amberpine Lodge
					["0.69:0.42:0.72:0.40:0.83:0.46"] = 114, -- Light's Breach, The Argent Stand, Westfall Brigade
					["0.69:0.42:0.73:0.54:0.76:0.67:0.88:0.72"] = 236, -- Light's Breach, Amberpine Lodge, Westguard Keep, Valgarde Port
					["0.69:0.42:0.73:0.54:0.76:0.67:0.74:0.71"] = 218, -- Light's Breach, Amberpine Lodge, Westguard Keep, Kamagua
					["0.69:0.42:0.73:0.54:0.76:0.67"] = 167, -- Light's Breach, Amberpine Lodge, Westguard Keep
					["0.69:0.42:0.73:0.54:0.88:0.60"] = 200, -- Light's Breach, Amberpine Lodge, Fort Wildervar

					-- Alliance: Zul'Drak: The Argent Stand
					["0.72:0.40:0.78:0.38"] = 42, -- The Argent Stand, Zim'Torga
					["0.72:0.40:0.69:0.42"] = 25, -- The Argent Stand, Light's Breach
					["0.72:0.40:0.64:0.42"] = 53, -- The Argent Stand, Ebon Watch
					["0.72:0.40:0.64:0.42:0.52:0.38"] = 121, -- The Argent Stand, Ebon Watch, Dalaran
					["0.72:0.40:0.78:0.38:0.82:0.31"] = 95, -- The Argent Stand, Zim'Torga, Gundrak
					["0.72:0.40:0.64:0.42:0.52:0.38:0.56:0.36"] = 141, -- The Argent Stand, Ebon Watch, Dalaran, The Argent Vanguard
					["0.72:0.40:0.69:0.42:0.73:0.54:0.76:0.67"] = 191, -- The Argent Stand, Light's Breach, Amberpine Lodge, Westguard Keep
					["0.72:0.40:0.83:0.46:0.88:0.60:0.88:0.72"] = 230, -- The Argent Stand, Westfall Brigade, Fort Wildervar, Valgarde Port
					["0.72:0.40:0.64:0.42:0.54:0.52:0.42:0.53:0.22:0.61"] = 336, -- The Argent Stand, Ebon Watch, Wyrmrest Temple, Stars' Rest, Valiance Keep
					["0.72:0.40:0.83:0.46"] = 72, -- The Argent Stand, Westfall Brigade

					-- Alliance: Zul'Drak: Zim'Torga
					["0.78:0.38:0.83:0.46"] = 56, -- Zim'Torga, Westfall Brigade
					["0.78:0.38:0.83:0.46:0.88:0.60"] = 142, -- Zim'Torga, Westfall Brigade, Fort Wildervar
					["0.78:0.38:0.82:0.31"] = 54, -- Zim'Torga, Gundrak
					["0.78:0.38:0.83:0.46:0.88:0.60:0.88:0.72"] = 215, -- Zim'Torga, Westfall Brigade, Fort Wildervar, Valgarde Port
					["0.78:0.38:0.72:0.40"] = 54, -- Zim'Torga, The Argent Stand
					["0.78:0.38:0.72:0.40:0.64:0.42:0.52:0.38"] = 173, -- Zim'Torga, The Argent Stand, Ebon Watch, Dalaran
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.42:0.53:0.22:0.61"] = 388, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Stars' Rest, Valiance Keep
					["0.78:0.38:0.83:0.46:0.73:0.54"] = 135, -- Zim'Torga, Westfall Brigade, Amberpine Lodge
					["0.78:0.38:0.83:0.46:0.73:0.54:0.76:0.67"] = 217, -- Zim'Torga, Westfall Brigade, Amberpine Lodge, Westguard Keep
					["0.78:0.38:0.72:0.40:0.69:0.42:0.60:0.52"] = 159, -- Zim'Torga, The Argent Stand, Light's Breach, Wintergarde Keep
					["0.78:0.38:0.83:0.46:0.73:0.54:0.76:0.67:0.74:0.71"] = 268, -- Zim'Torga, Westfall Brigade, Amberpine Lodge, Westguard Keep, Kamagua
					["0.78:0.38:0.72:0.40:0.69:0.42"] = 77, -- Zim'Torga, The Argent Stand, Light's Breach
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.42:0.53:0.29:0.57"] = 357, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Stars' Rest, Unu'pe
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.42:0.53:0.21:0.49:0.17:0.53:0.12:0.53"] = 466, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Stars' Rest, Fizzcrank Airstrip, Amber Ledge, Transitus Shield
					["0.78:0.38:0.72:0.40:0.64:0.42:0.54:0.52:0.42:0.53:0.21:0.49:0.17:0.53"] = 430, -- Zim'Torga, The Argent Stand, Ebon Watch, Wyrmrest Temple, Stars' Rest, Fizzcrank Airstrip, Amber Ledge

				},


			},
		}

	end
