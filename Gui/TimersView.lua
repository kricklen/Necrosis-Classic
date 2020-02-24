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
-- $LastChangedDate: 2008-10-18 19:51:42 +1100 (Sat, 18 Oct 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

Necrosis.Gui.TimersView = {
	Frame = false,
	ddTimers = false,
	lblTimers = false,
	cbEnableTimers = false,
	cbTimersGrowUpwards = false,
	cbTimersOnLeftSide = false,
	--        0           1            2
	_Types = {"Disabled", "Graphical", "Textual"}
}

local _tv = Necrosis.Gui.TimersView

function _tv:cbEnableTimers_Click()
	NecrosisConfig.ShowSpellTimers = self:GetChecked()
	if NecrosisConfig.ShowSpellTimers then
		NecrosisSpellTimerButton:Show()
	else
		NecrosisSpellTimerButton:Hide()
	end
end

function _tv:cbTimersOnLeftSide_Click()
	Necrosis:SymetrieTimer(self:GetChecked())
end

function _tv:cbTimersGrowUpwards_Click()
	if (self:GetChecked()) then
		NecrosisConfig.SensListe = -1
	else
		NecrosisConfig.SensListe = 1
	end
end

function _tv.ddTimers_Init(dd)
	for i,data in ipairs(_tv._Types) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Timers.Type[data],
			value = data,
			checked = false,
			func = _tv.ddTimers_Click,
			arg1 = dd
		})
		if data == NecrosisConfig.TimerType then
			UIDropDownMenu_SetSelectedValue(dd, data)
			UIDropDownMenu_SetText(dd, Necrosis.Config.Timers.Type[NecrosisConfig.TimerType])
		end
	end
	if NecrosisConfig.TimerType == "Disabled" then
		_tv.DisableTimers()
	else
		Necrosis:CreateTimerAnchor()
		if NecrosisConfig.TimerType == "Textual" then
			_tv.EnableTextualTimers()
		else
			_tv.EnableGraphicalTimers()
		end
	end
end

function _tv.ddTimers_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.TimerType = item.value
	if item.value == "Disabled" then
		_tv.DisableTimers()
	else
		Necrosis:CreateTimerAnchor()
		if item.value == "Textual" then
			_tv.EnableTextualTimers()
		else
			_tv.EnableGraphicalTimers()
		end
	end
end

function _tv.DisableTimers()
	_tv.cbTimersGrowUpwards:Disable()
	_tv.cbTimersOnLeftSide:Disable()
	if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
	local index = 1
	while _G["NecrosisTimerFrame"..index] do
		_G["NecrosisTimerFrame"..index]:Hide()
		index = index + 1
	end
end

function _tv.EnableTextualTimers()
	_tv.cbTimersGrowUpwards:Disable()
	_tv.cbTimersOnLeftSide:Enable()
	local index = 1
	while _G["NecrosisTimerFrame"..index] do
		_G["NecrosisTimerFrame"..index]:Hide()
		index = index + 1
	end
end

function _tv.EnableGraphicalTimers()
	_tv.cbTimersGrowUpwards:Enable()
	_tv.cbTimersOnLeftSide:Enable()
	if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
end

function _tv.UpdateTexts()
	UIDropDownMenu_Initialize(_tv.ddTimers, _tv.ddTimers_Init)
	UIDropDownMenu_SetText(_tv.ddTimers, Necrosis.Config.Timers.Type[NecrosisConfig.TimerType])
	_tv.lblTimers:SetText(Necrosis.Config.Timers["Type de timers"])
	_tv.cbEnableTimers:SetText(Necrosis.Config.Timers["Afficher le bouton des timers"])
	_tv.cbTimersGrowUpwards:SetText(Necrosis.Config.Timers["Afficher les timers de bas en haut"])
	_tv.cbTimersOnLeftSide:SetText(Necrosis.Config.Timers["Afficher les timers sur la gauche du bouton"])
end


-- Testing
local metatable = {
	__index = {
		["insert"] = table.insert,
		["remove"] = table.remove,
		["sort"] = table.sort,
	}
}

local timerManagement = {
	-- Spells to timer || Sorts à timer
	SpellTimer = setmetatable({}, metatable),
	-- Association of timers to Frames || Association des timers aux Frames
	TimerTable = setmetatable({}, metatable),
	-- Groups of timers by mobs || Groupes de timers par mobs
	SpellGroup = setmetatable(
		{
			{Name = "Rez", SubName = " ", Visible = 0},
			{Name = "Main", SubName = " ", Visible = 0},
			{Name = "Cooldown", SubName = " ", Visible = 0}
		},
		metatable
	),
	-- Last cast spell || Dernier sort casté
	LastSpell = {}
}


function _tv:Show()
	if not self.Frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)

		-- Affiche ou masque le bouton des timers
		self.cbEnableTimers = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher le bouton des timers"],
			0, -88,
			self.cbEnableTimers_Click
		)
		self.cbEnableTimers:SetChecked(NecrosisConfig.ShowSpellTimers)

		-- Affiche les timers sur la gauche du bouton
		self.cbTimersOnLeftSide = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher les timers sur la gauche du bouton"],
			0, -110,
			self.cbTimersOnLeftSide_Click
		)
		self.cbTimersOnLeftSide:SetChecked(NecrosisConfig.SpellTimerPos == -1)

		-- Affiche les timers de bas en haut
		self.cbTimersGrowUpwards = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher les timers de bas en haut"],
			0, -132,
			self.cbTimersGrowUpwards_Click
		)
		self.cbTimersGrowUpwards:SetChecked(NecrosisConfig.SensListe == -1)

		-- Handler to update texts when language changes
		EventHub:RegisterLanguageChangedHandler(self.UpdateTexts)

		-- Choix du timer graphique
		-- Initialize dropdown here so the checkboxes can be disabled/enabled
		self.ddTimers, self.lblTimers = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Timers["Type de timers"],
			0, -60,
			self.ddTimers_Init
		)
	
		self.btnTestTimer = GraphicsHelper:CreateButton(
			self.Frame,
			"Test timer",
			-200, -250,
			function(self)
				Necrosis.Timers:InsertSpellTimer(
					Necrosis.CurrentEnv.PlayerGuid,
					UnitGUID("target"), "target", 20,
					6222,
					"Corruption",
					Necrosis.Spell.AuraDuration[6222],
					Necrosis.Spell.AuraType[6222]
				)
			end
		)
		self.btnTestTimer:SetWidth(100)

		self.btnClearTimer = GraphicsHelper:CreateButton(
			self.Frame,
			"Clear timer",
			-90, -250,
			function(self)
				print("#Necrosis.Timers.ActiveTimers: "..#Necrosis.Timers.ActiveTimers)
				for data in pairs(Necrosis.Timers.ActiveTimers) do
					Necrosis.Timers:RemoveSpellTimerTarget(Necrosis.Timers.ActiveTimers[data].TargetGuid)
				end
			end
		)
		self.btnClearTimer:SetWidth(100)
	end

	self.Frame:Show()
end

function _tv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end
