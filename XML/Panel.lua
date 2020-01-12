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
-- $LastChangedDate: 2008-10-26 20:09:15 +1100 (Sun, 26 Oct 2008) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- CRÉATION ET INVOCATION DU PANNEAU DE CONFIGURATION
------------------------------------------------------------------------------------------------------

local currentPanelId = 1

-- Opening the options menu framework
function Necrosis:OpenConfigPanel()

	-- Help messages are displayed
	if self.ChatMessage.Help[1] then
		for i = 1, #self.ChatMessage.Help, 1 do
			self:Msg(self.ChatMessage.Help[i], "USER")
		end
	end

	local frame = _G["NecrosisGeneralFrame"]

	-- If the window doesn't exist, create it
	if not frame then
		local sectionTitleWidth = 300
		local frameHeight = 512
		local frameWidth  = 428

		frame = CreateFrame("Frame", "NecrosisGeneralFrame", UIParent)

		-- Defining its attributes
		frame:SetFrameStrata("DIALOG")
		frame:SetMovable(true)
		frame:EnableMouse(true)
		frame:SetToplevel(true)
		frame:SetHeight(frameHeight)
		frame:SetWidth(frameWidth)
		frame:Show()
		frame:ClearAllPoints()
		if NecrosisConfig.FramePosition.NecrosisGeneralFrame then
			frame:SetPoint(
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][1],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][2],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][3],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][4],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][5]
			)
		else
			frame:SetPoint("TOPLEFT", 100, -100)
		end

		frame:RegisterForDrag("LeftButton")
		frame:SetScript("OnMouseUp", function(self) Necrosis:OnDragStop(self) end)
		frame:SetScript("OnDragStart", function(self) Necrosis:OnDragStart(self) end)
		frame:SetScript("OnDragStop", function(self) Necrosis:OnDragStop(self) end)

		local texture = frame:CreateTexture("NecrosisGeneralIcon", "BACKGROUND")
		-- texture:SetWidth(75)
		-- texture:SetWidth(61)
		texture:SetWidth(60)
		texture:SetHeight(60)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("Spellbook", "Spellbook-Icon"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", 10, -8)

		-- Frame textures
		texture = frame:CreateTexture(nil, "BORDER")
		texture:SetWidth(280)
		texture:SetHeight(280)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopLeft"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT")

		texture = frame:CreateTexture(nil, "BORDER")
		texture:SetWidth(148)
		texture:SetHeight(280)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopRight"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("TOPRIGHT")

		texture = frame:CreateTexture(nil, "BORDER")
		-- texture:SetWidth(322)
		texture:SetWidth(280)
		texture:SetHeight(280)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomLeft"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("BOTTOMLEFT")

		texture = frame:CreateTexture(nil, "BORDER")
		texture:SetWidth(148)
		texture:SetHeight(280)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomRight"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("BOTTOMRIGHT")

		-- Text of the title
		local FontString = frame:CreateFontString(nil, nil, "GameFontNormal")
		FontString:SetTextColor(1, 0.8, 0)
		FontString:SetText(self.Data.Label)
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("CENTER", 6, 229)

		-- Credits
		FontString = frame:CreateFontString(nil, nil, "GameFontNormal")
		FontString:SetTextColor(1, 0.8, 0)
		FontString:SetText("Developed by Lomig & Tarcalion")
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("TOP", 0, -42)

		-- Section title at the top of the page
		FontString = frame:CreateFontString("NecrosisGeneralPageText", nil, "GameFontNormal")
		FontString:SetTextColor(1, 1, 1)
		FontString:SetWidth(sectionTitleWidth)
		FontString:SetHeight(0)
		FontString:Show()
		FontString:ClearAllPoints()
		FontString:SetPoint("TOP", 0, -60)

		-- Window closing button
		frame = CreateFrame("Button", "NecrosisGeneralCloseButton", NecrosisGeneralFrame, "UIPanelCloseButton")
		frame:SetWidth(34)
		frame:SetHeight(34)
		frame:ClearAllPoints()
		frame:SetPoint("CENTER", "NecrosisGeneralFrame", "TOPRIGHT", -53, -27)

		-- First tab of the configuration panel
		frame = CreateFrame("CheckButton", "NecrosisGeneralTab1", NecrosisGeneralFrame)
		frame:SetWidth(32)
		frame:SetHeight(32)
		frame:Show()
		frame:ClearAllPoints()
		frame:SetPoint("TOPLEFT", "NecrosisGeneralFrame", "TOPRIGHT", -41, -68)

		frame:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(Necrosis.Config.Panel[1])
			end
		)
		frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		frame:SetScript("OnClick", function() Necrosis:SetPanel(1) end)

		texture = frame:CreateTexture(nil, "BACKGROUND")
		texture:SetWidth(64)
		texture:SetHeight(64)
		texture:SetTexture(GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"))
		texture:Show()
		texture:ClearAllPoints()
		texture:SetPoint("TOPLEFT", -3, 11)

		frame:SetNormalTexture(GraphicsHelper:GetWoWTexture("Icons", "Ability_Creature_Cursed_03"))
		frame:SetHighlightTexture(GraphicsHelper:GetWoWTexture("Buttons", "ButtonHilight-Square"))
		frame:GetHighlightTexture():SetBlendMode("ADD")
		frame:SetCheckedTexture(GraphicsHelper:GetWoWTexture("Buttons", "CheckButtonHilight"))
		frame:GetCheckedTexture():SetBlendMode("ADD")

		-- Autres onglets
		local tex = {
			"INV_Misc_Gem_Amethyst_02",
			"Trade_Engineering",
			"INV_Wand_1H_Stratholme_D_02",
			"Spell_Nature_TimeStop",
			"Ability_Creature_Disease_05"
		}
	 
		for i in ipairs(tex) do
			frame = CreateFrame("CheckButton", "NecrosisGeneralTab"..(i + 1), NecrosisGeneralFrame)
			frame:SetWidth(32)
			frame:SetHeight(32)
			frame:Show()
			frame:ClearAllPoints()
			frame:SetPoint("TOPLEFT", "NecrosisGeneralTab"..i, "BOTTOMLEFT", 0, -17)
			
			frame:SetScript("OnEnter",
				function(self)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					GameTooltip:SetText(Necrosis.Config.Panel[i + 1])
				end
			)
			frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
			frame:SetScript("OnClick", function() Necrosis:SetPanel(i + 1) end)


			texture = frame:CreateTexture(nil, "BACKGROUND")
			texture:SetWidth(64)
			texture:SetHeight(64)
			texture:SetTexture(GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"))
			texture:Show()
			texture:ClearAllPoints()
			texture:SetPoint("TOPLEFT", -3, 11)

			frame:SetNormalTexture(GraphicsHelper:GetWoWTexture("Icons", tex[i]))
			frame:SetHighlightTexture(GraphicsHelper:GetWoWTexture("Buttons", "ButtonHilight-Square"))
			frame:GetHighlightTexture():SetBlendMode("ADD")
			frame:SetCheckedTexture(GraphicsHelper:GetWoWTexture("Buttons", "CheckButtonHilight"))
			frame:GetCheckedTexture():SetBlendMode("ADD")
		end

		self:SetPanel(1)

		-- Register handler to update texts when language changes
		local function updateTexts()
			NecrosisGeneralPageText:SetText(Necrosis.Config.Panel[currentPanelId])
		end
		EventHub:RegisterLanguageChangedHandler(updateTexts)
	else

		if frame:IsVisible() then
			frame:Hide()
		else
			frame:Show()
		end
	end
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS LIÉES AU PANNEAU DE CONFIGURATION
------------------------------------------------------------------------------------------------------

-- Function to display different pages of the control panel || Fonction permettant l'affichage des différentes pages du panneau de configuration
function Necrosis:SetPanel(PanelID)
	currentPanelId = PanelID
	local TabName
	for index=1, 6, 1 do
		TabName = _G["NecrosisGeneralTab"..index]
		if index == PanelID then
			TabName:SetChecked(1)
		else
			TabName:SetChecked(nil)
		end
	end
	NecrosisGeneralPageText:SetText(self.Config.Panel[PanelID])
	if PanelID == 1 then
		HideUIPanel(Gui.SphereView.Frame)
		HideUIPanel(NecrosisButtonsConfig)
		HideUIPanel(NecrosisMenusConfig)
		HideUIPanel(NecrosisTimersConfig)
		HideUIPanel(NecrosisMiscConfig)
		-- self:SetMessagesConfig()
		Gui.MessagesView:Show()
	elseif PanelID == 2 then
		HideUIPanel(Gui.MessagesView.Frame)
		HideUIPanel(NecrosisButtonsConfig)
		HideUIPanel(NecrosisMenusConfig)
		HideUIPanel(NecrosisTimersConfig)
		HideUIPanel(NecrosisMiscConfig)
		-- self:SetSphereConfig()
		Gui.SphereView:Show()
	elseif PanelID == 3 then
		HideUIPanel(Gui.MessagesView.Frame)
		HideUIPanel(Gui.SphereView.Frame)
		HideUIPanel(NecrosisMenusConfig)
		HideUIPanel(NecrosisTimersConfig)
		HideUIPanel(NecrosisMiscConfig)
		self:SetButtonsConfig()
	elseif PanelID == 4 then
		HideUIPanel(Gui.MessagesView.Frame)
		HideUIPanel(Gui.SphereView.Frame)
		HideUIPanel(NecrosisButtonsConfig)
		HideUIPanel(NecrosisTimersConfig)
		HideUIPanel(NecrosisMiscConfig)
		self:SetMenusConfig()
	elseif PanelID == 5 then
		HideUIPanel(Gui.MessagesView.Frame)
		HideUIPanel(Gui.SphereView.Frame)
		HideUIPanel(NecrosisButtonsConfig)
		HideUIPanel(NecrosisMenusConfig)
		HideUIPanel(NecrosisMiscConfig)
		self:SetTimersConfig()
	elseif PanelID == 6 then
		HideUIPanel(Gui.MessagesView.Frame)
		HideUIPanel(Gui.SphereView.Frame)
		HideUIPanel(NecrosisButtonsConfig)
		HideUIPanel(NecrosisMenusConfig)
		HideUIPanel(NecrosisTimersConfig)
		self:SetMiscConfig()
	end
end
