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
-- $LastChangedDate: 2009-08-17 15:50:02 +1000 (Mon, 17 Aug 2009) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

Necrosis.Gui.MiscView = {
	Frame = false,
	cbMoveShards = false,
	-- cbDestroyShardsOnFullBag = false,
	ddShardBag = false,
	lblShardBag = false,
	
	cbDestroyShards = false,
	slDestroyShardCount = false,
	slDestroyShardCountLow = false,
	slDestroyShardCountHigh = false,
	
	cbLockButtons = false,
	
	cbShowHiddenButtons = false,
	slHiddenButtonSize = false,
	slHiddenButtonSizeText = false,
	slHiddenButtonSizeLow = false,
	slHiddenButtonSizeHigh = false
}

local _mv = Necrosis.Gui.MiscView

------------------------------------------------------------------------------------------------------
-- CREATION DE LA FRAME DES OPTIONS
------------------------------------------------------------------------------------------------------

function _mv.ddShardBag_Init(dd)
	for i,data in ipairs(BagHelper:GetPlayerBags()) do
		UIDropDownMenu_AddButton({
			text = data.name,
			value = data.id,
			checked = false,
			func = _mv.ddShardBag_Click,
			arg1 = dd
		})
	end
	UIDropDownMenu_SetSelectedValue(dd, NecrosisConfig.SoulshardContainer)
end
	
function _mv.ddShardBag_Click(item, dd)
	UIDropDownMenu_SetSelectedValue(dd, item.value)
	NecrosisConfig.SoulshardContainer = item.value
end

function _mv:Show()
	-- local frame = _G["NecrosisMiscConfig"]
	if not self.Frame then
		-- Création de la fenêtre
		self.Frame = GraphicsHelper:CreateDialog(NecrosisGeneralFrame)

		-- Déplacement des fragments
		self.cbMoveShards = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Misc["Deplace les fragments"],
			0, -18,
			function(self)
				NecrosisConfig.SoulshardSort = self:GetChecked()
				-- if NecrosisConfig.SoulshardSort then
				-- 	_mv.cbDestroyShardsOnFullBag:Enable()
				-- 	-- UIDropDownMenu_EnableDropDown(_mv.ddShardBag)
				-- else
				-- 	_mv.cbDestroyShardsOnFullBag:Disable()
				-- 	-- UIDropDownMenu_DisableDropDown(_mv.ddShardBag)
				-- end
			end
		)
		self.cbMoveShards:SetChecked(NecrosisConfig.SoulshardSort)

