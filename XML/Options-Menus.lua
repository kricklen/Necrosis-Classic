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

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

Necrosis.Gui.MenusView = {
	Frame = false,
	CurrentPageIndex = 1,
	Pages = {}
}

local _mv = Necrosis.Gui.MenusView

function _mv:NextPage()
	-- Calculate the next visible page, rotating from max page to first page
	local nextIndex = math.fmod(#_mv.Pages, _mv.CurrentPageIndex + 1)
	_mv.Pages[_mv.CurrentPageIndex]:Hide()
	_mv.Pages[nextIndex]:Show()
	self.fsPaging:SetText(nextIndex.." / "..#_mv.Pages)
	_mv.CurrentPageIndex = nextIndex
end

function _mv:PrevPage()
	-- Calculate the next visible page, rotating from max page to first page
	local prevIndex = math.fmod(#_mv.Pages, _mv.CurrentPageIndex - 1)
	_mv.Pages[_mv.CurrentPageIndex]:Hide()
	_mv.Pages[prevIndex]:Show()
	self.fsPaging:SetText(prevIndex.." / "..#_mv.Pages)
	_mv.CurrentPageIndex = prevIndex
end

function _mv:cbBlockedMenu_Click()
	NecrosisConfig.BlockedMenu = self:GetChecked()
	if NecrosisConfig.BlockedMenu then
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
		self.cbAutoMenu:Disable()
		self.cbCloseMenu:Disable()
	else
		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Ferme") end
		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Ferme") end
		self.cbAutoMenu:Enable()
		self.cbCloseMenu:Enable()
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

function _mv:Show()

	local frame = _G["NecrosisMenusConfig"]
	if not frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)
		local Page1 = GraphicsHelper:CreateDialog(self.Frame)
		self.Pages[1] = Page1
		local Page2 = GraphicsHelper:CreateDialog(self.Frame)
		self.Pages[2] = Page2
		local Page3 = GraphicsHelper:CreateDialog(self.Frame)
		self.Pages[3] = Page3
		local Page4 = GraphicsHelper:CreateDialog(self.Frame)
		self.Pages[4] = Page4

		-- (parentFrame, name, text, position, x, y)
		self.fsPaging = GraphicsHelper:CreateFontString(
			self.Frame,
			nil,
			"1 / 4",
			"BOTTOM",
			-20, 10
		)

		-- CreateButton(parentFrame, text, x, y, onClickFunction)
		self.btnNext = GraphicsHelper:CreateButton(
			self.Frame,
			">>>",
			-60, -300
			self.NextPage
		)

		self.btnPrev = GraphicsHelper:CreateButton(
			self.Frame,
			"<<<",
			-300, -300
			self.PrevPage
		)

		-- frame = CreateFrame("Frame", "NecrosisMenusConfig", NecrosisGeneralFrame)
		-- self.Frame = frame
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("BOTTOMLEFT")

		-- -- Création de la sous-fenêtre 1
		-- frame = CreateFrame("Frame", "NecrosisMenusConfig1", NecrosisMenusConfig)
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetAllPoints(NecrosisMenusConfig)

		-- local FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		-- FontString:SetText("1 / 4")

		-- FontString = frame:CreateFontString("NecrosisMenusConfig1Text", nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 400)

		-- Boutons
		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig1, "OptionsButtonTemplate")
		-- frame:SetText(">>>")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig1, "BOTTOMRIGHT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig2:Show()
		-- 	NecrosisMenusConfig1:Hide()
		-- end)

		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig1, "OptionsButtonTemplate")
		-- frame:SetText("<<<")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig4:Show()
		-- 	NecrosisMenusConfig1:Hide()
		-- end)

		-- -- Création de la sous-fenêtre 2
		-- frame = CreateFrame("Frame", "NecrosisMenusConfig2", NecrosisMenusConfig)
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Hide()
		-- frame:ClearAllPoints()
		-- frame:SetAllPoints(NecrosisMenusConfig)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		-- FontString:SetText("2 / 4")

		-- FontString = frame:CreateFontString("NecrosisMenusConfig2Text", nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 400)

		-- -- Boutons
		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig2, "OptionsButtonTemplate")
		-- frame:SetText(">>>")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig3:Show()
		-- 	NecrosisMenusConfig2:Hide()
		-- end)

		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig2, "OptionsButtonTemplate")
		-- frame:SetText("<<<")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig1:Show()
		-- 	NecrosisMenusConfig2:Hide()
		-- end)

		-- -- Création de la sous-fenêtre 3
		-- frame = CreateFrame("Frame", "NecrosisMenusConfig3", NecrosisMenusConfig)
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Hide()
		-- frame:ClearAllPoints()
		-- frame:SetAllPoints(NecrosisMenusConfig)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		-- FontString:SetText("3 / 4")

		-- FontString = frame:CreateFontString("NecrosisMenusConfig3Text", nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 400)

		-- -- Boutons
		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig3, "OptionsButtonTemplate")
		-- frame:SetText(">>>")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig4:Show()
		-- 	NecrosisMenusConfig3:Hide()
		-- end)

		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig3, "OptionsButtonTemplate")
		-- frame:SetText("<<<")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig2:Show()
		-- 	NecrosisMenusConfig3:Hide()
		-- end)

		-- -- Création de la sous-fenêtre 4
		-- frame = CreateFrame("Frame", "NecrosisMenusConfig4", NecrosisMenusConfig)
		-- frame:SetFrameStrata("DIALOG")
		-- frame:SetMovable(false)
		-- frame:EnableMouse(true)
		-- frame:SetWidth(350)
		-- frame:SetHeight(452)
		-- frame:Hide()
		-- frame:ClearAllPoints()
		-- frame:SetAllPoints(NecrosisMenusConfig)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 130)
		-- FontString:SetText("4 / 4")

		-- FontString = frame:CreateFontString("NecrosisMenusConfig4Text", nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("BOTTOM", frame, "BOTTOM", 50, 400)

		-- -- Boutons
		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig4, "OptionsButtonTemplate")
		-- frame:SetText(">>>")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig1:Show()
		-- 	NecrosisMenusConfig4:Hide()
		-- end)

		-- frame = CreateFrame("Button", nil, NecrosisMenusConfig4, "OptionsButtonTemplate")
		-- frame:SetText("<<<")
		-- frame:EnableMouse(true)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 40, 135)

		-- frame:SetScript("OnClick", function()
		-- 	NecrosisMenusConfig3:Show()
		-- 	NecrosisMenusConfig4:Hide()
		-- end)

		-- Page 1
		self.fsPage1Title = GraphicsHelper:CreateFontString(
			self.Page1,
			nil,
			Necrosis.Config.Menus["Options Generales"],
			"TOP",
			0, -40
		)

		-- Afficher les menus en permanence
		self.cbBlockedMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Afficher les menus en permanence"],
			0, -60,
			self.cbBlockedMenu_Click
		)
		self.cbBlockedMenu:SetChecked(NecrosisConfig.BlockedMenu)

		-- frame = CreateFrame("CheckButton", "NecrosisBlockedMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig, "BOTTOMLEFT", 25, 350)

		-- frame:SetScript("OnClick", function(self)
		-- 	NecrosisConfig.BlockedMenu = self:GetChecked()
		-- 	if NecrosisConfig.BlockedMenu then
		-- 		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		-- 		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		-- 		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
		-- 		NecrosisAutoMenu:Disable()
		-- 		NecrosisCloseMenu:Disable()
		-- 	else
		-- 		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Ferme") end
		-- 		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Ferme") end
		-- 		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Ferme") end
		-- 		NecrosisAutoMenu:Enable()
		-- 		NecrosisCloseMenu:Enable()
		-- 	end
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)

		-- Afficher les menus en combat
		self.cbAutoMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Afficher automatiquement les menus en combat"],
			0, -80,
			self.cbAutoMenu_Click
		)
		self.cbAutoMenu:SetChecked(NecrosisConfig.AutomaticMenu)

		-- frame = CreateFrame("CheckButton", "NecrosisAutoMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 25, 325)

		-- frame:SetScript("OnClick", function(self)
		-- 	NecrosisConfig.AutomaticMenu = self:GetChecked()
		-- 	if not NecrosisConfig.AutomaticMenu then
		-- 		if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Ferme") end
		-- 		if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Ferme") end
		-- 		if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Ferme") end
		-- 	end
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)
		--frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Cacher les menus sur un click
		self.cbCloseMenu = GraphicsHelper:CreateCheckButton(
			self.Page1,
			Necrosis.Config.Menus["Fermer le menu apres un clic sur un de ses elements"],
			0, -100,
			self.cbCloseMenu_Click
		)
		self.cbCloseMenu:SetChecked(NecrosisConfig.ClosingMenu)

		-- frame = CreateFrame("CheckButton", "NecrosisCloseMenu", NecrosisMenusConfig1, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig1, "BOTTOMLEFT", 25, 300)

		-- frame:SetScript("OnClick", function(self)
		-- 	NecrosisConfig.ClosingMenu = self:GetChecked()
		-- 	Necrosis:CreateMenu()
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)
		--frame:SetDisabledTextColor(0.75, 0.75, 0.75)

		-- Page 2
		-- BUFF
		self.fsPage2Title = GraphicsHelper:CreateFontString(
			self.Page2,
			nil,
			Necrosis.Config.Menus["Menu des Buffs"],
			"TOP",
			0, -40
		)

		-- Choix de l'orientation du menu
		self.ddBuffVector, self.lblBuffVector = GraphicsHelper:CreateDropDown(
			self.Page2,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -40,
			self.BuffVector_Init
		)

		-- frame = CreateFrame("Frame", "NecrosisBuffVector", NecrosisMenusConfig2, "UIDropDownMenuTemplate")
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", 40, 350)

		-- local FontString = frame:CreateFontString("NecrosisBuffVectorT", "OVERLAY", "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 35, 353)
		-- FontString:SetTextColor(1, 1, 1)

		-- UIDropDownMenu_SetWidth(frame, 125)

		-- Choix du sens du menu
		self.cbBuffSens = GraphicsHelper:CreateCheckButton(
			self.Page2,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -60,
			self.cbBuffSense_Click
		)
		self.cbBuffSens:SetChecked(NecrosisConfig.BuffMenuPos.direction < 0)

		-- frame = CreateFrame("CheckButton", "NecrosisBuffSens", NecrosisMenusConfig2, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 50, 325)

		-- frame:SetScript("OnClick", function(self)
		-- 	if self:GetChecked() then
		-- 		NecrosisConfig.BuffMenuPos.direction = -1
		-- 	else
		-- 		NecrosisConfig.BuffMenuPos.direction = 1
		-- 	end
		-- 	Necrosis:CreateMenu()
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)

		-- Création du slider de scale du Banish
		-- (parentFrame, name, min, max, step, height, width, x, y)
		self.slBanishSize = GraphicsHelper:CreateSlider(
			self.Page2,
			"slBanishSize",
			50, 200, 5,
			15, 150,
			0, -80
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

		-- frame = CreateFrame("Slider", "NecrosisBanishSize", NecrosisMenusConfig2, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(50, 200)
		-- frame:SetValueStep(5)
		-- frame:SetWidth(150)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("CENTER", NecrosisMenusConfig2, "BOTTOM", 50, 265)

		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue().." %")
		-- 	if _G["NecrosisBuffMenu10"] then
		-- 		NecrosisBuffMenu10:Show();
		-- 		NecrosisBuffMenu10:ClearAllPoints();
		-- 		NecrosisBuffMenu10:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		-- 	end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	Necrosis:CreateMenu()
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	if not (self:GetValue() == NecrosisConfig.BanishScale) then
		-- 		GameTooltip:SetText(self:GetValue().." %")
		-- 		NecrosisConfig.BanishScale = self:GetValue()
		-- 		if _G["NecrosisBuffMenu10"] then
		-- 			NecrosisBuffMenu10:ClearAllPoints();
		-- 			NecrosisBuffMenu10:SetScale(NecrosisConfig.BanishScale / 100);
		-- 			NecrosisBuffMenu10:SetPoint("CENTER", "UIParent", "CENTER", 0, 0);
		-- 		end
		-- 	end
		-- end)

		-- NecrosisBanishSizeLow:SetText("50 %")
		-- NecrosisBanishSizeHigh:SetText("200 %")

		-- Création du slider d'Offset X
		self.slBuffOx = GraphicsHelper:CreateSlider(
			self.Page2, "slBuffOx",
			-65, 65, 1,
			15, 140,
			0, -120
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

		-- frame = CreateFrame("Slider", "NecrosisBuffOx", NecrosisMenusConfig2, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig2, "BOTTOMLEFT", 35, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.BuffMenuDecalage.x = self:GetValue()
		-- 	Necrosis:SetOfxy("Buff")
		-- end)

		-- NecrosisBuffOxText:SetText("Offset X")
		-- NecrosisBuffOxLow:SetText("")
		-- NecrosisBuffOxHigh:SetText("")

		-- Création du slider d'Offset Y
		self.slBuffOy = GraphicsHelper:CreateSlider(
			self.Page2, "slBuffOy",
			-65, 65, 1,
			15, 140,
			0, -140
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

		-- frame = CreateFrame("Slider", "NecrosisBuffOy", NecrosisMenusConfig2, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig2, "BOTTOMRIGHT", 40, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisBuffMenuButton"] then NecrosisBuffMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.BuffMenuDecalage.y = self:GetValue()
		-- 	Necrosis:SetOfxy("Buff")
		-- end)

		-- NecrosisBuffOyText:SetText("Offset Y")
		-- NecrosisBuffOyLow:SetText("")
		-- NecrosisBuffOyHigh:SetText("")

		-- Page 3
		-- DEMON
		self.fsPage3Title = GraphicsHelper:CreateFontString(
			self.Page3,
			nil,
			Necrosis.Config.Menus["Menu des Demons"],
			"TOP",
			0, -40
		)

		-- Choix de l'orientation du menu
		self.ddDemonVector, self.lblDemonVector = GraphicsHelper:CreateDropDown(
			self.Page3,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -40,
			self.DemonVector_Init
		)

		-- frame = CreateFrame("Frame", "NecrosisDemonVector", NecrosisMenusConfig3, "UIDropDownMenuTemplate")
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", 40, 350)

		-- local FontString = frame:CreateFontString("NecrosisDemonVectorT", "OVERLAY", "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 35, 353)
		-- FontString:SetTextColor(1, 1, 1)
		-- UIDropDownMenu_SetWidth(frame, 125)

		-- Choix du sens du menu
		self.cbDemonSens = GraphicsHelper:CreateCheckButton(
			self.Page3,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -60,
			self.cbDemonSens_Click
		)
		self.cbDemonSens:SetChecked(NecrosisConfig.PetMenuPos.direction < 0)

		-- frame = CreateFrame("CheckButton", "NecrosisDemonSens", NecrosisMenusConfig3, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 50, 325)

		-- frame:SetScript("OnClick", function(self)
		-- 	if self:GetChecked() then
		-- 		NecrosisConfig.PetMenuPos.direction = -1
		-- 	else
		-- 		NecrosisConfig.PetMenuPos.direction = 1
		-- 	end
		-- 	Necrosis:CreateMenu()
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)

		-- Création du slider d'Offset X
		self.slDemonOx = GraphicsHelper:CreateSlider(
			self.Page3, "slDemonOx",
			-65, 65, 1,
			15, 140,
			0, -80
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


		-- frame = CreateFrame("Slider", "NecrosisDemonOx", NecrosisMenusConfig3, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig3, "BOTTOMLEFT", 35, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.PetMenuDecalage.x = self:GetValue()
		-- 	Necrosis:SetOfxy("Pet")
		-- end)

		-- NecrosisDemonOxText:SetText("Offset X")
		-- NecrosisDemonOxLow:SetText("")
		-- NecrosisDemonOxHigh:SetText("")

		-- Création du slider d'Offset Y
		self.slDemonOy = GraphicsHelper:CreateSlider(
			self.Page3, "slDemonOy",
			-65, 65, 1,
			15, 140,
			0, -100
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

		-- frame = CreateFrame("Slider", "NecrosisDemonOy", NecrosisMenusConfig3, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig3, "BOTTOMRIGHT", 40, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisPetMenuButton"] then NecrosisPetMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.PetMenuDecalage.y = self:GetValue()
		-- 	Necrosis:SetOfxy("Pet")
		-- end)

		-- NecrosisDemonOyText:SetText("Offset Y")
		-- NecrosisDemonOyLow:SetText("")
		-- NecrosisDemonOyHigh:SetText("")

		-- Page 4
		-- CURSE
		self.fsPage4Title = GraphicsHelper:CreateFontString(
			self.Page4,
			nil,
			Necrosis.Config.Menus["Menu des Maledictions"],
			"TOP",
			0, -40
		)

		-- Choix de l'orientation du menu
		self.ddCurseVector = GraphicsHelper:CreateDropDown(
			self.Page4,
			Necrosis.Config.Menus["Orientation du menu"],
			0, -40,
			self.CurseVector_Init
		)



		-- frame = CreateFrame("Frame", "NecrosisCurseVector", NecrosisMenusConfig4, "UIDropDownMenuTemplate")
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", 40, 350)

		-- local FontString = frame:CreateFontString("NecrosisCurseVectorT", "OVERLAY", "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 35, 353)
		-- FontString:SetTextColor(1, 1, 1)

		-- UIDropDownMenu_SetWidth(frame, 125)

		-- Choix du sens du menu
		self.cbCurseSens = GraphicsHelper:CreateCheckButton(
			self.Page4,
			Necrosis.Config.Menus["Changer la symetrie verticale des boutons"],
			0, -60,
			self.cbCurseSens_Click
		)
		self.ddCurseSens:SetValue(NecrosisConfig.CurseMenuPos.direction < 0)


		-- frame = CreateFrame("CheckButton", "NecrosisCurseSens", NecrosisMenusConfig4, "UICheckButtonTemplate")
		-- frame:EnableMouse(true)
		-- frame:SetWidth(24)
		-- frame:SetHeight(24)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 50, 325)

		-- frame:SetScript("OnClick", function(self)
		-- 	if self:GetChecked() then
		-- 		NecrosisConfig.CurseMenuPos.direction = -1
		-- 	else
		-- 		NecrosisConfig.CurseMenuPos.direction = 1
		-- 	end
		-- 	Necrosis:CreateMenu()
		-- end)

		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormalSmall")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("LEFT", frame, "RIGHT", 5, 1)
		-- FontString:SetTextColor(1, 1, 1)
		-- frame:SetFontString(FontString)

		-- Création du slider d'Offset X
		self.slCurseOx = GraphicsHelper:CreateSlider(
			self.Page4, "slCurseOx",
			-65. 65, 1,
			15, 140,
			0, -80
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

		-- frame = CreateFrame("Slider", "NecrosisCurseOx", NecrosisMenusConfig4, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("LEFT", NecrosisMenusConfig4, "BOTTOMLEFT", 35, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.CurseMenuDecalage.x = self:GetValue()
		-- 	Necrosis:SetOfxy("Curse")
		-- end)

		-- NecrosisCurseOxText:SetText("Offset X")
		-- NecrosisCurseOxLow:SetText("")
		-- NecrosisCurseOxHigh:SetText("")

		-- Création du slider d'Offset Y
		self.slCurseOy = GraphicsHelper:CreateSlider(
			self.Page4, "slCurseOy",
			-65, 65, 1,
			15, 140,
			0, -100
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


		-- frame = CreateFrame("Slider", "NecrosisCurseOy", NecrosisMenusConfig4, "OptionsSliderTemplate")
		-- frame:SetMinMaxValues(-65, 65)
		-- frame:SetValueStep(1)
		-- frame:SetWidth(140)
		-- frame:SetHeight(15)
		-- frame:Show()
		-- frame:ClearAllPoints()
		-- frame:SetPoint("RIGHT", NecrosisMenusConfig4, "BOTTOMRIGHT", 40, 200)

		-- local State = "Ferme"
		-- if NecrosisConfig.BlockedMenu then
		-- 	State = "Bloque"
		-- end
		-- frame:SetScript("OnEnter", function(self)
		-- 	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", "Bloque") end
		-- end)
		-- frame:SetScript("OnLeave", function()
		-- 	GameTooltip:Hide()
		-- 	if _G["NecrosisCurseMenuButton"] then NecrosisCurseMenuButton:SetAttribute("state", State) end
		-- end)
		-- frame:SetScript("OnValueChanged", function(self)
		-- 	GameTooltip:SetText(self:GetValue())
		-- 	NecrosisConfig.CurseMenuDecalage.y = self:GetValue()
		-- 	Necrosis:SetOfxy("Curse")
		-- end)

		-- NecrosisCurseOyText:SetText("Offset Y")
		-- NecrosisCurseOyLow:SetText("")
		-- NecrosisCurseOyHigh:SetText("")

		if not (NecrosisConfig.BuffMenuPos.x == 0) then
			UIDropDownMenu_SetSelectedID(self.ddBuffVector, 1)
			UIDropDownMenu_SetText(self.ddBuffVector, Necrosis.Config.Menus.Orientation[1])
		elseif NecrosisConfig.BuffMenuPos.y > 0 then
			UIDropDownMenu_SetSelectedID(self.ddBuffVector, 2)
			UIDropDownMenu_SetText(self.ddBuffVector, Necrosis.Config.Menus.Orientation[2])
		else
			UIDropDownMenu_SetSelectedID(self.ddBuffVector, 3)
			UIDropDownMenu_SetText(self.ddBuffVector, Necrosis.Config.Menus.Orientation[3])
		end

		if not (NecrosisConfig.PetMenuPos.x == 0) then
			UIDropDownMenu_SetSelectedID(self.ddDemonVector, 1)
			UIDropDownMenu_SetText(self.ddDemonVector, Necrosis.Config.Menus.Orientation[1])
		elseif NecrosisConfig.PetMenuPos.y > 0 then
			UIDropDownMenu_SetSelectedID(self.ddDemonVector, 2)
			UIDropDownMenu_SetText(self.ddDemonVector, Necrosis.Config.Menus.Orientation[2])
		else
			UIDropDownMenu_SetSelectedID(self.ddDemonVector, 3)
			UIDropDownMenu_SetText(self.ddDemonVector, Necrosis.Config.Menus.Orientation[3])
		end
	
		if not (NecrosisConfig.CurseMenuPos.x == 0) then
			UIDropDownMenu_SetSelectedID(self.ddCurseVector, 1)
			UIDropDownMenu_SetText(self.ddCurseVector, Necrosis.Config.Menus.Orientation[1])
		elseif NecrosisConfig.CurseMenuPos.y > 0 then
			UIDropDownMenu_SetSelectedID(self.ddCurseVector, 2)
			UIDropDownMenu_SetText(self.ddCurseVector, Necrosis.Config.Menus.Orientation[2])
		else
			UIDropDownMenu_SetSelectedID(self.ddCurseVector, 3)
			UIDropDownMenu_SetText(self.ddCurseVector, Necrosis.Config.Menus.Orientation[3])
		end

		if NecrosisConfig.BlockedMenu then
			self.cbAutoMenu:Disable()
			self.cbCloseMenu:Disable()
		else
			self.cbAutoMenu:Enable()
			self.cbCloseMenu:Enable()
		end
	end

	-- UIDropDownMenu_Initialize(NecrosisBuffVector, _mv.BuffVector_Init)
	-- UIDropDownMenu_Initialize(NecrosisDemonVector, _mv.DemonVector_Init)
	-- UIDropDownMenu_Initialize(NecrosisCurseVector, _mv.CurseVector_Init)

	-- NecrosisMenusConfig1Text:SetText(Necrosis.Config.Menus["Options Generales"])
	-- NecrosisMenusConfig2Text:SetText(Necrosis.Config.Menus["Menu des Buffs"])
	-- NecrosisMenusConfig3Text:SetText(Necrosis.Config.Menus["Menu des Demons"])
	-- NecrosisMenusConfig4Text:SetText(Necrosis.Config.Menus["Menu des Maledictions"])

	-- NecrosisBlockedMenu:SetText(Necrosis.Config.Menus["Afficher les menus en permanence"])
	-- NecrosisAutoMenu:SetText(Necrosis.Config.Menus["Afficher automatiquement les menus en combat"])
	-- NecrosisCloseMenu:SetText(Necrosis.Config.Menus["Fermer le menu apres un clic sur un de ses elements"])

	-- NecrosisBuffVectorT:SetText(Necrosis.Config.Menus["Orientation du menu"])
	-- NecrosisBuffSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])
	-- NecrosisBanishSizeText:SetText(Necrosis.Config.Menus["Taille du bouton Banir"])

	-- NecrosisDemonVectorT:SetText(Necrosis.Config.Menus["Orientation du menu"])
	-- NecrosisDemonSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])

	-- NecrosisCurseVectorT:SetText(Necrosis.Config.Menus["Orientation du menu"])
	-- NecrosisCurseSens:SetText(Necrosis.Config.Menus["Changer la symetrie verticale des boutons"])

	-- NecrosisBlockedMenu:SetChecked(NecrosisConfig.BlockedMenu)
	-- NecrosisAutoMenu:SetChecked(NecrosisConfig.AutomaticMenu)
	-- NecrosisCloseMenu:SetChecked(NecrosisConfig.ClosingMenu)

	-- if not (NecrosisConfig.BuffMenuPos.x == 0) then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 1)
	-- 	UIDropDownMenu_SetText(NecrosisBuffVector, Necrosis.Config.Menus.Orientation[1])
	-- elseif NecrosisConfig.BuffMenuPos.y > 0 then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 2)
	-- 	UIDropDownMenu_SetText(NecrosisBuffVector, Necrosis.Config.Menus.Orientation[2])
	-- else
	-- 	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, 3)
	-- 	UIDropDownMenu_SetText(NecrosisBuffVector, Necrosis.Config.Menus.Orientation[3])
	-- end
	-- NecrosisBuffSens:SetChecked(NecrosisConfig.BuffMenuPos.direction < 0)
	-- NecrosisBanishSize:SetValue(NecrosisConfig.BanishScale)
	-- NecrosisBuffOx:SetValue(NecrosisConfig.BuffMenuDecalage.x)
	-- NecrosisBuffOy:SetValue(NecrosisConfig.BuffMenuDecalage.y)

	-- if not (NecrosisConfig.PetMenuPos.x == 0) then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 1)
	-- 	UIDropDownMenu_SetText(NecrosisDemonVector, Necrosis.Config.Menus.Orientation[1])
	-- elseif NecrosisConfig.PetMenuPos.y > 0 then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 2)
	-- 	UIDropDownMenu_SetText(NecrosisDemonVector, Necrosis.Config.Menus.Orientation[2])
	-- else
	-- 	UIDropDownMenu_SetSelectedID(NecrosisDemonVector, 3)
	-- 	UIDropDownMenu_SetText(NecrosisDemonVector, Necrosis.Config.Menus.Orientation[3])
	-- end
	-- NecrosisDemonSens:SetChecked(NecrosisConfig.PetMenuPos.direction < 0)
	-- NecrosisDemonOx:SetValue(NecrosisConfig.PetMenuDecalage.x)
	-- NecrosisDemonOy:SetValue(NecrosisConfig.PetMenuDecalage.y)

	-- if not (NecrosisConfig.CurseMenuPos.x == 0) then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 1)
	-- 	UIDropDownMenu_SetText(NecrosisCurseVector, Necrosis.Config.Menus.Orientation[1])
	-- elseif NecrosisConfig.CurseMenuPos.y > 0 then
	-- 	UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 2)
	-- 	UIDropDownMenu_SetText(NecrosisCurseVector, Necrosis.Config.Menus.Orientation[2])
	-- else
	-- 	UIDropDownMenu_SetSelectedID(NecrosisCurseVector, 3)
	-- 	UIDropDownMenu_SetText(NecrosisCurseVector, Necrosis.Config.Menus.Orientation[3])
	-- end
	-- NecrosisCurseSens:SetChecked(NecrosisConfig.CurseMenuPos.direction < 0)
	-- NecrosisCurseOx:SetValue(NecrosisConfig.CurseMenuDecalage.x)
	-- NecrosisCurseOy:SetValue(NecrosisConfig.CurseMenuDecalage.y)

	-- if NecrosisConfig.BlockedMenu then
	-- 	NecrosisAutoMenu:Disable()
	-- 	NecrosisCloseMenu:Disable()
	-- else
	-- 	NecrosisAutoMenu:Enable()
	-- 	NecrosisCloseMenu:Enable()
	-- end

	self.Frame:Show()
