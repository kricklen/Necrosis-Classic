ItemHelper = {
    Soulshard_Item_Id = 6265,
    InfernalStone_Item_Id = 5565,
    DemonicFigure_Item_Id = 16583,
    
    Hearthstone_Item_Id = 6948,

    Firestone = {
        ItemIds = {
            1254,  -- Lesser
            13699, -- Normal
            13700, -- Greater
            13701  -- Major
        }
    },

    Healthstone = {
        ItemIds = {
            19005, -- Minor
            19007, -- Lesser
            19009, -- Normal
            19011, -- Greater
            19013  -- Major
        }
    },

    Soulstone = {
        ItemIds = {
            5232,  -- Minor
            16892, -- Lesser
            16893, -- Normal
            16895, -- Greater
            16896  -- Major
        }
    },

    Spellstone = {
        ItemIds = {
            5522,  -- Normal
            13602, -- Greater
            13603  -- Major
        }
    }
}

local _ih = ItemHelper

local function MakeItemIdRanks(root)
    -- i is the rank of the item
    -- Create an entry in the form of [itemId] = rank
    for i,id in ipairs(root.ItemIds) do
        root[id] = i
    end
end

MakeItemIdRanks(_ih.Healthstone)
MakeItemIdRanks(_ih.Firestone)
MakeItemIdRanks(_ih.Spellstone)
MakeItemIdRanks(_ih.Soulstone)

function _ih:IsFirestone(itemId)
    return tContains(self.Firestone.ItemIds, itemId)
end

function _ih:IsHealthstone(itemId)
    return tContains(self.Healthstone.ItemIds, itemId)
end

function _ih:IsHearthstone(itemId)
    return (self.Hearthstone_Item_Id == itemId)
end

function _ih:IsSoulstone(itemId)
    return tContains(self.Soulstone.ItemIds, itemId)
end

function _ih:IsSpellstone(itemId)
    return tContains(self.Spellstone.ItemIds, itemId)
end

-- Cooldowns
function _ih:IsSoulstoneOnCooldown()
	local secs = self:GetItemCooldownInSecs(self.Soulstone.ItemIds[1])
	return (secs > 0)
end

function _ih:GetSoulstoneCooldown()
	return self:GetItemCooldownTime(self.Soulstone.ItemIds[1])
end

function _ih:GetHealthstoneCooldown()
	return self:GetItemCooldownTime(self.Healthstone.ItemIds[1])
end

function _ih:GetHearthstoneCooldown()
	return self:GetItemCooldownTime(self.Healthstone.ItemIds[1])
end

function _ih:GetItemCooldownTime(itemId)
	local secs = self:GetItemCooldownInSecs(itemId)
	return (secs > 0), Necrosis.Timers:GetFormattedTime(secs)
end

function _ih:GetItemCooldownInSecs(itemId)
	local startTime, duration, enable = GetItemCooldown(itemId)
	if enable == 0 then
		return 0
	end
	if startTime == 0 then
		return 0
	end
	local remainingSecs = math.floor(duration - (GetTime() - startTime))
	return remainingSecs
end
