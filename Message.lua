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
-- Version $LastChangedDate: 2008-10-19 14:52:05 +1100 (Sun, 19 Oct 2008) $
------------------------------------------------------------------------------------------------------

-- One defines G as being the table containing all the existing frames.
-- local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- Message handler (CONSOLE, CHAT, MESSAGE SYSTEM)
------------------------------------------------------------------------------------------------------

Necrosis.Chat = {
	LastSoulstoneMessageNumber = false,
	LastMountMessageNumber = false,
	LastRitualOfSoulsMessageNumber = false,
	LastRitualOfSummoningMessageNumber = false,
	LastDemonMessageNumber = false,
	LastDemonicSacrificeMessageNumber = false,
	TargetName = false,
	PetType = false,
	MsgTableAfter = false,
	MsgTableBefore = false
}

local _chat = Necrosis.Chat

------------------------------------------------------------------------------------------------------
-- Handles the posting of messages while casting a spell.
------------------------------------------------------------------------------------------------------
function Necrosis:Speech_It(Spell, Speeches, metatable)
	if not NecrosisConfig.ChatMsg then
		-- Chat messages have been disabled
		return nil
	end
	-- messages to be posted while summoning a mount
	if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
		print("Necrosis:Speech_It: Summoning mount...")
		if NecrosisConfig.SteedSummon then
			_chat:SummonMount()
		else
			print("Summon Mount speech disabled")
		end
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
		-- Speeches.SpellSucceed.Steed = setmetatable({}, metatable)
		-- if NecrosisConfig.SteedSummon and NecrosisConfig.ChatMsg and self.Speech.Demon[7] and not NecrosisConfig.SM then
		-- 	local tempnum = math.random(1, #self.Speech.Demon[7])
		-- 	while tempnum == Speeches.LastSpeech.Steed and #self.Speech.Demon[7] >= 2 do
		-- 		tempnum = math.random(1, #self.Speech.Demon[7])
		-- 	end
		-- 	Speeches.LastSpeech.Steed = tempnum
		-- 	for i in ipairs(self.Speech.Demon[7][tempnum]) do
		-- 		if self.Speech.Demon[7][tempnum][i]:find("<after>") then
		-- 			Speeches.SpellSucceed.Steed:insert(self.Speech.Demon[7][tempnum][i])
		-- 		elseif self.Speech.Demon[7][tempnum][i]:find("<emote>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "EMOTE")
		-- 		elseif self.Speech.Demon[7][tempnum][i]:find("<yell>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "YELL")
		-- 		else
		-- 			self:Msg(self:MsgReplace(self.Speech.Demon[7][tempnum][i]), "SAY")
		-- 		end
		-- 	end
		-- end
	-- messsages to be posted while casting 'Ritual of Souls' -Draven (April 3rd, 2008)
	elseif Spell.Name == Necrosis.Spell[50].Name then
		print("Necrosis:Speech_It: Casting Ritual of Souls...")
		if NecrosisConfig.RoSSummon then
			_chat:CastRitualOfSouls()
		else
			print("Ritual of Souls speech disabled")
		end
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
		-- Speeches.SpellSucceed.RoS = setmetatable({}, metatable)
		-- if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and NecrosisConfig.RoSSummon and self.Speech.RoS then
		-- 	local tempnum = math.random(1, #self.Speech.RoS)
		-- 	while tempnum == Speeches.LastSpeech.RoS and #self.Speech.RoS >= 2 do
		-- 		tempnum = math.random(1, #self.Speech.RoS)
		-- 	end
		-- 	Speeches.LastSpeech.RoS = tempnum
		-- 	for i in ipairs(self.Speech.RoS[tempnum]) do
		-- 		if self.Speech.RoS[tempnum][i]:find("<after>") then
		-- 			Speeches.SpellSucceed.RoS:insert(self.Speech.RoS[tempnum][i])
		-- 		elseif self.Speech.RoS[tempnum][i]:find("<emote>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "EMOTE")
		-- 		elseif self.Speech.RoS[tempnum][i]:find("<yell>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "YELL")
		-- 		else
		-- 			self:Msg(self:MsgReplace(self.Speech.RoS[tempnum][i]), "WORLD")
		-- 		end
		-- 	end
		-- end
	-- messages to be posted while casting 'Soulstone' on a friendly target
	elseif Spell.Name == Necrosis.Spell[11].Name and not (Spell.TargetName == UnitName("player")) then
		print("Necrosis:Speech_It:: Casting Soulstone...")
		_chat:CastSoulstone(Spell.TargetName)
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
		-- Speeches.SpellSucceed.Rez = setmetatable({}, metatable)
		-- if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.Rez then
		-- 	local tempnum = math.random(1, #self.Speech.Rez)
		-- 	while tempnum == Speeches.LastSpeech.Rez and #self.Speech.Rez >= 2 do
		-- 		tempnum = math.random(1, #self.Speech.Rez)
		-- 	end
		-- 	Speeches.LastSpeech.Rez = tempnum
		-- 	for i in ipairs(self.Speech.Rez[tempnum]) do
		-- 		if self.Speech.Rez[tempnum][i]:find("<after>") then
		-- 			Speeches.SpellSucceed.Rez:insert(self.Speech.Rez[tempnum][i])
		-- 		elseif self.Speech.Rez[tempnum][i]:find("<emote>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "EMOTE")
		-- 		elseif self.Speech.Rez[tempnum][i]:find("<yell>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "YELL")
		-- 		else
		-- 			self:Msg(self:MsgReplace(self.Speech.Rez[tempnum][i], Spell.TargetName), "WORLD")
		-- 		end
		-- 	end
		-- end
	-- messages to be posted while casting 'Ritual of Summoning'
	elseif Spell.Name == Necrosis.Spell[37].Name then
		print("Necrosis:Speech_It: Casting Ritual of Summoning...")
		_chat:CastRitualOfSummoning(Spell.TargetName)
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
		-- Speeches.SpellSucceed.TP = setmetatable({}, metatable)
		-- if (NecrosisConfig.ChatMsg or NecrosisConfig.SM) and self.Speech.TP then
		-- 	local tempnum = math.random(1, #self.Speech.TP)
		-- 	while tempnum == Speeches.LastSpeech.TP and #self.Speech.TP >= 2 do
		-- 		tempnum = math.random(1, #self.Speech.TP)
		-- 	end
		-- 	Speeches.LastSpeech.TP = tempnum
		-- 	for i in ipairs(self.Speech.TP[tempnum]) do
		-- 		if self.Speech.TP[tempnum][i]:find("<after>") then
		-- 			Speeches.SpellSucceed.TP:insert(self.Speech.TP[tempnum][i])
		-- 		elseif self.Speech.TP[tempnum][i]:find("<emote>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "EMOTE")
		-- 		elseif self.Speech.TP[tempnum][i]:find("<yell>") then
		-- 			self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "YELL")
		-- 		else
		-- 			self:Msg(self:MsgReplace(self.Speech.TP[tempnum][i], Spell.TargetName), "WORLD")
		-- 		end
		-- 	end
		-- end
		AlphaBuffMenu = 1
		AlphaBuffVar = GetTime() + 3
	-- Messages for summoning Imp
	elseif Spell.Name == Necrosis.Spell[3].Name then
		print("Necrosis:Speech_It: Casting Summon Imp...")
		_chat:CastSummonDemon("Imp")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
	-- Messages for summoning Voidwalker
	elseif Spell.Name == Necrosis.Spell[4].Name then
		print("Necrosis:Speech_It: Casting Summon Voidwalker...")
		_chat:CastSummonDemon("Voidwalker")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
	-- Messages for summoning Succubus
	elseif Spell.Name == Necrosis.Spell[5].Name then
		print("Necrosis:Speech_It: Casting Summon Succubus...")
		_chat:CastSummonDemon("Succubus")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
	-- Messages for summoning Felhunter
	elseif Spell.Name == Necrosis.Spell[6].Name then
		print("Necrosis:Speech_It: Casting Summon Felhunter...")
		_chat:CastSummonDemon("Felhunter")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
	-- Messages for summoning Felguard
	elseif Spell.Name == Necrosis.Spell[7].Name then
		print("Necrosis:Speech_It: Casting Summon Felguard...")
		_chat:CastSummonDemon("Felguard")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
	-- Messages for Demonic Sacrifice
	elseif Spell.Name == Necrosis.Spell[44].Name then
		-- TODO: Need to get the active pet type
		print("Necrosis:Speech_It: Casting Demonic Sacrifice...")
		_chat:CastDemonicSacrifice("Imp")
		print("_chat.MsgTableAfter: "..tostring(_chat.MsgTableAfter)..", "..tostring(#_chat.MsgTableAfter))
		-- messages to be posted while summoning a pet demon
	else
		print("Necrosis:Speech_It: Spell cast: "..Spell.Name)
		-- for type = 3, 7, 1 do
		-- 	if Spell.Name == Necrosis.Spell[type].Name then
		-- 		Speeches.SpellSucceed.Pet = setmetatable({}, metatable)
		-- 		Speeches.SpellSucceed.Sacrifice = setmetatable({}, metatable)
		-- 		Speeches.DemonName = type - 2
		-- 		if NecrosisConfig.DemonSummon and NecrosisConfig.ChatMsg and not NecrosisConfig.SM then
		-- 			local generalSpeechNum = math.random(1, 10) -- show general speech if num is 9 or 10

		-- 			if (not NecrosisConfig.PetName[Speeches.DemonName] or generalSpeechNum > 8) and self.Speech.Demon[6] then
		-- 				local tempnum = math.random(1, #self.Speech.Demon[6])
		-- 				while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[6] >= 2 do
		-- 					tempnum = math.random(1, #self.Speech.Demon[6])
		-- 				end
		-- 				Speeches.LastSpeech.Pet = tempnum
		-- 				for i in ipairs(self.Speech.Demon[6][tempnum]) do
		-- 					if self.Speech.Demon[6][tempnum][i]:find("<after>") then
		-- 						Speeches.SpellSucceed.Pet:insert(self.Speech.Demon[6][tempnum][i])
		-- 					elseif self.Speech.Demon[6][tempnum][i]:find("<sacrifice>")then
		-- 						Speeches.SpellSucceed.Sacrifice:insert(self.Speech.Demon[6][tempnum][i])
		-- 					elseif self.Speech.Demon[6][tempnum][i]:find("<emote>") then
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "EMOTE")
		-- 					elseif self.Speech.Demon[6][tempnum][i]:find("<yell>") then
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "YELL")
		-- 					else
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[6][tempnum][i]), "SAY")
		-- 					end
		-- 				end
		-- 			elseif self.Speech.Demon[Speeches.DemonName] then
		-- 				local tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
		-- 				while tempnum == Speeches.LastSpeech.Pet and #self.Speech.Demon[Speeches.DemonName] >= 2 do
		-- 					tempnum = math.random(1, #self.Speech.Demon[Speeches.DemonName])
		-- 				end
		-- 				Speeches.LastSpeech.Pet = tempnum
		-- 				for i in ipairs(self.Speech.Demon[Speeches.DemonName][tempnum]) do
		-- 					if self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<after>") then
		-- 						Speeches.SpellSucceed.Pet:insert(
		-- 							self.Speech.Demon[Speeches.DemonName][tempnum][i]
		-- 						)
		-- 					elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<sacrifice>")then
		-- 						Speeches.SpellSucceed.Sacrifice:insert(
		-- 							self.Speech.Demon[Speeches.DemonName][tempnum][i]
		-- 						)
		-- 					elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<emote>") then
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "EMOTE")
		-- 					elseif self.Speech.Demon[Speeches.DemonName][tempnum][i]:find("<yell>") then
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "YELL")
		-- 					else
		-- 						self:Msg(self:MsgReplace(self.Speech.Demon[Speeches.DemonName][tempnum][i], nil , Speeches.DemonName), "SAY")
		-- 					end
		-- 				end
		-- 			end
		-- 		end
		-- 		AlphaPetMenu = 1
		-- 		AlphaPetVar = GetTime() + 3
		-- 	end
		-- end
	end
	return Speeches
end

------------------------------------------------------------------------------------------------------
-- Handles the posting of messages after a spell has been cast.
------------------------------------------------------------------------------------------------------
function Necrosis:Speech_Then(Spell, DemonName, Speech)
-- TODO need to be fixed ..
	if (_chat.MsgTableAfter) then
		print("Necrosis:Speech_Then: Posting messages after spellcast: "..tostring(#_chat.MsgTableAfter))
		_chat:_PostMessages(_chat.MsgTableAfter)
		_chat.MsgTableAfter = nil
	end

	-- -- messages to be posted after a mount is summoned.
	-- if (Spell.Name == Necrosis.Spell[1].Name or Spell.Name == Necrosis.Spell[2].Name) then
	-- 	for i in ipairs(Speech.Steed) do
	-- 		if Speech.Steed[i]:find("<emote>") then
	-- 			self:Msg(self:MsgReplace(Speech.Steed[i]), "EMOTE")
	-- 		elseif Speech.Steed[i]:find("<yell>") then
	-- 			self:Msg(self:MsgReplace(Speech.Steed[i]), "YELL")
	-- 		else
	-- 			self:Msg(self:MsgReplace(Speech.Steed[i]), "WORLD")
	-- 		end
	-- 	end
	-- 	Speech.Steed = {}
	-- 	if _G["NecrosisMountButton"] then
	-- 		local gh = GraphicsHelper:create()
	-- 		NecrosisMountButton:SetNormalTexture(gh:GetTexture("MountButton-02"))
	-- 	end
	-- -- messages to be posted after a 'Ritual of Souls' is cast -Draven (April 3rd, 2008)
	-- elseif Spell.Name == Necrosis.Spell[50].Name then
	-- 	for i in ipairs(Speech.RoS) do
	-- 		if Speech.RoS[i]:find("<emote>") then
	-- 			self:Msg(self:MsgReplace(Speech.RoS[i]), "EMOTE")
	-- 		elseif Speech.RoS[i]:find("<yell>") then
	-- 			self:Msg(self:MsgReplace(Speech.RoS[i]), "YELL")
	-- 		else
	-- 			self:Msg(self:MsgReplace(Speech.RoS[i]), "WORLD")
	-- 		end
	-- 	end
	-- 	Speech.RoS = {}
	-- -- messages to be posted after 'Soulstone' is cast
	-- elseif Spell.Name == Necrosis.Spell[11].Name then
	-- 	for i in ipairs(Speech.Rez) do
	-- 		if Speech.Rez[i]:find("<emote>") then
	-- 			self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "EMOTE")
	-- 		elseif Speech.Rez[i]:find("<yell>") then
	-- 			self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "YELL")
	-- 		else
	-- 			self:Msg(self:MsgReplace(Speech.Rez[i], Spell.TargetName), "WORLD")
	-- 		end
	-- 	end
	-- 	Speech.Rez = {}
	-- -- messages to be posted after 'Ritual of Summoning' is cast
	-- elseif (Spell.Name == Necrosis.Spell[37].Name) then
	-- 	for i in ipairs(Speech.TP) do
	-- 		if Speech.TP[i]:find("<emote>") then
	-- 			self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "EMOTE")
	-- 		elseif Speech.TP[i]:find("<yell>") then
	-- 			self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "YELL")
	-- 		else
	-- 			self:Msg(self:MsgReplace(Speech.TP[i], Spell.TargetName), "WORLD")
	-- 		end
	-- 	end
	-- 	Speech.TP = {}
	-- -- messages to be posted after sacrificing a demon
	-- elseif Spell.Name == Necrosis.Spell[44].Name then
	-- 	for i in ipairs(Speech.Sacrifice) do
	-- 		if Speech.Sacrifice[i]:find("<emote>") then
	-- 			self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "EMOTE")
	-- 		elseif Speech.Sacrifice[i]:find("<yell>") then
	-- 			self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "YELL")
	-- 		else
	-- 			self:Msg(self:MsgReplace(Speech.Sacrifice[i], nil, DemonName), "SAY")
	-- 		end
	-- 	end
	-- 	Speech.Sacrifice = {}
	-- -- messages to be posted after summoning a demon
	-- elseif Spell.Name == Necrosis.Spell[3].Name
	-- 		or Spell.Name == Necrosis.Spell[4].Name
	-- 		or Spell.Name == Necrosis.Spell[5].Name
	-- 		or Spell.Name == Necrosis.Spell[6].Name
	-- 		or Spell.Name == Necrosis.Spell[7].Name
	-- 		then
	-- 			for i in ipairs(Speech.Pet) do
	-- 				if Speech.Pet[i]:find("<emote>") then
	-- 					self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "EMOTE")
	-- 				elseif Speech.Pet[i]:find("<yell>") then
	-- 					self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "YELL")
	-- 				else
	-- 					self:Msg(self:MsgReplace(Speech.Pet[i], nil, DemonName), "SAY")
	-- 				end
	-- 			end
	-- 			Speech.Pet = {}
	-- end

	-- return Speech
end


--
-- Start of refactored code
--

function _chat:CastSoulstone(targetName)
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.Soulstone,
		Necrosis.Speech.Rez
	)
	if not msgTable then
		print("No messages for Soulstone available...")
		return nil
	end
	-- Set available values
	self.TargetName = targetName
	self.PetType = nil
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastSoulstoneMessageNumber = self:_PostRandomMessage(msgTable, self.LastSoulstoneMessageNumber)
end

function _chat:SummonMount()
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.Mount,
		Necrosis.Speech.Mount
	)
	if not msgTable then
		print("No messages for Mount available...")
		return nil
	end
	-- Set available values
	self.TargetName = nil
	self.PetType = nil
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastMountMessageNumber = self:_PostRandomMessage(msgTable, self.LastMountMessageNumber)
end

function _chat:CastRitualOfSouls()
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.RitualOfSouls,
		Necrosis.Speech.RoS
	)
	if not msgTable then
		print("No messages for RitualOfSouls available...")
		return nil
	end
	-- Set available values
	self.TargetName = nil
	self.PetType = nil
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastRitualOfSoulsMessageNumber = self:_PostRandomMessage(msgTable, self.LastRitualOfSoulsMessageNumber)
end

function _chat:CastRitualOfSummoning(targetName)
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.RitualOfSummoning,
		Necrosis.Speech.TP
	)
	if not msgTable then
		print("No messages for RitualOfSummoning available...")
		return nil
	end
	-- Set available values
	self.TargetName = targetName
	self.PetType = nil
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastRitualOfSummoningMessageNumber = self:_PostRandomMessage(msgTable, self.LastRitualOfSummoningMessageNumber)
end

function _chat:SummonDemon(petType)
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.Demon,
		Necrosis.Speech.Demon[petType]
	)
	if not msgTable then
		print("No messages for Demon available...")
		return nil
	end
	-- Set available values
	self.TargetName = nil
	self.PetType = petType
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastDemonMessageNumber = self:_PostRandomMessage(msgTable, self.LastDemonMessageNumber)
end

function _chat:CastDemonicSacrifice(petType)
	-- Determine the message source table
	local msgTable = self:_GetShortOrFullMsgTable(
		Necrosis.Speech.ShortMessage.DemonicSacrifice,
		Necrosis.Speech.DemonicSacrifice[petType]
	)
	if not msgTable then
		print("No messages for DemonicSacrifice available...")
		return nil
	end
	-- Set available values
	self.TargetName = nil
	self.PetType = petType
	-- Create and post random message
	-- Also set messages to be posted after the spell has been cast successfully
	self.LastDemonicSacrificeMessageNumber = self:_PostRandomMessage(msgTable, self.LastDemonicSacrificeMessageNumber)
end

function _chat:_GetShortOrFullMsgTable(shortMsgTable, fullMsgTable)
	if NecrosisConfig.SM then
		-- Check if any short messages are available
		if (not shortMsgTable) then
			print("No shortMessageTable entries available, aborting...")
			return nil
		end
		return shortMsgTable
	else
		-- Check if any normal messages are available
		if (not fullMsgTable) then
			print("No fullMsgTable entries available, aborting...")
			return nil
		end
		return fullMsgTable
	end
end

function _chat:_PostRandomMessage(msgTable, lastMsgNumber)
	-- Take a random message, if possible not the same as last time
	local lastMsgNumber, msgList = self:_GetRandomMessageNumber(lastMsgNumber, msgTable)
	self:_PrepareMessageTables(msgList)
	-- Post immediate messages before the spell is cast
	self:_PostMessages(self.MsgTableBefore)
	-- Other messages are posted after the spell finishes
	return lastMsgNumber
end

function _chat:_GetRandomMessageNumber(lastNumber, msgTable)
	local tmp = 0
	repeat 
		tmp = math.random(1, #msgTable)
	until (not (tmp == lastNumber) or #msgTable == 1)
	return tmp, msgTable[tmp]
end

function _chat:_PrepareMessageTables(msgList)
	self.MsgTableBefore = {}
	self.MsgTableAfter = {}
	for i in ipairs(msgList) do
		-- Check if the message should be posted before or after spellcast
		if string.find(msgList[i], "<after>") then
			-- Remove the <after> meta tag from the message before storing it
			table.insert(self.MsgTableAfter, self:_ParseChannelAndMessageData(string.gsub(msgList[i], "<after>", "", 1)))
		else
			table.insert(self.MsgTableBefore, self:_ParseChannelAndMessageData(msgList[i]))
		end
	end
end

function _chat:_ParseChannelAndMessageData(msg)
	local chatType
	if string.find(msg, "<emote>") then
		chatType = "EMOTE"
	elseif string.find(msg, "<yell>") then
		chatType = "YELL"
	else
		chatType = "WORLD"
	end
	return {channel = chatType, msg = self:_ReplaceMessagePlaceholders(msg)}
end

------------------------------------------------------------------------------------------------------
-- Replace user-friendly string variables in the invocation messages
------------------------------------------------------------------------------------------------------
function _chat:_ReplaceMessagePlaceholders(msg)
	msg = msg:gsub("<player>", UnitName("player"))
	msg = msg:gsub("<emote>", "")
	msg = msg:gsub("<after>", "")
	msg = msg:gsub("<sacrifice>", "")
	msg = msg:gsub("<yell>", "")
	if self.TargetName then
		msg = msg:gsub("<target>", self.TargetName)
	end
	if self.PetType and NecrosisConfig.PetName[pet] then
		msg = msg:gsub("<pet>", NecrosisConfig.PetName[self.PetType])
	end
	return msg
end

function _chat:_PostMessages(msgTable)
	print("_chat:_PostMessages: "..tostring(#msgTable))
	for i,data in ipairs(msgTable) do
		self:_Msg(data.msg, data.channel)
	end
end

function _chat:_Msg(msg, channel)
	-- dispatch the message to the appropriate chat channel depending on the message type
	if (channel == "WORLD") then
		local groupMembersCount = GetNumGroupMembers()
		if (groupMembersCount > 5) then
			-- send to all raid members
			channel = "RAID"
		elseif (groupMembersCount > 0) then
			-- send to party members
			channel = "PARTY"
		else
			-- not in a group so lets use the 'say' channel
			channel = "SAY"
		end
	end

-- check this: https://wow.gamepedia.com/Viewing_Blizzard%27s_interface_code

	print("_chat:_Msg: "..channel..", "..msg)
	if (channel == "PARTY") then
		SendChatMessage(msg, _G.PARTY)
	elseif (channel == "RAID") then
		SendChatMessage(msg, _G.RAID)
	elseif (channel == "SAY") then
		-- try this
		pcall(SendChatMessage, msg, _G.SAY)
		--SendChatMessage(msg, _G.SAY)
	elseif (channel == "EMOTE") then
		SendChatMessage(msg, _G.EMOTE)
	elseif (channel == "YELL") then
		SendChatMessage(msg, _G.YELL)
	else
		-- Add some color to our message :D
		local msg = self._ColorizeMessage(msg)
		local intro = "|CFFFF00FFNe|CFFFF50FFcr|CFFFF99FFos|CFFFFC4FFis|CFFFFFFFF: "
		if NecrosisConfig.ChatType then
			-- ...... on the first chat frame
			ChatFrame1:AddMessage(intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
		else
			-- ...... on the middle of the screen
			UIErrorsFrame:AddMessage(intro..msg, 1.0, 0.7, 1.0, 1.0, UIERRORS_HOLD_TIME)
		end
	end
end

-- Replace any color strings in the message with its associated value
function _chat:_ColorizeMessage(msg)
	if type(msg) == "string" then
		msg = msg:gsub("<white>", "|CFFFFFFFF")
		msg = msg:gsub("<lightBlue>", "|CFF99CCFF")
		msg = msg:gsub("<brightGreen>", "|CFF00FF00")
		msg = msg:gsub("<lightGreen2>", "|CFF66FF66")
		msg = msg:gsub("<lightGreen1>", "|CFF99FF66")
		msg = msg:gsub("<yellowGreen>", "|CFFCCFF66")
		msg = msg:gsub("<lightYellow>", "|CFFFFFF66")
		msg = msg:gsub("<darkYellow>", "|CFFFFCC00")
		msg = msg:gsub("<lightOrange>", "|CFFFFCC66")
		msg = msg:gsub("<dirtyOrange>", "|CFFFF9933")
		msg = msg:gsub("<darkOrange>", "|CFFFF6600")
		msg = msg:gsub("<redOrange>", "|CFFFF3300")
		msg = msg:gsub("<red>", "|CFFFF0000")
		msg = msg:gsub("<lightRed>", "|CFFFF5555")
		msg = msg:gsub("<lightPurple1>", "|CFFFFC4FF")
		msg = msg:gsub("<lightPurple2>", "|CFFFF99FF")
		msg = msg:gsub("<purple>", "|CFFFF50FF")
		msg = msg:gsub("<darkPurple1>", "|CFFFF00FF")
		msg = msg:gsub("<darkPurple2>", "|CFFB700B7")
		msg = msg:gsub("<close>", "|r")
	end
	return msg
end
