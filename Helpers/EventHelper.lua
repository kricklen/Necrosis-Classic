-- Class for central event management
EventHelper = {
    -- Events utilised by Necrosis || Events utilisés dans Necrosis
    ApiEvents = {
        "BAG_UPDATE",
        "PLAYER_REGEN_DISABLED",
        "PLAYER_REGEN_ENABLED",
        "PLAYER_DEAD",
        "PLAYER_ALIVE",
        "PLAYER_UNGHOST",
        "UNIT_PET",
        "UNIT_SPELLCAST_FAILED",
        "UNIT_SPELLCAST_INTERRUPTED",
        "UNIT_SPELLCAST_SUCCEEDED",
        "UNIT_SPELLCAST_SENT",
        "UNIT_MANA",
        "UNIT_HEALTH",
        "LEARNED_SPELL_IN_TAB",
        "PLAYER_TARGET_CHANGED",
        "TRADE_REQUEST",
        "TRADE_REQUEST_CANCEL",
        "TRADE_ACCEPT_UPDATE",
        "TRADE_SHOW",
        "TRADE_CLOSED",
        "COMBAT_LOG_EVENT_UNFILTERED",
        "SKILL_LINES_CHANGED"
    }
}

-- Array with references to text change functions
local _languageChangedHandlers = {}

local _eh = EventHelper

-- Localization event and handler
function _eh:RegisterLanguageChangedHandler(handler)
    table.insert(_languageChangedHandlers, handler)
end

-- Notify language change
function _eh:FireLanguageChangedEvent(code)
    NecrosisConfig.Language = code
    Necrosis:SpellLocalize("tooltip")
    for i,handler in ipairs(_languageChangedHandlers) do
        handler()
    end    
end

-- Events: PLAYER_ENTERING_WORLD and PLAYER_LEAVING_WORLD || Events : PLAYER_ENTERING_WORLD et PLAYER_LEAVING_WORLD
-- Function applied to each loading screen || Fonction appliquée à chaque écran de chargement
-- When you leave an area, you stop watching the surroundings || Quand on sort d'une zone, on arrête de surveiller les envents
-- When we enter an area, we resume surveillance || Quand on rentre dans une zone, on reprend la surveillance
-- This makes it possible to avoid a loading time that is too long for the mod || Cela permet d'éviter un temps de chargement trop long du mod
function _eh:AttachApiEvents()
    for i,e in ipairs(_eh.ApiEvents) do
        NecrosisButton:RegisterEvent(e)
    end
end

function _eh:ReleaseApiEvents()
    for i,e in ipairs(_eh.ApiEvents) do
        NecrosisButton:UnregisterEvent(e)
    end
end