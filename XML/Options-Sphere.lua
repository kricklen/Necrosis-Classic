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
-- $LastChangedDate: 2008-10-20 08:29:32 +1100 (Mon, 20 Oct 2008) $
------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

Gui.Views.SphereConfig = {
	Frame = false
}

-- On crée ou on affiche le panneau de configuration de la sphere
function Gui.Views.SphereConfig:Show()

	if not self.Frame then
		-- Création de la fenêtre
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

		-- Création du slider de scale de Necrosis
		self.slSphereSize = GraphicsHelper:CreateSlider(
			self.Frame,
			"slSphereSize",
			50, 200, 5,
			15, 150,
			80, -20
		)
		self.slSphereSizeText = slSphereSizeText
		self.slSphereSizeLow = slSphereSizeLow
		self.slSphereSizeHigh = slSphereSizeHigh

		self.slSphereSizeText:SetText(Necrosis.Config.Sphere["Taille de la sphere"])
		self.slSphereSizeLow:SetText("50 %")
		self.slSphereSizeHigh:SetText("200 %")

		local NBx, NBy
		self.slSphereSize:SetScript("OnLeave", function() GameTooltip:Hide() end)
		self.slSphereSize:SetScript(
			"OnEnter",
			function(self)
				NBx, NBy = NecrosisButton:GetCenter()
				NBx = NBx * (NecrosisConfig.NecrosisButtonScale / 100)
				NBy = NBy * (NecrosisConfig.NecrosisButtonScale / 100)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue().." %")
			end
		)
		self.slSphereSize:SetScript(
			"OnValueChanged",
			function(self)
				if not (self:GetValue() == NecrosisConfig.NecrosisButtonScale) then
					NecrosisButton:ClearAllPoints()
					GameTooltip:SetText(self:GetValue().." %")
					NecrosisConfig.NecrosisButtonScale = self:GetValue()
					NecrosisButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", NBx / (NecrosisConfig.NecrosisButtonScale / 100), NBy / (NecrosisConfig.NecrosisButtonScale / 100))
					NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale / 100)
					Necrosis:ButtonSetup()
				end
			end
		)

		-- Skin de la sphère
		self.ddSkins, self.lblSkins = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Skin de la pierre Necrosis"],
			0, -60
		)

		-- Evenement montré par la sphère
		self.ddEvents, self.lblEvents = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Evenement montre par la sphere"],
			0, -88
		)

		-- Sort associé à la sphère
		self.ddSpells, self.lblSpells = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Sort caste par la sphere"],
			0, -116
		)

		-- Affiche ou masque le compteur numérique
		self.cbShowCount = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Sphere["Afficher le compteur numerique"],
			0, -144,
			function(self)
				NecrosisConfig.ShowCount = self:GetChecked()
				Necrosis:BagExplore()
			end
		)

		-- Evenement montré par le compteur
		self.ddCount, self.lblCount = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Type de compteur numerique"],
			0, -172
		)

		-- Handler to update texts when language changes
		local function updateTexts()
			Gui.Views.SphereConfig.slSphereSizeText:SetText(Necrosis.Config.Sphere["Taille de la sphere"])
			Gui.Views.SphereConfig.lblSkins:SetText(Necrosis.Config.Sphere["Skin de la pierre Necrosis"])
			UIDropDownMenu_SetText(
				Gui.Views.SphereConfig.ddSkins,
				Necrosis.Config.Sphere.Colour[UIDropDownMenu_GetSelectedID(Gui.Views.SphereConfig.ddSkins)]
			)
			Gui.Views.SphereConfig.lblEvents:SetText(Necrosis.Config.Sphere["Evenement montre par la sphere"])
			Gui.Views.SphereConfig.lblSpells:SetText(Necrosis.Config.Sphere["Sort caste par la sphere"])
			Necrosis.Spell_Init(Gui.Views.SphereConfig.ddSpells)
			-- UIDropDownMenu_SetText(
			-- 	NecrosisSpellSelection,
			-- 	Necrosis.Spell[spell[UIDropDownMenu_GetSelectedID(NecrosisSpellSelection)]].Name
			-- )
			Gui.Views.SphereConfig.cbShowCount:SetText(Necrosis.Config.Sphere["Afficher le compteur numerique"])
			Gui.Views.SphereConfig.lblCount:SetText(Necrosis.Config.Sphere["Type de compteur numerique"])
		end
		EventHub:RegisterLanguageChangedHandler(updateTexts)

		local function initDropdowns()
