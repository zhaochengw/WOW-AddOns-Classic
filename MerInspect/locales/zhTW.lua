
local _, ns = ...

BINDING_HEADER_TinyInspect = "裝備觀察"

if (GetLocale() ~= "zhTW") then return end

ns.L = {
    ShowItemBorder              = "顯示物品直角邊框",
    EnableItemLevel             = "顯示物品等級",
    ShowColoredItemLevelString  = "裝等文字使用品質顏色",
    ShowItemSlotString          = "顯示物品部位文字",
    ShowInspectAngularBorder    = "觀察面板顯示直角邊框",
    ShowInspectColoredLabel     = "觀察面板顯著標示橘裝",
	ShowCharacterItemSheet      = "顯示自己的裝備列表",
	ShowCharacterItemStats      = "顯示自己的裝備統計",
	ShowInspectItemSheet		= "顯示觀察對象的裝備列表",
    ShowOwnFrameWhenInspecting  = "觀察時顯示自己的裝備列表",
	ShowItemStats               = "顯示裝備屬性統計",
    DisplayPercentageStats      = "裝備屬性換算成百分比數值",
    EnablePartyItemLevel        = "啟用小隊隊友裝等",
    SendPartyItemLevelToSelf    = "發送隊友裝等到自己面板",
    SendPartyItemLevelToParty   = "發送隊友裝等到隊伍頻道",
    ShowPartySpecialization     = "顯示隊友專精",
    EnableRaidItemLevel         = "啟用團隊成員裝等",
    EnableMouseItemLevel        = "滑鼠提示中顯示裝等",
    EnableMouseSpecialization   = "顯示專精",
	EnableMouseWeaponLevel      = "顯示項鍊等級",
	ShowPluginGreenState        = "顯示副屬性前綴文字 |cffcccc33(需要重新載入 /reload)|r",
    Bag                         = "背包",
    Bank                        = "銀行",
    Merchant                    = "商人",
    Trade                       = "交易",
    Auction                     = "拍賣",
    AltEquipment                = "Alt 鍵換裝",
    GuildBank                   = "公會銀行",
    GuildNews                   = "公會新聞",
    PaperDoll                   = "角色視窗",
	Chat                        = "聊天",
	Loot                        = "拾取",
	Other						= "任務/冒險指南",
	Title						= "裝備觀察",
	OptionName					= "裝備-觀察",
	NA							= "未知",
}

BINDING_NAME_InspectRaidFrame = "顯示團隊觀察視窗"