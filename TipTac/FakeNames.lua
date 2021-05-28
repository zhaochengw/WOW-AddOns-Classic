-- Changes display name (only on your client)!
-- Affects ZPerl: Playerframe, Target, Targetoftarget, Partyframe, PartyTarget,
-- Also affects TipTac tooltips!
-- It's totally safe, only changes the displayed name on your screen and only in these addons!
-- Purely cosmetic, after querying the names it changes them before writing out the texts to the unitframes and tooltips
-- Character panel or the names above heads (if turned on) still show the real name, so you should hide that for full effect :)
-- You can add as many new line as you want or edit the existing ones, left is the original "" and if finds that name or substring it changes into the right text
-- Can have spaces, numbers capital letters...
-- After editing must save and reloadui with /run ReloadUI() or relog to take effect
-- If you party with other streamer, you both must have these addons and set up the same namechanges to see eachother with the changed names



fakenames={	"Magepy","MaGepy",
			"Gepy","GEPY",
			"Bankif","BankIF - GoldMaker",
			"Banksw","BankSW - GoldMaker",
			"Damagepy","DaMaGepy",
			"Esfand","ESFAND",
			"Swifty","SWIFTY",
			"Darkmedic","DarkMedic",
			"Holymedic","HolyMedic",
			"Tipsout","TipsOut",
			"Konnagma","Big Blue Danger",
			"Zeprin","IMPossible",
			"Marcang","MARCANG",
			"XXX","YYY",
			"XXX","YYY",
			"XXX","YYY"}
			
			
	







	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
if round~=nil then fakenum=round(table.getn(fakenames) / 2) else fakenum=math.floor(table.getn(fakenames) / 2); end
if fakenum==nil then fakenum=0 end
DEFAULT_CHAT_FRAME:AddMessage("|cffbbddbbFake-names loaded:  |cffcc55cc"..fakenum)

function GetFakeName(gfn,fsource) -- DaMaGepy
	local NewFakeName=gfn;
	if (gfn~=nil) and (fakenum~=nil) then
		for xpf=1,fakenum do 
			if gfn==fakenames[xpf*2-1] then 
				NewFakeName=fakenames[xpf*2]
			elseif strfind(gfn,fakenames[xpf*2-1],1)~=nil then
				NewFakeName=string.gsub(gfn, fakenames[xpf*2-1], fakenames[xpf*2]); 
			end 
		end	
	end
	return NewFakeName;
end

function round(x)
  return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
end