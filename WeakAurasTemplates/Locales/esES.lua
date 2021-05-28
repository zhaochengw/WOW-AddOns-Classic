if not WeakAuras.IsCorrectVersion() then return end

if not(GetLocale() == "esES") then
  return
end

local L = WeakAuras.L

-- WeakAuras/Templates
	L[" Debuff"] = "Perjuicio"
	L["<70% Mana"] = "<70% de maná"
	L[">70% Mana"] = ">70% de maná"
	L["Abilities"] = "Habilidades"
	L["Ability"] = "Habilidad"
	L["Add Triggers"] = "Añadir disparadores"
	L["Always Active"] = "Siempre activo"
	L["Always Show"] = "Mostrar siempre"
	L["Always show the aura, highlight it if debuffed."] = "Mostrar siempre el aura, resaltarla si hay perjuicios."
	L["Always show the aura, turns grey if on cooldown."] = "Siempre muestra el aura, se vuelve gris si está en tiempo de reutilización."
	L["Always show the aura, turns grey if the debuff not active."] = "Mostrar siempre el aura, se vuelve gris si el perjuicio no está activo."
	L["Always shows highlights if enchant missing."] = "Siempre se muestra resplandeciente si no hay encantamiento."
	L["Always shows the aura, grey if buff not active."] = "Muestra siempre el aura, se vuelve gris si el beneficio no está activo."
	L["Always shows the aura, highlight it if buffed."] = "Muestra siempre el aura, la resalta si el beneficio está activo."
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
	--[[Translation missing --]]
	L["Back"] = "Back"
	--[[Translation missing --]]
	L["Basic Show On Cooldown"] = "Basic Show On Cooldown"
	--[[Translation missing --]]
	L["Basic Show On Ready"] = "Basic Show On Ready"
	--[[Translation missing --]]
	L["Bloodlust/Heroism"] = "Bloodlust/Heroism"
	--[[Translation missing --]]
	L["Bonded Buff"] = "Bonded Buff"
	--[[Translation missing --]]
	L["Buff"] = "Buff"
	L["buff"] = "beneficio"
	--[[Translation missing --]]
	L["Buff on Other"] = "Buff on Other"
	L["Buffs"] = "Beneficios"
	--[[Translation missing --]]
	L["Build Up"] = "Build Up"
	--[[Translation missing --]]
	L["Cancel"] = "Cancel"
	--[[Translation missing --]]
	L["Cast"] = "Cast"
	L["Charge and Buff Tracking"] = "Seguimiento de cargas y beneficios"
	L["Charge and Debuff Tracking"] = "Seguimiento de cargas y perjuicios"
	--[[Translation missing --]]
	L["Charge and Duration Tracking"] = "Charge and Duration Tracking"
	--[[Translation missing --]]
	L["Charge Tracking"] = "Charge Tracking"
	--[[Translation missing --]]
	L["Combustion Ready"] = "Combustion Ready"
	--[[Translation missing --]]
	L["Conduits"] = "Conduits"
	--[[Translation missing --]]
	L["Cooldown"] = "Cooldown"
	--[[Translation missing --]]
	L["cooldown"] = "cooldown"
	--[[Translation missing --]]
	L["Cooldown Tracking"] = "Cooldown Tracking"
	--[[Translation missing --]]
	L["Create Auras"] = "Create Auras"
	--[[Translation missing --]]
	L["Debuff"] = "Debuff"
	L["debuff"] = "perjuicio"
	L["Debuffs"] = "Perjuicios"
	--[[Translation missing --]]
	L["Empowered Buff"] = "Empowered Buff"
	--[[Translation missing --]]
	L["Fire"] = "Fire"
	--[[Translation missing --]]
	L["Frost"] = "Frost"
	--[[Translation missing --]]
	L["General"] = "General"
	--[[Translation missing --]]
	L["Health"] = "Health"
	--[[Translation missing --]]
	L["Highlight while action is queued."] = "Highlight while action is queued."
	--[[Translation missing --]]
	L["Highlight while active, red when out of range."] = "Highlight while active, red when out of range."
	--[[Translation missing --]]
	L["Highlight while active."] = "Highlight while active."
	L["Highlight while buffed, red when out of range."] = "Resaltar cuando hay beneficio activo, rojo cuando esté fuera de rango."
	L["Highlight while buffed."] = "Resaltar cuando hay beneficio activo."
	L["Highlight while debuffed, red when out of range."] = "Resaltar cuando hay perjuicio activo, rojo cuando esté fuera de rango."
	L["Highlight while debuffed."] = "Resaltar cuando hay perjuicio activo."
	--[[Translation missing --]]
	L["Highlight while spell is active."] = "Highlight while spell is active."
	--[[Translation missing --]]
	L["Hold CTRL to create multiple auras at once"] = "Hold CTRL to create multiple auras at once"
	--[[Translation missing --]]
	L["Keeps existing triggers intact"] = "Keeps existing triggers intact"
	--[[Translation missing --]]
	L["Legendaries"] = "Legendaries"
	--[[Translation missing --]]
	L["Meteor Ready"] = "Meteor Ready"
	--[[Translation missing --]]
	L["Nature"] = "Nature"
	--[[Translation missing --]]
	L["Next"] = "Next"
	L["Only show the aura if the target has the debuff."] = "Mostrar el aura solo si el objetivo tiene el perjuicio activo."
	--[[Translation missing --]]
	L["Only show the aura when the item is on cooldown."] = "Only show the aura when the item is on cooldown."
	--[[Translation missing --]]
	L["Only shows if the weapon is enchanted."] = "Only shows if the weapon is enchanted."
	--[[Translation missing --]]
	L["Only shows if the weapon is not enchanted."] = "Only shows if the weapon is not enchanted."
	L["Only shows the aura if the target has the buff."] = "Muestra el aura solo si el objetivo tiene el beneficio activo."
	--[[Translation missing --]]
	L["Only shows the aura when the ability is on cooldown."] = "Only shows the aura when the ability is on cooldown."
	--[[Translation missing --]]
	L["Only shows the aura when the ability is ready to use."] = "Only shows the aura when the ability is ready to use."
	--[[Translation missing --]]
	L["Other cooldown"] = "Other cooldown"
	L["Pet alive"] = "Mascota viva"
	L["Pet Behavior"] = "Comportamiento de mascota"
	--[[Translation missing --]]
	L["PvP Talents"] = "PvP Talents"
	--[[Translation missing --]]
	L["Replace all existing triggers"] = "Replace all existing triggers"
	--[[Translation missing --]]
	L["Replace Triggers"] = "Replace Triggers"
	--[[Translation missing --]]
	L["Resources"] = "Resources"
	--[[Translation missing --]]
	L["Resources and Shapeshift Form"] = "Resources and Shapeshift Form"
	--[[Translation missing --]]
	L["Rogue cooldown"] = "Rogue cooldown"
	--[[Translation missing --]]
	L["Runes"] = "Runes"
	--[[Translation missing --]]
	L["Shapeshift Form"] = "Shapeshift Form"
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
	L["Show Cooldown and Buff"] = "Mostrar tiempo de reutilización y beneficio"
	L["Show Cooldown and Buff and Check for Target"] = "Mostrar Tiempo de reutilización, Beneficio y Comprobar objetivo"
	L["Show Cooldown and Buff and Check Usable"] = "Mostrar Tiempo de reutilización, Beneficio y Comprobar utilizable"
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
	L["Show Cooldown and Debuff"] = "Mostrar Tiempo de reutilización y Perjuicio"
	L["Show Cooldown and Debuff and Check for Target"] = "Mostrar Tiempo de reutilización, Perjuicio y Comprobar objetivo"
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
	L["Show Only if Buffed"] = "Mostrar solo si hay Beneficio activo"
	L["Show Only if Debuffed"] = "Mostrar solo si hay Perjuicio activo"
	--[[Translation missing --]]
	L["Show Only if Enchanted"] = "Show Only if Enchanted"
	--[[Translation missing --]]
	L["Show Only if on Cooldown"] = "Show Only if on Cooldown"
	--[[Translation missing --]]
	L["Show Totem and Charge Information"] = "Show Totem and Charge Information"
	--[[Translation missing --]]
	L["Slow"] = "Slow"
	L["slow debuff"] = "Perjuicio de ralentización"
	--[[Translation missing --]]
	L["Stance"] = "Stance"
	L["stun debuff"] = "Perjuicio de aturdimiento"
	--[[Translation missing --]]
	L["Stun Debuff"] = "Stun Debuff"
	--[[Translation missing --]]
	L["Totem"] = "Totem"
	--[[Translation missing --]]
	L["Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."] = "Track the charge and proc, highlight while proc is active, turns red when out of range, blue on insufficient resources."
	L["Tracks the charge and the buff, highlight while the buff is active, blue on insufficient resources."] = "Realiza un seguimiento de la carga y el beneficio, resaltar cuando el beneficio está activo, azul si no hay recursos suficientes."
	L["Tracks the charge and the debuff, highlight while the debuff is active, blue on insufficient resources."] = "Realiza un seguimiento de la carga y el perjuicio, resaltar cuando el perjuicio está activo, azul si no hay recursos suficientes."
	--[[Translation missing --]]
	L["Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."] = "Tracks the charge and the duration of spell, highlight while the spell is active, blue on insufficient resources."
	--[[Translation missing --]]
	L["Unknown Item"] = "Unknown Item"
	--[[Translation missing --]]
	L["Unknown Spell"] = "Unknown Spell"
	--[[Translation missing --]]
	L["Warrior cooldown"] = "Warrior cooldown"

