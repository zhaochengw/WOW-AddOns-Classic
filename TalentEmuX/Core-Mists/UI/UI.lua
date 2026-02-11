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
-->
-->
MT.BuildEnv('UI');
-->		predef
-->		UI
	--[==[	Frame Definition
		Frame
					initialized		(bool)
					style			(num(identify))
					CurTreeIndex	(num)
					ClassTDB		(table)
					class			(string)
					level			(num)
					TotalUsedPoints	(num)
					TotalAvailablePoints	(num)
					data			(string)
					readOnly		(bool)
					name			(string)
					TreeButtonsBar					CurTreeIndicator	(texture)
					TreeButtons[]	(frame table)
					TreeFrames[]	(frame table)
													id					(identify)
													TreeNodes			(frame)
																					id					(identify)
																					MaxVal				(fontString)
																					MinVal				(fontString)
																					Split				(fontString)
																					active				(bool)
																					TalentSeq				(num)
													HSeq				(texture)
													VSep				(texture)
													TalentSet			(table)
																					total
																					CountByTier			(num table)
																					TopCheckedTier		(num)
																					TopAvailableTier	(num)
													DependArrows		(table)
																					coordFamily			(num(identify))
													NodeDependArrows	(table-table)
													TreeTDB				(table)
	--]==]
	--

	MT.RegisterOnInit('UI', function(LoggedIn)
		if CT.LOCALE == 'zhCN' or CT.LOCALE == 'zhTW' then
			CT.TUISTYLE.FrameFontSizeSmall = CT.TUISTYLE.FrameFontSizeMedium;
		end
		CT.TUISTYLE.TreeFrameXSizeSingle = CT.TUISTYLE.TreeNodeXSize * DT.MAX_NUM_COL + CT.TUISTYLE.TreeNodeXGap * (DT.MAX_NUM_COL - 1) + CT.TUISTYLE.TreeNodeXToBorder * 2;
		CT.TUISTYLE.TreeFrameYSize = CT.TUISTYLE.TreeFrameHeaderYSize + CT.TUISTYLE.TreeNodeYToTop + CT.TUISTYLE.TreeNodeYSize * DT.MAX_NUM_TIER + CT.TUISTYLE.TreeNodeYGap * (DT.MAX_NUM_TIER - 1) + CT.TUISTYLE.TreeNodeYToBottom + CT.TUISTYLE.TreeFrameFooterYSize;
		CT.TUISTYLE.SpecSpellFrameXSizeSingle = CT.TUISTYLE.SpecSpellNodeXSize * DT.MAX_NUM_COL + CT.TUISTYLE.SpecSpellNodeXGap * (DT.MAX_NUM_COL - 1) + CT.TUISTYLE.SpecSpellNodeXToBorder * 2;
		CT.TUISTYLE.SpecSpellFrameYSize = CT.TUISTYLE.TreeFrameHeaderYSize + CT.TUISTYLE.TreeNodeYToTop + CT.TUISTYLE.TreeNodeYSize * DT.MAX_NUM_TIER + CT.TUISTYLE.TreeNodeYGap * (DT.MAX_NUM_TIER - 1) + CT.TUISTYLE.TreeNodeYToBottom;
		CT.TUISTYLE.FrameXSizeDefault_Style1 = CT.TUISTYLE.TreeFrameXSizeSingle + CT.TUISTYLE.TreeFrameXToBorder * 2;
		CT.TUISTYLE.FrameYSizeDefault_Style1 = CT.TUISTYLE.FrameHeaderYSize + CT.TUISTYLE.TreeFrameYSize + CT.TUISTYLE.TreeFrameYToBorder * 2 + CT.TUISTYLE.TreeButtonsBarYSize + CT.TUISTYLE.FrameFooterYSize;
		CT.TUISTYLE.FrameXSizeDefault_Style2 = CT.TUISTYLE.FrameXSizeDefault_Style1;
		CT.TUISTYLE.FrameYSizeDefault_Style2 = CT.TUISTYLE.FrameYSizeDefault_Style1;
		CT.TUISTYLE.EquipmentContainerYSize = CT.TUISTYLE.EquipmentNodeYToBorder + CT.TUISTYLE.EquipmentNodeSize * 9 + CT.TUISTYLE.EquipmentNodeGap * 10 + CT.TUISTYLE.EquipmentNodeYToBorder;
		VT.TooltipFrame = MT.UI.CreateTooltipFrame();
	end);
	MT.RegisterOnLogin('UI', function(LoggedIn)
	end);

-->
