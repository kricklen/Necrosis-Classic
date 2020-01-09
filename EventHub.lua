-- Class for central event management
EventHub = {}

-- Array with references to text change functions
local _languageChangedHandlers = {}

-- Localization event and handler
function EventHub:RegisterLanguageChangedHandler(handler)
    table.insert(_languageChangedHandlers, handler)
end

-- Notify language change
function EventHub:FireLanguageChangedEvent(code)
    NecrosisConfig.Language = code
    Necrosis:SpellLocalize("tooltip")
    for i,handler in ipairs(_languageChangedHandlers) do
        handler()
    end    
end
