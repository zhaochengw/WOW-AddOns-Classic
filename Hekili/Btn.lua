Hekili_mode_dict = {
    single = "单",
    aoe = "群",
    dual = "双",
    reactive = "响",
    automatic = "自",
}


function ChangeButtonColor(button, IsActive)
    
    if not button or not button.GetFontString then return end  -- 添加空值检查

    local r, g, b
    if IsActive then
        r, g, b = 0, 1, 0
    else
        r, g, b = 0.5, 0.5, 0.5
    end
    button:GetFontString():SetTextColor(r, g, b)
end

function Hekili_Btn_UpdateButton()
    if HekiliDisplayPrimary then
        if Hekili_Btnbutton1 then ChangeButtonColor(Hekili_Btnbutton1, Hekili.DB.profile.toggles.cooldowns.value) end
        if Hekili_Btnbutton2 then ChangeButtonColor(Hekili_Btnbutton2, Hekili.DB.profile.toggles.essences.value) end
        if Hekili_Btnbutton3 then ChangeButtonColor(Hekili_Btnbutton3, Hekili.DB.profile.toggles.interrupts.value) end
        if Hekili_Btnbutton4 then ChangeButtonColor(Hekili_Btnbutton4, Hekili.DB.profile.toggles.defensives.value) end
        if Hekili_Btnbutton5 then ChangeButtonColor(Hekili_Btnbutton5, Hekili.DB.profile.toggles.potions.value) end 
        if Hekili_Btnbutton6 then
            Hekili_Btnbutton6:SetText(Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value])
            ChangeButtonColor(Hekili_Btnbutton6, Hekili.DB.profile.toggles.mode.value)
        end
    end
end

--控制按钮
function Hekili_Btn_CreateBtnFrame()
    Hekili_BtnFrame = CreateFrame("Frame", "BtnFrame")
    Hekili_BtnFrame:SetSize(9, 9)

    Hekili_Btnbutton1 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton1:SetSize(20, 20)
    Hekili_Btnbutton1:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 0, 0)
    Hekili_Btnbutton1:SetText("主")
    Hekili_Btnbutton1:GetFontString():SetTextColor(0.5, 0.5, 0.5)
    Hekili_Btnbutton1:SetScript("OnClick", function()
        Hekili:FireToggle("cooldowns")
        Hekili_Btn_UpdateButton()
    end)

    Hekili_Btnbutton2 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton2:SetSize(20, 20)
    Hekili_Btnbutton2:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 20, 0)
    Hekili_Btnbutton2:SetText("次")
    Hekili_Btnbutton2:GetFontString():SetTextColor(0, 1, 0)
    Hekili_Btnbutton2:SetScript("OnClick", function()
        Hekili:FireToggle("essences")
        Hekili_Btn_UpdateButton()
    end)

    Hekili_Btnbutton3 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton3:SetSize(20, 20)
    Hekili_Btnbutton3:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 40, 0)
    Hekili_Btnbutton3:SetText("断")
    Hekili_Btnbutton3:GetFontString():SetTextColor(0, 1, 0)
    Hekili_Btnbutton3:SetScript("OnClick", function()
        Hekili:FireToggle("interrupts")
        Hekili_Btn_UpdateButton()
    end)

    Hekili_Btnbutton4 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton4:SetSize(20, 20)
    Hekili_Btnbutton4:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 60, 0)
    Hekili_Btnbutton4:SetText("防")
    Hekili_Btnbutton4:GetFontString():SetTextColor(0, 1, 0)
    Hekili_Btnbutton4:SetScript("OnClick", function()
        Hekili:FireToggle("defensives")
        Hekili_Btn_UpdateButton()
    end)

    Hekili_Btnbutton5 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton5:SetSize(20, 20)
    Hekili_Btnbutton5:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 80, 0)
    Hekili_Btnbutton5:SetText("药")
    Hekili_Btnbutton5:GetFontString():SetTextColor(0, 1, 0)
    Hekili_Btnbutton5:SetScript("OnClick", function()
        Hekili:FireToggle("potions")
        Hekili_Btn_UpdateButton()
    end)

    Hekili_Btnbutton6 = CreateFrame("Button", "Hekili_BtnButton", Hekili_BtnFrame, "UIPanelButtonTemplate")
    Hekili_Btnbutton6:SetSize(20, 20)
    Hekili_Btnbutton6:SetPoint("TOPLEFT", Hekili_BtnFrame, "TOPLEFT", 100, 0)
    Hekili_Btnbutton6:SetText(Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value])
    Hekili_Btnbutton6:GetFontString():SetTextColor(0, 1, 0)
    Hekili_Btnbutton6:SetScript("OnClick", function()
        Hekili:FireToggle("mode")
        Hekili_Btnbutton6:SetText(Hekili_mode_dict[Hekili.DB.profile.toggles.mode.value])
    end)
    Hekili_Btn_UpdateButton()
end

local function UpdateBtnFrameVisibility()
    if HekiliDisplayPrimary and Hekili.DB.profile.btnFunction then
        if not Hekili_BtnFrame then
            Hekili_Btn_CreateBtnFrame()
            Hekili_BtnFrame:ClearAllPoints() -- 清除原来的位置
            Hekili_BtnFrame:SetPoint("TOPLEFT", HekiliDisplayPrimary, "TOPLEFT", 0, 20)
        end
        Hekili_BtnFrame:Show()
    elseif Hekili_BtnFrame then
        Hekili_BtnFrame:Hide()
    end
end

C_Timer.After(1, UpdateBtnFrameVisibility)

local frame = CreateFrame("Frame")
frame:SetScript("OnUpdate", function()
    if HekiliDisplayPrimary then
        Hekili_Btn_UpdateButton()
        UpdateBtnFrameVisibility()
    end
end)
