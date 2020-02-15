--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]

------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2010-08-04 12:04:27 +1000 (Wed, 04 Aug 2010) $
------------------------------------------------------------------------------------------------------

local new, del
do
	local cache = setmetatable({}, {__mode='k'})
	function new(populate, ...)
		local tbl
		local t = next(cache)
		if ( t ) then
			cache[t] = nil
			tbl = t
		else
			tbl = {}
		end
		if ( populate ) then
			local num = select("#", ...)
			if ( populate == "hash" ) then
				assert(math.fmod(num, 2) == 0)
				local key
				for i = 1, num do
					local v = select(i, ...)
					if not ( math.fmod(i, 2) == 0 ) then
						key = v
					else
						tbl[key] = v
						key = nil
					end
				end
			elseif ( populate == "array" ) then
				for i = 1, num do
					local v = select(i, ...)
					table.insert(tbl, i, v)
				end
			end
		end
		return tbl
	end
	function del(t)
		for k in next, t do
			t[k] = nil
		end
		cache[t] = true
	end
end



Necrosis.Spells = {}

local _sp = Necrosis.Spells

function _sp:GetFelDominationCooldown()
	return self:GetSpellCooldownTime(Necrosis.Spell[15].ID)
end

function _sp:GetShadowWardCooldown()
	return self:GetSpellCooldownTime(Necrosis.Spell[43].ID)
end

function _sp:GetRitualOfSoulsCooldown()
	return self:GetSpellCooldownTime(Necrosis.Spell[50].ID)
end

function _sp:GetSpellCooldownTime(spellBookId)
	local secs = self:GetSpellCooldownInSecs(spellBookId)
	return (secs > 0), Necrosis.Timers:GetFormattedTime(secs)
end

function _sp:GetSpellCooldownInSecs(spellBookId)
	if not spellBookId then
		-- Some spells may not be available
		return 0
	end
	local startTime, duration, enable = GetSpellCooldown(spellBookId, BOOKTYPE_SPELL)
	if enable == 0 then
		return 0
	end
	if startTime == 0 then
		return 0
	end
	local remainingSecs = math.floor(duration - (GetTime() - startTime))
	return remainingSecs
end

function _sp:GetRankNumberFromSubName(subName)
	local _, _, rank = subName:find("(%d+)")
	if rank then
		return  tonumber(rank)
	end
	return nil
end


local function MakeSpellIdRanks(root)
    -- i is the rank of the item
    -- Create an entry in the form of [itemId] = rank
    for i,id in ipairs(root.SpellIds) do
        root[id] = i
    end
end

