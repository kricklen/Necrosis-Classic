BagHelper = {
	Soulshard_Count = 0,
	InfernalStone_Count = 0,
	DemonicFigure_Count = 0,
	
	Soulstone_IsAvailable = false,
	Soulstone_Rank = 0,
	Soulstone_Name = nil,
	Soulstone_BagId = nil,

	Healthstone_IsAvailable = false,
	Healthstone_Rank = 0,
	Healthstone_Name = nil,
	Healthstone_BagId = nil,
	Healthstone_SlotId = nil,

	Firestone_IsAvailable = false,
	Firestone_Rank = 0,
	Firestone_Name = nil,
	Firestone_BagId = nil,

	Spellstone_IsAvailable = false,
	Spellstone_Rank = 0,
	Spellstone_Name = nil,
	Spellstone_BagId = nil,

	Hearthstone_IsAvailable = false,
	Hearthstone_BagId = nil,
	Hearthstone_SlotId = nil
}

local _bh = BagHelper

function _bh:GetPlayerBags()
    local bagsArray = {}
    for i = 0, NUM_BAG_SLOTS, 1 do
		local bagName = GetBagName(i)
		if (bagName) then
			local bagSlots = GetContainerNumSlots(i)
			local _, _, _, _, _, _, itemSubType = GetItemInfo(bagName)
			table.insert(
				bagsArray,
				{
					id = i,
					name = bagName,
					type = itemSubType,
					capacity = bagSlots,
					isSoulBag = (itemSubType == "Soul Bag")
				}
			)
		end
	end
	return bagsArray
end

function _bh:GetStoneCounts()
	self.Soulshard_Count = GetItemCount(ItemHelper.Soulshard_Item_Id)
	self.InfernalStone_Count = GetItemCount(ItemHelper.InfernalStone_Item_Id)
	self.DemonicFigure_Count = GetItemCount(ItemHelper.DemonicFigure_Item_Id)
end

-- Explore bags for stones & shards || Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function _bh:BagExplore(bagId)
	-- Only check inventory bags or -2 (same bag)
	if (bagId
		and (bagId < 0 or bagId > NUM_BAG_SLOTS)
	    and not (bagId == -2))
	then
		return
	end
	local bagsArray = self:GetPlayerBags()

	if (not bagId) then
		self.Soulstone_IsAvailable = false
		self.Soulstone_Rank = 0
		self.Soulstone_Name = nil
		self.Healthstone_IsAvailable = false
		self.Healthstone_Rank = 0
		self.Healthstone_Name = nil
		self.Firestone_IsAvailable = false
		self.Firestone_Rank = 0
		self.Firestone_Name = nil
		self.Spellstone_IsAvailable = false
		self.Spellstone_Rank = 0
		self.Spellstone_Name = nil
		self.Hearthstone_IsAvailable = false
		-- Search all bags || Parcours des sacs
		for i,bag in ipairs(bagsArray) do
			self:_FindStones(bag)
		end
	else
		if (self.Soulstone_BagId == bagId) then
			self.Soulstone_IsAvailable = false
			self.Soulstone_Rank = 0
			self.Soulstone_Name = nil
		end
		if (self.Healthstone_BagId == bagId) then
			self.Healthstone_IsAvailable = false
			self.Healthstone_Rank = 0
			self.Healthstone_Name = nil
		end
		if (self.Firestone_BagId == bagId) then
			self.Firestone_IsAvailable = false
			self.Firestone_Rank = 0
			self.Firestone_Name = nil
		end
		if (self.Spellstone_BagId == bagId) then
			self.Spellstone_IsAvailable = false
			self.Spellstone_Rank = 0
			self.Spellstone_Name = nil
		end
		if (self.Hearthstone_BagId == bagId) then
			self.Hearthstone_IsAvailable = false
		end
		-- Search the bag that updated
		for i,bag in ipairs(bagsArray) do
			if (bagId == bag.id) then
				self:_FindStones(bag)
			end
		end
	end
end

