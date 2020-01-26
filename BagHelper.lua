BagHelper = {
	Soulshard_Count = 0,
	InfernalStone_Count = 0,
	DemonicFigure_Count = 0,
	
	Soulstone_IsAvailable = false,
	Soulstone_Name = nil,
	Soulstone_BagId = nil,
	Soulstone_SlotId = nil,

	Healthstone_IsAvailable = false,
	Healthstone_Name = nil,
	Healthstone_BagId = nil,
	Healthstone_SlotId = nil,

	Firestone_IsAvailable = false,
	Firestone_Name = nil,
	Firestone_BagId = nil,
	Firestone_SlotId = nil,

	Spellstone_IsAvailable = false,
	Spellstone_Name = nil,
	Spellstone_BagId = nil,
	Spellstone_SlotId = nil,

	Hearthstone_IsAvailable = false,
	Hearthstone_Name = nil,
	Hearthstone_BagId = nil,
	Hearthstone_SlotId = nil
}

local _bh = BagHelper

function _bh:GetPlayerBags()
    local bagsArray = {}
    for i = 0, NUM_BAG_SLOTS, 1 do
		local bagName = GetBagName(i)
		if bagName then
			local bagSlots = GetContainerNumSlots(i)
			local _, _, _, _, _, _, itemSubType = GetItemInfo(bagName)
			table.insert(bagsArray, {id=i, name=bagName, type=itemSubType, capacity=bagSlots, isSoulBag=(itemSubType == "Soul Bag")})
		end
	end
	return bagsArray
end

function _bh:GetStoneCounts()
	self.Soulshard_Count = GetItemCount(Constants.Soulshard_Item_Id)
	self.InfernalStone_Count = GetItemCount(Constants.InfernalStone_Item_Id)
	self.DemonicFigure_Count = GetItemCount(Constants.DemonicFigure_Item_Id)
end

-- Explore bags for stones & shards || Fonction qui fait l'inventaire des éléments utilisés en démonologie : Pierres, Fragments, Composants d'invocation
function _bh:BagExplore(bagId)
	-- Only check inventory bags or -2 (same bag)
	if bagId
		and (bagId < 0 or bagId > NUM_BAG_SLOTS)
	    and not (bagId == -2)
		then
			print("Ignore: "..tostring(bagId))
		return
	end
	local bagsArray = self:GetPlayerBags()

	if not bagId then
		self.Soulstone_IsAvailable = false
		self.Healthstone_IsAvailable = false
		self.Firestone_IsAvailable = false
		self.Spellstone_IsAvailable = false
		self.Hearthstone_IsAvailable = false
		-- Search all bags || Parcours des sacs
		for i,bag in ipairs(bagsArray) do
			self:_FindStones(bag)
		end
	else
		if self.Soulstone_BagId   == bagId then self.Soulstone_IsAvailable   = false end
		if self.Healthstone_BagId == bagId then self.Healthstone_IsAvailable = false end
		if self.Firestone_BagId   == bagId then self.Firestone_IsAvailable   = false end
		if self.Spellstone_BagId  == bagId then self.Spellstone_IsAvailable  = false end
		if self.Hearthstone_BagId == bagId then self.Hearthstone_IsAvailable = false end
		-- Search the bag that updated
		for i,bag in ipairs(bagsArray) do
			if bagId == bag.id then
				self:_FindStones(bag)
			end
		end
	end
end

function _bh:_FindStones(bag)
	-- Exit if its a known soul bag (which can only store shards) || Parcours des emplacements des sacs
	if not bag.isSoulBag then
		-- Iterate over the bag slots
		for slot = 1,bag.capacity,1 do
			local itemLink = GetContainerItemLink(bag.id, slot)
			-- If there is an item located in that bag slot || Dans le cas d'un emplacement non vide
			if itemLink then
				local itemName = self:GetItemNameFromLink(itemLink)

				-- Check if its a soulstone || Si c'est une pierre d'âme, on note son existence et son emplacement
				if itemName:find(Necrosis.Translation.Item.Soulstone) then
					print("Soulstone found")
					self.Soulstone_IsAvailable = true
					self.Soulstone_Name = itemName
					self.Soulstone_BagId = bag.id
					self.Soulstone_SlotId = slot
					NecrosisConfig.ItemSwitchCombat[4] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SoulstoneUpdateAttribute()
				-- Check if its a healthstone || Même chose pour une pierre de soin
				elseif itemName:find(Necrosis.Translation.Item.Healthstone) then
					self.Healthstone_IsAvailable = true
					self.Healthstone_Name = itemName
					self.Healthstone_BagId = bag.id
					self.Healthstone_SlotId = slot
					NecrosisConfig.ItemSwitchCombat[3] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:HealthstoneUpdateAttribute()
				-- Check if its a spellstone || Et encore pour la pierre de sort
				elseif itemName:find(Necrosis.Translation.Item.Spellstone) then
					self.Spellstone_IsAvailable = true
					self.Spellstone_BagId = bag.id
					self.Spellstone_SlotId = slot
					NecrosisConfig.ItemSwitchCombat[1] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:SpellstoneUpdateAttribute()
				-- Check if its a firestone || La pierre de feu maintenant
				elseif itemName:find(Necrosis.Translation.Item.Firestone) then
					self.Firestone_IsAvailable = true
					self.Firestone_BagId = bag.id
					self.Firestone_SlotId = slot
					NecrosisConfig.ItemSwitchCombat[2] = itemName

					-- Update its button attributes on the sphere || On attache des actions au bouton de la pierre
					Necrosis:FirestoneUpdateAttribute()
				-- Check if its a hearthstone || et enfin la pierre de foyer
				elseif itemName:find(Necrosis.Translation.Item.Hearthstone) then
					self.Hearthstone_IsAvailable = true
					self.Hearthstone_Name = itemName
					self.Hearthstone_BagId = bag.id
					self.Hearthstone_SlotIdId = slot
				end
			end
		end
	end
end

function _bh:GetItemNameFromLink(link)
	-- local s = gsub(link, "\124", "\124\124")
	-- print(s)
	local i = string.find(link, "[", 1, true)
	local j = string.find(link, "]", i, true)
	if (i < j) then
		return string.sub(link, i+1, j-1)
	else
		return nil
	end
end

function _bh:DestroyShards(maxToKeep)
	for i,bag in ipairs(self:GetPlayerBags()) do

		-- Skip soul bags
		if not bag.isSoulBag then

			-- Iterate over the bag slots
			for slot = 1,bag.capacity,1 do
				if maxToKeep >= self.Soulshard_Count then
					break
				end
				if self:TryDestroyShard(bag.id, slot) then
					self.Soulshard_Count = GetItemCount(Constants.Soulshard_Item_Id)
				end
			end
		end
	end
end

function _bh:TryDestroyShard(bagId, slot)
	local itemId = GetContainerItemID(bagId, slot)
	if (itemId == Constants.Soulshard_Item_Id) then
		PickupContainerItem(bagId, slot)
		if (CursorHasItem()) then
			DeleteCursorItem()
			return true
		end
	end
	return false
end