-- Fonction pour relocaliser  automatiquemlent des éléments en fonction du client
function Necrosis:SpellLocalize(tooltip) 

	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Sorts
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	if not tooltip then
		self.Spell = {
			[1] = {Name = GetSpellInfo(5784), 	GlobalId = 5784, 	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Felsteed
			[2] = {Name = GetSpellInfo(23161), 	GlobalId = 23161,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Dreadsteed
			[3] = {Name = GetSpellInfo(688), 	GlobalId = 688,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Imp || Diablotin 
			[4] = {Name = GetSpellInfo(697),	GlobalId = 697,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Voidwalker || Marcheur
			[5] = {Name = GetSpellInfo(712),	GlobalId = 712,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Succubus || Succube
			[6] = {Name = GetSpellInfo(691),	GlobalId = 691,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Fellhunter
			[7] = {Name = GetSpellInfo(691),	GlobalId = 691,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Felguard -- Fellhunter now
			[8] = {Name = GetSpellInfo(1122),	GlobalId = 1122,	Mana = 50,	Rank = 0,	Length = 600,	Type = 3}, -- Infernal
			[9] = {Name = GetSpellInfo(18647),	GlobalId = 18647,	Mana = 50,	Rank = 0,	Length = 30,	Type = 2}, -- Banish
			[10] = {Name = GetSpellInfo(1098),	GlobalId = 1098,	Mana = 50,	Rank = 0,	Length = 300,	Type = 2}, -- Enslave
			[11] = {Name = GetSpellInfo(20707),	GlobalId = 20707,	Mana = 50,	Rank = 0,	Length = 1800,	Type = 1}, -- Soulstone Resurrection || Résurrection de pierre d'ame
			[12] = {Name = GetSpellInfo(707),	GlobalId = 707,		Mana = 50,	Rank = 0,	Length = 15,	Type = 6}, -- Immolate
			[13] = {Name = GetSpellInfo(6215),	GlobalId = 6215,	Mana = 50,	Rank = 0,	Length = 15,	Type = 6}, -- Fear
			[14] = {Name = GetSpellInfo(6222),	GlobalId = 6222,	Mana = 50,	Rank = 0,	Length = 18,	Type = 5}, -- Corruption
			[15] = {Name = GetSpellInfo(18708),	GlobalId = 18708,	Mana = 50,	Rank = 0,	Length = 180,	Type = 3}, -- Fel Domination || Domination corrompue
			[16] = {Name = GetSpellInfo(603),	GlobalId = 603,		Mana = 50,	Rank = 0,	Length = 60,	Type = 3}, -- Curse of Doom || Malédiction funeste
			[17] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 20,	Type = 3}, -- NOPE NOT IN Classic Shadowfury || Furie de l'ombre
			[18] = {Name = GetSpellInfo(17924),	GlobalId = 17924,	Mana = 50,	Rank = 0,	Length = 60,	Type = 3}, -- Soul Fire || Feu de l'âme
			[19] = {Name = GetSpellInfo(17926),	GlobalId = 17926,	Mana = 50,	Rank = 0,	Length = 120,	Type = 3}, -- Death Coil || Voile mortel
			[20] = {Name = GetSpellInfo(18871),	GlobalId = 18871,	Mana = 50,	Rank = 0,	Length = 15,	Type = 3}, -- Shadowburn || Brûlure de l'ombre
			[21] = {Name = GetSpellInfo(18932),	GlobalId = 18932,	Mana = 50,	Rank = 0,	Length = 10,	Type = 3}, -- Conflagration
			[22] = {Name = GetSpellInfo(11713),	GlobalId = 11713,	Mana = 50,	Rank = 0,	Length = 24,	Type = 4}, -- Curse of Agony || Malédiction Agonie
			[23] = {Name = GetSpellInfo(11708),	GlobalId = 11708,	Mana = 50,	Rank = 0,	Length = 120,	Type = 4}, -- Curse of Weakness || Malédiction Faiblesse
			[24] = {Name = GetSpellInfo(11717),	GlobalId = 11717,	Mana = 0 ,  Rank = 0, 	Length = 0,	    Type = 0}, -- Curse of Recklessness - removed in patch 3.1 || Malédiction Témérité || 
			[25] = {Name = GetSpellInfo(11719),	GlobalId = 11719,	Mana = 50,	Rank = 0,	Length = 30,	Type = 4}, -- Curse of Tongues || Malédiction Langage
			[26] = {Name = GetSpellInfo(11722),	GlobalId = 11722,	Mana = 50,	Rank = 0,	Length = 300,	Type = 4}, -- Curse of the Elements || Malédiction Eléments
			[27] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 180,	Type = 3}, -- NOPE NOT IN Classic  Metamorphosis || Metamorphose
			[28] = {Name = GetSpellInfo(18881),	GlobalId = 18881,	Mana = 50,	Rank = 0,	Length = 30,	Type = 6}, -- Siphon Life || Syphon de vie
			[29] = {Name = GetSpellInfo(17928),	GlobalId = 17928,	Mana = 50,	Rank = 0,	Length = 40,	Type = 3}, -- Howl of Terror || Hurlement de terreur
			[30] = {Name = GetSpellInfo(18540),	GlobalId = 18540,	Mana = 50,	Rank = 0,	Length = 1800,	Type = 3}, -- Ritual of Doom || Rituel funeste
			[31] = {Name = GetSpellInfo(11735),	GlobalId = 11735,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Demon Armor || Armure démoniaque
			[32] = {Name = GetSpellInfo(5697),	GlobalId = 5697,	Mana = 50,	Rank = 0,	Length = 600,	Type = 0}, -- Unending Breath || Respiration interminable
			[33] = {Name = GetSpellInfo(132),	GlobalId = 132,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Detect Invisibility || Détection de l'invisibilité
			[34] = {Name = GetSpellInfo(126),	GlobalId = 126,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Eye of Kilrogg
			[35] = {Name = GetSpellInfo(1098),	GlobalId = 1098,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Enslave Demon
			[36] = {Name = GetSpellInfo(696),	GlobalId = 696,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Demon Skin || Peau de démon 
			[37] = {Name = GetSpellInfo(698),	GlobalId = 698,		Mana = 50,	Rank = 0,	Length = 120,	Type = 3}, -- Ritual of Summoning || Rituel d'invocation
			[38] = {Name = GetSpellInfo(19028),	GlobalId = 19028,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Soul Link || Lien spirituel
			[39] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 45,	Type = 3}, -- NOPE NOT IN Classic  Demon Charge || Charge démoniaque
			[40] = {Name = GetSpellInfo(18223),	GlobalId = 18223,	Mana = 50,	Rank = 0,	Length = 12,	Type = 4}, -- Curse of Exhaustion || Malédiction de fatigue
			[41] = {Name = GetSpellInfo(11689),	GlobalId = 11689,	Mana = 50,	Rank = 0,	Length = 0,	    Type = 0}, -- Life Tap || Connexion
			[42] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 12,	Type = 2}, -- NOPE NOT IN Classic  Haunt || Hanter
			[43] = {Name = GetSpellInfo(28610),	GlobalId = 28610,	Mana = 50,	Rank = 0,	Length = 30,	Type = 0}, -- Shadow Ward || Gardien de l'ombre
			[44] = {Name = GetSpellInfo(18788),	GlobalId = 18788,	Mana = 50,	Rank = 0,	Length = 60,	Type = 3}, -- Demonic Sacrifice || Sacrifice démoniaque 
			[45] = {Name = GetSpellInfo(11661),	GlobalId = 11661,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Shadow Bolt
			[46] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 18,	Type = 6}, -- NOPE NOT IN Classic  Unstable Affliction || Affliction instable
			[47] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- NOPE NOT IN Classic  Fel Armor || Gangrarmure
			[48] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 18,	Type = 5}, -- NOPE NOT IN Classic  Seed of Corruption || Graine de Corruption
			[49] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 180,	Type = 3}, -- NOPE NOT IN Classic SoulShatter || Brise âme
			[50] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 300,	Type = 3}, -- NOPE NOT IN Classic Ritual of Souls || Rituel des âmes
			[51] = {Name = GetSpellInfo(20755),	GlobalId = 20755,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Create Soulstone || Création pierre d'âme
			[52] = {Name = GetSpellInfo(5699),	GlobalId = 5699,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Create Healthstone || Création pierre de soin
			[53] = {Name = GetSpellInfo(2362),	GlobalId = 2362,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Create Spellstone || Création pierre de sort
			[54] = {Name = GetSpellInfo(17951),	GlobalId = 17951,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Create Firestone || Création pierre de feu
			[55] = {Name = GetSpellInfo(18938),	GlobalId = 18938,	Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- Dark Pact || Pacte noir
			[56] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 0,		Type = 0}, -- NOPE NOT IN Classic  Shadow Cleave || Enchainement d'ombre
			[57] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 30,	Type = 3}, -- NOPE NOT IN Classic  Immolation Aura || Aura d'immolation
			[58] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0,	Length = 15,	Type = 3}, --  NOPE NOT IN Classic Challenging Howl || Hurlement de défi
			[59] = {Name = GetSpellInfo(133),	GlobalId = 133,		Mana = 50,	Rank = 0, 	Length = 60,	Type = 3}, --NOPE NOT IN Classic   Demonic Empowerment || Renforcement démoniaque
			Firestone = {
				SpellIds = {
					6366,  -- Lesser
					17951, -- Normal
					17952, -- Greater
					17953  -- Major
				}
			},
			Healthstone = {
				SpellIds = {
					6202,  -- Minor
					6201,  -- Lesser
					5699,  -- Normal
					11729, -- Greater
					11730  -- Major
				}
			},
			Soulstone = {
				SpellIds = {
					693,   -- Minor
					20752, -- Lesser
					20755, -- Normal
					20756, -- Greater
					20757  -- Major
				}
			},
			Spellstone = {
				SpellIds = {
					2362,  -- Normal
					17727, -- Greater
					17728  -- Major
				}
			}
		}

		MakeSpellIdRanks(self.Spell.Firestone)
		MakeSpellIdRanks(self.Spell.Healthstone)
		MakeSpellIdRanks(self.Spell.Soulstone)
		MakeSpellIdRanks(self.Spell.Spellstone)
		-- Type 0 = Pas de Timer || no timer
		-- Type 1 = Timer permanent principal || Standing main timer
		-- Type 2 = Timer permanent || main timer
		-- Type 3 = Timer de cooldown || cooldown timer
		-- Type 4 = Timer de malédiction || curse timer
		-- Type 5 = Timer de corruption || corruption timer
		-- Type 6 = Timer de combat || combat timer
	end
	
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	-- Relocalisation des Tooltips
	------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
	-- stones || Pierres
	local buttonTooltip = new("array",
		"Soulstone",
		"Healthstone",
		"Spellstone",
		"Firestone"
	)
	local colorCode = new("array",
		"|c00FF99FF", "|c0066FF33", "|c0099CCFF", "|c00FF4444"
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = colorCode[i]..self.Translation.Item[button].."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	
	-- Buffs
	local buttonTooltip = new("array",
		"Domination",
		"Enslave",
		"Armor",
		"FelArmor",
		"Invisible",
		"Aqua",
		"Kilrogg",
		"Banish",
		"TP",
		"RoS",
		"SoulLink",
		"ShadowProtection",
		"Renforcement"
	)
	local buttonName = new("array",
		15, 35, 31, 47, 33, 32, 34, 9, 37, 50, 38, 43, 59
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)

	-- Demons
	local buttonTooltip = new("array",
		"Sacrifice",
		"Charge",
		"Enchainement",
		"Immolation",
		"Defi",
		"Renforcement",
		"Enslave"
	)
	local buttonName = new("array",
		44, 39, 56, 57, 58, 59, 35
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"
	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
	
	-- Curses || Malédiction
	local buttonTooltip = new("array",
		"Weakness",
		"Agony",
		"Tongues",
		"Exhaust",
		"Elements",
		"Doom",
		"Corruption"
	)
	local buttonName = new("array",
		23, 22, 25, 40, 26, 16, 14
	)
	for i, button in ipairs(buttonTooltip) do
		if not self.TooltipData[button] then
			self.TooltipData[button] = {}
		end
		self.TooltipData[button].Label = "|c00FFFFFF"..self.Spell[buttonName[i]].Name.."|r"

	end
	del(buttonTooltip)
	del(colorCode)
	del(buttonName)
end

-- https://github.com/WeakAuras/WeakAuras2/wiki/Useful-Snippets
function Necrosis:GetManaCostForSpell(spellID)
	if (not spellID) then return end
	local cost = 0
	local costTable = GetSpellPowerCost(spellID);
	if (costTable == nil) then
		return false
	end
	return table.foreach(costTable,
		function(k,v)  
			if (v.name  == "MANA") then
				return v.cost;
			end 
		end
	)
end

local function UpdateSpellIfHigherRank(index, spellRank, spellID, spellNameOrg, globalId)
	-- Only update the spell stats if a higher rank has been found
	if (Necrosis.Spell[index].Rank < spellRank) then
		Necrosis.Spell[index].ID = spellID
		Necrosis.Spell[index].Rank = spellRank
		Necrosis.Spell[index].NameOrg = spellNameOrg
		Necrosis.Spell[index].GlobalId = globalId
		Necrosis.Spell[index].Mana = Necrosis:GetManaCostForSpell(spellNameOrg)
	end
end

-- My favourite feature! Create a list of spells known by the warlock sorted by name & rank || Ma fonction préférée ! Elle fait la liste des sorts connus par le démo, et les classe par rang.
-- Select the highest available spell in the case of stones. || Pour les pierres, elle sélectionne le plus haut rang connu
function Necrosis:SpellSetup()

	for index in ipairs(Necrosis.Spell) do
		Necrosis.Spell[index].ID = nil
		Necrosis.Spell[index].Rank = -1
	end

	local spellID = 1

	-- Search for all spells known by the warlock || On va parcourir tous les sorts possedés par le Démoniste
	while true do

		local spellName, subSpellName, globalId = GetSpellBookItemName(spellID, BOOKTYPE_SPELL)

		if (not spellName) then
			do break end
		end

		local spellNameOrg = spellName

		if (tContains(Necrosis.Spell.Healthstone.SpellIds, globalId)) then
			-- Healthstone
			local spellRank = Necrosis.Spell.Healthstone[globalId]
			UpdateSpellIfHigherRank(52, spellRank, spellID, spellNameOrg, globalId)
		elseif (tContains(Necrosis.Spell.Soulstone.SpellIds, globalId)) then
			-- Soulstone
			local spellRank = Necrosis.Spell.Soulstone[globalId]
			UpdateSpellIfHigherRank(51, spellRank, spellID, spellNameOrg, globalId)
		elseif (tContains(Necrosis.Spell.Firestone.SpellIds, globalId)) then
			-- Firestone
			local spellRank = Necrosis.Spell.Firestone[globalId]
			UpdateSpellIfHigherRank(54, spellRank, spellID, spellNameOrg, globalId)
		elseif (tContains(Necrosis.Spell.Spellstone.SpellIds, globalId)) then
			-- Spellstone
			local spellRank = Necrosis.Spell.Spellstone[globalId]
			UpdateSpellIfHigherRank(53, spellRank, spellID, spellNameOrg, globalId)
		elseif (subSpellName and subSpellName ~= " " and subSpellName ~= "") then
			-- For spells with numbered ranks, compare each one || Pour les sorts avec des rangs numérotés, on compare pour chaque sort les rangs 1 à 1
			-- And preserve the highest rank || Le rang supérieur est conservé
			local spellRank = Necrosis.Spells:GetRankNumberFromSubName(subSpellName)
			if (spellRank ~= nil) then
				for index = 1, #Necrosis.Spell, 1 do
					-- A version of the spell is already in our table
					if (Necrosis.Spell[index].Name == spellName) then
						UpdateSpellIfHigherRank(index, spellRank, spellID, spellNameOrg, globalId)
						break
					end
				end
			end
		else
			-- The spell has no subSpellName, like Ritual of Summoning or
			-- unavailable / not learned spells like Conflagrate
			-- Set rank = 0 for those spells
			for index = 1, #Necrosis.Spell, 1 do
				-- a version of the spell is already in our table
				if (Necrosis.Spell[index].Name == spellName) then
					UpdateSpellIfHigherRank(index, 0, spellID, spellNameOrg, globalId)
					break
				end
			end
		end
		spellID = spellID + 1
	end

	-- Update the spell durations according to their rank || On met à jour la durée de chaque sort en fonction de son rang
	-- Fear || Peur
	if (Necrosis.Spell[13].ID and Necrosis.Spell[13].Rank) then
		Necrosis.Spell[13].Length = tonumber(Necrosis.Spell[13].Rank) * 5 + 5
	end

	-- Corruption
	if (Necrosis.Spell[14].ID and Necrosis.Spell[14].Rank) then
		if (Necrosis.Spell[14].Rank <= 2) then
			Necrosis.Spell[14].Length = Necrosis.Spell[14].Rank * 3 + 9
		end
	end

	-- WoW 3.0 :  Les montures se retrouvent dans une interface à part
	-- if GetNumCompanions("MOUNT") > 0 then
	-- 	for i = 1, GetNumCompanions("MOUNT"), 1 do
	-- 		local _, NomCheval, SpellCheval = Necrosis:GetCompanionInfo("MOUNT", i)
	-- 		if NomCheval == Necrosis.Spell[1].Name then
	-- 			Necrosis.Spell[1].ID = SpellCheval
	-- 		end
	-- 		if NomCheval == Necrosis.Spell[2].Name then
	-- 			Necrosis.Spell[2].ID = SpellCheval
	-- 		end
	-- 	end
	-- end

	-- associate the mounts to the sphere button || Association du sort de monture correct au bouton
	if (Necrosis.Spell[1].ID or Necrosis.Spell[2].ID) then
		Necrosis.CurrentEnv.SteedAvailable = true
	else
		Necrosis.CurrentEnv.SteedAvailable = false
	end

	if (not InCombatLockdown()) then
		Necrosis:MainButtonAttribute()
		Necrosis:BuffSpellAttribute()
		Necrosis:PetSpellAttribute()
		Necrosis:CurseSpellAttribute()
		Necrosis:StoneAttribute(Necrosis.CurrentEnv.SteedAvailable)
	end

	Necrosis:BindName()
end
