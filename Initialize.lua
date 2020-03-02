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
-- Version $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------




-- On définit _G comme étant le tableau contenant toutes les frames existantes.
local _G = getfenv(0)

------------------------------------------------------------------------------------------------------
-- FONCTION D'INITIALISATION
------------------------------------------------------------------------------------------------------

local function ApplyLocalization()
	-- Initilialisation des Textes (VO / VF / VA / VCT / VCS / VE)
	if NecrosisConfig.Version then
		if NecrosisConfig.Language == "frFR" then
			Localization.frFR()
		elseif (NecrosisConfig.Language == "deDE") then
			Localization.deDE()
		elseif (NecrosisConfig.Language == "zhTW") then
			Localization.zhTW()
		elseif (NecrosisConfig.Language == "zhCN") then
			Localization.zhCN()
		elseif (NecrosisConfig.Language == "esES") then
			Localization.esES()
		elseif (NecrosisConfig.Language == "ruRU") then
			Localization.ruRU()
		else
			-- Default to English
			Localization.enUS()
		end
	else
		local code = GetLocale()
		if code == "frFR" then
			Localization.frFR()
		elseif code == "deDE" then
			Localization.deDE()
		elseif code == "zhTW" then
			Localization.zhTW()
		elseif code == "zhCN" then
			Localization.zhCN()
		elseif code == "esES" then
			Localization.esES()
		elseif code == "ruRU" then
			Localization.ruRU()
		else
			-- Default to English
			Localization.enUS()
		end
	end
end

function Necrosis:Initialize(Config)
	ApplyLocalization()

	-- On charge (ou on crée la configuration pour le joueur et on l'affiche sur la console
	if not NecrosisConfig.Version or type(NecrosisConfig.Version) == "string" or Necrosis.Data.LastConfig > NecrosisConfig.Version then
		NecrosisConfig = {}
		NecrosisConfig = Config
		NecrosisConfig.Version = Necrosis.Data.LastConfig
		self.Chat:_Msg(self.ChatMessage.Interface.DefaultConfig, "USER")
	else
		self.Chat:_Msg(self.ChatMessage.Interface.UserConfig, "USER")
	end

	self:CreateWarlockUI()
	self:CreateWarlockPopup()
	-----------------------------------------------------------
	-- Exécution des fonctions de démarrage
	-----------------------------------------------------------
	-- Affichage d'un message sur la console
	self.Chat:_Msg(self.ChatMessage.Interface.Welcome, "USER")

	-- Création de la liste des sorts disponibles
	self:SpellLocalize()
	self:SpellSetup()
	self:CreateMenu()
	self:ButtonSetup()

    -- Enregistrement de la commande console
	SlashCmdList["NecrosisCommand"] = Necrosis.SlashHandler
	SLASH_NecrosisCommand1 = "/necrosis"

	-- On règle la taille de la pierre et des boutons suivant les réglages du SavedVariables
	NecrosisButton:SetScale(NecrosisConfig.NecrosisButtonScale/100)
	NecrosisShadowTranceButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisBacklashButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisAntiFearButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	NecrosisCreatureAlertButton:SetScale(NecrosisConfig.ShadowTranceScale/100)
	-- On définit l'affichage des Timers Graphiques à gauche ou à droite du bouton
	if _G["NecrosisTimerFrame0"] then
		NecrosisTimerFrame0:ClearAllPoints()
		NecrosisTimerFrame0:SetPoint(
			NecrosisConfig.SpellTimerJust,
			NecrosisSpellTimerButton,
			"CENTER",
			NecrosisConfig.SpellTimerPos * 20,
			0
		)
	end
	-- On définit l'affichage des Timers Textes à gauche ou à droite du bouton
	if _G["NecrosisListSpells"] then
		NecrosisListSpells:ClearAllPoints()
		NecrosisListSpells:SetJustifyH(NecrosisConfig.SpellTimerJust)
		NecrosisListSpells:SetPoint(
			"TOP"..NecrosisConfig.SpellTimerJust,
			"NecrosisSpellTimerButton",
			"CENTER",
			NecrosisConfig.SpellTimerPos * 23,
			5
		)
	end

	--On affiche ou on cache le bouton, d'ailleurs !
	if not NecrosisConfig.ShowSpellTimers then
		NecrosisSpellTimerButton:Hide()
	end
	
	-- Le Shard est-il verrouillé sur l'interface ?
	if NecrosisConfig.NoDragAll then
		self:NoDrag()
		NecrosisButton:RegisterForDrag("")
		NecrosisSpellTimerButton:RegisterForDrag("")
	else
		self:Drag()
		NecrosisButton:RegisterForDrag("LeftButton")
		NecrosisSpellTimerButton:RegisterForDrag("LeftButton")
	end

	-- Inventaire des pierres et des fragments possedés par le Démoniste
	self:BagExplore()

	-- Si la sphere doit indiquer la vie ou la mana, on y va
	Necrosis:UpdateHealth()
	Necrosis:UpdateMana()

	-- On vérifie que les fragments sont dans le sac défini par le Démoniste
	if NecrosisConfig.SoulshardSort then
		self:SoulshardSwitch("CHECK")
	end
end


------------------------------------------------------------------------------------------------------
-- FUNCTION RUNNING CONSOLE CONTROL / FONCTION GERANT LA COMMANDE CONSOLE /NECRO
------------------------------------------------------------------------------------------------------

function Necrosis.SlashHandler(arg1)
	if arg1:lower():find("recall") then
		Necrosis:Recall()
	elseif arg1:lower():find("reset") and not InCombatLockdown() then
		NecrosisConfig = {}
		ReloadUI()
	elseif arg1:lower():find("glasofruix") then
		NecrosisConfig.Smooth = not NecrosisConfig.Smooth
		Necrosis.Chat:_Msg("SpellTimer smoothing  : <lightBlue>Toggled")
	else
		Necrosis.Gui.MainWindow:Show()
	end
end

