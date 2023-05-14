local E, L, C = select(2, ...):unpack()

if E.isClassic then E.changelog = [=[
v1.14.3.2751
	Added option to use ElvUI's timer (in General menu)
]=]
elseif E.isBCC then E.changelog = [=[
v2.5.4.2722
	Fixed sync for cross realm group members
]=]
elseif E.isWOTLKC then E.changelog = [=[
v3.4.1.2751
	3.4.2 font flag fix
	Added option to use ElvUI's timer (in General menu)
]=]
else E.changelog = [=[
v10.1.0.2751
	Added Season 2 Obsidian PvP Trinkets
	Added Embers of Neltharion Tier Set bonuses
	Added option to use ElvUI's timer (in General menu)
]=]
end

E.changelog = E.changelog .. "\n\n|cff808080Full list of changes can be found in the CHANGELOG file"