end

function _mv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des Buff
function _mv.BuffVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = _mv.BuffVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function _mv.BuffVector_Click(self)
	local ID = self:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisBuffVector, ID)
	if ID == 1 then
		NecrosisConfig.BuffMenuPos.x = 1
		NecrosisConfig.BuffMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = 1
	else
		NecrosisConfig.BuffMenuPos.x = 0
		NecrosisConfig.BuffMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Démons
function _mv.DemonVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = _mv.DemonVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function _mv.DemonVector_Click(self)
	local ID = self:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisDemonVector, ID)
	if ID == 1 then
		NecrosisConfig.PetMenuPos.x = 1
		NecrosisConfig.PetMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = 1
	else
		NecrosisConfig.PetMenuPos.x = 0
		NecrosisConfig.PetMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end

-- Fonctions du Dropdown des Malédictions
function _mv.CurseVector_Init()
	local element = {}

	for i in ipairs(Necrosis.Config.Menus.Orientation) do
		element.text = Necrosis.Config.Menus.Orientation[i]
		element.checked = false
		element.func = _mv.CurseVector_Click
		UIDropDownMenu_AddButton(element)
	end
end

function _mv.CurseVector_Click(self)
	local ID = self:GetID()

	UIDropDownMenu_SetSelectedID(NecrosisCurseVector, ID)
	if ID == 1 then
		NecrosisConfig.CurseMenuPos.x = 1
		NecrosisConfig.CurseMenuPos.y = 0
	elseif ID == 2 then
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = 1
	else
		NecrosisConfig.CurseMenuPos.x = 0
		NecrosisConfig.CurseMenuPos.y = -1
	end
	Necrosis:CreateMenu()
end
