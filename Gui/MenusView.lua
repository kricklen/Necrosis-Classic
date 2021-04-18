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
-- $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

Necrosis.Gui.MenusView = {
	Frame = false,
	CurrentPageIndex = 1,
	Pages = {},
	fsPaging = false
}

local _mv = Necrosis.Gui.MenusView

function _mv:NextPage()
	-- Calculate the next visible page, rotating from max page to first page
	local nextIndex = _mv.CurrentPageIndex + 1
	if math.fmod(nextIndex, #_mv.Pages) == 1 then
		nextIndex = 1
	end
	_mv.Pages[_mv.CurrentPageIndex]:Hide()
	_mv.Pages[nextIndex]:Show()
	_mv.fsPaging:SetText(nextIndex.." / "..#_mv.Pages)
	_mv.CurrentPageIndex = nextIndex
end

function _mv:PrevPage()
	-- Calculate the previous visible page, rotating from first page to max page
	local prevIndex = _mv.CurrentPageIndex - 1
	if math.fmod(prevIndex, #_mv.Pages) == 0 then
		prevIndex = #_mv.Pages
	end
	_mv.Pages[_mv.CurrentPageIndex]:Hide()
	_mv.Pages[prevIndex]:Show()
	_mv.fsPaging:SetText(prevIndex.." / "..#_mv.Pages)
	_mv.CurrentPageIndex = prevIndex
end

function _mv:cbBlockedMenu_Click()
	NecrosisConfig.BlockedMenu = self:GetChecked()
	if NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
		_mv.cbAutoMenu:Disable()
		_mv.cbCloseMenu:Disable()
	else
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Ferme") end
		_mv.cbAutoMenu:Enable()
		_mv.cbCloseMenu:Enable()
	end
end

function _mv:cbAutoMenu_Click()
	NecrosisConfig.AutomaticMenu = self:GetChecked()
	if not NecrosisConfig.AutomaticMenu then
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Ferme") end
	end
end

function _mv:cbCloseMenu_Click()
	NecrosisConfig.ClosingMenu = self:GetChecked()
	Necrosis:CreateMenu()
end

function _mv:cbBuffSense_Click()
	if self:GetChecked() then
		NecrosisConfig.BuffMenuPos.direction = -1
	else
		NecrosisConfig.BuffMenuPos.direction = 1
	end
	Necrosis:CreateMenu()
end

function _mv:cbDemonSens_Click()
	if self:GetChecked() then
		NecrosisConfig.PetMenuPos.direction = -1
	else
		NecrosisConfig.PetMenuPos.direction = 1
	end
	Necrosis:CreateMenu()
end

function _mv:cbCurseSens_Click()
	if self:GetChecked() then
		NecrosisConfig.CurseMenuPos.direction = -1
	else
		NecrosisConfig.CurseMenuPos.direction = 1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Buff
function _mv.ddBuffVector_Init(dd)
	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Menus.Orientation[i],
			checked = false,
			func = _mv.ddBuffVector_Click,
			arg1 = dd
		})
	end
	if NecrosisConfig.BuffMenuPos.x == 1 then
		UIDropDownMenu_SetSelectedID(dd, 1)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[1])
	elseif NecrosisConfig.BuffMenuPos.y == 1 then
		UIDropDownMenu_SetSelectedID(dd, 2)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[2])
	else
		UIDropDownMenu_SetSelectedID(dd, 3)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[3])
	end
end

function _mv.ddBuffVector_Click(item, dd)
	local id = item:GetID()
	UIDropDownMenu_SetSelectedID(dd, id)
	if id == 1 then
		NecrosisConfig.BuffMenuPos.x = 1
		NecrosisConfig.BuffMenuPos.y = 0
	elseif id == 2 then
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = 1
	else
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Démons
function _mv.ddDemonVector_Init(dd)
	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Menus.Orientation[i],
			checked = false,
			func = _mv.ddDemonVector_Click,
			arg1 = dd
		})
	end
	if NecrosisConfig.PetMenuPos.x == 1 then
		UIDropDownMenu_SetSelectedID(dd, 1)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[1])
	elseif NecrosisConfig.PetMenuPos.y == 1 then
		UIDropDownMenu_SetSelectedID(dd, 2)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[2])
	else
		UIDropDownMenu_SetSelectedID(dd, 3)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[3])
	end