-- 		-- Destruction des fragments quand le sac est plein
-- 		self.cbDestroyShardsOnFullBag = GraphicsHelper:CreateCheckButton(
-- 			self.Frame,
-- 			Necrosis.Config.Misc["Detruit les fragments si le sac plein"],
-- 			20, -40,
-- 			function(self)
-- 				NecrosisConfig.SoulshardDestroy = self:GetChecked()
-- print("SoulshardDestroy: "..tostring(NecrosisConfig.SoulshardDestroy))
-- 			end
-- 		)
-- 		self.cbDestroyShardsOnFullBag:SetChecked(NecrosisConfig.SoulshardDestroy)

		-- Choose the bag for storing soul shards || Choix du sac à fragments
		self.ddShardBag, self.lblShardBag = GraphicsHelper:CreateDropDown(
			self.Frame,
			Necrosis.Config.Misc["Choix du sac contenant les fragments"],
			0, -64,
			self.ddShardBag_Init
		)

		-- Limit max shards
		self.cbDestroyShards = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Misc["Nombre maximum de fragments a conserver"],
			0, -110,
			function(self)
				NecrosisConfig.DestroyShard = self:GetChecked()
				Necrosis:BagExplore()
				if self:GetChecked() then
					_mv.slDestroyShardCount:Enable()
				else
					_mv.slDestroyShardCount:Disable()
				end
			end			
		)
		self.cbDestroyShards:SetChecked(NecrosisConfig.DestroyShard)

		-- How many shards to keep max.
		self.slDestroyShardCount = GraphicsHelper:CreateSlider(
			self.Frame, "slDestroyShardCount",
			1, 32, 1,
			15, 150,
			0, -134
		)

		self.slDestroyShardCountLow = slDestroyShardCountLow
		self.slDestroyShardCountHigh = slDestroyShardCountHigh

		self.slDestroyShardCountLow:SetText("1")
		self.slDestroyShardCountHigh:SetText("32")

		self.slDestroyShardCount:SetScript("OnEnter",
			function(self)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue())
			end
		)
		self.slDestroyShardCount:SetScript("OnLeave", function() GameTooltip:Hide() end)
		self.slDestroyShardCount:SetScript("OnValueChanged",
			function(self)
				GameTooltip:SetText(math.floor(self:GetValue()))
			end
		)
		self.slDestroyShardCount:SetScript("OnMouseUp",
			function(self)
				GameTooltip:SetText(self:GetValue())
				NecrosisConfig.DestroyCount = math.floor(self:GetValue())
				NecrosisConfig.DestroyShard = true
			end
		)

		if NecrosisConfig.DestroyShard then
			self.slDestroyShardCount:Enable()
		else
			self.slDestroyShardCount:Disable()
		end

		if NecrosisConfig.DestroyCount then
			self.slDestroyShardCount:SetValue(NecrosisConfig.DestroyCount)
		else
			self.slDestroyShardCount:SetValue(32)
		end

		-- Verrouillage de Necrosis
		self.cbLockButtons = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Misc["Verrouiller Necrosis sur l'interface"],
			0, -180,
			function(self)
				if (self:GetChecked()) then
					Necrosis:NoDrag()
					NecrosisButton:RegisterForDrag("")
					NecrosisSpellTimerButton:RegisterForDrag("")
					NecrosisConfig.NoDragAll = true
				else
					if not NecrosisConfig.NecrosisLockServ then
						Necrosis:Drag()
					end
					NecrosisButton:RegisterForDrag("LeftButton")
					NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
					NecrosisConfig.NoDragAll = false
				end
			end
		)
		self.cbLockButtons:SetChecked(NecrosisConfig.NoDragAll)

		-- Affichage des boutons cachés
		self.cbShowHiddenButtons = GraphicsHelper:CreateCheckButton(
			self.Frame,
			Necrosis.Config.Misc["Afficher les boutons caches"],
			0, -220,
			function(self)
				if (self:GetChecked()) then
					_mv.slHiddenButtonSize:Enable()
					ShowUIPanel(NecrosisShadowTranceButton)
					ShowUIPanel(NecrosisBacklashButton)
					ShowUIPanel(NecrosisAntiFearButton)
					ShowUIPanel(NecrosisCreatureAlertButton)
					NecrosisShadowTranceButton:RegisterForDrag("LeftButton")
					NecrosisBacklashButton:RegisterForDrag("LeftButton")
					NecrosisAntiFearButton:RegisterForDrag("LeftButton")
					NecrosisCreatureAlertButton:RegisterForDrag("LeftButton")
				else
					_mv.slHiddenButtonSize:Disable()
					HideUIPanel(NecrosisShadowTranceButton)
					HideUIPanel(NecrosisBacklashButton)
					HideUIPanel(NecrosisAntiFearButton)
					HideUIPanel(NecrosisCreatureAlertButton)
					NecrosisShadowTranceButton:RegisterForDrag("")
					NecrosisBacklashButton:RegisterForDrag("")
					NecrosisAntiFearButton:RegisterForDrag("")
					NecrosisCreatureAlertButton:RegisterForDrag("")
				end
			end
		)

		-- Tailles boutons cachés
		self.slHiddenButtonSize = GraphicsHelper:CreateSlider(
			self.Frame, "slHiddenButtonSize",
			50, 200, 5,
			15, 150,
			0, -252
		)

		self.slHiddenButtonSize:SetValue(NecrosisConfig.ShadowTranceScale)
		self.slHiddenButtonSize:Disable()

		self.slHiddenButtonSizeText = slHiddenButtonSizeText
		self.slHiddenButtonSizeLow  = slHiddenButtonSizeLow
		self.slHiddenButtonSizeHigh = slHiddenButtonSizeHigh

		self.slHiddenButtonSizeText:SetText(Necrosis.Config.Misc["Taille des boutons caches"])
		self.slHiddenButtonSizeLow:SetText("50 %")
		self.slHiddenButtonSizeHigh:SetText("200 %")

		local STx, STy, BLx, BLy, AFx, AFy, CAx, CAy
		self.slHiddenButtonSize:SetScript("OnEnter",
			function(self)
				STx, STy = NecrosisShadowTranceButton:GetCenter()
				STx = STx * (NecrosisConfig.ShadowTranceScale / 100)
				STy = STy * (NecrosisConfig.ShadowTranceScale / 100)

				BLx, BLy = NecrosisBacklashButton:GetCenter()
				BLx = BLx * (NecrosisConfig.ShadowTranceScale / 100)
				BLy = BLy * (NecrosisConfig.ShadowTranceScale / 100)

				AFx, AFy = NecrosisAntiFearButton:GetCenter()
				AFx = AFx * (NecrosisConfig.ShadowTranceScale / 100)
				AFy = AFy * (NecrosisConfig.ShadowTranceScale / 100)

				CAx, CAy = NecrosisCreatureAlertButton:GetCenter()
				CAx = CAx * (NecrosisConfig.ShadowTranceScale / 100)
				CAy = CAy * (NecrosisConfig.ShadowTranceScale / 100)

				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(self:GetValue().."%")
				GameTooltip:Show()
			end
		)
		self.slHiddenButtonSize:SetScript("OnLeave",
			function()
				GameTooltip:Hide()
			end
		)
		self.slHiddenButtonSize:SetScript("OnValueChanged",
			function(self)
				if not (self:GetValue() == NecrosisConfig.ShadowTranceScale) then
					GameTooltip:SetText(self:GetValue().."%")
					NecrosisConfig.ShadowTranceScale = self:GetValue()

					NecrosisShadowTranceButton:ClearAllPoints()
					NecrosisShadowTranceButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", STx / (NecrosisConfig.ShadowTranceScale / 100), STy / (NecrosisConfig.ShadowTranceScale / 100))
					NecrosisShadowTranceButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

					NecrosisBacklashButton:ClearAllPoints()
					NecrosisBacklashButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", BLx / (NecrosisConfig.ShadowTranceScale / 100), BLy / (NecrosisConfig.ShadowTranceScale / 100))
					NecrosisBacklashButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

					NecrosisCreatureAlertButton:ClearAllPoints()
					NecrosisCreatureAlertButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", CAx / (NecrosisConfig.ShadowTranceScale / 100), CAy / (NecrosisConfig.ShadowTranceScale / 100))
					NecrosisCreatureAlertButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)

					NecrosisAntiFearButton:ClearAllPoints()
					NecrosisAntiFearButton:SetPoint("CENTER", "UIParent", "BOTTOMLEFT", AFx / (NecrosisConfig.ShadowTranceScale / 100), AFy / (NecrosisConfig.ShadowTranceScale / 100))
					NecrosisAntiFearButton:SetScale(NecrosisConfig.ShadowTranceScale / 100)
				end
			end
		)

		-- if NecrosisConfig.SoulshardSort then
		-- 	-- UIDropDownMenu_EnableDropDown(_mv.ddShardBag)
		-- 	self.cbDestroyShardsOnFullBag:Enable()
		-- else
		-- 	-- UIDropDownMenu_DisableDropDown(_mv.ddShardBag)
		-- 	self.cbDestroyShardsOnFullBag:Disable()
		-- end
	end

	self.Frame:Show()
end

function _mv:Hide()
	if self.Frame then
		HideUIPanel(self.Frame)
	end
end