-- Helper for textures etc

GraphicsHelper = {}
GraphicsHelper.__index = GraphicsHelper

function GraphicsHelper:GetTexture(name)
    return "Interface\\Addons\\Necrosis-Classic\\UI\\"..name
end

function GraphicsHelper:GetWoWTexture(category, name)
    return "Interface\\"..category.."\\"..name
end

function GraphicsHelper:CreateTexture(parentFrame, type, height, width, texturePath, anchor, x, y)
	local tx = parentFrame:CreateTexture(nil, type)
	tx:SetWidth(width)
	tx:SetHeight(height)
	tx:SetTexture(texturePath)
	tx:Show()
	tx:ClearAllPoints()
	tx:SetPoint(anchor, x, y)
	return tx
end

-- Create a dialog frame for the options panels
function GraphicsHelper:CreateDialog(parentFrame, height)
	local dia = CreateFrame("Frame", nil, parentFrame)
	dia:SetFrameStrata("DIALOG")
	dia:SetMovable(false)
	dia:EnableMouse(true)
	if height then
		dia:SetHeight(height)
	else
		dia:SetHeight(324)
	end
	dia:SetWidth(340)
	dia:Show()
	dia:ClearAllPoints()
	dia:SetPoint("CENTER", 0, 8)
	return dia
end

-- Create a FontString (label) for a CheckButton or DropDown
function GraphicsHelper:CreateFontString(parentFrame, name, text, position, x, y)
	local fs = parentFrame:CreateFontString(name, "OVERLAY", "GameFontNormalSmall")
	fs:Show()
	fs:ClearAllPoints()
	fs:SetPoint(position, x, y)
	fs:SetTextColor(1, 1, 1)
	fs:SetText(text)
	return fs
end

-- Create a UIDropDownMenu with a FontString.
-- The FontString element has the name: "lbl" + name.
function GraphicsHelper:CreateDropDown(parentFrame, text, x, y, initFunction)
	local dd = CreateFrame("Frame", nil, parentFrame, "UIDropDownMenuTemplate")
	dd:Show()
	dd:ClearAllPoints()
	dd:SetPoint("TOPRIGHT", x, y)
	UIDropDownMenu_SetWidth(dd, 125)
	if initFunction then
		UIDropDownMenu_Initialize(dd, initFunction)
	end
	-- Set the text in line with the dropdown to the left side
	local fs = self:CreateFontString(parentFrame, nil, text, "TOPLEFT", -12, y - 6)
    return dd, fs
end

-- Create a UICheckButton with a FontString.
-- The FontString element has the name: "lbl" + name.
function GraphicsHelper:CreateCheckButton(parentFrame, text, x, y, onClickFunction)
	local cb = CreateFrame("CheckButton", nil, parentFrame, "UICheckButtonTemplate")
	cb:EnableMouse(true)
	cb:SetHeight(24)
	cb:SetWidth(24)
	cb:Show()
	cb:ClearAllPoints()
	cb:SetPoint("TOPLEFT", x - 16, y)
	cb:SetScript("OnClick", onClickFunction)
    cb:SetFontString(self:CreateFontString(cb, nil, text, "LEFT", 30, 0))
    return cb
end

-- Create an OptionsSlider
function GraphicsHelper:CreateSlider(parentFrame, name, min, max, step, height, width, x, y)
	local sl = CreateFrame("Slider", name, parentFrame, "OptionsSliderTemplate")
	sl:SetMinMaxValues(min, max)
	sl:SetValueStep(step)
	sl:SetHeight(height)
	sl:SetWidth(width)
	sl:Show()
	sl:ClearAllPoints()
	sl:SetPoint("TOPLEFT", x, y)
    return sl
end

function GraphicsHelper:CreateButton(parentFrame, text, x, y, onClickFunction)
	local btn = CreateFrame("Button", nil, parentFrame, "OptionsButtonTemplate")
	btn:SetText(text)
	btn:EnableMouse(true)
	btn:Show()
	btn:ClearAllPoints()
	btn:SetHeight(24)
	btn:SetPoint("TOPRIGHT", x, y)
	btn:SetScript("OnClick", onClickFunction)
	return btn
end