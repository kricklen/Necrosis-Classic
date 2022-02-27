SphereMenu = {}

local _sm = SphereMenu

-- Function (XML) to restore the default attachment points of the buttons || Fonction (XML) pour rétablir les points d'attache par défaut des boutons
function _sm:ClearAllPoints()
    for index, item in ipairs(Necrosis.Warlock_Lists.on_sphere) do
        local warlockButton = Necrosis.Warlock_Buttons[item.f_ptr]
        local frame = _G[warlockButton.f]
        if (frame) then
            frame:ClearAllPoints()
        end
    end
end

-- Disable drag functionality || Fonction (XML) pour étendre la propriété NoDrag() du bouton principal de Necrosis sur tout ses boutons
function _sm:NoDrag()
    for index, item in ipairs(Necrosis.Warlock_Lists.on_sphere) do
        local warlockButton = Necrosis.Warlock_Buttons[item.f_ptr]
        local frame = _G[warlockButton.f]
        if (frame) then
            frame:RegisterForDrag("")
        end
    end
end

-- Enable drag functionality || Fonction (XML) inverse de celle du dessus
function _sm:Drag()
    for index, item in ipairs(Necrosis.Warlock_Lists.on_sphere) do
        local warlockButton = Necrosis.Warlock_Buttons[item.f_ptr]
        local frame = _G[warlockButton.f]
        if (frame) then
            frame:RegisterForDrag("LeftButton")
        end
    end
end

local function HideList(list)
	for i, v in pairs(list) do
		local menuVariable = _G[Necrosis.Warlock_Buttons[v.f_ptr].f]
		if menuVariable then
			menuVariable:Hide()
		end
	end
end

local function WireUpMenuChildrenStates(menuButton, childButtonList)
	-- Secure the menu || Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
	for i = 1, #childButtonList, 1 do
		local childButton = childButtonList[i]
		childButton:SetParent(menuButton)
		-- Close the menu when a child button is clicked || Si le menu se ferme à l'appui d'un bouton, alors il se ferme à l'appui d'un bouton !
		menuButton:WrapScript(childButton, "OnClick", [[
			if self:GetParent():GetAttribute("state") == "Ouvert" then
				self:GetParent():SetAttribute("state", "Ferme")
			end
		]])
		menuButton:WrapScript(childButton, "OnEnter", [[
			self:GetParent():SetAttribute("mousehere", true)
		]])
		menuButton:WrapScript(childButton, "OnLeave", [[
			self:GetParent():SetAttribute("mousehere", false)
			local stateMenu = self:GetParent():GetAttribute("state")
			if not (stateMenu == "Bloque" or stateMenu == "Combat" or stateMenu == "ClicDroit") then
				self:GetParent():SetAttribute("state", "Refresh")
			end
		]])
	end
end

-- Setup the buttons available on the menu 
local function PopulateMenuTable(menuTable, warlockButton, warlockList, menuPos, menuOffset)
    local buttonName = warlockButton.f -- menu button on sphere
    -- Create menu button on demand, needed to anchor child buttons to it
    local menuButtonFrame = _G[buttonName]
    if not menuButtonFrame then
        menuButtonFrame = SphereButtonHelper:CreateMenuButton(warlockButton)
    end

    local anchor = "CENTER"
    if (menuPos.y == 1) then
    	anchor = "TOP"
    elseif (menuPos.y == -1) then
    	anchor = "BOTTOM"
    elseif (menuPos.x == 1) then
    	anchor = "RIGHT"
    end

    local x = menuPos.direction * menuPos.x * 32
    local y = menuPos.y * 32

    for index = 1, #warlockList, 1 do
        local listItem = warlockList[index]
        local menuButton = Necrosis.Warlock_Buttons[listItem.f_ptr]
        if Necrosis.IsSpellKnown(listItem.high_of) then -- in spell book
            if Necrosis.Debug.buttons then
                _G["DEFAULT_CHAT_FRAME"]:AddMessage("CreateMenu pets"
                .." f'"..(listItem.f_ptr or "nyl")..'"'
                .." pr'"..(buttonName or "nyl")..'"'
                )
            end
            menuVariable = Necrosis:CreateMenuItem(menuButton, listItem.high_of)
            menuVariable:ClearAllPoints()
            menuVariable:SetPoint(anchor, buttonName, anchor, x, y)
            buttonName = menuButton.f -- anchor the next button
            menuTable:insert(menuVariable)
        end
    end

    -- Display the menu button with configured offset || Maintenant que tous les boutons de pet sont placés les uns à côté des autres, on affiche les disponibles
    if menuTable[1] then
        menuTable[1]:ClearAllPoints()
        menuTable[1]:SetPoint("CENTER", menuButtonFrame, "CENTER",x + menuOffset.x,y + menuOffset.y)
        -- Secure the menu || Maintenant on sécurise le menu, et on y associe nos nouveaux boutons
        WireUpMenuChildrenStates(menuButtonFrame, menuTable)
        Necrosis:MenuAttribute(menuButtonFrame)
    end
end

-- Rebuild the menus at mod startup or when the spellbook changes || A chaque changement du livre des sorts, au démarrage du mod, ainsi qu'au changement de sens du menu on reconstruit les menus des sorts
function _sm:CreateMenu(Local)
	local menuVariable = nil

	HideList(Necrosis.Warlock_Lists.pets) -- Hide all the pet demon buttons || On cache toutes les icones des démons
	HideList(Necrosis.Warlock_Lists.buffs) -- Hide the general buff spell buttons || On cache toutes les icones des sorts
	HideList(Necrosis.Warlock_Lists.curses) -- Hide the curse buttons || On cache toutes les icones des curses

	if NecrosisConfig.StonePosition[7] > 0 then -- pets
        PopulateMenuTable(
            Local.Menu.Pet,
            Necrosis.Warlock_Buttons.pets,
            Necrosis.Warlock_Lists.pets,
            NecrosisConfig.PetMenuPos,
            NecrosisConfig.PetMenuDecalage
        )
        if (Local.Menu.Pet[1]) then
            Necrosis:PetSpellAttribute(Local.Menu.Pet)
        end
	end

	if NecrosisConfig.StonePosition[5] > 0 then -- buffs
        PopulateMenuTable(
            Local.Menu.Buff,
            Necrosis.Warlock_Buttons.buffs,
            Necrosis.Warlock_Lists.buffs,
            NecrosisConfig.BuffMenuPos,
            NecrosisConfig.BuffMenuDecalage
        )
        if (Local.Menu.Buff[1]) then
			Necrosis:BuffSpellAttribute(Local.Menu.Buff)
        end
	end

	if NecrosisConfig.StonePosition[8] > 0 then -- curses
        PopulateMenuTable(
            Local.Menu.Curse,
            Necrosis.Warlock_Buttons.curses,
            Necrosis.Warlock_Lists.curses,
            NecrosisConfig.CurseMenuPos,
            NecrosisConfig.CurseMenuDecalage
        )
        if (Local.Menu.Curse[1]) then
			Necrosis:CurseSpellAttribute(Local.Menu.Curse)
        end
	end

    -- This function doesn't exist anymore?
	-- -- Always keep menus Open (if enabled) || On bloque le menu en position ouverte si configuré
	-- if NecrosisConfig.BlockedMenu then
	-- 	local s = "Bloque"
	-- 	SetState(_G[Necrosis.Warlock_Buttons.buffs.f], s)
	-- 	SetState(_G[Necrosis.Warlock_Buttons.pets.f], s)
	-- 	SetState(_G[Necrosis.Warlock_Buttons.curses.f], s)
	-- end
end
