local insert = table.insert
local inserted1, inserted2, inserted3 = false, false, false

-- Try to use unique function names so diff user packs don't overwrite eachother, Generally I just use MP, VP, DF + Unique Addon Name
-- Function names are defined in TOC. A pack does not need to contain all 3 sound types. You are welcome to make just specific ones, just make sure TOC is correct

function DBMVPSoundEventsPack() -- Register Victory sounds to DBM.Victory table
	if inserted1 then
		return
	end
	insert(DBM.Victory, {
		text	= "Zelda OoT: Chest",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Chest_Opening_and_Getting_Item.ogg"
	})
	insert(DBM.Victory, {
		text	= "Gooshers: win",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\goosherswin.ogg"
	})
	insert(DBM.Victory, {
		text	= "Sonic: Stage Cleared",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\sonic.ogg"
	})
	insert(DBM.Victory, {
		text	= "FF: Fanfare",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_FinalFantasy.ogg"
	})
	insert(DBM.Victory, {
		text	= "FF: Fanfare Long",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_FinalFantasyLong.ogg"
	})
	insert(DBM.Victory, {
		text	= "FF: Fanfare Classic",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_FinalFantasyClassic.ogg"
	})
	insert(DBM.Victory, {
		text	= "SMB: Stage Clear",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_SuperMarioBros.ogg"
	})
	insert(DBM.Victory, {
		text	= "SMB: Stage Clear 2",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_SuperMarioBrosDungeon.ogg"
	})
	insert(DBM.Victory, {
		text	= "SMB3: Stage Clear",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_SuperMarioBros3.ogg"
	})
	insert(DBM.Victory, {
		text	= "SMRPG: Victory",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_SuperMarioRPG.ogg"
	})
	insert(DBM.Victory, {
		text	= "SMW: Victory",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Victory\\Victory_SuperMarioWorld.ogg"
	})
	inserted1 = true
end

function DBMDPSoundEventsPack() -- Register Defeat sounds to DBM.Defeat Table
	if inserted2 then
		return
	end
	insert(DBM.Defeat, {
		text	= "Alex Death",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\alexdeath.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Death 1",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\death1.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Death 2",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\death2.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Drama",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\drama.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Etpm",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\etpm.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Gooshers: fail",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\gooshersfail.ogg"
	})
	insert(DBM.Defeat, {
		text	= "IOUS",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\IOUS.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Keyboard Cat",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\KeyboardCat.ogg"
	})
	insert(DBM.Defeat, {
		text	= "SMB: Death",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\mariodie.ogg"
	})
	insert(DBM.Defeat, {
		text	= "SMB3: Death",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\mariodie2.ogg"
	})
	insert(DBM.Defeat, {
		text	= "SMW: Game Over",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\SuperMarioWorld.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Oh No",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\ohno.ogg"
	})
	insert(DBM.Defeat, {
		text	= "PacMan: Death",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\pacmandie.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Price Is Right",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\PriceIsRight.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Sonic: Game Over",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\sonic.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Whoa",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\whoa.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Whoops",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\whoops.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Link: Death",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\zelda.ogg"
	})
	insert(DBM.Defeat, {
		text	= "Twiggl: Stop It",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Defeat\\stop_it1.ogg"
	})
	inserted2 = true
end

function DBMMPSoundEventsPack() -- Register Music to DBM.Music Table
	if inserted3 then
		return
	end
	-- All Music Table
	insert(DBM.Music, {
		text	= "FFVII: Boss Battle",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_FinalFantasy.ogg"
	})
	insert(DBM.Music, {
		text	= "FFX: Boss Battle",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_FinalFantasyX.ogg"
	})
	insert(DBM.Music, {
		text	= "SMB: Stage",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioBros.ogg"
	})
	insert(DBM.Music, {
		text	= "SMB3: Stage",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioBros3.ogg"
	})
	insert(DBM.Music, {
		text	= "SMRPG: Boss Battle",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioRPG_Boss.ogg"
	})
	insert(DBM.Music, {
		text	= "SMW: Stage",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioWorld.ogg"
	})
	insert(DBM.Music, {
		text	= "Super Metroid: Ridley",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMetroidRidley.ogg"
	})
	insert(DBM.Music, {
		text	= "WingCommander",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_WingCommander.ogg"
	})
	insert(DBM.Music, {
		text	= "Blakbyrd",
		value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Blackbyrd.ogg"
	})

	-- Dungeon BGM Table
	if DBM.DungeonMusic then
		insert(DBM.DungeonMusic, {
			text	= "SMB: Stage",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioBros.ogg"
		})
		insert(DBM.DungeonMusic, {
			text	= "SMB3: Stage",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioBros3.ogg"
		})
		insert(DBM.DungeonMusic, {
			text	= "SMW: Stage",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioWorld.ogg"
		})
		insert(DBM.DungeonMusic, {
			text	= "Blakbyrd",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Blackbyrd.ogg"
		})
	end

	-- Boss BGM Table
	if DBM.BattleMusic then
		insert(DBM.BattleMusic, {
			text	= "FFVII: Boss Battle",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_FinalFantasy.ogg"
		})
		insert(DBM.BattleMusic, {
			text	= "FFX: Boss Battle",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_FinalFantasyX.ogg"
		})
		insert(DBM.BattleMusic, {
			text	= "SMRPG: Boss Battle",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMarioRPG_Boss.ogg"
		})
		insert(DBM.BattleMusic, {
			text	= "Super Metroid: Ridley",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_SuperMetroidRidley.ogg"
		})
		insert(DBM.BattleMusic, {
			text	= "WingCommander",
			value	= "Interface\\AddOns\\DBM-SoundEventsPack\\Music\\Music_WingCommander.ogg"
		})
	end
	inserted3 = true
end
