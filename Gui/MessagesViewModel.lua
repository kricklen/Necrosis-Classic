
Gui.MessagesViewModel = {

    -- Handler to initialize language dropdown
    LanguageDropDownInit =
        function(dd)
            UIDropDownMenu_Initialize(dd, _LanguageDropDownInit)
        end,

    -- Add items to the dropdown
    _LanguageDropDownInit =
        function(dd, level, menulist)
            for i, v in pairs(Localization.Languages) do
                UIDropDownMenu_AddButton({
                    text = v.lang,
                    value = v.code,
                    checked = false,
                    func = _LanuageDropDownItemClick,
                    -- arg1 and arg2 can be used to pass any extra argument to the button
                    arg1 = dd,
                    arg2 = v.init
                })
        
                if v.code == NecrosisConfig.Language then
                    UIDropDownMenu_SetSelectedValue(dd, v.code)
                end
            end
        end,

    -- Handler when language in dropdown is clicked
    -- dd is arg1, initFunc is arg2
    _LanuageDropDownItemClick =
        function(item, dd, initFunc)
            UIDropDownMenu_SetSelectedValue(dd, item.value)
            initFunc()
            EventHub:FireLanguageChangedEvent(item.value)
        end,

    -- Handler to update texts when language changes
    UpdateTexts =
        function()
			self.cbShowTooltip:SetText(Necrosis.Config.Messages["Afficher les bulles d'aide"])
			self.cbChatType:SetText(Necrosis.Config.Messages["Afficher les messages dans la zone systeme"])
			self.cbSpeech:SetText(Necrosis.Config.Messages["Activer les messages aleatoires de TP et de Rez"])
			self.cbShortMessages:SetText(Necrosis.Config.Messages["Utiliser des messages courts"])
			self.cbDemonMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Demons"])
			self.cbMountMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour les Montures"])
			self.cbRoSMessages:SetText(Necrosis.Config.Messages["Activer egalement les messages pour le Rituel des ames"])
			self.cbSound:SetText(Necrosis.Config.Messages["Activer les sons"])
			self.cbAntiFearAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible est insensible a la peur"])
			self.cbBanishAlert:SetText(Necrosis.Config.Messages["Alerter quand la cible peut etre banie ou asservie"])
			self.cbTranceAlert:SetText(Necrosis.Config.Messages["M'alerter quand j'entre en Transe"])
		end
}
