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

Necrosis.Gui.SphereView = {
	ButtonX = false,
	ButtonY = false,

	Frame = false,

	slSphereSize = false,
	slSphereSizeText = false,
	slSphereSizeLow = false,
	slSphereSizeHigh = false,
	cbShowCount = false,
	lblSkins = false,
	ddSkins = false,
	lblEvents = false,
	ddEvents = false,
	lblSpells = false,
	ddSpells = false,
	cbShowCount = false,
	lblCount = false,
	ddCount = false,
	
	_Spells = {19, 31, 37, 41, 43, 44, 55},
	_Skins = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"},
	_SphereEvents = {"Soulshards", "RezTimer", "Mana", "Health"},
	_SphereCounts = {"Soulshards", "DemonStones", "RezTimer", "Mana", "Health"},
}

local _sv = Necrosis.Gui.SphereView

function _sv:slSphereSize_OnEnter()
	_sv.ButtonX, _sv.ButtonY = NecrosisButton:GetCenter()
	_sv.ButtonX = _sv.ButtonX * (NecrosisConfig.NecrosisButtonScale / 100)
	_sv.ButtonY = _sv.ButtonY * (NecrosisConfig.NecrosisButtonScale / 100)
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
	GameTooltip:SetText(self:GetValue().." %")
end

function _sv:slSphereSize_OnValueChanged()
	if not (self:GetValue() == NecrosisConfig.NecrosisButtonScale) then
		NecrosisButton:ClearAllPoints()
		GameTooltip:SetText(self:GetValue().." %")
		NecrosisConfig.NecrosisButtonScale = self:GetValue()
		NecrosisButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT",
			_sv.ButtonX / (NecrosisConfig.NecrosisButtonScale / 100),
			_sv.ButtonY / (NecrosisConfig.NecrosisButtonScale / 100))
		NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale / 100)
		Necrosis:ButtonSetup()
	end
end

function _sv:cbShowCount_Click()
	NecrosisConfig.ShowCount = self:GetChecked()
	Necrosis:BagExplore()
end

-- Fonctions du Dropdown des skins
function _sv.ddSkins_Init(dd)
	local element = {}
	for i,skinName in ipairs(_sv._Skins) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Sphere.Colour[skinName],
			value = skinName,
			checked = false,
			func = _sv.ddSkins_Click,
			arg1 = dd
		})
		-- Check for and set currently selected value
		if skinName == NecrosisConfig.NecrosisColor then
			UIDropDownMenu_SetSelectedValue(dd, skinName)
		end
	end
end

function _sv.ddSkins_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.NecrosisColor = item.value
	NecrosisButton:SetNormalTexture(GraphicsHelper:GetTexture(item.value.."\\Shard16"))
end

-- Fonctions du Dropdown des sorts de la sphère
function _sv.ddSpells_Init(dd)
	for i,spellIndex in ipairs(_sv._Spells) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Spell[spellIndex].Name,
			value = spellIndex,
			checked = false,
			func = _sv.ddSpells_Click,
			arg1 = dd
		})
		if spellIndex == NecrosisConfig.MainSpell then
			UIDropDownMenu_SetSelectedValue(dd, spellIndex)
			UIDropDownMenu_SetText(dd, Necrosis.Spell[spellIndex].Name)
		end
	end
end

function _sv.ddSpells_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.MainSpell = item.value
	Necrosis.MainButtonAttribute()
end

-- Fonctions du Dropdown des Events de la sphère
function _sv.ddEvents_Init(dd)
	for i,count in ipairs(_sv._SphereEvents) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Sphere.Count[count],
			value = count,
			checked = false,
			func = _sv.ddEvents_Click,
			arg1 = dd
		})
		if count == NecrosisConfig.Circle then
			UIDropDownMenu_SetSelectedValue(dd, count)
		end
	end
end

function _sv.ddEvents_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.Circle = item.value
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end

-- Fonctions du Dropdown des Events du compteur
function _sv.ddCount_Init(dd)
	for i,count in ipairs(_sv._SphereCounts) do
		UIDropDownMenu_AddButton({
			text = Necrosis.Config.Sphere.Count[count],
			value = count,
			checked = false,
			func = _sv.ddCount_Click,
			arg1 = dd
		})
		if count == NecrosisConfig.CountType then
			UIDropDownMenu_SetSelectedValue(dd, count)
		end
	end
