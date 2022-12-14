--[[
    This file is part of Decursive.

    Decursive (v 2.7.8.12) add-on for World of Warcraft UI
    Copyright (C) 2006-2019 John Wellesz (Decursive AT 2072productions.com) ( http://www.2072productions.com/to/decursive.php )

    Decursive is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Decursive is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Decursive.  If not, see <https://www.gnu.org/licenses/>.


    Decursive is inspired from the original "Decursive v1.9.4" by Patrick Bohnet (Quu).
    The original "Decursive 1.9.4" is in public domain ( www.quutar.com )

    Decursive is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY.

    This file was last updated on 2019-11-18T13:42:00Z
--]]
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Brazilian Portuguese localization
-------------------------------------------------------------------------------

--[=[
--                      YOUR ATTENTION PLEASE
--
--         !!!!!!! TRANSLATORS TRANSLATORS TRANSLATORS !!!!!!!
--
--    Thank you very much for your interest in translating Decursive.
--    Do not edit those files. Use the localization interface available at the following address:
--
--      ################################################################
--      #  http://wow.curseforge.com/projects/decursive/localization/  #
--      ################################################################
--
--    Your translations made using this interface will be automatically included in the next release.
--
--]=]

local addonName, T = ...;
-- big ugly scary fatal error message display function {{{
if not T._FatalError then
-- the beautiful error popup : {{{ -
StaticPopupDialogs["DECURSIVE_ERROR_FRAME"] = {
    text = "|cFFFF0000Decursive Error:|r\n%s",
    button1 = "OK",
    OnAccept = function()
        return false;
    end,
    timeout = 0,
    whileDead = 1,
    hideOnEscape = 1,
    showAlert = 1,
    preferredIndex = 3,
    }; -- }}}
T._FatalError = function (TheError) StaticPopup_Show ("DECURSIVE_ERROR_FRAME", TheError); end
end
-- }}}
if not T._LoadedFiles or not T._LoadedFiles["enUS.lua"] then
    if not DecursiveInstallCorrupted then T._FatalError("Decursive installation is corrupted! (enUS.lua not loaded)"); end;
    DecursiveInstallCorrupted = true;
    return;
end

local L = LibStub("AceLocale-3.0"):NewLocale("Decursive", "ptBR");

if not L then
    T._LoadedFiles["ptBR.lua"] = "2.7.8.12";
    return;
end

L["ABOLISH_CHECK"] = "Verifique se h?? \"Abolir\" antes de curar"
L["ABOUT_AUTHOREMAIL"] = "E-MAIL DO AUTOR"
L["ABOUT_CREDITS"] = "CR??DITOS"
L["ABOUT_LICENSE"] = "LICEN??A"
L["ABOUT_NOTES"] = "Exibi????o de afli????es e limpeza para uso solo, em grupo e raides, com filtragem avan??ada e sistema de proriodades."
L["ABOUT_OFFICIALWEBSITE"] = "WEBSITE OFFICIAL"
L["ABOUT_SHAREDLIBS"] = "BIBLIOTECAS COMPARTILHADAS"
L["ABSENT"] = "Faltando (%s)"
L["AFFLICTEDBY"] = "%s Afligido"
L["ALT"] = "Alt"
L["AMOUNT_AFFLIC"] = "A quantidade afligida para exibir"
L["ANCHOR"] = "??ncora de texto do Decursive"
L["BINDING_NAME_DCRMUFSHOWHIDE"] = "Mostrar ou esconder os micro quadros de unidades."
L["BINDING_NAME_DCRPRADD"] = "Adicionar alvo na lista de prioridades"
L["BINDING_NAME_DCRPRCLEAR"] = "Limpar a lista de prioridades"
L["BINDING_NAME_DCRPRLIST"] = "Imprimir a lista de prioridades"
L["BINDING_NAME_DCRPRSHOW"] = "Mostrar ou esconder a lista de prioridade"
L["BINDING_NAME_DCRSHOW"] = [=[Mostrar ou esconder a Barra Principal do Decursive
(??ncora de lista ao vivo)]=]
L["BINDING_NAME_DCRSHOWOPTION"] = "Mostrar op????o de painel est??tico"
L["BINDING_NAME_DCRSKADD"] = "Adiciona alvo ?? lista de passe"
L["BINDING_NAME_DCRSKCLEAR"] = "Limpar a lista de passe"
L["BINDING_NAME_DCRSKLIST"] = "Mostrar a lista de passe"
L["BINDING_NAME_DCRSKSHOW"] = "Mostra ou oculta a lista de passe"
L["BLACK_LENGTH"] = "Segundos na lista negra"
L["BLACKLISTED"] = "Lista negra"
L["CHARM"] = "Encantar"
L["CLASS_HUNTER"] = "Ca??ador"
L["CLEAR_PRIO"] = "C"
L["CLEAR_SKIP"] = "C"
L["COLORALERT"] = "Definir o alerta de de cor quando um '%s' ?? necess??rio."
L["COLORCHRONOS"] = "Contador central"
L["COLORCHRONOS_DESC"] = "Define a cor do contador central"
L["COLORSTATUS"] = "Define a cor para o status '%s' no MQU."
L["CTRL"] = "Ctrl"
L["CURE_PETS"] = "Varrer e curar ajudantes"
L["CURSE"] = "Maldi????o"
L["DEBUG_REPORT_HEADER"] = "|cFF11FF33Por favor envie o conte??do desta janela por email para <%s>|r |cFF009999(Use CTRL+A para selecionar tudo e ent??o CTRL+C para por o texto na sua ??rea de transfer??ncia)|r Tamb??m explique no seu relat??rio se voc?? encontrou algum comportamento estranho no %s."
L["DECURSIVE_DEBUG_REPORT"] = "**** |cFFFF0000Relat??rio de Depura????o do Decursive|r ****"
L["DECURSIVE_DEBUG_REPORT_BUT_NEW_VERSION"] = "|cFF11FF33O Decursive travou, mas n??o se apavore! Uma NOVA vers??o do Decursive foi detectada (%s). Voc?? s?? precisa atualizar. V?? para curse.com e pesquise por 'Decursive' ou use o aplicativo do Curse, ele ir?? atualizar todos os seus add-ons de modo autom??tico.|r |cFFFF1133Ent??o n??o perca seu tempo relatando esse bug pois ele provavelmente j?? foi corrigido. Simplismente atualize o Decursive para resolver esse problema!|r |cFF11FF33Obrigado por ler esta mensagem!|r"
L["DECURSIVE_DEBUG_REPORT_NOTIFY"] = "Um relat??rio de depura????o est?? dispon??vel! Digite |cFFFF0000/DCRREPORT|r para visualizar."
L["DECURSIVE_DEBUG_REPORT_SHOW"] = "Relat??rio de depura????o dispon??vel!"
L["DECURSIVE_DEBUG_REPORT_SHOW_DESC"] = "Exibe um relat??rio de depura????o que o autor precisa ver..."
L["DEFAULT_MACROKEY"] = "`"
L["DEV_VERSION_ALERT"] = "Voc?? est?? usando uma vers??o de desenvolvimento do Decursive. Se voc?? n??o deseja participar do teste de novas funcionalidade/corre????es, receber relat??rios de depura????o em jogo, relatar problemas ao autor ent??o N??O USE ESTA VERS??O e baixe a vers??o EST??VEL mais recente em curse.com ou wowace.com. Esta mensagem ser?? exibida somente uma vez por vers??o"
L["DEV_VERSION_EXPIRED"] = "Esta vers??o de desenvolvimento do Decursive expirou. Voc?? deve baixar a vers??o de desenvolvimento mais recente ou voltar para o lan??amento est??vel atual, dispon??vel em CURSE.COM ou WOWACE.COM. Este aviso ser?? exibido a cada dois dias."
L["DEWDROPISGONE"] = "N??o h?? um equivalente a DewDrop para Ace3. Pressione Alt-Clique-Direito para abrir o painel de op????es."
L["DISABLEWARNING"] = "Decursive foi desabilitado! Para habilitar novamente, digite |cFFFFAA44/DCR ENABLE|r"
L["DISEASE"] = "Doen??a"
L["DONOT_BL_PRIO"] = "N??o excluir nomes na lista de prioriade"
L["DONT_SHOOT_THE_MESSENGER"] = "Decursive est?? somente relatando o problema. Ent??o, n??o culpe o mensageiro e resolva o problema real."
L["FAILEDCAST"] = "|cFF22FFFF%s %s|r |cFFAA0000falhou em|r %s |cFF00AAAA%s|r"
L["FOCUSUNIT"] = "Unidade Foco"
L["FUBARMENU"] = "Menu FuBar"
L["FUBARMENU_DESC"] = "Define as op????es relacionadas ao ??cone FuBar"
L["GLOR1"] = "Em memoria de Glorfindal"
L["GLOR2"] = "Decursive ?? dedicado a memoria de Bertrand que n??s deixou muito cedo. Ele sempre ser?? lembrado."
L["GLOR3"] = "Em mem??ria de Bertrand Sense 1969 - 2007"
L["GLOR4"] = "Amizade e afeto podem extender suas ra??zes a qualquer lugar. Aqueles que conheceram Glorfindal em World of Warcraft conheceram um home de grande compromisso e um l??der carism??tico. Ele foi em vida como foi em jogo, altru??sta, generoso, dedicado aos amigos e acima de tudo, um homem apaixonado. Ele nos deixou aos 38 anos, deixando para tr??s n??o apenas jogadores an??nimos em um mundo virtual, mas um grupo de amigos verdadeiros que sentir??o sua falta para sempre."
L["GLOR5"] = "Ele sempre ser?? lembrado..."
L["HANDLEHELP"] = "Arrastar todos os Micro Quadro de Unidades (MQU)"
L["HIDE_MAIN"] = "Esconder Janela do Decursive"
L["HIDESHOW_BUTTONS"] = "Ocultar/Mostrar bot??es e bloquear/desbloquear a barra \"Decursive\""
L["HLP_LEFTCLICK"] = "Clique-Esquerdo"
L["HLP_LL_ONCLICK_TEXT"] = "A Lista Ao Vivo n??o deve ser clicada. Por favor, leia a documenta????o para saber como usar este add-on. Basta pesquisar por 'Decursive' em WoWAce.com (Para mover esta lista, mova a barra do Decursive, /dcrshow e alt-clique-esquedo para mover)"
L["HLP_MIDDLECLICK"] = "Clique-Meio"
L["HLP_MOUSE4"] = "Mouse Bot??o 4"
L["HLP_MOUSE5"] = "Mouse Bot??o 5"
L["HLP_NOTHINGTOCURE"] = "N??o h?? nada a ser curado!"
L["HLP_RIGHTCLICK"] = "Clique-Direito"
L["HLP_USEXBUTTONTOCURE"] = "Use \"%s\" para curar essa afli????o!"
L["HLP_WRONGMBUTTON"] = "Bot??o do mouse errado!"
L["IGNORE_STEALTH"] = "Ignorar unidades em modo furtivo"
L["IS_HERE_MSG"] = "Decursive foi inicializado, lembre-se de conferir as op????es (/decursive)"
L["LIST_ENTRY_ACTIONS"] = "|cFF33AA33[CTRL]|r-Clique: Remover este jogador Clique-|cFF33AA33ESQUERDO|r: Subir jogador Clique-|cFF33AA33DIREITO|r: Descer jogador |cFF33AA33[SHIFT]|r Clique-|cFF33AA33ESQUERDO|r: Elevar jogador ao topo |cFF33AA33[SHIFT]|r Clique-|cFF33AA33DIREITO|r: Descer jogado ao fim"
L["MACROKEYALREADYMAPPED"] = [=[AVISO: A tecla mapeada para a macro do Decursive [%s] foi mapeada para a a????o '%s'.
Decursive ir?? restaurar o mapeamento anterior se voc?? definir outra tecla para sua macro.]=]
L["MACROKEYMAPPINGFAILED"] = "A tecla [%s] n??o p??de ser mapeada para a macro do Decursive!"
L["MACROKEYMAPPINGSUCCESS"] = "A tecla [%s] foi mapeada com sucesso para a macro do Decursive."
L["MACROKEYNOTMAPPED"] = "Macro de mouse-over do Decursive n??o est?? mapeado para uma tecla, verifique as op????es de 'Macro'!"
L["MAGIC"] = "M??gica"
L["MAGICCHARMED"] = "Encanto M??gico"
L["MISSINGUNIT"] = "Unidade ausente"
L["NEW_VERSION_ALERT"] = "Uma nova vers??o do Decursive foi detectada: |cFFEE7722%q|r lan??ada em |cFFEE7722%s|r! V?? para |cFFFF0000WoWAce.com|r para obt??-la! --------"
L["NORMAL"] = "Normal"
L["NOSPELL"] = "Nenhum feiti??o dispon??vel"
L["NOTICE_FRAME_TEMPLATE"] = "|cFFFF0000Decursive - Aviso|r %s"
L["OPT_ABOLISHCHECK_DESC"] = "seleciona se as unidades com um feiti??o 'Abolir' ativo s??o mostradas e curadas"
L["OPT_ABOUT"] = "Sobre"
L["OPT_ADD_A_CUSTOM_SPELL"] = "Adicionar feiti??o/item personalizado"
L["OPT_ADD_A_CUSTOM_SPELL_DESC"] = "Arraste e solte um feiti??o ou item us??vel aqui. Voc?? tamb??m pode escrever seu nome diretamente, seu ID num??rico ou usar shift-clique."
L["OPT_ADDDEBUFF"] = "Adicionar afli????o personalizada"
L["OPT_ADDDEBUFF_DESC"] = "Adiciona uma nova afli????o a esta lista"
L["OPT_ADDDEBUFF_USAGE"] = "<ID de feiti??o de afli????o> (voc?? pode encontrar ID de feiti??os em URLs do WoWHead.com)"
L["OPT_ADDDEBUFFFHIST"] = "Adicionar uma afli????o dissipada recentemente"
L["OPT_ADDDEBUFFFHIST_DESC"] = "Adicionar uma afli????o usando o hist??rico de afli????es dissipadas por voc?? recentemente"
L["OPT_ADVDISP"] = "Op????es de exibi????o Avan??adas"
L["OPT_ADVDISP_DESC"] = "Permite definir Transpar??ncia da borda e do centro de maneira separada, para definir o espa??o entre cada MQU"
L["OPT_AFFLICTEDBYSKIPPED"] = "%s afligido por %s ser?? ignorado"
L["OPT_ALLOWMACROEDIT"] = "Permitir edi????o de macro"
L["OPT_ALLOWMACROEDIT_DESC"] = "Habilite isto para previnir o Decursive de atualizar sua macro, deixando que voc?? a edite da maneira que quiser."
L["OPT_ALWAYSIGNORE"] = "Sempre ignorar quando fora de combate"
L["OPT_ALWAYSIGNORE_DESC"] = "Se marcada, esta afli????o tamb??m ser?? ignorada quando voc?? estiver fora de combate"
L["OPT_AMOUNT_AFFLIC_DESC"] = "Define o n??mero m??ximo de amaldi??oados para exibir na lista ao vivo"
L["OPT_ANCHOR_DESC"] = "Mostra a ??ncora do quadro de mensagem personalizada"
L["OPT_AUTOHIDEMFS"] = "Ocultar MQUs quando:"
L["OPT_AUTOHIDEMFS_DESC"] = "Escolha quando ocultar a janela de MQUs automaticamente."
L["OPT_BLACKLENTGH_DESC"] = "Define quanto tempo algu??m permanece na lista negra"
L["OPT_BORDERTRANSP"] = "Transpar??ncia da borda"
L["OPT_BORDERTRANSP_DESC"] = "Define a transpar??ncia da borda"
L["OPT_CENTERTEXT"] = "Contador central:"
L["OPT_CENTERTEXT_DESC"] = "Exibe informa????es sobre a afli????o superior (de acordo com suas prioridades) no centro de cada MQU. Escolha: - Tempo restante antes da expira????o natural - Tempo decorrido desde a ocorr??ncia da afli????o - N??mero de cargas"
L["OPT_CENTERTEXT_DISABLED"] = "Desabilitado"
L["OPT_CENTERTEXT_ELAPSED"] = "Tempo decorrido"
L["OPT_CENTERTEXT_STACKS"] = "N??mero de cargas"
L["OPT_CENTERTEXT_TIMELEFT"] = "Tempo restante"
L["OPT_CENTERTRANSP"] = "Transpar??ncia do centro"
L["OPT_CENTERTRANSP_DESC"] = "Define a transpar??ncia do centro"
L["OPT_CHARMEDCHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e lidar com unidades encantadas"
L["OPT_CHATFRAME_DESC"] = "As mensagens do Decursive ser??o impressas no quadro de bate-papo padr??o"
L["OPT_CHECKOTHERPLAYERS"] = "Verificar outros jogadores"
L["OPT_CHECKOTHERPLAYERS_DESC"] = "Exibe a vers??o do Decursive entre os jogadores em seu grupo atual ou guilda (n??o pode exibir vers??es anteriores ao Decursive 2.4.6)."
L["OPT_CMD_DISBLED"] = "Desativado"
L["OPT_CMD_ENABLED"] = "Ativado"
L["OPT_CREATE_VIRTUAL_DEBUFF"] = "Criar uma afli????o de teste virtual"
L["OPT_CREATE_VIRTUAL_DEBUFF_DESC"] = "Permite que voc?? veja a apar??ncia do Decursive quando uma afli????o ?? encontrada."
L["OPT_CURE_PRIORITY_NUM"] = "Prioridade #%d"
L["OPT_CUREPETS_DESC"] = "Ajudantes ser??o gerenciados e curados"
L["OPT_CURINGOPTIONS"] = "Op????es de Cura"
L["OPT_CURINGOPTIONS_DESC"] = "Op????es de cura, incluindo op????es para alterar a prioridade para cada tipo de afli????o"
L["OPT_CURINGOPTIONS_EXPLANATION"] = "Selecione os tipos de afli????o que deseja curar, os tipos n??o marcados ser??o completamente ignorados pelo Decursive. Os n??meros verdes representam a prioridade associada a cada tipo de afli????o. Esta prioridade determina as seguintes op????es: - Qual tipo de afli????o o Decursive mostra primeiro se um jogador tem v??rios tipos de afli????es. - A cor e a teclas associadas a cada tipo de afli????o. (Para alterar as prioridades, desmarque todas as caixas de sele????o e marque-as na ordem da prioridade desejada.)"
L["OPT_CURINGORDEROPTIONS"] = "Tipos de afli????o e prioridades"
L["OPT_CURSECHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e curar unidades amaldi??oadas"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING"] = "Permitir edi????o de macro interna para o feiti??o acima"
L["OPT_CUSTOM_SPELL_ALLOW_EDITING_DESC"] = "Marque isto se quiser editar a macro interna que o Decursive usar?? para o feiti??o personalizado que est?? sendo adicionado. Nota: Marcar isto permite que voc?? modifique os feiti??os gerenciados pelo Decursive. Se um feiti??o j?? estiver listado, voc?? precisar?? remov??-lo primeiro para habilitar a edi????o de macro. (--- Apenas para usu??rios avan??ados ---)"
L["OPT_CUSTOM_SPELL_CURE_TYPES"] = "Tipos de afli????o"
L["OPT_CUSTOM_SPELL_IS_DEFAULT"] = "Este feiti??o faz parte da configura????o autom??tica do Decursive. Se este feiti??o n??o estiver mais funcionando corretamente, voc?? pode remov??-lo ou desativ??-lo para recuperar o comportamento Decursivo padr??o."
L["OPT_CUSTOM_SPELL_ISPET"] = "Habilidade de ajudante"
L["OPT_CUSTOM_SPELL_ISPET_DESC"] = "Marque esta op????o se esta ?? uma habilidade que pertence a um de seus ajudantes para o Decursive pode detectar e lan????-la corretamente."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_NOMINAL_SPELL"] = "Aviso: O feiti??o %q n??o est?? presente em sua macro, as informa????es de alcance e recarga n??o corresponder??o..."
L["OPT_CUSTOM_SPELL_MACRO_MISSING_UNITID_KEYWORD"] = "Falta a palavra-chave UNITID."
L["OPT_CUSTOM_SPELL_MACRO_TEXT"] = "Texto da macro:"
L["OPT_CUSTOM_SPELL_MACRO_TEXT_DESC"] = "Editar o texto da macro padr??o. |cFFFF0000Somente 2 restri????es:|r - Voc?? deve especificar o destino utilizando a palavra-chave UNITID que ser?? automaticamente substitu??da pelo ID da unidade de cada MQU. - Qualquer que seja o feiti??o usado na macro, o Decursive continuar?? usando o nome original exibido ?? esquerda para alcance e exibi????o/rastreamento de recarga. (tenha isso em mente se voc?? planeja usar feiti??os diferentes com condicionais)"
L["OPT_CUSTOM_SPELL_MACRO_TOO_LONG"] = "Sua macro ?? muito longa, voc?? precisa remover %d caracteres."
L["OPT_CUSTOM_SPELL_PRIORITY"] = "Prioridade de feiti??os"
L["OPT_CUSTOM_SPELL_PRIORITY_DESC"] = "Quando v??rios feiti??os podem curar os mesmos tipos de afli????o, aqueles com uma prioridade mais alta ser??o preferidos. Observe que as habilidades padr??o gerenciadas pelo Decursive t??m uma prioridade que varia de 0 a 9. Portanto, se voc?? der ao seu feiti??o personalizado uma prioridade negativa, ela s?? ser?? escolhida se a habilidade padr??o n??o estiver dispon??vel."
L["OPT_CUSTOM_SPELL_UNAVAILABLE"] = "indispon??vel"
L["OPT_CUSTOM_SPELL_UNIT_FILTER"] = "Filtragem de Unidades"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_DESC"] = "Selecione as unidades que podem se beneficiar deste feiti??o"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONE"] = "Todas as unidades"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_NONPLAYER"] = "Somente outros"
L["OPT_CUSTOM_SPELL_UNIT_FILTER_PLAYER"] = "Somente jogador"
L["OPT_CUSTOMSPELLS"] = "Feiti??os/itens personalizados"
L["OPT_CUSTOMSPELLS_DESC"] = "Aqui voc?? pode adicionar feiti??os para estender a configura????o autom??tica do Decursive. Seus feiti??os personalizados sempre t??m uma prioridade mais alta e ir??o sobrepor e substituir os feiti??os padr??o (se e somente se o seu personagem puder usar esses feiti??os)."
L["OPT_CUSTOMSPELLS_EFFECTIVE_ASSIGNMENTS"] = "Atribui????es feiti??os eficazes:"
L["OPT_DEBCHECKEDBYDEF"] = "Marcado por padr??o"
L["OPT_DEBUFFENTRY_DESC"] = "Selecione qual classe deve ser ignorada em combate quando afligida por esta afli????o"
L["OPT_DEBUFFFILTER"] = "Filtragem de Afli????o"
L["OPT_DEBUFFFILTER_DESC"] = "Selecione afli????es para excluir por nome e classe enquanto voc?? est?? em combate"
L["OPT_DELETE_A_CUSTOM_SPELL"] = "Remover"
L["OPT_DISABLEABOLISH"] = "N??o use feiti??os 'Abolir'"
L["OPT_DISABLEABOLISH_DESC"] = "Se habilitado, o Decursive preferir?? 'Curar Doen??a' e 'Curar Veneno' em vez de seu equivalente 'Abolir'."
L["OPT_DISABLEMACROCREATION"] = "Desativar cria????o de macro"
L["OPT_DISABLEMACROCREATION_DESC"] = "A macro do Descursive n??o ser?? mais criada ou mantida"
L["OPT_DISEASECHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e curar unidades afligidas por doen??as"
L["OPT_DISPLAYOPTIONS"] = "Op????es de exibi????o"
L["OPT_DONOTBLPRIO_DESC"] = "Unidades priorizadas n??o ser??o colocadas na lista negra"
L["OPT_ENABLE_A_CUSTOM_SPELL"] = "Ativar"
L["OPT_ENABLE_LIVELIST"] = "Ativar lista ao vivo"
L["OPT_ENABLE_LIVELIST_DESC"] = "Exibe uma lista informativa de pessoas afligidas. Voc?? pode mover esta lista movendo a barra do Decursive (digite /DCRSHOW para exibir essa barra)."
L["OPT_ENABLEDEBUG"] = "Habilitar Depura????o"
L["OPT_ENABLEDEBUG_DESC"] = "Habilitar sa??da de depura????o"
L["OPT_ENABLEDECURSIVE"] = "Habilitar Decursive"
L["OPT_FILTERED_DEBUFF_RENAMED"] = "Afli????o filtrada \"%s\" renomeada automaticamente para \"%s\" para ID de feiti??o %d"
L["OPT_FILTEROUTCLASSES_FOR_X"] = "%q ser?? ignorado nas classes especificadas enquanto voc?? est?? em combate."
L["OPT_GENERAL"] = "Op????es gerais"
L["OPT_GROWDIRECTION"] = "Exibi????o reversa de MQUs"
L["OPT_GROWDIRECTION_DESC"] = "Os MQUs ser??o exibidos de baixo para cima"
L["OPT_HIDEMFS_GROUP"] = "em modo solo ou em grupo"
L["OPT_HIDEMFS_GROUP_DESC"] = "Ocultar a janela do MQU quando voc?? n??o estiver em uma raide."
L["OPT_HIDEMFS_NEVER"] = "Nunca ocultar automaticamente"
L["OPT_HIDEMFS_NEVER_DESC"] = "Nunca ocultar automaticamente a janela dos MQUs."
L["OPT_HIDEMFS_SOLO"] = "em modo solo"
L["OPT_HIDEMFS_SOLO_DESC"] = "Ocultar a janela dos MQUs quando voc?? n??o fizer parte de nenhum tipo de grupo."
L["OPT_HIDEMUFSHANDLE"] = "Ocultar a al??a dos MQU"
L["OPT_HIDEMUFSHANDLE_DESC"] = "Oculta a al??a dos Micro Quadros de Unidade e desativa a possibilidade de mov??-los. Use o mesmo comando para recuper??-la."
L["OPT_IGNORESTEALTHED_DESC"] = "Unidades camufladas ser??o ignoradas"
L["OPT_INPUT_SPELL_BAD_INPUT_ALREADY_HERE"] = "Feiti??o j?? listado!"
L["OPT_INPUT_SPELL_BAD_INPUT_DEFAULT_SPELL"] = "Decursive j?? gerencia este feiti??o. Shift-clique no feiti??o ou digite seu ID para adicionar uma classifica????o especial."
L["OPT_INPUT_SPELL_BAD_INPUT_ID"] = "ID de feiti??o inv??lido!"
L["OPT_INPUT_SPELL_BAD_INPUT_NOT_SPELL"] = "Feiti??o n??o encontrado no seu livro de feiti??os!"
L["OPT_ISNOTVALID_SPELLID"] = "n??o ?? um ID de feiti??o v??lido"
L["OPT_LIVELIST"] = "Lista ao vivo"
L["OPT_LIVELIST_DESC"] = "Estas s??o as configura????es relativas ?? lista de unidades afligidas exibida abaixo da barra \"Decursive\". Para mover esta lista, voc?? precisa mover o pequeno quadro \"Decursive\". Algumas das configura????es abaixo est??o dispon??veis apenas quando este quadro ?? exibido. Voc?? pode exibi-lo digitando |cff20CC20/DCRSHOW|r na janela de bate-papo. Depois de definir a posi????o, escala e transpar??ncia da lista ao vivo, voc?? pode ocultar com seguran??a o quadro do Decursive digitando |cff20CC20/DCRHIDE|r."
L["OPT_LLALPHA"] = "Transpar??ncia da lista ao vivo"
L["OPT_LLALPHA_DESC"] = "Altera a barra principal descursiva e a transpar??ncia da lista ao vivo (a barra principal deve ser exibida)"
L["OPT_LLSCALE"] = "Escala da Lista ao vivo"
L["OPT_LLSCALE_DESC"] = "Define o tamanho da barra principal do Decursive e da lista ao vivo (a barra principal deve ser exibida)"
L["OPT_LVONLYINRANGE"] = "Unidades em alcance apenas"
L["OPT_LVONLYINRANGE_DESC"] = "Apenas unidades em alcance de dissipa????o ser??o mostradas na lista ao vivo"
L["OPT_MACROBIND"] = "Define o v??nculo de tecla da macro"
L["OPT_MACROBIND_DESC"] = "Define a tecla na qual a macro 'Decursive' ser?? chamada. Pressione a tecla e pressione a tecla 'Enter' do teclado para salvar a nova atribui????o (com o cursor do mouse sobre o campo de edi????o)"
L["OPT_MACROOPTIONS"] = "Op????es de macro"
L["OPT_MACROOPTIONS_DESC"] = "Define o comportamento da macro 'mouseover' criada pelo Decursive"
L["OPT_MAGICCHARMEDCHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e curar unidades encantadas por magia"
L["OPT_MAGICCHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e curar unidades afligidas por magia"
L["OPT_MAXMFS"] = "Unidades m??ximas mostradas"
L["OPT_MAXMFS_DESC"] = "Define o n??mero m??ximo de micro quadros de unidade para exibir"
L["OPT_MESSAGES"] = "Mensagens"
L["OPT_MESSAGES_DESC"] = "O????es de exibi????o de mensagens"
L["OPT_MFALPHA"] = "Transpar??ncia"
L["OPT_MFALPHA_DESC"] = "Define a transpar??ncia dos MQU quando as unidades n??o est??o afligidas"
L["OPT_MFPERFOPT"] = "Op????es de performance"
L["OPT_MFREFRESHRATE"] = "Taxa de atualiza????o"
L["OPT_MFREFRESHRATE_DESC"] = "Tempo entre cada chamada de atualiza????o (1 ou v??rios micro quadros de unidade podem ser atualizadas de uma vez)"
L["OPT_MFREFRESHSPEED"] = "Velocidade de atualiza????o"
L["OPT_MFREFRESHSPEED_DESC"] = "N??mero de micro quadros de unidade para atualizar em uma ??nica passagem"
L["OPT_MFSCALE"] = "Escala dos micro quadros de unidade"
L["OPT_MFSCALE_DESC"] = "Define o tamanho dos micro quadros de unidade"
L["OPT_MFSETTINGS"] = "Op????es de Micro Quadros de Unidade"
L["OPT_MFSETTINGS_DESC"] = "Define v??rias op????es de exibi????o relacionadas ?? prioridade de tipo afli????es e MQU"
L["OPT_MUFFOCUSBUTTON"] = "Bot??o de foco:"
L["OPT_MUFHANDLE_HINT"] = "Para mover os micro-quadros de unidade: ALT-clique na al??a invis??vel localizada acima do primeiro micro-quadro de unidade."
L["OPT_MUFMOUSEBUTTONS"] = "V??nculos de mouse"
L["OPT_MUFMOUSEBUTTONS_DESC"] = "Altere as teclas usadas para curar, definir alvo ou focar membros do grupo por meio dos MQU. Cada n??mero de prioridade representa um tipo de afli????o diferente, conforme especificado no painel '|cFFFF5533Op????es de Cura|r'. O feiti??o usado para cada tipo de afli????o ?? definido por padr??o, mas pode ser alterado no painel '|cFF00DDDDFeiti??os personalizados|r'."
L["OPT_MUFSCOLORS"] = "Cores"
L["OPT_MUFSCOLORS_DESC"] = "Op????es para alterar a cor para a prioridade de cada tipo de afli????o e v??rios status de MQU. Cada prioridade representa um tipo de afli????o diferente, conforme especificado no painel '|cFFFF5533Op????es de Cura|r'."
L["OPT_MUFSVERTICALDISPLAY"] = "Exibi????o vertical"
L["OPT_MUFSVERTICALDISPLAY_DESC"] = "Janela de MQUs crescer?? verticalmente"
L["OPT_MUFTARGETBUTTON"] = "Bot??o de alvo:"
L["OPT_NEWVERSIONBUGMENOT"] = "Alertas de nova vers??o"
L["OPT_NEWVERSIONBUGMENOT_DESC"] = "Se uma vers??o mais recente do Decursive for detectada, um alerta pop-up ser?? exibido uma vez a cada sete dias."
L["OPT_NOKEYWARN"] = "Alertar falta de tecla"
L["OPT_NOKEYWARN_DESC"] = "Exibir um alerta se nenhuma tecla estiver mapeada"
L["OPT_NOSTARTMESSAGES"] = "Desativar mensagens de iniciar"
L["OPT_NOSTARTMESSAGES_DESC"] = "Remover as duas mensagens que o Decursive exibe no quadro de bate-papo a cada login."
L["OPT_OPTIONS_DISABLED_WHILE_IN_COMBAT"] = "Essas op????es est??o desativadas enquanto voc?? est?? em combate."
L["OPT_PERFOPTIONWARNING"] = "AVISO: N??o altere esses valores a menos que saiba exatamente o que est?? fazendo. Essas configura????es podem ter um grande impacto no desempenho do jogo. A maioria dos usu??rios deve usar os valores padr??o de 0,1 e 10."
L["OPT_PLAYSOUND_DESC"] = "Tocar um som se algu??m for amaldi??oado"
L["OPT_POISONCHECK_DESC"] = "Se marcado, voc?? ser?? capaz de ver e curar unidades envenenadas"
L["OPT_PRINT_CUSTOM_DESC"] = "As mensagens do Decursive ser??o impressas em um quadro de bate-papo personalizado"
L["OPT_PRINT_ERRORS_DESC"] = "Erros ser??o exibidos"
L["OPT_PROFILERESET"] = "Redefinir perfil..."
L["OPT_RANDOMORDER_DESC"] = "As unidades ser??o exibidas e curadas aleatoriamente (n??o recomendado)"
L["OPT_READDDEFAULTSD"] = "Re-adicionar as afli????es padr??o"
L["OPT_READDDEFAULTSD_DESC1"] = "Adicionar as afli????es padr??o do Decursive ausentes a esta lista. Suas configura????es n??o ser??o alteradas"
L["OPT_READDDEFAULTSD_DESC2"] = "Todas as afli????es padr??o do Decursive est??o nesta lista"
L["OPT_REMOVESKDEBCONF"] = "Tem certeza de que deseja remover '%s' da lista de afli????es ignoradas do Decursive?"
L["OPT_REMOVETHISDEBUFF"] = "Remover esta afli????o"
L["OPT_REMOVETHISDEBUFF_DESC"] = "Remove '%s' da lista de passe"
L["OPT_RESETDEBUFF"] = "Redefinir esta afli????o"
L["OPT_RESETDTDCRDEFAULT"] = "Redefine '%s' para o padr??o do Decursive"
L["OPT_RESETMUFMOUSEBUTTONS"] = "Redefinir"
L["OPT_RESETMUFMOUSEBUTTONS_DESC"] = "Redefinir v??nculos de bot??o do mouse para o padr??o."
L["OPT_RESETOPTIONS"] = "Redefinir op????es para o padr??o"
L["OPT_RESETOPTIONS_DESC"] = "Redefinir o perfil atual para os valores padr??o"
L["OPT_RESTPROFILECONF"] = "Tem certeza de que deseja redefinir o perfil '(%s) %s' para as op????es padr??o?"
L["OPT_REVERSE_LIVELIST_DESC"] = "A lista ao vivo preenche-se de baixo para cima"
L["OPT_SCANLENGTH_DESC"] = "Define o tempo entre cada varredura"
L["OPT_SETAFFTYPECOLOR_DESC"] = "Define a cor do tipo de afli????o \"%s\". (Aparece principalmente nas tootips dos MQU e na lista ao vivo)"
L["OPT_SHOW_STEALTH_STATUS"] = "Mostrar status de furtividade"
L["OPT_SHOW_STEALTH_STATUS_DESC"] = "Quando um jogador est?? furtivo, seu MQU ter?? uma cor especial"
L["OPT_SHOWBORDER"] = "Mostrar bordas coloridas de acordo com a classe"
L["OPT_SHOWBORDER_DESC"] = "Uma borda colorida ser?? exibida ao redor dos MQU representando a classe da unidade"
L["OPT_SHOWHELP"] = "Mostrar Ajuda"
L["OPT_SHOWHELP_DESC"] = "Mostra uma tooltip detalhada quando voc?? passa o mouse sobre um micro-quadro de unidade"
L["OPT_SHOWMFS"] = "Mostrar os Micro-Quadros de Unidade"
L["OPT_SHOWMFS_DESC"] = "Isso deve ser habilitado se voc?? deseja curar clicando"
L["OPT_SHOWMINIMAPICON"] = "??cone do minimapa"
L["OPT_SHOWMINIMAPICON_DESC"] = "Alterna o ??cone do minimapa."
L["OPT_SHOWTOOLTIP_DESC"] = "Mostra dicas detalhadas sobre maldi????es na lista ao vivo e nos MQU"
L["OPT_SPELL_DESCRIPTION_LOADING"] = "Descri????o est?? carregando... volte mais tarde."
L["OPT_SPELL_DESCRIPTION_UNAVAILABLE"] = "descri????o indispon??vel"
L["OPT_SPELLID_MISSING_READD"] = "Voc?? precisa adicionar novamente esta afli????o usando seu Spell ID para ver uma descri????o adequada em vez desta mensagem."
L["OPT_STICKTORIGHT"] = "Alinhar janela de MQU ?? direita"
L["OPT_STICKTORIGHT_DESC"] = "A janela de MQU crescer?? da direita para a esquerda, a al??a ser?? movida conforme necess??rio."
L["OPT_TESTLAYOUT"] = "Testar Layout"
L["OPT_TESTLAYOUT_DESC"] = "Cria unidades falsas para que voc?? possa testar o layout da tela. (Aguarde alguns segundos ap??s clicar)"
L["OPT_TESTLAYOUTUNUM"] = "Quantidade de unidades"
L["OPT_TESTLAYOUTUNUM_DESC"] = "Define a quantidade de unidades falsas a serem criadas."
L["OPT_TIE_LIVELIST_DESC"] = "A exibi????o da lista ao vivo est?? ligada ?? exibi????o da barra \"Decursive\""
L["OPT_TIECENTERANDBORDER"] = "Vincular transpar??ncia da borda e centro"
L["OPT_TIECENTERANDBORDER_OPT"] = "A transpar??ncia da borda ?? metade da transpar??ncia do centro quando marcado"
L["OPT_TIEXYSPACING"] = "Vincular espa??amento horizontal e vertical"
L["OPT_TIEXYSPACING_DESC"] = "O espa??amento vertical e horizontal entre os MQU s??o o mesmo"
L["OPT_UNITPERLINES"] = "N??mero de unidades por linha"
L["OPT_UNITPERLINES_DESC"] = "Define o n??mero m??ximo de micro-quadros de unidade para exibir por linha"
L["OPT_USERDEBUFF"] = "Esta afli????o n??o faz parte das afli????es padr??o do Decursive"
L["OPT_XSPACING"] = "Espa??amento horizontal"
L["OPT_XSPACING_DESC"] = "Define o espa??amento Horizontal entre os MQU"
L["OPT_YSPACING"] = "Espa??amento vertical"
L["OPT_YSPACING_DESC"] = "Define o espa??amento Vertical entre os MQU"
L["OPTION_MENU"] = "Menu de Op????es do Decursive"
L["PLAY_SOUND"] = "Tocar um som quando houver algu??m para curar"
L["POISON"] = "Veneno"
L["POPULATE"] = "p"
L["POPULATE_LIST"] = "Popular rapidamente a lista do Decursive"
L["PRINT_CHATFRAME"] = "Imprimir mensagens no chat padr??o"
L["PRINT_CUSTOM"] = "Imprimir mensagens na janela"
L["PRINT_ERRORS"] = "Imprimir mensagens de erro"
L["PRIORITY_LIST"] = "Lista de Prioridades Decursive"
L["PRIORITY_SHOW"] = "P"
L["RANDOM_ORDER"] = "Curar em ordem aleat??ria"
L["REVERSE_LIVELIST"] = "Exibi????o reversa da lista ao vivo"
L["SCAN_LENGTH"] = "Segundos entre as varreduras ao vivo:"
L["SHIFT"] = "Shift"
L["SHOW_MSG"] = "Para amostrar a janela do Decursive, escreve /dcrshow"
L["SHOW_TOOLTIP"] = "Exibir tooltips em unidades aflitas"
L["SKIP_LIST_STR"] = "Lista de passe Decursive"
L["SKIP_SHOW"] = "S"
L["SPELL_FOUND"] = "%s feiti??o nao foi encontrado"
L["STEALTHED"] = "camuflado"
L["STR_CLOSE"] = "Fechar"
L["STR_DCR_PRIO"] = "Prioridade do Decursive"
L["STR_DCR_SKIP"] = "Pulo Decursive"
L["STR_GROUP"] = "Grupo"
L["STR_OPTIONS"] = "Op????es do Decursive"
L["STR_OTHER"] = "Outro"
L["STR_POP"] = "Popular Lista"
L["STR_QUICK_POP"] = "Popular Rapidamente"
L["SUCCESSCAST"] = "|cFF22FFFF%s %s|r |cFF00AA00funcionou em|r %s"
L["TARGETUNIT"] = "Unidade Alvo"
L["TIE_LIVELIST"] = "Vincular a visibilidade da lista ao vivo ?? janela do DCR"
L["TOC_VERSION_EXPIRED"] = "A vers??o do seu Decursive est?? desatualizada. Esta vers??o do Decursive foi lan??ada antes da vers??o do World of Warcraft que voc?? est?? usando. Voc?? precisa atualizar o Decursive para corrigir poss??veis incompatibilidades e erros de tempo de execu????o. V?? para curse.com e procure por 'Decursive' ou use o aplicativo do Curse para atualizar todos os seus add-ons de uma vez. Este aviso ser?? exibido novamente em 2 dias."
L["TOO_MANY_ERRORS_ALERT"] = "Existem muitos erros Lua em sua interface de usu??rio (%d erros). Sua experi??ncia de jogo pode ser prejudicada. Desabilite ou atualize os add-ons com falha para desligar esta mensagem. Voc?? pode querer ativar o relat??rio de erros Lua (/console scriptErrors 1)."
L["TOOFAR"] = "Muito longe"
L["UNITSTATUS"] = "Status da Unidade:"
L["UNSTABLERELEASE"] = "Vers??o inst??vel"



T._LoadedFiles["ptBR.lua"] = "2.7.8.12";

