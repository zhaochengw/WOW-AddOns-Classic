local AddonName, SAO = ...

SAO.defaults = {
    classes = {
        ["DEATHKNIGHT"] = {
            alert = {
                [59052] = { -- Rime
                    [0] = true,
                },
                [51124] = { -- Killing Machine
                    [0] = true,
                },
            },
            glow = {
                [56815] = { -- Rune Strike
                    [56815] = true, -- Rune Strike
                },
                [59052] = { -- Rime
                    [49184] = true, --  Howling Blast
                },
                [51124] = { -- Killing Machine
                    [45477] = true, -- Icy Touch
                    [49143] = true, -- Frost Strike
                    [49184] = true, -- Howling Blast
                },
            }
        },
        ["DRUID"] = {
            alert = {
                [16870] = { -- Omen of Clarity
                    [0] = true,
                },
                [48518] = { -- Eclipse (Lunar)
                    [0] = true,
                },
                [48517] = { -- Eclipse (Solar)
                    [0] = true,
                },
                [16886] = { -- Nature's Grace
                    [0] = false,
                },
                [46833] = { -- Wrath of Elune
                    [0] = false,
                },
                [64823] = { -- Elune's Wrath
                    [0] = false,
                },
                [69369] = { -- Predatory Strikes
                    [0] = true,
                },
                [60512] = { -- Healing Trance / Soul Preserver
                    [0] = false,
                },
                [414800]= { -- Fury of Stormrage (Season of Discovery)
                    [0] = true,
                },
            },
            glow = {
                [2912] = { -- Starfire
                    [2912] = true, -- Starfire
                },
                [5176] = { -- Wrath
                    [5176] = true, -- Wrath
                },
                [46833] = { -- Wrath of Elune
                    [2912] = true, -- Starfire
                },
                [64823] = { -- Elune's Wrath
                    [2912] = true, -- Starfire
                },
                [69369] = { -- Predatory Strikes
                    [8936]  = false, -- Regrowth
                    [5185]  = true,  -- Healing Touch
                    [50464] = false, -- Nourish
                    [20484] = false, -- Rebirth
                    [5176]  = false, -- Wrath
                    [339]   = false, -- Entangling Roots
                    [33786] = true,  -- Cyclone
                    [2637]  = false, -- Hibernate
                },
                [414800]= { -- Fury of Stormrage (Season of Discovery)
                    [5185] = true, -- Healing Touch
                },
            }
        },
        ["HUNTER"] = {
            alert = {
                [53220] = { -- Improved Steady Shot
                    [0] = true,
                },
                [56453] = { -- Lock and Load
                    [0] = true, -- any stacks
                },
                [415320]= { -- Flanking Strike (Season of Discovery)
                    [0] = true,
                },
                [425714]= { -- Cobra Strikes (Season of Discovery)
                    [0] = true, -- any stacks
                },
            },
            glow = {
                [53351] = { -- Kill Shot
                    [53351] = true, -- Kill Shot
                },
                [19306] = { -- Counterattack
                    [19306] = true, -- Counterattack
                },
                [53220] = { -- Improved Steady Shot
                    [19434] = true, --  Aimed Shot
                    [3044]  = true, --  Arcane Shot
                    [53209] = true, --  Chimera Shot
                },
                [56453] = { -- Lock and Load
                    [3044]  = true, --  Arcane Shot
                    [53301] = true, --  Explosive Shot
                },
                [1495] = { -- Mongoose Bite
                    [1495]  = true, -- Mongoose Bite
                },
                [415320]= { -- Flanking Strike (Season of Discovery)
                    [415320]= true, -- Flanking Strike (Season of Discovery)
                },
            }
        },
        ["MAGE"] = {
            alert = {
                [12536] = { -- Arcane Concentration
                    [0] = false,
                },
                [44401] = { -- Missile Barrage
                    [0] = true,
                },
                [400573]= { -- Arcane Blast (Season of Discovery)
                    [4] = true, -- 4 stacks
                    [0] = true, -- any stacks but 4
                },
                [48107] = { -- Heating Up (not an actual buff)
                    [0] = true,
                },
                [48108] = { -- Hot Streak
                    [0] = true,
                },
                [64343] = { -- Impact
                    [0] = true,
                },
                [54741] = { -- Firestarter
                    [0] = true,
                },
                [74396] = { -- Fingers of Frost
                    [0] = true, -- any stacks
                },
                [400670]= { -- Fingers of Frost (Season of Discovery)
                    [0] = true, -- any stacks
                },
                [57761] = { -- Brain Freeze
                    [0] = true,
                },
                [96215] = { -- Hot Streak + Heating Up (not an actual buff)
                    [0] = false,
                },
                [5276] = { -- Representative of spells triggering Frozen effect
                    [0] = false,
                }
            },
            glow = {
                [44401] = { -- Missile Barrage
                    [5143] = true, -- Arcane Missiles
                },
                [400573]= { -- Arcane Blast 4/4 (Season of Discovery)
                    [5143] = true,  -- Arcane Missiles
                    [1449] = false, -- Arcane Explosion
                },
                [48108] = { -- Hot Streak
                    [11366] = true, -- Pyroblast
                },
                [64343] = { -- Impact
                    [2136] = true, -- Fire Blast
                },
                [54741] = { -- Firestarter
                    [2120] = true, -- Flamestrike
                },
                [57761] = { -- Brain Freeze
                    [133]   = true, -- Fireball
                    [44614] = true, -- Frostfire Bolt
                },
                [74396] = { -- Fingers of Frost
                    [30455] = true, -- Ice Lance
                    [44572] = true, -- Deep Freeze
                },
                [400670]= { -- Fingers of Frost (Season of Discovery)
                    [400640]= true, -- Ice Lance (Season of Discovery)
                },
                [5276] = { -- Representative of spells triggering Frozen effect
                    [30455] = true, -- Ice Lance
                    [44572] = true, -- Deep Freeze
                    [400640]= true, -- Ice Lance (Season of Discovery)
                },
            },
        },
        ["PALADIN"] = {
            alert = {
                [54149] = { -- Infusion of Light (2/2)
                    [0] = true,
                },
                [59578] = { -- The Art of War (2/2)
                    [0] = true,
                },
                [60513] = { -- Healing Trance / Soul Preserver
                    [0] = false,
                },
            },
            glow = {
                [24275] = { -- Hammer of Wrath
                    [24275] = true, -- Hammer of Wrath
                },
                [54149] = { -- Infusion of Light (2/2)
                    [19750] = true, -- Flash of Light
                    [635]   = true, -- Holy Light
                },
                [59578] = { -- The Art of War (2/2)
                    [879]   = true, -- Exorcism
                    [19750] = true, -- Flash of Light
                },
            },
        },
        ["PRIEST"] = {
            alert = {
                [33151] = {  -- Surge of Light
                    [0] = true,
                },
                [63734] = { -- Serendipity
                    [3] = true,  -- 3 stacks
                    [0] = false, -- any stacks but 3
                },
                [60514] = { -- Healing Trance / Soul Preserver
                    [0] = false,
                },
                [413247]= { -- Serendipity (Season of Discovery)
                    [3] = true,  -- 3 stacks
                    [0] = false, -- any stacks but 3
                },
            },
            glow = {
                [33151] = { -- Surge of Light
                    [585]  = true, -- Smite
                    [2061] = true, -- Flash Heal
                },
                [63734] = { -- Serendipity 3/3
                    [2060] = true, -- Greater Heal
                    [596]  = true, -- Prayer of Healing
                },
                [413247]= { -- Serendipity 3/3 (Season of Discovery)
                    [2050] = true, -- Lesser Heal
                    [2054] = true, -- Heal
                    [2060] = true, -- Greater Heal
                    [596]  = true, -- Prayer of Healing
                },
            },
        },
        ["ROGUE"] = {
            alert = {
                [14251] = { -- Riposte
                    [0] = "cd:off",
                },
            },
            glow = {
                [14251] = { -- Riposte
                    [14251] = "cd:off", -- Riposte
                },
            },
        },
        ["SHAMAN"] = {
            alert = {
                [16246] = {  -- Elemental Focus
                    [0] = true,
                },
                [53817] = { -- Maelstorm Weapon
                    [5] = true, -- 5 stacks
                    [0] = true, -- any stacks but 5
                },
                [53390] = { -- Tidal Waves
                    [0] = false, -- any stacks
                },
                [60515] = { -- Healing Trance / Soul Preserver
                    [0] = false,
                },
                [425339]= { -- Molten Blast (Season of Discovery)
                    [0] = true,
                },
            },
            glow = {
                [53817] = { -- Maelstorm Weapon
                    [403]   = false, -- Lightning Bolt
                    [421]   = false, -- Chain Lightning
                    [8004]  = false, -- lesser Healing Wave
                    [331]   = false, -- Healing Wave
                    [1064]  = false, -- Chain Heal
                    [51514] = false, -- Hex
                },
                [53390] = { -- Tidal Waves
                    [8004] = false, -- lesser Healing Wave
                    [331]  = false, -- Healing Wave
                },
                [425339]= { -- Molten Blast (Season of Discovery)
                    [425339] = true, -- Molten Blast (Season of Discovery)
                },
            },
        },
        ["WARLOCK"] = {
            alert = {
                [17941] = { -- Nightfall
                    [0] = true,
                },
                [34936] = { -- Backlash
                    [0] = true,
                },
                [71165] = { -- Molten Core
                    [0] = true, -- any stacks
                },
                [63167] = { -- Decimation
                    [0] = true,
                },
                [47283] = { -- Empowered Imp
                    [0] = true,
                },
            },
            glow = {
                [17941] = { -- Nightfall
                    [686] = true, -- Shadow Bolt
                },
                [34936] = { -- Backlash
                    [686]   = true, -- Shadow Bolt
                    [29722] = true, -- Incinerate
                },
                [71165] = { -- Molten Core
                    [29722] = true, -- Incinerate
                    [6353]  = true, -- Soul Fire
                },
                [63167] = { -- Decimation
                    [6353] = true, -- Soul Fire
                },
                [1120] = { -- Drain Soul
                    [1120] = "spec:1", -- Drain Soul
                },
            },
        },
        ["WARRIOR"] = {
            alert = {
                [52437] = { -- Sudden Death
                    [0] = true, -- any stacks (up to 2 stacks with tier 10)
                },
                [46916] = { -- Bloodsurge
                    [0] = true, -- any stacks (up to 2 stacks with tier 10)
                },
                [50227] = { -- Sword and Board
                    [0] = true,
                },
                [402911]= { -- Raging Blow (Season of Discovery)
                    [0] = true,
                },
            },
            glow = {
                [7384] = { -- Overpower
                    [7384] = "stance:1", -- Overpower
                },
                [6572] = { -- Revenge
                    [6572] = "stance:2", -- Revenge
                },
                [5308] = { -- Execute
                    [5308] = "stance:1/3", -- Execute
                },
                [34428] = { -- Victory Rush
                    [34428] = true, -- Victory Rush
                },
                [402927]= { -- Victory Rush (Season of Discovery)
                    [402927]= true, -- Victory Rush (Season of Discovery)
                },
                [402911]= { -- Raging Blow (Season of Discovery)
                    [402911]= true, -- Raging Blow (Season of Discovery)
                },
                [52437] = { -- Sudden Death
                    [5308] = true, -- Execute
                },
                [46916] = { -- Bloodsurge
                    [1464] = true, -- Slam
                },
                [50227] = { -- Sword and Board
                    [23922] = true, -- Shield Slam
                },
            },
        },
    }
}

if WOW_PROJECT_ID == WOW_PROJECT_CLASSIC then
    -- Options that have different default values for Classic Era
    SAO.defaults.classes["MAGE"]["alert"][12536][0] = "genericarc_05";
end
