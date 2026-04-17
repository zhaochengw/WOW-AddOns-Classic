#!/usr/bin/python

import sys
import requests
from lxml.html import fromstring

spell_ids = sys.argv[1:]
countries = ["http://eu.battle.net/wow/de/spell/%s/tooltip",
                "http://eu.battle.net/wow/fr/spell/%s/tooltip",
                "http://tw.battle.net/wow/zh/spell/%s/tooltip",
                "http://www.battlenet.com.cn/wow/zh/spell/%s/tooltip",
                "http://kr.battle.net/wow/ko/spell/%s/tooltip"]

enchants = []

for spell_id in spell_ids:
    print("getting spell id", spell_id)
    us = requests.get("http://www.wowhead.com/spell=" + spell_id).text
    html = fromstring(us)
    effect_id_tag = html.xpath('//*[@id="spelldetails"]/tr[7]/td/text()[2]')
    if not effect_id_tag:
        effect_id_tag = html.xpath('//*[@id="spelldetails"]/tr[7]/td/text()')
    effect_id = effect_id_tag[0][-5:-1]
    
    header = html.xpath('//*[@id="main-contents"]/div[3]/h1')
    if not header:
        header = html.xpath('//*[@id="main-contents"]/div[2]/h1')
    us_name = header[0].text

    translations = []

    for c in countries:
        html = fromstring(requests.get(c % spell_id).text)
        name = html.xpath('h3')
        translations.append(name[0].text)
        
    enchants.append((spell_id, effect_id, us_name, translations))



with open("enchants.txt", "wb+") as f:
    translated = []
    
    for i in range(len(enchants[0][3]) + 1):
        translated.append([])
        
    for enchant in enchants:
        ready = ['    ["%s"] = {\n' % enchant[0],
            '        ["enchantID"] = "%s",\n' % enchant[1],
            #'        ["illusion"] = true,\n',
            '        ["name"] = "%s",\n' % enchant[2],
            '    },\n']
    
        for l in ready:
            f.write(l.encode("utf-8"))
            
        translated[0].append('L["%s"] = true' % enchant[2])
        
        for i in range(len(enchant[3])):
            translated[i + 1].append('L["%s"] = "%s"' % (enchant[2], enchant[3][i]))

    
    for lang in translated:
        f.write(b"\n")
        
        for l in lang:
            f.write(l.encode("utf-8"))
            f.write(b"\n")