end

function _mv.ddDemonVector_Click(item, dd)
	local id = item:GetID()
	UIDropDownMenu_SetSelectedID(dd, id)
	if id == 1 then
		NecrosisConfig.PetMenuPos.x = 1
		NecrosisConfig.PetMenuPos.y = 0
	elseif id == 2 then
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = 1
	else
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Malédictions
function _mv.ddCurseVector_Init(dd)
	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Menus.Orientation[i],
			checked = false,
			func = _mv.ddCurseVector_Click,
			arg1 = dd
		})
	end
	if NecrosisConfig.CurseMenuPos.x == 1 then
		UIDropDownMenu_SetSelectedID(dd, 1)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[1])
	elseif NecrosisConfig.CurseMenuPos.y == 1 then
		UIDropDownMenu_SetSelectedID(dd, 2)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[2])
	else
		UIDropDownMenu_SetSelectedID(dd, 3)
		UIDropDownMenu_SetText(dd, Necrosis.Config.Menus.Orientation[3])
	end
end

function _mv.ddCurseVector_Click(item, dd)
	local id = item:GetID()
	UIDropDownMenu_SetSelectedID(dd, id)
	if id == 1 then
		NecrosisConfig.CurseMenuPos.x = 1
		NecrosisConfig.CurseMenuPos.y = 0
	elseif id == 2 then
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = 1
	else
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

function _mv.UpdateTexts()
	-- Page 1
	_mv.fsPage1Title:SetText(Necrosis.Config.Menus["Options Generales"])
	_mv.cbBlockedMenu:SetText(Necrosis.Config.Menus["Afficher les menus en permanence"])
	_mv.cbAutoMenu:SetText(Necrosis.Config.Menus["Afficher automatiquement les menus en combat"])
	_mv.cbCloseMenu:SetText(Necrosis.Config.Menus["Fermer le menu apres un clic sur un de ses elements"])

	-- Page 2
	_mv.fsPage2Title:SetText(Necrosis.Config.Menus["Menu des Buffs"])
	_mv.lblBuffVector:SetText(Necrosis.Config.Menus["Orientation du menu"])
	UIDropDownMenu_Initialize(_mv.ddBuffVector, _mv.ddBuffVector_Init)
	_mv.cbBuffSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])
	_mv.slBanishSizeText:SetText(Necrosis.Config.Menus["Taille du bouton Banir"])
	_mv.slBuffOxText:SetText("Offset X")
	_mv.slBuffOyText:SetText("Offset Y")

	-- Page 3
	_mv.fsPage3Title:SetText(Necrosis.Config.Menus["Menu des Demons"])
	_mv.lblDemonVector:SetText(Necrosis.Config.Menus["Orientation du menu"])
	UIDropDownMenu_Initialize(_mv.ddDemonVector, _mv.ddDemonVector_Init)
	_mv.cbDemonSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])
	_mv.slDemonOxText:SetText("Offset X")
	_mv.slDemonOyText:SetText("Offset Y")

	-- Page 4
	_mv.fsPage4Title:SetText(Necrosis.Config.Menus["Menu des Maledictions"])
	_mv.lblCurseVector:SetText(Necrosis.Config.Menus["Orientation du menu"])
	UIDropDownMenu_Initialize(_mv.ddCurseVector, _mv.ddCurseVector_Init)
	_mv.cbCurseSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])
	_mv.slCurseOxText:SetText("Offset X")
	_mv.slCurseOyText:SetText("Offset Y")
end

