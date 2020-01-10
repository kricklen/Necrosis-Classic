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

Gui.MessagesView = {
	Frame = false,
	
	ddLanguage = false,
	cbShowTooltip = false,
	cbChatType = false,
	cbSpeech = false,
	cbShortMessages = false,
	cbDemonMessages = false,
	cbMountMessages = false,
	cbRoSMessages = false,
	cbSound = false,
	cbAntiFearAlert = false,
	cbBanishAlert = false,
	cbTranceAlert = false,

	cbShowTooltip_Click =
		function(cb)
			NecrosisConfig.NecrosisToolTip = cb:GetChecked()
		end,
	cbChatType_Click =
		function(cb)
			NecrosisConfig.ChatType = not cb:GetChecked()
			Necrosis:Msg(Necrosis.Config.Messages.Position)
		end,
	cbSpeech_Click =
		function(cb)
			NecrosisConfig.ChatMsg = cb:GetChecked()
			if NecrosisConfig.ChatMsg then
				self.EnableMessages()
			else
				self.DisableMessages()
			end
		end,
	cbShortMessages_Click =
		function(cb)
			NecrosisConfig.SM = cb:GetChecked()
			if NecrosisConfig.SM then
				self.EnableShortMessages()
			else
				self.EnableMessages()
			end
		end,
	cbDemonMessages_Click =
		function(cb)
			NecrosisConfig.DemonSummon = cb:GetChecked()
		end,
	cbMountMessages_Click =
		function(cb)
			NecrosisConfig.SteedSummon = cb:GetChecked()
		end,
	cbRoSMessages_Click =
		function(cb)
			NecrosisConfig.RoSSummon = cb:GetChecked()
		end,
	cbSound_Click =
		function(cb)
			NecrosisConfig.Sound = cb:GetChecked()
		end,
	cbBanishAlert_Click =
		function(cb)
			NecrosisConfig.BanishAlert = cb:GetChecked()
		end,
	cbAntiFearAlert_Click =
		function(cb)
			NecrosisConfig.AntiFearAlert = cb:GetChecked()
		end,
	cbTranceAlert_Click =
		function(cb)
			NecrosisConfig.ShadowTranceAlert = cb:GetChecked()
		end,

	DisableMessages =
		function()
			self.cbShortMessages:Disable()
			self.cbDemonMessages:Disable()
			self.cbMountMessages:Disable()
			self.cbRoSMessages:Disable()
		end,

	EnableMessages =
		function()
			self.cbShortMessages:Enable()
			self.cbDemonMessages:Enable()
			self.cbMountMessages:Enable()
			self.cbRoSMessages:Enable()
		end,

	DisableShortMessages =
		function()
			self.EnableMessages()
			Necrosis.Speech.Rez = Necrosis.Speech.ShortMessage[1]
			Necrosis.Speech.TP = Necrosis.Speech.ShortMessage[2]
		end,

	EnableShortMessages =
		function()
			self.cbShortMessages:Enable()
			self.cbDemonMessages:Disable()
			self.cbMountMessages:Disable()
			self.cbRoSMessages:Disable()
			Necrosis.Speech.Rez = Necrosis.Speech.ShortMessage[1]
			Necrosis.Speech.TP = Necrosis.Speech.ShortMessage[2]
		end,

	UpdateTexts =
		function()
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
		end,

	Show =
		function()
			-- Check if the frame has been initialized before
			if not self.Frame then
				-- Create the window
				self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)

				-- Language selection
				self.ddLanguage, self.lblLanguage =
					GraphicsHelper:CreateDropDown(
						self.Frame,
						"Langue / Language / Sprache",
						0, 0
					)
				Gui.MessagesViewModel.LanguageDropDownInit(self.ddLanguage)

				-- Turn on help bubbles
				self.cbShowTooltip =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Afficher les bulles d'aide"],
						0, -28,
						self.cbShowTooltip_Click
					)
				self.cbShowTooltip:SetChecked(NecrosisConfig.NecrosisToolTip)

				-- Move messages to the system area
				self.cbChatType =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Afficher les messages dans la zone systeme"],
						0, -56,
						self.cbChatType_Click
					)
				self.cbChatType:SetChecked(not NecrosisConfig.ChatType)

				-- Activate TP and Rez messages
				self.cbSpeech =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Activer les messages aleatoires de TP et de Rez"],
						0, -84,
						self.cbSpeech_Click
					)
				self.cbSpeech:SetChecked(NecrosisConfig.ChatMsg)

				-- Activate short messages
				self.cbShortMessages =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Utiliser des messages courts"],
						20, -112,
						self.cbShortMessages_Click
					)
				self.cbShortMessages:SetChecked(NecrosisConfig.SM)

				-- Activate demon messages
				self.cbDemonMessages =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Activer egalement les messages pour les Demons"],
						20, -140,
						self.cbDemonMessages_Click
					)
				self.cbDemonMessages:SetChecked(NecrosisConfig.DemonSummon)

				-- Activate mount messages
				self.cbMountMessages =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Activer egalement les messages pour les Montures"],
						20, -168,
						self.cbMountMessages_Click
					)
				self.cbMountMessages:SetChecked(NecrosisConfig.SteedSummon)

				-- Activate Ritual of Souls speech button -Draven (April 3rd, 2008)
				self.cbRoSMessages =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Activer egalement les messages pour le Rituel des ames"],
						20, -196,
						self.cbRoSMessages_Click
					)
				self.cbRoSMessages:SetChecked(NecrosisConfig.RoSSummon)

				-- Sound alerts
				self.cbSound =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Activer les sons"],
						0, -224,
						self.cbSound_Click
					)
				self.cbSound:SetChecked(NecrosisConfig.Sound)

				-- Antifear alerts
				self.cbAntiFearAlert =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Alerter quand la cible est insensible a la peur"],
						0, -252,
						self.cbAntiFearAlert_Click
					)
				self.cbAntiFearAlert:SetChecked(NecrosisConfig.AntiFearAlert)

				-- Elemental / Demon Alerts
				self.cbBanishAlert =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["Alerter quand la cible peut etre banie ou asservie"],
						0, -280,
						self.cbBanishAlert_Click
					)
				self.cbBanishAlert:SetChecked(NecrosisConfig.BanishAlert)

				-- Trance alerts
				self.cbTranceAlert =
					GraphicsHelper:CreateCheckButton(
						self.Frame,
						Necrosis.Config.Messages["M'alerter quand j'entre en Transe"],
						0, -308,
						self.cbTranceAlert_Click
					)
				self.cbTranceAlert:SetChecked(NecrosisConfig.ShadowTranceAlert)

				-- Handler to update texts when language changes
				EventHub:RegisterLanguageChangedHandler(self.UpdateTexts)

				-- Apply initial configuration
				if not NecrosisConfig.ChatMsg then
					self.DisableMessages()
				elseif NecrosisConfig.SM then
					self.EnableShortMessages()
				else
					self.EnableMessages()
				end
			end

			self.Frame:Show()
		end
}