print("initDropdowns")
			UIDropDownMenu_Initialize(self.ddSkins, Necrosis.Skin_Init)
			UIDropDownMenu_Initialize(self.ddEvents, Necrosis.Event_Init)
			UIDropDownMenu_Initialize(self.ddSpells, Necrosis.Spell_Init)
			UIDropDownMenu_Initialize(self.ddCount, Necrosis.Count_Init)
		end
		initDropdowns()

		local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
		for i in ipairs(couleur) do
			if couleur[i] == NecrosisConfig.NecrosisColor then
				UIDropDownMenu_SetSelectedID(self.ddSkins, i)
				UIDropDownMenu_SetText(self.ddSkins, Necrosis.Config.Sphere.Colour[i])
				break
			end
		end

		UIDropDownMenu_SetSelectedID(self.ddEvents, NecrosisConfig.Circle)
		if NecrosisConfig.Circle == 1 then
			UIDropDownMenu_SetText(self.ddEvents, Necrosis.Config.Sphere.Count[NecrosisConfig.Circle])
		else
			UIDropDownMenu_SetText(self.ddEvents, Necrosis.Config.Sphere.Count[NecrosisConfig.Circle + 1])
		end


	end

	self.slSphereSize:SetValue(NecrosisConfig.NecrosisButtonScale)
	self.cbShowCount:SetChecked(NecrosisConfig.ShowCount)

	-- local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	-- for i in ipairs(couleur) do
	-- 	if couleur[i] == NecrosisConfig.NecrosisColor then
	-- 		UIDropDownMenu_SetSelectedID(NecrosisSkinSelection, i)
	-- 		UIDropDownMenu_SetText(NecrosisSkinSelection, self.Config.Sphere.Colour[i])
	-- 		break
	-- 	end
	-- end

	-- UIDropDownMenu_SetSelectedID(NecrosisEventSelection, NecrosisConfig.Circle)
	-- if NecrosisConfig.Circle == 1 then
	-- 	UIDropDownMenu_SetText(NecrosisEventSelection, self.Config.Sphere.Count[NecrosisConfig.Circle])
	-- else
	-- 	UIDropDownMenu_SetText(NecrosisEventSelection, self.Config.Sphere.Count[NecrosisConfig.Circle + 1])
	-- end

	-- local spell = {19, 31, 37, 41, 43, 44, 55}
	-- for i in ipairs(spell) do
	-- 	if spell[i] == NecrosisConfig.MainSpell then
	-- 		UIDropDownMenu_SetSelectedID(NecrosisSpellSelection, i)
	-- 		UIDropDownMenu_SetText(NecrosisSpellSelection, self.Spell[spell[i]].Name)
	-- 		break
	-- 	end
	-- end

	UIDropDownMenu_SetSelectedID(self.ddCount, NecrosisConfig.CountType)
	UIDropDownMenu_SetText(self.ddCount, Necrosis.Config.Sphere.Count[NecrosisConfig.CountType])

	self.Frame:Show()
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des skins
function Necrosis.Skin_Init(dd)
	local element = {}

	for i in ipairs(Necrosis.Config.Sphere.Colour) do
		element.text = Necrosis.Config.Sphere.Colour[i]
		element.checked = false
		element.func = Necrosis.Skin_Click
		element.arg1 = dd
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Skin_Click(item, dd)
	local ID = item:GetID()
	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
	UIDropDownMenu_SetSelectedID(dd, ID)
	NecrosisConfig.NecrosisColor = couleur[ID]
	NecrosisButton:SetNormalTexture(GraphicsHelper:GetTexture(couleur[ID].."\\Shard16"))
end

-- Fonctions du Dropdown des Events de la sphère
function Necrosis.Event_Init(dd)
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Count) do
		if not (i == 2) then
			element.text = Necrosis.Config.Sphere.Count[i]
			element.checked = false
			element.func = Necrosis.Event_Click
			element.arg1 = dd
			UIDropDownMenu_AddButton(element)
		end
	end
end

function Necrosis.Event_Click(item, dd)
	local ID = item:GetID()
	UIDropDownMenu_SetSelectedID(dd, ID)
	NecrosisConfig.Circle = ID
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end

-- Fonctions du Dropdown des sorts de la sphère
function Necrosis.Spell_Init(dd)
	local spell = {19, 31, 37, 41, 43, 44, 55}
	for i in ipairs(spell) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Spell[spell[i]].Name,
			value = spell[i],
			checked = false,
			func = Necrosis.Spell_Click,
			arg1 = dd
		})
		if spell[i] == NecrosisConfig.MainSpell then
			UIDropDownMenu_SetSelectedID(dd, i)
			UIDropDownMenu_SetText(dd, Necrosis.Spell[spell[i]].Name)
			-- break
		end
	end
-- local spell =  {19, 31, 37, 41, 43, 44, 55}
-- 	local element = {}
-- 	for i in ipairs(spell) do
-- 		element.text = Necrosis.Spell[spell[i]].Name
-- 		element.value = spell[i]
-- 		element.checked = false
-- 		element.func = Necrosis.Spell_Click
-- 		UIDropDownMenu_AddButton(element)
-- 	end
end

function Necrosis.Spell_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.MainSpell = item.value
	Necrosis.MainButtonAttribute()
end

-- Fonctions du Dropdown des Events du compteur
function Necrosis.Count_Init(dd)
	local element = {}
	for i in ipairs(Necrosis.Config.Sphere.Count) do
		element.text = Necrosis.Config.Sphere.Count[i]
		element.checked = false
		element.func = Necrosis.Count_Click
		element.arg1 = dd
		UIDropDownMenu_AddButton(element)
	end
end

function Necrosis.Count_Click(item, dd)
	local ID = item:GetID()
	UIDropDownMenu_SetSelectedID(dd, ID)
	NecrosisConfig.CountType = ID
	NecrosisShardCount:SetText("")
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end