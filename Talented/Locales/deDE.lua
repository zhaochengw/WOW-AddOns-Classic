-- translators: kunda
local L =  LibStub:GetLibrary("AceLocale-3.0"):NewLocale("Talented", "deDE")
if not L then return end

L['CONFIRM_TALENT_WIPE_TEXT'] = "Sollen alle Talente verlernt werden? Mit jeder Anwendung dieses Befehls steigen die Kosten dafür und alle Eure Begleiter werden freigegeben."

L["Talented - Talent Editor"] = "Talented - Talente Editor"

L["Layout options"] = "Anzeigeoptionen"
--~ L["Options that change the visual layout of Talented."] = true
L["Icon offset"] = "Symbolabstand"
L["Distance between icons."] = "Abstand zwischen den Symbolen."
L["Frame scale"] = "Fensterskalierung"
L["Overall scale of the Talented frame."] = "Gesamte Skalierung des Talented Fensters."

L["Options"] = "Optionen"
L["General Options for Talented."] = "Allgemeine Optionen für Talented."
L["Always edit"] = "Änderbar immer an"
L["Always allow templates and the current build to be modified, instead of having to Unlock them first."] = "Zeigt Vorlagen und die momentane Talentvergabe immer änderbar an, statt sie zuerst auf änderbar stellen zu müssen."
L["Confirm Learning"] = "Erlernen bestätigen"
L["Ask for user confirmation before learning any talent."] = "Erlernen neuer Talente bestätigen."
--~ L["Don't Confirm when applying"] = "Keine Bestätigung beim Zuweisen"
--~ L["Don't ask for user confirmation when applying full template."] = "Zeigt keine Bestätigung, wenn eine volle Vorlage den Talenten zugewiesen wird."
L["Always try to learn talent"] = "Immer versuchen Talente zu lernen"
L["Always call the underlying API when a user input is made, even when no talent should be learned from it."] = "Immer die zugrundeliegende API aufrufen wenn eine Benutzereingabe erfolgt, auch wenn kein Talent gelernt werden sollte."
L["Talent cap"] = "Talente cap"
L["Restrict templates to a maximum of %d points."] = "Vorlagen auf ein Maximum von %d Punkten beschränken."
L["Level restriction"] = "Levelbegrenzung"
L["Show the required level for the template, instead of the number of points."] = "Zeigt den benötigten Level, statt die Anzahl der Punkte."
L["Load outdated data"] = "Veraltete Daten laden"
L["Load Talented_Data, even if outdated."] = "Lädt Talented_Data, auch wenn diese veraltet sind."
L["Hook Inspect UI"] = "Betrachten UI mitbenutzen"
L["Hook the Talent Inspection UI."] = "Talented bei Talentbetrachtung von anderen Spielern benutzen."
L["Output URL in Chat"] = "URL in Chat ausgeben"
L["Directly outputs the URL in Chat instead of using a Dialog."] = "Gibt die URL direkt im Chat aus, statt in einem Dialogfenster."

L["Inspected Characters"] = "Betrachtete Charaktere"
--~ L["Talent trees of inspected characters."] = true
L["Edit template"] = "Vorlage änderbar"
L["Edit talents"] = "Talente änderbar"
L["Toggle edition of the template."] = "Vorlage editieren ein-/ausschalten."
L["Toggle editing of talents."] = "Talente editieren ein-/ausschalten."

L["Templates"] = "Vorlagen"
L["Actions"] = "Aktionen"
L["You can edit the name of the template here. You must press the Enter key to save your changes."] = "Du kannst den Namen der Vorlage hier ändern. Du musst Enter/Return drücken um Namensänderungen zu speichern."

L["Remove all talent points from this tree."] = "Alle Talentpunkte aus diesem Baum entfernen."
L["%s (%d)"] = "%s (%d)"
L["Level %d"] = "Level %d"
L["%d/%d"] = "%d/%d"
--~ L["Right-click to unlearn"] = "Rechtsklick zum verlernen"
L["Effective tooltip information not available"] = "Effektive Tooltip Informationen nicht verfügbar"
L["You have %d talent |4point:points; left"] = "Du hast noch %d Talentpunkt(e) zur Verfügung"
L["Are you sure that you want to learn \"%s (%d/%d)\" ?"] = "Bist Du sicher, daß Du \"%s (%d/%d)\" lernen willst?"

--~ L["Open the Talented options panel."] = "Öffnet die Talented Optionen."

--~ L["View Current Spec"] = "Momentane Talentvergabe zeigen"
L["View the Current spec in the Talented frame."] = "Momentane Talentvergabe im Talented Fenster anschauen."
--~ L["View Alternate Spec"] = "Alternative Talentvergabe zeigen"
L["Switch to this Spec"] = "Zu dieser Talentvergabe wechseln"
L["View Pet Spec"] = "Begleitertalente"

