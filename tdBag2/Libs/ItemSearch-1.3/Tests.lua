local Tests = WoWUnit and WoWUnit('ItemSearch-1.3', 'GET_ITEM_INFO_RECEIVED')
if not Tests then return end

local Search =  LibStub('ItemSearch-1.3')
local IsTrue = WoWUnit.IsTrue

if C_ArtifactUI then
  function Tests:ArtifactRelic()
    local item = '\124cffa335ee\124Hitem:140040::::::::120:::::\124h[Comet Dust]\124h\124r'

    IsTrue(Search:Matches(item, 'relic'))
    IsTrue(Search:Matches(item, 'artif'))
    IsTrue(Search:Matches(item, 'artifact'))
  end
end

if C_AzeriteItem and C_CurrencyInfo.GetAzeriteCurrencyID then
  function Tests:Azerite()
    local shoulder = '\124cffa335ee\124Hitem:161391::::::::120::::2:4822:1477:\124h[Deathshambler\'s Shoulderpads]\124h\124r'
    local heart = '\124cffe5cc80\124Hitem:158075::::::::120:::::\124h[Heart of Azeroth]\124h\124r'

    IsTrue(Search:Matches(shoulder, 'azer'))
    IsTrue(Search:Matches(shoulder, 'azerite'))

    IsTrue(Search:Matches(heart, 'azer'))
    IsTrue(Search:Matches(heart, 'azerite'))
  end
end

if C_Garrison then
  function Tests:ChampionEquipment()
    local item = '\124cffff8000\124Hitem:147556::::::::120:::::\124h[Cloak of Concealment]\124h\124r'

    IsTrue(Search:Matches(item, 'champ'))
    IsTrue(Search:Matches(item, 'champion'))
    IsTrue(Search:Matches(item, 'mission'))
  end
end
