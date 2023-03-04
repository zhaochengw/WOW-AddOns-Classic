----------------------------------------------------------------------------------
------------------------------ TITLES PANE FUNCTIONS -----------------------------
----------------------------------------------------------------------------------

local STRIPE_COLOR = {r=0.9, g=0.9, b=1};

-- Create Titles pane scrollbar frame
function MCF_CreateTitlesPane(frame)
    frame.TitlesPane = CreateFrame("ScrollFrame", "PaperDollTitlesPane", frame, "MCF-PaperDollTitlesPaneTemplate");
end

function MCF_PaperDollTitlesPane_OnLoad(self)
	HybridScrollFrame_OnLoad(self);
	self.update = MCF_PaperDollTitlesPane_UpdateScrollFrame;	
	HybridScrollFrame_CreateButtons(self, "MCF-PlayerTitleButtonTemplate", 2, -4);
end

function MCF_PaperDollTitlesPane_UpdateScrollFrame()
	local buttons = PaperDollTitlesPane.buttons;
	local playerTitles = PaperDollTitlesPane.titles;
	local numButtons = #buttons;
	local scrollOffset = HybridScrollFrame_GetOffset(PaperDollTitlesPane);
	local playerTitle;
	for i = 1, numButtons do
		playerTitle = playerTitles[i + scrollOffset];
		if ( playerTitle ) then
			buttons[i]:Show();
			buttons[i].text:SetText(playerTitle.name);
			buttons[i].titleId = playerTitle.id;
			if ( PaperDollTitlesPane.selected == playerTitle.id ) then
				buttons[i].Check:Show();
				buttons[i].SelectedBar:Show();
			else
				buttons[i].Check:Hide();
				buttons[i].SelectedBar:Hide();
			end
			
			if ((i+scrollOffset) == 1) then
				buttons[i].BgTop:Show();
				buttons[i].BgMiddle:SetPoint("TOP", buttons[i].BgTop, "BOTTOM");
			else
				buttons[i].BgTop:Hide();
				buttons[i].BgMiddle:SetPoint("TOP");
			end
			
			if ((i+scrollOffset) == #playerTitles) then
				buttons[i].BgBottom:Show();
				buttons[i].BgMiddle:SetPoint("BOTTOM", buttons[i].BgBottom, "TOP");
			else
				buttons[i].BgBottom:Hide();
				buttons[i].BgMiddle:SetPoint("BOTTOM");
			end
			
			if ((i+scrollOffset)%2 == 0) then
				buttons[i].Stripe:SetColorTexture(STRIPE_COLOR.r, STRIPE_COLOR.g, STRIPE_COLOR.b);
				buttons[i].Stripe:SetAlpha(0.1);
				buttons[i].Stripe:Show();
			else
				buttons[i].Stripe:Hide();
			end
		else
			buttons[i]:Hide();
		end
	end
end

local function MCF_PlayerTitleSort(a, b) return a.name < b.name; end 

function MCF_PaperDollTitlesPane_Update()
	local playerTitles = { };
	local currentTitle = GetCurrentTitle();		
	local titleCount = 1;
	local buttons = PaperDollTitlesPane.buttons;
	local fontstringText = buttons[1].text;
	local fontstringWidth;			
	local playerTitle = false;
	local tempName = 0;
	PaperDollTitlesPane.selected = -1;
	playerTitles[1] = { };
	-- reserving space for None so it doesn't get sorted out of the top position
	playerTitles[1].name = "       ";
	playerTitles[1].id = -1;		
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then		
			tempName, playerTitle = GetTitleName(i);
			if ( tempName and playerTitle ) then
				titleCount = titleCount + 1;
				playerTitles[titleCount] = playerTitles[titleCount] or { };
				playerTitles[titleCount].name = strtrim(tempName);
				playerTitles[titleCount].id = i;
				if ( i == currentTitle ) then
					PaperDollTitlesPane.selected = i;
				end					
				fontstringText:SetText(playerTitles[titleCount].name);
			end
		end
	end

	table.sort(playerTitles, MCF_PlayerTitleSort);
	playerTitles[1].name = PLAYER_TITLE_NONE;
	PaperDollTitlesPane.titles = playerTitles;	

	HybridScrollFrame_Update(PaperDollTitlesPane, titleCount * MCF_PLAYER_TITLE_HEIGHT + 20 , PaperDollTitlesPane:GetHeight());
	MCF_PaperDollTitlesPane_UpdateScrollFrame();
end

function MCF_PlayerTitleButton_OnClick(self)
	PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	SetCurrentTitle(self.titleId);
end

function MCF_SetTitleByName(name)
	name = strlower(name);
	for i = 1, GetNumTitles() do
		if ( IsTitleKnown(i) ~= false ) then
			local title = GetTitleName(i);
			title = strlower(strtrim(title));
			if(title:find(name) == 1) then
				SetCurrentTitle(i);
				return true;
			end
		end
	end
	return false;
end