L["New Template"] = "Neue Vorlage"
L["Empty"] = "Leer"

L["Apply template"] = "Vorlage zuweisen"
L["Copy template"] = "Vorlage kopieren"
L["Delete template"] = "Vorlage löschen"
L["Set as target"] = "Als Zielvorlage setzen"
L["Clear target"] = "Zielvorlage entfernen"

L["Sorry, I can't apply this template because you don't have enough talent points available (need %d)!"] = "Vorlage konnte nicht zugewiesen werden, weil Du nicht genug Talentpunkte zur Verfügung hast (%d werden benötigt)!"
L["Sorry, I can't apply this template because it doesn't match your pet's class!"] = "Vorlage konnte nicht zugewiesen werden, weil Dein Begleiter eine andere Klasse hat."
L["Sorry, I can't apply this template because it doesn't match your class!"] = "Vorlage konnte nicht zugewiesen werden, weil Du eine andere Klasse hast."
L["Nothing to do"] = "Es gibt nichts zuzuweisen"
-- L["Talented cannot perform the required action because it does not have the required talent data available for class %s. You should inspect someone of this class."] = "Talented konnte die gewählte Aktion nicht ausführen, weil die benötigten Talentdaten für Klasse %s nicht verfügbar sind. Du solltest jemand mit dieser Klasse betrachten/inspizieren."
L["Talented cannot perform the required action because it does not have the required talent data available for class %s."] = "Talented konnte die gewählte Aktion nicht ausführen, weil die benötigten Talentdaten für Klasse %s nicht verfügbar sind."
L["You must install the Talented_Data helper addon for this action to work."] = "Du musst das Addon Talented_Data installieren um diese Aktion ausführen zu können."
L["You must enable the Talented_Data helper addon for this action to work."] = "Du musst das Addon Talented_Data installieren um diese Aktion ausführen zu können."
--~ L["You can download it from http://files.wowace.com/ ."] = "Du kannst es hier runterladen: http://files.wowace.com/"
L["If Talented_Data is out of date, you must update or you can allow it to load outdated data in the settings."] = true

L["Inspection of %s"] = "Talente von %s"
L["Select %s"] = "Wähle %s"
L["Copy of %s"] = "Kopie von %s"
L["Target: %s"] = "Ziel: %s"
L["Imported"] = "Importiert"

L["Please wait while I set your talents..."] = "Bitte warten, während die Talente zugewiesen werden..."
L["The given template is not a valid one!"] = "Die erhaltene Vorlage ist ungültig!"
L["Error while applying talents! Not enough talent points!"] = "Fehler beim Zuweisen der Talente! Nicht genug Talentpunkte!"
L["Error while applying talents! some of the request talents were not set!"] = "Fehler beim Zuweisen der Talente! Einige der angeforderten Talente wurden nicht gesetzt!"
L["Error! Talented window has been closed during template application. Please reapply later."] = "Fehler! Das Talented Fenster wurde während der Vorlagenzuweisung geschlossen. Bitte später noch einmal versuchen."
L["Talent application has been cancelled. %d talent points remaining."] = "Talentzuweisung wurde abgebrochen. %d Talentpunkt(e) übrig."
L["Template applied successfully, %d talent points remaining."] = "Vorlage erfolgreich zugewiesen, %d Talentpunkt(e) übrig."
L["Warning - no action was taken, or we ran out of talent points."] = true --TODO: Localise!
L["Talented_Data is outdated. It was created for %q, but current build is %q. Please update."] = "Talented_Data ist veraltet. Es wurde für %q erstellt, aber momentane Version ist %q. Bitte aktualisieren."
L["Loading outdated data. |cffff1010WARNING:|r Recent changes in talent trees might not be included in this data."] = "Veraltete Daten werden geladen. |cffff1010WARNUNG:|r Änderungen an Talentbäumen, die erst kürzlich eingeführt wurden, könnten nicht in diesen Daten vorhanden sein."
L["\"%s\" does not appear to be a valid URL!"] = "\"%s\" sieht nach einer ungültigen URL aus!"

L["Import template ..."] = "Importiere Vorlage ..."
L["Enter the complete URL of a template from Blizzard talent calculator or wowhead."] = "Gib die ganze URL einer Vorlage vom Blizzard- oder wowhead-Talentrechner ein."

