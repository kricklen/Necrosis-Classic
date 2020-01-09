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
-- $LastChangedDate: 2008-10-26 18:56:51 +1100 (Sun, 26 Oct 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- CREATING THE OPTIONS FRAME
------------------------------------------------------------------------------------------------------

Gui.Views.MessagesConfig = {
	Frame = false,
	ddLanguage = false,
	cbShowTooltip = false,

}

-- function Necrosis:SetMessagesConfig()
function Gui.Views.MessagesConfig:Show()
	-- Check if the frame has been initialized before
	-- local frame = _G["NecrosisMessagesConfig"]

	if not self.Frame then
		-- Create the window
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)
		-- self.Frame = CreateFrame("Frame", nil, NecrosisGeneralFrame)
		-- self.Frame:SetFrameStrata("DIALOG")
		-- self.Frame:SetMovable(false)
		-- self.Frame:EnableMouse(true)
		-- self.Frame:SetHeight(324)
		-- self.Frame:SetWidth(340)
		-- self.Frame:Show()
		-- self.Frame:ClearAllPoints()
		-- self.Frame:SetPoint("CENTER", 0, 8)

		-- Language selection
		self.ddLanguage, self.lblLanguage = GraphicsHelper:CreateDropDown(
			self.Frame,
			"Langue / Language / Sprache",
			0, 0
		)
		Gui.ViewModels.MessagesVm.LanguageDropDownInit(self.ddLanguage)

		-- Turn on help bubbles
		self.cbShowTooltip = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Afficher les bulles d'aide"],
			0, -28,
			function(self) NecrosisConfig.NecrosisToolTip = self:GetChecked() end)

		-- Move messages to the system area
		self.cbChatType = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Afficher les messages dans la zone systeme"],
			0, -56,
			function(self)
				NecrosisConfig.ChatType = not self:GetChecked()
				Necrosis:Msg(Necrosis.Config.Messages.Position)
			end
		)

		-- Activate TP and Rez messages
		self.cbSpeech = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Activer les messages aleatoires de TP et de Rez"],
			0, -84,
			function(self)
				NecrosisConfig.ChatMsg = self:GetChecked()
				if not NecrosisConfig.ChatMsg then
					self.cbShortMessages:Disable()
					self.cbDemonMessages:Disable()
					self.cbMountMessages:Disable()
					self.cbRoSMessages:Disable()
				else
					self.cbShortMessages:Enable()
					self.cbDemonMessages:Enable()
					self.cbMountMessages:Enable()
					self.cbRoSMessages:Enable()
				end
			end
		)

		-- Activate short messages
		self.cbShortMessages = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Utiliser des messages courts"],
			20, -112,
			function(cb)
				NecrosisConfig.SM = cb:GetChecked()
				if NecrosisConfig.SM then
					Necrosis.Speech.Rez = Necrosis.Speech.ShortMessage[1]
					Necrosis.Speech.TP = Necrosis.Speech.ShortMessage[2]
					self.cbDemonMessages:Disable()
					self.cbMountMessages:Disable()
				else
					self.cbDemonMessages:Enable()
					self.cbMountMessages:Enable()
				end
			end
		)

		-- Activate demon messages
		self.cbDemonMessages = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Activer egalement les messages pour les Demons"],
			20, -140,
			function(cb)
				NecrosisConfig.DemonSummon = cb:GetChecked()
			end
		)

		-- Activate mount messages
		self.cbMountMessages = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Activer egalement les messages pour les Montures"],
			20, -168,
			function(self)
				NecrosisConfig.SteedSummon = self:GetChecked()
			end
		)

		-- Activate Ritual of Souls speech button -Draven (April 3rd, 2008)
		self.cbRoSMessages = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Activer egalement les messages pour le Rituel des ames"],
			20, -196,
			function(self)
				NecrosisConfig.RoSSummon = self:GetChecked()
			end
		)

		-- Sound alerts
		self.cbSound = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Activer les sons"],
			0, -224,
			function(self)
				NecrosisConfig.Sound = self:GetChecked()
			end
		)

		-- Antifear alerts
		self.cbAntiFearAlert = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Alerter quand la cible est insensible a la peur"],
			0, -252,
			function(self)
				NecrosisConfig.AntiFearAlert = self:GetChecked()
			end
		)

		-- Elemental / Demon Alerts
		self.cbBanishAlert = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["Alerter quand la cible peut etre banie ou asservie"],
			0, -280,
			function(self)
				NecrosisConfig.BanishAlert = self:GetChecked()
			end
		)

		-- Trance alerts
		self.cbTranceAlert = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Messages["M'alerter quand j'entre en Transe"],
			0, -308,
			function(self)
				NecrosisConfig.ShadowTranceAlert = self:GetChecked()
			end
		)

		-- Handler to update texts when language changes
		local function updateTexts()
			self.cbShowTooltip:SetText(Necrosis.Config.Messages["Afficher les bulles d'aide"])
			self.cbChatType:SetText(Necrosis.Config.Messages["Afficher les messages dans la zone systeme"])
			self.cbSpeech:SetText(Necrosis.Config.Messages["Activer les messages aleatoires de TP et de Rez"])
			self.cbShortMessages:SetText(Necrosis.Config.Messages["Utiliser des messages courts"])
			self.cbDemonMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Demons"])
			self.cbMountMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Montures"])
			self.cbRoSMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour le Rituel des ames"])
			self.cbSound:SetText(Necrosis.Config.Messages["Activer les sons"])
			self.cbAntiFearAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible est insensible a la peur"])
			self.cbBanishAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible peut etre banie ou asservie"])
			self.cbTranceAlert:SetText(Necrosis.Config.Messages["M'alerter quand j'entre en Transe"])
		end
		EventHub:RegisterLanguageChangedHandler(updateTexts)
	end

	self.cbShowTooltip:SetChecked(NecrosisConfig.NecrosisToolTip)
	self.cbChatType:SetChecked(not NecrosisConfig.ChatType)
	self.cbSpeech:SetChecked(NecrosisConfig.ChatMsg)
	self.cbShortMessages:SetChecked(NecrosisConfig.SM)
	self.cbDemonMessages:SetChecked(NecrosisConfig.DemonSummon)
	self.cbMountMessages:SetChecked(NecrosisConfig.SteedSummon)
	self.cbRoSMessages:SetChecked(NecrosisConfig.RoSSummon)
	self.cbSound:SetChecked(NecrosisConfig.Sound)
	self.cbAntiFearAlert:SetChecked(NecrosisConfig.AntiFearAlert)
	self.cbBanishAlert:SetChecked(NecrosisConfig.BanishAlert)
	self.cbTranceAlert:SetChecked(NecrosisConfig.ShadowTranceAlert)

	local function enableMessages()
		self.cbShortMessages:Enable()
		self.cbDemonMessages:Enable()
		self.cbMountMessages:Enable()
		self.cbRoSMessages:Enable()
	end
	local function enableShortMessages()
		self.cbShortMessages:Enable()
		self.cbDemonMessages:Disable()
		self.cbMountMessages:Disable()
		self.cbRoSMessages:Disable()
	end
	local function disableMessages()
		self.cbShortMessages:Disable()
		self.cbDemonMessages:Disable()
		self.cbMountMessages:Disable()
		self.cbRoSMessages:Disable()
	end

	if not NecrosisConfig.ChatMsg then
		disableMessages()
	elseif NecrosisConfig.SM then
		enableShortMessages()
	else
		enableMessages()
	end

	self.Frame:Show()

end
