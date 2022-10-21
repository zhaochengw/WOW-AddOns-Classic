hooksecurefunc("HandleModifiedItemClick", function(link)
	local mounts = MountsJournal
	local config = mounts.config

	if config.openHyperlinks and not InCombatLockdown() and IsModifiedClick("DRESSUP") and not IsModifiedClick("CHATLINK") then
		local _,_,_, linkType, linkID = (":|H"):split(link)

		local spellID
		if linkType == "item" then
			linkID = mounts.itemIDToSpellID[tonumber(linkID)]
			spellID = MountsJournalUtil.getMountInfoBySpellID(linkID) and linkID
		elseif linkType == "spell" then
			linkID = tonumber(linkID)
			spellID = MountsJournalUtil.getMountInfoBySpellID(linkID) and linkID
		end

		if spellID then
			HideUIPanel(DressUpFrame)
			local journal = MountsJournalFrame
			if journal.init then
				journal:init()
			else
				journal.bgFrame:Show()
			end
			journal:setSelectedMount(spellID)
		end
	end
end)

function DressUpMountLink() return false end