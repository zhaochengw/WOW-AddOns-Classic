local AceGUI = LibStub("AceGUI-3.0")

local class = nil
local spec = nil
local phase = nil
local class_index = nil
local spec_index = nil
local phase_index = nil

local class_options = {}
local class_options_to_class = {}

local spec_options = {}
local spec_options_to_spec = {}
local phases = { "PR", "T4", "T5", "T6", "ZA", "SWP" }
local spec_frame = nil
local items = {}
local main_frame = nil

local function createItemFrame(item_id)
    if item_id < 0 then
        local f = AceGUI:Create("Label")
        return f
    end
    local item_frame = AceGUI:Create("Icon")
    item_frame:SetImageSize(30, 30)
    items[item_id] = Item:CreateFromItemID(item_id);

    if (items[item_id]:GetItemID()) then
        items[item_id]:ContinueOnItemLoad(function()
            item_frame:SetImage(items[item_id]:GetItemIcon())
            item_frame:SetCallback("OnClick", function(button)
                SetItemRef(items[item_id]:GetItemLink(), items[item_id]:GetItemLink(), "LeftButton");
            end)
            item_frame:SetCallback("OnEnter", function(widget)
                GameTooltip:SetOwner(item_frame.frame)
                GameTooltip:SetPoint("TOPRIGHT", item_frame.frame, "TOPRIGHT", 220, -13);
                GameTooltip:SetHyperlink(items[item_id]:GetItemLink())
            end)
            item_frame:SetCallback("OnLeave", function(widget)
                GameTooltip:Hide()
            end)
        end)
    end
    return item_frame
end

local function drawItemSlot(slot)
    local f = AceGUI:Create("Label")
    f:SetText(slot.slot_name)
    f:SetFont("Fonts\\FRIZQT__.TTF", 14)
    spec_frame:AddChild(f)
    for i, item_id in ipairs(slot) do
        spec_frame:AddChild(createItemFrame(item_id))
    end
end

local function drawTableHeader(frame)
    local f = AceGUI:Create("Label")
    f:SetText("Slot")
    f:SetFont("Fonts\\FRIZQT__.TTF", 14)
    frame:AddChild(f)
    for i = 1, 5 do
        f = AceGUI:Create("Label")
        f:SetText("Top " .. i)
        frame:AddChild(f)
    end
end

local function saveData()
    BistooltipAddon.db.char.class_index = class_index
    BistooltipAddon.db.char.spec_index = spec_index
    BistooltipAddon.db.char.phase_index = phase_index
end

local function drawSpecData()
    saveData()
    items = {}
    spec_frame:ReleaseChildren()
    drawTableHeader(spec_frame)
    if not spec or not phase then
        return
    end
    local slots = Bistooltip_bislists[class][spec][phase]
    for i, slot in ipairs(slots) do
        drawItemSlot(slot)
    end
end

local function buildClassDict()
    for ci, class in ipairs(Bistooltip_classes) do
        local option_name = "|T" .. Bistooltip_spec_icons[class.name].classIcon .. ":14|t " .. class.name
        table.insert(class_options, option_name)
        class_options_to_class[option_name] = { name = class.name, i = ci }
    end
end

local function buildSpecsDict(class_i)
    spec_options = {}
    spec_options_to_spec = {}
    for si, spec in ipairs(Bistooltip_classes[class_i].specs) do
        local option_name = "|T" .. Bistooltip_spec_icons[class][spec] .. ":14|t " .. spec
        table.insert(spec_options, option_name)
        spec_options_to_spec[option_name] = spec
    end
end

local function loadData()
    class_index = BistooltipAddon.db.char.class_index
    spec_index = BistooltipAddon.db.char.spec_index
    phase_index = BistooltipAddon.db.char.phase_index
    if class_index then
        class = class_options_to_class[class_options[class_index]].name
        buildSpecsDict(class_index)
    end
    if spec_index then
        spec = spec_options_to_spec[spec_options[spec_index]]
    end
    if phase_index then
        phase = phases[phase_index]
    end
end

local function drawDropdowns()
    local dropDownGroup = AceGUI:Create("SimpleGroup")

    dropDownGroup:SetLayout("Table")
    dropDownGroup:SetUserData("table", {
        columns = {
            110, 180, 70 },
        space = 1,
        align = "BOTTOMRIGHT"
    })
    main_frame:AddChild(dropDownGroup)

    local classDropdown = AceGUI:Create("Dropdown")
    local specDropdown = AceGUI:Create("Dropdown")
    local phaseDropDown = AceGUI:Create("Dropdown")
    specDropdown:SetDisabled(true)

    phaseDropDown:SetCallback("OnValueChanged", function(_, _, key)
        phase_index = key
        phase = phases[key]
        drawSpecData()
    end)

    specDropdown:SetCallback("OnValueChanged", function(_, _, key)
        spec_index = key
        spec = spec_options_to_spec[spec_options[key]]
        drawSpecData()
    end)

    classDropdown:SetCallback("OnValueChanged", function(_, _, key)
        class_index = key
        class = class_options_to_class[class_options[key]].name

        specDropdown:SetDisabled(false)
        buildSpecsDict(key)
        specDropdown:SetList(spec_options)
        specDropdown:SetValue(1)
        spec_index = 1
        spec = spec_options_to_spec[spec_options[1]]
        drawSpecData()
    end)

    classDropdown:SetList(class_options)
    phaseDropDown:SetList(phases)

    dropDownGroup:AddChild(classDropdown)
    dropDownGroup:AddChild(specDropdown)
    dropDownGroup:AddChild(phaseDropDown)

    local fillerFrame = AceGUI:Create("Label")
    fillerFrame:SetText(" ")
    main_frame:AddChild(fillerFrame)

    classDropdown:SetValue(class_index)
    if (class_index) then
        buildSpecsDict(class_index)
        specDropdown:SetList(spec_options)
        specDropdown:SetDisabled(false)
    end
    specDropdown:SetValue(spec_index)
    phaseDropDown:SetValue(phase_index)
end

local function createSpecFrame()
    local frame = AceGUI:Create("ScrollFrame")
    frame:SetLayout("Table")
    frame:SetUserData("table", {
        columns = {
            { weight = 5 },
            { width = 34 },
            { width = 34 },
            { width = 34 },
            { width = 34 },
            { width = 34 } },
        space = 1,
        align = "middle"
    })
    frame:SetFullWidth(true)
    --frame:SetFullHeight(true)
    frame:SetHeight(0)
    frame:SetAutoAdjustHeight(false)
    main_frame:AddChild(frame)
    spec_frame = frame
end

function BistooltipAddon:createMainFrame()
    if main_frame then
        AceGUI:Release(main_frame)
        return
    end
    main_frame = AceGUI:Create("Frame")
    main_frame:SetWidth(400)
    main_frame:SetCallback("OnClose", function(widget)
        spec_frame = nil
        AceGUI:Release(widget)
        main_frame = nil
    end)
    main_frame:SetLayout("List")
    main_frame:SetTitle(BistooltipAddon.AddonNameAndVersion)
    main_frame:SetStatusText("AceGUI-3.0")
    drawDropdowns()
    createSpecFrame()
    drawSpecData()
end

function BistooltipAddon:initBislists()
    loadData()
    LibStub("AceConsole-3.0"):RegisterChatCommand("bistooltip", function()
        BistooltipAddon:createMainFrame()
    end, persist)
end

buildClassDict()