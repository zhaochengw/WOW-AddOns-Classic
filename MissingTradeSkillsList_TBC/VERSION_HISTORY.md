## Version History

### v2.5.08 (June 19, 2021)

* Optimised the way the addon scans for missing skills
* Optimised code for scanning skills when swapping TradeSkillFrame & CraftFrame and rehooking MTSL button
* Added all upcoming patches as filter possibility to the regular MTSL window as well
* Fixed data:
  * All professions should now have their correct localised name
  * Cooking recipe "Ravager dogs" is now also sold by Alliance vendor
  * All skills should now have the correct phase (if you find any mistake, create an isssue)
* Added data:
  * Added item_id for each skill that represents the id of the item that is created when executing the spell
  
### v2.5.07 (June 17, 2021)

* All professions should now have all the correct data
* Added the reputation needed for all items sold by any TBC faction quartermaster
* Added the TBC factions to the filter frame
* Addded racial bonus for Enchanting (Blood Elf) & Jewelcrafting (Draenei)
* Fixed bug when showing the details of a Quest with NPCs lead to "nil" error
* Fixed bug where skills learned in spellbook still showed as unlearned
* Added ability to show the 2nd vendor using reputation when available

### v2.5.06 (June 14, 2021)

* All professions except Jewelcrafting & Leatherworking have all the skills & items added
* Fixed data:
  * Set the correct data for each NPC
  * All items have the correct phase now, if they drop in specific zone(s), those zone(s) are added
  * Removed unused NPCs
  * Removed unused or duplicate skills/items
  
### v2.5.05 (June 8, 2021)

* Fixed data
  * Added missing "expansion" number for classic specialisations
  * Added some missing NPCs
  * Updated professions to only have the correct auto learned spells
  * Set the correct phase for some skill
* Added code to save ids when data is missing for an object for easier missing data reports. Include the contents of "MTSL\_MISSING\_DATA" from saved variables to bug report if not empty
* Fixed bugs
  * Fresh install could prevent addon from loading when MTSLUI\_PLAYER is not yet loaded/filled
  * Mob data is once again shown when the item they drop is selected
  * Missing icon for Jewelcrafting in skill list frame

### v2.5.04 (June 8, 2021)

* Added loads of spells/items/npcs for all professions
* Added all "Master" level for all professions
* Set the correct trainers for each level of each profession
* Added specialisations for Alchemy & Tailoring
* Updated the names of all spells, items with live ingame data

### v2.5.03 (May 30, 2021)

* Fixed data
  * Updated French & German translations for continents, factions, zones & some NPCs

### v2.5.02 (May 30, 2021)

* Removed useless "prints" from code
* Added data
  * Currency "Glowcap"
  * Some cooking skills
  * all TBC factions 
  * Book to learn first aid (Master)
* Fixed data
  * Removed spell "Blinding powder" from Poisons
  * All items have the correct vendor price  
  * All Master levels have the correct price
  * Improved MTSL locale for Russian
  * Updated all translations from "classic" skills for all locales to match the names used in TBC
  * Ezekiel Graves was replaced with Gregory Charles as Poison trainer
* Fixed bugs
  * Character explorer frame did not correctly change to current zone

### v2.5.01 (May 24, 2021)

* Initial release
* Added the 5 scheduled phases
* Added "zone" as a possible drop source
* Added data for TBC for professions:
    * First Aid
    * Fishing
    * Herbalism
    * Mining
    * Skinning
* Fixed bugs:
  * Character explorer frame did not correctly change to current zone