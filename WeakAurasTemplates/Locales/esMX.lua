if not WeakAuras.IsLibsOK() then return end

if GetLocale() ~= "esMX" then
  return
end

local L = WeakAuras.L

-- WeakAuras/Templates
	L[" Debuff"] = "Perjuicio"
	L["<70% Mana"] = "<70% de maná"
	L[">70% Mana"] = ">70% de maná"
	L["Abilities"] = "Habilidades"
	L["Ability"] = "Habilidad"
	L["Add Triggers"] = "Agregar desencadenadores"
	L["Always Active"] = "Siempre activo"
	L["Always Show"] = "Siempre mostrar"
	L["Always show the aura, highlight it if debuffed."] = "Mostrar siempre el aura, resaltarla si hay perjuicios."
	L["Always show the aura, turns grey if on cooldown."] = "Siempre muestra el aura, se vuelve gris si está en tiempo de reutilización."
	L["Always show the aura, turns grey if the debuff not active."] = "Mostrar siempre el aura, se vuelve gris si el perjuicio no está activo."
	L["Always shows highlights if enchant missing."] = "Siempre se muestra resplandeciente si no hay encantamiento."
	--[[Translation missing --]]
	L["Always shows the aura, grey if buff not active."] = "Always shows the aura, grey if buff not active."
	--[[Translation missing --]]
	L["Always shows the aura, highlight it if buffed."] = "Always shows the aura, highlight it if buffed."
	L["Always shows the aura, highlight when active, turns blue on insufficient resources."] = "Muestra siempre el aura, la resalta si está activa, se vuelve azul si no hay suficientes recursos."
	--[[Translation missing --]]
	L["Always shows the aura, highlight while proc is active, blue on insufficient resources."] = "Always shows the aura, highlight while proc is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Always shows the aura, highlight while proc is active, blue when not usable."] = "Always shows the aura, highlight while proc is active, blue when not usable."
	--[[Translation missing --]]
	L["Always shows the aura, highlight while proc is active, turns red when out of range, blue on insufficient resources."] = "Always shows the aura, highlight while proc is active, turns red when out of range, blue on insufficient resources."
	--[[Translation missing --]]
	L["Always shows the aura, turns blue on insufficient resources."] = "Always shows the aura, turns blue on insufficient resources."
	--[[Translation missing --]]
	L["Always shows the aura, turns blue when not usable."] = "Always shows the aura, turns blue when not usable."
	--[[Translation missing --]]
	L["Always shows the aura, turns grey if on cooldown."] = "Always shows the aura, turns grey if on cooldown."
	--[[Translation missing --]]
	L["Always shows the aura, turns grey if the ability is not usable and red when out of range."] = "Always shows the aura, turns grey if the ability is not usable and red when out of range."
	--[[Translation missing --]]
	L["Always shows the aura, turns grey if the ability is not usable."] = "Always shows the aura, turns grey if the ability is not usable."
	--[[Translation missing --]]
	L["Always shows the aura, turns red when out of range, blue on insufficient resources."] = "Always shows the aura, turns red when out of range, blue on insufficient resources."
	--[[Translation missing --]]
	L["Always shows the aura, turns red when out of range."] = "Always shows the aura, turns red when out of range."
	--[[Translation missing --]]
	L["Always shows the aura."] = "Always shows the aura."
	L["Back"] = "Atrás"
	--[[Translation missing --]]
	L["Basic Show On Cooldown"] = "Basic Show On Cooldown"
	--[[Translation missing --]]
	L["Basic Show On Ready"] = "Basic Show On Ready"
	L["Bloodlust/Heroism"] = "Sed de sangre/Heroísmo"
	--[[Translation missing --]]
	L["Bonded Buff"] = "Bonded Buff"
	L["Buff"] = "Beneficio"
	L["buff"] = "beneficio"
	--[[Translation missing --]]
	L["Buff on Other"] = "Buff on Other"
	L["Buffs"] = "Beneficios"
	--[[Translation missing --]]
	L["Build Up"] = "Build Up"
	L["Cancel"] = "Cancelar"
	L["Cast"] = "Lanzar hechizo"
	--[[Translation missing --]]
	L["Charge and Buff Tracking"] = "Charge and Buff Tracking"
	--[[Translation missing --]]
	L["Charge and Debuff Tracking"] = "Charge and Debuff Tracking"
	--[[Translation missing --]]
	L["Charge and Duration Tracking"] = "Charge and Duration Tracking"
	--[[Translation missing --]]
	L["Charge Tracking"] = "Charge Tracking"
	--[[Translation missing --]]
	L["Combustion Ready"] = "Combustion Ready"
	--[[Translation missing --]]
	L["Conduits"] = "Conduits"
	L["Cooldown"] = "Reutilización"
	L["cooldown"] = "enfriamiento"
	--[[Translation missing --]]
	L["Cooldown Tracking"] = "Cooldown Tracking"
	--[[Translation missing --]]
	L["Create Auras"] = "Create Auras"
	L["Debuff"] = "Perjuicio"
	L["debuff"] = "Perjuicio"
	L["Debuffs"] = "Perjuicios"
	--[[Translation missing --]]
	L["Empowered Buff"] = "Empowered Buff"
	--[[Translation missing --]]
	L["Fire"] = "Fire"
	--[[Translation missing --]]
	L["Frost"] = "Frost"
	L["General"] = "General"
	L["Health"] = "Salud"
	--[[Translation missing --]]
	L["Highlight while action is queued."] = "Highlight while action is queued."
	--[[Translation missing --]]
	L["Highlight while active, red when out of range."] = "Highlight while active, red when out of range."
	--[[Translation missing --]]
	L["Highlight while active."] = "Highlight while active."
	--[[Translation missing --]]
	L["Highlight while buffed, red when out of range."] = "Highlight while buffed, red when out of range."
	--[[Translation missing --]]
	L["Highlight while buffed."] = "Highlight while buffed."
	--[[Translation missing --]]
	L["Highlight while debuffed, red when out of range."] = "Highlight while debuffed, red when out of range."
	--[[Translation missing --]]
	L["Highlight while debuffed."] = "Highlight while debuffed."
	--[[Translation missing --]]
	L["Highlight while spell is active."] = "Highlight while spell is active."
	--[[Translation missing --]]
	L["Hold CTRL to create multiple auras at once"] = "Hold CTRL to create multiple auras at once"
	--[[Translation missing --]]
	L["Initial Buff"] = "Initial Buff"
	L["Keeps existing triggers intact"] = "Desencadenadores intactos"
	--[[Translation missing --]]
	L["Legendaries"] = "Legendaries"
	--[[Translation missing --]]
	L["Meteor Ready"] = "Meteor Ready"
	--[[Translation missing --]]
	L["Nature"] = "Nature"
	--[[Translation missing --]]
	L["Next"] = "Next"
	--[[Translation missing --]]
	L["Only show the aura if the target has the debuff."] = "Only show the aura if the target has the debuff."
	--[[Translation missing --]]
	L["Only show the aura when the item is on cooldown."] = "Only show the aura when the item is on cooldown."
	--[[Translation missing --]]
	L["Only shows if the weapon is enchanted."] = "Only shows if the weapon is enchanted."
	--[[Translation missing --]]
	L["Only shows if the weapon is not enchanted."] = "Only shows if the weapon is not enchanted."
	--[[Translation missing --]]
	L["Only shows the aura if the target has the buff."] = "Only shows the aura if the target has the buff."
	--[[Translation missing --]]
	L["Only shows the aura when the ability is on cooldown."] = "Only shows the aura when the ability is on cooldown."
	--[[Translation missing --]]
	L["Only shows the aura when the ability is ready to use."] = "Only shows the aura when the ability is ready to use."
	--[[Translation missing --]]
	L["Other cooldown"] = "Other cooldown"
	L["Pet alive"] = "Mascota viva"
	L["Pet Behavior"] = "Comportamiento de la mascota"
	--[[Translation missing --]]
	L["Preparation"] = "Preparation"
	L["PvP Talents"] = "JcJ - Talentos"
	L["Replace all existing triggers"] = "Reemplazar todos los desencadenadores existentes"
	L["Replace Triggers"] = "Reemplazar desencadenadores"
	L["Resources"] = "Recursos"
	L["Resources and Shapeshift Form"] = "Recursos y cambios de forma"
	--[[Translation missing --]]
	L["Rogue cooldown"] = "Rogue cooldown"
	--[[Translation missing --]]
	L["Root"] = "Root"
	L["Runes"] = "Runas"
	L["Shapeshift Form"] = "Cambiar de forma"
	--[[Translation missing --]]
	L["Shards Of Domination"] = "Shards Of Domination"
	--[[Translation missing --]]
	L["Show Always, Glow on Missing"] = "Show Always, Glow on Missing"
	--[[Translation missing --]]
	L["Show Charges and Check Usable"] = "Show Charges and Check Usable"
	--[[Translation missing --]]
	L["Show Charges with Proc Tracking"] = "Show Charges with Proc Tracking"
	--[[Translation missing --]]
	L["Show Charges with Range Tracking"] = "Show Charges with Range Tracking"
	--[[Translation missing --]]
	L["Show Charges with Usable Check"] = "Show Charges with Usable Check"
	--[[Translation missing --]]
	L["Show Cooldown and Action Queued"] = "Show Cooldown and Action Queued"
	--[[Translation missing --]]
	L["Show Cooldown and Buff"] = "Show Cooldown and Buff"
	--[[Translation missing --]]
	L["Show Cooldown and Buff and Check for Target"] = "Show Cooldown and Buff and Check for Target"
	--[[Translation missing --]]
	L["Show Cooldown and Buff and Check Usable"] = "Show Cooldown and Buff and Check Usable"
	--[[Translation missing --]]
	L["Show Cooldown and Check for Target"] = "Show Cooldown and Check for Target"
	--[[Translation missing --]]
	L["Show Cooldown and Check for Target & Proc Tracking"] = "Show Cooldown and Check for Target & Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable"] = "Show Cooldown and Check Usable"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable & Target"] = "Show Cooldown and Check Usable & Target"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable, Proc Tracking"] = "Show Cooldown and Check Usable, Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Check Usable, Target & Proc Tracking"] = "Show Cooldown and Check Usable, Target & Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Debuff"] = "Show Cooldown and Debuff"
	--[[Translation missing --]]
	L["Show Cooldown and Debuff and Check for Target"] = "Show Cooldown and Debuff and Check for Target"
	--[[Translation missing --]]
	L["Show Cooldown and Duration"] = "Show Cooldown and Duration"
	--[[Translation missing --]]
	L["Show Cooldown and Duration and Check for Target"] = "Show Cooldown and Duration and Check for Target"
	--[[Translation missing --]]
	L["Show Cooldown and Duration and Check Usable"] = "Show Cooldown and Duration and Check Usable"
	--[[Translation missing --]]
	L["Show Cooldown and Proc Tracking"] = "Show Cooldown and Proc Tracking"
	--[[Translation missing --]]
	L["Show Cooldown and Totem Information"] = "Show Cooldown and Totem Information"
	--[[Translation missing --]]
	L["Show if Enchant Missing"] = "Show if Enchant Missing"
	--[[Translation missing --]]
	L["Show on Ready"] = "Show on Ready"
	--[[Translation missing --]]
	L["Show Only if Buffed"] = "Show Only if Buffed"
	--[[Translation missing --]]
	L["Show Only if Debuffed"] = "Show Only if Debuffed"
	--[[Translation missing --]]
	L["Show Only if Enchanted"] = "Show Only if Enchanted"
	--[[Translation missing --]]
	L["Show Only if on Cooldown"] = "Show Only if on Cooldown"
	--[[Translation missing --]]
	L["Show Totem and Charge Information"] = "Show Totem and Charge Information"
	--[[Translation missing --]]
	L["Slow"] = "Slow"
	--[[Translation missing --]]
	L["slow debuff"] = "slow debuff"
	--[[Translation missing --]]
	L["Sprint"] = "Sprint"
	--[[Translation missing --]]
	L["Stance"] = "Stance"
	--[[Translation missing --]]
	L["stun debuff"] = "stun debuff"
	--[[Translation missing --]]
	L["Stun Debuff"] = "Stun Debuff"
	--[[Translation missing --]]
	L["Totem"] = "Totem"
	--[[Translation missing --]]
	L["Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."] = "Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the buff, highlight while the buff is active, blue on insufficient resources."] = "Tracks the charge and the buff, highlight while the buff is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the debuff, highlight while the debuff is active, blue on insufficient resources."] = "Tracks the charge and the debuff, highlight while the debuff is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."] = "Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."
	L["Unknown Item"] = "Objeto desconocido"
	L["Unknown Spell"] = "Hechizo desconocido"
	--[[Translation missing --]]
	L["Warrior cooldown"] = "Warrior cooldown"