end

function _sv.ddCount_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.CountType = item.value
	NecrosisShardCount:SetText("")
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()
	Necrosis:BagExplore()
end

-- Handler to update texts when language changes
function _sv.UpdateTexts()
	_sv.slSphereSizeText:SetText(Necrosis.Config.Sphere["Taille de la sphere"])
	_sv.lblSkins:SetText(Necrosis.Config.Sphere["Skin de la pierre Necrosis"])
	UIDropDownMenu_Initialize(_sv.ddSkins, _sv.ddSkins_Init)
	_sv.lblEvents:SetText(Necrosis.Config.Sphere["Evenement montre par la sphere"])
	UIDropDownMenu_Initialize(_sv.ddEvents, _sv.ddEvents_Init)
	_sv.lblSpells:SetText(Necrosis.Config.Sphere["Sort caste par la sphere"])
	UIDropDownMenu_Initialize(_sv.ddSpells, _sv.ddSpells_Init)
	_sv.cbShowCount:SetText(Necrosis.Config.Sphere["Afficher le compteur numerique"])
	_sv.lblCount:SetText(Necrosis.Config.Sphere["Type de compteur numerique"])
	UIDropDownMenu_Initialize(_sv.ddCount, _sv.ddCount_Init)
end

-- On crée ou on affiche le panneau de configuration de la sphere
function _sv:Show()
	if not self.Frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)

		-- Création du slider de scale de Necrosis
		self.slSphereSize = GraphicsHelper:CreateSlider(
			self.Frame,
			"slSphereSize",
			50, 200, 5,
			15, 150,
			80, -20
		)
		-- Set special controls that are created automatically with the slider
		self.slSphereSizeText = slSphereSizeText
		self.slSphereSizeLow = slSphereSizeLow
		self.slSphereSizeHigh = slSphereSizeHigh

		self.slSphereSizeText:SetText(Necrosis.Config.Sphere["Taille de la sphere"])
		self.slSphereSizeLow:SetText("50 %")
		self.slSphereSizeHigh:SetText("200 %")

		self.slSphereSize:SetScript("OnLeave", function() GameTooltip:Hide() end)
		self.slSphereSize:SetScript("OnEnter", _sv.slSphereSize_OnEnter)
		self.slSphereSize:SetScript("OnValueChanged", _sv.slSphereSize_OnValueChanged)
		self.slSphereSize:SetValue(NecrosisConfig.NecrosisButtonScale)

		-- Skin de la sphère
		self.ddSkins, self.lblSkins = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Skin de la pierre Necrosis"],
			0, -60
		)
		UIDropDownMenu_Initialize(self.ddSkins, self.ddSkins_Init)

		-- Evenement montré par la sphère
		self.ddEvents, self.lblEvents = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Evenement montre par la sphere"],
			0, -88
		)
		UIDropDownMenu_Initialize(self.ddEvents, self.ddEvents_Init)

		-- Sort associé à la sphère
		self.ddSpells, self.lblSpells = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Sort caste par la sphere"],
			0, -116
		)
		UIDropDownMenu_Initialize(self.ddSpells, self.ddSpells_Init)

		-- Affiche ou masque le compteur numérique
		self.cbShowCount = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Sphere["Afficher le compteur numerique"],
			0, -144,
			_sv.cbShowCount_Click
		)
		self.cbShowCount:SetChecked(NecrosisConfig.ShowCount)

		-- Evenement montré par le compteur
		self.ddCount, self.lblCount = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Sphere["Type de compteur numerique"],
			0, -172
		)
		UIDropDownMenu_Initialize(self.ddCount, self.ddCount_Init)

		EventHub:RegisterLanguageChangedHandler(self.UpdateTexts)
	end
	self.Frame:Show()
end

function _sv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end

------------------------------------------------------------------------------------------------------
-- FONCTIONS NECESSAIRES AUX DROPDOWNS
------------------------------------------------------------------------------------------------------

