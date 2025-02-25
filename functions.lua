--[[
Bullseye mod for Balatro
functions.lua
Used for spawning tags and cards
Dollars are handled separately in Bullseye.lua
This file inherits Bullseye.lua's Version #
--]]

function spawn_tag(self, card, context, tagkey)
	if tagkey then
		add_tag(Tag(tagkey))
		return true
	else
		local tagPool = get_current_pool("Tag", nil, nil, append)
		local filteredTags = {}
		for key, value in pairs(tagPool) do
			if value ~= "UNAVAILABLE" then
				table.insert(filteredTags, value)
			end
		end
		local randomTag = filteredTags[math.random(#filteredTags)]
		add_tag(Tag(randomTag))
		return true
	end
end

-- Helper to handle common spawn logic for Joker, Planet, Tarot, and Spectral cards.
local function spawn_card(setName, poolName, area, providedKey)
	if providedKey then
		if #area.cards < area.config.card_limit then
			SMODS.add_card({
				set = setName,
				key = providedKey,
				area = area
			})
			return true
		else
			return "noRoom"
		end
	else
		if #area.cards < area.config.card_limit then
			local pool = get_current_pool(poolName, nil, nil, append)
			for k, v in pairs(pool) do
				if v == "UNAVAILABLE" then pool[k] = nil end
			end
			local keys = {}
			for _, v in pairs(pool) do
				table.insert(keys, v)
			end
			local randomKey = keys[math.random(#keys)]
			SMODS.add_card({
				set = setName,
				key = randomKey,
				area = area
			})
			return true
		else
			return "noRoom"
		end
	end
end

function spawn_joker(self, card, context, jokerKey)
	return spawn_card("Joker", "Joker", G.jokers, jokerKey)
end

function spawn_planet(self, card, context, planetKey)
	return spawn_card("Consumeable", "Planet", G.consumeables, planetKey)
end

function spawn_tarot(self, card, context, tarotKey)
	return spawn_card("Consumeable", "Tarot", G.consumeables, tarotKey)
end

function spawn_spectral(self, card, context, spectralKey)
	return spawn_card("Consumeable", "Spectral", G.consumeables, spectralKey)
end
