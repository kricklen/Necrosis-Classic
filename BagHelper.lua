BagHelper = {
	BagsArray = false,
	
	Soulshard_Count = false,
	Soulshard_Locations = false,
	InfernalStone_Count = false,
	DemonicFigure_Count = false,
	
	Soulstone_Available = false,
	Soulstone_Location = false,
	Healthstone_Available = false,
	Healthstone_Location = false,
	Firestone_Available = false,
	Firestone_Location = false,
	Spellstone_Available = false,
	Spellstone_Location = false,
	Hearthstone_Available = false,
	Hearthstone_Location = false
}

local _bh = BagHelper

function _bh:GetPlayerBags()
    self.BagsArray = {}
    for i = 0, NUM_BAG_SLOTS, 1 do
		local bagName = GetBagName(i)
		local bagSlots = GetContainerNumSlots(i)
        local itemName, itemLink, itemRarity,
              itemLevel, itemMinLevel, itemType,
              itemSubType, itemStackCount, itemEquipLoc,
              itemTexture, itemSellPrice = GetItemInfo(bagName)
		table.insert(self.BagsArray, {slot=i, name=bagName, type=itemSubType, capacity=bagSlots, isSoulBag=(itemSubType == "Soul Bag")})
    end
end

function _bh:GetStoneCounts()
	self.Soulshard_Count = GetItemCount(Constants.Soulshard_Item_Id)
	self.InfernalStone_Count = GetItemCount(Constants.InfernalStone_Item_Id)
	self.DemonicFigure_Count = GetItemCount(Constants.DemonicFigure_Item_Id)
end

-- Explore bags for stones & shards || Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function _bh:BagExplore(containerId)
	self:GetPlayerBags()

	if not containerId then
		self.Soulstone_Available = nil
		self.Healthstone_Available = nil
		self.Firestone_Available = nil
		self.Spellstone_Available = nil
		self.Hearthstone_Available = nil
		-- Search all bags || Parcours des sacs
		for i,bag in ipairs(self.BagsArray) do
			self:FindStones(bag)
		end
	else
		if self.Soulstone_Available == containerId then self.Soulstone_Available = nil end
		if self.Healthstone_Available == containerId then self.Healthstone_Available = nil end
		if self.Firestone_Available == containerId then self.Firestone_Available = nil end
		if self.Spellstone_Available == containerId then self.Spellstone_Available = nil end
		if self.Hearthstone_Available == containerId then self.Hearthstone_Available = nil end
		-- Search the bag that updated
		for i,bag in ipairs(self.BagsArray) do
			if containerId == bag.slot then
				self:FindStones(bag)
			end
		end
	end
end

function _bh:FindStones(bag)
	-- Exit if its a known soul bag (which can only store shards) || Parcours des emplacements des sacs
	if not bag.isSoulBag then

		-- Iterate over the bag slots
		for slot = 1,bag.capacity,1 do
			local itemId = GetContainerItemID(bag.slot, slot)

			-- If there is an item located in that bag slot || Dans le cas d'un emplacement non vide
			if itemId then
				local itemName = GetItemInfo(itemId)

				-- Check if its a soulstone || Si c'est une pierre d'âme, on note son existence et son emplacement
				if itemName:find(Necrosis.Translation.Item.Soulstone) then
					self.Soulstone_Available = bag.slot
					self.Soulstone_Location = {bag.slot,slot}
					NecrosisConfig.ItemSwitchCombat[4] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SoulstoneUpdateAttribute()
				-- Check if its a healthstone || Même chose pour une pierre de soin
				elseif itemName:find(Necrosis.Translation.Item.Healthstone) then
					self.Healthstone_Available = bag.slot
					self.Healthstone_Location = {bag.slot,slot}
					NecrosisConfig.ItemSwitchCombat[3] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:HealthstoneUpdateAttribute()
				-- Check if its a spellstone || Et encore pour la pierre de sort
				elseif itemName:find(Necrosis.Translation.Item.Spellstone) then
					self.Spellstone_Available = bag.slot
					self.Spellstone_Location = {bag.slot,slot}
					NecrosisConfig.ItemSwitchCombat[1] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SpellstoneUpdateAttribute()
				-- Check if its a firestone || La pierre de feu maintenant
				elseif itemName:find(Necrosis.Translation.Item.Firestone) then
					self.Firestone_Available = bag.slot
					self.Firestone_Location = {bag.slot,slot}
					NecrosisConfig.ItemSwitchCombat[2] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:FirestoneUpdateAttribute()
				-- Check if its a hearthstone || et enfin la pierre de foyer
				elseif itemName:find(Necrosis.Translation.Item.Hearthstone) then
					self.Hearthstone_Available = bag.slot
					self.Hearthstone_Location = {bag.slot,slot}
				end
			end
		end
	end
end

function _bh:DestroyShards(maxToKeep)
	for i,bag in ipairs(self.BagsArray) do

		-- Skip soul bags
		if not bag.isSoulBag then

			-- Iterate over the bag slots
			for slot = 1,bag.capacity,1 do
				if maxToKeep >= self.Soulshard_Count then
					break
				end
				if self:TryDestroyShard(bag.slot, slot) then
					self.Soulshard_Count = GetItemCount(Constants.Soulshard_Item_Id)
				end
			end
		end
	end
end

function _bh:TryDestroyShard(bagSlot, slot)
	local itemId = GetContainerItemID(bagSlot, slot)
	if (itemId == Constants.Soulshard_Item_Id) then
		PickupContainerItem(bagSlot, slot)
		if (CursorHasItem()) then
			DeleteCursorItem()
			return true
		end
	end
	return false
end