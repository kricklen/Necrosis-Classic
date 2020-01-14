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

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

Necrosis.Gui.TimersView = {
	Frame = false,
	Types = {"Disabled", "Graphical", "Textual"}
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
	for i,data in ipairs(_tv.Types) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Timers.Type[data],
			value = data,
			checked = false,
			func = _tv.ddTimers_Click,
			arg1 = dd
			})
		if data == NecrosisConfig.TimerType then
			UIDropDownMenu_SetSelectedValue(dd, data)
		end
	end
end

function _tv.ddTimers_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.TimerType = item.value
	if not (item.value == "Disabled") then
		Necrosis:CreateTimerAnchor()
	end
	if item.value == "Disabled" then
		_tv.DisableTimers()
	elseif item.value == "Textual" then
		_tv.EnableTextualTimers()
	else
		_tv.EnableGraphicalTimers()
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

function _tv:Show()
	if not self.Frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)
		-- frame = CreateFrame("Frame", "NecrosisTimersConfig", NecrosisGeneralFrame)
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("BOTTOMLEFT")

		-- Choix du timer graphique
		self.ddTimers, self.lblTimers = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Timers["Type de timers"],
			0, -60
		)
		UIDropDownMenu_Initialize(self.ddTimers, self.ddTimers_Init)
		UIDropDownMenu_SetText(self.ddTimers, Necrosis.Config.Timers.Type[NecrosisConfig.TimerType])
		-- frame = CreateFrame("Frame", "NecrosisTimerSelection", NecrosisTimersConfig, "UIDropDownMenuTemplate")
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisTimersConfig, "BOTTOMRIGHT", 40, 400)

		-- local FontString = frame:CreateFontString("NecrosisTimerSelectionT", "OVERLAY", "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 35, 403)
		-- FontString:SetTextColor(1, 1, 1)

		-- UIDropDownMenu_SetWidth(frame, 125)

		-- Affiche ou masque le bouton des timers
		--parentFrame, text, x, y, onClickFunction
		self.cbEnableTimers = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher le bouton des timers"],
			0, -88,
			self.cbEnableTimers_Click
		)
		self.cbEnableTimers:SetChecked(NecrosisConfig.ShowSpellTimers)

		-- frame = CreateFrame("CheckButton", "NecrosisShowSpellTimerButton", NecrosisTimersConfig, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 325)

		-- frame:SetScript("OnClick", function(self)
		-- 	NecrosisConfig.ShowSpellTimers = self:GetChecked()
		-- 	if NecrosisConfig.ShowSpellTimers then
		-- 		NecrosisSpellTimerButton:Show()
		-- 	else
		-- 		NecrosisSpellTimerButton:Hide()
		-- 	end
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)
		-- -- frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Affiche les timers sur la gauche du bouton
		self.cbTimersOnLeftSide = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher les timers sur la gauche du bouton"],
			0, -110,
			self.cbTimersOnLeftSide_Click
		)
		self.cbTimersOnLeftSide:SetChecked(NecrosisConfig.SpellTimerPos == -1)
		-- frame = CreateFrame("CheckButton", "NecrosisTimerOnLeft", NecrosisTimersConfig, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 300)

		-- frame:SetScript("OnClick", function(self)
		-- 	Necrosis:SymetrieTimer(self:GetChecked())
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)
		-- -- frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Affiche les timers de bas en haut
		self.cbTimersGrowUpwards = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Timers["Afficher les timers de bas en haut"],
			0, -132,
			self.cbTimersGrowUpwards_Click
		)
		self.cbTimersGrowUpwards:SetChecked(NecrosisConfig.SensListe == -1)
		-- frame = CreateFrame("CheckButton", "NecrosisTimerUpward", NecrosisTimersConfig, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisTimersConfig, "BOTTOMLEFT", 25, 275)

		-- frame:SetScript("OnClick", function(self)
		-- 	if (self:GetChecked()) then
		-- 		NecrosisConfig.SensListe = -1
		-- 	else
		-- 		NecrosisConfig.SensListe = 1
		-- 	end
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)
		-- -- frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		if NecrosisConfig.TimerType == 0 then
			self.cbTimersGrowUpwards:Disable()
			self.cbTimersOnLeftSide:Disable()

		elseif NecrosisConfig.TimerType == 2 then
			self.cbTimersGrowUpwards:Disable()
			self.cbTimersOnLeftSide:Enable()
		else
			self.cbTimersGrowUpwards:Enable()
			self.cbTimersOnLeftSide:Enable()
		end
	end

	-- UIDropDownMenu_Initialize(NecrosisTimerSelection, Necrosis.Timer_Init)

	-- NecrosisTimerSelectionT:SetText(self.Config.Timers["Type de timers"])
	-- NecrosisShowSpellTimerButton:SetText(self.Config.Timers["Afficher le bouton des timers"])
	-- NecrosisTimerOnLeft:SetText(self.Config.Timers["Afficher les timers sur la gauche du bouton"])
	-- NecrosisTimerUpward:SetText(self.Config.Timers["Afficher les timers de bas en haut"])

	-- UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, (NecrosisConfig.TimerType + 1))
	-- UIDropDownMenu_SetText(NecrosisTimerSelection, Necrosis.Config.Timers.Type[NecrosisConfig.TimerType + 1])

	-- NecrosisShowSpellTimerButton:SetChecked(NecrosisConfig.ShowSpellTimers)
	-- NecrosisTimerOnLeft:SetChecked(NecrosisConfig.SpellTimerPos == -1)
	-- NecrosisTimerUpward:SetChecked(NecrosisConfig.SensListe == -1)

	-- if NecrosisConfig.TimerType == 0 then
	-- 	NecrosisTimerUpward:Disable()
	-- 	NecrosisTimerOnLeft:Disable()

	-- elseif NecrosisConfig.TimerType == 2 then
	-- 	NecrosisTimerUpward:Disable()
	-- 	NecrosisTimerOnLeft:Enable()
	-- else
	-- 	NecrosisTimerOnLeft:Enable()
	-- 	NecrosisTimerUpward:Enable()
	-- end

	self.Frame:Show()
end

function _tv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des timers
function Necrosis.Timer_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Timers.Type) do
		element.text = Necrosis.Config.Timers.Type[i]
		element.checked = false
		element.func = Necrosis.Timer_Click
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Timer_Click(self)
	local ID = self:GetID()
	UIDropDownMenu_SetSelectedID(NecrosisTimerSelection, ID)
	NecrosisConfig.TimerType = ID - 1
	if not (ID == 1) then Necrosis:CreateTimerAnchor() end
	if ID == 1 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Disable()
		if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
		local index = 1
		while _G["NecrosisTimerFrame"..index] do
			_G["NecrosisTimerFrame"..index]:Hide()
			index = index + 1
		end
	elseif ID == 3 then
		NecrosisTimerUpward:Disable()
		NecrosisTimerOnLeft:Enable()
		local index = 1
		while _G["NecrosisTimerFrame"..index] do
			_G["NecrosisTimerFrame"..index]:Hide()
			index = index + 1
		end
	else
		NecrosisTimerUpward:Enable()
		NecrosisTimerOnLeft:Enable()
		if _G["NecrosisListSpells"] then NecrosisListSpells:SetText("") end
	end
end
