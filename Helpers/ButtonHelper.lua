ButtonHelper = {
    States = {
        Bloque = "Bloque",
        Ferme = "Ferme",
        Ouvert = "Ouvert",
        ClicDroit = "ClicDroit",
        Combat = "Combat",
        Refresh = "Refresh"
    }
}

local _bh = ButtonHelper

function _bh:SoulstoneUpdateAttribute(nostone)
	-- Si le démoniste est en combat, on ne fait rien :)
	-- if InCombatLockdown() then
	-- 	return
	-- end

	if Necrosis.Debug.buttons then
		_G["DEFAULT_CHAT_FRAME"]:AddMessage("SoulstoneUpdateAttribute"
		.." a'"..(tostring(nostone) or "nyl")..'"'
		.." s'"..(tostring(BagHelper.Soulstone_Name))..'"'
		.." f'"..(tostring(Necrosis.Warlock_Buttons.soul_stone.f))..'"'
		.." '"..(str)..'"'
		)
	end

    local f = Necrosis.Warlock_Buttons.soul_stone.f
	f = _G[f]
	if not f then
		return
	end
	if Necrosis.IsSpellKnown("soulstone") then
		local str = ""
		-- R click to create; will cause an error if one is in bags
--		f:SetAttribute("type2", "macro")
--		str = "/cast Create "..L["SOUL_STONE"] -- 
		f:SetAttribute("type2", "spell") -- 51
		str = Necrosis.GetSpellCastName("soulstone")
		f:SetAttribute("spell2", str)
		-- Use all possible Soulstones. Modifying the button use during combat is forbidden.
		f:SetAttribute("type1", "macro")
		f:SetAttribute("type3", "macro")
		local useSoulstoneMacro = ""
		for i,id in ipairs(ItemHelper.Soulstone.ItemIds) do
			useSoulstoneMacro = "/use item:"..tostring(id).."\n"..useSoulstoneMacro
		end
		f:SetAttribute("macrotext", useSoulstoneMacro)
		
		-- if the 'Ritual of Summoning' spell is known, then associate it to the soulstone icon as shift-click.
		if Necrosis.IsSpellKnown("summoning") then
			f:SetAttribute("shift-type*", "spell")
			f:SetAttribute("shift-spell*", 
			Necrosis.GetSpellCastName("summoning")) 
		end
	end
end

function _bh:FirestoneUpdateAttribute(nostone)
	local f = Necrosis.Warlock_Buttons.fire_stone.f
	f = _G[f]

	-- Si le démoniste est en combat, on ne fait rien :)
	-- if InCombatLockdown() or not f then
	if not f then
		return
	end

	if Necrosis.Debug.buttons then
		_G["DEFAULT_CHAT_FRAME"]:AddMessage("FirestoneUpdateAttribute"
		.." a'"..(tostring(nostone) or "nyl")..'"'
		.." s'"..(BagHelper.Firestone_Name or "nyl")..'"'
		)
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		f:SetAttribute("type1", "spell") -- 54
		f:SetAttribute("spell*", Necrosis.GetSpellCastName("firestone")) 
    else
        f:SetAttribute("type1", "item")
        f:SetAttribute("item1", BagHelper.Firestone_Name)
    --	f:SetAttribute("type1", "macro")
    --	f:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[2].."\n/use 16")
	end
end

function _bh:SpellstoneUpdateAttribute(nostone)
	local f = Necrosis.Warlock_Buttons.spell_stone.f
	f = _G[f]

	-- Si le démoniste est en combat, on ne fait rien :)
	-- if InCombatLockdown() or not f then
	if not f then
		return
	end

	if Necrosis.Debug.buttons then
		_G["DEFAULT_CHAT_FRAME"]:AddMessage("SpellstoneUpdateAttribute"
		.." a'"..(tostring(nostone) or "nyl")..'"'
		.." s'"..(BagHelper.Spellstone_Name or "nyl")..'"'
		)
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		f:SetAttribute("type1", "spell") -- 53
		f:SetAttribute("spell*", Necrosis.GetSpellCastName("spellstone")) 
    else
        f:SetAttribute("type1", "item")
        f:SetAttribute("item1", BagHelper.Spellstone_Name)
        --	f:SetAttribute("type1", "macro")
        --	f:SetAttribute("macrotext*", "/cast "..NecrosisConfig.ItemSwitchCombat[1].."\n/use 16")
	end
end

function _bh:HealthstoneUpdateAttribute(nostone)
	local f = Necrosis.Warlock_Buttons.health_stone.f
	f = _G[f]
	-- Si le démoniste est en combat, on ne fait rien :)
	-- if InCombatLockdown() or not f then
	if not f then
		return
	end

	if Necrosis.Debug.buttons then
		_G["DEFAULT_CHAT_FRAME"]:AddMessage("HealthstoneUpdateAttribute"
		.." a'"..(tostring(nostone) or "nyl")..'"'
		.." s'"..(BagHelper.Healthstone_Name or "nyl")..'"'
		)
	end

	-- Si le démoniste n'a pas de pierre dans son inventaire,
	-- Un clic gauche crée la pierre
	if nostone then
		f:SetAttribute("type1", "spell") -- 52
		f:SetAttribute("spell1", Necrosis.GetSpellCastName("healthstone")) 
    else
		-- Use all available healthstones
		local useHealthstoneMacro = ""
		for i,id in ipairs(ItemHelper.Healthstone.ItemIds) do
			useHealthstoneMacro = "/use item:"..tostring(id).."\n"..useHealthstoneMacro
		end
		f:SetAttribute("type1", "macro")
		f:SetAttribute("macrotext1", "/stopcasting\n"..useHealthstoneMacro)

		f:SetAttribute("type3", "Trade")
        f:SetAttribute("ctrl-type1", "Trade")
        f.Trade = function () Necrosis:TradeStone() end
	end
end
