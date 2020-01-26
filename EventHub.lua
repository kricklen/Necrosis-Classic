-- Class for central event management
EventHub = {}

-- Array with references to text change functions
local _languageChangedHandlers = {}

local _eh = EventHub

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
