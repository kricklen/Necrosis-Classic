-- The viewmodel holds functions that will be passed around as parameters
Gui.MessagesViewModel = {
    -- This is a reference to the View, used to access controls
    MessagesView = false
}

-- local _mvm = Gui.MessagesViewModel

-- -- Handler to initialize language dropdown
-- function _mvm.LanguageDropDownInit(dd)
--     UIDropDownMenu_Initialize(dd, _mvm._LanguageDropDownInit)
-- end

-- -- Add items to the dropdown
-- function _mvm._LanguageDropDownInit(dd, level, menulist)
--     for i, v in pairs(Localization.Languages) do
--         UIDropDownMenu_AddButton({
--             text = v.lang,
--             value = v.code,
--             checked = false,
--             func = _mvm._LanuageDropDownItemClick,
--             -- arg1 and arg2 can be used to pass any extra argument to the button
--             arg1 = dd,
--             arg2 = v.init
--         })

--         if v.code == NecrosisConfig.Language then
--             UIDropDownMenu_SetSelectedValue(dd, v.code)
--         end
--     end
-- end

-- -- Handler when language in dropdown is clicked
-- -- dd is arg1, initFunc is arg2
-- function _mvm._LanuageDropDownItemClick(item, dd, initFunc)
--     UIDropDownMenu_SetSelectedValue(dd, item.value)
--     initFunc()
--     EventHub:FireLanguageChangedEvent(item.value)
-- end

-- -- Handler to update texts when language changes
-- function _mvm.UpdateTexts()
--     _mvm.MessagesView.cbShowTooltip:SetText(Necrosis.Config.Messages["Afficher les bulles d'aide"])
--     _mvm.MessagesView.cbChatType:SetText(Necrosis.Config.Messages["Afficher les messages dans la zone systeme"])
--     _mvm.MessagesView.cbSpeech:SetText(Necrosis.Config.Messages["Activer les messages aleatoires de TP et de Rez"])
--     _mvm.MessagesView.cbShortMessages:SetText(Necrosis.Config.Messages["Utiliser des messages courts"])
--     _mvm.MessagesView.cbDemonMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Demons"])
--     _mvm.MessagesView.cbMountMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Montures"])
--     _mvm.MessagesView.cbRoSMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour le Rituel des ames"])
--     _mvm.MessagesView.cbSound:SetText(Necrosis.Config.Messages["Activer les sons"])
--     _mvm.MessagesView.cbAntiFearAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible est insensible a la peur"])
--     _mvm.MessagesView.cbBanishAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible peut etre banie ou asservie"])
--     _mvm.MessagesView.cbTranceAlert:SetText(Necrosis.Config.Messages["M'alerter quand j'entre en Transe"])
-- end
