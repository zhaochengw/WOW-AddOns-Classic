local addonName, addonTable = ...;
local gsub = _G.string.gsub 
local find = _G.string.find
local _, _, _, tocversion = GetBuildInfo()
local ADD_Frame=addonTable.ADD_Frame
local ADD_Checkbutton=addonTable.ADD_Checkbutton
local PIGDownMenu=addonTable.PIGDownMenu
-----------------------------------------
local function ADD_QuickBut_Jilu()
		local miyuP={}
		miyuP.zijirealm = GetRealmName()
		local jilupindaoID={"PARTY","RAID"};
		PIG["Chatjilu"]["jiluinfo"]=PIG["Chatjilu"]["jiluinfo"] or addonTable.Default["Chatjilu"]["jiluinfo"]
		local baocuntianshu=PIG["Chatjilu"]["tianshu"];
		for i=1,#jilupindaoID do
			local shujuyaun=PIG["Chatjilu"]["jiluinfo"][jilupindaoID[i]]["neirong"];
			if #shujuyaun>0 then
				if #shujuyaun[1]>0 then
					for ii=#shujuyaun[1], 1, -1 do
							local dangqianday=floor(GetServerTime()/60/60/24);
							local jiluday=shujuyaun[1][ii];
							if (dangqianday-jiluday)>baocuntianshu then
								table.remove(shujuyaun[1],ii);
								table.remove(shujuyaun[2],ii);
							end
					end
				end
			end
		end
		
		--密语
		local miyushuju=PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"];
		if #miyushuju>0 then
			for k,v in pairs(miyushuju[2]) do
				for i=#v,1,-1 do
					local baocunTime=baocuntianshu*60*60*24;
					if (GetServerTime()-v[i][2])>baocunTime then
						table.remove(v,i);					
					end
				end
				if #v==0 then
					table.removekey(miyushuju[2],k)
				end
			end
			for x=#miyushuju[1],1,-1 do
				if miyushuju[2][miyushuju[1][x][1]] then
					if #miyushuju[2][miyushuju[1][x][1]]==0 then
						table.remove(miyushuju[1],x);
					end
				else
					table.remove(miyushuju[1],x);
				end
			end
		end
		--------------
		local fuFrame=QuickChatFFF_UI
		local QuickChat_biaoqingName=addonTable.QuickChat_biaoqingName
		--密语/团队聊天记录
		local ChatWidth,ChatHeight=220,260;
		local ChatjiluMianban=ADD_Frame("ChatjiluMianban_UI",UIParent,ChatWidth*4,ChatHeight*2,"CENTER",UIParent,"CENTER",0,80,true,false,true,true,true)

		ChatjiluMianban.yidong = CreateFrame("Frame", nil, ChatjiluMianban);
		ChatjiluMianban.yidong:SetSize(ChatWidth*4-60,24);
		ChatjiluMianban.yidong:SetPoint("TOP", ChatjiluMianban, "TOP", 0, 0);
		ChatjiluMianban.yidong:EnableMouse(true)
		ChatjiluMianban.yidong:RegisterForDrag("LeftButton")
		ChatjiluMianban.yidong:SetScript("OnDragStart",function()
			ChatjiluMianban:StartMoving()
		end)
		ChatjiluMianban.yidong:SetScript("OnDragStop",function()
			ChatjiluMianban:StopMovingOrSizing()
		end)
		ChatjiluMianban.text0 = ChatjiluMianban:CreateFontString();
		ChatjiluMianban.text0:SetPoint("TOP", ChatjiluMianban, "TOP", 0,-4);
		ChatjiluMianban.text0:SetFontObject(GameFontNormal);
		ChatjiluMianban.text0:SetText("聊天记录");
		ChatjiluMianban.Close = CreateFrame("Button",nil,ChatjiluMianban, "UIPanelCloseButton");  
		ChatjiluMianban.Close:SetSize(32,32);
		ChatjiluMianban.Close:SetPoint("TOPRIGHT", ChatjiluMianban, "TOPRIGHT", 5, 4);

		ChatjiluMianban.TOP1 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.TOP1:SetTexture("interface/worldmap/ui-worldmap-top1.blp");
		ChatjiluMianban.TOP1:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.TOP1:SetPoint("TOPLEFT",ChatjiluMianban,"TOPLEFT",0,0);
		ChatjiluMianban.TOP2 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.TOP2:SetTexture("interface/worldmap/ui-worldmap-top2.blp");
		ChatjiluMianban.TOP2:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.TOP2:SetPoint("TOPLEFT",ChatjiluMianban.TOP1,"TOPRIGHT",0,0);
		ChatjiluMianban.TOP3 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.TOP3:SetTexture("interface/worldmap/ui-worldmap-top3.blp");
		ChatjiluMianban.TOP3:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.TOP3:SetPoint("TOPLEFT",ChatjiluMianban.TOP2,"TOPRIGHT",0,0);
		ChatjiluMianban.TOP4 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.TOP4:SetTexture("interface/worldmap/ui-worldmap-top4.blp");
		ChatjiluMianban.TOP4:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.TOP4:SetPoint("TOPLEFT",ChatjiluMianban.TOP3,"TOPRIGHT",0,0);
		---
		ChatjiluMianban.BOTTOM1 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.BOTTOM1:SetTexture("interface/worldmap/ui-worldmap-bottom1.blp");
		ChatjiluMianban.BOTTOM1:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.BOTTOM1:SetPoint("TOPLEFT",ChatjiluMianban.TOP1,"BOTTOMLEFT",0,0);
		ChatjiluMianban.BOTTOM2 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.BOTTOM2:SetTexture("interface/worldmap/ui-worldmap-bottom2.blp");
		ChatjiluMianban.BOTTOM2:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.BOTTOM2:SetPoint("TOPLEFT",ChatjiluMianban.BOTTOM1,"TOPRIGHT",0,0);
		ChatjiluMianban.BOTTOM3 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.BOTTOM3:SetTexture("interface/worldmap/ui-worldmap-bottom3.blp");
		ChatjiluMianban.BOTTOM3:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.BOTTOM3:SetPoint("TOPLEFT",ChatjiluMianban.BOTTOM2,"TOPRIGHT",0,0);
		ChatjiluMianban.BOTTOM4 = ChatjiluMianban:CreateTexture(nil, "BORDER");
		ChatjiluMianban.BOTTOM4:SetTexture("interface/worldmap/ui-worldmap-bottom4.blp");
		ChatjiluMianban.BOTTOM4:SetSize(ChatWidth,ChatHeight);
		ChatjiluMianban.BOTTOM4:SetPoint("TOPLEFT",ChatjiluMianban.BOTTOM3,"TOPRIGHT",0,0);

		----记录频道选择
		ChatjiluMianban.text1 = ChatjiluMianban:CreateFontString();
		ChatjiluMianban.text1:SetPoint("TOPLEFT", ChatjiluMianban, "TOPLEFT", 340,-40);
		ChatjiluMianban.text1:SetFontObject(GameFontNormal);
		ChatjiluMianban.text1:SetText("记录频道:");
		local huoquliaotianjiluFFF = CreateFrame("Frame");
		local jilupindaoName={"队伍","团队"};
		local jilupindaoNameC={"AAAAFF","FF7F00"};
		local jilupindaoEvent={{"CHAT_MSG_PARTY","CHAT_MSG_PARTY_LEADER"},{"CHAT_MSG_RAID","CHAT_MSG_RAID_LEADER","CHAT_MSG_RAID_WARNING"}};
		for j=1,#jilupindaoName do
			local pindaoxuanzeC = CreateFrame("CheckButton", "pindaoxuanzeC_"..j.."_UI", ChatjiluMianban, "ChatConfigCheckButtonTemplate");
			pindaoxuanzeC:SetSize(30,32);
			pindaoxuanzeC:SetHitRectInsets(0,0,0,0);
			if j==1 then
				pindaoxuanzeC:SetPoint("LEFT",ChatjiluMianban.text1,"RIGHT",4,0);
			else
				pindaoxuanzeC:SetPoint("LEFT",_G["pindaoxuanzeC_"..(j-1).."_UI"],"RIGHT",40,0);
			end
			_G["pindaoxuanzeC_"..j.."_UIText"]:SetText("\124cff"..jilupindaoNameC[j]..jilupindaoName[j].."\124r");
			pindaoxuanzeC.tooltip = "记录"..jilupindaoName[j].."频道聊天信息";
			pindaoxuanzeC:SetScript("OnClick", function (self)
				if self:GetChecked() then
					PIG["Chatjilu"]["jiluinfo"][jilupindaoID[j]]["kaiguan"]="ON";
					for jj=1,#jilupindaoEvent[j] do
						huoquliaotianjiluFFF:RegisterEvent(jilupindaoEvent[j][jj]);
					end
				else
					PIG["Chatjilu"]["jiluinfo"][jilupindaoID[j]]["kaiguan"]="OFF";
					for jj=1,#jilupindaoEvent[j] do
						huoquliaotianjiluFFF:UnregisterEvent(jilupindaoEvent[j][jj]);
					end
				end
			end);
		end
		--保存天数
		ChatjiluMianban.baocuntianchu = ChatjiluMianban:CreateFontString();
		ChatjiluMianban.baocuntianchu:SetPoint("TOPLEFT",ChatjiluMianban,"TOPLEFT",600,-38);
		ChatjiluMianban.baocuntianchu:SetFontObject(GameFontNormal);
		ChatjiluMianban.baocuntianchu:SetText("保存时间");
		-- --
		local baocuntianshulist ={7,31,180,365};
		local baocuntianshulistN ={[7]="一周",[31]="一月",[180]="半年",[365]="一年"};
		ChatjiluMianban.tianshuxiala=PIGDownMenu(nil,{70,24},ChatjiluMianban,{"LEFT",ChatjiluMianban.baocuntianchu,"RIGHT", 0,0})
		function ChatjiluMianban.tianshuxiala:PIGDownMenu_Update_But(self)
			local info = {}
			info.func = self.PIGDownMenu_SetValue
			for i=1,#baocuntianshulist,1 do
			    info.text, info.arg1, info.arg2 = baocuntianshulistN[baocuntianshulist[i]], baocuntianshulist[i], baocuntianshulist[i]
			    info.checked = baocuntianshulist[i]==PIG["Chatjilu"]["tianshu"]
				ChatjiluMianban.tianshuxiala:PIGDownMenu_AddButton(info)
			end 
		end
		function ChatjiluMianban.tianshuxiala:PIGDownMenu_SetValue(value,arg1,arg2)
			ChatjiluMianban.tianshuxiala:PIGDownMenu_SetText(value)
			PIG["Chatjilu"]["tianshu"]=arg1
			PIGCloseDropDownMenus()
		end
	
		ChatjiluMianban.qingkong = CreateFrame("Button",nil,ChatjiluMianban, "UIPanelButtonTemplate");
		ChatjiluMianban.qingkong:SetSize(90,22);
		ChatjiluMianban.qingkong:SetPoint("TOPRIGHT",ChatjiluMianban,"TOPRIGHT",-10,-34);
		ChatjiluMianban.qingkong:SetText("清空记录");
		ChatjiluMianban.qingkong:SetScript("OnClick", function (self)
			StaticPopup_Show ("QINGKONGLIAOTIANJILU");
		end);
		---
		ChatjiluMianban.nr = CreateFrame("Frame", nil, ChatjiluMianban,"BackdropTemplate");
		ChatjiluMianban.nr:SetBackdrop({bgFile = "interface/raidframe/ui-raidframe-groupbg.blp",tile = false,tileSize = 0});
		ChatjiluMianban.nr:SetSize(ChatWidth*4-8,ChatHeight*2-92);
		ChatjiluMianban.nr:SetPoint("TOP",ChatjiluMianban,"TOP",0,-66);
		ChatjiluMianban.nr.tishiliulan = ChatjiluMianban.nr:CreateFontString();
		ChatjiluMianban.nr.tishiliulan:SetPoint("CENTER",ChatjiluMianban.nr,"CENTER",0,0);
		ChatjiluMianban.nr.tishiliulan:SetFontObject(GameFontNormal);
		ChatjiluMianban.nr.tishiliulan:SetText("点击上方频道标签浏览聊天记录");
		-------
		ChatjiluMianban:HookScript("OnShow", function (self)
			ChatjiluMianban.tianshuxiala:PIGDownMenu_SetText(baocuntianshulistN[PIG["Chatjilu"]["tianshu"]])
			for j=1,#jilupindaoID do
				if PIG["Chatjilu"]["jiluinfo"][jilupindaoID[j]]["kaiguan"]=="ON" then
					_G["pindaoxuanzeC_"..j.."_UI"]:SetChecked(true);
				elseif PIG["Chatjilu"]["jiluinfo"][jilupindaoID[j]]["kaiguan"]=="OFF" then
					_G["pindaoxuanzeC_"..j.."_UI"]:SetChecked(false);
				end
			end
		end);
							
		-------------
		local hang_Width,hang_Height,hang_NUM  = ChatjiluMianban.nr:GetWidth()*0.14-30, 20, 17;
		local function CHATgengxinhang1(self)
			local nn=1;
			local laiyuan=jilupindaoID[nn];
			if _G["PindaolistFrame_"..nn.."_UI"]:IsShown() then
					for i = 1, hang_NUM do
						_G["riqi_list_TAB_"..nn.."_"..i]:Hide()
						_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetText();
						_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetTextColor(0,250/255,154/255, 1);
						_G["riqi_list_TAB_highlight1_"..nn.."_"..i]:Hide();
					end
					if #PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"]>0 then
					    local ItemsNum = #PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"][1];
					    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
					    local offset = FauxScrollFrame_GetOffset(self);
					    for i = 1, hang_NUM do
							local dangqian = (ItemsNum+1)-i-offset;
							if dangqian>0 then
								_G["riqi_list_TAB_"..nn.."_"..i]:Show()
								_G["riqi_list_TAB_"..nn.."_"..i]:SetID(dangqian)
								_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetText(date("%Y-%m-%d",PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"][1][dangqian]*86400));
								local yijihuohang=_G["liaotianneirong_shuaxin"..nn.."_UI"]:GetID()
								if dangqian==yijihuohang then
									_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetTextColor(1,1,1, 1);
									_G["riqi_list_TAB_highlight1_"..nn.."_"..i]:Show();
								end
							end
						end
					end
			end
		end
		---
		local function CHATgengxinhang2(self)
				local nn=2;
				local laiyuan=jilupindaoID[nn];
				if _G["PindaolistFrame_"..nn.."_UI"]:IsShown() then
						for i = 1, hang_NUM do
							_G["riqi_list_TAB_"..nn.."_"..i]:Hide()
							_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetText();
							_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetTextColor(0,250/255,154/255, 1);
							_G["riqi_list_TAB_highlight1_"..nn.."_"..i]:Hide();
						end
						if #PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"]>0 then
						    local ItemsNum = #PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"][1];
						    FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
						    local offset = FauxScrollFrame_GetOffset(self);
						    for i = 1, hang_NUM do
								local dangqian = (ItemsNum+1)-i-offset;
								if dangqian>0 then
									_G["riqi_list_TAB_"..nn.."_"..i]:Show()
									_G["riqi_list_TAB_"..nn.."_"..i]:SetID(dangqian)
									_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetText(date("%Y-%m-%d",PIG["Chatjilu"]["jiluinfo"][laiyuan]["neirong"][1][dangqian]*86400));
									local yijihuohang=_G["liaotianneirong_shuaxin"..nn.."_UI"]:GetID()
									if dangqian==yijihuohang then
										_G["riqi_list_TAB_Title_"..nn.."_"..i]:SetTextColor(1,1,1, 1);
										_G["riqi_list_TAB_highlight1_"..nn.."_"..i]:Show();
									end
								end
							end
						end
				end
		end
		---
		StaticPopupDialogs["QINGKONGLIAOTIANJILU"] = {
			text = "确定要清空所有记录和配置吗？",
			button1 = "确定",
			button2 = "取消",
			OnAccept = function()
				for i=1,#jilupindaoID do
					PIG["Chatjilu"]["jiluinfo"][jilupindaoID[i]]["neirong"]={}
					_G["liaotianneirong_shuaxin"..i.."_UI"]:SetID(0)
					if i==1 then
				    	CHATgengxinhang1(_G["riqi_list_Scroll_"..i.."_UI"]);
				    elseif i==2 then
				    	CHATgengxinhang2(_G["riqi_list_Scroll_"..i.."_UI"]);
				    end
					_G["CHatjilu_liaotianneirong_Scroll"..i.."_UI"]:Clear()
					_G["dangtianzonghangshu_"..i.."_UI"]:SetText()
				end
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		---
		local TabWidth,TabHeight = 110,26;
		for id=1,#jilupindaoName do
			local Pindaolist = CreateFrame("Button","Pindaolist_"..id.."_UI",ChatjiluMianban.nr, "TruncatedButtonTemplate",id);
			Pindaolist:SetSize(TabWidth,TabHeight);
			if id==1 then
				Pindaolist:SetPoint("BOTTOMLEFT", ChatjiluMianban.nr, "TOPLEFT", 10,-1);
			else
				Pindaolist:SetPoint("LEFT", _G["Pindaolist_"..(id-1).."_UI"], "RIGHT", 10,0);
			end
			Pindaolist.Tex = Pindaolist:CreateTexture(nil, "BORDER");
			Pindaolist.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
			PIGRotation(Pindaolist.Tex, 180)
			--Pindaolist.Tex:SetSize(TabWidth*1.16,TabHeight*1.3);
			Pindaolist.Tex:SetPoint("BOTTOM", Pindaolist, "BOTTOM", 0,0);
			Pindaolist.title = Pindaolist:CreateFontString();
			Pindaolist.title:SetPoint("BOTTOM", Pindaolist, "BOTTOM", 0,5);
			Pindaolist.title:SetFontObject(GameFontNormalSmall);
			Pindaolist.title:SetText(jilupindaoName[id]);
			Pindaolist.highlight = Pindaolist:CreateTexture(nil, "BORDER");
			Pindaolist.highlight:SetTexture("interface/paperdollinfoframe/ui-character-tab-highlight.blp");
			Pindaolist.highlight:SetBlendMode("ADD")
			Pindaolist.highlight:SetPoint("CENTER", Pindaolist.title, "CENTER", 0,0);
			Pindaolist.highlight:SetSize(TabWidth-12,TabHeight);
			Pindaolist.highlight:Hide();
			--
			local PindaolistFrame = CreateFrame("Frame", "PindaolistFrame_"..id.."_UI",ChatjiluMianban.nr);
			PindaolistFrame:SetSize(ChatWidth*4-8,ChatHeight*2-92);
			PindaolistFrame:SetPoint("TOP",ChatjiluMianban.nr,"TOP",0,-0);
			PindaolistFrame:Hide();
			--
			Pindaolist:SetScript("OnEnter", function (self)
				if not _G["PindaolistFrame_"..self:GetID().."_UI"]:IsShown() then
					self.title:SetTextColor(1, 1, 1, 1);
					self.highlight:Show();
				end
			end);
			Pindaolist:SetScript("OnLeave", function (self)
				if not _G["PindaolistFrame_"..self:GetID().."_UI"]:IsShown() then
					self.title:SetTextColor(1, 215/255, 0, 1);	
				end
				self.highlight:Hide();
			end);
			Pindaolist:SetScript("OnMouseDown", function (self)
				if not _G["PindaolistFrame_"..self:GetID().."_UI"]:IsShown() then
					self.title:SetPoint("CENTER", self, "CENTER", 2, -2);
				end
			end);
			Pindaolist:SetScript("OnMouseUp", function (self)		
				if not _G["PindaolistFrame_"..self:GetID().."_UI"]:IsShown() then
					self.title:SetPoint("CENTER", self, "CENTER", 0, 0);
				end
			end);
			-----------
			Pindaolist:SetScript("OnClick", function (self)
				ChatjiluMianban.nr.tishiliulan:Hide()
				for x=1,#jilupindaoName do
					local faja = _G["Pindaolist_"..x.."_UI"]
					faja.Tex:SetTexture("interface/paperdollinfoframe/ui-character-inactivetab.blp");
					faja.Tex:SetPoint("BOTTOM", faja, "BOTTOM", 0,0);
					faja.title:SetTextColor(1, 215/255, 0, 1);
					_G["PindaolistFrame_"..x.."_UI"]:Hide();
				end
				self.Tex:SetTexture("interface/paperdollinfoframe/ui-character-activetab.blp");
				self.Tex:SetPoint("BOTTOM", _G["Pindaolist_"..self:GetID().."_UI"], "BOTTOM", 0,-2);
				self.title:SetTextColor(1, 1, 1, 1);
				self.highlight:Hide();
				_G["PindaolistFrame_"..self:GetID().."_UI"]:Show();
				if id==1 then
			    	CHATgengxinhang1(_G["riqi_list_Scroll_"..id.."_UI"]);
			    elseif id==2 then
			    	CHATgengxinhang2(_G["riqi_list_Scroll_"..id.."_UI"]);
			    end
			end);
			-------左边日期目录
			local riqi_list = CreateFrame("Frame", "CHAT_riqi_list_"..id.."_UI", PindaolistFrame,"BackdropTemplate");
			riqi_list:SetBackdropBorderColor(1, 1, 1, 0.6);
			riqi_list:SetSize(ChatjiluMianban.nr:GetWidth()*0.14,ChatHeight*2-100);
			riqi_list:SetPoint("LEFT",PindaolistFrame,"LEFT",0,-0);
			riqi_list.line = riqi_list:CreateLine()
			riqi_list.line:SetColorTexture(1,1,1,0.2)
			riqi_list.line:SetThickness(2);
			riqi_list.line:SetStartPoint("TOPRIGHT",2,2)
			riqi_list.line:SetEndPoint("BOTTOMRIGHT",2,-3)

			riqi_list.Scroll = CreateFrame("ScrollFrame","riqi_list_Scroll_"..id.."_UI",riqi_list, "FauxScrollFrameTemplate");  
			riqi_list.Scroll:SetPoint("TOPLEFT",riqi_list,"TOPLEFT",2,-2);
			riqi_list.Scroll:SetPoint("BOTTOMRIGHT",riqi_list,"BOTTOMRIGHT",-24,0);
			riqi_list.Scroll:SetScript("OnVerticalScroll", function(self, offset)
				if id==1 then
			    	FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, CHATgengxinhang1)
			    elseif id==2 then
			    	FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, CHATgengxinhang2)
			    end
			end)
			local function zairuliaotianINFO(self,id)
					local laiyuan=PIG["Chatjilu"]["jiluinfo"][jilupindaoID[id]]["neirong"];
					local jilulist=laiyuan[2][self:GetID()];
					for x=1,#jilulist do
						local Event =jilulist[x][1];
						local info2 ="["..date("%H:%M",jilulist[x][2]).."] ";
						local info3 =jilulist[x][3];
						local info4_jiluxiaoxineirong =jilulist[x][4];
						local info5 =jilulist[x][5];
						for i=1,#QuickChat_biaoqingName do
							if info4_jiluxiaoxineirong:find(QuickChat_biaoqingName[i][1]) then
								info4_jiluxiaoxineirong = info4_jiluxiaoxineirong:gsub(QuickChat_biaoqingName[i][1], "\124T" .. QuickChat_biaoqingName[i][2] .. ":" ..(PIG["ChatFrame"]["FontSize_value"]+2) .. "\124t");
							end
						end
						local textCHATINFO="";
						if Event=="CHAT_MSG_PARTY_LEADER" then
							textCHATINFO=info2.."|Hchannel:PARTY|h|cff89D2FF[队长]|r|h |Hplayer:"..info3..":000:PARTY:|h|cff89D2FF[|r|c"..info5..info3.."|r|cff89D2FF]|h："..info4_jiluxiaoxineirong.."|r";
						elseif Event=="CHAT_MSG_PARTY" then							
							textCHATINFO=info2.."|Hchannel:PARTY|h|cffAAAAFF[小队]|r|h |Hplayer:"..info3..":000:PARTY:|h|cffAAAAFF[|r|c"..info5..info3.."|r|cffAAAAFF]|h："..info4_jiluxiaoxineirong.."\124r";
						elseif Event=="CHAT_MSG_RAID_LEADER" then							
							textCHATINFO=info2.."|Hchannel:RAID|h\124cffFF4809[团队领袖]\124r|h |Hplayer:"..info3..":000:RAID:|h\124cffFF4809[\124r|c"..info5..info3.."|r\124cffFF4809]|h："..info4_jiluxiaoxineirong.."\124r";
						elseif Event=="CHAT_MSG_RAID" then
							textCHATINFO=info2.."|Hchannel:RAID|h\124cffFF7F00[团队]\124r|h |Hplayer:"..info3..":000:RAID:|h\124cffFF7F00[\124r|c"..info5..info3.."|r\124cffFF7F00]|h："..info4_jiluxiaoxineirong.."\124r";						
						elseif Event=="CHAT_MSG_RAID_WARNING" then	
							textCHATINFO=info2.."\124cffFF4800[团队通知]\124r |Hplayer:"..info3..":000:RAID:|h\124cffFF4800[\124r|c"..info5..info3.."|r\124cffFF4800]|h："..info4_jiluxiaoxineirong.."\124r";
						end
						_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:Show()
						_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:AddMessage(textCHATINFO, nil, nil, nil, nil, true);	
					end
					local xianshiriqishuju=date("%Y-%m-%d",laiyuan[1][self:GetID()]*86400)
					_G["dangtianzonghangshu_"..id.."_UI"]:SetText(xianshiriqishuju.."|cff"..jilupindaoNameC[id].."["..jilupindaoName[id].."]|r聊天总行数:"..#jilulist);
			end
			for i=1, hang_NUM, 1 do
				riqi_list.TAB = CreateFrame("Button", "riqi_list_TAB_"..id.."_"..i, _G["riqi_list_Scroll_"..id.."_UI"]:GetParent(),nil,i);
				riqi_list.TAB:SetSize(hang_Width,hang_Height);
				if i==1 then
					riqi_list.TAB:SetPoint("TOPLEFT", riqi_list.Scroll, "TOPLEFT", 2, -3);
				else
					riqi_list.TAB:SetPoint("TOPLEFT", _G["riqi_list_TAB_"..id.."_"..(i-1)], "BOTTOMLEFT", 0, -4);
				end
				riqi_list.TAB.Title = riqi_list.TAB:CreateFontString("riqi_list_TAB_Title_"..id.."_"..i);
				riqi_list.TAB.Title:SetPoint("LEFT", riqi_list.TAB, "LEFT", 6, 0);
				riqi_list.TAB.Title:SetFontObject(GameFontNormal);
				riqi_list.TAB.Title:SetTextColor(0,250/255,154/255, 1);
				riqi_list.TAB.highlight = riqi_list.TAB:CreateTexture("riqi_list_TAB_highlight_"..id.."_"..i, "BORDER");
				riqi_list.TAB.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
				riqi_list.TAB.highlight:SetBlendMode("ADD")
				riqi_list.TAB.highlight:SetPoint("CENTER", riqi_list.TAB, "CENTER", 0,0);
				riqi_list.TAB.highlight:SetSize(hang_Width,hang_Height);
				riqi_list.TAB.highlight:SetAlpha(0.4);
				riqi_list.TAB.highlight:Hide();
				riqi_list.TAB.highlight1 = riqi_list.TAB:CreateTexture("riqi_list_TAB_highlight1_"..id.."_"..i, "BORDER");
				riqi_list.TAB.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
				riqi_list.TAB.highlight1:SetPoint("CENTER", riqi_list.TAB, "CENTER", 0,0);
				riqi_list.TAB.highlight1:SetSize(hang_Width,hang_Height);
				riqi_list.TAB.highlight1:SetAlpha(0.9);
				riqi_list.TAB.highlight1:Hide();
				_G["riqi_list_TAB_"..id.."_"..i]:SetScript("OnEnter", function (self)
					if not _G["riqi_list_TAB_highlight1_"..id.."_"..i]:IsShown() then
						_G["riqi_list_TAB_Title_"..id.."_"..i]:SetTextColor(1,1,1,1);
						_G["riqi_list_TAB_highlight_"..id.."_"..i]:Show();
					end
				end);
				_G["riqi_list_TAB_"..id.."_"..i]:SetScript("OnLeave", function (self)
					if not _G["riqi_list_TAB_highlight1_"..id.."_"..i]:IsShown() then
						_G["riqi_list_TAB_Title_"..id.."_"..i]:SetTextColor(0,250/255,154/255,1);	
					end
					_G["riqi_list_TAB_highlight_"..id.."_"..i]:Hide();
				end);
				_G["riqi_list_TAB_"..id.."_"..i]:SetScript("OnClick", function (self)
					for v=1,hang_NUM do
						_G["riqi_list_TAB_highlight1_"..id.."_"..v]:Hide();
						_G["riqi_list_TAB_highlight_"..id.."_"..v]:Hide();
						_G["riqi_list_TAB_Title_"..id.."_"..v]:SetTextColor(0,250/255,154/255,1);
					end
					_G["riqi_list_TAB_Title_"..id.."_"..i]:SetTextColor(1,1,1,1);
					_G["riqi_list_TAB_highlight1_"..id.."_"..i]:Show();
					---
					_G["liaotianneirong_shuaxin"..id.."_UI"]:SetID(self:GetID())
					_G["liaotianneirong_del"..id.."_UI"]:SetID(self:GetID())
					_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:Clear()
					zairuliaotianINFO(self,id)
				end)
			end
			---右边聊天内容
			local butWWW,butHHH = 30,30
			local liaotianneirong = CreateFrame("Frame", "CHAT_liaotianneirong_"..id.."_UI", PindaolistFrame,"BackdropTemplate");
			liaotianneirong:SetBackdropBorderColor(1, 1, 1, 0.6);
			liaotianneirong:SetSize(ChatjiluMianban.nr:GetWidth()*0.85,ChatHeight*2-100);
			liaotianneirong:SetPoint("RIGHT",PindaolistFrame,"RIGHT",-4,-0);
			liaotianneirong.Scroll = CreateFrame("ScrollingMessageFrame", "CHatjilu_liaotianneirong_Scroll"..id.."_UI", liaotianneirong, "ChatFrameTemplate")
			liaotianneirong.Scroll:SetPoint("TOPLEFT",liaotianneirong,"TOPLEFT",6,-4);
			liaotianneirong.Scroll:SetPoint("BOTTOMRIGHT",liaotianneirong,"BOTTOMRIGHT",-26,4);
			liaotianneirong.Scroll:SetFading(false)
			liaotianneirong.Scroll:SetMaxLines(9999)
			liaotianneirong.Scroll:UnregisterAllEvents()
			liaotianneirong.Scroll:SetFrameStrata("MEDIUM")
			liaotianneirong.Scroll:SetToplevel(false)
			liaotianneirong.Scroll:Hide()
			liaotianneirong.Scroll:SetHyperlinksEnabled(true)
			liaotianneirong.Scroll:EnableMouseWheel(true)
			---按钮
			liaotianneirong.Scroll.ScrollToBottomButton = CreateFrame("Button",nil,liaotianneirong.Scroll, "TruncatedButtonTemplate");
			liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
			liaotianneirong.Scroll.ScrollToBottomButton:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
			liaotianneirong.Scroll.ScrollToBottomButton:SetPushedTexture("interface/chatframe/ui-chaticon-scrollend-down.blp")
			liaotianneirong.Scroll.ScrollToBottomButton:SetSize(butWWW,butHHH);
			liaotianneirong.Scroll.ScrollToBottomButton:SetPoint("BOTTOMLEFT",liaotianneirong.Scroll,"BOTTOMRIGHT",0,4);
			liaotianneirong.Scroll.down = CreateFrame("Button",nil,liaotianneirong.Scroll, "TruncatedButtonTemplate");
			liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
			liaotianneirong.Scroll.down:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
			liaotianneirong.Scroll.down:SetPushedTexture("interface/chatframe/ui-chaticon-scrolldown-down.blp")
			liaotianneirong.Scroll.down:SetSize(butWWW,butHHH);
			liaotianneirong.Scroll.down:SetPoint("BOTTOM",liaotianneirong.Scroll.ScrollToBottomButton,"TOP",0,6);
			liaotianneirong.Scroll.up = CreateFrame("Button",nil,liaotianneirong.Scroll, "TruncatedButtonTemplate");
			liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
			liaotianneirong.Scroll.up:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
			liaotianneirong.Scroll.up:SetPushedTexture("interface/chatframe/ui-chaticon-scrollup-down.blp")
			liaotianneirong.Scroll.up:SetSize(butWWW,butHHH);
			liaotianneirong.Scroll.up:SetPoint("BOTTOM",liaotianneirong.Scroll.down,"TOP",0,6);
			liaotianneirong.Scroll.shuaxin = CreateFrame("Button","liaotianneirong_shuaxin"..id.."_UI",liaotianneirong.Scroll, "UIMenuButtonStretchTemplate");
			liaotianneirong.Scroll.shuaxin:SetHighlightTexture(0);
			liaotianneirong.Scroll.shuaxin:SetSize(butWWW-4,butHHH-4);
			liaotianneirong.Scroll.shuaxin:SetPoint("BOTTOM",liaotianneirong.Scroll.up,"TOP",-0.4,40);
			liaotianneirong.Scroll.shuaxin.highlight = liaotianneirong.Scroll.shuaxin:CreateTexture(nil, "HIGHLIGHT");
			liaotianneirong.Scroll.shuaxin.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
			liaotianneirong.Scroll.shuaxin.highlight:SetBlendMode("ADD")
			liaotianneirong.Scroll.shuaxin.highlight:SetPoint("CENTER", liaotianneirong.Scroll.shuaxin, "CENTER", 0,0);
			liaotianneirong.Scroll.shuaxin.highlight:SetSize(butWWW,butHHH);
			liaotianneirong.Scroll.shuaxin.Normal = liaotianneirong.Scroll.shuaxin:CreateTexture(nil, "BORDER");
			liaotianneirong.Scroll.shuaxin.Normal:SetTexture("interface/buttons/ui-refreshbutton.blp");
			liaotianneirong.Scroll.shuaxin.Normal:SetBlendMode("ADD")
			liaotianneirong.Scroll.shuaxin.Normal:SetPoint("CENTER", liaotianneirong.Scroll.shuaxin, "CENTER", 0,0);
			liaotianneirong.Scroll.shuaxin.Normal:SetSize(butWWW-14,butHHH-14);
			liaotianneirong.Scroll.shuaxin:HookScript("OnMouseDown", function (self)
				liaotianneirong.Scroll.shuaxin.Normal:SetPoint("CENTER", liaotianneirong.Scroll.shuaxin, "CENTER", -1.5,-1.5);
			end);
			liaotianneirong.Scroll.shuaxin:HookScript("OnMouseUp", function (self)
				liaotianneirong.Scroll.shuaxin.Normal:SetPoint("CENTER", liaotianneirong.Scroll.shuaxin, "CENTER", 0,0);
			end);
			-------------
			liaotianneirong.Scroll.kaishi = CreateFrame("Button",nil,liaotianneirong.Scroll, "TruncatedButtonTemplate");
			liaotianneirong.Scroll.kaishi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
			liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
			liaotianneirong.Scroll.kaishi:SetPushedTexture("interface/chatframe/ui-chaticon-scrollend-down.blp")
			liaotianneirong.Scroll.kaishi:SetSize(butWWW,butHHH);
			liaotianneirong.Scroll.kaishi:SetPoint("BOTTOM",liaotianneirong.Scroll.shuaxin,"TOP",0,50);
			local buttonNormal=liaotianneirong.Scroll.kaishi:GetNormalTexture() 
			PIGRotation(buttonNormal, 180)
			local buttonPushed=liaotianneirong.Scroll.kaishi:GetPushedTexture() 
			PIGRotation(buttonPushed, 180)

			liaotianneirong.Scroll.del = CreateFrame("Button","liaotianneirong_del"..id.."_UI",liaotianneirong.Scroll, "TruncatedButtonTemplate");
			liaotianneirong.Scroll.del:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square");
			liaotianneirong.Scroll.del:SetSize(butWWW-7,butHHH-7);
			liaotianneirong.Scroll.del:SetPoint("TOPLEFT",liaotianneirong.Scroll,"TOPRIGHT",1,-4);
			liaotianneirong.Scroll.del.Tex = liaotianneirong.Scroll.del:CreateTexture(nil, "BORDER");
			liaotianneirong.Scroll.del.Tex:SetTexture("interface/containerframe/bags.blp");
			if tocversion<40000 then
				liaotianneirong.Scroll.del.Tex:SetTexCoord(0.168,0.27,0.837,0.934);
			else
				liaotianneirong.Scroll.del.Tex:SetTexCoord(0.32,0.413,0.543,0.634);
			end
			liaotianneirong.Scroll.del.Tex:SetAllPoints(liaotianneirong.Scroll.del)

			liaotianneirong.Scroll.del.Tex1 = liaotianneirong.Scroll.del:CreateTexture(nil, "BORDER");
			liaotianneirong.Scroll.del.Tex1:SetTexture("interface/containerframe/bags.blp");
			if tocversion<40000 then
				liaotianneirong.Scroll.del.Tex1:
				SetTexCoord(0.008,0.11,0.86,0.958);
			else
				liaotianneirong.Scroll.del.Tex1:SetTexCoord(0.171,0.267,0.838,0.93);
			end
			liaotianneirong.Scroll.del.Tex1:SetAllPoints(liaotianneirong.Scroll.del)
			liaotianneirong.Scroll.del.Tex1:Hide();
			liaotianneirong.Scroll.del:SetScript("OnMouseDown", function (self)
				self.Tex:Hide();
				self.Tex1:Show();
			end);
			liaotianneirong.Scroll.del:SetScript("OnMouseUp", function (self)
				self.Tex:Show();
				self.Tex1:Hide();
			end);

			liaotianneirong.Scroll.kaishi:SetScript("OnClick", function (self)
				_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:ScrollToTop()
				liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-disabled.blp")
				liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-disabled.blp")
				liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
				liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
			end);
			liaotianneirong.Scroll.up:SetScript("OnClick", function (self)
				for i=1,20 do
					_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:ScrollUp()
				end
				liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
				liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
			end);
			liaotianneirong.Scroll.down:SetScript("OnClick", function (self)
				for i=1,20 do
					_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:ScrollDown()
				end
				liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
				liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
			end);
			liaotianneirong.Scroll.ScrollToBottomButton:SetScript("OnClick", function (self)
				_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:ScrollToBottom()
				liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
				liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
				liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-disabled.blp")
				liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-disabled.blp")
			end);
			liaotianneirong.Scroll.shuaxin:SetScript("OnClick", function (self)
				liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
				liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
				liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-disabled.blp")
				liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-disabled.blp")
				if self:GetID()>0 then
					_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:Clear()
					zairuliaotianINFO(self,id)
				end
			end);
			liaotianneirong.Scroll.del:SetScript("OnClick", function (self)
				local bjid =self:GetID()
				if bjid and bjid>0 then
					_G["CHatjilu_liaotianneirong_Scroll"..id.."_UI"]:Clear()
					table.remove(PIG["Chatjilu"]["jiluinfo"][jilupindaoID[id]]["neirong"][1],bjid);
					table.remove(PIG["Chatjilu"]["jiluinfo"][jilupindaoID[id]]["neirong"][2],bjid);
				    if id==1 then
				    	CHATgengxinhang1(_G["riqi_list_Scroll_"..id.."_UI"]);
				    elseif id==2 then
				    	CHATgengxinhang2(_G["riqi_list_Scroll_"..id.."_UI"]);
				    end
				    self:SetID(0)
				    liaotianneirong.Scroll.shuaxin:SetID(0)
				end
			end);
			liaotianneirong.Scroll:SetScript("OnMouseWheel", function(self, delta)
				if delta == 1 then
					liaotianneirong.Scroll.down:SetNormalTexture("interface/chatframe/ui-chaticon-scrolldown-up.blp")
					liaotianneirong.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
					liaotianneirong.Scroll:ScrollUp()
				elseif delta == -1 then
					liaotianneirong.Scroll.kaishi:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
					liaotianneirong.Scroll.up:SetNormalTexture("interface/chatframe/ui-chaticon-scrollup-up.blp")
					liaotianneirong.Scroll:ScrollDown()
				end
			end)
			---总行数
			local dangtianzonghangshu = liaotianneirong.Scroll:CreateFontString("dangtianzonghangshu_"..id.."_UI");
			dangtianzonghangshu:SetPoint("TOP",liaotianneirong.Scroll,"BOTTOM",0,-10);
			dangtianzonghangshu:SetFontObject(GameFontNormal);
		end
		---根据启用注册事件
		for i=1,#jilupindaoID do
			if PIG["Chatjilu"]["jiluinfo"][jilupindaoID[i]]["kaiguan"]=="ON" then
				for jj=1,#jilupindaoEvent[i] do
					huoquliaotianjiluFFF:RegisterEvent(jilupindaoEvent[i][jj]);
				end
			end
		end
		huoquliaotianjiluFFF:HookScript("OnEvent", function (self,event,arg1,arg2,arg3,arg4,arg5,_,_,_,_,_,_,arg12)
				for i=1,#jilupindaoEvent do
					for ii=1,#jilupindaoEvent[i] do
						if jilupindaoEvent[i][ii]==event then
							local xiaoxiTime=GetServerTime()
							local YYDAY=floor(xiaoxiTime/60/60/24)
							local localizedClass, englishClass = GetPlayerInfoByGUID(arg12)
							local rPerc, gPerc, bPerc, argbHex = GetClassColor(englishClass);
							local shujuyuanPR=PIG["Chatjilu"]["jiluinfo"][jilupindaoID[i]]["neirong"]
							if #shujuyuanPR>0 then
								local yijingcunzairiqi=false
								for f=#shujuyuanPR[1], 1, -1 do
									if shujuyuanPR[1][f]==YYDAY then
										table.insert(shujuyuanPR[2][f], {event,xiaoxiTime,arg5,arg1,argbHex});
										yijingcunzairiqi=true;
										break
									end
								end
								if yijingcunzairiqi==false then
									table.insert(shujuyuanPR[1], YYDAY);
									table.insert(shujuyuanPR[2], {{event,xiaoxiTime,arg5,arg1,argbHex}});
								end
							else
								PIG["Chatjilu"]["jiluinfo"][jilupindaoID[i]]["neirong"]={
									{YYDAY},{{{event,xiaoxiTime,arg5,arg1,argbHex}}}
								}
							end
						end
					end
				end
		end)
		--=======================================
		---密语记录
		local www,hhh,hang_Height,hang_NUM = 160,310,24,12
		local miyijiluF=ADD_Frame("miyijiluF_UI",UIParent,www,hhh,"CENTER",UIParent,"CENTER",0,70,true,true,true,true,true)
		miyijiluF:SetBackdrop({bgFile = "Interface/DialogFrame/UI-DialogBox-Background"});

		miyijiluF.line = miyijiluF:CreateLine()
		miyijiluF.line:SetColorTexture(1,1,1,0.2)
		miyijiluF.line:SetThickness(1);
		miyijiluF.line:SetStartPoint("TOPLEFT",1,-20)
		miyijiluF.line:SetEndPoint("TOPRIGHT",-1,-20)

		miyijiluF.biaoti = CreateFrame("Frame", nil, miyijiluF);
		miyijiluF.biaoti:SetSize(www,20);
		miyijiluF.biaoti:SetPoint("TOP", miyijiluF, "TOP", 0, 0);
		miyijiluF.biaoti:EnableMouse(true)
		miyijiluF.biaoti:RegisterForDrag("LeftButton")
		miyijiluF.biaoti:SetScript("OnDragStart",function()
			miyijiluF:StartMoving()
		end)
		miyijiluF.biaoti:SetScript("OnDragStop",function()
			miyijiluF:StopMovingOrSizing()
		end)
		miyijiluF.biaoti.shezhi = CreateFrame("Button",nil,miyijiluF.biaoti);
		miyijiluF.biaoti.shezhi:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		miyijiluF.biaoti.shezhi:SetSize(18,18);
		miyijiluF.biaoti.shezhi:SetPoint("LEFT",miyijiluF.biaoti,"LEFT",4,0);
		miyijiluF.biaoti.shezhi.Tex = miyijiluF.biaoti.shezhi:CreateTexture(nil,"OVERLAY");
		miyijiluF.biaoti.shezhi.Tex:SetTexture("interface/gossipframe/bindergossipicon.blp");
		miyijiluF.biaoti.shezhi.Tex:SetPoint("CENTER", 0, 0);
		miyijiluF.biaoti.shezhi.Tex:SetSize(16,16);
		miyijiluF.biaoti.shezhi:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1,-1);
		end);
		miyijiluF.biaoti.shezhi:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		miyijiluF.biaoti.shezhi:SetScript("OnClick", function (self)
			if miyijiluF.shezhiF:IsShown() then
				miyijiluF.shezhiF:Hide();
			else
				miyijiluF.shezhiF:Show();
				if PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["tixing"]=="ON" then
					miyijiluF.shezhiF.tixing:SetChecked(true)
				else
					miyijiluF.shezhiF.tixing:SetChecked(false)
				end
			end
		end)
		miyijiluF.shezhiF = CreateFrame("Frame", nil, miyijiluF,"BackdropTemplate");
		miyijiluF.shezhiF:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4,} );
		miyijiluF.shezhiF:SetBackdropBorderColor(0.5, 0.5, 0.5, 0.8);
		miyijiluF.shezhiF:SetSize(www,hhh);
		miyijiluF.shezhiF:SetPoint("TOPRIGHT",miyijiluF,"TOPLEFT",-1,0);
		miyijiluF.shezhiF:Hide();
		miyijiluF.shezhiF.Close = CreateFrame("Button",nil,miyijiluF.shezhiF, "TruncatedButtonTemplate");
		miyijiluF.shezhiF.Close:SetSize(18,18);
		miyijiluF.shezhiF.Close:SetPoint("TOPRIGHT",miyijiluF.shezhiF,"TOPRIGHT",-1,-2);
		miyijiluF.shezhiF.Close.highlight = miyijiluF.shezhiF.Close:CreateTexture(nil, "HIGHLIGHT");
		miyijiluF.shezhiF.Close.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
		miyijiluF.shezhiF.Close.highlight:SetBlendMode("ADD")
		miyijiluF.shezhiF.Close.highlight:SetPoint("CENTER", miyijiluF.shezhiF.Close, "CENTER", 0,0);
		miyijiluF.shezhiF.Close.highlight:SetSize(16,16);
		miyijiluF.shezhiF.Close.Tex = miyijiluF.shezhiF.Close:CreateTexture(nil, "BORDER");
		miyijiluF.shezhiF.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
		miyijiluF.shezhiF.Close.Tex:SetPoint("CENTER");
		miyijiluF.shezhiF.Close.Tex:SetSize(12,12)
		miyijiluF.shezhiF.Close:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1,-1);
		end);
		miyijiluF.shezhiF.Close:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		miyijiluF.shezhiF.Close:SetScript("OnClick", function (self)
			miyijiluF.shezhiF:Hide()
		end)

		miyijiluF.shezhiF.tixing = ADD_Checkbutton(nil,miyijiluF.shezhiF,-60,"TOPLEFT", miyijiluF.shezhiF, "TOPLEFT", 8,-10,"来密语提醒","收到密语时频道切换按钮里面的图标会闪动")
		miyijiluF.shezhiF.tixing:SetScript("OnClick", function (self)
			if self:GetChecked() then
				PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["tixing"]="ON" 
			else
				PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["tixing"]="OFF" 
			end
		end)
		---重置密语记录
		miyijiluF.shezhiF.MIYUJILU = miyijiluF.shezhiF:CreateFontString();
		miyijiluF.shezhiF.MIYUJILU:SetPoint("BOTTOMLEFT",miyijiluF.shezhiF,"BOTTOMLEFT",2,3);
		miyijiluF.shezhiF.MIYUJILU:SetFontObject(GameFontNormal);
		miyijiluF.shezhiF.MIYUJILU:SetText("\124cffFFff00出问题点\124r");
		miyijiluF.shezhiF.MIYUJILUBUT = CreateFrame("Button","Default_Button_daibenzhushou_UI",miyijiluF.shezhiF, "UIPanelButtonTemplate");  
		miyijiluF.shezhiF.MIYUJILUBUT:SetSize(76,20);
		miyijiluF.shezhiF.MIYUJILUBUT:SetPoint("LEFT",miyijiluF.shezhiF.MIYUJILU,"RIGHT",10,0);
		miyijiluF.shezhiF.MIYUJILUBUT:SetText("清空重置");
		miyijiluF.shezhiF.MIYUJILUBUT:SetScript("OnClick", function ()
			StaticPopup_Show ("CHONGZHI_MIYUJILU");
		end);
		---------
		miyijiluF.biaoti.text = miyijiluF.biaoti:CreateFontString();
		miyijiluF.biaoti.text:SetPoint("CENTER",miyijiluF.biaoti,"CENTER",0,0);
		miyijiluF.biaoti.text:SetFontObject(GameFontNormal);
		miyijiluF.biaoti.text:SetText("密语记录");

		miyijiluF.biaoti.Close = CreateFrame("Button",nil,miyijiluF.biaoti, "TruncatedButtonTemplate");
		miyijiluF.biaoti.Close:SetSize(18,18);
		miyijiluF.biaoti.Close:SetPoint("TOPRIGHT",miyijiluF.biaoti,"TOPRIGHT",-1,-2);
		miyijiluF.biaoti.Close.highlight = miyijiluF.biaoti.Close:CreateTexture(nil, "HIGHLIGHT");
		miyijiluF.biaoti.Close.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
		miyijiluF.biaoti.Close.highlight:SetBlendMode("ADD")
		miyijiluF.biaoti.Close.highlight:SetPoint("CENTER", miyijiluF.biaoti.Close, "CENTER", 0,0);
		miyijiluF.biaoti.Close.highlight:SetSize(16,16);
		miyijiluF.biaoti.Close.Tex = miyijiluF.biaoti.Close:CreateTexture(nil, "BORDER");
		miyijiluF.biaoti.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
		miyijiluF.biaoti.Close.Tex:SetPoint("CENTER");
		miyijiluF.biaoti.Close.Tex:SetSize(12,12)
		miyijiluF.biaoti.Close:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1,-1);
		end);
		miyijiluF.biaoti.Close:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		miyijiluF.biaoti.Close:SetScript("OnClick", function (self)
			miyijiluF:Hide()
		end)
		
		--右键功能
		local yuanchengchaj=addonTable.YCchaokanzhuangbei
		local function RGongNeng(menuName,name)
			local fullnameX = name
			if menuName=="邀请组队" then
				InviteUnit(fullnameX)
			elseif menuName=="目标信息" then
				C_FriendList.SendWho(fullnameX)
			elseif menuName=="添加好友" then
				C_FriendList.AddFriend(fullnameX)
			elseif menuName=="邀请入会" then
				GuildInvite(fullnameX)
			elseif menuName=="复制名字" then
				local editBoxXX
				editBoxXX = ChatEdit_ChooseBoxForSend()
		        local hasText = (editBoxXX:GetText() ~= "")
		        ChatEdit_ActivateChat(editBoxXX)
				editBoxXX:Insert(fullnameX)
		        if (not hasText) then editBoxXX:HighlightText() end
			elseif menuName=="查看装备" then
				yuanchengchaj(fullnameX)
			end
		end
		local listName={"邀请组队","目标信息","添加好友","邀请入会","复制名字","查看装备","取消"}
		local caidanW,caidanH=106,20

		local beijingico=DropDownList1MenuBackdrop.NineSlice.Center:GetTexture()
		local beijing1,beijing2,beijing3,beijing4=DropDownList1MenuBackdrop.NineSlice.Center:GetVertexColor()
		local Biankuang1,Biankuang2,Biankuang3,Biankuang4=DropDownList1MenuBackdrop:GetBackdropBorderColor()
		miyijiluF.RGN = CreateFrame("Frame", nil, miyijiluF,"BackdropTemplate");
		miyijiluF.RGN:SetBackdrop( { bgFile = beijingico,
			edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
			tile = false, tileSize = 0, edgeSize = 14, 
			insets = { left = 4, right = 4, top = 4, bottom = 4 } });
		miyijiluF.RGN:SetBackdropBorderColor(Biankuang1,Biankuang2,Biankuang3,Biankuang4);
		miyijiluF.RGN:SetBackdropColor(beijing1,beijing2,beijing3,beijing4);
		miyijiluF.RGN:SetSize(caidanW,caidanH*#listName+12+16);
		miyijiluF.RGN:Hide();
		miyijiluF.RGN:SetFrameLevel(8)
		miyijiluF.RGN:EnableMouse(true)
		miyijiluF.RGN:SetScript("OnUpdate", function(self, ssss)
			if miyijiluF.RGN.zhengzaixianshi==nil then
				return;
			else
				if miyijiluF.RGN.zhengzaixianshi==true then
					if miyijiluF.RGN.xiaoshidaojishi<= 0 then
						miyijiluF.RGN:Hide();
						miyijiluF.RGN.zhengzaixianshi = nil;
					else
						miyijiluF.RGN.xiaoshidaojishi = miyijiluF.RGN.xiaoshidaojishi - ssss;	
					end
				end
			end

		end)
		miyijiluF.RGN:SetScript("OnEnter", function()
			miyijiluF.RGN.zhengzaixianshi = nil;
		end)
		miyijiluF.RGN:SetScript("OnLeave", function()
			miyijiluF.RGN.xiaoshidaojishi = 1.5;
			miyijiluF.RGN.zhengzaixianshi = true;
		end)
		---
		miyijiluF.RGN.name = miyijiluF.RGN:CreateFontString();
		miyijiluF.RGN.name:SetPoint("TOP",miyijiluF.RGN,"TOP",0,-4);
		miyijiluF.RGN.name:SetFontObject(GameFontNormal);
		------
		for i=1,#listName do
			local RGNTAB = CreateFrame("Frame", "RGNTAB_"..i, miyijiluF.RGN);
			RGNTAB:SetSize(caidanW,caidanH);
			if i==1 then
				RGNTAB:SetPoint("TOPLEFT", miyijiluF.RGN, "TOPLEFT", 4, -22);
			else
				RGNTAB:SetPoint("TOPLEFT", _G["RGNTAB_"..(i-1)], "BOTTOMLEFT", 0, 0);
			end
			RGNTAB.Title = RGNTAB:CreateFontString();
			RGNTAB.Title:SetPoint("LEFT", RGNTAB, "LEFT", 6, 0);
			RGNTAB.Title:SetFontObject(GameFontNormal);
			RGNTAB.Title:SetTextColor(1,1,1, 1);
			RGNTAB.Title:SetText(listName[i]);
			RGNTAB.highlight1 = RGNTAB:CreateTexture(nil, "BORDER");
			RGNTAB.highlight1:SetTexture("interface/buttons/ui-listbox-highlight.blp");
			RGNTAB.highlight1:SetPoint("CENTER", RGNTAB, "CENTER", -3,0);
			RGNTAB.highlight1:SetSize(caidanW-18,16);
			RGNTAB.highlight1:SetAlpha(0.9);
			RGNTAB.highlight1:Hide();
			RGNTAB:SetScript("OnEnter", function(self)
				self.highlight1:Show()
				miyijiluF.RGN.zhengzaixianshi = nil;
			end);
			RGNTAB:SetScript("OnLeave", function(self)
				self.highlight1:Hide()
				miyijiluF.RGN.xiaoshidaojishi = 1.5;
				miyijiluF.RGN.zhengzaixianshi = true;
			end);
			RGNTAB:SetScript("OnMouseDown", function(self)
				self.Title:SetPoint("LEFT", self, "LEFT", 7.4, -1.4);
			end);
			RGNTAB:SetScript("OnMouseUp", function(self)
				self.Title:SetPoint("LEFT", self, "LEFT", 6, 0);
				miyijiluF.RGN:Hide();
				RGongNeng(self.Title:GetText(),miyijiluF.RGN.name.X)
			end);
		end
		---------

		miyijiluF.F = CreateFrame("Frame", nil, miyijiluF,"BackdropTemplate");
		miyijiluF.F:SetPoint("TOPLEFT",miyijiluF,"TOPLEFT",0,-20);
		miyijiluF.F:SetPoint("BOTTOMRIGHT",miyijiluF,"BOTTOMRIGHT",0,0);
		local function gengxinhang(self)
			for id = 1, hang_NUM do
		    	_G["MSGhang_"..id]:Hide();
		    end
		    local shuju=PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"]
			if #shuju>0 then
				local ItemsNum = #shuju[1];
				FauxScrollFrame_Update(self, ItemsNum, hang_NUM, hang_Height);
				local offset = FauxScrollFrame_GetOffset(self);
			    for id = 1, hang_NUM do
					local dangqian = id+offset;
					if shuju[1][dangqian] then
						_G["MSGhang_"..id]:Show();
						local coords = CLASS_ICON_TCOORDS[shuju[1][dangqian][2]]
						_G["MSGhang_"..id].zhiye:SetTexCoord(unpack(coords));
						local name1,name2 = strsplit("-", shuju[1][dangqian][1]);
						_G["MSGhang_"..id].name.X=shuju[1][dangqian][1]
						if name2 == GetRealmName() then
							_G["MSGhang_"..id].name:SetText(name1);
						else
							_G["MSGhang_"..id].name:SetText(name1.."(*)");
						end
						local rPerc, gPerc, bPerc, argbHex = GetClassColor(shuju[1][dangqian][2]);
						local nrname=shuju[1][dangqian][1]
						local shifouyuedu=shuju[1][dangqian][3]
						local nrheji=shuju[2][nrname]
						if nrheji[#nrheji][1]=="CHAT_MSG_WHISPER" then
							if shifouyuedu then
								_G["MSGhang_"..id].name:SetTextColor(rPerc, gPerc, bPerc, 1);
							else
								_G["MSGhang_"..id].name:SetTextColor(0.9, 0.9, 0.9, 1);
							end
						else
							_G["MSGhang_"..id].name:SetTextColor(0.5, 0.5, 0.5, 1);
						end
						_G["MSGhang_"..id].del:SetID(dangqian);
					end
				end
			end
		end
		StaticPopupDialogs["CHONGZHI_MIYUJILU"] = {
			text = "此操作将\124cffff0000重置\124r密语记录配置，并清空所有已保存数据。\n确定重置?",
			button1 = "确定",
			button2 = "取消",
			OnAccept = function()
				PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"] = addonTable.Default["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"];
				gengxinhang(miyijiluF.F.Scroll)
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
		}
		miyijiluF.F.Scroll = CreateFrame("ScrollFrame",nil,miyijiluF.F, "FauxScrollFrameTemplate");  
		miyijiluF.F.Scroll:SetPoint("TOPLEFT",miyijiluF.F,"TOPLEFT",0,-2);
		miyijiluF.F.Scroll:SetPoint("BOTTOMRIGHT",miyijiluF.F,"BOTTOMRIGHT",-20,2);
		miyijiluF.F.Scroll:SetScript("OnVerticalScroll", function(self, offset)
		    FauxScrollFrame_OnVerticalScroll(self, offset, hang_Height, gengxinhang)
		end)
		miyijiluF.F.Scroll.ScrollBar:SetScale(0.8);
		for id = 1, hang_NUM do
			local hang = CreateFrame("Frame", "MSGhang_"..id, miyijiluF.F.Scroll:GetParent());
			hang:SetSize(www, hang_Height);
			if id==1 then
				hang:SetPoint("TOPLEFT",miyijiluF.F.Scroll,"TOPLEFT",0,0);
			else
				hang:SetPoint("TOP",_G["MSGhang_"..(id-1)],"BOTTOM",0,-0);
			end
			hang:SetScript("OnEnter",  function(self)
				miyijiluF.zhengzaixianshi = nil;
				local WowWidth=GetScreenWidth()/2-300;
				local offset = miyijiluF:GetLeft();
				miyijiluF.nr:ClearAllPoints();
				if offset<WowWidth then
					miyijiluF.nr:SetPoint("TOPLEFT",miyijiluF,"TOPRIGHT",1,0);
				else
					miyijiluF.nr:SetPoint("TOPRIGHT",miyijiluF,"TOPLEFT",-1,0);
				end
				miyijiluF.nr:Show()
				self.highlight:Show();
				self.del:Show();
				miyijiluF.nr.Scroll:Clear()

				local idxx=self.del:GetID()
				local shuju=PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"]
				local Aname = shuju[1][idxx][1];
				shuju[1][idxx][3]=false
				
				
				local rPerc, gPerc, bPerc, argbHex = GetClassColor(shuju[1][idxx][2]);
				miyijiluF.nr.text:SetText("与 |c"..argbHex..Aname.."|r 聊天记录");
				

				local name1,name2 = strsplit("-", Aname);
				local nering=shuju[2][Aname]
				local zonghhh=#nering
				if nering[zonghhh][1]=="CHAT_MSG_WHISPER_INFORM" then
					self.name:SetTextColor(0.5, 0.5, 0.5, 1);
				else
					self.name:SetTextColor(0.9, 0.9, 0.9, 1);
				end
				miyijiluF.nr.Scroll.ScrollToBottomButton:Hide()
				if zonghhh>9 then
					if zonghhh>21 then
						miyijiluF.nr.Scroll.ScrollToBottomButton:Show()
						miyijiluF.nr:SetHeight(310);
					else
						miyijiluF.nr:SetHeight(zonghhh*16+20);
					end
				else
					miyijiluF.nr:SetHeight(150);
				end
				for ix=1,zonghhh do
					local Event =nering[ix][1];
					local info2 ="[\124cffC0C0C0"..date("%m-%d %H:%M",nering[ix][2]).."]\124r ";
					local info4_jiluxiaoxineirong =nering[ix][3];
					local textCHATINFO="";
					if Event=="CHAT_MSG_WHISPER_INFORM" then
						textCHATINFO=info2.."\124cffFF80FF发送给|Hplayer:"..name1..":000:WHISPER:"..name1.."|h[\124r|c"..argbHex..name1.."|r\124cffFF80FF]|h："..info4_jiluxiaoxineirong.."\124r";						
					elseif Event=="CHAT_MSG_WHISPER" then
						textCHATINFO=info2.."|Hplayer:"..name1..":000:WHISPER:"..name1.."|h\124cffFF80FF[\124r|c"..argbHex..name1.."|r\124cffFF80FF]|h悄悄地说："..info4_jiluxiaoxineirong.."\124r";
					end
					miyijiluF.nr.Scroll:Show()
					miyijiluF.nr.Scroll:AddMessage(textCHATINFO, nil, nil, nil, nil, true);
				end
			end)
			hang:SetScript("OnLeave",  function(self)
				miyijiluF.xiaoshidaojishi = 0.2;
				miyijiluF.zhengzaixianshi = true;
				self.highlight:Hide();
				self.del:Hide();
			end)
			hang:SetScript("OnMouseUp", function(self,button)
				local name = self.name:GetText()	
				local cunzai =name:find("*")
				if not cunzai then
					self.name.X=name
				end
				local nameinfo = self.name.X
				if button=="LeftButton" then
					local editBox = ChatEdit_ChooseBoxForSend();
					local hasText = editBox:GetText()
					if editBox:HasFocus() then
						editBox:SetText("/WHISPER " ..nameinfo.." ".. hasText);
					else
						ChatEdit_ActivateChat(editBox)
						editBox:SetText("/WHISPER " ..nameinfo.." ".. hasText);
					end
				elseif button=="RightButton" then
					miyijiluF.RGN:ClearAllPoints();
					miyijiluF.RGN:SetPoint("TOPLEFT",self,"BOTTOMLEFT",24,0);
					miyijiluF.RGN:Show()
					miyijiluF.RGN.name:SetText(name);
					miyijiluF.RGN.name.X=nameinfo;
					miyijiluF.RGN.xiaoshidaojishi = 1.5;
					miyijiluF.RGN.zhengzaixianshi = true;
				end
			end)
			hang.highlight = hang:CreateTexture(nil, "BORDER");
			hang.highlight:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
			hang.highlight:SetBlendMode("ADD")
			hang.highlight:SetPoint("CENTER", hang, "CENTER", 0,0);
			hang.highlight:SetSize(www, hang_Height-2);
			hang.highlight:SetAlpha(0.4);
			hang.highlight:Hide();
			if id~=hang_NUM then
				hang.line = hang:CreateLine()
				hang.line:SetColorTexture(1,1,1,0.2)
				hang.line:SetThickness(1);
				hang.line:SetStartPoint("BOTTOMLEFT",0,0)
				hang.line:SetEndPoint("BOTTOMRIGHT",0,0)
			end
			hang.zhiye = hang:CreateTexture(nil, "BORDER");
			hang.zhiye:SetTexture("Interface/TargetingFrame/UI-Classes-Circles");
			hang.zhiye:SetPoint("LEFT", hang, "LEFT", 4,0);
			hang.zhiye:SetSize(hang_Height-5,hang_Height-5);
			hang.name = hang:CreateFontString();
			hang.name:SetPoint("LEFT", hang.zhiye, "RIGHT", 4,0);
			hang.name:SetFont(ChatFontNormal:GetFont(), 13, "OUTLINE");
			hang.del = CreateFrame("Button",nil,hang, "TruncatedButtonTemplate");
			hang.del:SetSize(hang_Height-2,hang_Height-2);
			hang.del:SetPoint("RIGHT",hang,"RIGHT",-14,-0);
			hang.del:Hide();
			hang.del.highlight = hang.del:CreateTexture(nil, "HIGHLIGHT");
			hang.del.highlight:SetTexture("interface/buttons/ui-common-mousehilight.blp");
			hang.del.highlight:SetBlendMode("ADD")
			hang.del.highlight:SetPoint("CENTER", hang.del, "CENTER", 0,0);
			hang.del.highlight:SetSize(hang_Height-10,hang_Height-10);
			hang.del.Tex = hang.del:CreateTexture(nil, "BORDER");
			hang.del.Tex:SetTexture("interface/common/voicechat-muted.blp");
			hang.del.Tex:SetPoint("CENTER");
			hang.del.Tex:SetSize(hang_Height-12,hang_Height-12)
			hang.del:SetScript("OnEnter",  function(self)
				self:Show();
			end)
			hang.del:SetScript("OnLeave",  function(self)
				self:Hide();
			end)
			hang.del:SetScript("OnMouseDown", function (self)
				self.Tex:SetPoint("CENTER",-1,-1);
			end);
			hang.del:SetScript("OnMouseUp", function (self)
				self.Tex:SetPoint("CENTER");
			end);
			hang.del:SetScript("OnClick", function (self)
				local idid=self:GetID()
				local shuju=PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"]	
				table.removekey(shuju[2],shuju[1][idid][1])
				table.remove(shuju[1],idid);
				gengxinhang(miyijiluF.F.Scroll)
			end)
		end
		huoquliaotianjiluFFF:RegisterEvent("CHAT_MSG_WHISPER_INFORM");
		huoquliaotianjiluFFF:RegisterEvent("CHAT_MSG_WHISPER");
		--密语提醒
		local youNEWxiaoxinlai=false;
		local function miyuMGStishi()
				if fuFrame.ChatJilu.Tex:IsShown() then
					fuFrame.ChatJilu.Tex:Hide()
				else
					fuFrame.ChatJilu.Tex:Show()
				end
				if youNEWxiaoxinlai then
					C_Timer.After(0.8,miyuMGStishi)
				else
					fuFrame.ChatJilu.Tex:Show()
				end
		end
		--提取消息
		miyuP.zijirealm = GetRealmName()
		huoquliaotianjiluFFF:HookScript("OnEvent", function (self,event,arg1,arg2,arg3,arg4,arg5,_,_,_,_,_,_,arg12)
			if not miyuP.zijirealm then miyuP.zijirealm = GetRealmName() end
			if event=="CHAT_MSG_WHISPER" then
				if PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["tixing"]=="ON" and youNEWxiaoxinlai==false and not miyijiluF_UI:IsShown() then
					youNEWxiaoxinlai=true 
					miyuMGStishi() 
				end
			end
			if event=="CHAT_MSG_WHISPER_INFORM" or event=="CHAT_MSG_WHISPER" then
				if miyijiluF_UI:IsShown() then
					local function zhixingshuaxiHn()
						gengxinhang(miyijiluF.F.Scroll)
					end
					C_Timer.After(0.2,zhixingshuaxiHn)
				end
				local xiaoxiTime=GetServerTime()
				--local YYDAY=floor(xiaoxiTime/60/60/24)
				if not arg12 then return end
				local localizedClass, englishClass = GetPlayerInfoByGUID(arg12)
				if tocversion<40000 then
					local izedClass, englishClass, localizedRace, englishRace, sex, name, realm = GetPlayerInfoByGUID(arg12)
					if realm=="" or realm==" " then
						miyuP.miyuren=arg5.."-"..miyuP.zijirealm
					else
						miyuP.miyuren=arg5
					end
				else
					miyuP.miyuren=arg5
				end
				local huancunshuju=PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"]
				if #huancunshuju>0 then
					local yijingcunzairiqi=false
					for f=#huancunshuju[1], 1, -1 do
						if huancunshuju[1][f][1]==miyuP.miyuren then
							table.remove(huancunshuju[1],f);
							table.insert(huancunshuju[1],1,{miyuP.miyuren,englishClass,true});
							if not huancunshuju[2] then
								huancunshuju[2][miyuP.miyuren]={}
							end
							table.insert(huancunshuju[2][miyuP.miyuren], {event,xiaoxiTime,arg1});
							yijingcunzairiqi=true;
							break
						end
					end
					if yijingcunzairiqi==false then
						table.insert(huancunshuju[1],1,{miyuP.miyuren,englishClass,true});
						huancunshuju[2][miyuP.miyuren]={{event,xiaoxiTime,arg1}}
					end
				else
					PIG["Chatjilu"]["jiluinfo"]["WHISPER"]["neirong"]={
						{{miyuP.miyuren,englishClass,true}},{[miyuP.miyuren]={{event,xiaoxiTime,arg1}}}
					}
				end
			end
		end)
		-------------
		miyijiluF.nr = CreateFrame("Frame", nil, miyijiluF,"BackdropTemplate");
		miyijiluF.nr:SetBackdrop( { bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border", edgeSize = 4,} );
		miyijiluF.nr:SetWidth(400)
		miyijiluF.nr:SetHeight(120);
		miyijiluF.nr:SetPoint("TOPRIGHT",miyijiluF,"TOPLEFT",-1,0);
		miyijiluF.nr:Hide();
		miyijiluF.nr:SetScript("OnEnter",  function(self)
			miyijiluF.nr:Show();
			miyijiluF.zhengzaixianshi = nil;
		end)
		miyijiluF.nr:SetScript("OnLeave",  function(self)
			miyijiluF.xiaoshidaojishi = 0.2;
			miyijiluF.zhengzaixianshi = true;
		end)
		miyijiluF.nr:SetScript("OnUpdate", function(self, ssss)
			if miyijiluF.zhengzaixianshi==nil then
				return;
			else
				if miyijiluF.zhengzaixianshi==true then
					if miyijiluF.xiaoshidaojishi<= 0 then
						miyijiluF.nr:Hide();
						miyijiluF.zhengzaixianshi = nil;
					else
						miyijiluF.xiaoshidaojishi = miyijiluF.xiaoshidaojishi - ssss;	
					end
				end
			end
		end)

		miyijiluF.nr.text = miyijiluF.nr:CreateFontString();
		miyijiluF.nr.text:SetPoint("TOPLEFT",miyijiluF.nr,"TOPLEFT",4,-1);
		miyijiluF.nr.text:SetFontObject(GameFontNormal);

		miyijiluF.nr.line = miyijiluF.nr:CreateLine()
		miyijiluF.nr.line:SetColorTexture(1,1,1,0.2)
		miyijiluF.nr.line:SetThickness(1);
		miyijiluF.nr.line:SetStartPoint("TOPLEFT",1,-20)
		miyijiluF.nr.line:SetEndPoint("TOPRIGHT",-1,-20)
		--内容显示UI============================================
		miyijiluF.nr.Scroll = CreateFrame("ScrollingMessageFrame", "ChatFrame89", miyijiluF.nr, "ChatFrameTemplate")
		miyijiluF.nr.Scroll:SetPoint("TOPLEFT",miyijiluF.nr,"TOPLEFT",4,-22);
		miyijiluF.nr.Scroll:SetPoint("BOTTOMRIGHT",miyijiluF.nr,"BOTTOMRIGHT",-2,3);
		miyijiluF.nr.Scroll:UnregisterAllEvents()
		--miyijiluF.nr.Scroll:SetHyperlinksEnabled(true)--可点击
		miyijiluF.nr.Scroll:SetMaxLines(9999)
		miyijiluF.nr.Scroll:SetFading(false)
		miyijiluF.nr.Scroll:SetFrameStrata("HIGH")
		miyijiluF.nr.Scroll:SetScript("OnEnter",  function(self)
			miyijiluF.nr:Show();
			miyijiluF.zhengzaixianshi = nil;
		end)
		miyijiluF.nr.Scroll:SetScript("OnLeave",  function(self)
			miyijiluF.xiaoshidaojishi = 0.2;
			miyijiluF.zhengzaixianshi = true;
		end)
		miyijiluF.nr.Scroll:SetScript("OnMouseWheel", function(self, delta)
			if delta == 1 then
				self:ScrollUp()
				self.ScrollToBottomButton.hilight:Show();
			elseif delta == -1 then
				self:ScrollDown()
				if self:GetScrollOffset()==0 then
					self.ScrollToBottomButton.hilight:Hide();
				end
			end
		end)
		---翻页按钮=======================
		local anniudaxiaoF = 24
		miyijiluF.nr.Scroll.ScrollToBottomButton = CreateFrame("Button",nil,miyijiluF.nr.Scroll, "TruncatedButtonTemplate");
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetNormalTexture("interface/chatframe/ui-chaticon-scrollend-up.blp")
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp");
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetPushedTexture("interface/chatframe/ui-chaticon-scrollend-down.blp")
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetSize(anniudaxiaoF,anniudaxiaoF);
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetPoint("BOTTOMRIGHT",miyijiluF.nr.Scroll,"BOTTOMRIGHT",0,4);
		miyijiluF.nr.Scroll.ScrollToBottomButton.hilight = miyijiluF.nr.Scroll.ScrollToBottomButton:CreateTexture(nil,"OVERLAY");
		miyijiluF.nr.Scroll.ScrollToBottomButton.hilight:SetTexture("interface/chatframe/ui-chaticon-blinkhilight.blp");
		miyijiluF.nr.Scroll.ScrollToBottomButton.hilight:SetSize(anniudaxiaoF,anniudaxiaoF);
		miyijiluF.nr.Scroll.ScrollToBottomButton.hilight:SetPoint("CENTER", 0, 0);
		miyijiluF.nr.Scroll.ScrollToBottomButton.hilight:Hide();
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetScript("OnEnter",  function(self)
			miyijiluF.nr:Show();
			miyijiluF.zhengzaixianshi = nil;
		end)
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetScript("OnLeave",  function(self)
			miyijiluF.xiaoshidaojishi = 0.2;
			miyijiluF.zhengzaixianshi = true;
		end)
		miyijiluF.nr.Scroll.ScrollToBottomButton:SetScript("OnClick", function (self)
			miyijiluF.nr.Scroll:ScrollToBottom()
			self.hilight:Hide();
		end);
		---================================

		local Width,Height,jiangejuli = 24,24,4;
		local ziframe = {fuFrame:GetChildren()}
		if PIG["ChatFrame"]["QuickChat_style"]==1 then
			fuFrame.ChatJilu = CreateFrame("Button",nil,fuFrame, "TruncatedButtonTemplate"); 
		elseif PIG["ChatFrame"]["QuickChat_style"]==2 then
			fuFrame.ChatJilu = CreateFrame("Button",nil,fuFrame, "UIMenuButtonStretchTemplate"); 
		end
		fuFrame.ChatJilu:SetSize(Width,Height);
		fuFrame.ChatJilu:SetFrameStrata("LOW")
		fuFrame.ChatJilu:SetPoint("LEFT",fuFrame,"LEFT",#ziframe*Width,0);
		fuFrame.ChatJilu.Tex = fuFrame.ChatJilu:CreateTexture(nil, "BORDER");
		fuFrame.ChatJilu.Tex:SetTexture("interface/chatframe/ui-chatwhispericon.blp");
		fuFrame.ChatJilu.Tex:SetPoint("CENTER",0,0);
		fuFrame.ChatJilu.Tex:SetSize(Width-6,Height-4);
		fuFrame.ChatJilu:SetScript("OnEnter", function (self)	
			GameTooltip:ClearLines();
			GameTooltip:SetOwner(self, "ANCHOR_TOPLEFT",0,0);
			GameTooltip:SetText("|cff00FFff左键-|r|cffFFFF00私聊记录\n|cff00FFff右键-|r|cffFFFF00队伍团队记录|r");
			GameTooltip:Show();
			GameTooltip:FadeOut()
		end);
		fuFrame.ChatJilu:SetScript("OnLeave", function (self)
			GameTooltip:ClearLines();
			GameTooltip:Hide() 
		end);
		fuFrame.ChatJilu:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",1,-1);
		end);
		fuFrame.ChatJilu:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER",0,0);
		end);
		fuFrame.ChatJilu:RegisterForClicks("LeftButtonUp","RightButtonUp")
		fuFrame.ChatJilu:SetScript("OnClick", function(self, event)
			if event=="LeftButton" then
				ChatjiluMianban:Hide()
				if miyijiluF_UI:IsShown() then
					miyijiluF_UI:Hide()
				else
					youNEWxiaoxinlai=false;
					miyijiluF_UI:Show()
					gengxinhang(miyijiluF_UI.F.Scroll)
				end
			else
				miyijiluF_UI:Hide()
				if ChatjiluMianban:IsShown() then
					ChatjiluMianban:Hide()
				else
					ChatjiluMianban:SetFrameLevel(70)
					ChatjiluMianban:Show()	
				end
			end
		end);
end
--------------------------------------------
addonTable.ADD_QuickBut_Jilu =ADD_QuickBut_Jilu