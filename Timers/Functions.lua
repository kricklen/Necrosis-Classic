--[[
    Necrosis LdC
    Copyright (C) 2005-2008  Lom Enfroy

    This file is part of Necrosis LdC.

    Necrosis LdC is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    Necrosis LdC is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Necrosis LdC; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
--]]


------------------------------------------------------------------------------------------------------
-- Necrosis LdC
-- Par Lomig (Kael'Thas EU/FR) & Tarcalion (Nagrand US/Oceanic) 
-- Contributions deLiadora et Nyx (Kael'Thas et Elune EU/FR)
--
-- Skins et voix Françaises : Eliah, Ner'zhul
--
-- Version Allemande par Geschan
-- Version Espagnole par DosS (Zul’jin)
-- Version Russe par Komsomolka
--
-- Version $LastChangedDate: 2009-12-10 17:09:53 +1100 (Thu, 10 Dec 2009) $
------------------------------------------------------------------------------------------------------

-- On définit G comme étant le tableau contenant toutes les frames existantes.
-- local _G = getfenv(0)


------------------------------------------------------------------------------------------------------
-- FUNCTIONS TO ADD TIMERS || FONCTIONS D'INSERTION
------------------------------------------------------------------------------------------------------

Necrosis.Timers = {
	Instances = {},
	SingleFrame = nil,
	SingleAnchor = nil,
	MobFrames = {},
	MobAnchor = nil,
	Font = CreateFont("NecrosisTimerFont"),
	TICK_SECS = 0.05,
	TimeSinceLastUpdate = 0
}

local _t = Necrosis.Timers

-- local TICK_SECS = 0.1
local BAR_HEIGHT = 20
local BAR_WIDTH = 140
local BAR_PADDING = 1
local BAR_COLOR = {r = 1, g = 0.5, b = 0}
local TEXT_COLOR = {r = 1, g = 1, b = 1}
local SS_BAN_ANCHOR = {x = 0, y = 0}
local MOB_ANCHOR = {x = -60, y = 0}
local BACKGROUND_COLOR = {r = 0.5, g = 0.5, b = 0.5, a = 0.5}

function _t:GetFormattedTime(secs)
	local mins = math.modf(secs / 60)
	secs = math.fmod(secs, 60)
	if (mins > 0) then
		return string.format("%d:%02d", mins, secs)
	end
	return string.format("%d", secs)
end

function _t:SetFont(path, size)
	local result = _t.Font:SetFont(path, size)
end

local function FindMobTimerGroup(targetGuid)
	for i,mobFrame in pairs(_t.MobFrames) do
		if (mobFrame.Guid == targetGuid) then
			return mobFrame
		end
	end
	return nil
end

local function FindFreeMobTimerGroup()
	for i,mobFrame in pairs(_t.MobFrames) do
		-- A mobFrame is unused when it has no timers
		if (#mobFrame.Timers == 0 and mobFrame.Frame) then
			return mobFrame
		end
	end
	return nil
end

local function PositionMobTimerGroups()
	local activeCount = 0
	for i,mobFrame in pairs(_t.MobFrames) do
		-- Only reposition active frames
		if (#mobFrame.Timers > 0) then
			mobFrame.Frame:ClearAllPoints()
			if (_t.MobAnchor) then
				mobFrame.Frame:SetPoint(
					"LEFT",
					_t.MobAnchor,
					"LEFT",
					0 - (activeCount * (BAR_HEIGHT + BAR_WIDTH + BAR_PADDING)),
					0)
			else
				mobFrame.Frame:SetPoint(
					NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"][1],
					NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"][2],
					NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"][3],
					NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"][4] - (activeCount * (BAR_HEIGHT + BAR_WIDTH + BAR_PADDING)),
					NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"][5]
				)
			end
			activeCount = activeCount + 1
		end
	end
end

local function PositionSingleTimerGroup()
	if (not _t.SingleFrame) then
		return
	end
	_t.SingleFrame.Frame:ClearAllPoints()
	if (_t.SingleAnchor) then
		-- Capture the single frame if it exists
		_t.SingleFrame.Frame:SetParent(_t.SingleAnchor)
		_t.SingleFrame.Frame:SetPoint(
			"LEFT",
			_t.SingleAnchor,
			"LEFT",
			0,
			0)
	else
		_t.SingleFrame.Frame:SetPoint(
			NecrosisConfig.FramePosition["NecrosisSingleTimerAnchor"][1],
			NecrosisConfig.FramePosition["NecrosisSingleTimerAnchor"][2],
			NecrosisConfig.FramePosition["NecrosisSingleTimerAnchor"][3],
			NecrosisConfig.FramePosition["NecrosisSingleTimerAnchor"][4],
			NecrosisConfig.FramePosition["NecrosisSingleTimerAnchor"][5]
		)
	end
end

local function MakeTimerGroupGui(parentFrame)
	local mf = CreateFrame("Frame", nil, parentFrame)
	mf:SetMovable(false)
	-- mf:SetAllPoints(parentFrame)
	mf:ClearAllPoints()
	mf:SetSize(BAR_WIDTH, BAR_HEIGHT)

	local bg = mf:CreateTexture(nil, "BACKGROUND")
	bg:SetSize(BAR_WIDTH, BAR_HEIGHT)
	bg:SetColorTexture(BACKGROUND_COLOR.r, BACKGROUND_COLOR.g, BACKGROUND_COLOR.b, BACKGROUND_COLOR.a)
	bg:SetAllPoints()

	local title = mf:CreateFontString(nil, "OVERLAY", "NecrosisTimerFont")
	title:SetSize(BAR_WIDTH, BAR_HEIGHT)
	title:SetJustifyH("MIDDLE")
	title:SetJustifyV("MIDDLE")
	title:ClearAllPoints()
	title:SetPoint("CENTER", mf, "CENTER")
	title:SetTextColor(TEXT_COLOR.r, TEXT_COLOR.g, TEXT_COLOR.b)

	local icon = mf:CreateTexture(nil, "OVERLAY")
	icon:SetSize(BAR_HEIGHT, BAR_HEIGHT)
	icon:SetBlendMode("ADD")
	icon:ClearAllPoints()
	icon:SetPoint("LEFT", mf, "LEFT", BAR_PADDING, 0)

	return
		{
			Frame = mf,
			Background = bg,
			Title = title,
			RaidIcon = icon,
			Timers = {}
		}
end

local function SortTimerGroup(timerGroup)
	-- Sort timers by time when they are finished, lowest on top
	table.sort(timerGroup.Timers,
		function(a,b)
			return (a.EndTime > b.EndTime)
		end
	)
	for i,timerData in ipairs(timerGroup.Timers) do
		timerData.Frame:ClearAllPoints()
		timerData.Frame:SetPoint(
			"CENTER",
			timerGroup.Frame,
			"CENTER",
			0,
			i * (BAR_HEIGHT + BAR_PADDING))
	end
end

local function UpdateRaidIcon(data, iconNumber)
	if (iconNumber == data.RaidIconNumber) then
		return
	end
	if (iconNumber) then
		data.RaidIcon:SetTexture(GraphicsHelper:GetWoWTexture("TargetingFrame", "UI-RaidTargetingIcon_"..iconNumber))
		data.RaidIconNumber = iconNumber
	else
		data.RaidIcon:SetTexture(nil)
		data.RaidIconNumber = nil
	end
end

local function RemoveTimer(timerData)
	if (timerData.Finished) then
		return
	end
	timerData.Finished = true
	-- Hide the timer, stopping the countdown
	timerData.Frame:Hide()
	-- Remove the raid icon from the timer (might have been banish)
	UpdateRaidIcon(timerData, nil)
	-- Remove the timer from the group
	local idx = table.indexOf(timerData.Group.Timers, timerData)
	table.remove(timerData.Group.Timers, idx)
	if (#timerData.Group.Timers > 0) then
		SortTimerGroup(timerData.Group)
	else
		-- Remove the raid icon from the timer group
		UpdateRaidIcon(timerData.Group, nil)
		timerData.Group.Frame:Hide()
		if (timerData.SpellType ~= "soulstone" and timerData.SpellType ~= "banish") then
			PositionMobTimerGroups()
		end
	end
	-- Remove reference to the timer group as well
	timerData.Group = nil
end

local function UpdateTimer(ticker)
	print("upd: "..tostring(self))
	local timerData = ticker.TimerData
	-- for i,timerData in pairs(_t.Instances) do
		if (not timerData.Finished) then
			-- local value = timerData.ProgressBar:GetValue() - _t.TICK_SECS
			-- local fraction = value / timerData.SpellDuration
			timerData.Value = timerData.Value - _t.TICK_SECS
			local fraction = timerData.Value / timerData.SpellDuration
			
			timerData.ProgressBar:SetValue(timerData.Value)
			
			-- timerData.Spark:ClearAllPoints()
			-- timerData.Spark:SetPoint("CENTER", timerData.ProgressBar, "LEFT", fraction * (BAR_WIDTH - BAR_HEIGHT), 0)
			
			if (timerData.Value > 60) then
				timerData.lblCountdown:SetText(_t:GetFormattedTime(timerData.Value))
			else
				local idx = string.find(timerData.Value, ".", 1, true)
				if (idx) then
					local str = string.sub(timerData.Value, 1, idx + 1)
					timerData.lblCountdown:SetText(str)
				end
			end

			if (fraction <= 0) then
				RemoveTimer(timerData)
			end
		end
	-- end


	<start>...
	ends = GetTime() + delay
	-- do stuff
	local time = GetTime()
	-- local delay = timer.delay - (time - timer.ends)
	local delay = _t.TICK_SECS - (time - timer.ends)
	-- Ensure the delay doesn't go below the threshold
	if delay < 0.01 then delay = 0.01 end
	C_TimerAfter(delay, timer.callback)
	timer.ends = time + delay
	<end>...


	if (NecrosisConfig.EnableTimerBars) then
		-- Repeat after 0.1 secs
		C_Timer.After(TICK_SECS, UpdateTimer)
	end
end

local function FindFreeTimer()
	for i,timerData in ipairs(_t.Instances) do
		if (timerData.Finished and timerData.Frame) then
			timerData.Finished = false
			return timerData
		end
	end
	return nil
end

local function SetTimerParent(timerData, parentFrame)
	timerData.Frame:ClearAllPoints()
	timerData.Frame:SetAllPoints(parentFrame)
	timerData.Frame:SetParent(parentFrame)
end

local function MakeTimerGui(parentFrame)
	-- Frame will be positioned later
	local frame = CreateFrame("Frame", nil, parentFrame)
	frame:SetSize(BAR_WIDTH, BAR_HEIGHT)
	
	local lblCountdown = frame:CreateFontString(nil, "OVERLAY", "NecrosisTimerFont")
	lblCountdown:SetSize(2 * BAR_HEIGHT + BAR_PADDING, BAR_HEIGHT)
	lblCountdown:SetJustifyH("LEFT")
	lblCountdown:SetTextColor(TEXT_COLOR.r, TEXT_COLOR.g, TEXT_COLOR.b)
	lblCountdown:ClearAllPoints()
	if (NecrosisConfig.SpellTimerPos == -1) then
		lblCountdown:SetPoint("LEFT", frame, "LEFT", 1, 0)
	else
		lblCountdown:SetPoint("LEFT", frame, "RIGHT", 5, 0)
	end

	local bar = CreateFrame("StatusBar", nil, frame)
	bar:SetSize(BAR_WIDTH - BAR_HEIGHT, BAR_HEIGHT)
	bar:SetStatusBarTexture(GraphicsHelper:GetWoWTexture("TargetingFrame", "UI-StatusBar"))
	bar:SetStatusBarColor(BAR_COLOR.r, BAR_COLOR.g, BAR_COLOR.b)
	bar:SetFrameLevel(bar:GetFrameLevel() - 1)
	bar:ClearAllPoints()
	bar:SetPoint("LEFT", frame, "LEFT")

	local lblSpellname = bar:CreateFontString(nil, "OVERLAY", "NecrosisTimerFont")
	lblSpellname:SetSize(BAR_WIDTH - BAR_HEIGHT, BAR_HEIGHT)
	lblSpellname:SetJustifyH("RIGHT")
	lblSpellname:SetJustifyV("MIDDLE")
	lblSpellname:ClearAllPoints()
	lblSpellname:SetPoint("LEFT", bar, "LEFT", -3, 0)
	lblSpellname:SetTextColor(TEXT_COLOR.r, TEXT_COLOR.g, TEXT_COLOR.b)

	local bg = bar:CreateTexture(nil, "BACKGROUND")
	bg:SetAllPoints()
	bg:SetColorTexture(BACKGROUND_COLOR.r, BACKGROUND_COLOR.g, BACKGROUND_COLOR.b, BACKGROUND_COLOR.a)

	local spark = bar:CreateTexture(nil, "OVERLAY")
	spark:SetSize(BAR_HEIGHT, BAR_HEIGHT)
	spark:SetTexture(GraphicsHelper:GetWoWTexture("CastingBar", "UI-CastingBar-Spark"))
	spark:SetBlendMode("ADD")
	spark:ClearAllPoints()
	spark:SetPoint("CENTER", bar, "LEFT", 0, 0)

	local spellIcon = bar:CreateTexture(nil, "OVERLAY")
	spellIcon:SetSize(BAR_HEIGHT, BAR_HEIGHT)
	spellIcon:SetBlendMode("ADD")
	spellIcon:ClearAllPoints()
	spellIcon:SetPoint("RIGHT", frame, "RIGHT", BAR_PADDING, 0)

	local raidIcon = bar:CreateTexture(nil, "OVERLAY")
	raidIcon:SetSize(BAR_HEIGHT, BAR_HEIGHT)
	raidIcon:SetBlendMode("ADD")
	raidIcon:ClearAllPoints()
	raidIcon:SetPoint("LEFT", frame, "RIGHT", BAR_PADDING, 0)

	return
		{
			Finished = false,
			Frame = frame,
			lblCountdown = lblCountdown,
			lblSpellname = lblSpellname,
			ProgressBar = bar,
			Spark = spark,
			SpellIcon = spellIcon,
			RaidIcon = raidIcon
		}
end

local function InsertTimer(timerGroup)
	-- Find a finished timer
	local timerData = FindFreeTimer()
	if (not timerData) then
		-- Create a new timer with gui elements
		timerData = MakeTimerGui(timerGroup.Frame)
		timerData.Frame:SetAttribute("TimerData", timerData)
		table.insert(_t.Instances, timerData)
	end
	-- Change references to the current timer group
	SetTimerParent(timerData, timerGroup.Frame)

	-- Link and reverse link timer to group
	timerData.Group = timerGroup
	table.insert(timerGroup.Timers, timerData)
	return timerData
end

local function StartTimer(timerData)
	-- Timers are split into 3 types: banish, soulstone and the rest
	-- Banish and soulstone are displayed in the same frame group, banishes on top, soulstones at the bottom
	-- The rest is displayed in a frame group per mob since it's dots etc.

	-- Set starting values
	timerData.ProgressBar:SetMinMaxValues(0, timerData.SpellDuration)
	timerData.ProgressBar:SetValue(timerData.SpellDuration)
	timerData.lblCountdown:SetText(timerData.SpellDuration)
	timerData.Value = timerData.SpellDuration

	if (timerData.SpellType == "soulstone") then
		-- Soulstone Resurrection has no SpellIcon texture
		timerData.SpellIcon:SetTexture(GetSpellTexture("Create Soulstone"))
	else
		timerData.SpellIcon:SetTexture(GetSpellTexture(timerData.SpellName))
	end

	-- Assign the spell name or target
	if (timerData.SpellType == "soulstone" or timerData.SpellType == "banish") then
		timerData.lblSpellname:SetText(timerData.TargetName)
	else
		timerData.lblSpellname:SetText(timerData.SpellName)
	end

	SortTimerGroup(timerData.Group)

	-- Show the gui elements, starting the timer
	timerData.Group.Frame:Show()
	timerData.Frame:Show()

	timerData.UpdateMe = UpdateTimer
	-- timerData.Ticker = C_Timer.NewTicker(_t.TICK_SECS, UpdateTimer, timerData.SpellDuration / _t.TICK_SECS)
	-- timerData.Ticker.TimerData = timerData
	C_Timer.After(_t.TICK_SECS, timerData.UpdateMe)
end

function _t:InsertSpellTimer(casterGuid, casterName, targetGuid, targetName, targetLevel, targetIcon, spellId, spellName, spellDuration, spellType)
	local timerData
	if (spellType == "soulstone" or spellType == "banish") then
		-- If we cast soulstone or banish, tell our fellow warlocks
		if (casterGuid == Necrosis.CurrentEnv.PlayerGuid) then
			-- Broadcast to raid/party if applicable
			EventHelper:SendAddonMessage("InsertTimer~"
				..tostring(casterGuid).."|"
				..tostring(casterName).."|"
				..tostring(targetGuid).."|"
				..tostring(targetName).."|"
				..tostring(targetLevel).."|"
				..tostring(targetIcon).."|"
				..tostring(spellId).."|"
				..tostring(spellName).."|"
				..tostring(spellDuration).."|"
				..tostring(spellType))
		end
		if (not _t.SingleFrame) then
			-- Create and position the group for single timers
			_t.SingleFrame = MakeTimerGroupGui(UIParent)
			PositionSingleTimerGroup()
		end
		-- Add single timer
		_t.SingleFrame.Title:SetText("Single")
		timerData = InsertTimer(_t.SingleFrame)
	else
		-- Add mob timer
		local timerGroup = FindMobTimerGroup(targetGuid)
		if (not timerGroup) then
			timerGroup = FindFreeMobTimerGroup()
			if (not timerGroup) then
				timerGroup = MakeTimerGroupGui(UIParent)
				table.insert(_t.MobFrames, timerGroup)
			end
			timerGroup.Guid = targetGuid
			timerGroup.Title:SetText(targetName)
		end
		timerData = InsertTimer(timerGroup)
		PositionMobTimerGroups()
	end

	-- Set payload
	timerData.CasterGuid = casterGuid
	timerData.CasterName = casterName
	timerData.SpellId = spellId
	timerData.SpellName = spellName
	timerData.SpellDuration = spellDuration
	timerData.SpellType = spellType
	timerData.TargetGuid = targetGuid
	timerData.TargetName = targetName
	timerData.TargetLevel = targetLevel
	timerData.EndTime = GetTime() + spellDuration

	StartTimer(timerData)
end

-- Reset an existing timer, a debuff has been casted on a tareget while it was still active
function _t:ResetTimer(casterGuid, targetGuid, spellId, spellDuration)
	for i,timerData in ipairs(_t.Instances) do
		if (timerData.CasterGuid == casterGuid and timerData.TargetGuid == targetGuid and timerData.SpellId == spellId) then
			timerData.ProgressBar:SetValue(spellDuration)
			return
		end
	end
end

local function SetSoulstoneCooldown(timerData)
	if (timerData.CasterGuid == Necrosis.CurrentEnv.PlayerGuid) then
		-- Our own soulstone target died
		timerData.lblSpellname:SetText("Inactive")
		local iscd, sscd = ItemHelper:GetSoulstoneCooldownSecs()
		print("sscd: "..tostring(sscd))
		if (iscd) then
			timerData.ProgressBar:SetValue(sscd)
			EventHelper:SendAddonMessage("Soulstone cooldown: "..sscd)
		else
			-- Soulstone is ready, remove the timer
			RemoveTimer(timerData)
			EventHelper:SendAddonMessage("Soulstone remove: ")
		end
	else
		-- Soulstone target of a fellow warlock died

	end
end

-- The target died, remove all timers for it
function _t:RemoveSpellTimerTarget(targetGuid)
	for i,timerData in ipairs(self.Instances) do
		if (timerData.TargetGuid == targetGuid) then
			-- Check if it's a soulstone
			if (timerData.SpellType == "soulstone") then
				SetSoulstoneCooldown(timerData)
			else
				RemoveTimer(timerData)
			end
		end
	end
end

-- A spell was removed from target
function _t:RemoveSpellTimerTargetName(targetGuid, spellName)
	for i,timerData in ipairs(self.Instances) do
		if (timerData.TargetGuid == targetGuid and timerData.SpellName == spellName) then
			if (timerData.SpellType == "soulstone") then
				SetSoulstoneCooldown(timerData)
			else
				RemoveTimer(timerData)
			end
		end
	end
end

function _t:RemoveAllTimers()
	for i,timerData in ipairs(_t.Instances) do
		RemoveTimer(timerData)
	end
end

local function MakeAnchor(anchorFrame, anchorName, anchorText)
	if (anchorFrame) then
		anchorFrame:Show()
	else
		anchorFrame = GraphicsHelper:CreateMovableDialog(anchorName, BAR_HEIGHT, BAR_WIDTH)
		local tex = anchorFrame:CreateTexture(nil, "BACKGROUND")
		tex:SetAllPoints()
		tex:SetColorTexture(1, 1, 1, 0.5)
		local fs = anchorFrame:CreateFontString(nil, "OVERLAY", "NecrosisTimerFont")
		fs:ClearAllPoints()
		fs:SetAllPoints()
		fs:SetTextColor(0.5, 1, 0)
		fs:SetText(anchorText)
		fs:Show()
	end
	if (not GraphicsHelper:LoadPosition(anchorFrame)) then
		anchorFrame:SetPoint("TOPLEFT", 100, -100)
	end
	return anchorFrame
end

function _t:ShowMobAnchor()
	self.MobAnchor = MakeAnchor(self.MobAnchor, "NecrosisMobTimerAnchor", "Mob Anchor")
	-- Capture existing timer groups
	for i,mobFrame in ipairs(self.MobFrames) do
		mobFrame.Frame:SetParent(self.MobAnchor)
	end
	PositionMobTimerGroups()
end

function _t:HideMobAnchor()
	for i,mobFrame in ipairs(self.MobFrames) do
		mobFrame.Frame:SetParent(UIParent)
	end
	self.MobAnchor:Hide()
	self.MobAnchor = nil
	PositionMobTimerGroups()
end

function _t:ShowSingleAnchor()
	self.SingleAnchor = MakeAnchor(self.SingleAnchor, "NecrosisSingleTimerAnchor", "Single Anchor")
	PositionSingleTimerGroup()
end

function _t:HideSingleAnchor()
	if (_t.SingleFrame) then
		_t.SingleFrame.Frame:SetParent(UIParent)
	end
	_t.SingleAnchor:Hide()
	_t.SingleAnchor = nil
	PositionSingleTimerGroup()
end

function _t:UpdateRaidIcon(unitGuid, iconNumber)
	for i,mobFrame in ipairs(_t.MobFrames) do
		if (mobFrame.Guid == unitGuid) then
			if (#mobFrame.Timers > 0) then
				UpdateRaidIcon(mobFrame, iconNumber)
			end
			break
		end
	end
	-- Check for banish on a target
	if (_t.SingleFrame) then
		for i,timerData in ipairs(_t.SingleFrame.Timers) do
			if (timerData.TargetGuid == unitGuid
				and (timerData.SpellType == "soulstone"
				or timerData.SpellType == "banish"))
			then
				if (not timerData.Finished) then
					UpdateRaidIcon(timerData, iconNumber)
				end
				break
			end
		end
	end
end

function _t:Initialize()
	-- Do nothing if timers are disabled
	if (not NecrosisConfig.EnableTimerBars) then
		return
	end
	-- Start the timer update
	-- C_Timer.After(_t.TICK_SECS, UpdateTimer)
	-- Set the default font for timer bars if none is configured
	if (not NecrosisConfig.TimerFont) then
		NecrosisConfig.TimerFont = Necrosis.Config.Fonts[1]
	end
	-- Also set default font size
	if (not NecrosisConfig.TimerFontSize) then
		NecrosisConfig.TimerFontSize = 12
	end
	-- Set the configured font and anchors
	_t:SetFont(NecrosisConfig.TimerFont.Path, NecrosisConfig.TimerFontSize)
	if (not NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"]) then
		NecrosisConfig.FramePosition["NecrosisMobTimerAnchor"] =
			Config.FramePosition["NecrosisMobTimerAnchor"]
	end
	-- Add soulstone timer if it's on cooldown
	local iscd, secs = ItemHelper:GetSoulstoneCooldownSecs()
	if (iscd) then
		local spellId = 20765 -- Major Soulstone Resurrection
		self:InsertSpellTimer(
			Necrosis.CurrentEnv.PlayerGuid,
			Necrosis.CurrentEnv.PlayerName,
			nil, nil, nil, nil,
			spellId,
			GetSpellInfo(spellId),
			secs,
			Necrosis.Spell.AuraType[spellId])
	end
end