function _bh:_FindStones(bag)
	-- Exit if its a known soul bag (which can only store shards) || Parcours des emplacements des sacs
	if (not bag.isSoulBag) then
		-- Iterate over the bag slots
		for slot = 1,bag.capacity,1 do
			local itemId = GetContainerItemID(bag.id, slot)
			-- If there is an item located in that bag slot || Dans le cas d'un emplacement non vide
			if (itemId) then
				-- Check if its a soulstone and of higher rank than the current one
				if (ItemHelper:IsSoulstone(itemId)
					and self.Soulstone_Rank < ItemHelper.Soulstone[itemId].Rank)
				then
					self.Soulstone_IsAvailable = true
					self.Soulstone_Rank = ItemHelper.Soulstone[itemId].Rank
					self.Soulstone_BagId = bag.id
					self.Soulstone_Name = ItemHelper.Soulstone[itemId].Name
					-- NecrosisConfig.ItemSwitchCombat[4] = ItemHelper.Soulstone[itemId].Name
					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SoulstoneUpdateAttribute()

				-- Check if its a healthstone and of higher rank than the current one
				elseif (ItemHelper:IsHealthstone(itemId)
					and self.Healthstone_Rank < ItemHelper.Healthstone[itemId].Rank)
				then
					self.Healthstone_IsAvailable = true
					self.Healthstone_Rank = ItemHelper.Healthstone[itemId].Rank
					self.Healthstone_BagId = bag.id
					self.Healthstone_SlotId = slot
					self.Healthstone_Name = ItemHelper.Healthstone[itemId].Name
					-- NecrosisConfig.ItemSwitchCombat[3] = ItemHelper.Healthstone[itemId].Name
					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:HealthstoneUpdateAttribute()

				-- Check if its a spellstone and of higher rank than the current one
				elseif (ItemHelper:IsSpellstone(itemId)
					and self.Spellstone_Rank < ItemHelper.Spellstone[itemId].Rank)
				then
					self.Spellstone_IsAvailable = true
					self.Spellstone_Rank = ItemHelper.Spellstone[itemId].Rank
					self.Spellstone_BagId = bag.id
					self.Spellstone_Name = ItemHelper.Spellstone[itemId].Name
					-- NecrosisConfig.ItemSwitchCombat[1] = ItemHelper.Spellstone[itemId].Name
					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SpellstoneUpdateAttribute()

				-- Check if its a firestone and of higher rank than the current one
				elseif (ItemHelper:IsFirestone(itemId)
					and self.Firestone_Rank < ItemHelper.Firestone[itemId].Rank)
				then
					self.Firestone_IsAvailable = true
					self.Firestone_Rank = ItemHelper.Firestone[itemId].Rank
					self.Firestone_BagId = bag.id
					self.Firestone_Name = ItemHelper.Firestone[itemId].Name
					-- NecrosisConfig.ItemSwitchCombat[2] = ItemHelper.Firestone[itemId].Name
					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:FirestoneUpdateAttribute()

				-- Check if its a hearthstone || et enfin la pierre de foyer
				elseif (ItemHelper:IsHearthstone(itemId)) then
					self.Hearthstone_IsAvailable = true
					self.Hearthstone_BagId = bag.id
				end
			end
		end
	end
end

function _bh:DestroyShards(maxToKeep)
	print("DestroyShards: "..tostring(maxToKeep))
	local shardCountTmp = self.Soulshard_Count
	-- Kills all shards? Debug!
	for i,bag in ipairs(self:GetPlayerBags()) do
		-- print("Bags: "..tostring(bag.name)..", "..tostring(bag.isSoulBag))
		-- Skip soul bags
		-- if (not bag.isSoulBag) then
			-- Iterate over the bag slots
			for slot = 1,bag.capacity,1 do
				if (maxToKeep >= self.Soulshard_Count) then
					break
				end
				if (self:TryDestroyShard(bag.id, slot)) then
					self.Soulshard_Count = GetItemCount(ItemHelper.Soulshard_Item_Id)
				end
				-- if (shardCountTmp == self.Soulshard_Count) then
				-- 	print("Destroy failed")
				-- 	break
				-- end
			end
		-- end
	end
end

function _bh:TryDestroyShard(bagId, slot)
	local itemId = GetContainerItemID(bagId, slot)
	if (itemId == ItemHelper.Soulshard_Item_Id) then
		PickupContainerItem(bagId, slot)
		if (CursorHasItem()) then
			DeleteCursorItem()
			return true
		end
	end
	return false
end
