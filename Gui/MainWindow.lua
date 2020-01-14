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

------------------------------------------------------------------------------------------------------
-- CRÉATION ET INVOCATION DU PANNEAU DE CONFIGURATION
------------------------------------------------------------------------------------------------------

Necrosis.Gui.MainWindow = {
	Frame = false,
	bgIcon = false,
	bgTopLeft = false,
	bgTopRight = false,
	bgBottomLeft = false,
	bgBottomRight = false,
	fsTitle = false,
	fsCredits = false,
	fsTabTitle = false,
	btnClose = false,
	TabTable = {
		{ frame = Necrosis.Gui.MessagesView.Frame, 	texture = "Ability_Creature_Cursed_03"	},
		{ frame = Necrosis.Gui.SphereView.Frame, 	texture = "INV_Misc_Gem_Amethyst_02"	},
		{ frame = NecrosisButtonsConfig, 			texture = "Trade_Engineering"			},
		{ frame = NecrosisMenusConfig, 				texture = "INV_Wand_1H_Stratholme_D_02"	},
		{ frame = NecrosisTimersConfig, 			texture = "Spell_Nature_TimeStop"		},
		{ frame = NecrosisMiscConfig, 				texture = "Ability_Creature_Disease_05"	}
	}
}

local _mw = Necrosis.Gui.MainWindow

-- function _mw:CreatePanel()
-- 	-- First tab of the configuration panel
-- 	local cbTabMessages
-- 	cbTabMessages = CreateFrame("CheckButton", "NecrosisGeneralTab1", NecrosisGeneralFrame)
-- 	cbTabMessages:SetWidth(32)
-- 	cbTabMessages:SetHeight(32)
-- 	cbTabMessages:Show()
-- 	cbTabMessages:ClearAllPoints()
-- 	cbTabMessages:SetPoint("TOPLEFT", "NecrosisGeneralFrame", "TOPRIGHT", -41, -68)

-- 	cbTabMessages:SetScript("OnEnter",
-- 		function(self)
-- 			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
-- 			GameTooltip:SetText(Necrosis.Config.Panel[1])
-- 		end
-- 	)
-- 	cbTabMessages:SetScript("OnLeave", function() GameTooltip:Hide() end)
-- 	cbTabMessages:SetScript("OnClick", function() Necrosis:SetPanel(1) end)

