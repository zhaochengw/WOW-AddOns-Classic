--contains sampe configs all can use

-------------------------
--Get the Classic Config
function SCT:GetClassicConfig()
	local default = {
		["PLAYSOUND"] = false,
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 1,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = 0,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.MSG] = {
				["MSGFADE"] = 1.5,
				["MSGFONT"] = "Friz Quadrata TT",
				["MSGFONTSHADOW"] = 1,
				["MSGSIZE"] = 24,
				["MSGYOFFSET"] = 210,
				["MSGXOFFSET"] = 0,
			}
		},
		[SCT.CRITS_TABLE] = {
			["SHOWEXECUTE"] = 1,
			["SHOWLOWHP"] = 1,
			["SHOWLOWMANA"] = 1,
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWPOWER"] = SCT.FRAME1,
			["SHOWCOMBAT"] = SCT.FRAME1,
			["SHOWHONOR"] = SCT.FRAME1,
			["SHOWBUFF"] = SCT.FRAME1,
			["SHOWREP"] = SCT.FRAME1,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWSKILL"] = SCT.FRAME1
		}
	};
	return default;
end

-------------------------
--Get the Performance Config
function SCT:GetPerformanceConfig()
	local default = {
	  ["CUSTOMEVENTS"] = false,
  }
	return default;
end

-------------------------
--Get the Split Config
function SCT:GetSplitConfig()
	local default = {
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 200,
				["YOFFSET"] = -100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME2] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = -200,
				["YOFFSET"] = -100,
				["DIRECTION"] = true,
				["TEXTSIZE"] = 24,
			},
		},
		[SCT.CRITS_TABLE] = {
			["SHOWEXECUTE"] = 1,
			["SHOWLOWHP"] = 1,
			["SHOWLOWMANA"] = 1,
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME2,
			["SHOWLOWMANA"] = SCT.FRAME2,
			["SHOWPOWER"] = SCT.FRAME2,
			["SHOWCOMBAT"] = SCT.FRAME2,
			["SHOWCOMBOPOINTS"] = SCT.FRAME2,
			["SHOWBUFF"] = SCT.FRAME2,
			["SHOWFADE"] = SCT.FRAME2,
			["SHOWSKILL"] = SCT.MSG
		}
	};
	return default;
end

-------------------------
--Get the Split SCTD Config
function SCT:GetSplitSCTDConfig()
	if (not SCT.FRAME3) then return SCT:GetSplitConfig() end;
	local default = {
		[SCT.FRAMES_DATA_TABLE] = {
			[SCT.FRAME1] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 200,
				["YOFFSET"] = -100,
				["DIRECTION"] = 1,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME2] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = 0,
				["YOFFSET"] = 100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
			[SCT.FRAME3] = {
				["FONT"] = "Friz Quadrata TT",
				["FONTSHADOW"] = 2,
				["ALPHA"] = 100,
				["ANITYPE"] = 1,
				["ANISIDETYPE"] = 1,
				["XOFFSET"] = -200,
				["YOFFSET"] = -100,
				["DIRECTION"] = false,
				["TEXTSIZE"] = 24,
			},
		},
		[SCT.FRAMES_TABLE] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWPOWER"] = SCT.FRAME2,
			["SHOWCOMBAT"] = SCT.FRAME2,
			["SHOWCOMBOPOINTS"] = SCT.FRAME2,
			["SHOWHONOR"] = SCT.FRAME2,
			["SHOWBUFF"] = SCT.FRAME2,
			["SHOWFADE"] = SCT.FRAME2,
			["SHOWEXECUTE"] = SCT.FRAME1,
			["SHOWREP"] = SCT.FRAME2,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWSKILL"] = SCT.FRAME2
		}
	};
	return default;
end

-------------------------
--Get the Grayhoof Config
function SCT:GetGrayhoofConfig()
  if (not SCT.FRAME3) then return SCT:GetGrayhoofConfigNoSCTD() end;
	local default = {
		["SHOWCOMBAT"] = 1,
		["SPELLCOLOR"] = 1,
		[SCT.FRAMES_DATA_TABLE] = {
		  [SCT.FRAME1] = {
				["GAPDIST"] = 100,
				["ANITYPE"] = 7,
				["ANISIDETYPE"] = 2,
				["FONT"] = "SCT Emblem",
				["ALIGN"] = 4,
				["ICONSIDE"] = 4,
				["DIRECTION"] = 1,
			},
			[SCT.FRAME2] = {
				["GAPDIST"] = 200,
				["ANITYPE"] = 7,
				["ICONSIDE"] = 4,
				["FONT"] = "SCT Emblem",
				["ALIGN"] = 4,
				["YOFFSET"] = 0,
				["ANISIDETYPE"] = 2,
			},
			[SCT.FRAME3] = {
				["GAPDIST"] = 40,
				["ANITYPE"] = 1,
				["ALPHA"] = 100,
				["ICONSIDE"] = 2,
				["DIRECTION"] = false,
				["FADE"] = 1.5,
				["ANISIDETYPE"] = 1,
				["FONTSHADOW"] = 2,
				["TEXTSIZE"] = 24,
				["FONT"] = "SCT Emblem",
				["ALIGN"] = 2,
				["YOFFSET"] = 210,
				["XOFFSET"] = 0,
			}, -- [3]
			[SCT.MSG] = {
				["MSGFONT"] = "SCT Emblem",
			},
		},
	  ["FRAMES"] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWHONOR"] = SCT.FRAME2,
			["SHOWDEBUFF"] = SCT.FRAME2,
			["SHOWREP"] = SCT.FRAME2,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWKILLBLOW"] = SCT.FRAME1,
			["SHOWBUFF"] = SCT.FRAME2,
		},
  };
	return default;
end

-------------------------
--Get the Grayhoof Config
function SCT:GetGrayhoofConfigNoSCTD()
	local default = {
		["SHOWCOMBAT"] = 1,
		["SPELLCOLOR"] = 1,
		[SCT.FRAMES_DATA_TABLE] = {
		  [SCT.FRAME1] = {
				["GAPDIST"] = 100,
				["ANITYPE"] = 7,
				["ANISIDETYPE"] = 2,
				["FONT"] = "SCT Emblem",
				["ALIGN"] = 4,
				["ICONSIDE"] = 4,
				["DIRECTION"] = 1,
			},
			[SCT.FRAME2] = {
				["GAPDIST"] = 200,
				["ANITYPE"] = 7,
				["ICONSIDE"] = 4,
				["FONT"] = "SCT Emblem",
				["ALIGN"] = 4,
				["YOFFSET"] = 0,
				["ANISIDETYPE"] = 2,
			},
			[SCT.MSG] = {
				["MSGFONT"] = "SCT Emblem",
			},
		},
	  ["FRAMES"] = {
			["SHOWHEAL"] = SCT.FRAME1,
			["SHOWHONOR"] = SCT.FRAME2,
			["SHOWDEBUFF"] = SCT.FRAME2,
			["SHOWREP"] = SCT.FRAME2,
			["SHOWSELFHEAL"] = SCT.FRAME1,
			["SHOWKILLBLOW"] = SCT.FRAME1,
			["SHOWBUFF"] = SCT.FRAME2,
		},
  };
	return default;
end
