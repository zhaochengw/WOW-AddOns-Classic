-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

-- Prevent multi-loading
if not HTBLIB_VERSION or HTBLIB_VERSION < 1.32 then

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

HTBLIB_POSITION = "Position";
HTBLIB_POSITIONS = { unlock = "Unlocked", lock = "Locked", auto = "Automatic" };
HTBLIB_SHOWBORDERS = "Show borders";
HTBLIB_LAYOUT = "Layout";
HTBLIB_CONFIRM_RESET = "Do you really want to reset '%s'? The interface will be reloaded.";

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------

if (GetLocale() == "frFR") then

HTBLIB_POSITION = "Position";
HTBLIB_POSITIONS.unlock = "Déverrouillée";
HTBLIB_POSITIONS.lock = "Verrouillée";
HTBLIB_POSITIONS.auto = "Automatique";
HTBLIB_SHOWBORDERS = "Afficher les cadres";
HTBLIB_LAYOUT = "Disposition";
HTBLIB_CONFIRM_RESET = "Voulez-vous vraiment réinitialiser '%s' ? L'interface sera rechargée.";

end

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then

HTBLIB_POSITION = "Position";
HTBLIB_POSITIONS.unlock = "Entriegelte";
HTBLIB_POSITIONS.lock = "Verriegelte";
HTBLIB_POSITIONS.auto = "Automatische";
HTBLIB_SHOWBORDERS = "Ränder zeigen";
HTBLIB_LAYOUT = "Layout";
HTBLIB_CONFIRM_RESET = "Möchtet Ihr wirklich '%s' zurücksetzen? Die Schnittstelle wird neu geladen.";

end

-------------------------------------------------------------------------------
-- Spanish localization
-------------------------------------------------------------------------------

if (GetLocale() == "esES") then

HTBLIB_POSITION = "Posición";
HTBLIB_POSITIONS.unlock = "Desatrancada";
HTBLIB_POSITIONS.lock = "Cerrada";
HTBLIB_POSITIONS.auto = "Automática";
HTBLIB_SHOWBORDERS = "Mostrar bordes";
HTBLIB_LAYOUT = "Disposición";
HTBLIB_CONFIRM_RESET = "¿Seguro que quieres reajustar '%s'? El interfaz será recargado.";

end


-------------------------------------------------------------------------------
-- Russian localization
-------------------------------------------------------------------------------

if (GetLocale() == "ruRU") then

HTBLIB_POSITION = "Позиция";
HTBLIB_POSITIONS.unlock = "Освободить";
HTBLIB_POSITIONS.lock = "Закрепить";
HTBLIB_POSITIONS.auto = "Авто";
HTBLIB_SHOWBORDERS = "Показывать края";
HTBLIB_LAYOUT = "Планировка";
HTBLIB_CONFIRM_RESET = "Вы действительно хотите сбросить '%s'? Интерфейс будет перезагружен.";

end

-------------------------------------------------------------------------------
-- Simplified Chinese localization
-------------------------------------------------------------------------------

if (GetLocale() == "zhCN") then

HTBLIB_POSITION = "位置";
HTBLIB_POSITIONS.unlock = "开锁";
HTBLIB_POSITIONS.lock = "锁着";
HTBLIB_POSITIONS.auto = "自动";
HTBLIB_SHOWBORDERS = "显示疆界";
HTBLIB_LAYOUT = "格式";
HTBLIB_CONFIRM_RESET = "您真正地想要重新设置 '%s' 吗? 界面将被重新载入。";

end

-------------------------------------------------------------------------------
-- Traditional Chinese localization
-------------------------------------------------------------------------------

if (GetLocale() == "zhTW") then

HTBLIB_POSITION = "位置";
HTBLIB_POSITIONS = { unlock = "解除鎖定", lock = "鎖定位置", auto = "自動" };
HTBLIB_SHOWBORDERS = "顯示邊框";
HTBLIB_LAYOUT = "格式";
HTBLIB_CONFIRM_RESET = "您真正地想要重新設置 '%s' 嗎? 介面將會重新截入。";
HTBLIB_ACTIVATE_SPEC_1 = "啟用主要天賦配置";
HTBLIB_ACTIVATE_SPEC_2 = "啟用第二天賦配置"; 

end

end
