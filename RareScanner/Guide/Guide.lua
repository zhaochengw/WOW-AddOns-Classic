-------------------------------------------------------------------------------
-- AddOn namespace.
-------------------------------------------------------------------------------
local LibStub = _G.LibStub
local FOLDER_NAME, private = ...

-- Locales
local AL = LibStub("AceLocale-3.0"):GetLocale("RareScanner");

-- RareScanner internal libraries
local RSConstants = private.ImportLib("RareScannerConstants")

---============================================================================
-- NPC guide
---============================================================================

private.NPC_GUIDE = {
	["658278"] = { [RSConstants.ENTRANCE] = { x = 0.4997, y = 0.8143 } }; --Clutchmother Zavas
	["820471"] = { [RSConstants.ENTRANCE] = { x = 0.3423, y = 0.4748 } }; --Soriid the Devourer
	["820571"] = { [RSConstants.ENTRANCE] = { x = 0.5553, y = 0.6822 } }; --Haarka the Ravenous
	["1168866"] = { [RSConstants.ENTRANCE] = { x = 0.2936, y = 0.6250 } }; --Cursed Centaur
	["365210"] = { [RSConstants.ENTRANCE] = { x = 0.4038, y = 0.6935 } }; --Trigore the Lasher
	["367210"] = { [RSConstants.ENTRANCE] = { x = 0.4038, y = 0.6935 } }; --Boahn <Druid of the F>
	["47137"] = { [RSConstants.ENTRANCE] = { x = 0.6177, y = 0.5395 } }; --Mother Fang
	["59652"] = { [RSConstants.ENTRANCE] = { x = 0.4374, y = 0.7335 } }; --Brainwashed Noble
	["59952"] = { [RSConstants.ENTRANCE] = { x = 0.4374, y = 0.7335 } }; --Marisa du'Paige
	["58221"] = { [RSConstants.ENTRANCE] = { x = 0.5497, y = 0.097 } }; --Felweaver Scornn
	["1713271533"] = { [RSConstants.TRANSPORT] = { x = 0.391, y = 0.562 } }; --Reekmonger
	["1716881565"] = {
		[RSConstants.PATH_START] = { x = 0.6579, y = 0.2778 };
		[RSConstants.FLAG] = { x = 0.6839, y = 0.2883, comment = AL["NOTE_171688_1"] };
		[RSConstants.ENTRANCE] = { x = 0.6844, y = 0.2945 };
	}; --Faeflayer
	["1678511565"] = { [RSConstants.ENTRANCE] = { x = 0.5856, y = 0.3196 } }; --Egg-Tender Leh'go
	["1643911565"] = { [RSConstants.FLAG] = { x = 0.5107, y = 0.5739, comment = AL["NOTE_164391_1"]  } }; --Old Ardeite
	["1644151565"] = { [RSConstants.ENTRANCE] = { x = 0.3683, y = 0.6029 } }; --Skuld Vit
	["1641121565"] = { [RSConstants.FLAG] = { x = 0.5009, y = 0.2665, comment = AL["NOTE_164112_1"]  } }; --Humon'gozz
	["1681351565"] = {
		[RSConstants.STEP1] = { x = 0.1807, y = 0.62, comment = AL["NOTE_168135_1"] };
		[RSConstants.STEP2] = { x = 0.1897, y = 0.6345, comment = AL["NOTE_168135_2"] };
		[RSConstants.STEP3] = { x = 0.1967, y = 0.6347, comment = AL["NOTE_168135_3"] };
		[RSConstants.STEP4] = { x = 0.510, y = 0.338, comment = AL["NOTE_168135_4"] };
		[RSConstants.STEP5] = { x = 0.5044, y = 0.3306, comment = AL["NOTE_168135_5"] };
		[RSConstants.STEP6] = { x = 0.4530, y = 0.5113, comment = AL["NOTE_168135_6"] };
	}; --Faeflayer
	["1625881536"] = { [RSConstants.FLAG] = { x = 0.5775, y = 0.5153, comment = AL["NOTE_162588_1"] } }; --Gristlebeak
	["1704391533"] = {
		[RSConstants.PATH_START] = { x = 0.5526, y = 0.887 };
		[RSConstants.STEP1] = { x = 0.6002, y = 0.9402, comment = AL["NOTE_170439_1"] };
		[RSConstants.STEP2] = { x = 0.6182, y = 0.8267, comment = AL["NOTE_170439_2"] };
	}; --Sundancer
	["1706591533"] = { [RSConstants.FLAG] = { x = 0.4896, y = 0.5068, comment = AL["NOTE_170659_1"] } }; --Basilofos, King of the Hill
	["1713001533"] = {
		[RSConstants.ENTRANCE] = { x = 0.5637, y = 0.4595 };
		[RSConstants.DOT..1] = { x = 0.545, y = 0.41, comment = AL["NOTE_171300_1"] };
		[RSConstants.DOT..2] = { x = 0.55, y = 0.402, comment = AL["NOTE_171300_1"] };
		[RSConstants.DOT..3] = { x = 0.5726, y = 0.4792, comment = AL["NOTE_171300_1"] };
	}; --Corrupted Clawguard
	["1634601533"] = { [RSConstants.ENTRANCE] = { x = 0.4091, y = 0.4724 } }; --Dionae
	["1670781533"] = { 
		[RSConstants.FLAG] = { x = 0.6422, y = 0.199, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
		[RSConstants.STEP1] = { x = 0.4165, y = 0.5453, comment = AL["NOTE_167078_1"] } 
	}; --Wingflayer the Cruel
	["1563391533"] = { 
		[RSConstants.FLAG] = { x = 0.6422, y = 0.199, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
		[RSConstants.TRANSPORT..1] = { x = 0.2456, y = 0.225 };
	}; --Eliminator Sotiros
	["1563401533"] = { 
		[RSConstants.FLAG] = { x = 0.6422, y = 0.199, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
		[RSConstants.TRANSPORT..1] = { x = 0.2456, y = 0.225 };
	}; --Larionrider Orstus
	["1627411536"] = { 
		[RSConstants.FLAG] = { x = 0.5017, y = 0.6957, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
	}; --Gieger <Experimental Construct>
	["1681471536"] = { 
		[RSConstants.FLAG] = { x = 0.5017, y = 0.6957, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
	}; --Sabreil the Bonecleaver
	["1681481536"] = { 
		[RSConstants.FLAG] = { x = 0.5017, y = 0.6957, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
	}; --Drolkrad
	["1594961525"] = { 
		[RSConstants.FLAG] = { x = 0.2537, y = 0.2869, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
	}; --Forgemaster Madalav
	["1686471565"] = { 
		[RSConstants.FLAG] = { x = 0.4594, y = 0.5366, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
	}; --Valfir the Unrelenting
	["1652901525"] = {
		[RSConstants.FLAG] = { x = 0.2537, y = 0.2869, comment = AL["GUIDE_ANIMA_CONDUCTOR"] };
		[RSConstants.STEP1] = { x = 0.4077, y = 0.7270, comment = AL["NOTE_165290_1"] };
		[RSConstants.STEP2] = { x = 0.4118, y = 0.7467, comment = AL["NOTE_165290_1"] };
		[RSConstants.STEP3] = { x = 0.46, y = 0.79, comment = AL["NOTE_165290_2"] };
		[RSConstants.STEP4] = { x = 0.4323, y = 0.7762, comment = AL["NOTE_165290_3"] };
		[RSConstants.STEP5] = { x = 0.463, y = 0.7786, comment = AL["NOTE_165290_4"] };
	}; --Harika the Horrid
	["1712111533"] = {
		[RSConstants.DOT..1] = { x = 0.3141, y = 0.2295, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..2] = { x = 0.3317, y = 0.2386, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..3] = { x = 0.3317, y = 0.2321, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..4] = { x = 0.3212, y = 0.2305, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..5] = { x = 0.3256, y = 0.2449, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..6] = { x = 0.3306, y = 0.2071, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..7] = { x = 0.3305, y = 0.2123, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..8] = { x = 0.3233, y = 0.2113, comment = AL["NOTE_171211_1"] };
		[RSConstants.DOT..9] = { x = 0.3276, y = 0.2035, comment = AL["NOTE_171211_1"] };
	}; --Aspirant Eolis
	["1708321533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.3956, y = 0.5616 };
		[RSConstants.DOT..1] = { x = 0.3342, y = 0.5964, comment = AL["NOTE_170832_1"] };
		[RSConstants.TRANSPORT..2] = { x = 0.6931, y = 0.4039 };
		[RSConstants.DOT..2] = { x = 0.7190, y = 0.3894, comment = AL["NOTE_170832_2"] };
		[RSConstants.TRANSPORT..3] = { x = 0.6365, y = 0.7227 };
		[RSConstants.DOT..3] = { x = 0.6431, y = 0.6997, comment = AL["NOTE_170832_3"] };
		[RSConstants.TRANSPORT..4] = { x = 0.4154, y = 0.2347 };
		[RSConstants.DOT..4] = { x = 0.3915, y = 0.2037, comment = AL["NOTE_170832_4"] };
		[RSConstants.DOT..5] = { x = 0.3216, y = 0.1788, comment = AL["NOTE_170832_5"] };
	}; --Champion of Loyalty
	["1708331533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.3956, y = 0.5616 };
		[RSConstants.DOT..1] = { x = 0.3342, y = 0.5964, comment = AL["NOTE_170832_1"] };
		[RSConstants.TRANSPORT..2] = { x = 0.6931, y = 0.4039 };
		[RSConstants.DOT..2] = { x = 0.7190, y = 0.3894, comment = AL["NOTE_170832_2"] };
		[RSConstants.TRANSPORT..3] = { x = 0.6365, y = 0.7227 };
		[RSConstants.DOT..3] = { x = 0.6431, y = 0.6997, comment = AL["NOTE_170832_3"] };
		[RSConstants.TRANSPORT..4] = { x = 0.4154, y = 0.2347 };
		[RSConstants.DOT..4] = { x = 0.3915, y = 0.2037, comment = AL["NOTE_170832_4"] };
		[RSConstants.DOT..5] = { x = 0.3216, y = 0.1788, comment = AL["NOTE_170832_5"] };
	}; --Champion of Wisdom
	["1708341533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.3956, y = 0.5616 };
		[RSConstants.DOT..1] = { x = 0.3342, y = 0.5964, comment = AL["NOTE_170832_1"] };
		[RSConstants.TRANSPORT..2] = { x = 0.6931, y = 0.4039 };
		[RSConstants.DOT..2] = { x = 0.7190, y = 0.3894, comment = AL["NOTE_170832_2"] };
		[RSConstants.TRANSPORT..3] = { x = 0.6365, y = 0.7227 };
		[RSConstants.DOT..3] = { x = 0.6431, y = 0.6997, comment = AL["NOTE_170832_3"] };
		[RSConstants.TRANSPORT..4] = { x = 0.4154, y = 0.2347 };
		[RSConstants.DOT..4] = { x = 0.3915, y = 0.2037, comment = AL["NOTE_170832_4"] };
		[RSConstants.DOT..5] = { x = 0.3216, y = 0.1788, comment = AL["NOTE_170832_5"] };
	}; --Champion of Purity
	["1708351533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.3956, y = 0.5616 };
		[RSConstants.DOT..1] = { x = 0.3342, y = 0.5964, comment = AL["NOTE_170832_1"] };
		[RSConstants.TRANSPORT..2] = { x = 0.6931, y = 0.4039 };
		[RSConstants.DOT..2] = { x = 0.7190, y = 0.3894, comment = AL["NOTE_170832_2"] };
		[RSConstants.TRANSPORT..3] = { x = 0.6365, y = 0.7227 };
		[RSConstants.DOT..3] = { x = 0.6431, y = 0.6997, comment = AL["NOTE_170832_3"] };
		[RSConstants.TRANSPORT..4] = { x = 0.4154, y = 0.2347 };
		[RSConstants.DOT..4] = { x = 0.3915, y = 0.2037, comment = AL["NOTE_170832_4"] };
		[RSConstants.DOT..5] = { x = 0.3216, y = 0.1788, comment = AL["NOTE_170832_5"] };
	}; --Champion of Courage
	["1708361533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.3956, y = 0.5616 };
		[RSConstants.DOT..1] = { x = 0.3342, y = 0.5964, comment = AL["NOTE_170832_1"] };
		[RSConstants.TRANSPORT..2] = { x = 0.6931, y = 0.4039 };
		[RSConstants.DOT..2] = { x = 0.7190, y = 0.3894, comment = AL["NOTE_170832_2"] };
		[RSConstants.TRANSPORT..3] = { x = 0.6365, y = 0.7227 };
		[RSConstants.DOT..3] = { x = 0.6431, y = 0.6997, comment = AL["NOTE_170832_3"] };
		[RSConstants.TRANSPORT..4] = { x = 0.4154, y = 0.2347 };
		[RSConstants.DOT..4] = { x = 0.3915, y = 0.2037, comment = AL["NOTE_170832_4"] };
		[RSConstants.DOT..5] = { x = 0.3216, y = 0.1788, comment = AL["NOTE_170832_5"] };
	}; --Champion of Humility
	["1591561525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Grand Inquisitor Nicu
	["1591571525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Grand Inquisitor Aurica
	["1591511525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Inquisitor Traian
	["1569191525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Inquisitor Petre
	["1569161525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Inquisitor Sorin
	["1591531525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --High Inquisitor Radu
	["1591521525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --High Inquisitor Gabi
	["1591551525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --High Inquisitor Dacian
	["1569181525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --Inquisitor Otilia
	["1591541525"] = {
		[RSConstants.FLAG..1] = { x = 0.716, y = 0.40, comment = AL["GUIDE_ABUSE_OF_POWER"] };
		[RSConstants.FLAG..2] = { x = 0.76, y = 0.518, comment = AL["GUIDE_SINSTONE_QUEST"] };
	}; --High Inquisitor Magda
	["1652061525"] = { [RSConstants.FLAG] = { x = 0.6667, y = 0.5931, comment = AL["NOTE_165206_1"] } }; --Endlurker
	["1700481525"] = { [RSConstants.FLAG] = { x = 0.49, y = 0.348, comment = AL["NOTE_170048_1"] } }; --Manifestation of Wrath
	["1579641543"] = { [RSConstants.PATH_START] = { x = 0.235, y = 0.347 } }; --Adjutant Dekaris
	["1725771543"] = { [RSConstants.FLAG] = { x = 0.268, y = 0.293, comment = AL["NOTE_172577_1"] } }; --Adjutant Dekaris
	["1725211543"] = { [RSConstants.ENTRANCE] = { x = 0.558, y = 0.675 } }; --Sanngror the Torturer
	["1758211543"] = { [RSConstants.ENTRANCE] = { x = 0.2081, y = 0.394 } }; --Ratgusher <10,000 Mawrats in a Suit of Armor>
	["1725241543"] = { [RSConstants.ENTRANCE] = { x = 0.593, y = 0.8 } }; --Skittering Broodmother
	["1651521525"] = { [RSConstants.ENTRANCE] = { x = 0.6728, y = 0.8234 } }; --Leeched Soul
	["1651751525"] = { [RSConstants.ENTRANCE] = { x = 0.6728, y = 0.8234 } }; --Prideful Hulk
	["1710141533"] = { 
		[RSConstants.STEP1] = { x = 0.6621, y = 0.4411, comment = AL["NOTE_171014_1"] }; 
		[RSConstants.STEP2] = { x = 0.659, y = 0.4419, comment = AL["NOTE_171014_2"] }; 
		[RSConstants.STEP3] = { x = 0.6581, y = 0.4402, comment = AL["NOTE_171014_3"] }; 
		[RSConstants.STEP4] = { x = 0.6573, y = 0.4349, comment = AL["NOTE_171014_4"] }; 
		[RSConstants.STEP5] = { x = 0.6595, y = 0.4322, comment = AL["NOTE_171014_5"] }; 
		[RSConstants.STEP6] = { x = 0.6619, y = 0.4328, comment = AL["NOTE_171014_6"] }; 
		[RSConstants.FLAG] = { x = 0.66, y = 0.436, comment = AL["NOTE_171014_8"] }; 
		[RSConstants.STEP7..1] = { x = 0.6628, y = 0.4352, comment = AL["NOTE_171014_7"] }; 
		[RSConstants.STEP7..2] = { x = 0.6542, y = 0.4451, comment = AL["NOTE_171014_7"] }; 
		[RSConstants.STEP7..3] = { x = 0.6507, y = 0.4138, comment = AL["NOTE_171014_7"] }; 
		[RSConstants.STEP7..4] = { x = 0.6581, y = 0.445, comment = AL["NOTE_171014_7"] }; 
		[RSConstants.STEP7..5] = { x = 0.6538, y = 0.4291, comment = AL["NOTE_171014_7"] }; 
	}; --Collector Astorestes
	["1734681525"] = { 
		[RSConstants.STEP1] = { x = 0.6845, y = 0.6041, comment = AL["NOTE_173468_1"] };
		[RSConstants.STEP2] = { x = 0.634, y = 0.618, comment = AL["NOTE_173468_2"], questID = 62042 }; --62107
		[RSConstants.STEP3.."1"] = { x = 0.7395, y = 0.581, comment = AL["NOTE_173468_3"], questID = 62047 }; --62107
		[RSConstants.STEP3.."2"] = { x = 0.7054, y = 0.5811, comment = AL["NOTE_173468_3"], questID = 62047 };
		[RSConstants.STEP3.."3"] = { x = 0.6423, y = 0.5881, comment = AL["NOTE_173468_3"], questID = 62047 };
		[RSConstants.STEP3.."4"] = { x = 0.679, y = 0.6836, comment = AL["NOTE_173468_3"], questID = 62047 };
		[RSConstants.STEP3.."5"] = { x = 0.6279, y = 0.667, comment = AL["NOTE_173468_3"], questID = 62047 };
		[RSConstants.STEP3.."6"] = { x = 0.6113, y = 0.6933, comment = AL["NOTE_173468_3"], questID = 62047 };
		[RSConstants.STEP4] = { x = 0.6301, y = 0.6181, comment = AL["NOTE_173468_4"], questID = 62049 }; --62107
		[RSConstants.STEP5] = { x = 0.51, y = 0.788, comment = AL["NOTE_173468_5"], questID = 62048 }; --62107
		[RSConstants.STEP6] = { x = 0.408, y = 0.468, comment = AL["NOTE_173468_6"], questID = 62050 };
	}; --Blanchy's Reins
	["1571251536"] = { 
		[RSConstants.FLAG] = { x = 0.264, y = 0.4272, comment = AL["NOTE_157125_1"] }; --Zargox the Reborn
	};
	["1645471565"] = { 
		[RSConstants.DOT..1] = { x = 0.27, y = 0.45, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..2] = { x = 0.448, y = 0.2, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..3] = { x = 0.5, y = 0.2, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..4] = { x = 0.5837, y = 0.6104, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..5] = { x = 0.41, y = 0.71, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..6] = { x = 0.554, y = 0.558, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..7] = { x = 0.25, y = 0.5, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..8] = { x = 0.39, y = 0.6, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
		[RSConstants.DOT..9] = { x = 0.3, y = 0.36, comment = AL["NOTE_164547_1"] }; --Mystic Rainbowhorn
	};
	["1607701543"] = { [RSConstants.ENTRANCE] = { x = 0.593, y = 0.517 } }; --Darithis the Bleak
	["1800321961"] = { [RSConstants.FLAG] = { x = 0.567, y = 0.3218, comment = AL["NOTE_180032_1"] } }; --Wild Worldcracker
	["1773361961"] = { [RSConstants.ENTRANCE] = { x = 0.3028, y = 0.55 } }; --Zelnithop
	["1799311961"] = { [RSConstants.FLAG] = { x = 0.29, y = 0.4463, comment = AL["NOTE_179931_1"] } }; --Relic Breaker Krelva
	["1796841961"] = { [RSConstants.FLAG] = { x = 0.6066, y = 0.231, comment = AL["NOTE_179684_1"] } }; --Malbog
	["1802461543"] = { [RSConstants.FLAG] = { x = 0.6521, y = 0.8446, comment = AL["NOTE_180246_1"] } }; --Carriage Crusher
	["1798831543"] = { [RSConstants.FLAG] = { x = 0.4473, y = 0.5142, comment = AL["NOTE_179883_1"] } }; --Zovaal's Vault
	["1801601961"] = { [RSConstants.FLAG] = { x = 0.5627, y = 0.6618, comment = AL["NOTE_180160_1"] } }; --Zovaal's Vault
	["1797911543"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.6686, y = 0.5632 }; 
		[RSConstants.STEP1..1] = { x = 0.6559, y = 0.5864, comment = AL["NOTE_179791_1"] }; 
		[RSConstants.STEP2..1] = { x = 0.6685, y = 0.5934, comment = AL["NOTE_179791_1"] }; 
		[RSConstants.ENTRANCE..2] = { x = 0.632, y = 0.4377 }; 
		[RSConstants.STEP1..2] = { x = 0.6165, y = 0.4507, comment = AL["NOTE_179791_1"] }; 
		[RSConstants.STEP2..2] = { x = 0.623, y = 0.4612, comment = AL["NOTE_179791_1"] }; 
	}; --Zelnithop
	["1798021961"] = { [RSConstants.TRANSPORT] = { x = 0.3935, y = 0.524 } }; --Yarxhov the Pillager
	["1798591961"] = { [RSConstants.TRANSPORT] = { x = 0.4499, y = 0.3558 } }; --Xyraxz the Unknowable
	["1796081961"] = { [RSConstants.TRANSPORT] = { x = 0.4105, y = 0.4166, comment = AL["NOTE_RIFT_PORTAL"] } }; --Screaming Shade
	["1799111961"] = { [RSConstants.TRANSPORT] = { x = 0.4105, y = 0.4166, comment = AL["NOTE_RIFT_PORTAL"] } }; --Silent Soulstalker
	["1799131961"] = { [RSConstants.TRANSPORT] = { x = 0.5938, y = 0.5378, comment = AL["NOTE_RIFT_PORTAL"] } }; --Deadsoul Hatcher
	["1799141961"] = { [RSConstants.TRANSPORT] = { x = 0.5371, y = 0.7181, comment = AL["NOTE_RIFT_PORTAL"] } }; --Observer Yorik
	["1799111961"] = { [RSConstants.TRANSPORT] = { x = 0.5371, y = 0.7181, comment = AL["NOTE_RIFT_PORTAL"] } }; --Silent Soulstalker
	["1839251970"] = { [RSConstants.TRANSPORT] = { x = 0.506, y = 0.319 , comment = AL["NOTE_183925_1"] } }; --Tahkwitz
	["1836461970"] = { 
		[RSConstants.STEP1] = { x = 0.64, y = 0.573, comment = AL["NOTE_183646_1"] }; --Star Empowered Key
		[RSConstants.STEP2] = { x = 0.6259, y = 0.5982, comment = AL["NOTE_183646_2"] }; --Cube Empowered Key
		[RSConstants.STEP3] = { x = 0.6448, y = 0.6041, comment = AL["NOTE_183646_3"] }; --Orb Empowered Key
	}; --Furidian
	["1787781970"] = { 
		[RSConstants.STEP1] = { x = 0.5203, y = 0.9378 , comment = AL["NOTE_178778_1"] };
		[RSConstants.STEP2] = { x = 0.524, y = 0.928 , comment = AL["NOTE_178778_1"] };
		[RSConstants.STEP3] = { x = 0.532, y = 0.930 , comment = AL["NOTE_178778_1"] }; 
		[RSConstants.STEP4] = { x = 0.534, y = 0.908 , comment = AL["NOTE_178778_1"] };
		[RSConstants.STEP5] = { x = 0.540, y = 0.912 , comment = AL["NOTE_178778_1"] };
	}; --Gluttonous Overgrowth
	["1785081970"] = { [RSConstants.ENTRANCE] = { x = 0.5597, y = 0.3260 } }; --Mother Phestis
	["1807461970"] = { 
		[RSConstants.STEP1] = { x = 0.406, y = 0.239, comment = AL["NOTE_180746_1"] }; --Mysterious Cypher V´
		[RSConstants.STEP2] = { x = 0.424, y = 0.268, comment = AL["NOTE_180746_1"] }; --Mysterious Cypher N
		[RSConstants.STEP3] = { x = 0.430, y = 0.251, comment = AL["NOTE_180746_1"] }; --Mysterious Cypher,V,
		[RSConstants.STEP4] = { x = 0.414, y = 0.244, comment = AL["NOTE_180746_1"] }; --Mysterious Cypher <>
	}; --Furidian
	["1809781970"] = { [RSConstants.FLAG] = { x = 0.5186, y = 0.7431, comment = AL["NOTE_180978_1"] } }; --Hirukon (Strange Goop)
	["1809781536"] = { [RSConstants.FLAG] = { x = 0.576, y = 0.92, comment = AL["NOTE_180978_2"] } }; --Hirukon (Baroness Vashj)
	["180978102"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5032, y = 0.4095 };
		[RSConstants.FLAG] = { x = 0.522, y = 0.379, comment = AL["NOTE_180978_3"] };
	}; --Hirukon (Pungent Blobfish)
	["1809781355"] = { [RSConstants.FLAG] = { x = 0.728, y = 0.243, comment = AL["NOTE_180978_4"] } }; --Hirukon (Flipper Fish)
	["180978205"] = { [RSConstants.FLAG] = { x = 0.347, y = 0.75, comment = AL["NOTE_180978_5"] } }; --Hirukon (Flipper Fish)
	["1879452022"] = { 
		[RSConstants.PATH_START] = { x = 0.5696, y = 0.3815 };
	}; --Anhydros the Tidetaker
	["1909712022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2727, y = 0.6100 };
	}; --Shas'ith
	["1892892022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2727, y = 0.6100 };
	}; --Penumbrus
	["1932382024"] = {
		[RSConstants.DOT..1] = { x = 0.5293, y = 0.3710, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..2] = { x = 0.5339, y = 0.3655, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..3] = { x = 0.522, y = 0.3733, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..4] = { x = 0.5167, y = 0.3681, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..5] = { x = 0.5194, y = 0.3564, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..6] = { x = 0.5407, y = 0.3718, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..7] = { x = 0.5401, y = 0.3629, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..8] = { x = 0.5416, y = 0.3466, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.DOT..9] = { x = 0.5348, y = 0.3474, comment = AL["NOTE_193238_1"] }; 
		[RSConstants.FLAG] = { x = 0.5388, y = 0.3560, comment = AL["NOTE_193238_2"] }; 
	}; --Spellwrought Snowman
	["1848532022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.8174, y = 0.3713 };
	}; --Primal Scythid Queen
	["1960102023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3642, y = 0.5339 };
	}; --Researcher Sneakwing <The Sundered Flame>
	["1909912022"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.3063, y = 0.5147 };
		[RSConstants.ENTRANCE..2] = { x = 0.2942, y = 0.5272 };
	}; --Char
	["1936582025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4460, y = 0.6774 };
	}; --Corrupted Proto-Dragon
	["1932202025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5936, y = 0.6967 };
	}; --Broodweaver Araznae <Mother of Spiders>
	["1932542023"] = { 
		[RSConstants.FLAG] = { x = 0.8571, y = 0.2072, comment = AL["NOTE_193254_1"] };
	}; --Bloodgullet
	["1931762025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3857, y = 0.7658 };
	}; --Sandana the Tempest <Timesand Thief>
	["1936882025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6068, y = 0.6062 };
	}; --Phenran
	["1932712022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4833, y = 0.7416 };
		[RSConstants.STEP1] = { x = 0.4772, y = 0.7447, comment = AL["NOTE_193271_2"] };
		[RSConstants.STEP2] = { x = 0.4775, y = 0.7370, comment = AL["NOTE_193271_1"] };
		[RSConstants.STEP3] = { x = 0.4684, y = 0.7355, comment = AL["NOTE_193271_3"] };
	}; --Shadeslash Trakken
	["1931322022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6261, y = 0.5461 };
	}; --Amethyzar the Glittering
	["1929832023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4339, y = 0.4777 };
	}; --Web-Queen Ashkaz
	["1931962024"] = { 
		[RSConstants.STEP1] = { x = 0.7035, y = 0.2409, comment = AL["NOTE_193196_1"] };
		[RSConstants.STEP2] = { x = 0.7022, y = 0.2534, comment = AL["NOTE_193196_2"] };
	}; --Trilvarus Loreweaver
	["1936982024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6445, y = 0.3020 };
	}; --Frigidpelt Den Mother
	["1980042024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4034, y = 0.4846 };
	}; --Mange the Outcast
	["1917292118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3359, y = 0.4348 };
	}; --Deathrip
	["1917132118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3366, y = 0.3358 };
	}; --Scytherin
	["1863552118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5999, y = 0.5916 };
	}; --Tripletath the Lost
	["1818332118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.7327, y = 0.3899 };
	}; --Shimmermaw
	["1814272118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5632, y = 0.4496 };
	}; --Stormspine
	["1913052025"] = { 
		[RSConstants.FLAG] = { x = 0.3833, y = 0.6850, comment = AL["NOTE_191305_1"] };
	}; --The Great Shellkhan (Patient Vargoo)
	["1913052024"] = { 
		[RSConstants.FLAG] = { x = 0.4563, y = 0.5480, comment = AL["NOTE_191305_2"] };
	}; --The Great Shellkhan (gleamfish)
	["1931282023"] = { 
		[RSConstants.FLAG] = { x = 0.9008, y = 0.4045, comment = AL["NOTE_193128_1"] };
	}; --Blightpaw the Depraved
	["1936912024"] = { 
		[RSConstants.STEP1] = { x = 0.5052, y = 0.3672, comment = AL["NOTE_193691_1"] };
		[RSConstants.STEP2] = { x = 0.4997, y = 0.3821, comment = AL["NOTE_193691_2"] };
		[RSConstants.STEP3] = { x = 0.4922, y = 0.3842, comment = AL["NOTE_193691_3"] };
	}; --Fisherman Tinnak <Angered Ghost>
	["1909852022"] = { 
		[RSConstants.FLAG] = { x = 0.276, y = 0.564, comment = AL["NOTE_190985_1"] };
	}; --Death's Shadow
	["1898222022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2711, y = 0.6073 };
		[RSConstants.FLAG] = { x = 0.268, y = 0.624, comment = AL["NOTE_189822_1"] };
	}; --Shas'ith
	["1873062022"] = { 
		[RSConstants.FLAG] = { x = 0.322, y = 0.524, comment = AL["NOTE_187306_1"] };
	}; --Morchok <Harbinger of Twilight>
	["1881242023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.792, y = 0.3655 };
	}; --Irontree
	["1932252024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2062, y = 0.4979 };
	}; --Notfar the Unbearable
	["1931422023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5636, y = 0.8168 };
	}; --Enraged Sapphire
	["1868592022"] = { 
		[RSConstants.DOT..1] = { x = 0.3117, y = 0.5476, comment = AL["NOTE_186859_1"] };
		[RSConstants.DOT..2] = { x = 0.2859, y = 0.5325, comment = AL["NOTE_186859_1"] };
		[RSConstants.DOT..3] = { x = 0.3120, y = 0.5780, comment = AL["NOTE_186859_1"] };
	}; --Worldcarver A'tir
	["1931342022"] = { 
		[RSConstants.DOT..1] = { x = 0.2229, y = 0.7534, comment = AL["NOTE_193134_1"] };
		[RSConstants.DOT..2] = { x = 0.2270, y = 0.7181, comment = AL["NOTE_193134_1"] };
		[RSConstants.DOT..3] = { x = 0.2252, y = 0.6929, comment = AL["NOTE_193134_1"] };
		[RSConstants.DOT..4] = { x = 0.2208, y = 0.6685, comment = AL["NOTE_193134_1"] };
		[RSConstants.DOT..5] = { x = 0.2260, y = 0.7337, comment = AL["NOTE_193134_1"] };
	}; --Enkine the Voracious
	["1880952023"] = { 
		[RSConstants.FLAG] = { x = 0.8051, y = 0.4216, comment = AL["NOTE_188095_1"] };
	}; --Hunter of the Deep
	["1931782024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.1371, y = 0.2209 };
		[RSConstants.FLAG] = { x = 0.1340, y = 0.2220, comment = AL["NOTE_193178_1"] };
	}; --Blightfur
	["1973712022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
	["1973712023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
	["1973712024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
--	["1973712025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Snufflegust <Lunker>
	["1937352022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Moth'go Deeploom <Lunker>
	["1937352023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Moth'go Deeploom <Lunker>
	["1937352024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Moth'go Deeploom <Lunker>
--	["1937352025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Moth'go Deeploom <Lunker>
	["1936342022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Swog'ranka <Lunker>
	["1936342023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Swog'ranka <Lunker>
	["1936342024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Swog'ranka <Lunker>
--	["1936342025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Swog'ranka <Lunker>
	["1937102022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Seereel, the Spring <Lunker>
	["1937102023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Seereel, the Spring <Lunker>
	["1937102024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Seereel, the Spring <Lunker>
--	["1937102025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Seereel, the Spring <Lunker>
	["1937082022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Skald the Impaler <Lunker>
	["1937082023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Skald the Impaler <Lunker>
	["1937082024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Skald the Impaler <Lunker>
--	["1937082025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Skald the Impaler <Lunker>
--	["1974112022"] = { 
--		[RSConstants.FLAG] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
--		[RSConstants.FLAG] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Astray Splasher <Lunker>
--	["1974112023"] = { 
--		[RSConstants.FLAG] = { x = 0.7488, y = 0.7994, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Astray Splasher <Lunker>
--	["1974112024"] = { 
--		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Astray Splasher <Lunker>
--	["1974112025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Astray Splasher <Lunker>
	["1937062022"] = { 
		[RSConstants.FLAG..1] = { x = 0.6713, y = 0.7442, comment = AL["NOTE_OMINOUS_CONCHS"] };
		[RSConstants.FLAG..2] = { x = 0.3382, y = 0.6453, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
	["1937062023"] = { 
		[RSConstants.FLAG] = { x = 0.8208, y = 0.7827, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
	["1937062024"] = { 
		[RSConstants.FLAG] = { x = 0.5911, y = 0.3292, comment = AL["NOTE_OMINOUS_CONCHS"] };
	}; --Snufflegust <Lunker>
--	["1937062025"] = { 
--		[RSConstants.FLAG] = { x = 0.5646, y = 0.6562, comment = AL["NOTE_OMINOUS_CONCHS"] };
--	}; --Snufflegust <Lunker>
	["1918422023"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.7775, y = 0.8088 };
		[RSConstants.ENTRANCE..2] = { x = 0.7881, y = 0.8106 };
		[RSConstants.ENTRANCE..3] = { x = 0.7687, y = 0.8188 };
		[RSConstants.ENTRANCE..4] = { x = 0.7702, y = 0.8299 };
	}; --Sulfurion
	["1943902024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.0848, y = 0.4893 };
	}; --Barnacle Brashe
	["1943922024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.0848, y = 0.4893 };
	}; --Brackle
	["1931752022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3615, y = 0.8982 };
	}; --Slurpo, the Incredible Snail
	["1931752024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.1093, y = 0.4156, comment = AL["NOTE_193175_1"] };
		[RSConstants.FLAG] = { x = 0.1161, y = 0.4106, comment = AL["NOTE_193175_2"] };
	}; --Slurpo, the Incredible Snail
	["1932662022"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.3578, y = 0.8433 };
		[RSConstants.ENTRANCE..2] = { x = 0.3544, y = 0.8241 };
		[RSConstants.ENTRANCE..3] = { x = 0.3458, y = 0.8211 };
		[RSConstants.FLAG] = { x = 0.3461, y = 0.8276, comment = AL["NOTE_193266_1"] };
	}; --Lepidoralia the Resplendent
	["1913562024"] = { 
		[RSConstants.STEP1] = { x = 0.5867, y = 0.4340, comment = AL["NOTE_191356_1"] };
		[RSConstants.STEP2] = { x = 0.5832, y = 0.4375, comment = AL["NOTE_191356_2"] };
	}; --Frostpaw
	["1936642025"] = { 
		[RSConstants.DOT..1] = { x = 0.5800, y = 0.5260, comment = AL["NOTE_193664_1"] };
		[RSConstants.DOT..2] = { x = 0.6100, y = 0.5680, comment = AL["NOTE_193664_1"] };
		[RSConstants.DOT..3] = { x = 0.5980, y = 0.6260, comment = AL["NOTE_193664_1"] };
		[RSConstants.DOT..4] = { x = 0.5760, y = 0.6060, comment = AL["NOTE_193664_1"] };
		[RSConstants.FLAG..1] = { x = 0.5944, y = 0.6070, comment = AL["NOTE_193664_2"] };
	}; --Ancient Protector
	["1932152023"] = { 
		[RSConstants.FLAG] = { x = 0.1660, y = 0.5120, comment = AL["NOTE_193215_1"] };
	}; --Scaleseeker Mezeri
	["1932152025"] = { 
		[RSConstants.FLAG] = { x = 0.3900, y = 0.4620, comment = AL["NOTE_193215_2"] };
	}; --Scaleseeker Mezeri
	["1932412025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6172, y = 0.8120 };
	}; --Lord Epochbrgl <Time-Lost>
	["1839842025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4753, y = 0.7168 };
		[RSConstants.FLAG] = { x = 0.4627, y = 0.7317, comment = AL["NOTE_183984_1"] };
	}; --The Weeping Vilomah
	["1925572023"] = { 
		[RSConstants.FLAG] = { x = 0.7043, y = 0.6349, comment = AL["NOTE_192557_1"] };
	}; --Quackers the Terrible
	["1919502023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5969, y = 0.6848 };
		[RSConstants.DOT..1] = { x = 0.5050, y = 0.7020, comment = AL["NOTE_191950_1"] };
		[RSConstants.DOT..2] = { x = 0.5270, y = 0.6580, comment = AL["NOTE_191950_1"] };
		[RSConstants.DOT..3] = { x = 0.5460, y = 0.6940, comment = AL["NOTE_191950_1"] };
		[RSConstants.DOT..4] = { x = 0.5210, y = 0.7050, comment = AL["NOTE_191950_1"] };
		[RSConstants.DOT..5] = { x = 0.5310, y = 0.7200, comment = AL["NOTE_191950_1"] };
		[RSConstants.DOT..6] = { x = 0.4970 , y = 0.6870, comment = AL["NOTE_191950_1"] };		
		[RSConstants.DOT..7] = { x = 0.5273 , y = 0.6993, comment = AL["NOTE_191950_1"] };		
		[RSConstants.DOT..8] = { x = 0.5376 , y = 0.6746, comment = AL["NOTE_191950_1"] };	
	}; --Porta the Overgrown
	["2006812151"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.4366, y = 0.5859 };
		[RSConstants.ENTRANCE..2] = { x = 0.4203, y = 0.5836 };
		[RSConstants.ENTRANCE..3] = { x = 0.4134, y = 0.6052 };
		[RSConstants.ENTRANCE..4] = { x = 0.4170, y = 0.6200 };
	}; --Bonesifter Marwak
	["2006102151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3673, y = 0.3245 };
	}; --Duzalgor <Guardian of the Noxious Brood>
	["2005372151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2675, y = 0.4169 };
	}; --Gahz'raxes <Spawn of Gahz'ragon>
	["2009602151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5190, y = 0.5982 };
	}; --Warden Entrix <Hand of Lapisagos>
	["2009602102"] = { 
		[RSConstants.TRANSPORT..1] = { x = 0.4991, y = 0.5426 };
		[RSConstants.TRANSPORT..2] = { x = 0.4697, y = 0.4737 };
	}; --Warden Entrix <Hand of Lapisagos>
	["2009782151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5190, y = 0.5982 };
	}; --Pyrachniss
	["2009782102"] = { 
		[RSConstants.TRANSPORT] = { x = 0.6799, y = 0.4921 };
	}; --Pyrachniss
	["2005842151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5904, y = 0.4961 };
	}; --Vraken the Hunter
	["2009042151"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.7224, y = 0.6474 };
		[RSConstants.ENTRANCE..2] = { x = 0.7070, y = 0.6645 };
		[RSConstants.ENTRANCE..3] = { x = 0.7092, y = 0.6879 };
		[RSConstants.ENTRANCE..4] = { x = 0.7191, y = 0.6972 };
	}; --Veltrax
	["2009112151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.7448, y = 0.5460 };
	}; --Volcanakk
	["2006002151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4676, y = 0.1920 };
	}; --Reisa the Drowned
	["2008852151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6144, y = 0.5821 };
	}; --Lady Shaz'ra
	["2011812151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6936, y = 0.4631 };
	}; --Mad-Eye Carrey
	["2007302151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.8069, y = 0.6087 };
	}; --Tidesmith Zarviss
	["2006212151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5510, y = 0.3876 };
	}; --Manathema
	["2007432151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3091, y = 0.6085 };
	}; --Amephyst
	["2006192151"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4289, y = 0.5098 };
	}; --Tectonus
	["122899407"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6545, y = 0.6811 };
	}; --Death Metal Knight
	["2034802133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5479, y = 0.6590 };
	}; --Spinmarrow
	["2035152133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5697, y = 0.7306 };
	}; --Alcanon
	["2036602133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3586, y = 0.4378 };
	}; --Flowfy
	["2034622133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6455, y = 0.5538 };
	}; --Kob'rok
	["2035212133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5287, y = 0.1887 };
	}; --Professor Gastrinax <Ex-Emeritus of Algeth'ar Academy>
	["2058652025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5936, y = 0.6967 };
	}; --Zal'kir the Chosen <The Maw of K'Tanth>
	["2016642025"] = { 
		[RSConstants.STEP1] = { x = 0.5214, y = 0.8140, comment = AL["NOTE_201664_1"] };
		[RSConstants.STEP2] = { x = 0.5220, y = 0.8160, comment = AL["NOTE_201664_2"] };
	}; --Temporal Investi-gator
	["2120092200"] = {
		[RSConstants.ENTRANCE] = { x = 0.6345, y = 0.7156 };
	}; --Fruitface
	["2101612200"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4502, y = 0.3684 };
		[RSConstants.ENTRANCE..2] = { x = 0.4425, y = 0.3606 };
		[RSConstants.ENTRANCE..3] = { x = 0.4319, y = 0.3648 };
	}; --Ristar, the Rabid
	["2099192200"] = {
		[RSConstants.ENTRANCE] = { x = 0.3830, y = 0.3225 };
	}; --Isaqa <The Shatterer>
	["2105082200"] = {
		[RSConstants.ENTRANCE] = { x = 0.3810, y = 0.6145 };
	}; --Voracious Mikanji
	["2100512200"] = {
		[RSConstants.ENTRANCE] = { x = 0.4174, y = 0.7310 };
	}; --Matriarch Keevah
	["2100452200"] = {
		[RSConstants.ENTRANCE] = { x = 0.3875, y = 0.7162 };
	}; --Moragh the Slothful
	["2105592200"] = {
		[RSConstants.ENTRANCE] = { x = 0.2354, y = 0.3239 };
	}; --Balboan
	["2100752200"] = {
		[RSConstants.ENTRANCE] = { x = 0.4757, y = 0.3048 };
	}; --Henri Snufftail
	["2100702200"] = {
		[RSConstants.ENTRANCE] = { x = 0.5424, y = 0.3708 };
	}; --Mosa Umbramane
	["2099132200"] = {
		[RSConstants.ENTRANCE] = { x = 0.6345, y = 0.7156 };
		[RSConstants.FLAG] = { x = 0.6016, y = 6875, comment = AL["NOTE_209913_1"] };
	}; --Fruitface
	["2099132254"] = {
		[RSConstants.ENTRANCE] = { x = 0.6525, y = 0.4875 };
		[RSConstants.FLAG] = { x = 0.6016, y = 0.6875, comment = AL["NOTE_209913_1"] };
	}; --Fruitface
	["2160422255"] = {
		[RSConstants.ENTRANCE] = { x = 0.7011, y = 0.2200 };
	}; --Cha'tak
	["2160342255"] = {
		[RSConstants.ENTRANCE] = { x = 0.7756, y = 0.5907 };
	}; --The XT-Minecrusher 8700
	["2160492255"] = {
		[RSConstants.ENTRANCE] = { x = 0.6346, y = 0.8975 };
	}; --Black Blood Slime
	["2160492256"] = {
		[RSConstants.ENTRANCE] = { x = 0.6346, y = 0.8975 };
	}; --Black Blood Slime
	["2160472255"] = {
		[RSConstants.ENTRANCE] = { x = 0.6530, y = 0.9335 };
	}; --The Disgraced
	["2160472256"] = {
		[RSConstants.ENTRANCE] = { x = 0.6530, y = 0.9335 };
	}; --The Disgraced
	["2202682214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6869, y = 0.4433 };
	}; --Trungal <Whose Roots Run Deep>
	["4337332214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4789, y = 0.5312 };
	}; --Forgotten Treasure
	["2202722214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6290, y = 0.6793 };
	}; --Deathbound Husk <Machine Speaker Loyalist>
	["2192652248"] = {
		[RSConstants.ENTRANCE] = { x = 0.4736, y = 0.6163 };
	}; --Emperor Pitfang
	["2160412255"] = {
		[RSConstants.ENTRANCE] = { x = 0.6151, y = 0.2802 };
	}; --Webspeaker Grik'ik
	["2217532215"] = {
		[RSConstants.STEP1..1] = { x = 0.2892, y = 0.5120, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..2] = { x = 0.3418, y = 0.5782, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..3] = { x = 0.3436, y = 0.5357, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..4] = { x = 0.4345, y = 0.1413, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..5] = { x = 0.5009, y = 0.4966, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..6] = { x = 0.5377, y = 0.1913, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP1..7] = { x = 0.5514, y = 0.2344, comment = AL["NOTE_221753_1"] };
		[RSConstants.STEP2] = { x = 0.4800, y = 0.1668, comment = AL["NOTE_221753_2"] };
	}; --Deathtide <The Viscous Swell>
	["2202732214"] = {
		[RSConstants.ENTRANCE] = { x = 0.5329, y = 0.5478 };
	}; --Rampaging Skardyn <Evolved Monstrosity>
	["2202852214"] = {
		[RSConstants.FLAG..1] = { x = 0.4530, y = 0.0880, comment = AL["NOTE_220285_1"] };
		[RSConstants.FLAG..2] = { x = 0.4975, y = 0.2528, comment = AL["NOTE_220285_1"] };
		[RSConstants.FLAG..3] = { x = 0.5346, y = 0.2357, comment = AL["NOTE_220285_1"] };
		[RSConstants.FLAG..4] = { x = 0.5867, y = 0.4464, comment = AL["NOTE_220285_1"] };
		[RSConstants.FLAG..5] = { x = 0.5492, y = 0.9240, comment = AL["NOTE_220285_1"] };
	}; --Lurker of the Deeps <Displaced Sea Horror>
	["2069772215"] = {
		[RSConstants.FLAG] = { x = 0.6440, y = 0.3100, comment = AL["NOTE_206977_1"] };
	}; --Parasidious
	["107105630"] = {
		[RSConstants.ENTRANCE] = { x = 0.3331, y = 0.4250 };
	}; --Broodmother Lizax
	["109504630"] = {
		[RSConstants.ENTRANCE] = { x = 0.3479, y = 0.4979 };
	}; --Broodmother Lizax
	["95123641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6611, y = 0.5253 };
	}; --Grelda the Hag
	["105739680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2040, y = 0.4100 };
	}; --Sanaar
	["99610680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4955, y = 0.3383 };
	}; --Garvrulg <Slatecrusher Exile>
	["103214680"] = {
		[RSConstants.ENTRANCE] = { x = 0.7320, y = 0.6800 };
	}; --Har'kess the Insatiable
	["112756680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2901, y = 0.8481 };
	}; --Sorallus
	["91892634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4203, y = 0.7107 };
	}; --Thane Irglov the Merciless
	["90139634"] = {
		[RSConstants.ENTRANCE] = { x = 0.6252, y = 0.7494 };
	}; --Inquisitor Ernstenbok
	["110363634"] = {
		[RSConstants.ENTRANCE] = { x = 0.5777, y = 0.3470 };
	}; --Roteye
	["98188634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4140, y = 0.3195 };
	}; --Egyl the Enduring
	["97653650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5417, y = 0.5078 };
	}; --Taurson <The Beastly Boxer>
	["97220650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4869, y = 0.5001 };
	}; --Arru <The Terror>
	["95872650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5091, y = 0.3197 };
	}; --Skullhat <Skywhisker Taskmaster>
	["98024650"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5158, y = 0.3746 };
		[RSConstants.ENTRANCE..2] = { x = 0.4806, y = 0.3380 };
	}; --Luggut the Eggeater
	["2282012369"] = {
		[RSConstants.ENTRANCE] = { x = 0.6317, y = 0.7601 };
	}; --Gravesludge
	["2299922369"] = {
		[RSConstants.ENTRANCE] = { x = 0.4431, y = 0.5666 };
	}; --Stalagnarok
	["2299822369"] = {
		[RSConstants.ENTRANCE] = { x = 0.3292, y = 0.6499 };
	}; --Nerathor <The Storm Drowned>
	["2285472369"] = {
		[RSConstants.FLAG] = { x = 0.6910, y = 0.4926, comment = AL["NOTE_SUZIE_BOLTWRENCH"] };
	}; --Slaughtershell
	["2313532369"] = {
		[RSConstants.FLAG] = { x = 0.6910, y = 0.4926, comment = AL["NOTE_SUZIE_BOLTWRENCH"] };
	}; --Tempest Talon
	["2313562369"] = {
		[RSConstants.FLAG] = { x = 0.6910, y = 0.4926, comment = AL["NOTE_SUZIE_BOLTWRENCH"] };
	}; --Brinebough
	["2313572369"] = {
		[RSConstants.FLAG] = { x = 0.6910, y = 0.4926, comment = AL["NOTE_SUZIE_BOLTWRENCH"] };
	}; --Zek'ul the Shipbreaker
	["1527121355"] = {
		[RSConstants.ENTRANCE] = { x = 0.3969, y = 0.7726 };
	}; --Blindlight <Necrofin Chieftain>
	["1524641355"] = {
		[RSConstants.ENTRANCE] = { x = 0.4239, y = 0.1315 };
	}; --Caverndark Terror
	["1525561355"] = {
		[RSConstants.ENTRANCE] = { x = 0.4744, y = 0.8514 };
	}; --Chasm-Haunter
	["2309342346"] = {
		[RSConstants.ENTRANCE] = { x = 0.2549, y = 0.3500 };
	}; --Ratspit <Court of Rats>
	["2344802346"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4045, y = 0.2014 };
		[RSConstants.ENTRANCE..2] = { x = 0.3940, y = 0.2588 };
		[RSConstants.FLAG] = { x = 0.4000, y = 0.2240, comment = AL["NOTE_234480_1"] };
	}; --M.A.G.N.O.
	["2334712346"] = {
		[RSConstants.FLAG] = { x = 0.5665, y = 0.7915, comment = AL["NOTE_233471_1"] };
	}; --Scrapchewer <Workplace Liability>
	["2344992346"] = {
		[RSConstants.FLAG] = { x = 0.3200, y = 0.7654, comment = AL["NOTE_234499_1"] };
	}; --Giovante <Unwitting Trial>
	["2334722346"] = {
		[RSConstants.FLAG] = { x = 0.6147, y = 0.2522, comment = AL["NOTE_233472_1"] };
	}; --Voltstrike the Charged
	["2313102346"] = {
		[RSConstants.FLAG] = { x = 0.3080, y = 0.3820, comment = AL["NOTE_231310_1"] };
	}; --Darkfuse Precipitant
	["2412312215"] = {
		[RSConstants.DOT..1] = { x = 0.4010, y = 0.5850, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.4050, y = 0.5960, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.4030, y = 0.6090, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.4150, y = 0.5930, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.4100, y = 0.6210, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..6] = { x = 0.4150, y = 0.6170, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Fortfervor
	["2412342215"] = {
		[RSConstants.DOT..1] = { x = 0.4010, y = 0.5850, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.4050, y = 0.5960, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.4030, y = 0.6090, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.4150, y = 0.5930, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.4100, y = 0.6210, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..6] = { x = 0.4150, y = 0.6170, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Batalsworn
	["2412292215"] = {
		[RSConstants.DOT..1] = { x = 0.4980, y = 0.6500, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.4980, y = 0.7040, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.5060, y = 0.6620, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.5140, y = 0.6870, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.5150, y = 0.7000, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Fervormyt
	["2412382215"] = {
		[RSConstants.DOT..1] = { x = 0.4980, y = 0.6500, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.4980, y = 0.7040, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.5060, y = 0.6620, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.5140, y = 0.6870, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.5150, y = 0.7000, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Siegesage
	["2412282255"] = {
		[RSConstants.DOT..1] = { x = 0.6270, y = 0.2670, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6190, y = 0.3020, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6310, y = 0.3070, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6410, y = 0.2990, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.6600, y = 0.3110, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..6] = { x = 0.6750, y = 0.2770, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Oathland
	["2412372255"] = {
		[RSConstants.DOT..1] = { x = 0.6270, y = 0.2670, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6190, y = 0.3020, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6310, y = 0.3070, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6410, y = 0.2990, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..5] = { x = 0.6600, y = 0.3110, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..6] = { x = 0.6750, y = 0.2770, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Warsididel
	["2412302255"] = {
		[RSConstants.DOT..1] = { x = 0.6370, y = 0.0680, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6480, y = 0.0660, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6480, y = 0.1330, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6530, y = 0.0940, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Tailtrek
	["2412352255"] = {
		[RSConstants.DOT..1] = { x = 0.6370, y = 0.0680, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6480, y = 0.0660, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6480, y = 0.1330, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6530, y = 0.0940, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Hillhelm
	["2412272255"] = {
		[RSConstants.DOT..1] = { x = 0.6650, y = 0.5370, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6670, y = 0.5070, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6840, y = 0.5470, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6950, y = 0.5450, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Glaivefur
	["2412392255"] = {
		[RSConstants.DOT..1] = { x = 0.6650, y = 0.5370, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.6670, y = 0.5070, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.6840, y = 0.5470, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.6950, y = 0.5450, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Warhavuk
	["2412322215"] = {
		[RSConstants.DOT..1] = { x = 0.7480, y = 0.4300, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.7270, y = 0.4170, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.7180, y = 0.4280, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.7240, y = 0.4750, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Dissenter Troosilver
	["2412362215"] = {
		[RSConstants.DOT..1] = { x = 0.7480, y = 0.4300, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..2] = { x = 0.7270, y = 0.4170, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..3] = { x = 0.7180, y = 0.4280, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
		[RSConstants.DOT..4] = { x = 0.7240, y = 0.4750, comment = AL["NOTE_FLAMES_RADIANCE_INCURSION_NPCS_1"] };
	}; --Whisperer Bravefort
	["50822390"] = {
		[RSConstants.ENTRANCE] = { x = 0.4138, y = 0.6864 };
	}; --Ai-Ran the Shifting Cloud
	["2459982371"] = {
		[RSConstants.DOT..1] = { x = 0.7698, y = 0.3179, comment = AL["NOTE_245998_1"] };
		[RSConstants.DOT..2] = { x = 0.7271, y = 0.3472, comment = AL["NOTE_245998_2"] };
		[RSConstants.DOT..3] = { x = 0.7258, y = 0.2845, comment = AL["NOTE_245998_3"] };
		[RSConstants.DOT..4] = { x = 0.7179, y = 0.3461, comment = AL["NOTE_245998_4"] };
		[RSConstants.FLAG] = { x = 0.7543, y = 0.3032, comment = AL["NOTE_245998_5"] };
	}; --Heka'tamos <the Elemental Disjunction>
	["2385402472"] = {
		[RSConstants.FLAG] = { x = 0.4848, y = 0.5874, comment = AL["NOTE_238540_1"] };
	}; --Grubber
	["2419202371"] = {
		[RSConstants.FLAG] = { x = 0.6626, y = 0.8040, comment = AL["NOTE_241920_1"] };
	}; --Purple Peat
	["2381352371"] = {
		[RSConstants.FLAG] = { x = 0.6633, y = 0.8038, comment = AL["NOTE_238135_1"] };
	}; --Shatterpulse
	["2348452371"] = {
		[RSConstants.FLAG] = { x = 0.7583, y = 0.3289, comment = AL["NOTE_234845_1"] };
	}; --Sthaarbs <the Mindroiler>
	["2385362371"] = {
		[RSConstants.FLAG] = { x = 0.6628, y = 0.8040, comment = AL["NOTE_238536_1"] };
	}; --Hollowbane
	["2419562472"] = {
		[RSConstants.FLAG] = { x = 0.4846, y = 0.5840, comment = AL["NOTE_241956_1"] };
	}; --Arcana-Monger So'zer
	["2383842472"] = {
		[RSConstants.FLAG] = { x = 0.4846, y = 0.5840, comment = AL["NOTE_238384_1"] };
	}; --Xy'vox the Twisted
	["63510390"] = {
		[RSConstants.ENTRANCE] = { x = 0.2232, y = 0.2779 };
	}; --Wulon <The Granite Sentinel>
	["100495650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5514, y = 0.4427 };
	}; --Devouring Darkness
}

---============================================================================
-- Container guide
---============================================================================

private.CONTAINER_GUIDE = {
	["3550411565"] = {
		[RSConstants.STEP1] = { x = 0.3899, y = 0.5696, itemID = 180759, comment = AL["NOTE_355041_1"] };
		[RSConstants.STEP2] = { x = 0.3975, y = 0.5440, itemID = 180754, comment = AL["NOTE_355041_2"] };
		[RSConstants.STEP3] = { x = 0.4031, y = 0.5262, itemID = 180758, comment = AL["NOTE_355041_3"] };
		[RSConstants.STEP4] = { x = 0.3849, y = 0.5808, itemID = 180756, comment = AL["NOTE_355041_4"] };
		[RSConstants.STEP5] = { x = 0.3885, y = 0.6010, itemID = 180757, comment = AL["NOTE_355041_5"] };
	}; --Cache of the Moon
	["3546501565"] = { [RSConstants.FLAG] = { x = 0.3801, y = 0.3634, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Dreamsong Heart
	["3546481565"] = { [RSConstants.FLAG] = { x = 0.3766, y = 0.6146, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Darkreach Supplies
	["3554181565"] = {
		[RSConstants.ENTRANCE] = { x = 0.359, y = 0.6568 };
		[RSConstants.STEP1] = { x = 0.5155, y = 0.616, itemID = 180654, comment = AL["NOTE_355418_1"] };
		[RSConstants.STEP2] = { x = 0.424, y = 0.467, itemID = 180656, comment = AL["NOTE_355418_2"] };
		[RSConstants.STEP3] = { x = 0.37, y = 0.298, itemID = 180655, comment = AL["NOTE_355418_3"] };
	}; --Cache of the Night
	["3533311565"] = { [RSConstants.FLAG] = { x = 0.3989, y = 0.4377, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Faerie Stash
	["3533321565"] = { [RSConstants.FLAG] = { x = 0.4359, y = 0.2296, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Faerie Stash
	["3537711565"] = {
		[RSConstants.STEP1] = { x = 0.4768, y = 0.3436, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.4813, y = 0.3584, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.4852, y = 0.346, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.4896, y = 0.3449, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.4828, y = 0.3373, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3537701565"] = {
		[RSConstants.STEP1] = { x = 0.3879, y = 0.5425, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.3885, y = 0.5363, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.3919, y = 0.5366, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.3949, y = 0.5444, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.3966, y = 0.5352, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3537731565"] = {
		[RSConstants.STEP1] = { x = 0.6189, y = 0.5684, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.6145, y = 0.5626, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.6052, y = 0.5644, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.6041, y = 0.5735, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.6144, y = 0.5753, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["1712061565"] = {
		[RSConstants.DOT..1] = { x = 0.407, y = 0.274 };
		[RSConstants.DOT..2] = { x = 0.512, y = 0.551 };
		[RSConstants.DOT..3] = { x = 0.51, y = 0.543 };
		[RSConstants.DOT..4] = { x = 0.724, y = 0.314 };
		[RSConstants.DOT..5] = { x = 0.507, y = 0.551 };
		[RSConstants.DOT..6] = { x = 0.3185, y = 0.4363 };
		[RSConstants.DOT..7] = { x = 0.3176, y = 0.41 };
		[RSConstants.DOT..8] = { x = 0.3260, y = 0.4292 };
		[RSConstants.DOT..9] = { x = 0.341, y = 0.45 };
		[RSConstants.DOT..10] = { x = 0.5021, y = 0.5353 };
		[RSConstants.DOT..11] = { x = 0.4331, y = 0.2874 };
		[RSConstants.DOT..12] = { x = 0.4094, y = 0.5156 };
		[RSConstants.DOT..13] = { x = 0.4137, y = 0.4979 };
		[RSConstants.DOT..14] = { x = 0.5116, y = 0.5507 };
		[RSConstants.DOT..15] = { x = 0.6716, y = 0.2888 };
		[RSConstants.DOT..16] = { x = 0.7014, y = 0.3004 };
		[RSConstants.DOT..17] = { x = 0.6522, y = 0.2265 };
		[RSConstants.DOT..18] = { x = 0.6755, y = 0.3191 };
		[RSConstants.DOT..19] = { x = 0.7239, y = 0.3146 };
	}; --Playful Vulpin Befriended
	["1716991565"] = {
		[RSConstants.ENTRANCE] = { x = 0.3105, y = 0.5451 };
		[RSConstants.DOT..1] = { x = 0.2960, y = 0.5629 };
		[RSConstants.FLAG] = { x = 0.2964, y = 0.5691, comment = AL["NOTE_171699_1"] };
		[RSConstants.DOT..3] = { x = 0.2985, y = 0.5784 };
		[RSConstants.DOT..4] = { x = 0.2935, y = 0.5859 };
		[RSConstants.DOT..5] = { x = 0.2898, y = 0.5887 };
		[RSConstants.DOT..6] = { x = 0.2811, y = 0.5816 };
		[RSConstants.DOT..7] = { x = 0.2709, y = 0.5822 };
	}; --Tame Gladerunner
	["1714841565"] = {
		[RSConstants.STEP1..1] = { x = 0.3645, y = 0.5961, itemID = 180784 };
		[RSConstants.STEP1..2] = { x = 0.3178, y = 0.3248, itemID = 180784 };
		[RSConstants.STEP1..3] = { x = 0.5628, y = 0.5594, itemID = 180784 };
		[RSConstants.STEP1..4] = { x = 0.4875, y = 0.3373, itemID = 180784 };
		[RSConstants.STEP2] = { x = 0.4143, y = 0.3165, comment = AL["GUIDE_BOUNDING_SHROOM"] };
	}; --Desiccated Moth
	["3546621565"] = { [RSConstants.FLAG] = { x = 0.4649, y = 0.7012, comment = AL["NOTE_171475_1"] } }; --Elusive Faerie Cache
	["3533331565"] = { [RSConstants.FLAG] = { x = 0.4285, y = 0.6612, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Faerie Stash
	["3356551536"] = {
		[RSConstants.STEP1] = { x = 0.508, y = 0.53, comment = AL["NOTE_335655_1"] };
		[RSConstants.STEP2] = { x = 0.7663, y = 0.5612, comment = AL["NOTE_335655_2"] };
	}; --Oonar's Arm
	["3356491536"] = {
		[RSConstants.FLAG] = { x = 0.5142, y = 0.4515, comment = AL["NOTE_335649_1"] };
		[RSConstants.STEP1] = { x = 0.536, y = 0.478, comment = AL["NOTE_335649_2"] };
		[RSConstants.STEP2] = { x = 0.3884, y = 0.4921, comment = AL["NOTE_335649_3"] };
		[RSConstants.STEP3] = { x = 0.508, y = 0.53, comment = AL["NOTE_335655_1"] };
		[RSConstants.STEP4] = { x = 0.7663, y = 0.5612, comment = AL["NOTE_335655_2"] };
	}; --Sword of Oonar
	["3558801536"] = { [RSConstants.FLAG] = { x = 0.406, y = 0.33, comment =  AL["NOTE_355880_1"] } }; --The Necronom-i-nom
	["3565351536"] = { [RSConstants.FLAG] = { x = 0.3787, y = 0.7008, comment =  AL["NOTE_356535_1"] } }; --Runespeaker's Trove
	["3519801536"] = {
		[RSConstants.PATH_START] = { x = 0.62, y = 0.5865 } ;
		[RSConstants.STEP1] = { x = 0.6251, y = 0.5888, comment = AL["NOTE_351980_1"] };
		[RSConstants.STEP2] = { x = 0.6294, y = 0.5808, comment = AL["NOTE_351980_2"] };
		[RSConstants.STEP3] = { x = 0.6312, y = 0.5871, comment = AL["NOTE_351980_3"] };
	}; --Misplaced Supplies
	["3558861536"] = {
		[RSConstants.STEP1] = { x = 0.6178, y = 0.788, comment = AL["NOTE_355886_1"] };
		[RSConstants.ENTRANCE] = { x = 0.6248, y = 0.7656 };
		[RSConstants.STEP2] = { x = 0.6161, y = 0.7677, comment = AL["NOTE_355886_2"] };
	}; --Ritualist's Cache
	["3559471536"] = { [RSConstants.ENTRANCE] = { x = 0.72, y = 0.5259 } }; --Glutharn's Stash
	["3396011533"] = {
		[RSConstants.STEP1] = { x = 0.5420, y = 0.8257, comment = AL["NOTE_339601_1"] };
		[RSConstants.STEP2] = { x = 0.5443, y = 0.8388, comment = AL["NOTE_339601_2"] };
		[RSConstants.STEP3] = { x = 0.5617, y = 0.8306, comment = AL["NOTE_339601_2"] };
	}; --Ritualist's Cache
	["3554351533"] = {
		[RSConstants.DOT..1] = { x = 0.3905, y = 0.7704, comment = AL["NOTE_355435_1"], questID = 61225 };
		[RSConstants.DOT..2] = { x = 0.4363, y = 0.7622, comment = AL["NOTE_355435_1"], questID = 61235 };
		[RSConstants.DOT..3] = { x = 0.4842, y = 0.7273, comment = AL["NOTE_355435_1c"], questID = 61236 };
		[RSConstants.DOT..4] = { x = 0.5267, y = 0.7555, comment = AL["NOTE_355435_1"], questID = 61237 };
		[RSConstants.DOT..5] = { x = 0.5331, y = 0.7362, comment = AL["NOTE_355435_1"], questID = 61238 };
		[RSConstants.DOT..6] = { x = 0.5349, y = 0.8060, comment = AL["NOTE_355435_1"], questID = 61239 };
		[RSConstants.DOT..7] = { x = 0.5596, y = 0.8666, comment = AL["NOTE_355435_1"], questID = 61241 };
		[RSConstants.DOT..8] = { x = 0.6104, y = 0.8566, comment = AL["NOTE_355435_1"], questID = 61244 };
		[RSConstants.DOT..9] = { x = 0.5810, y = 0.8008, comment = AL["NOTE_355435_1"], questID = 61245 };
		[RSConstants.DOT..10] = { x = 0.5687, y = 0.7498, comment = AL["NOTE_355435_1"], questID = 61247 };
		[RSConstants.DOT..11] = { x = 0.6552, y = 0.7192, comment = AL["NOTE_355435_1"], questID = 61249 };
		[RSConstants.DOT..12] = { x = 0.5815, y = 0.6391, comment = AL["NOTE_355435_1"], questID = 61250 };
		[RSConstants.DOT..13] = { x = 0.5400, y = 0.5970, comment = AL["NOTE_355435_1"], questID = 61251 };
		[RSConstants.DOT..14] = { x = 0.4670, y = 0.6595, comment = AL["NOTE_355435_1"], questID = 61253 };
		[RSConstants.DOT..15] = { x = 0.5068, y = 0.5614, comment = AL["NOTE_355435_1"], questID = 61254 };
		[RSConstants.DOT..16] = { x = 0.3484, y = 0.6578, comment = AL["NOTE_355435_1"], questID = 61257 };
		[RSConstants.DOT..17] = { x = 0.5167, y = 0.4802, comment = AL["NOTE_355435_1b"], questID = 61258 };
		[RSConstants.DOT..18] = { x = 0.4708, y = 0.4923, comment = AL["NOTE_355435_1"], questID = 61260 };
		[RSConstants.DOT..19] = { x = 0.4139, y = 0.4663, comment = AL["NOTE_355435_1"], questID = 61261 };
		[RSConstants.DOT..20] = { x = 0.4004, y = 0.5912, comment = AL["NOTE_355435_1"], questID = 61263 };
		[RSConstants.DOT..21] = { x = 0.3852, y = 0.5326, comment = AL["NOTE_355435_1"], questID = 61264 };
		[RSConstants.DOT..22] = { x = 0.5764, y = 0.5567, comment = AL["NOTE_355435_1"], questID = 61270 };
		[RSConstants.DOT..23] = { x = 0.6525, y = 0.4288, comment = AL["NOTE_355435_1"], questID = 61271 };
		[RSConstants.DOT..24] = { x = 0.7238, y = 0.4029, comment = AL["NOTE_355435_1"], questID = 61273 };
		[RSConstants.DOT..25] = { x = 0.6689, y = 0.2692, comment = AL["NOTE_355435_1"], questID = 61274 };
		[RSConstants.DOT..26] = { x = 0.5755, y = 0.3827, comment = AL["NOTE_355435_1a"], questID = 61275 };
		[RSConstants.DOT..27] = { x = 0.5216, y = 0.3939, comment = AL["NOTE_355435_1"], questID = 61277 };
		[RSConstants.DOT..28] = { x = 0.4999, y = 0.3826, comment = AL["NOTE_355435_1"], questID = 61278 };
		[RSConstants.DOT..29] = { x = 0.4848, y = 0.3491, comment = AL["NOTE_355435_1"], questID = 61279 };
		[RSConstants.DOT..30] = { x = 0.5672, y = 0.2884, comment = AL["NOTE_355435_1"], questID = 61280 };
		[RSConstants.DOT..31] = { x = 0.5620, y = 0.1731, comment = AL["NOTE_355435_1"], questID = 61281 };
		[RSConstants.DOT..32] = { x = 0.5988, y = 0.1391, comment = AL["NOTE_355435_1"], questID = 61282 };
		[RSConstants.DOT..33] = { x = 0.5244, y = 0.0942, comment = AL["NOTE_355435_1"], questID = 61283 };
		[RSConstants.DOT..34] = { x = 0.4669, y = 0.1804, comment = AL["NOTE_355435_1"], questID = 61284 };
		[RSConstants.DOT..35] = { x = 0.4494, y = 0.2845, comment = AL["NOTE_355435_1"], questID = 61285 };
		[RSConstants.DOT..36] = { x = 0.4230, y = 0.2402, comment = AL["NOTE_355435_1"], questID = 61286 };
		[RSConstants.DOT..37] = { x = 0.3710, y = 0.2468, comment = AL["NOTE_355435_1"], questID = 61287 };
		[RSConstants.DOT..38] = { x = 0.4281, y = 0.3321, comment = AL["NOTE_355435_1"], questID = 61288 };
		[RSConstants.DOT..39] = { x = 0.4271, y = 0.3940, comment = AL["NOTE_355435_1"], questID = 61289 };
		[RSConstants.DOT..40] = { x = 0.3303, y = 0.3762, comment = AL["NOTE_355435_1"], questID = 61290 };
		[RSConstants.DOT..41] = { x = 0.3100, y = 0.2747, comment = AL["NOTE_355435_1"], questID = 61291 };
		[RSConstants.DOT..42] = { x = 0.3061, y = 0.2373, comment = AL["NOTE_355435_1"], questID = 61292 };
		[RSConstants.DOT..43] = { x = 0.2464, y = 0.2298, comment = AL["NOTE_355435_1"], questID = 61293 };
		[RSConstants.DOT..44] = { x = 0.2615, y = 0.2262, comment = AL["NOTE_355435_1"], questID = 61294 };
		[RSConstants.DOT..45] = { x = 0.2437, y = 0.1821, comment = AL["NOTE_355435_1"], questID = 61295 };
		--[RSConstants.DOT..46] = { x = 0.5250, y = 0.8860, comment = AL["NOTE_355435_1"].."46" };
		--[RSConstants.DOT..47] = { x = 0.3620, y = 0.2280, comment = AL["NOTE_355435_1"].."47" };
		--[RSConstants.DOT..48] = { x = 0.4660, y = 0.5310, comment = AL["NOTE_355435_1"].."48" };
		--[RSConstants.DOT..49] = { x = 0.6940, y = 0.3870, comment = AL["NOTE_355435_1"].."49" };
		--[RSConstants.DOT..50] = { x = 0.4980, y = 0.4690, comment = AL["NOTE_355435_1"].."50" };
		[RSConstants.FLAG] = { x = 0.592, y = 0.314, comment = AL["NOTE_355435_2"], questID = 61229  };
	}; --Vesper of the Silver Wind
	["3539401533"] = {
		[RSConstants.STEP1] = { x = 0.6493, y = 0.7140, comment = AL["NOTE_353940_1"] };
		[RSConstants.STEP2] = { x = 0.6459, y = 0.7139, comment = AL["NOTE_353940_2"] };
	}; --Trial of Purity
	["3542141533"] = { [RSConstants.ENTRANCE] = { x = 0.5567, y = 0.4295 } }; --Larion Tamer's Harness
	["3539411533"] = {
		[RSConstants.TRANSPORT..1] = { x = 0.6938, y = 0.4032 };
		[RSConstants.TRANSPORT..2] = { x = 0.7177, y = 0.369 };
	}; --Trial of Humility
	["3552861533"] = {
		[RSConstants.DOT..1] = { x = 0.528, y = 0.472, comment = AL["NOTE_355286_1"] };
		[RSConstants.DOT..2] = { x = 0.436, y = 0.328, comment = AL["NOTE_355286_1"] };
		[RSConstants.DOT..3] = { x = 0.338, y = 0.666, comment = AL["NOTE_355286_1"] };
		[RSConstants.DOT..4] = { x = 0.48, y = 0.738, comment = AL["NOTE_355286_1"] };
		[RSConstants.DOT..5] = { x = 0.546, y = 0.828, comment = AL["NOTE_355286_1"] };
		[RSConstants.FLAG] = { x = 0.5685, y = 0.1911, comment = AL["NOTE_355286_2"] };
	}; --Memorial Offerings
	["3542751533"] = {
		[RSConstants.DOT..1] = { x = 0.5283, y = 0.1956, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..2] = { x = 0.5087, y = 0.1471, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..3] = { x = 0.53, y = 0.15, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..4] = { x = 0.535, y = 0.172, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..5] = { x = 0.5355, y = 0.1703, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..6] = { x = 0.531, y = 0.19, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..7] = { x = 0.4981, y = 0.1739, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..8] = { x = 0.5206, y = 0.1999, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..9] = { x = 0.5247, y = 0.1449, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..10] = { x = 0.5147, y = 0.1796, comment = AL["NOTE_354275_1"] };
		[RSConstants.DOT..11] = { x = 0.5027, y = 0.165, comment = AL["NOTE_354275_1"] };
	}; --Experimental Construct Part
	["3538711533"] = {
		[RSConstants.ENTRANCE] = { x = 0.4773, y = 0.3511 };
		[RSConstants.PATH_START] = { x = 0.4563, y = 0.3479 };
	}; --Hidden Hoard
	["3542021533"] = { [RSConstants.ENTRANCE] = { x = 0.4651, y = 0.4668 } }; --Abandoned Stockpile
	["3539431533"] = {
		[RSConstants.STEP1] = { x = 0.3710, y = 0.1829, comment = AL["NOTE_353943_1"] };
		[RSConstants.STEP2] = { x = 0.4077, y = 0.1565, comment = AL["NOTE_353943_2"] };
		[RSConstants.STEP3] = { x = 0.3735, y = 0.1873, comment = AL["NOTE_353943_3"] };
		[RSConstants.STEP4] = { x = 0.4189, y = 0.1833, comment = AL["NOTE_353943_4"] };
		[RSConstants.STEP5] = { x = 0.4186, y = 0.1594, comment = AL["NOTE_353943_5"] };
		[RSConstants.TRANSPORT..1] = { x = 0.4167, y = 0.2331 };
		[RSConstants.TRANSPORT..2] = { x = 0.4057, y = 0.2113 };
		[RSConstants.TRANSPORT..3] = { x = 0.3955, y = 0.19 };
	}; --Trial of Wisdom
	["3539421533"] = {
		[RSConstants.STEP1] = { x = 0.3910, y = 0.5447, comment = AL["NOTE_353942_1"] };
		[RSConstants.STEP2] = { x = 0.3846, y = 0.5707, comment = AL["NOTE_353942_1"] };
		[RSConstants.STEP3] = { x = 0.3747, y = 0.5675, comment = AL["NOTE_353942_1"] };
		[RSConstants.STEP4] = { x = 0.3696, y = 0.5701, comment = AL["NOTE_353942_1"] };
	}; --Trial of Courage
	["3539441533"] = {
		[RSConstants.FLAG..1] = { x = 0.2393, y = 0.2483, comment = AL["NOTE_353944_1"] };
		[RSConstants.DOT..1] = { x = 0.25, y = 0.2508, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..2] = { x = 0.2340, y = 0.2498, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..3] = { x = 0.2362, y = 0.2422, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..4] = { x = 0.2406, y = 0.2303, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..5] = { x = 0.2418, y = 0.2146, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..6] = { x = 0.2507, y = 0.2092, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..7] = { x = 0.2609, y = 0.2109, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..8] = { x = 0.2703, y = 0.2149, comment = AL["NOTE_353944_2"] };
		[RSConstants.DOT..9] = { x = 0.273, y = 0.2055, comment = AL["NOTE_353944_2"] };
		[RSConstants.FLAG..2] = { x = 0.2738, y = 0.2181, comment = AL["NOTE_353944_3"] };
	}; --Trial of Loyalty
	["3541861525"] = { [RSConstants.PATH_START] = { x = 0.7540, y = 0.7277 } }; --Stoneborn Satchel
	["3574871525"] = { [RSConstants.PATH_START] = { x = 0.4142, y = 0.4497 } }; --Stylish Parasol
	["3515421525"] = { [RSConstants.FLAG] = { x = 0.747, y = 0.6259, comment = AL["NOTE_351542_1"] } }; --Secret Treasure
	["3541921525"] = { [RSConstants.PATH_START] = { x = 0.22, y = 0.41 } }; --Secret Treasure
	["3515441525"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5518, y = 0.3473 };
		[RSConstants.FLAG..1] = { x = 0.5469, y = 0.346, comment = AL["NOTE_351544_1"] };
	}; --Secret Treasure
	["3497931525"] = { [RSConstants.FLAG] = { x = 0.68, y = 0.6458, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Wayfarer's Abandoned Spoils
	["3497971525"] = { [RSConstants.FLAG] = { x = 0.5253, y = 0.592, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Abandoned Curios
	["3533301525"] = { [RSConstants.FLAG] = { x = 0.6468, y = 0.234, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Faerie Stash
	["3536431533"] = { [RSConstants.FLAG] = { x = 0.6075, y = 0.5551, comment = AL["NOTE_353643_1"] } }; --Faerie Stash
	["3538691533"] = { [RSConstants.PATH_START] = { x = 0.4599, y = 0.2012 } }; --Hidden Hoard
	["3515401525"] = { [RSConstants.FLAG] = { x = 0.7305, y = 0.4727, comment = AL["NOTE_351540_1"] } }; --Secret Treasure
	["3536911533"] = { [RSConstants.PATH_START] = { x = 0.5826, y = 0.6452 } }; --Campana celeste
	["3535031533"] = { [RSConstants.PATH_START] = { x = 0.4748, y = 0.252 } }; --Silver Strongbox
	["3538721533"] = { [RSConstants.ENTRANCE] = { x = 0.6195, y = 0.3845 } }; --Hidden Hoard
	["3454561536"] = { [RSConstants.PATH_START] = { x = 0.5157, y = 0.1357 } }; --Chest of Eyes
	["3514871525"] = { [RSConstants.FLAG] = { x = 0.6568, y = 0.4295, comment = AL["NOTE_351487_1"] } }; --Secret Treasure
	["3535161533"] = { [RSConstants.FLAG] = { x = 0.6431, y = 0.3002, comment = AL["NOTE_353643_1"] } }; --Silver Strongbox
	["3538761533"] = { [RSConstants.FLAG] = { x = 0.586, y = 0.9252, comment = AL["NOTE_353876_1"] } }; --Virtue of Penitence
	["3538751533"] = { [RSConstants.FLAG] = { x = 0.3550, y = 0.1870, comment = AL["NOTE_353876_1"] } }; --Virtue of Penitence
	["3546471565"] = { [RSConstants.FLAG] = { x = 0.4895, y = 0.4107, comment = AL["NOTE_354647_1"] } }; --Hearty Dragon Plume
	["3538701533"] = { [RSConstants.ENTRANCE] = { x = 0.4863, y = 0.4548 } }; --Hidden Hoard
	["3530191533"] = { [RSConstants.PATH_START] = { x = 0.5806, y = 0.8098 } }; --Silver Strongbox
	["3568231533"] = { [RSConstants.PATH_START] = { x = 0.587, y = 0.163 } }; --Wayfarer's Abandoned Spoils
	["3541091525"] = { 
		[RSConstants.STEP1] = { x = 0.5741, y = 0.3345, comment = AL["NOTE_354109_1"]  };
		[RSConstants.STEP2] = { x = 0.5761, y = 0.3252, comment = AL["NOTE_354109_2"] };
	}; --Stoneborn Satchel
	["3515411525"] = { [RSConstants.ENTRANCE] = { x = 0.4192, y = 0.5008 } }; --Secret Treasure
	["3497951525"] = { [RSConstants.FLAG] = { x = 0.4699, y = 0.5839, comment = AL["GUIDE_BOUNDING_SHROOM"] } }; --Fleeing Soul's Bundle
	["3537721565"] = {
		[RSConstants.STEP1] = { x = 0.5604, y = 0.3872, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.5528, y = 0.3816, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.5517, y = 0.392, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.5569, y = 0.3964, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.5616, y = 0.3942, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3536851565"] = {
		[RSConstants.STEP1] = { x = 0.5604, y = 0.3872, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.5528, y = 0.3816, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.5517, y = 0.392, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.5569, y = 0.3964, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.5616, y = 0.3942, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3537691565"] = {
		[RSConstants.STEP1] = { x = 0.4831, y = 0.7122, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.4830, y = 0.7155, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.4779, y = 0.7096, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.4802, y = 0.7018, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.4840, y = 0.6998, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3536811565"] = {
		[RSConstants.STEP1] = { x = 0.4831, y = 0.7122, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP2] = { x = 0.4830, y = 0.7155, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP3] = { x = 0.4779, y = 0.7096, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP4] = { x = 0.4802, y = 0.7018, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
		[RSConstants.STEP5] = { x = 0.4840, y = 0.6998, comment = AL["GUIDE_LUNARLIGHT_BUD"] };
	}; --Lunarlight Pod
	["3533271565"] = { [RSConstants.ENTRANCE] = { x = 0.5405, y = 0.7634 } }; --Decayed Husk
	["3532311536"] = { [RSConstants.ENTRANCE] = { x = 0.3785, y = 0.7626 } }; --Bonebound Chest
	["3538681533"] = { [RSConstants.ENTRANCE] = { x = 0.5963, y = 0.1331 } }; --Hidden Hoard
	["3533141533"] = { [RSConstants.PATH_START] = { x = 0.3983, y = 0.2589 } }; --Silver Strongbox
	["3536881533"] = { [RSConstants.ENTRANCE] = { x = 0.5779, y = 0.4207 } }; --Hidden Hoard
	["3538731533"] = { [RSConstants.ENTRANCE] = { x = 0.4942, y = 0.5199 } }; --Hidden Hoard
	["3527031525"] = { 
		[RSConstants.FLAG..1] = { x = 0.382, y = 0.437, itemID = 179823 };
		[RSConstants.FLAG..2] = { x = 0.439, y = 0.415, itemID = 179823 };
		[RSConstants.FLAG..3] = { x = 0.436, y = 0.381, itemID = 179823 };
		[RSConstants.FLAG..4] = { x = 0.414, y = 0.385, itemID = 179823 };
		[RSConstants.FLAG..5] = { x = 0.433, y = 0.447, itemID = 179823 };
		[RSConstants.FLAG..6] = { x = 0.442, y = 0.441, itemID = 179823 };
		[RSConstants.FLAG..7] = { x = 0.447, y = 0.388, itemID = 179823 };
		[RSConstants.FLAG..8] = { x = 0.4292, y = 0.4148, itemID = 179823 };
	}; --The Harvest
	["3542061525"] = { [RSConstants.PATH_START] = { x = 0.4102, y = 0.3753 } }; --Greedstone
	["3691481961"] = { [RSConstants.FLAG..1] = { x = 0.3815, y = 0.4161, comment = AL["NOTE_369148_1"] } }; --Glitering nest material
	["3692251961"] = { [RSConstants.ENTRANCE] = { x = 0.4250, y = 0.5606 } }; --Infected vestige
	["1797721961"] = {
		[RSConstants.STEP1..1] = { x = 0.6101, y = 0.5869, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64250 };
		[RSConstants.STEP1..2] = { x = 0.6218, y = 0.5771, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64250 };
		[RSConstants.STEP1..3] = { x = 0.6011, y = 0.5652, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64250 };
		[RSConstants.STEP1..4] = { x = 0.5921, y = 0.5679, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64250 };
		[RSConstants.STEP2..1] = { x = 0.5236, y = 0.5326, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64249 };
		[RSConstants.STEP2..2] = { x = 0.505, y = 0.537, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64249 };
		[RSConstants.STEP2..3] = { x = 0.526, y = 0.497, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64249 };
		[RSConstants.STEP2..4] = { x = 0.5418, y = 0.506, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64249 };
		[RSConstants.STEP3..1] = { x = 0.575, y = 0.4932, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64248 };
		[RSConstants.STEP3..2] = { x = 0.5909, y = 0.4868, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64248 };
		[RSConstants.STEP3..3] = { x = 0.6119, y = 0.4761, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64248 };
		[RSConstants.STEP3..4] = { x = 0.6282, y = 0.5132, comment = AL["GUIDE_SPECTRAL_KEY"], questID = 64248 };
	}; --Spectral bound chest
	["3686481543"] = { [RSConstants.ENTRANCE] = { x = 0.2553, y = 0.3255 } }; --Rift hidden cache
	["3686531543"] = { [RSConstants.ENTRANCE] = { x = 0.208, y = 0.3933 } }; --Etherwyrm Cage
	["3692621543"] = { [RSConstants.FLAG] = { x = 0.6192, y = 0.6302, comment = AL["NOTE_369262_1"] } }; --Zovaal's Vault
	["3692321961"] = { [RSConstants.FLAG] = { x = 0.4355, y = 0.677, itemID = 187033, comment = AL["NOTE_369232_1"] } }; --Offering Box
	["3691831961"] = {
		[RSConstants.DOT..1] = { x = 0.4887, y = 0.3058, comment = AL["NOTE_369183_1"] };
		[RSConstants.DOT..2] = { x = 0.4411, y = 0.3086, comment = AL["NOTE_369183_1"] };
	}; --Dislodged Nest
	["3691491961"] = { 
		[RSConstants.PATH_START] = { x = 0.6379, y = 0.2712 };
		[RSConstants.FLAG] = { x = 0.6611, y = 0.2825, comment = AL["NOTE_369149_1"] };
	}; --Forgotten Feather
	["3754131970"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3513, y = 0.4564, comment = AL["CYPHER_CONSOLE_ENTRANCE"] };
		[RSConstants.STEP1] = { x = 0.338, y = 0.494, comment = AL["CYPHER_CONSOLE"] };
		[RSConstants.STEP2] = { x = 0.346, y = 0.706, comment = AL["NOTE_185285_1"] };
	}; --Drowned Broker Supplies
	["3754831970"] = { [RSConstants.PATH_START] = { x = 0.3404, y = 0.6658 } }; --Stolen Scroll
	["3735681970"] = { 
		[RSConstants.FLAG] = { x = 0.342, y = 0.486, comment = AL["NOTE_373568_1"] };
		[RSConstants.ENTRANCE] = { x = 0.3513, y = 0.4564, comment = AL["NOTE_373568_2"] };
	}; --Locked Provis Cache
	["3753691970"] = { [RSConstants.PATH_START] = { x = 0.4023, y = 0.7464 } }; --Gnawed Valise
	["3754111970"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5237, y = 0.7350 };
		[RSConstants.DOT..1] = { x = 0.3431, y = 0.6656, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..2] = { x = 0.3451, y = 0.4971, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..3] = { x = 0.3517, y = 0.4905, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..4] = { x = 0.3597, y = 0.4620, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..5] = { x = 0.4322, y = 0.8490, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..6] = { x = 0.4815, y = 0.7357, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..7] = { x = 0.4918, y = 0.7153, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..8] = { x = 0.5080, y = 0.7081, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..9] = { x = 0.5242, y = 0.7364, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..10] = { x = 0.5383, y = 0.6486, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..11] = { x = 0.5520, y = 0.7685, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..12] = { x = 0.6084, y = 0.7592, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..13] = { x = 0.3516, y = 0.4888, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..14] = { x = 0.5070, y = 0.6761, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..15] = { x = 0.4136, y = 0.6938, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..16] = { x = 0.3935, y = 0.5097, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..17] = { x = 0.4460, y = 0.5191, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..18] = { x = 0.5719, y = 0.7778, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..19] = { x = 0.5887, y = 0.6526, comment = AL["NOTE_375411_1"] };
		[RSConstants.DOT..20] = { x = 0.6088, y = 0.4298, comment = AL["NOTE_375411_1"] };
	}; --Mistaken Ovoid
	["3754851970"] = { 
		[RSConstants.PATH_START] = { x = 0.5580, y = 0.6501 } ;
		[RSConstants.FLAG] = { x = 0.5322, y = 0.7206, comment = AL["NOTE_375485_1"] };
	}; --Protoflora Harvester
	["3753821970"] = { 
		[RSConstants.FLAG] = { x = 0.5761, y = 0.6316, comment = AL["NOTE_375382_1"] };
	}; --Crushed Supply Crate
	["3749761970"] = { 
		[RSConstants.STEP1] = { x = 0.5260, y = 0.6406 }; 
		[RSConstants.STEP2] = { x = 0.5250, y = 0.6261 };
		[RSConstants.STEP3] = { x = 0.5218, y = 0.6390 };
		[RSConstants.STEP4] = { x = 0.5283, y = 0.6301 };
	}; --Symphonic Vault
	["3735481970"] = { [RSConstants.ENTRANCE] = { x = 0.5803, y = 0.4440 } }; --Template Archive (outside)
	["3735482030"] = { [RSConstants.FLAG] = { x = 0.7207, y = 0.4877 , comment = AL["NOTE_373548_1"] } }; --Template Archive (inside)
	["3754951970"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4963, y = 0.7699, comment = AL["NOTE_375495_1"] }; 
		[RSConstants.STEP1] = { x = 0.4995, y = 0.7673, comment = AL["NOTE_375495_2"], questID = 65592 };
		[RSConstants.STEP2] = { x = 0.5318, y = 0.8085, comment = AL["NOTE_375495_3"], questID = 65591 };
		[RSConstants.STEP3] = { x = 0.5099, y = 0.8199, comment = AL["NOTE_375495_3"], questID = 65589 };
		[RSConstants.STEP4] = { x = 0.5249, y = 0.8338, comment = AL["NOTE_375495_3"], questID = 65590 };
		[RSConstants.STEP5] = { x = 0.5125, y = 0.8070, comment = AL["NOTE_375495_4"], questID = 65572 };
	}; --Undulating Foliage
	["3754952066"] = { 
		[RSConstants.STEP2] = { x = 0.6964, y = 0.5275, comment = AL["NOTE_375495_3"], questID = 65591 };
		[RSConstants.STEP3] = { x = 0.3947, y = 0.6904, comment = AL["NOTE_375495_3"], questID = 65589 };
		[RSConstants.STEP4] = { x = 0.6011, y = 0.8667, comment = AL["NOTE_375495_3"], questID = 65590 };
		[RSConstants.STEP5] = { x = 0.4894, y = 0.3430, comment = AL["NOTE_375495_4"], questID = 65572 };
	}; --Undulating Foliage
	["3735431970"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5900, y = 0.8186 }; 
		[RSConstants.FLAG] = { x = 0.5791, y = 0.7891, comment = AL["NOTE_373543_1"] };
	}; --Library Vault
	["3754081970"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3513, y = 0.4564, comment = AL["CYPHER_CONSOLE_ENTRANCE"] };
		[RSConstants.STEP1] = { x = 0.338, y = 0.494, comment = AL["CYPHER_CONSOLE"] };
		[RSConstants.STEP2] = { x = 0.614, y = 0.514, comment = AL["NOTE_375408_1"] } 
	}; --Architect's Reserve
	["3754781970"] = { [RSConstants.TRANSPORT] = { x = 0.506, y = 0.319 , comment = AL["NOTE_375478_1"] } }; --Protomineral Extractor
	["3753761970"] = { [RSConstants.TRANSPORT] = { x = 0.4608, y = 0.2168 } }; --Fallen Vault
	["3754921970"] = { 
		[RSConstants.TRANSPORT] = { x = 0.6489, y = 0.5335 };
		[RSConstants.ENTRANCE] = { x = 0.7615, y = 0.5986 }; 
		[RSConstants.STEP1] = { x = 0.7699, y = 0.5879, comment = AL["NOTE_375492_1"] };
		[RSConstants.STEP2] = { x = 0.7705, y = 0.6032, comment = AL["NOTE_375492_1"] };
		[RSConstants.STEP3] = { x = 0.8093, y = 0.5626, comment = AL["NOTE_375492_1"] };
		[RSConstants.STEP4] = { x = 0.8126, y = 0.5045, comment = AL["NOTE_375492_1"] };
		[RSConstants.STEP5] = { x = 0.7692, y = 0.4667, comment = AL["NOTE_375492_1"] };
		[RSConstants.STEP6] = { x = 0.7806, y = 0.5339, comment = AL["NOTE_375492_1"] };
	}; --Fractal Sealed Vault
	["3754931970"] = { 
		[RSConstants.STEP1] = { x = 0.338, y = 0.494, comment = AL["CYPHER_CONSOLE"] };
		[RSConstants.STEP2] = { x = 0.5521, y = 0.6451, comment = AL["NOTE_375493_1"] };
		[RSConstants.ENTRANCE] = { x = 0.6360, y = 0.7363 }; 
	}; --Unripened Protopear
	["3754961970"] = { 
		[RSConstants.DOT..1] = { x = 0.4667, y = 0.8763, comment = AL["NOTE_375496_1"] };
		[RSConstants.DOT..2] = { x = 0.481, y = 0.8748, comment = AL["NOTE_375496_1"] };
		[RSConstants.DOT..3] = { x = 0.476, y = 0.894, comment = AL["NOTE_375496_1"] };
		[RSConstants.DOT..4] = { x = 0.470, y = 0.8684, comment = AL["NOTE_375496_1"] };
	}; --Bushel of Progenitor Produce
	["3697571970"] = {
		[RSConstants.STEP1] = { x = 0.594, y = 0.769, comment = AL["NOTE_369757_1"] };
		[RSConstants.STEP2] = { x = 0.5848, y = 0.7283, comment = AL["NOTE_369757_2"] };
	}; --
	["220986554"] = {
		[RSConstants.ENTRANCE] = { x = 0.172, y = 0.573 }; 
	}; --Blackguard's Jetsam
	["3778992022"] = {
		[RSConstants.STEP1] = { x = 0.6446, y = 0.6910, comment = AL["NOTE_377899_1"] }; 
		[RSConstants.STEP2] = { x = 0.3964, y = 0.8469, comment = AL["NOTE_377899_2"] }; 
		[RSConstants.STEP3] = { x = 0.4773, y = 0.8363, comment = AL["NOTE_377899_3"] }; 
		[RSConstants.STEP4] = { x = 0.6618, y = 0.5530, comment = AL["NOTE_377899_4"] }; 
	}; --Hidden Hornswog Hostage
	["3809912023"] = {
		[RSConstants.DOT..1] = { x = 0.6093, y = 0.4377, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..2] = { x = 0.6093, y = 0.4295, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..3] = { x = 0.6122, y = 0.4183, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..4] = { x = 0.6162, y = 0.4120, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..5] = { x = 0.6178, y = 0.4145, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..6] = { x = 0.6186, y = 0.4218, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..7] = { x = 0.6138, y = 0.4141, comment = AL["NOTE_380991_1"] }; 
		[RSConstants.DOT..8] = { x = 0.6104, y = 0.4236, comment = AL["NOTE_380991_1"] }; 
	}; --Dirt Mound
	["3810452022"] = {
		[RSConstants.FLAG] = { x = 0.7655, y = 0.3424, comment = AL["NOTE_381045_1"] }; 
	}; --Replica Dragon Goblet
	["1959392022"] = {
		[RSConstants.FLAG] = { x = 0.4093, y = 0.4147, comment = AL["NOTE_195939_1"] }; 
	}; --Bubble Drifter
	["3811072025"] = {
		[RSConstants.FLAG] = { x = 0.5491, y = 0.7545, comment = AL["NOTE_381107_1"] }; --, questID = 70538 
	}; --Sandy Wooden Duck
	["3773172118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.7327, y = 0.3899 };
	}; --Treasure Hoard
	["3761232118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6355, y = 0.4575 };
	}; --Suspicious Bottle
	["3808422023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.8186, y = 0.7221 };
	}; --Gold Swog Coin
	["3823252022"] = { 
		[RSConstants.ENTRANCE] = { x = 0.2940, y = 0.5258 };
	}; --Onyx Gem Cluster
	["1953732024"] = { 
		[RSConstants.PATH_START] = { x = 0.2573, y = 0.4653 };
		[RSConstants.STEP1] = { x = 0.2629, y = 0.4633, comment = AL["NOTE_195373_1"] };
	}; --Pepper Hammer
	["1919922118"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3945, y = 0.2355 };
	}; --Eviscerated Argali
	["3806202023"] = { 
		[RSConstants.ENTRANCE] = { x = 0.7934, y = 0.3650 };
	}; --Ancient Spear Shards
	["3805562024"] = { 
		[RSConstants.STEP1] = { x = 0.4462, y = 0.6132, comment = AL["NOTE_380556_1"] }; 
		[RSConstants.STEP2] = { x = 0.4471, y = 0.6199, comment = AL["NOTE_380556_2"] }; 
		[RSConstants.STEP3] = { x = 0.4418, y = 0.6198, comment = AL["NOTE_380556_2"] }; 
		[RSConstants.STEP4] = { x = 0.4468, y = 0.6020, comment = AL["NOTE_380556_2"] }; 
	}; --Harmonic Crystal Harmonizer
	["3812232025"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.3242, y = 0.7561 };
		[RSConstants.ENTRANCE..2] = { x = 0.3251, y = 0.7490 };
		[RSConstants.ENTRANCE..3] = { x = 0.3311, y = 0.7414 };
		[RSConstants.ENTRANCE..4] = { x = 0.3398, y = 0.7469 };
	}; --Cracked Hourglass
	["1986042025"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5276, y = 0.8324 };
	}; --Cracked Hourglass
	["3806232024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5305, y = 0.6528 };
	}; --Spelltouched Tongs
	["3761752022"] = { 
		[RSConstants.DOT..1] = { x = 0.7660, y = 0.4280, comment = AL["NOTE_376175_1"] };
		[RSConstants.DOT..2] = { x = 0.8000, y = 0.4400, comment = AL["NOTE_376175_1"] };
		[RSConstants.DOT..3] = { x = 0.8220, y = 0.4260, comment = AL["NOTE_376175_1"] };
		[RSConstants.DOT..4] = { x = 0.8120, y = 0.4599, comment = AL["NOTE_376175_1"] };
		[RSConstants.DOT..5] = { x = 0.7920, y = 0.4520, comment = AL["NOTE_376175_1"] };
		[RSConstants.DOT..6] = { x = 0.7800, y = 0.4390, comment = AL["NOTE_376175_1"] };
	}; --Fullsails Supply Chest
	["3805582022"] = { 
		[RSConstants.FLAG] = { x = 0.5752, y = 0.5849, comment = AL["NOTE_380558_1"] };
	}; --Enchanted Debris
	["3805712022"] = { 
		[RSConstants.STEP1] = { x = 0.5591, y = 0.4529, comment = AL["NOTE_380571_1"] };
		[RSConstants.STEP2] = { x = 0.5783, y = 0.4458, comment = AL["NOTE_380571_2"] };
		[RSConstants.STEP3] = { x = 0.5799, y = 0.4435, comment = AL["NOTE_380571_3"] };
		[RSConstants.STEP4] = { x = 0.5813, y = 0.4454, comment = AL["NOTE_380571_4"] };
	}; --Boomthyr Rocket
	["3808222022"] = { 
		[RSConstants.STEP1] = { x = 0.3321, y = 0.6258, comment = AL["NOTE_380822_1"] };
		[RSConstants.STEP2] = { x = 0.3301, y = 0.6410, comment = AL["NOTE_380822_1"] };
		[RSConstants.STEP3] = { x = 0.3438, y = 0.6460, comment = AL["NOTE_380822_1"] };
	}; --Igneous Gem
	["3805842025"] = { 
		[RSConstants.FLAG] = { x = 0.4984, y = 0.4031, comment = AL["NOTE_380584_1"] };
	}; --Curious Glyph
	["3806012024"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4652, y = 0.2430 };
	}; --Dusty Darkmoon Card
	["2010032025"] = { 
		[RSConstants.DOT..1] = { x = 0.5520, y = 0.3060, comment = AL["NOTE_201003_1"] };
		[RSConstants.DOT..2] = { x = 0.5660, y = 0.2900, comment = AL["NOTE_201003_1"] };
		[RSConstants.DOT..3] = { x = 0.5660, y = 0.3060, comment = AL["NOTE_201003_1"] };
		[RSConstants.DOT..4] = { x = 0.5580, y = 0.3100, comment = AL["NOTE_201003_1"] };
		[RSConstants.DOT..5] = { x = 0.5580, y = 0.3120, comment = AL["NOTE_201003_1"] };
	}; --Furry Gloop
	["3823252022"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.3063, y = 0.5147 };
		[RSConstants.ENTRANCE..2] = { x = 0.2942, y = 0.5272 };
	}; --Onyx Gem Cluster
	["3780102023"] = { 
		[RSConstants.STEP1..1] = { x = 0.2661, y = 0.4876, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..2] = { x = 0.2686, y = 0.4733, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..3] = { x = 0.2758, y = 0.5276, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..4] = { x = 0.2774, y = 0.5084, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..5] = { x = 0.2935, y = 0.4888, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..6] = { x = 0.2949, y = 0.5166, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..7] = { x = 0.3050, y = 0.4596, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..8] = { x = 0.3618, y = 0.4690, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP1..9] = { x = 0.3213, y = 0.4689, comment = AL["NOTE_378010_1"] };
		[RSConstants.STEP2] = { x = 0.6703, y = 0.4372, comment = AL["NOTE_378010_2"] };
		[RSConstants.STEP3] = { x = 0.6697, y = 0.5036, comment = AL["NOTE_378010_3"] };
	}; --Forgotten Dragon Treasure
	["3862142151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Frozenheart Cairn
	["3861652151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Obsidian Coffer
	["3861662151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Bone Pile
	["3861672151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Irontide Stash
	["3861682151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Farscale Cache
	["3861722151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Morqut Provisions
	["3861742151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Avian Trove
	["3861792151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Spellsworn Reserves
	["3862082151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Storm-Eater Cairn
	["3862122151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Stonescaled Cairn
	["3862132151"] = { 
		[RSConstants.FLAG] = { x = 0.3420, y = 0.5980, comment = AL["NOTE_CATALOGER_DAELA"] };
	}; --Blazing Cairn
	["4018282133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.6248, y = 0.7321 };
	}; --Nal ks'kol Reliquary
	["3889112133"] = { 
		[RSConstants.STEP1] = { x = 0.4292, y = 0.8261, comment = AL["NOTE_388911_1"] };
		[RSConstants.STEP2] = { x = 0.4215, y = 0.8016, comment = AL["NOTE_388911_1"] };
		[RSConstants.STEP3] = { x = 0.4170, y = 0.8145, comment = AL["NOTE_388911_1"] };
		[RSConstants.STEP4] = { x = 0.4270, y = 0.8222, comment = AL["NOTE_388911_1"] };
		[RSConstants.STEP5] = { x = 0.4371, y = 0.8386, comment = AL["NOTE_388911_2"] };
	}; --Old Trunk
	["3888962133"] = { 
		[RSConstants.STEP1] = { x = 0.3775, y = 0.6885, comment = AL["NOTE_388896_1"] };
		[RSConstants.STEP2] = { x = 0.3941, y = 0.7327, comment = AL["NOTE_388896_1"] };
	}; --Crystal-encased Chest
	["3860792133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.3041, y = 0.4145 };
		[RSConstants.FLAG] = { x = 0.3012, y = 0.4074, comment = AL["NOTE_386079_1"] };
	}; --Well-Chewed Chest
	["3988142133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4840, y = 0.1880 };
	}; --Molten Hoard
	["3981382133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4840, y = 0.1880 };
	}; --Molten Scoutbot
	["3925912133"] = { 
		[RSConstants.PATH_START] = { x = 0.5443, y = 0.0801 };
		[RSConstants.DOT..1] = { x = 0.5467, y = 0.0684 };
		[RSConstants.DOT..2] = { x = 0.5498, y = 0.0568 };
		[RSConstants.DOT..3] = { x = 0.5513, y = 0.0466 };
		[RSConstants.DOT..4] = { x = 0.5513, y = 0.0466 };
		[RSConstants.DOT..5] = { x = 0.5553, y = 0.0399 };
		[RSConstants.ENTRANCE] = { x = 0.5573, y = 0.0363 };
	}; --Chest of the Flights
	["3960202133"] = { 
		[RSConstants.ENTRANCE..1] = { x = 0.6037, y = 0.3725 };
		[RSConstants.ENTRANCE..2] = { x = 0.6152, y = 0.3895 };
	}; --Stolen Stash
	["3861042133"] = { 
		[RSConstants.FLAG] = { x = 0.3645, y = 0.4822, comment = AL["NOTE_386104_1"] };
	}; --Ancient Zaqali Chest
	["4028922133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5281, y = 0.1885 };
	}; --Ancient Research
	["4012992133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.5413, y = 0.3290 };
	}; --Broken Barter Boulder
	["3987932133"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4840, y = 0.1880 };
	}; --Lava-Drenched Shadow Crystal
	["3860862133"] = { 
		[RSConstants.DOT..1] = { x = 0.2520, y = 0.4480, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..2] = { x = 0.2670, y = 0.4700, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..3] = { x = 0.2760, y = 0.4900, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..4] = { x = 0.2800, y = 0.5130, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..4] = { x = 0.2875, y = 0.5530, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..5] = { x = 0.2995, y = 0.4797, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..7] = { x = 0.3020, y = 0.4000, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..8] = { x = 0.3120, y = 0.5200, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..10] = { x = 0.3273, y = 0.5224, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..11] = { x = 0.3441, y = 0.4571, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..12] = { x = 0.3440, y = 0.4880, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..13] = { x = 0.3630, y = 0.4410, comment = AL["NOTE_386086_1"] };
		[RSConstants.DOT..14] = { x = 0.3760, y = 0.4668, comment = AL["NOTE_386086_1"] };
	}; --Seething Cache
	["3988102133"] = { 
		[RSConstants.FLAG] = { x = 0.4357, y = 0.2302, comment = AL["NOTE_398810_1"] };
	}; --Fealty's Reward
	["4110652200"] = {
		[RSConstants.ENTRANCE] = { x = 0.6345, y = 0.7156 };
	}; --Reliquary of Ashamane
	["4110652254"] = {
		[RSConstants.ENTRANCE] = { x = 0.6525, y = 0.4875 };
		[RSConstants.FLAG] = { x = 0.6248, y = 0.6004, comment = AL["NOTE_411065_1"] };
	}; --Reliquary of Ashamane
	["4114652200"] = {
		[RSConstants.ENTRANCE] = { x = 0.5476, y = 0.4441 };
	}; --Unwaking Echo
	["4092222200"] = {
		[RSConstants.FLAG] = { x = 0.4788, y = 0.5430, comment = AL["NOTE_409222_1"] };
	}; --Reliquary of Ursol
	["4110672200"] = {
		[RSConstants.ENTRANCE] = { x = 0.3310, y = 0.8242 };
		[RSConstants.FLAG] = { x = 0.3082, y = 0.8069, comment = AL["NOTE_411067_1"] };
	}; --Reliquary of Goldrinn
	["4110662200"] = {
		[RSConstants.FLAG] = { x = 0.6212, y = 0.2351, comment = AL["NOTE_411066_1"] };
	}; --Reliquary of Aviana
	["4077392200"] = {
		[RSConstants.STEP1] = { x = 0.3971, y = 0.5215, comment = AL["NOTE_407739_1"] };
		[RSConstants.STEP2] = { x = 0.4222, y = 0.5630, comment = AL["NOTE_407739_2"] };
		[RSConstants.STEP3] = { x = 0.4175, y = 0.6256, comment = AL["NOTE_407739_3"] };
		[RSConstants.STEP4] = { x = 0.3409, y = 0.5634, comment = AL["NOTE_407739_4"] };
	}; --Triflesnatch's Roving Trove
	["4104342200"] = {
		[RSConstants.ENTRANCE] = { x = 0.6345, y = 0.7156 };
	}; --Splash Potion of Narcolepsy
	["4464192255"] = {
		[RSConstants.PATH_START] = { x = 0.3469, y = 0.5941 };
		[RSConstants.DOT..1] = { x = 0.3395, y = 0.5987 };
		[RSConstants.DOT..2] = { x = 0.3376, y = 0.6044 };
	}; --Concealed contraband
	["4462992255"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.6460, y = 0.2962 };
		[RSConstants.ENTRANCE..2] = { x = 0.6544, y = 0.2764 };
	}; --Silk-spun Supplies
	["4453602255"] = {
		[RSConstants.ENTRANCE] = { x = 0.7756, y = 0.5907 };
	}; --Stashed Loot
	["4461012213"] = {
		[RSConstants.ENTRANCE] = { x = 0.3125, y = 0.1959 };
	}; --Nerubian Offerings
	["4461012255"] = {
		[RSConstants.ENTRANCE] = { x = 0.4222, y = 0.7168 };
	}; --Nerubian Offerings
	["4532742215"] = {
		[RSConstants.FLAG] = { x = 0.5543, y = 0.5166, comment = AL["NOTE_453274_1"] };
	}; --Smuggler's Treasure
	["4533742215"] = {
		[RSConstants.ENTRANCE] = { x = 0.5966, y = 0.6068 };
	}; --Shadowed Essence
	["4196952215"] = {
		[RSConstants.ENTRANCE] = { x = 0.7604, y = 0.5364 };
	}; --Spore-Covered Coffer
	["4372112215"] = {
		[RSConstants.ENTRANCE] = { x = 0.5755, y = 0.2744 };
	}; --Illuminated Footlocker
	["4440872214"] = {
		[RSConstants.ENTRANCE] = { x = 0.5052, y = 0.1421 };
	}; --Munderut's Forgotten Stash
	["4200532214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6454, y = 0.4070 };
	}; --Webbed Knapsack
	["4463412214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4354, y = 0.3217 };
		[RSConstants.DOT..1] = { x = 0.5327, y = 0.4944, itemID = 223878 };
		[RSConstants.DOT..2] = { x = 0.6403, y = 0.5321, itemID = 223882 };
		[RSConstants.DOT..3] = { x = 0.5488, y = 0.3809, itemID = 223881 };
		[RSConstants.DOT..4] = { x = 0.5311, y = 0.2187, itemID = 223880 };
		[RSConstants.DOT..5] = { x = 0.5839, y = 0.6311, itemID = 223879 };
	}; --Dusty Prospector's Chest
	["4442562214"] = {
		[RSConstants.ENTRANCE] = { x = 0.5466, y = 0.6423 };
	}; --Kaja'Cola Machine
	["4448942248"] = {
		[RSConstants.ENTRANCE] = { x = 0.4736, y = 0.6163 };
	}; --Opal Lily
	["4442332248"] = {
		[RSConstants.FLAG] = { x = 0.5284, y = 0.6602, comment = AL["NOTE_444233_1"] };
	}; --Mushroom Cap
	["4442152248"] = {
		[RSConstants.FLAG] = { x = 0.5308, y = 0.1854, comment = AL["NOTE_444215_1"] };
	}; --Weary Water Elemental
	["4436382248"] = {
		[RSConstants.FLAG] = { x = 0.5960, y = 0.2454, comment = AL["NOTE_443638_1"] };
	}; --Elemental Geode
	["4443542248"] = {
		[RSConstants.FLAG..1] = { x = 0.5158, y = 0.3982, comment = AL["NOTE_444354_1"] };
	}; --Turtle's Thanks
	["4443542339"] = {
		[RSConstants.FLAG] = { x = 0.5831, y = 0.3031, comment = AL["NOTE_444354_1"] };
	}; --Turtle's Thanks
	["4433182248"] = {
		[RSConstants.ENTRANCE] = { x = 0.4865, y = 0.3125 };
		[RSConstants.DOT..1] = { x = 0.5071, y = 0.7058, comment = AL["NOTE_443318_1"], questID = 82751 };
		[RSConstants.DOT..2] = { x = 0.7077, y = 0.1999, comment = AL["NOTE_443318_3"], questID = 82753 };
		[RSConstants.DOT..3] = { x = 0.4185, y = 0.2701, comment = AL["NOTE_443318_1"], questID = 82754 };
		[RSConstants.DOT..4] = { x = 0.1973, y = 0.5843, comment = AL["NOTE_443318_1"], questID = 82755 };
		[RSConstants.DOT..5] = { x = 0.3827, y = 0.4202, comment = AL["NOTE_443318_2"], questID = 82756 };
		[RSConstants.DOT..6] = { x = 0.7490, y = 0.4969, comment = AL["NOTE_443318_1"], questID = 82752 };
	}; --Tree's Treasure
	["4337332214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4787, y = 0.5311 };
	}; --Forgotten Treasure
	["4537552215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4838, y = 0.3982 };
	}; --The Big Book of Arathi Idioms
	["4416372215"] = {
		[RSConstants.ENTRANCE] = { x = 0.7920, y = 0.4110 };
	}; --A Weathered Tome
	["4531672215"] = {
		[RSConstants.FLAG] = { x = 0.6920, y = 0.4400, comment = AL["NOTE_453167_1"] };
	}; --Caesper
	["4415552214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4651, y = 0.5751 };
	}; --Wax-Drenched Sign
	["4464202255"] = {
		[RSConstants.DOT..1] = { x = 0.7479, y = 0.4285, comment = AL["NOTE_446420_1"] };
		[RSConstants.DOT..2] = { x = 0.7267, y = 0.3967, comment = AL["NOTE_446420_2"] };
		[RSConstants.DOT..3] = { x = 0.7418, y = 0.3770, comment = AL["NOTE_446420_3"] };
	}; --"Weaving Supplies"
	["4464042256"] = {
		[RSConstants.FLAG] = { x = 0.6346, y = 0.8589, comment = AL["NOTE_446404_1"] };
	}; --Memory Cache
	["4559772248"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.6323, y = 0.6730 };
		[RSConstants.ENTRANCE..2] = { x = 0.6312, y = 0.6716 };
	}; --Gentle Jewel Hammer
	["4559752214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4400, y = 0.3477 };
	}; --Carved Stone File
	["4559742214"] = {
		[RSConstants.ENTRANCE] = { x = 0.5329, y = 0.5478 };
	}; --Jeweler's Delicate Drill
	["4560052215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4013, y = 0.7009 };
	}; --Essence of Holy Fire
	["4559722215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4439, y = 0.5099 };
	}; --Librarian's Magnifiers
	["4559702255"] = {
		[RSConstants.ENTRANCE] = { x = 0.5566, y = 0.5875 };
	}; --Nerubian Bench Blocks
	["4559452339"] = {
		[RSConstants.ENTRANCE] = { x = 0.6046, y = 0.2061 };
	}; --Dornogal Seam Ripper
	["4559432214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4354, y = 0.3216 };
	}; --Runed Earthen Pins
	["4560222214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6054, y = 0.6161 };
	}; --Engraved Stirring Rod
	["4560202215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4185, y = 0.5534 };
	}; --Sanctified Mortar and Pestle
	["4560182255"] = {
		[RSConstants.ENTRANCE] = { x = 0.4331, y = 0.5652 };
	}; --Dark Apothecary's Vial
	["4559392255"] = {
		[RSConstants.ENTRANCE] = { x = 0.5355, y = 0.5253 };
	}; --Nerubian Quilt
	["4560192213"] = {
		[RSConstants.ENTRANCE] = { x = 0.4616, y = 0.1403 };
	}; --Nerubian Mixing Salts
	["4559852339"] = {
		[RSConstants.ENTRANCE] = { x = 0.5567, y = 0.4884 };
	}; --Dornogal Scribe's Quill
	["4559842248"] = {
		[RSConstants.ENTRANCE] = { x = 0.5609, y = 0.6030 };
	}; --Historian's Dip Pen
	["4559832214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4416, y = 0.3420 };
	}; --Runic Scroll
	["4559912214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4400, y = 0.3475 };
	}; --Earthen Digging Fork
	["4559822214"] = {
		[RSConstants.ENTRANCE] = { x = 0.5835, y = 0.5875 };
	}; --Blue Earthen Pigment
	["4559802215"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4272, y = 0.4889 };
		[RSConstants.ENTRANCE..2] = { x = 0.4334, y = 0.4982 };
	}; --Calligrapher's Chiselled Marker
	["4559782213"] = {
		[RSConstants.ENTRANCE] = { x = 0.4873, y = 0.3175 };
	}; --Venomancer's Ink Well
	["4559692339"] = {
		[RSConstants.ENTRANCE] = { x = 0.6772, y = 0.2440 };
	}; --Earthen Lacing Tools
	["4559532339"] = {
		[RSConstants.ENTRANCE] = { x = 0.3038, y = 0.5609 };
	}; --Dornogal Carving Knife
	["4559672214"] = {
		[RSConstants.ENTRANCE] = { x = 0.4295, y = 0.3387 };
	}; --Underground Stropping Compound
	["4559482215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4235, y = 0.5362 };
	}; --Arathi Craftsman's Spokeshave
	["4559492215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4924, y = 0.6206 };
	}; --Arathi Tanning Agent
	["4559652215"] = {
		[RSConstants.ENTRANCE] = { x = 0.4735, y = 0.6494 };
	}; --Arathi Beveler Set
	["4559632213"] = {
		[RSConstants.ENTRANCE] = { x = 0.5548, y = 0.2778 };
	}; --Nerubian Tanning Mallet
	["4559472216"] = {
		[RSConstants.ENTRANCE] = { x = 0.4677, y = 0.4912 };
	}; --Nerubian's Slicking Iron
	["4559472213"] = {
		[RSConstants.ENTRANCE] = { x = 0.4677, y = 0.4912 };
	}; --Nerubian's Slicking Iron
	["4560002339"] = {
		[RSConstants.ENTRANCE] = { x = 0.6424, y = 0.5182 };
	}; --Dornogal Spectacles
	["4559982214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6041, y = 0.5907 };
	}; --Earthen Construct Blueprints
	["4559952255"] = {
		[RSConstants.ENTRANCE] = { x = 0.5652, y = 0.4057 };
	}; --Puppeted Mechanical Spider
	["4543352216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543352213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543352255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543362216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543362213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543362255"] = {
		[RSConstants.ENTRANCE] = { x = 0.3990, y = 0.3988 };
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 2
	["4543382216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543382213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 1
	["4543382255"] = {
		[RSConstants.ENTRANCE] = { x = 0.3990, y = 0.3988 };
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Entomological Essay on Grubs, Volume 3
	["4543282216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Strands of Memory
	["4543282213"] = {
		[RSConstants.ENTRANCE] = { x = 0.2846, y = 0.5271 };
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Strands of Memory
	["4543282255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Strands of Memory
	["4543432216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 1
	["4543432213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 1
	["4543432255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 1
	["4543442216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 2
	["4543442213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 2
	["4543442255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE..1] = { x = 0.6460, y = 0.2962 };
		[RSConstants.ENTRANCE..2] = { x = 0.6544, y = 0.2764 };
	}; --Ethos of War, Part 2
	["4543482216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 3
	["4543482213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 3
	["4543482255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE] = { x = 0.4857, y = 0.2383 };
	}; --Ethos of War, Part 3
	["4543502216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 4
	["4543502213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Ethos of War, Part 4
	["4543502255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE] = { x = 0.4392, y = 0.2559 };
	}; --Ethos of War, Part 4
	["4543132216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Xekatha
	["4543132213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE] = { x = 0.4054, y = 0.3384 };
	}; --Queen Xekatha
	["4543132255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Xekatha
	["4543202216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Anub'izek
	["4543202213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE] = { x = 0.4054, y = 0.3384 };
	}; --Queen Anub'izek
	["4543202255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Anub'izek
	["4543162216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Zaltra
	["4543162213"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
		[RSConstants.ENTRANCE] = { x = 0.4054, y = 0.3384 };
	}; --Queen Zaltra
	["4543162255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Queen Zaltra
	["4543322216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Sages
	["4543322213"] = {
		[RSConstants.ENTRANCE] = { x = 0.4017, y = 0.3875 };
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Sages
	["4543322255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Sages
	["4543302216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Skitterlings
	["4543302213"] = {
		[RSConstants.ENTRANCE] = { x = 0.4017, y = 0.3875 };
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Skitterlings
	["4543302255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Skitterlings
	["4569272216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Lords
	["4569272213"] = {
		[RSConstants.ENTRANCE] = { x = 0.2603, y = 0.5127 };
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Lords
	["4569272255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Lords
	["4569282216"] = {
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Ascended
	["4569282213"] = {
		[RSConstants.ENTRANCE] = { x = 0.7688, y = 0.3923 };
		[RSConstants.FLAG] = { x = 0.5727, y = 0.3629, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Ascended
	["4569282255"] = {
		[RSConstants.FLAG] = { x = 0.5131, y = 0.7767, comment = AL["NOTE_REJ_DYING"] };
	}; --Treatise on Forms: Ascended
	["2256412215"] = {
		[RSConstants.STEP1..1] = { x = 0.5400, y = 0.2640, comment = AL["NOTE_225641_1"] };
		[RSConstants.STEP1..2] = { x = 0.5380, y = 0.2980, comment = AL["NOTE_225641_1"] };
		[RSConstants.STEP1..3] = { x = 0.5400, y = 0.3080, comment = AL["NOTE_225641_1"] };
		[RSConstants.STEP1..4] = { x = 0.5460, y = 0.2720, comment = AL["NOTE_225641_1"] };
		[RSConstants.STEP2..1] = { x = 0.4420, y = 0.1460, comment = AL["NOTE_225641_2"] };
		[RSConstants.STEP2..2] = { x = 0.4480, y = 0.1120, comment = AL["NOTE_225641_2"] };
		[RSConstants.STEP2..3] = { x = 0.4620, y = 0.1060, comment = AL["NOTE_225641_2"] };
		[RSConstants.STEP2..4] = { x = 0.4720, y = 0.1520, comment = AL["NOTE_225641_2"] };
		[RSConstants.STEP2..5] = { x = 0.4840, y = 0.1720, comment = AL["NOTE_225641_2"] };
		[RSConstants.STEP3..1] = { x = 0.4960, y = 0.4940, comment = AL["NOTE_225641_3"] };
		[RSConstants.STEP3..2] = { x = 0.5180, y = 0.4880, comment = AL["NOTE_225641_3"] };
		[RSConstants.STEP3..3] = { x = 0.5140, y = 0.5180, comment = AL["NOTE_225641_3"] };
		[RSConstants.STEP4..1] = { x = 0.3560, y = 0.5280, comment = AL["NOTE_225641_4"] };
		[RSConstants.STEP4..2] = { x = 0.3560, y = 0.5620, comment = AL["NOTE_225641_4"] };
		[RSConstants.STEP4..3] = { x = 0.3560, y = 0.5520, comment = AL["NOTE_225641_4"] };
		[RSConstants.STEP4..4] = { x = 0.3460, y = 0.5560, comment = AL["NOTE_225641_4"] };
		[RSConstants.STEP4..5] = { x = 0.3440, y = 0.5380, comment = AL["NOTE_225641_4"] };
	}; --Illusive Kobyss Lure
	["4639792215"] = {
		[RSConstants.ENTRANCE] = { x = 0.5274, y = 0.6019 };
	}; --Lightspark Sky Academy Gradebook
	["4537412215"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4101, y = 0.5079 };
		[RSConstants.ENTRANCE..2] = { x = 0.4011, y = 0.5011 };
		[RSConstants.ENTRANCE..3] = { x = 0.4012, y = 0.5148 };
	}; --Loremaster's Reward
	["4350082215"] = {
		[RSConstants.FLAG] = { x = 0.6580, y = 0.2440, comment = AL["NOTE_CONTAINER_SPARKBUG_1"] };
	}; --Farmhand Stash
	["4417232215"] = {
		[RSConstants.FLAG] = { x = 0.6580, y = 0.2440, comment = AL["NOTE_CONTAINER_SPARKBUG_1"] };
	}; --Farm Satchel
	["4284722215"] = {
		[RSConstants.ENTRANCE] = { x = 0.6587, y = 0.1874 };
	}; --Captain Lancekat's Discretionary Funds
	["255341680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2926, y = 0.5068 };
	}; --Llorian's Supplies
	["252449680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2040, y = 0.4100 };
	}; --Shimmering Ancient Mana Cluster
	["252446680"] = {
		[RSConstants.ENTRANCE] = { x = 0.6586, y = 0.4190 };
	}; --Shimmering Ancient Mana Cluster
	["252450680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2901, y = 0.8481 };
	}; --Shimmering Ancient Mana Cluster
	["244628650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5417, y = 0.5078 };
	}; --Taurson's Prize
	["244473650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4869, y = 0.5001 };
	}; --Thunder Totem Stolen Goods
	["4933752369"] = {
		[RSConstants.ENTRANCE] = { x = 0.6826, y = 0.7159 };
	}; --Rune-Sealed Coffer
	["5055032369"] = {
		[RSConstants.ENTRANCE] = { x = 0.4217, y = 0.4704 };
	}; --Ashvane Issued Workboots
	["4642332369"] = {
		[RSConstants.FLAG] = { x = 0.5996, y = 0.6930, comment = AL["NOTE_464233_1"] };
	}; --Bilge Rat Supply Chest
	["3445881533"] = { 
		[RSConstants.ENTRANCE] = { x = 0.4091, y = 0.4724 } 
	}; --Stewart's Stewpendous Stew
	["5029142214"] = {
		[RSConstants.ENTRANCE] = { x = 0.6802, y = 0.9657 };
	}; --Extractor Drill X-78 Safety Guide
	["4760662346"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4045, y = 0.2014 };
		[RSConstants.ENTRANCE..2] = { x = 0.3940, y = 0.2588 };
	}; --Abandoned Toolbox
	["4773762346"] = {
		[RSConstants.ENTRANCE] = { x = 0.4198, y = 0.5261 };
	}; --Trick Deck of Cards
	["4908162346"] = {
		[RSConstants.ENTRANCE] = { x = 0.4880, y = 0.4131 };
	}; --Unexploded Fireworks
	["4743962346"] = {
		[RSConstants.PATH_START] = { x = 0.7204, y = 0.2868 };
	}; --Muff's Auto-Locker
	["4991192346"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5900, y = 0.1719 };
		[RSConstants.ENTRANCE..2] = { x = 0.5902, y = 0.1980 };
		[RSConstants.FLAG] = { x = 0.5875, y = 0.1797, comment = AL["NOTE_499119_1"] };
	}; --Lonely Tub
	["4992072346"] = {
		[RSConstants.ENTRANCE] = { x = 0.4916, y = 0.6610 };
	}; --Suspicious Book
	["5029022346"] = {
		[RSConstants.ENTRANCE] = { x = 0.3381, y = 0.5757 };
	}; --Second Half of Noggenfogger's Journal
	["5029082346"] = {
		[RSConstants.ENTRANCE] = { x = 0.2903, y = 0.6963 };
	}; --A Threatening Letter
	["5029032346"] = {
		[RSConstants.ENTRANCE] = { x = 0.5860, y = 0.5941 };
	}; --Gallywix's Notes
	["5028932346"] = {
		[RSConstants.ENTRANCE] = { x = 0.4051, y = 0.2859 };
	}; --First Half of Noggenfogger's Journal
	["213364371"] = {
		[RSConstants.ENTRANCE] = { x = 0.4595, y = 0.2900 };
	}; --Ancient Pandaren Mining Pick
	["214337371"] = {
		[RSConstants.ENTRANCE] = { x = 0.6269, y = 0.2667 };
	}; --Stash of Gems
	["213750418"] = {
		[RSConstants.ENTRANCE] = { x = 0.7036, y = 0.0947 };
	}; --Saurok Stone Tablet
	["213750376"] = {
		[RSConstants.ENTRANCE] = { x = 0.7715, y = 0.5729 };
	}; --Saurok Stone Tablet
	["211993418"] = {
		[RSConstants.ENTRANCE] = { x = 0.5232, y = 0.8612 };
	}; --Hozen Maturity
	["213650376"] = {
		[RSConstants.ENTRANCE] = { x = 0.2320, y = 0.3073 };
	}; --Virmen Treasure Cache
	["213649376"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4354, y = 0.3513 };
		[RSConstants.ENTRANCE..2] = { x = 0.4420, y = 0.3856 };
		[RSConstants.ENTRANCE..3] = { x = 0.4329, y = 0.4114 };
	}; --Cache of Pilfered Goods
	["213967422"] = {
		[RSConstants.ENTRANCE] = { x = 0.6675, y = 0.6374 };
	}; --Blade of the Prime
	["213970422"] = {
		[RSConstants.ENTRANCE] = { x = 0.2577, y = 0.5425 };
	}; --Bloodsoaked Chitin Fragment
	["213411422"] = {
		[RSConstants.ENTRANCE] = { x = 0.5363, y = 0.1568 };
	}; --Amber
	["213956388"] = {
		[RSConstants.ENTRANCE] = { x = 0.3286, y = 0.6166 };
	}; --Fragment of Dread
	["64227379"] = {
		[RSConstants.ENTRANCE] = { x = 0.3739, y = 0.7785 };
	}; --Frozen Trail Packer
	["214407379"] = {
		[RSConstants.ENTRANCE] = { x = 0.4813, y = 0.7301 };
	}; --Mo-Mo's Treasure Chest
	["213768379"] = {
		[RSConstants.ENTRANCE] = { x = 0.5286, y = 0.7133 };
	}; --Hozen Warrior Spear
	["213769379"] = {
		[RSConstants.ENTRANCE] = { x = 0.5035, y = 0.6173 };
	}; --Hozen Treasure Cache
	["213331379"] = {
		[RSConstants.ENTRANCE] = { x = 0.5299, y = 0.4651 };
	}; --Valley of the Emperors
	["213793379"] = {
		[RSConstants.ENTRANCE] = { x = 0.5226, y = 0.5084 };
	}; --Rikktik's Tiny Chest
	["213770379"] = {
		[RSConstants.ENTRANCE] = { x = 0.5953, y = 0.5294 };
	}; --Stolen Sprite Treasure
	["214438379"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.6394, y = 0.4975 };
		[RSConstants.ENTRANCE..2] = { x = 0.6321, y = 0.4189 };
	}; --Ancient Mogu Tablet
	["213751379"] = {
		[RSConstants.ENTRANCE] = { x = 0.7302, y = 0.7348 };
	}; --Sprite's Cloth Chest
	["213328379"] = {
		[RSConstants.ENTRANCE] = { x = 0.7319, y = 0.9446 };
	}; --The Defiant
	["213328433"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5771, y = 0.1340 };
		[RSConstants.ENTRANCE..2] = { x = 0.5075, y = 0.3990 };
	}; --The Defiant
	["214325433"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5512, y = 0.7325 };
		[RSConstants.ENTRANCE..2] = { x = 0.5417, y = 0.7175 };
	}; --Forgotten Lockbox
	["218436504"] = {
		[RSConstants.ENTRANCE] = { x = 0.5864, y = 0.3076 };
	}; --Shadow, Storm, and Stone
	["218437504"] = {
		[RSConstants.ENTRANCE] = { x = 0.5441, y = 0.2888 };
	}; --The Curse and the Silence
	["3550351536"] = {
		[RSConstants.FLAG..1] = { x = 0.3909, y = 0.6404, comment = AL["NOTE_355035_1"] };
		[RSConstants.FLAG..2] = { x = 0.3773, y = 0.6451, comment = AL["NOTE_355035_1"] };
		[RSConstants.FLAG..3] = { x = 0.3813, y = 0.6671, comment = AL["NOTE_355035_1"] };
	}; --Chosen Runecoffer
	["5038232472"] = {
		[RSConstants.ENTRANCE] = { x = 0.4801, y = 0.6301 };
	}; --Mailroom Distribution
	["5581092472"] = {
		[RSConstants.ENTRANCE] = { x = 0.4399, y = 0.1570 };
	}; --Ba'key's Aromatic Broker Cookies Recipes
	["5024712371"] = {
		[RSConstants.ENTRANCE] = { x = 0.6880, y = 0.4788 };
	}; --Tumbled Package
	["5000462371"] = {
		[RSConstants.FLAG..1] = { x = 0.6830, y = 0.4530, comment = AL["NOTE_500046_1"], questID = 86066 };
		[RSConstants.FLAG..2] = { x = 0.6986, y = 0.6056, comment = AL["NOTE_500046_2"], questID = 86067 };
		[RSConstants.FLAG..3] = { x = 0.75490, y = 0.3981, comment = AL["NOTE_500046_3"], questID = 86065 };
	}; --Gift of the brothers
	["5024372371"] = {
		[RSConstants.ENTRANCE] = { x = 0.6075, y = 0.4204 };
	}; --Wastelander Stash
	["5479952371"] = {
		[RSConstants.ENTRANCE] = { x = 0.5685, y = 0.2410 };
	}; --Warglaive of the Audacious Hunter
	["5480012472"] = {
		[RSConstants.ENTRANCE] = { x = 0.4797, y = 0.6315 };
	}; --P.O.S.T. Master's Prototype Parcel and Postage Presser
	["5033752371"] = {
		[RSConstants.FLAG..1] = { x = 0.6655, y = 0.4480, comment = AL["NOTE_503375_1"] };
		[RSConstants.FLAG..2] = { x = 0.7623, y = 0.3122, comment = AL["NOTE_503375_2"] };
	}; --Ancient Coffer
	["257978750"] = {
		[RSConstants.ENTRANCE] = { x = 0.3204, y = 0.4531 };
	}; --Treasure Chest
	["245537650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5514, y = 0.4427 };
	}; --Glimmering Treasure Chest
	["245538650"] = {
		[RSConstants.ENTRANCE] = { x = 0.5514, y = 0.4427 };
	}; --Small Treasure Chest
	["245530650"] = {
		[RSConstants.ENTRANCE] = { x = 0.3834, y = 0.6128 };
	}; --Glimmering Treasure Chest
	["244494650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4000, y = 0.5789 };
	}; --Treasure Chest
	["255828650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4581, y = 0.2736 };
	}; --Small Treasure Chest
	["245547650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4999, y = 0.5376 };
	}; --Small Treasure Chest
	["245550650"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5158, y = 0.3746 };
		[RSConstants.ENTRANCE..2] = { x = 0.4806, y = 0.3380 };
	}; --Small Treasure Chest
	["245551650"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.5158, y = 0.3746 };
		[RSConstants.ENTRANCE..2] = { x = 0.4806, y = 0.3380 };
	}; --Small Treasure Chest
	["245543650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4114, y = 0.7223 };
	}; --Treasure Chest
	["245601650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4460, y = 0.7242 };
	}; --Small Treasure Chest
	["245548650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4159, y = 0.4696 };
	}; --Treasure Chest
	["245602650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4460, y = 0.7242 };
	}; --Treasure Chest
	["245532650"] = {
		[RSConstants.ENTRANCE] = { x = 0.4257, y = 0.2531 };
	}; --Treasure Chest
	["240655641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5327, y = 0.3803 };
	}; --Glimmering Treasure Chest
	["242668641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4205, y = 0.4569 };
	}; --Glimmering Treasure Chest
	["242667641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4205, y = 0.4569 };
	}; --Small Treasure Chest
	["242646641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6817, y = 0.4003 };
	}; --Small Treasure Chest
	["242660641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4277, y = 0.5848 };
	}; --Small Treasure Chest
	["242643641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6224, y = 0.7618 };
	}; --Small Treasure Chest
	["254141641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6419, y = 0.4541 };
	}; --Small Treasure Chest
	["240653641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5098, y = 0.7712 };
	}; --Small Treasure Chest
	["240608641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5454, y = 0.7361 };
	}; --Small Treasure Chest
	["242242641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5550, y = 0.8407 };
	}; --Small Treasure Chest
	["242250641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5399, y = 0.8223 };
	}; --Small Treasure Chest
	["242446641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6047, y = 0.7113 };
	}; --Small Treasure Chest
	["242642641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6274, y = 0.7132 };
	}; --Small Treasure Chest
	["242328641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4929, y = 0.8564 };
	}; --Small Treasure Chest
	["240605641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6515, y = 0.5128 };
	}; --Small Treasure Chest
	["240651641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6697, y = 0.5265 };
	}; --Small Treasure Chest
	["254126641"] = {
		[RSConstants.ENTRANCE] = { x = 0.7306, y = 0.5370 };
	}; --Small Treasure Chest
	["242675641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5398, y = 0.6967 };
	}; --Treasure Chest
	["254127641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6249, y = 0.8600 };
	}; --Treasure Chest
	["242346641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6204, y = 0.8610 };
	}; --Treasure Chest
	["241767641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6987, y = 0.6049 };
	}; --Treasure Chest
	["241772641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6592, y = 0.5637 };
	}; --Treasure Chest
	["242664641"] = {
		[RSConstants.ENTRANCE] = { x = 0.3411, y = 0.5820 };
	}; --Treasure Chest
	["242678641"] = {
		[RSConstants.ENTRANCE] = { x = 0.5407, y = 0.6109 };
	}; --Treasure Chest
	["240652641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4440, y = 0.8337 };
	}; --Treasure Chest
	["254128641"] = {
		[RSConstants.ENTRANCE] = { x = 0.4374, y = 0.8977 };
	}; --Treasure Chest
	["242350641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6432, y = 0.8432 };
	}; --Treasure Chest
	["242644641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6201, y = 0.6823 };
	}; --Treasure Chest
	["242683641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6300, y = 0.7349 };
	}; --Treasure Chest
	["242647641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6602, y = 0.8630 };
	}; --Treasure Chest
	["242663641"] = {
		[RSConstants.ENTRANCE] = { x = 0.6602, y = 0.8630 };
		[RSConstants.FLAG] = { x = 0.5479, y = 0.5279, comment = AL["NOTE_242663_1"] };
	}; --Treasure Chest
	["241717634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4977, y = 0.4941 };
	}; --Glimmering Treasure Chest
	["251716634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4220, y = 0.3496 };
	}; --Glimmering Treasure Chest
	["241564634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4823, y = 0.6515 };
	}; --Small Treasure Chest
	["241153634"] = {
		[RSConstants.ENTRANCE] = { x = 0.5008, y = 0.4240 };
	}; --Small Treasure Chest
	["241180634"] = {
		[RSConstants.ENTRANCE] = { x = 0.3481, y = 0.3410 };
	}; --Treasure Chest
	["244901634"] = {
		[RSConstants.ENTRANCE] = { x = 0.6997, y = 0.4267 };
	}; --Treasure Chest
	["241146634"] = {
		[RSConstants.ENTRANCE] = { x = 0.4297, y = 0.6606 };
	}; --Treasure Chest
	["241208634"] = {
		[RSConstants.ENTRANCE] = { x = 0.3380, y = 0.2712 };
	}; --Treasure Chest
	["241280634"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.2996, y = 0.5507 };
		[RSConstants.ENTRANCE..2] = { x = 0.3140, y = 0.5734 };
	}; --Treasure Chest
	["251738634"] = {
		[RSConstants.ENTRANCE] = { x = 0.3299, y = 0.4814 };
	}; --Treasure Chest
	["241216649"] = {
		[RSConstants.ENTRANCE] = { x = 0.8455, y = 0.2091 };
	}; --Treasure Chest
	["246254680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4954, y = 0.3388 };
		[RSConstants.STEP1] = { x = 0.5193, y = 0.3187 };
		[RSConstants.STEP2] = { x = 0.5108, y = 0.3075 };
		[RSConstants.STEP3] = { x = 0.5092, y = 0.2996 };
		[RSConstants.STEP4] = { x = 0.5173, y = 0.3138 };
		[RSConstants.STEP5] = { x = 0.5215, y = 0.3270 };
	}; --Dusty Coffer
	["251052680"] = {
		[RSConstants.ENTRANCE] = { x = 0.3449, y = 0.8416 };
	}; --Protected Treasure Chest
	["258034680"] = {
		[RSConstants.ENTRANCE] = { x = 0.3449, y = 0.8416 };
	}; --Protected Treasure Chest
	["251052683"] = {
		[RSConstants.FLAG..1] = { x = 0.6275, y = 0.7059, comment = AL["NOTE_251052_1"] };
		[RSConstants.FLAG..2] = { x = 0.4100, y = 0.5691, comment = AL["NOTE_251052_1"] };
	}; --Protected Treasure Chest
	["252831680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4226, y = 0.2999 };
	}; --Glimmering Treasure Chest
	["252836680"] = {
		[RSConstants.ENTRANCE] = { x = 0.7927, y = 0.5751 };
	}; --Small Treasure Chest
	["252807680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2284, y = 0.3581 };
	}; --Small Treasure Chest
	["252860680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4244, y = 0.7637 };
	}; --Small Treasure Chest
	["252829680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4954, y = 0.3388 };
		[RSConstants.STEP1] = { x = 0.5193, y = 0.3187 };
		[RSConstants.STEP2] = { x = 0.5187, y = 0.3069 };
	}; --Small Treasure Chest
	["252813680"] = {
		[RSConstants.ENTRANCE] = { x = 0.1940, y = 0.1947 };
	}; --Small Treasure Chest
	["246524680"] = {
		[RSConstants.ENTRANCE] = { x = 0.3648, y = 0.7678 };
	}; --Small Treasure Chest
	["252806680"] = {
		[RSConstants.ENTRANCE] = { x = 0.3648, y = 0.7678 };
	}; --Small Treasure Chest
	["257393680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4820, y = 0.7219 };
	}; --Treasure Chest
	["257545680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4820, y = 0.7137 };
	}; --Treasure Chest
	["252838680"] = {
		[RSConstants.ENTRANCE] = { x = 0.8284, y = 0.6785 };
	}; --Treasure Chest
	["252842680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4870, y = 0.7392 };
	}; --Treasure Chest
	["257546680"] = {
		[RSConstants.ENTRANCE] = { x = 0.5029, y = 0.8026 };
	}; --Treasure Chest
	["252809680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2048, y = 0.5045 };
	}; --Treasure Chest
	["252808680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2048, y = 0.5045 };
	}; --Treasure Chest
	["252805680"] = {
		[RSConstants.ENTRANCE] = { x = 0.3133, y = 0.8403 };
	}; --Treasure Chest
	["252821680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2984, y = 0.1617 };
	}; --Treasure Chest
	["252880680"] = {
		[RSConstants.ENTRANCE] = { x = 0.6114, y = 0.5554 };
	}; --Treasure Chest
	["252882680"] = {
		[RSConstants.ENTRANCE] = { x = 0.5775, y = 0.6244 };
	}; --Treasure Chest
	["252828680"] = {
		[RSConstants.ENTRANCE] = { x = 0.4832, y = 0.3474 };
	}; --Small Treasure Chest
	["254025680"] = {
		[RSConstants.ENTRANCE] = { x = 0.2567, y = 0.7936 };
	}; --Small Treasure Chest
	["254025630"] = {
		[RSConstants.ENTRANCE] = { x = 0.6979, y = 0.2956 };
	}; --Small Treasure Chest
	["250081630"] = {
		[RSConstants.ENTRANCE] = { x = 0.6408, y = 0.5293 };
	}; --Small Treasure Chest
	["254024630"] = {
		[RSConstants.ENTRANCE] = { x = 0.3435, y = 0.3610 };
	}; --Small Treasure Chest
	["250108630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5577, y = 0.2546 };
	}; --Small Treasure Chest
	["254027630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5398, y = 0.1788 };
	}; --Small Treasure Chest
	["250087630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5383, y = 0.4056 };
	}; --Small Treasure Chest
	["258690630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5461, y = 0.5253 };
	}; --Small Treasure Chest
	["254028630"] = {
		[RSConstants.ENTRANCE] = { x = 0.2665, y = 0.4707 };
	}; --Small Treasure Chest
	["250097630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5009, y = 0.4875 };
	}; --Small Treasure Chest
	["250106630"] = {
		[RSConstants.ENTRANCE] = { x = 0.4783, y = 0.0824 };
	}; --Small Treasure Chest
	["250092630"] = {
		[RSConstants.ENTRANCE] = { x = 0.4803, y = 0.2467 };
	}; --Treasure Chest
	["240634630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5719, y = 0.1304 };
	}; --Treasure Chest
	["250109630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5400, y = 0.2245 };
	}; --Treasure Chest
	["250102630"] = {
		[RSConstants.ENTRANCE] = { x = 0.4158, y = 0.3124 };
	}; --Treasure Chest
	["240645630"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4899, y = 0.5887 };
		[RSConstants.ENTRANCE..2] = { x = 0.5076, y = 0.5904 };
		[RSConstants.ENTRANCE..3] = { x = 0.4584, y = 0.5530 };
		[RSConstants.ENTRANCE..4] = { x = 0.4786, y = 0.5069 };
	}; --Glimmering Treasure Chest
	["250098630"] = {
		[RSConstants.ENTRANCE..1] = { x = 0.4899, y = 0.5887 };
		[RSConstants.ENTRANCE..2] = { x = 0.5076, y = 0.5904 };
		[RSConstants.ENTRANCE..3] = { x = 0.4584, y = 0.5530 };
		[RSConstants.ENTRANCE..4] = { x = 0.4786, y = 0.5069 };
	}; --Small Treasure Chest
	["250088630"] = {
		[RSConstants.ENTRANCE] = { x = 0.5383, y = 0.4056 };
		[RSConstants.FLAG] = { x = 0.4790, y = 0.2680, comment = AL["NOTE_250088_1"] };
	}; --Small Treasure Chest
	["276225882"] = {
		[RSConstants.ENTRANCE] = { x = 0.6213, y = 0.7230 };
	}; --Student's Surprising Surplus
	["276227882"] = {
		[RSConstants.FLAG] = { x = 0.6718, y = 0.5824, comment = AL["NOTE_GOBLIN_GLIDER_KIT_1"] };
	}; --Augari Secret Stash
	["276224882"] = {
		[RSConstants.ENTRANCE] = { x = 0.5076, y = 0.3878 };
	}; --Chest of Ill-Gotten Gains
	["277327882"] = {
		[RSConstants.PATH_START] = { x = 0.6491, y = 0.4154 };
	}; --Augari-Runed Chest
	["276228882"] = {
		[RSConstants.PATH_START] = { x = 0.5704, y = 0.7500 };
	}; --Desperate Eredar's Cache
	["277342882"] = {
		[RSConstants.ENTRANCE] = { x = 0.4144, y = 0.6986 };
	}; --Augari Goods
	["276230882"] = {
		[RSConstants.FLAG] = { x = 0.4514, y = 0.5293, comment = AL["NOTE_GOBLIN_GLIDER_KIT_1"] };
	}; --Doomseeker's Treasure
	["276229882"] = {
		[RSConstants.FLAG] = { x = 0.3118, y = 0.4491, comment = AL["NOTE_GOBLIN_GLIDER_KIT_1"] };
	}; --Shattered House Chest
	["276226882"] = {
		[RSConstants.ENTRANCE] = { x = 0.3940, y = 0.5036 };
	}; --Void-Tinged Chest
	["276223882"] = {
		[RSConstants.ENTRANCE] = { x = 0.4341, y = 0.0449 };
		[RSConstants.PATH_START] = { x = 0.5349, y = 0.1310 };
	}; --Eredar Treasure Cache
	["276491830"] = {
		[RSConstants.ENTRANCE] = { x = 0.4776, y = 0.5935 };
	}; --Lost Krokul Chest
	["276490830"] = {
		[RSConstants.ENTRANCE] = { x = 0.5068, y = 0.7533 };
	}; --Krokul Emergency Cache
	["277344830"] = {
		[RSConstants.ENTRANCE] = { x = 0.5643, y = 0.7416 };
	}; --Precious Augari Keepsakes
	["277343830"] = {
		[RSConstants.ENTRANCE] = { x = 0.7408, y = 0.6983 };
	}; --Long-Lost Augari Treasure
	["276489830"] = {
		[RSConstants.ENTRANCE] = { x = 0.6416, y = 0.3911 };
	}; --Legion Tower Chest
	["277204885"] = {
		[RSConstants.ENTRANCE] = { x = 0.5916, y = 0.6177 };
	}; --Forgotten Legion Supplies
	["277206885"] = {
		[RSConstants.ENTRANCE] = { x = 0.5193, y = 0.2843 };
	}; --Fel-Bound Chest
	["277205885"] = {
		[RSConstants.ENTRANCE] = { x = 0.6526, y = 0.4052 };
		[RSConstants.FLAG] = { x = 0.6469, y = 0.4103, comment = AL["NOTE_277205_1"] };
	}; --Ancient Legion War Cache
}

---============================================================================
-- Event guide
---============================================================================

private.EVENT_GUIDE = {
}