L["Export template"] = "Vorlage exportieren"
L["Blizzard Talent Calculator"] = "Blizzard Talentrechner"
L["Wowhead Talent Calculator"] = "Wowhead Talentrechner"
L["Wowdb Talent Calculator"] = "Wowdb Talentrechner"
L["MMO Champion Talent Calculator"] = "MMO Champion Talentrechner"
--~ L["http://www.worldofwarcraft.com/info/classes/%s/talents.html?tal=%s"] = "http://www.wow-europe.com/de/info/basics/talents/%s/talents.html?tal=%s"
L["http://www.wowarmory.com/talent-calc.xml?%s=%s&tal=%s"] = "http://eu.wowarmory.com/talent-calc.xml?locale=de_de&%s=%s&tal=%s"
L["http://tbc.wowhead.com/talent-calc/%s/%s"] = "http://de.tbc.wowhead.com/talent-calc/%s/%s"
L["http://tbc.wowhead.com/petcalc#%s"] = "http://de.tbc.wowhead.com/petcalc#%s"
L["http://classic.wowhead.com/talent-calc/%s/%s"] = "http://de.classic.wowhead.com/talent-calc/%s/%s"
L["http://classic.wowhead.com/petcalc#%s"] = "http://de.classic.wowhead.com/petcalc#%s"
L["http://www.wowhead.com/talent-calc/%s/%s"] = "http://de.wowhead.com/talent-calc/%s/%s"
L["http://www.wowhead.com/petcalc#%s"] = "http://de.wowhead.com/petcalc#%s"
L["Send to ..."] = "Senden an ..."
L["Enter the name of the character you want to send the template to."] = "Gib den Namen des Charakters ein, an den Du die Vorlage schicken willst."
L["Do you want to add the template \"%s\" that %s sent you ?"] = "Willst Du die Vorlage \"%s\", die %s Dir gesendet hat hinzufügen?"

--~ L["Pet"] = "Begleiter"
L["Options ..."] = "Optionen ..."

L["URL:"] = "URL:"
L["Talented has detected an incompatible change in the talent information that requires an update to Talented. Talented will now Disable itself and reload the user interface so that you can use the default interface."] = "Talented hat eine inkompatible Änderung an den Talentinformationen festgestellt, die eine Aktualisierung von Talented erfordert. Talented wird sich jetzt selbst deaktivieren und das Interface neu laden, damit Du das Standard Interface benutzen kannst."
L["WARNING: Talented has detected that its talent data is outdated. Talented will work fine for your class for this session but may have issue with other classes. You should update Talented if you can."] = "WARNUNG: Die Daten von Talented sind veraltet. Talented wird für Deine Klasse noch funktionieren, aber es kann Probleme bei anderen Klassen geben. Du solltest Talented aktualisieren."
L["View glyphs of alternate Spec"] = "Glyphen der anderen Talentspezialisierung zeigen"
L[" (alt)"] = " (alt.)"
L["The following templates are no longer valid and have been removed:"] = "Die folgenden Vorlagen sind nicht länger gültig und wurden entfernt:"
L["The following templates were converted from a previous version of the addon. Ensure that none are 'invalid' (below); retrieve the backup of your config file from the WTF folder if so."] = true
L["The template '%s' is no longer valid and has been removed."] = "Die Vorlage '%s' ist nicht länger gültig und wurde entfernt."
L["The template '%s' had inconsistencies and has been fixed. Please check it before applying."] = "Bei der Vorlage '%s' gab es Ungereimtheiten, die behoben wurden. Bitte Vorlage vor einem zuweisen überprüfen."

L["Lock frame"] = "Fenster sperren"
L["Can not apply, unknown template \"%s\""] = "Konnte Vorlage nicht zuweisen, unbekannt Vorlage \"%s\""

L["Glyph frame policy on spec swap"] = "Glyhensetanzeige (bei Spezialisierungwechsel)"
L["Select the way the glyph frame handle spec swaps."] = "Wähle, welches Glyphenset bei einem Spezialisierungwechsel angezeigt werden soll."
L["Keep the shown spec"] = "Glyphenset beibehalten"
L["Swap the shown spec"] = "Glyphenset wechseln"
L["Always show the active spec after a change"] = "Glyphenset der aktiven Talentspezialisierung anzeigen"

L["General options"] = "Allgemeine Optionen"
L["Glyph frame options"] = "Glyphen Optionen"
L["Display options"] = "Anzeige Optionen"
L["Add bottom offset"] = "Zeile unten einfügen"
L["Add some space below the talents to show the bottom information."] = "Fügt unten eine Zeile ein, um die unteren Informationen besser anzuzeigen."

L["Right-click to activate this spec"] = "Rechtsklick um diese Talentspezialisierung zu aktivieren."

--Locales for new template options
L["Template"] = "Vorlage"
L["New Template"] = "Neue Vorlage"
L["Create a new Template."] = "Neue Vorlage erstellen."
L["New empty template"] = "Neue leere Vorlage"
L["Create a new template from scratch."] = "Neue leere Vorlage erstellen."
L["Copy current talent spec"] = "Momentane Talentvergabe kopieren"
L["Create a new template from your current spec."] = "Eine neue Vorlage von Deiner momentanen Talentvergabe erstellen."
L["Clone selected"] = "Ausgewählte Clonen"
L["Make a copy of the current template."] = "Eine Kopie der momentanen Vorlage erstellen."
