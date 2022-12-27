local _, addonTable = ...;
local gsub = _G.string.gsub 
local sub = _G.string.sub
local find = _G.string.find
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
-------
local function add_RsettingFrame()
	local Width,Height  = RaidR_UI:GetWidth(), RaidR_UI:GetHeight();
	local GnName = RaidR_UI.biaoti.title:GetText();
	--设置按钮=====================================================================
	local Rsetting = CreateFrame("Button",nil,RaidR_UI.xiafangF, "TruncatedButtonTemplate"); 
	Rsetting:SetNormalTexture("interface/gossipframe/healergossipicon.blp"); 
	Rsetting:SetHighlightTexture(130718);
	Rsetting:SetSize(22,22);
	Rsetting:SetPoint("TOPLEFT",RaidR_UI.xiafangF,"TOPLEFT",Width-70,-44);
	Rsetting.Down = Rsetting:CreateTexture(nil, "OVERLAY");
	Rsetting.Down:SetTexture(130839);
	Rsetting.Down:SetSize(22,22);
	Rsetting.Down:SetPoint("CENTER");
	Rsetting.Down:Hide();
	Rsetting:SetScript("OnMouseDown", function (self)
		self.Down:Show();
	end);
	Rsetting:SetScript("OnMouseUp", function (self)
		self.Down:Hide()
	end);
	--内容页-------------------------
	local RsettingF=ADD_Frame("RsettingF_UI",Rsetting,Width-40,Height-104,"TOP",RaidR_UI,"TOP",0,-18,true,false,false,false,false,"BG6")
	RsettingF:SetFrameLevel(RaidR_UI:GetFrameLevel()+40);
	RsettingF.Close = CreateFrame("Button",nil,RsettingF, "UIPanelCloseButton");  
	RsettingF.Close:SetSize(34,34);
	RsettingF.Close:SetPoint("TOPRIGHT",RsettingF,"TOPRIGHT",2.4,0);
	RsettingF.biaoti = RsettingF:CreateFontString();
	RsettingF.biaoti:SetPoint("TOP",RsettingF,"TOP",0,-10);
	RsettingF.biaoti:SetFont(ChatFontNormal:GetFont(), 16, "OUTLINE");
	RsettingF.biaoti:SetText("\124cff00FF00"..GnName.."设置\124r");
	RsettingF.biaoti1 = RsettingF:CreateLine()
	RsettingF.biaoti1:SetColorTexture(1,1,1,0.3)
	RsettingF.biaoti1:SetThickness(1);
	RsettingF.biaoti1:SetStartPoint("TOPLEFT",5,-34)
	RsettingF.biaoti1:SetEndPoint("TOPRIGHT",-3,-34)

	--===========
	RsettingF.fubenwai = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",20,-50,"记录副本外","开启后会记录副本外的拾取信息（默认只记录团队副本内掉落）")
	RsettingF.fubenwai:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["fubenwai"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["fubenwai"]="OFF";
		end
	end);
	--5人本
	RsettingF.wurenben = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",260,-50,"记录5人本","开启后会记录5人本拾取信息（默认只记录团队副本内掉落）")
	RsettingF.wurenben:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["wurenben"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["wurenben"]="OFF";
		end
	end);

	--手动添加物品
	RsettingF.shoudongloot = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",20,-100,"手动添加物品","开启后按住shift点击聊天栏物品链接添加物品到拾取目录（注意必须保持拾取目录列表为打开状态）")
	RsettingF.shoudongloot:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["shoudongloot"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["shoudongloot"]="OFF";
		end
	end);
	--拾取物品倒计时
	local function ITEMTimetishi()
		if not InCombatLockdown() then
			if PIG["RaidRecord"]["Kaiqi"]=="ON" and PIG["RaidRecord"]["Rsetting"]["jiaoyidaojishi"]=="ON" then
				if PIG["RaidRecord"]["instanceName"][1] then
					if GetServerTime()-PIG["RaidRecord"]["instanceName"][1]<43200 then
						if #PIG["RaidRecord"]["ItemList"]>0 then
							for i=1,#PIG["RaidRecord"]["ItemList"],1 do
								if PIG["RaidRecord"]["ItemList"][i][13] then
									if PIG["RaidRecord"]["ItemList"][i][8]~="无" or PIG["RaidRecord"]["ItemList"][i][9]>0 or PIG["RaidRecord"]["ItemList"][i][14]>0 then--已有成交人/收款/欠款
										PIG["RaidRecord"]["ItemList"][i][13]=false;
									else
										local yijingguoqu=GetServerTime()-PIG["RaidRecord"]["ItemList"][i][1];
										if yijingguoqu>7200 then
											PIG["RaidRecord"]["ItemList"][i][13]=false;	
										elseif yijingguoqu>6600 then
											if PIG["RaidRecord"]["ItemList"][i][12] then
												if UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME") and IsInRaid("LE_PARTY_CATEGORY_HOME") then
													SendChatMessage("提示：未成交物品"..PIG["RaidRecord"]["ItemList"][i][2].."可交易时间不足10分钟，请确认物品归属(预估时间仅供参考)！","RAID", nil);
													PIG["RaidRecord"]["ItemList"][i][12]=false;
												end
											end
										end	
									end
								end
							end
						end
					end
				end	
			end
		end
		C_Timer.After(30,ITEMTimetishi);
	end
	ITEMTimetishi();
	RsettingF.jiaoyidaojishi = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",260,-100,"可交易倒计时通告","启用后，物品可交易时间低于10分钟将会在团队频道提示，预估时间仅供参考\n注意此通告不会在战斗中执行")
	RsettingF.jiaoyidaojishi:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["jiaoyidaojishi"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["jiaoyidaojishi"]="OFF";
		end
	end);

	--交易记录==========================================================
	local jiaoyijiluFFFF = CreateFrame("Frame")
	-- 注册接收插件广播的交易信息
	C_ChatInfo.RegisterAddonMessagePrefix('!Pig-jiaoyi')
	jiaoyijiluFFFF:RegisterEvent('CHAT_MSG_ADDON');

	local guangbopindao="RAID";
	local jiaoyishujuinfo={{},0,{},0}
	jiaoyijiluFFFF:SetScript("OnEvent",function (self,event,arg1,arg2,arg3,arg4,arg5)
		if event=="CHAT_MSG_ADDON" then
			local namerealm = GetUnitName("player", true);
			if arg1 == '!Pig-jiaoyi' and arg5 ~= namerealm then
				local wupinID, wanjiaName,jiaoyijine = strsplit("-", arg2);
				-- local _, _, _, wupinID = arg2:find("((.+)姓名)");
				-- local _, _, _, wanjiaName = arg2:find("(姓名(.+)金额)");
				-- local _, _,_, jiaoyijine = arg2:find("(金额(.+))");			  
				for x=1,#PIG["RaidRecord"]["ItemList"] do
					if tonumber(wupinID)==PIG["RaidRecord"]["ItemList"][x][11] then
						if PIG["RaidRecord"]["ItemList"][x][8]=="无" and PIG["RaidRecord"]["ItemList"][x][9]==0 then
							PIG["RaidRecord"]["ItemList"][x][8]=wanjiaName;
							PIG["RaidRecord"]["ItemList"][x][9]=tonumber(jiaoyijine);
							PIG["RaidRecord"]["ItemList"][x][10]=GetServerTime();
							addonTable.RaidRecord_UpdateItem(Item_Scroll_UI);
							break
						end
					end
				end
		    end
		end
		if event=="TRADE_SHOW" then
			jiaoyishujuinfo={{},0,{},0}
		end
		if event=="TRADE_PLAYER_ITEM_CHANGED" or event=="TRADE_TARGET_ITEM_CHANGED" or event=="TRADE_ACCEPT_UPDATE" or event=="TRADE_MONEY_CHANGED" then
			jiaoyishujuinfo={{},0,{},0}
			for i=1,6 do
				local PPPItemlink = GetTradePlayerItemLink(i);
				if PPPItemlink then
					local PPPname, PPPtexture, PPPquantity = GetTradePlayerItemInfo(i)
					table.insert(jiaoyishujuinfo[1],{PPPItemlink,PPPquantity});
				end
				local TTTItemlink = GetTradeTargetItemLink(i);
				if TTTItemlink then
					local TTTname, TTTtexture, TTTquantity = GetTradeTargetItemInfo(i)
					table.insert(jiaoyishujuinfo[3],{TTTItemlink,TTTquantity});
				end
			end
			jiaoyishujuinfo[2]=GetPlayerTradeMoney();
			jiaoyishujuinfo[4]=GetTargetTradeMoney();
		end
		if event=="UI_INFO_MESSAGE" then
			if arg2=="交易完成" then
				if #jiaoyishujuinfo[1]>1 then
					local fubenzhushou_chenggongjiaoyi = false
					for x=1,#jiaoyishujuinfo[1] do
						local zijiitemID = GetItemInfoInstant(jiaoyishujuinfo[1][x][1]);
						for xx=1,#PIG["RaidRecord"]["ItemList"] do
							if zijiitemID==PIG["RaidRecord"]["ItemList"][xx][11] then
								if PIG["RaidRecord"]["ItemList"][xx][8]=="无" and PIG["RaidRecord"]["ItemList"][xx][9]==0 then
									fubenzhushou_chenggongjiaoyi = true
									local wanjia = TradeFrameRecipientNameText:GetText()
									PIG["RaidRecord"]["ItemList"][xx][8]=wanjia;
									addonTable.RaidRecord_UpdateItem(Item_Scroll_UI);
									C_ChatInfo.SendAddonMessage('!Pig-jiaoyi', zijiitemID..'-'..wanjia..'-'..0, guangbopindao);-- 发送此次交易给其他使用者
									if PIG["RaidRecord"]["Rsetting"]["jiaoyitonggao"]=="ON" then
										SendChatMessage("!Pig:物品"..jiaoyishujuinfo[1][x][1].."已交予"..wanjia,guangbopindao, nil);
									end
									break
								end
							end
						end
					end
					if fubenzhushou_chenggongjiaoyi then
						print("|cff00FFFF!Pig:|r|cffFFFF00一次交易多件物品请手动输入每件物品的成交价！|r")
					end
				elseif #jiaoyishujuinfo[1]==1 then
					local zijiitemID = GetItemInfoInstant(jiaoyishujuinfo[1][1][1]);
					for x=1,#PIG["RaidRecord"]["ItemList"] do
						if zijiitemID==PIG["RaidRecord"]["ItemList"][x][11] then
							if PIG["RaidRecord"]["ItemList"][x][8]=="无" and PIG["RaidRecord"]["ItemList"][x][9]==0 then
								local wanjia = TradeFrameRecipientNameText:GetText()
								PIG["RaidRecord"]["ItemList"][x][8]=wanjia;
								PIG["RaidRecord"]["ItemList"][x][9]=jiaoyishujuinfo[4]/10000;
								PIG["RaidRecord"]["ItemList"][x][10]=GetServerTime();
								addonTable.RaidRecord_UpdateItem(Item_Scroll_UI);
								C_ChatInfo.SendAddonMessage('!Pig-jiaoyi', zijiitemID..'-'..wanjia..'-'..(jiaoyishujuinfo[4]/10000), guangbopindao);-- 发送此次交易给其他使用者
								if PIG["RaidRecord"]["Rsetting"]["jiaoyitonggao"]=="ON" then
									SendChatMessage("!Pig:物品"..jiaoyishujuinfo[1][1][1].."已交予"..wanjia.."，收到"..floor((jiaoyishujuinfo[4]/10000)).."G",guangbopindao, nil);
								end
								break
							end
						end
					end
				elseif #jiaoyishujuinfo[1]==0 then --补交罚款
					for x=1,#PIG["RaidRecord"]["fakuan"] do
						local wanjia = TradeFrameRecipientNameText:GetText()
						if PIG["RaidRecord"]["fakuan"][x][4]==wanjia then
							PIG["RaidRecord"]["fakuan"][x][2]=PIG["RaidRecord"]["fakuan"][x][2]+jiaoyishujuinfo[4]/10000;
							if PIG["RaidRecord"]["fakuan"][x][3]>0 then
								PIG["RaidRecord"]["fakuan"][x][3]=PIG["RaidRecord"]["fakuan"][x][3]-jiaoyishujuinfo[4]/10000;
							end
							addonTable.RaidRecord_UpdateFakuan(fakuan_Scroll_UI);
							break
						end
					end
				end
				--从物品目录剔除此次交易生成的拾取记录
				if #jiaoyishujuinfo[3]>0 then
					for x=1,#jiaoyishujuinfo[3] do
						for v = #PIG["RaidRecord"]["ItemList"], 1, -1 do
							if jiaoyishujuinfo[3][x][1]==PIG["RaidRecord"]["ItemList"][v][2] then
								table.remove(PIG["RaidRecord"]["ItemList"],v);
								break
							end
						end
						for d =1, #PIG["RaidRecord"]["ItemList"] , 1 do
							if jiaoyishujuinfo[3][x][1]==PIG["RaidRecord"]["ItemList"][d][2] then
								PIG["RaidRecord"]["ItemList"][d][3]=PIG["RaidRecord"]["ItemList"][d][3]-jiaoyishujuinfo[3][x][2];
							end
						end
						addonTable.RaidRecord_UpdateItem(Item_Scroll_UI)
					end
				end
			end
		end
	end)
	local  function jiaoyijiluFun()
		if PIG["RaidRecord"]["Kaiqi"]=="ON" and PIG["RaidRecord"]["Rsetting"]["jiaoyijilu"]=="ON" then
			PIGEnable(RsettingF.jiaoyitonggao)
			jiaoyijiluFFFF:RegisterEvent("UI_INFO_MESSAGE");--交易信息
			jiaoyijiluFFFF:RegisterEvent("TRADE_SHOW");
			jiaoyijiluFFFF:RegisterEvent("TRADE_CLOSED");
			--jiaoyijiluFFFF:RegisterEvent("TRADE_REQUEST_CANCEL");--取消交易尝试时触发。
			-- jiaoyijiluFFFF:RegisterEvent("PLAYER_TRADE_MONEY");--当玩家进行交易时被触发
			jiaoyijiluFFFF:RegisterEvent("TRADE_MONEY_CHANGED");--交易窗口的货币值更改时触发。
			jiaoyijiluFFFF:RegisterEvent("TRADE_PLAYER_ITEM_CHANGED");
			jiaoyijiluFFFF:RegisterEvent("TRADE_TARGET_ITEM_CHANGED");
			jiaoyijiluFFFF:RegisterEvent("TRADE_ACCEPT_UPDATE");--当玩家和目标接受按钮的状态更改时触发。
		else
			PIGDisable(RsettingF.jiaoyitonggao)
			jiaoyijiluFFFF:UnregisterEvent("UI_INFO_MESSAGE");--交易信息
			jiaoyijiluFFFF:UnregisterEvent("TRADE_SHOW");
			jiaoyijiluFFFF:UnregisterEvent("TRADE_CLOSED");
			--jiaoyijiluFFFF:UnregisterEvent("TRADE_REQUEST_CANCEL");--取消交易尝试时触发。
			-- jiaoyijiluFFFF:UnregisterEvent("PLAYER_TRADE_MONEY");--当玩家进行交易时被触发
			jiaoyijiluFFFF:UnregisterEvent("TRADE_MONEY_CHANGED");--交易窗口的货币值更改时触发。
			jiaoyijiluFFFF:UnregisterEvent("TRADE_PLAYER_ITEM_CHANGED");
			jiaoyijiluFFFF:UnregisterEvent("TRADE_TARGET_ITEM_CHANGED");
			jiaoyijiluFFFF:UnregisterEvent("TRADE_ACCEPT_UPDATE");--当玩家和目标接受按钮的状态更改时触发。
		end
	end
	------------
	RsettingF.jiaoyijilu = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",20,-150,"记录装备交易","开启后,交易拾取目录内的物品将会自动填入收入金额及成交人。一次交易多件商品只会记录成交人需手动输入每件商品收入价\n|cff00ff00（其他已安装本插件的玩家也会收到此次交易信息）|r")
	RsettingF.jiaoyijilu:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["jiaoyijilu"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["jiaoyijilu"]="OFF";
		end
		jiaoyijiluFun()
	end);
	RsettingF.jiaoyitonggao = ADD_Checkbutton(nil,RsettingF,-80,"TOPLEFT",RsettingF,"TOPLEFT",260,-150,"交易通告","通告交易物品和被交易人")
	RsettingF.jiaoyitonggao:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["jiaoyitonggao"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["jiaoyitonggao"]="OFF";
		end
	end);
	jiaoyijiluFun();
	----===================================================
	RsettingF.CCXXX = RsettingF:CreateLine()
	RsettingF.CCXXX:SetColorTexture(1,1,1,0.3)
	RsettingF.CCXXX:SetThickness(2);
	RsettingF.CCXXX:SetStartPoint("TOPLEFT",5,-300)
	RsettingF.CCXXX:SetEndPoint("TOPRIGHT",-276,-300)
	---
	local waiwaizidonghuifu_fuben = CreateFrame("Frame");
	local function zhuceshijianEE()
		if PIG["RaidRecord"]["Rsetting"]["zidonghuifuYY"]=="ON" then
			waiwaizidonghuifu_fuben:RegisterEvent("CHAT_MSG_WHISPER") 
			waiwaizidonghuifu_fuben:RegisterEvent("CHAT_MSG_PARTY");--收到组队信息
			waiwaizidonghuifu_fuben:RegisterEvent("CHAT_MSG_PARTY_LEADER");
			waiwaizidonghuifu_fuben:RegisterEvent("CHAT_MSG_RAID");--收到团队信息
			waiwaizidonghuifu_fuben:RegisterEvent("CHAT_MSG_RAID_LEADER");
		else
			waiwaizidonghuifu_fuben:UnregisterAllEvents();
		end
	end
	zhuceshijianEE()
	RsettingF.zidonghuifuYY = ADD_Checkbutton(nil,RsettingF,-120,"TOPLEFT",RsettingF.CCXXX,"TOPLEFT",20,-10,"自动回复YY频道\124cff00FF00(你必须是队长或团长)\124r","开启后,收到队伍或者团队人员咨询YY频道会自动回复预设内容")
	RsettingF.zidonghuifuYY:SetScript("OnClick", function (self)
		if self:GetChecked() then
			PIG["RaidRecord"]["Rsetting"]["zidonghuifuYY"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["zidonghuifuYY"]="OFF";
		end
		zhuceshijianEE()
	end);
	
	--触发关键字
	RsettingF.zidonghuifuYY.biaoti = RsettingF:CreateFontString();
	RsettingF.zidonghuifuYY.biaoti:SetPoint("TOPLEFT", RsettingF.zidonghuifuYY, "BOTTOMLEFT", 0,-6);
	RsettingF.zidonghuifuYY.biaoti:SetFontObject(GameFontNormal);
	RsettingF.zidonghuifuYY.biaoti:SetText("触发关键字(用，分隔):");
	RsettingF.zidonghuifuYY.F = CreateFrame("Frame", nil, RsettingF,"BackdropTemplate");
	RsettingF.zidonghuifuYY.F:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 14});
	RsettingF.zidonghuifuYY.F:SetBackdropBorderColor(0, 1, 1, 0.8);
	RsettingF.zidonghuifuYY.F:SetSize(310,26);
	RsettingF.zidonghuifuYY.F:SetPoint("LEFT", RsettingF.zidonghuifuYY.biaoti, "RIGHT", 0,-0);
	RsettingF.zidonghuifuYY.E = CreateFrame('EditBox', nil, RsettingF.zidonghuifuYY.F);
	RsettingF.zidonghuifuYY.E:SetPoint("TOPLEFT", RsettingF.zidonghuifuYY.F, "TOPLEFT", 8,-6);
	RsettingF.zidonghuifuYY.E:SetPoint("BOTTOMRIGHT", RsettingF.zidonghuifuYY.F, "BOTTOMRIGHT", -8,6);
	RsettingF.zidonghuifuYY.E:SetFontObject(ChatFontNormal);
	RsettingF.zidonghuifuYY.E:SetAutoFocus(false);
	RsettingF.zidonghuifuYY.E:SetMaxLetters(22);
	RsettingF.zidonghuifuYY.E:SetTextColor(0.6, 0.6, 0.6, 1);
	RsettingF.zidonghuifuYY.E:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	RsettingF.zidonghuifuYY.E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	RsettingF.zidonghuifuYY.E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	local function fengedianjianzi(str,delimiter)
	    local dLen = string.len(delimiter)
	    local newDeli = ''
	    for i=1,dLen,1 do
	        newDeli = newDeli .. "["..delimiter:sub(i,i).."]"
	    end

	    local locaStart,locaEnd = str:find(newDeli)
	    local arr = {}
	    local n = 1
	    while locaStart ~= nil
	    do
	        if locaStart>0 then
	            arr[n] = str:sub(1,locaStart-1)
	            n = n + 1
	        end

	        str = str:sub(locaEnd+1,string.len(str))
	        locaStart,locaEnd = str:find(newDeli)
	    end
	    if str ~= nil and str ~= "" and str ~= " " then
	        arr[n] = str
	    end
	    return arr
	end
	RsettingF.zidonghuifuYY.E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1);
		local guanjianV = self:GetText();
		local guanjianshuzu = guanjianV:gsub("，", ",")
		local guanjianzilist = fengedianjianzi(guanjianshuzu, ",")
		PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"]=guanjianzilist;
	end);
	--回复内容
	RsettingF.zidonghuifuYY.NR_biaoti = RsettingF:CreateFontString();
	RsettingF.zidonghuifuYY.NR_biaoti:SetPoint("TOPLEFT", RsettingF.zidonghuifuYY.biaoti, "BOTTOMLEFT", 0,-18);
	RsettingF.zidonghuifuYY.NR_biaoti:SetFontObject(GameFontNormal);
	RsettingF.zidonghuifuYY.NR_biaoti:SetText("回复内容:");
	RsettingF.zidonghuifuYY.NR = CreateFrame("Frame", nil, RsettingF,"BackdropTemplate");
	RsettingF.zidonghuifuYY.NR:SetBackdrop({edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 14});
	RsettingF.zidonghuifuYY.NR:SetBackdropBorderColor(0, 1, 1, 0.8);
	RsettingF.zidonghuifuYY.NR:SetSize(400,28);
	RsettingF.zidonghuifuYY.NR:SetPoint("LEFT", RsettingF.zidonghuifuYY.NR_biaoti, "RIGHT", 0,-0);
	RsettingF.zidonghuifuYY.NR_E = CreateFrame('EditBox', nil, RsettingF.zidonghuifuYY.NR);
	RsettingF.zidonghuifuYY.NR_E:SetPoint("TOPLEFT", RsettingF.zidonghuifuYY.NR, "TOPLEFT", 8,-6);
	RsettingF.zidonghuifuYY.NR_E:SetPoint("BOTTOMRIGHT", RsettingF.zidonghuifuYY.NR, "BOTTOMRIGHT", -8,6);
	RsettingF.zidonghuifuYY.NR_E:SetFontObject(ChatFontNormal);
	RsettingF.zidonghuifuYY.NR_E:SetAutoFocus(false);
	RsettingF.zidonghuifuYY.NR_E:SetMaxLetters(40);
	RsettingF.zidonghuifuYY.NR_E:SetTextColor(0.6, 0.6, 0.6, 1);
	RsettingF.zidonghuifuYY.NR_E:SetScript("OnEditFocusGained", function(self) 
		self:SetTextColor(1, 1, 1, 1);
	end);
	RsettingF.zidonghuifuYY.NR_E:SetScript("OnEscapePressed", function(self) 
		self:ClearFocus() 
	end);
	RsettingF.zidonghuifuYY.NR_E:SetScript("OnEnterPressed", function(self) 
		self:ClearFocus() 
	end);
	RsettingF.zidonghuifuYY.NR_E:SetScript("OnEditFocusLost", function(self)
		self:SetTextColor(0.6, 0.6, 0.6, 1);
		PIG["RaidRecord"]["Rsetting"]["YYneirong"]=self:GetText();
	end);
	---
	waiwaizidonghuifu_fuben:SetScript("OnEvent",function(self, event,arg1,_,_,_,arg5)
		if PIG["RaidRecord"]["Rsetting"]["zidonghuifuYY"]=="ON" then
			local isLeader = UnitIsGroupLeader("player", "LE_PARTY_CATEGORY_HOME");
			if isLeader then
				local nameziji = UnitName("player")
				if arg5~=nameziji then
					local fubenzhushou_zidonghuifuYY=arg1:find("[!Pig]", 1)
					if not fubenzhushou_zidonghuifuYY then
						local YYguanjianzi=PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"];
						for i=1,#YYguanjianzi do
							local YYhaoYES=arg1:find(YYguanjianzi[i], 1)
							if YYhaoYES then
								if event=="CHAT_MSG_WHISPER" then
									local IsInRaid=IsInRaid("LE_PARTY_CATEGORY_HOME");
									if IsInRaid then
										for p=1,40 do
											local name = GetUnitName("raid"..p, true)
											if name~=nil then
												if arg5==name then
													SendChatMessage("[!Pig] "..PIG["RaidRecord"]["Rsetting"]["YYneirong"], "WHISPER", nil, arg5);
													break
												end
											end
										end
									else
										local IsInGroup = IsInGroup("LE_PARTY_CATEGORY_HOME");
										if IsInGroup then
											for p=1,4 do
												local name = GetUnitName("party"..p, true)
												if name~=nil then
													if arg5==name then
														SendChatMessage("[!Pig] "..PIG["RaidRecord"]["Rsetting"]["YYneirong"], "WHISPER", nil, arg5);
														break
													end
												end
											end
										end
									end
								elseif event=="CHAT_MSG_PARTY" or event=="CHAT_MSG_PARTY_LEADER" then
									SendChatMessage("[!Pig] "..PIG["RaidRecord"]["Rsetting"]["YYneirong"], "PARTY", nil);
								elseif event=="CHAT_MSG_RAID" or event=="CHAT_MSG_RAID_LEADER" then
									SendChatMessage("[!Pig] "..PIG["RaidRecord"]["Rsetting"]["YYneirong"], "RAID_WARNING", nil);
								end
								break
							end
						end
					end
				end
			end
		end
	end)

	--=================================================================
	--过滤排除物品
	local paichu_Height,paichu_NUM  = 28, 14;
	local function gengxinpaichu(self)
		for q = 1, paichu_NUM do
			_G["Pcwupin_"..q.."_UI"].item:Hide();
			_G["Pcwupin_"..q.."_UI"].item.icon:SetTexture();
			_G["Pcwupin_"..q.."_UI"].item.link:SetText();
			_G["Pcwupin_"..q.."_UI"].del:Hide();
	    end
		if #PIG["RaidRecord"]["ItemList_Paichu"]>0 then
			local ItemsNum = #PIG["RaidRecord"]["ItemList_Paichu"];
			FauxScrollFrame_Update(self, ItemsNum, paichu_NUM, paichu_Height);
			local offset = FauxScrollFrame_GetOffset(self);
		    if ItemsNum<paichu_NUM then
		    	New_DELpaichu_NUM=ItemsNum;
		    else
		    	New_DELpaichu_NUM=paichu_NUM;
		    end
			for k = 1, New_DELpaichu_NUM do
				local dangqianH = k+offset;
				local itemName, itemLink, _, _, _, _, _, _,_, itemTexture=GetItemInfo(PIG["RaidRecord"]["ItemList_Paichu"][dangqianH]);
		    	_G["Pcwupin_"..k.."_UI"].item.icon:SetTexture(itemTexture);
				_G["Pcwupin_"..k.."_UI"].item.link:SetText(itemLink);
				_G["Pcwupin_"..k.."_UI"].item:Show();
				_G["Pcwupin_"..k.."_UI"].item:SetScript("OnMouseDown", function (self)
					GameTooltip:ClearLines();
					GameTooltip:SetOwner(self, "ANCHOR_CURSOR");
					GameTooltip:SetHyperlink(itemLink)
				end);
				_G["Pcwupin_"..k.."_UI"].item:SetScript("OnMouseUp", function ()
					GameTooltip:ClearLines();
					GameTooltip:Hide() 
				end);
				_G["Pcwupin_"..k.."_UI"].del:Show();
				_G["Pcwupin_"..k.."_UI"].del:SetID(dangqianH);
			end
		end
	end
	-----------
	RsettingF.Paichu = CreateFrame("Frame", "Paichu_UI", RsettingF)
	RsettingF.Paichu:SetSize(Width/3, Height-144)
	RsettingF.Paichu:SetPoint("RIGHT", RsettingF, "RIGHT", -2, -16)
	RsettingF.Paichu.line = RsettingF.Paichu:CreateLine()
	RsettingF.Paichu.line:SetColorTexture(1,1,1,0.3)
	RsettingF.Paichu.line:SetThickness(2);
	RsettingF.Paichu.line:SetStartPoint("TOPLEFT",0,-30)
	RsettingF.Paichu.line:SetEndPoint("TOPRIGHT",0,-30)
	RsettingF.Paichu.line1 = RsettingF.Paichu:CreateLine()
	RsettingF.Paichu.line1:SetColorTexture(1,1,1,0.3)
	RsettingF.Paichu.line1:SetThickness(2);
	RsettingF.Paichu.line1:SetStartPoint("TOPLEFT",0,1)
	RsettingF.Paichu.line1:SetEndPoint("BOTTOMLEFT",0,0)
	RsettingF.Paichu.biaoti = RsettingF.Paichu:CreateFontString();
	RsettingF.Paichu.biaoti:SetPoint("TOPLEFT", RsettingF.Paichu, "TOPLEFT", 4, -7);
	RsettingF.Paichu.biaoti:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");
	RsettingF.Paichu.biaoti:SetText("\124cffFFFF00拾取黑名单\124r\124cff00FF00(拾取目录右键添加)\124r");
	--提示
	RsettingF.Paichu.biaoti_tishi = CreateFrame("Frame", nil, RsettingF.Paichu);
	RsettingF.Paichu.biaoti_tishi:SetSize(30,30);
	RsettingF.Paichu.biaoti_tishi:SetPoint("LEFT",RsettingF.Paichu_biaoti,"RIGHT",-6,0);
	RsettingF.Paichu.biaoti_tishi_Texture = RsettingF.Paichu.biaoti_tishi:CreateTexture(nil, "BORDER");
	RsettingF.Paichu.biaoti_tishi_Texture:SetTexture("interface/common/help-i.blp");
	RsettingF.Paichu.biaoti_tishi_Texture:SetAllPoints(RsettingF.Paichu.biaoti_tishi)
	RsettingF.Paichu.biaoti_tishi:SetScript("OnEnter", function (self)
		GameTooltip:ClearLines();
		GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
		GameTooltip:AddLine("提示：")
		GameTooltip:AddLine("\124cff00ff00右键点击拾取记录物品名添加为不记录.\124r")
		GameTooltip:Show();
	end);
	RsettingF.Paichu.biaoti_tishi:SetScript("OnLeave", function ()
		GameTooltip:ClearLines();
		GameTooltip:Hide() 
	end);
	----可滚动区域
	RsettingF.Paichu.Scroll = CreateFrame("ScrollFrame",nil,RsettingF.Paichu, "FauxScrollFrameTemplate");  
	RsettingF.Paichu.Scroll:SetPoint("TOPLEFT",RsettingF.Paichu,"TOPLEFT",0,-32);
	RsettingF.Paichu.Scroll:SetPoint("BOTTOMRIGHT",RsettingF.Paichu,"BOTTOMRIGHT",-25,2);
	RsettingF.Paichu.Scroll:SetScript("OnVerticalScroll", function(self, offset)
	    FauxScrollFrame_OnVerticalScroll(self, offset, Paichu_Height, gengxinpaichu)
	end)
	--创建行
	for id = 1, paichu_NUM do
		local Pcwupin = CreateFrame("Frame", "Pcwupin_"..id.."_UI", RsettingF.Paichu.Scroll:GetParent());
		Pcwupin:SetSize(Width/3-30, paichu_Height);
		if id==1 then
			Pcwupin:SetPoint("TOP",RsettingF.Paichu.Scroll,"TOP",0,0);
		else
			Pcwupin:SetPoint("TOP",_G["Pcwupin_"..(id-1).."_UI"],"BOTTOM",0,-0);
		end
		if id~=paichu_NUM then
			Pcwupin.line = Pcwupin:CreateLine()
			Pcwupin.line:SetColorTexture(1,1,1,0.2)
			Pcwupin.line:SetThickness(1.2);
			Pcwupin.line:SetStartPoint("BOTTOMLEFT",0,0.2)
			Pcwupin.line:SetEndPoint("BOTTOMRIGHT",0,0.2)
		end
		Pcwupin.item = CreateFrame("Frame", nil, Pcwupin);
		Pcwupin.item:SetSize(Width/3-68,paichu_Height);
		Pcwupin.item:SetPoint("LEFT",Pcwupin,"LEFT",34,0);
		Pcwupin.item.icon = Pcwupin.item:CreateTexture(nil, "BORDER");
		Pcwupin.item.icon:SetSize(paichu_Height-4,paichu_Height-4);
		Pcwupin.item.icon:SetPoint("LEFT", Pcwupin.item, "LEFT", 0,0);
		Pcwupin.item.link = Pcwupin.item:CreateFontString();
		Pcwupin.item.link:SetPoint("LEFT", Pcwupin.item, "LEFT", 30,0);
		Pcwupin.item.link:SetFont(ChatFontNormal:GetFont(), 14, "OUTLINE");

		Pcwupin.del = CreateFrame("Button",nil,Pcwupin, "TruncatedButtonTemplate");
		Pcwupin.del:SetSize(22,22);
		Pcwupin.del:SetPoint("LEFT", Pcwupin, "LEFT", 5,0);
		Pcwupin.del.Tex = Pcwupin.del:CreateTexture(nil, "BORDER");
		Pcwupin.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
		Pcwupin.del.Tex:SetPoint("CENTER");
		Pcwupin.del.Tex:SetSize(15,15);
		Pcwupin.del:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		Pcwupin.del:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		Pcwupin.del:SetScript("OnClick", function (self)
			local Pcwupin_delID =self:GetID()
			table.remove(PIG["RaidRecord"]["ItemList_Paichu"], Pcwupin_delID);
			gengxinpaichu(RsettingF.Paichu.Scroll);
		end);
	end
	--=======================================================
	RsettingF.dibuui = RsettingF:CreateLine()
	RsettingF.dibuui:SetColorTexture(1,1,1,0.3)
	RsettingF.dibuui:SetThickness(2);
	RsettingF.dibuui:SetStartPoint("BOTTOMLEFT",5,40)
	RsettingF.dibuui:SetEndPoint("BOTTOMRIGHT",-276,40)
	-----------------------
	local function zhixingxiufucaizhi()
		local tihuanbgFile = "interface/raidframe/ui-raidframe-groupbg.blp"
		if PIG["RaidRecord"]["Rsetting"]["caizhixiufu"]=="ON" then
			tihuanbgFile = "interface/characterframe/ui-party-background.blp"
		end
		RaidR_UI.TabFrame:SetBackdrop({bgFile = tihuanbgFile, 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		RsettingF_UI:SetBackdrop({bgFile = tihuanbgFile, 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		invite_UI:SetBackdrop({bgFile = tihuanbgFile, 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 20, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		History_UI:SetBackdrop({bgFile = tihuanbgFile, 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		fenG_UI:SetBackdrop({bgFile = tihuanbgFile, 
		edgeFile = "interface/glues/common/textpanel-border.blp", 
		tile = false, tileSize = 0, edgeSize = 20,insets = { left = 4, right = 4, top = 4, bottom = 4 }});
		tihuanbgFile=nil
	end
	RsettingF.xiufucaizhi = ADD_Checkbutton(nil,RsettingF,-80,"BOTTOMLEFT",RsettingF,"BOTTOMLEFT",20,6,"使用纯黑背景材质","使用纯黑背景材质，可以修复使用非官方材质造成的显示问题")
	RsettingF.xiufucaizhi:SetScript("OnClick", function (self)
		if self:GetChecked() then	
			PIG["RaidRecord"]["Rsetting"]["caizhixiufu"]="ON";
		else
			PIG["RaidRecord"]["Rsetting"]["caizhixiufu"]="OFF";
		end
		zhixingxiufucaizhi()
	end);
	if PIG["RaidRecord"]["Rsetting"]["caizhixiufu"]=="ON" then
		zhixingxiufucaizhi()
	end
	---重置配置
	RsettingF.Default = CreateFrame("Button",nil,RsettingF, "UIPanelButtonTemplate");  
	RsettingF.Default:SetSize(138,22);
	RsettingF.Default:SetPoint("BOTTOMLEFT",RsettingF,"BOTTOMLEFT",340,10);
	RsettingF.Default:SetText("重置"..GnName.."配置");
	RsettingF.Default:SetScript("OnClick", function ()
		StaticPopup_Show ("HUIFU_DEFAULT_FUBEN");
	end);
	StaticPopupDialogs["HUIFU_DEFAULT_FUBEN"] = {
		text = "此操作将\124cffff0000重置\124r"..GnName.."所有配置，需重载界面。\n确定重置?",
		button1 = "确定",
		button2 = "取消",
		OnAccept = function()
			PIG["RaidRecord"] = addonTable.Default["RaidRecord"];
			PIG["RaidRecord"]["Kaiqi"] = "ON";
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
	}
	--============================
	RsettingF:HookScript("OnShow", function (self)
		if PIG["RaidRecord"]["Rsetting"]["jiaoyidaojishi"]=="ON" then
			RsettingF.jiaoyidaojishi:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["fubenwai"]=="ON" then
			RsettingF.fubenwai:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["wurenben"]=="ON" then
			RsettingF.wurenben:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["shoudongloot"]=="ON" then
			RsettingF.shoudongloot:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["jiaoyijilu"]=="ON" then
			RsettingF.jiaoyijilu:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["jiaoyitonggao"]=="ON" then
			RsettingF.jiaoyitonggao:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["caizhixiufu"]=="ON" then
			RsettingF.xiufucaizhi:SetChecked(true);
		end
		if PIG["RaidRecord"]["Rsetting"]["zidonghuifuYY"]=="ON" then
			RsettingF.zidonghuifuYY:SetChecked(true);
		end
		local huifuYY_guanjianzineirong="";
		for i=1,#PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"] do
			if i~=#PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"] then
				huifuYY_guanjianzineirong=huifuYY_guanjianzineirong..PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"][i].."，"
			else
				huifuYY_guanjianzineirong=huifuYY_guanjianzineirong..PIG["RaidRecord"]["Rsetting"]["YYguanjianzi"][i]
			end
		end
		RsettingF.zidonghuifuYY.E:SetText(huifuYY_guanjianzineirong)
		RsettingF.zidonghuifuYY.NR_E:SetText(PIG["RaidRecord"]["Rsetting"]["YYneirong"])
		gengxinpaichu(RsettingF.Paichu.Scroll);
	end)
	---
	Rsetting:HookScript("OnClick", function (self)
		History_UI:Hide();
		fenG_UI:Hide();
		invite_UI:Hide();
		if RsettingF_UI:IsShown() then
			RsettingF_UI:Hide();
		else
			RsettingF_UI:Show();
		end
	end);
end
addonTable.ADD_Rsetting = add_RsettingFrame