-- 	local txTabMessages = GraphicsHelper:CreateTexture(
-- 		cbTabMessages, "BACKGROUND",
-- 		64, 64,
-- 		GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"),
-- 		"TOPLEFT",
-- 		-3, 11
-- 	)
-- 	-- texture = frame:CreateTexture(nil, "BACKGROUND")
-- 	-- texture:SetWidth(64)
-- 	-- texture:SetHeight(64)
-- 	-- texture:SetTexture(GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"))
-- 	-- texture:Show()
-- 	-- texture:ClearAllPoints()
-- 	-- texture:SetPoint("TOPLEFT", -3, 11)

-- 	cbTabMessages:SetNormalTexture(GraphicsHelper:GetWoWTexture("Icons", "Ability_Creature_Cursed_03"))
-- 	cbTabMessages:SetHighlightTexture(GraphicsHelper:GetWoWTexture("Buttons", "ButtonHilight-Square"))
-- 	cbTabMessages:GetHighlightTexture():SetBlendMode("ADD")
-- 	cbTabMessages:SetCheckedTexture(GraphicsHelper:GetWoWTexture("Buttons", "CheckButtonHilight"))
-- 	cbTabMessages:GetCheckedTexture():SetBlendMode("ADD")
-- end

function _mw.UpdateTexts()
	NecrosisGeneralPageText:SetText(Necrosis.Config.Panel[currentPanelId])
end

-- Opening the options menu framework
function _mw:Show()

	-- Help messages are displayed
	if Necrosis.ChatMessage.Help[1] then
		for i = 1, #Necrosis.ChatMessage.Help, 1 do
			Necrosis.Chat:_Msg(Necrosis.ChatMessage.Help[i], "USER")
		end
	end

	-- If the window doesn't exist, create it
	if not self.Frame then
		-- local sectionTitleWidth = 300
		-- local frameHeight = 512
		-- local frameWidth  = 428

		self.Frame = CreateFrame("Frame", "NecrosisGeneralFrame", UIParent)
		-- Defining its attributes
		self.Frame:SetFrameStrata("DIALOG")
		self.Frame:SetMovable(true)
		self.Frame:EnableMouse(true)
		self.Frame:SetToplevel(true)
		self.Frame:SetHeight(512)
		self.Frame:SetWidth(428)
		self.Frame:Show()
		self.Frame:ClearAllPoints()
		if NecrosisConfig.FramePosition.NecrosisGeneralFrame then
			self.Frame:SetPoint(
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][1],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][2],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][3],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][4],
				NecrosisConfig.FramePosition["NecrosisGeneralFrame"][5]
			)
		else
			self.Frame:SetPoint("TOPLEFT", 100, -100)
		end

		self.Frame:RegisterForDrag("LeftButton")
		self.Frame:SetScript("OnMouseUp", function(self) Necrosis:OnDragStop(self) end)
		self.Frame:SetScript("OnDragStart", function(self) Necrosis:OnDragStart(self) end)
		self.Frame:SetScript("OnDragStop", function(self) Necrosis:OnDragStop(self) end)

		self.bgIcon = GraphicsHelper:CreateTexture(
			self.Frame, "BACKGROUND"
			60, 60,
			GraphicsHelper:GetWoWTexture("Spellbook", "Spellbook-Icon"),
			"TOPLEFT",
			10, -8
		)
		-- local texture = frame:CreateTexture("NecrosisGeneralIcon", "BACKGROUND")
		-- texture:SetWidth(60)
		-- texture:SetHeight(60)
		-- texture:SetTexture(GraphicsHelper:GetWoWTexture("Spellbook", "Spellbook-Icon"))
		-- texture:Show()
		-- texture:ClearAllPoints()
		-- texture:SetPoint("TOPLEFT", 10, -8)

		-- Frame textures
		self.bgTopLeft = GraphicsHelper:CreateTexture(
			self.Frame, "BORDER",
			280, 280,
			GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopLeft"),
			"TOPLEFT",
			0, 0
		)
		-- texture = frame:CreateTexture(nil, "BORDER")
		-- texture:SetWidth(280)
		-- texture:SetHeight(280)
		-- texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopLeft"))
		-- texture:Show()
		-- texture:ClearAllPoints()
		-- texture:SetPoint("TOPLEFT")

		self.bgTopRight = GraphicsHelper:CreateTexture(
			self.Frame, "BORDER",
			280, 148,
			GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopRight"),
			"TOPRIGHT",
			0, 0
		)
		-- texture = frame:CreateTexture(nil, "BORDER")
		-- texture:SetWidth(148)
		-- texture:SetHeight(280)
		-- texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-TopRight"))
		-- texture:Show()
		-- texture:ClearAllPoints()
		-- texture:SetPoint("TOPRIGHT")

		self.bgBottomLeft = GraphicsHelper:CreateTexture(
			self.Frame, "BORDER",
			280, 280,
			GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomLeft"),
			"BOTTOMLEFT",
			0, 0
		)
		-- texture = frame:CreateTexture(nil, "BORDER")
		-- texture:SetWidth(280)
		-- texture:SetHeight(280)
		-- texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomLeft"))
		-- texture:Show()
		-- texture:ClearAllPoints()
		-- texture:SetPoint("BOTTOMLEFT")

		self.bgBottomRight = GraphicsHelper:CreateTexture(
			self.Frame, "BORDER",
			280, 148,
			GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomRight"),
			"BOTTOMRIGHT",
			0, 0
		)
		-- texture = frame:CreateTexture(nil, "BORDER")
		-- texture:SetWidth(148)
		-- texture:SetHeight(280)
		-- texture:SetTexture(GraphicsHelper:GetWoWTexture("PaperDollInfoFrame", "UI-Character-General-BottomRight"))
		-- texture:Show()
		-- texture:ClearAllPoints()
		-- texture:SetPoint("BOTTOMRIGHT")

		-- Text of the title
		-- parentFrame, name, text, position, x, y
		self.fsTitle = GraphicsHelper:CreateFontString(
			self.Frame, nil,
			Necrosis.Data.Label,
			"CENTER",
			6, 229
		)
		self.fsTitle:SetTextColor(1, 0.8, 0)
		-- local FontString = frame:CreateFontString(nil, nil, "GameFontNormal")
		-- FontString:SetTextColor(1, 0.8, 0)
		-- FontString:SetText(self.Data.Label)
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("CENTER", 6, 229)

		-- Credits
		self.fsCredits = GraphicsHelper:CreateFontString(
			self.Frame, nil,
			"Developed by Lomig & Tarcalion",
			"TOP",
			0, -42
		)
		self.fsCredits:SetTextColor(1, 0.8, 0)
		-- FontString = frame:CreateFontString(nil, nil, "GameFontNormal")
		-- FontString:SetTextColor(1, 0.8, 0)
		-- FontString:SetText("Developed by Lomig & Tarcalion")
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("TOP", 0, -42)

		-- Section title at the top of the page
		self.fsTabTitle = GraphicsHelper:CreateFontString(
			self.Frame, nil,
			nil,
			"TOP",
			0, -60
		)
		-- FontString = frame:CreateFontString("NecrosisGeneralPageText", nil, "GameFontNormal")
		-- FontString:SetTextColor(1, 1, 1)
		-- FontString:SetWidth(sectionTitleWidth)
		-- FontString:SetHeight(0)
		-- FontString:Show()
		-- FontString:ClearAllPoints()
		-- FontString:SetPoint("TOP", 0, -60)

		-- Window closing button
		self.btnClose = CreateFrame("Button", nil, self.Frame, "UIPanelCloseButton")
		self.btnClose:SetWidth(34)
		self.btnClose:SetHeight(34)
		self.btnClose:ClearAllPoints()
		self.btnClose:SetPoint("CENTER", "NecrosisGeneralFrame", "TOPRIGHT", -53, -27)

		-- -- First tab of the configuration panel
		-- local cbTabMessages
		-- cbTabMessages = CreateFrame("CheckButton", "NecrosisGeneralTab1", self.Frame)
		-- cbTabMessages:SetWidth(32)
		-- cbTabMessages:SetHeight(32)
		-- cbTabMessages:Show()
		-- cbTabMessages:ClearAllPoints()
		-- cbTabMessages:SetPoint("TOPLEFT", "NecrosisGeneralFrame", "TOPRIGHT", -41, -68)

		-- cbTabMessages:SetScript("OnEnter",
		-- 	function(self)
		-- 		GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
		-- 		GameTooltip:SetText(Necrosis.Config.Panel[1])
		-- 	end
		-- )
		-- cbTabMessages:SetScript("OnLeave", function() GameTooltip:Hide() end)
		-- cbTabMessages:SetScript("OnClick", function() Necrosis:SetPanel(1) end)

		-- local txTabMessages = GraphicsHelper:CreateTexture(
		-- 	cbTabMessages, "BACKGROUND",
		-- 	64, 64,
		-- 	GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"),
		-- 	"TOPLEFT",
		-- 	-3, 11
		-- )
		-- -- texture = frame:CreateTexture(nil, "BACKGROUND")
		-- -- texture:SetWidth(64)
		-- -- texture:SetHeight(64)
		-- -- texture:SetTexture(GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"))
		-- -- texture:Show()
		-- -- texture:ClearAllPoints()
		-- -- texture:SetPoint("TOPLEFT", -3, 11)

		-- cbTabMessages:SetNormalTexture(GraphicsHelper:GetWoWTexture("Icons", "Ability_Creature_Cursed_03"))
		-- cbTabMessages:SetHighlightTexture(GraphicsHelper:GetWoWTexture("Buttons", "ButtonHilight-Square"))
		-- cbTabMessages:GetHighlightTexture():SetBlendMode("ADD")
		-- cbTabMessages:SetCheckedTexture(GraphicsHelper:GetWoWTexture("Buttons", "CheckButtonHilight"))
		-- cbTabMessages:GetCheckedTexture():SetBlendMode("ADD")

		-- Create Tabs on the right side
		for i,item in ipairs(self.TabTable) do
			local tab = CreateFrame("CheckButton", "NecrosisGeneralTab"..(i), NecrosisGeneralFrame)
			tab:SetWidth(32)
			tab:SetHeight(32)
			tab:Show()
			tab:ClearAllPoints()
			tab:SetPoint("TOPLEFT", "NecrosisGeneralTab"..i, "BOTTOMLEFT", 0, -17)

			tab:SetScript("OnEnter",
				function(self)
					GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
					GameTooltip:SetText(Necrosis.Config.Panel[i])
				end
			)
			tab:SetScript("OnLeave", function() GameTooltip:Hide() end)
			tab:SetScript("OnClick", function() self:SetPanel(i) end)

			local txTabMessages = GraphicsHelper:CreateTexture(
				tab, "BACKGROUND",
				64, 64,
				GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"),
				"TOPLEFT",
				-3, 11
			)

			-- texture = frame:CreateTexture(nil, "BACKGROUND")
			-- texture:SetWidth(64)
			-- texture:SetHeight(64)
			-- texture:SetTexture(GraphicsHelper:GetWoWTexture("SpellBook", "SpellBook-SkillLineTab"))
			-- texture:Show()
			-- texture:ClearAllPoints()
			-- texture:SetPoint("TOPLEFT", -3, 11)

			tab:SetNormalTexture(GraphicsHelper:GetWoWTexture("Icons", item.texture))
			tab:SetHighlightTexture(GraphicsHelper:GetWoWTexture("Buttons", "ButtonHilight-Square"))
			tab:GetHighlightTexture():SetBlendMode("ADD")
			tab:SetCheckedTexture(GraphicsHelper:GetWoWTexture("Buttons", "CheckButtonHilight"))
			tab:GetCheckedTexture():SetBlendMode("ADD")

			item.tab = tab
		end

		self:SetPanel(1)

		-- Register handler to update texts when language changes
		EventHub:RegisterLanguageChangedHandler(_mw.UpdateTexts)
	end

	self.Frame:Show()
end


------------------------------------------------------------------------------------------------------
-- FONCTIONS LIÉES AU PANNEAU DE CONFIGURATION
------------------------------------------------------------------------------------------------------

-- Function to display different pages of the control panel || Fonction permettant l'affichage des différentes pages du panneau de configuration
function _mw:SetPanel(panelIndex)
	-- currentPanelId = PanelID
	-- local TabName
	-- for index=1, 6, 1 do
	for index=1, #self.TabTable, 1 do
		-- TabName = _G["NecrosisGeneralTab"..index]
		-- if index == PanelID then
		-- 	TabName:SetChecked(1)
		-- else
		-- 	TabName:SetChecked(nil)
		-- end
		if index == panelIndex then
			item.tab:SetChecked(1)
			item.frame:Show()
			NecrosisGeneralPageText:SetText(Necrosis.Config.Panel[index])
		else
			item.tab:SetChecked(nil)
			HideUIPanel(item.frame)
		end
	end
	-- NecrosisGeneralPageText:SetText(self.Config.Panel[PanelID])
	-- if PanelID == 1 then
	-- 	HideUIPanel(Necrosis.Gui.SphereView.Frame)
	-- 	HideUIPanel(NecrosisButtonsConfig)
	-- 	HideUIPanel(NecrosisMenusConfig)
	-- 	HideUIPanel(NecrosisTimersConfig)
	-- 	HideUIPanel(NecrosisMiscConfig)
	-- 	Necrosis.Gui.MessagesView:Show()
	-- elseif PanelID == 2 then
	-- 	HideUIPanel(Necrosis.Gui.MessagesView.Frame)
	-- 	HideUIPanel(NecrosisButtonsConfig)
	-- 	HideUIPanel(NecrosisMenusConfig)
	-- 	HideUIPanel(NecrosisTimersConfig)
	-- 	HideUIPanel(NecrosisMiscConfig)
	-- 	Necrosis.Gui.SphereView:Show()
	-- elseif PanelID == 3 then
	-- 	HideUIPanel(Necrosis.Gui.MessagesView.Frame)
	-- 	HideUIPanel(Necrosis.Gui.SphereView.Frame)
	-- 	HideUIPanel(NecrosisMenusConfig)
	-- 	HideUIPanel(NecrosisTimersConfig)
	-- 	HideUIPanel(NecrosisMiscConfig)
	-- 	self:SetButtonsConfig()
	-- elseif PanelID == 4 then
	-- 	HideUIPanel(Necrosis.Gui.MessagesView.Frame)
	-- 	HideUIPanel(Necrosis.Gui.SphereView.Frame)
	-- 	HideUIPanel(NecrosisButtonsConfig)
	-- 	HideUIPanel(NecrosisTimersConfig)
	-- 	HideUIPanel(NecrosisMiscConfig)
	-- 	self:SetMenusConfig()
	-- elseif PanelID == 5 then
	-- 	HideUIPanel(Necrosis.Gui.MessagesView.Frame)
	-- 	HideUIPanel(Necrosis.Gui.SphereView.Frame)
	-- 	HideUIPanel(NecrosisButtonsConfig)
	-- 	HideUIPanel(NecrosisMenusConfig)
	-- 	HideUIPanel(NecrosisMiscConfig)
	-- 	self:SetTimersConfig()
	-- elseif PanelID == 6 then
	-- 	HideUIPanel(Necrosis.Gui.MessagesView.Frame)
	-- 	HideUIPanel(Necrosis.Gui.SphereView.Frame)
	-- 	HideUIPanel(NecrosisButtonsConfig)
	-- 	HideUIPanel(NecrosisMenusConfig)
	-- 	HideUIPanel(NecrosisTimersConfig)
	-- 	self:SetMiscConfig()
	-- end
end
