-- Helper for textures etc

GraphicsHelper = {}
GraphicsHelper.__index = GraphicsHelper

local _gh = GraphicsHelper

function _gh:GetTexture(name)
    return "Interface\\Addons\\Necrosis-Classic\\UI\\"..name
end

function _gh:GetWoWTexture(category, name)
    return "Interface\\"..category.."\\"..name
end

function _gh:CreateTexture(parentFrame, type, height, width, texturePath, anchor, x, y)
	local tx = parentFrame:CreateTexture(nil, type)
	tx:SetSize(width, height)
	tx:SetTexture(texturePath)
	tx:Show()
	tx:ClearAllPoints()
	tx:SetPoint(anchor, x, y)
	return tx
end

-- Create a dialog frame for the options panels
function _gh:CreateDialog(parentFrame, height)
	local dia = CreateFrame("Frame", nil, parentFrame)
	dia:SetFrameStrata("DIALOG")
	dia:SetMovable(false)
	dia:EnableMouse(true)
	dia:SetSize(340, 324)
	dia:Show()
	dia:ClearAllPoints()
	dia:SetPoint("TOPLEFT", 34, -90)
	return dia
end

function _gh:CreateDialogPage(parentFrame)
	local dia = CreateFrame("Frame", nil, parentFrame)
	dia:SetFrameStrata("DIALOG")
	dia:SetMovable(false)
	dia:EnableMouse(true)
	dia:SetSize(340, 284)
	dia:Show()
	dia:ClearAllPoints()
	dia:SetPoint("TOPLEFT", 0, 0)
	return dia
end

-- Create a FontString (label), f.e. for a CheckButton
function _gh:CreateFontString(parentFrame, text, position, x, y)
	local fs = parentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
	fs:Show()
	fs:ClearAllPoints()
	fs:SetPoint(position, x, y)
	fs:SetTextColor(1, 1, 1)
	fs:SetText(text)
	return fs
end

-- Create a UIDropDownMenu with a FontString.
-- The FontString element has the name: "lbl" + name.
function _gh:CreateDropDown(parentFrame, text, x, y, initFunction)
	local dd = CreateFrame("Frame", nil, parentFrame, "UIDropDownMenuTemplate")
	dd:Show()
	dd:ClearAllPoints()
	dd:SetPoint("TOPRIGHT", x + 6, y)
	UIDropDownMenu_SetWidth(dd, 125)
	UIDropDownMenu_Initialize(dd, initFunction)
	-- Set the text in line with the dropdown to the left side
	local fs = self:CreateFontString(parentFrame, text, "TOPLEFT", 0, y - 7)
    return dd, fs
end

-- Create a UICheckButton with a FontString.
-- The FontString element has the name: "lbl" + name.
function _gh:CreateCheckButton(parentFrame, text, x, y, onClickFunction)
	local cb = CreateFrame("CheckButton", nil, parentFrame, "UICheckButtonTemplate")
	cb:EnableMouse(true)
	cb:SetSize(24, 24)
	cb:Show()
	cb:ClearAllPoints()
	cb:SetPoint("TOPLEFT", x, y)
	cb:SetScript("OnClick", onClickFunction)
    cb:SetFontString(self:CreateFontString(cb, text, "LEFT", 30, 0))
    return cb
end

-- Create an OptionsSlider
function _gh:CreateSlider(parentFrame, name, min, max, step, height, width, x, y)
	local sl = CreateFrame("Slider", name, parentFrame, "OptionsSliderTemplate")
	sl:SetMinMaxValues(min, max)
	sl:SetValueStep(step)
	sl:SetSize(parentFrame:GetWidth() - 20, height)
	sl:Show()
	sl:ClearAllPoints()
	sl:SetPoint("TOPLEFT", x + 6, y)
    return sl
end

function _gh:CreateButton(parentFrame, text, x, y, onClickFunction)
	local btn = CreateFrame("Button", nil, parentFrame, "OptionsButtonTemplate")
	btn:SetText(text)
	btn:EnableMouse(true)
	btn:Show()
	btn:ClearAllPoints()
	btn:SetSize(24, 24)
	btn:SetPoint("TOPRIGHT", x, y)
	btn:SetScript("OnClick", onClickFunction)
	return btn
end

function _gh:CreateButtonPrev(parentFrame, onClickFunction)
	local btn = CreateFrame("Button", nil, parentFrame, "OptionsButtonTemplate")
	btn:EnableMouse(true)
	btn:Show()
	btn:ClearAllPoints()
	btn:SetPoint("BOTTOMLEFT", -1, 8)
	btn:SetScript("OnClick", onClickFunction)
	btn:SetSize(32, 32)
	btn:SetHitRectInsets(-2, -2, -2, -2);
	btn:SetNormalTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-PrevPage-Up"))
	btn:SetPushedTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-PrevPage-Down"))
	btn:SetDisabledTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-PrevPage-Disabled"))
	return btn
end

function _gh:CreateButtonNext(parentFrame, onClickFunction)
	local btn = CreateFrame("Button", nil, parentFrame, "OptionsButtonTemplate")
	btn:EnableMouse(true)
	btn:Show()
	btn:ClearAllPoints()
	btn:SetPoint("BOTTOMRIGHT", -8, 8)
	btn:SetScript("OnClick", onClickFunction)
	btn:SetSize(32, 32)
	btn:SetHitRectInsets(-2, -2, -2, -2);
	btn:SetNormalTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-NextPage-Up"))
	btn:SetPushedTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-NextPage-Down"))
	btn:SetDisabledTexture(_gh:GetWoWTexture("Buttons", "UI-SpellbookIcon-NextPage-Disabled"))
	return btn
end