-- Fonctions du Dropdown des skins
-- function Necrosis.Skin_Init(dd)
-- 	local element = {}

-- 	for i in ipairs(Necrosis.Config.Sphere.Colour) do
-- 		element.text = Necrosis.Config.Sphere.Colour[i]
-- 		element.checked = false
-- 		element.func = Necrosis.Skin_Click
-- 		element.arg1 = dd
-- 		UIDropDownMenu_AddButton(element)
-- 	end
-- end

-- function Necrosis.Skin_Click(item, dd)
-- 	local ID = item:GetID()
-- 	local couleur = {"Rose", "Bleu", "Orange", "Turquoise", "Violet", "666", "X"}
-- 	UIDropDownMenu_SetSelectedID(dd, ID)
-- 	NecrosisConfig.NecrosisColor = couleur[ID]
-- 	NecrosisButton:SetNormalTexture(GraphicsHelper:GetTexture(couleur[ID].."\\Shard16"))
-- end

-- Fonctions du Dropdown des Events de la sphère
-- function Necrosis.Event_Init(dd)
-- 	local element = {}
-- 	for i in ipairs(Necrosis.Config.Sphere.Count) do
-- 		if not (i == 2) then
-- 			element.text = Necrosis.Config.Sphere.Count[i]
-- 			element.checked = false
-- 			element.func = Necrosis.Event_Click
-- 			element.arg1 = dd
-- 			UIDropDownMenu_AddButton(element)
-- 		end
-- 	end
-- end

-- function Necrosis.Event_Click(item, dd)
-- 	local ID = item:GetID()
-- 	UIDropDownMenu_SetSelectedID(dd, ID)
-- 	NecrosisConfig.Circle = ID
-- 	Necrosis:UpdateHealth()
-- 	Necrosis:UpdateMana()
-- 	Necrosis:BagExplore()
-- end

-- Fonctions du Dropdown des sorts de la sphère
-- function Necrosis.Spell_Init(dd)
-- 	local spell = {19, 31, 37, 41, 43, 44, 55}
-- 	for i in ipairs(spell) do
-- 		UIDropDownMenu_AddButton({
-- 			text = Necrosis.Spell[spell[i]].Name,
-- 			value = spell[i],
-- 			checked = false,
-- 			func = Necrosis.Spell_Click,
-- 			arg1 = dd
-- 		})
-- 		if spell[i] == NecrosisConfig.MainSpell then
-- 			UIDropDownMenu_SetSelectedID(dd, i)
-- 			UIDropDownMenu_SetText(dd, Necrosis.Spell[spell[i]].Name)
-- 			-- break
-- 		end
-- 	end
-- -- local spell =  {19, 31, 37, 41, 43, 44, 55}
-- -- 	local element = {}
-- -- 	for i in ipairs(spell) do
-- -- 		element.text = Necrosis.Spell[spell[i]].Name
-- -- 		element.value = spell[i]
-- -- 		element.checked = false
-- -- 		element.func = Necrosis.Spell_Click
-- -- 		UIDropDownMenu_AddButton(element)
-- -- 	end
-- end

-- function Necrosis.Spell_Click(item, dd)
-- 	UIDropDownMenu_SetSelectedValue(dd, item.value)
-- 	NecrosisConfig.MainSpell = item.value
-- 	Necrosis.MainButtonAttribute()
-- end

-- Fonctions du Dropdown des Events du compteur
-- function Necrosis.Count_Init(dd)
-- 	local element = {}
-- 	for i in ipairs(Necrosis.Config.Sphere.Count) do
-- 		element.text = Necrosis.Config.Sphere.Count[i]
-- 		element.checked = false
-- 		element.func = Necrosis.Count_Click
-- 		element.arg1 = dd
-- 		UIDropDownMenu_AddButton(element)
-- 	end
-- end

-- function Necrosis.Count_Click(item, dd)
-- 	local ID = item:GetID()
-- 	UIDropDownMenu_SetSelectedID(dd, ID)
-- 	NecrosisConfig.CountType = ID
-- 	NecrosisShardCount:SetText("")
-- 	Necrosis:UpdateHealth()
-- 	Necrosis:UpdateMana()
-- 	Necrosis:BagExplore()
-- end