-- This Source Code Form is subject to the terms of the Mozilla Public
-- License, v. 2.0. If a copy of the MPL was not distributed with this file,
-- You can obtain one at http://mozilla.org/MPL/2.0/.

-- Prevent multi-loading
if not FLOLIB_VERSION or FLOLIB_VERSION < 1.32 then

-------------------------------------------------------------------------------
-- English localization (Default)
-------------------------------------------------------------------------------

FLOLIB_POSITION = "Position";
FLOLIB_POSITIONS = { unlock = "Unlocked", lock = "Locked", auto = "Automatic" };
FLOLIB_SHOWBORDERS = "Show borders";
FLOLIB_LAYOUT = "Layout";
FLOLIB_CONFIRM_RESET = "Do you really want to reset '%s'? The interface will be reloaded.";

-------------------------------------------------------------------------------
-- French localization
-------------------------------------------------------------------------------

if (GetLocale() == "frFR") then

FLOLIB_POSITION = "Position";
FLOLIB_POSITIONS.unlock = "Déverrouillée";
FLOLIB_POSITIONS.lock = "Verrouillée";
FLOLIB_POSITIONS.auto = "Automatique";
FLOLIB_SHOWBORDERS = "Afficher les cadres";
FLOLIB_LAYOUT = "Disposition";
FLOLIB_CONFIRM_RESET = "Voulez-vous vraiment réinitialiser '%s' ? L'interface sera rechargée.";

end

-------------------------------------------------------------------------------
-- German localization
-------------------------------------------------------------------------------

if (GetLocale() == "deDE") then

FLOLIB_POSITION = "Position";
FLOLIB_POSITIONS.unlock = "Entriegelte";
FLOLIB_POSITIONS.lock = "Verriegelte";
FLOLIB_POSITIONS.auto = "Automatische";
FLOLIB_SHOWBORDERS = "Ränder zeigen";
FLOLIB_LAYOUT = "Layout";
FLOLIB_CONFIRM_RESET = "Möchtet Ihr wirklich '%s' zurücksetzen? Die Schnittstelle wird neu geladen.";

end

-------------------------------------------------------------------------------
-- Spanish localization
-------------------------------------------------------------------------------

if (GetLocale() == "esES") then

FLOLIB_POSITION = "Posición";
FLOLIB_POSITIONS.unlock = "Desatrancada";
FLOLIB_POSITIONS.lock = "Cerrada";
FLOLIB_POSITIONS.auto = "Automática";
FLOLIB_SHOWBORDERS = "Mostrar bordes";
FLOLIB_LAYOUT = "Disposición";
FLOLIB_CONFIRM_RESET = "¿Seguro que quieres reajustar '%s'? El interfaz será recargado.";

end


-------------------------------------------------------------------------------
-- Russian localization
-------------------------------------------------------------------------------

if (GetLocale() == "ruRU") then

FLOLIB_POSITION = "Позиция";
FLOLIB_POSITIONS.unlock = "Освободить";
FLOLIB_POSITIONS.lock = "Закрепить";
FLOLIB_POSITIONS.auto = "Авто";
FLOLIB_SHOWBORDERS = "Показывать края";
FLOLIB_LAYOUT = "Планировка";
FLOLIB_CONFIRM_RESET = "Вы действительно хотите сбросить '%s'? Интерфейс будет перезагружен.";

end

-------------------------------------------------------------------------------
-- Simplified Chinese localization
-------------------------------------------------------------------------------

if (GetLocale() == "zhCN") then

FLOLIB_POSITION = "位置";
FLOLIB_POSITIONS.unlock = "开锁";
FLOLIB_POSITIONS.lock = "锁着";
FLOLIB_POSITIONS.auto = "自动";
FLOLIB_SHOWBORDERS = "显示疆界";
FLOLIB_LAYOUT = "格式";
FLOLIB_CONFIRM_RESET = "您真正地想要重新设置 '%s' 吗? 界面将被重新载入。";

end

-------------------------------------------------------------------------------
-- Traditional Chinese localization
-------------------------------------------------------------------------------

if (GetLocale() == "zhTW") then

FLOLIB_POSITION = "位置";
FLOLIB_POSITIONS = { unlock = "解除鎖定", lock = "鎖定位置", auto = "自動" };
FLOLIB_SHOWBORDERS = "顯示邊框";
FLOLIB_LAYOUT = "格式";
FLOLIB_CONFIRM_RESET = "您真正地想要重新設置 '%s' 嗎? 介面將會重新截入。";
FLOLIB_ACTIVATE_SPEC_1 = "啟用主要天賦配置";
FLOLIB_ACTIVATE_SPEC_2 = "啟用第二天賦配置"; 

end

end
