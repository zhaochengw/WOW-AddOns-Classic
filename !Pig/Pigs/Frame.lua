local addonName, addonTable = ...;
addonTable.Create={}
---------------------------
local Create = addonTable.Create
local Backdropinfo={bgFile = "interface/chatframe/chatframebackground.blp",
	edgeFile = "Interface/AddOns/!Pig/Pigs/Pig_Border.blp", edgeSize = 6,}
function Create.PIGFrame(Parent,WH,Point,UIName,ESCOFF)
	local frameX = CreateFrame("Frame", UIName, Parent,"BackdropTemplate")
	if WH then
		frameX:SetSize(WH[1],WH[2]);
	end
	if Point then
		frameX:SetPoint(Point[1],Point[2],Point[3],Point[4],Point[5]);
	end
	frameX:EnableMouse(true)
	if ESCOFF then
		frameX:Hide()
		tinsert(UISpecialFrames,UIName);
	end
	function frameX:PIGSetBackdrop(BGAlpha,BorderAlpha)
		local BGAlpha = BGAlpha or 0.6
		local BorderAlpha = BorderAlpha or 1
		self:SetBackdrop(Backdropinfo)
		self:SetBackdropColor(0.08, 0.08, 0.08, BGAlpha);
		self:SetBackdropBorderColor(0, 0, 0, BorderAlpha);
	end
	function frameX:PIGSetMovable(MovableUI)
		local MovableUI=MovableUI or self
		MovableUI:SetMovable(true)
		self:RegisterForDrag("LeftButton")
		self:SetScript("OnDragStart",function(self)
			MovableUI:StartMoving()
		end)
		self:SetScript("OnDragStop",function(self)
			MovableUI:StopMovingOrSizing()
		end)
		MovableUI:SetClampedToScreen(true)
	end
	function frameX:PIGClose(Ww,Hh,CloseUI)
		local CloseUI=CloseUI or self:GetParent()
		self.Close = CreateFrame("Button",nil,self);
		self.Close:SetHighlightTexture("interface/buttons/ui-common-mousehilight.blp")
		self.Close:SetSize(Ww,Hh);
		self.Close:SetPoint("TOPRIGHT",self,"TOPRIGHT",0,0);
		self.Close.Tex = self.Close:CreateTexture(nil, "BORDER");
		self.Close.Tex:SetTexture("interface/common/voicechat-muted.blp");
		self.Close.Tex:SetSize(self.Close:GetWidth()-8,self.Close:GetHeight()-8);
		self.Close.Tex:SetPoint("CENTER",0,0);
		self.Close:SetScript("OnMouseDown", function (self)
			self.Tex:SetPoint("CENTER",-1.5,-1.5);
		end);
		self.Close:SetScript("OnMouseUp", function (self)
			self.Tex:SetPoint("CENTER");
		end);
		self.Close:SetScript("OnClick", function (self)
			PlaySound(SOUNDKIT.U_CHAT_SCROLL_BUTTON);
			CloseUI:Hide()
		end);
	end
	return frameX
end
