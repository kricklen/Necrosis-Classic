-- Handler when language in dropdown is clicked
local _LanuageDropDownItemClick =
        function(item, arg1, arg2)
            UIDropDownMenu_SetSelectedValue(arg1, item.value)
            arg2()
            EventHub:FireLanguageChangedEvent(item.value)
        end

-- Add items to the dropdown
local _LanguageDropDownInit =
        function(dd, level, menulist)
            for i, v in pairs(Localization.Languages) do
                UIDropDownMenu_AddButton({
                    text = v.lang,
                    value = v.code,
                    checked = false,
                    func = _LanuageDropDownItemClick,
                    -- arg1 and arg2 can be used to pass any argument to the button
                    arg1 = dd,
                    arg2 = v.init
                })
        
                if v.code == NecrosisConfig.Language then
                    UIDropDownMenu_SetSelectedValue(dd, v.code)
                end
            end
        end

Gui.ViewModels.MessagesVm = {
    -- Handler to initialize language dropdown
    LanguageDropDownInit =
        function(dd)
            UIDropDownMenu_Initialize(dd, _LanguageDropDownInit)
        end
}
