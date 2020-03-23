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
        "SKILL_LINES_CHANGED",
        "COMBAT_LOG_EVENT_UNFILTERED",
        "CHAT_MSG_ADDON",
        "GROUP_ROSTER_UPDATE",
        -- "RAID_TARGET_UPDATE",
        -- "UNIT_FLAGS",
        -- GROUP_ROSTER_CHANGED
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

function _eh:SendAddonMessage(message)
    local channel = "say"
    if (Necrosis.CurrentEnv.InRaid) then
        channel = "RAID"
    elseif (Necrosis.CurrentEnv.InParty) then
        channel = "PARTY"
    end
    local success = C_ChatInfo.SendAddonMessage(Necrosis.CurrentEnv.ChatPrefix, message, channel)
    print("_eh:SendAddonMessage: "..tostring(success))
end

-- Process messages from other warlocks in the raid or party
function _eh:ProcessAddonMessage(text)
    local split_cmd = split(text, "~")
    print("command: "..tostring(split_cmd[1])..", "..tostring(split_cmd[2]))
    if (split_cmd[1] == "InsertTimer") then
        local split_timer = split(split_cmd[2], "|")
        Necrosis.Timers:InsertSpellTimer(
            split_timer[1],
            split_timer[2],
            split_timer[3],
            split_timer[4],
            split_timer[5],
            split_timer[6],
            split_timer[7],
            split_timer[8],
            split_timer[9],
            split_timer[10]
        )
    end
end