function _mv:Show()
	if not self.Frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)
		self.Page1 = GraphicsHelper:CreateDialogPage(self.Frame)
		self.Pages[1] = self.Page1
		self.Page2 = GraphicsHelper:CreateDialogPage(self.Frame)
		self.Page2:Hide()
		self.Pages[2] = self.Page2
		self.Page3 = GraphicsHelper:CreateDialogPage(self.Frame)
		self.Page3:Hide()
		self.Pages[3] = self.Page3
		self.Page4 = GraphicsHelper:CreateDialogPage(self.Frame)
		self.Page4:Hide()
		self.Pages[4] = self.Page4

		self.btnPrev = GraphicsHelper:CreateButtonPrev(
			self.Frame,
			self.PrevPage
		)

		self.fsPaging = GraphicsHelper:CreateFontString(
			self.Frame,
			"1 / 4",
			"BOTTOM",
			-10, 18
		)

		self.btnNext = GraphicsHelper:CreateButtonNext(
			self.Frame,
			self.NextPage
		)

		-- Page 1
		self.fsPage1Title = GraphicsHelper:CreateFontString(
			self.Page1,
			Necrosis.Config.Menus["Options Generales"],
			"TOP",
			0, 0
		)

		-- Afficher les menus en permanence
		self.cbBlockedMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Afficher les menus en permanence"],
			0, -28,
			self.cbBlockedMenu_Click
		)
		self.cbBlockedMenu:SetChecked(NecrosisConfig.BlockedMenu)

		-- Afficher les menus en combat
		self.cbAutoMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Afficher automatiquement les menus en combat"],
			0, -50,
			self.cbAutoMenu_Click
		)
		self.cbAutoMenu:SetChecked(NecrosisConfig.AutomaticMenu)

		-- Cacher les menus sur un click
		self.cbCloseMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Fermer le menu apres un clic sur un de ses elements"],
			0, -72,
			self.cbCloseMenu_Click
		)
		self.cbCloseMenu:SetChecked(NecrosisConfig.ClosingMenu)

		-- Page 2
		-- BUFF
		self.fsPage2Title = GraphicsHelper:CreateFontString(
			self.Page2,
			Necrosis.Config.Menus["Menu des Buffs"],
			"TOP",
			0, 0
		)

		-- Choix de l'orientation du menu
		self.ddBuffVector, self.lblBuffVector = GraphicsHelper:CreateDropDown(
			self.Page2,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -28,
			self.ddBuffVector_Init
		)

		-- Choix du sens du menu
		self.cbBuffSens = GraphicsHelper:CreateCheckButton(
			self.Page2,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -50,
			self.cbBuffSense_Click
		)
		self.cbBuffSens:SetChecked(NecrosisConfig.BuffMenuPos.direction < 0)

		-- Création du slider de scale du Banish
		self.slBanishSize = GraphicsHelper:CreateSlider(
			self.Page2,
			"slBanishSize",
			50, 200, 5,
			15, 150,
			0, -92
		)
		-- Capture auto created controls
		self.slBanishSizeText = slBanishSizeText
		self.slBanishSizeLow  = slBanishSizeLow
		self.slBanishSizeHigh = slBanishSizeHigh

		self.slBanishSize:SetValue(NecrosisConfig.BanishScale)
		self.slBanishSizeLow:SetText("50 %")
		self.slBanishSizeHigh:SetText("200 %")
		self.slBanishSizeText:SetText(Necrosis.Config.Menus["Taille du bouton Banir"])

		self.slBanishSize:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue().." %")
				if _G["NecrosisBuffMenu10"] then
					NecrosisBuffMenu10:Show();
					NecrosisBuffMenu10:ClearAllPoints();
					NecrosisBuffMenu10:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
				end
			end
		)
		self.slBanishSize:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				Necrosis:CreateMenu()
			end
		)
		self.slBanishSize:SetScript("OnValueChanged",
			function(self)
				if not (self:GetValue() == NecrosisConfig.BanishScale) then
					GameTooltip:SetText(self:GetValue().." %")
					NecrosisConfig.BanishScale = self:GetValue()
					if _G["NecrosisBuffMenu10"] then
						NecrosisBuffMenu10:ClearAllPoints();
						NecrosisBuffMenu10:SetScale(NecrosisConfig.BanishScale / 100);
						NecrosisBuffMenu10:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
					end
				end
			end
		)

		-- Création du slider d'Offset X
		self.slBuffOx = GraphicsHelper:CreateSlider(
			self.Page2, "slBuffOx",
			-65, 65, 1,
			15, 140,
			0, -134
		)
		-- Capture auto created controls
		self.slBuffOxText = slBuffOxText
		self.slBuffOxLow  = slBuffOxLow
		self.slBuffOxHigh = slBuffOxHigh

		self.slBuffOx:SetValue(NecrosisConfig.BuffMenuDecalage.x)
		self.slBuffOxLow:SetText("")
		self.slBuffOxHigh:SetText("")
		self.slBuffOxText:SetText("Offset X")

		self.slBuffOx:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisBuffMenuButton"] then
					-- Block the menu button
					NecrosisBuffMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slBuffOx:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisBuffMenuButton"] then
					-- Set the state that the menu button had before
					if NecrosisConfig.BlockedMenu then
						NecrosisBuffMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisBuffMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slBuffOx:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.BuffMenuDecalage.x = self:GetValue()
				Necrosis:SetOfxy("Buff")
			end
		)

		-- Création du slider d'Offset Y
		self.slBuffOy = GraphicsHelper:CreateSlider(
			self.Page2, "slBuffOy",
			-65, 65, 1,
			15, 140,
			0, -176
		)
		
		self.slBuffOyText = slBuffOyText
		self.slBuffOyLow  = slBuffOyLow
		self.slBuffOyHigh = slBuffOyHigh

		self.slBuffOy:SetValue(NecrosisConfig.BuffMenuDecalage.y)
		self.slBuffOyText:SetText("Offset Y")
		self.slBuffOyLow:SetText("")
		self.slBuffOyHigh:SetText("")

		self.slBuffOy:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisBuffMenuButton"] then
					NecrosisBuffMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slBuffOy:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisBuffMenuButton"] then
					if NecrosisConfig.BlockedMenu then
						NecrosisBuffMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisBuffMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slBuffOy:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.BuffMenuDecalage.y = self:GetValue()
				Necrosis:SetOfxy("Buff")
			end
		)

		-- Page 3
		-- DEMON
		self.fsPage3Title = GraphicsHelper:CreateFontString(
			self.Page3,
			Necrosis.Config.Menus["Menu des Demons"],
			"TOP",
			0, 0
		)

		-- Choix de l'orientation du menu
		self.ddDemonVector, self.lblDemonVector = GraphicsHelper:CreateDropDown(
			self.Page3,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -28,
			self.ddDemonVector_Init
		)

		-- Choix du sens du menu
		self.cbDemonSens = GraphicsHelper:CreateCheckButton(
			self.Page3,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -50,
			self.cbDemonSens_Click
		)
		self.cbDemonSens:SetChecked(NecrosisConfig.PetMenuPos.direction < 0)

		-- Création du slider d'Offset X
		self.slDemonOx = GraphicsHelper:CreateSlider(
			self.Page3, "slDemonOx",
			-65, 65, 1,
			15, 140,
			0, -92
		)

		self.slDemonOxText = slDemonOxText
		self.slDemonOxLow  = slDemonOxLow
		self.slDemonOxHigh = slDemonOxHigh

		self.slDemonOx:SetValue(NecrosisConfig.PetMenuDecalage.x)
		self.slDemonOxText:SetText("Offset X")
		self.slDemonOxLow:SetText("")
		self.slDemonOxHigh:SetText("")

		self.slDemonOx:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisPetMenuButton"] then
					NecrosisPetMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slDemonOx:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisPetMenuButton"] then
					if NecrosisConfig.BlockedMenu then
						NecrosisPetMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisPetMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slDemonOx:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.PetMenuDecalage.x = self:GetValue()
				Necrosis:SetOfxy("Pet")
			end
		)

		-- Création du slider d'Offset Y
		self.slDemonOy = GraphicsHelper:CreateSlider(
			self.Page3, "slDemonOy",
			-65, 65, 1,
			15, 140,
			0, -134
		)

		self.slDemonOyText = slDemonOyText
		self.slDemonOyLow  = slDemonOyLow
		self.slDemonOyHigh = slDemonOyHigh

		self.slDemonOy:SetValue(NecrosisConfig.PetMenuDecalage.y)
		self.slDemonOyText:SetText("Offset Y")
		self.slDemonOyLow:SetText("")
		self.slDemonOyHigh:SetText("")

		self.slDemonOy:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisPetMenuButton"] then
					NecrosisPetMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slDemonOy:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisPetMenuButton"] then
					if NecrosisConfig.BlockedMenu then
						NecrosisPetMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisPetMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slDemonOy:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.PetMenuDecalage.y = self:GetValue()
				Necrosis:SetOfxy("Pet")
			end
		)

		-- Page 4
		-- CURSE
		self.fsPage4Title = GraphicsHelper:CreateFontString(
			self.Page4,
			Necrosis.Config.Menus["Menu des Maledictions"],
			"TOP",
			0, 0
		)

		-- Choix de l'orientation du menu
		self.ddCurseVector, self.lblCurseVector = GraphicsHelper:CreateDropDown(
			self.Page4,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -28,
			self.ddCurseVector_Init
		)

		-- Choix du sens du menu
		self.cbCurseSens = GraphicsHelper:CreateCheckButton(
			self.Page4,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -50,
			self.cbCurseSens_Click
		)
		self.cbCurseSens:SetChecked(NecrosisConfig.CurseMenuPos.direction < 0)

		-- Création du slider d'Offset X
		self.slCurseOx = GraphicsHelper:CreateSlider(
			self.Page4, "slCurseOx",
			-65, 65, 1,
			15, 140,
			0, -92
		)

		self.slCurseOxText = slCurseOxText
		self.slCurseOxLow  = slCurseOxLow
		self.slCurseOxHigh = slCurseOxHigh

		self.slCurseOx:SetValue(NecrosisConfig.CurseMenuDecalage.x)
		self.slCurseOxText:SetText("Offset X")
		self.slCurseOxLow:SetText("")
		self.slCurseOxHigh:SetText("")

		self.slCurseOx:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisCurseMenuButton"] then
					NecrosisCurseMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slCurseOx:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisCurseMenuButton"] then
					if NecrosisConfig.BlockedMenu then
						NecrosisCurseMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisCurseMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slCurseOx:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.CurseMenuDecalage.x = self:GetValue()
				Necrosis:SetOfxy("Curse")
			end
		)

		-- Création du slider d'Offset Y
		self.slCurseOy = GraphicsHelper:CreateSlider(
			self.Page4, "slCurseOy",
			-65, 65, 1,
			15, 140,
			0, -134
		)

		self.slCurseOyText = slCurseOyText
		self.slCurseOyLow  = slCurseOyLow
		self.slCurseOyHigh = slCurseOyHigh

		self.slCurseOy:SetValue(NecrosisConfig.CurseMenuDecalage.y)
		self.slCurseOyText:SetText("Offset Y")
		self.slCurseOyLow:SetText("")
		self.slCurseOyHigh:SetText("")

		self.slCurseOy:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
				if _G["NecrosisCurseMenuButton"] then
					NecrosisCurseMenuButton:SetAttribute("state", "Bloque")
				end
			end
		)
		self.slCurseOy:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
				if _G["NecrosisCurseMenuButton"] then
					if NecrosisConfig.BlockedMenu then
						NecrosisCurseMenuButton:SetAttribute("state", "Bloque")
					else
						NecrosisCurseMenuButton:SetAttribute("state", "Ferme")
					end
				end
			end
		)
		self.slCurseOy:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.CurseMenuDecalage.y = self:GetValue()
				Necrosis:SetOfxy("Curse")
			end
		)

		if NecrosisConfig.BlockedMenu then
			self.cbAutoMenu:Disable()
			self.cbCloseMenu:Disable()
		else
			self.cbAutoMenu:Enable()
			self.cbCloseMenu:Enable()
		end

		-- Handler to update texts when language changes
		EventHelper:RegisterLanguageChangedHandler(self.UpdateTexts)
	end

	self.Frame:Show()
end

function _mv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end
