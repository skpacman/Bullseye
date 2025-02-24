--[[ -- spawn_voucher -- Not used because it's easier to just explicitly spawn tag_voucher
function spawn_voucher(voucher_key)
    if not voucher_key then
        if not get_next_voucher_key then
            return
        end
        voucher_key = get_next_voucher_key(true)
    end
    if not G.P_CENTERS[voucher_key] then
        return
    end
    G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
    local card = Card(
        G.shop_vouchers.T.x + G.shop_vouchers.T.w / 2,
        G.shop_vouchers.T.y,
        G.CARD_W,
        G.CARD_H,
        G.P_CARDS.empty,
        G.P_CENTERS[voucher_key],
        { bypass_discovery_center = true, bypass_discovery_ui = true }
    )
    create_shop_card_ui(card, "Voucher", G.shop_vouchers)
    card.shop_voucher = true
    card:start_materialize()
    G.shop_vouchers:emplace(card)
end
--]]

function spawn_tag(self, card, context, tagkey)
	if tagkey then
		add_tag(Tag(tagkey))
		return true
	elseif not tagkey then
		tagPool = get_current_pool("Tag", nil, nil, append)
		for key, value in pairs(tagPool) do
		  if value == "UNAVAILABLE" then
			tagPool[key] = nil
		  end
		end
		local randomTag = tagPool[math.random(#tagPool)]
		add_tag(Tag(randomTag))
		return true
	else
		return "badKey"
	end
end

function spawn_joker(self, card, context, jokerKey)
	if jokerkey then
		if #G.jokers.cards < G.jokers.config.card_limit then
			SMODS.add_card({
				set = "Joker",
				key = jokerKey,
				area = G.jokers
			})
			return true
		else
			return "noRoom"
		end
	elseif not jokerKey then
		if #G.jokers.cards < G.jokers.config.card_limit then
			jokerPool = get_current_pool("Joker", nil, nil, append)
			for key, value in pairs(jokerPool) do
			  if value == "UNAVAILABLE" then
				jokerPool[key] = nil
			  end
			end
			local randomJoker = jokerPool[math.random(#jokerPool)]
			SMODS.add_card({
				set = "Joker",
				key = randomJoker,
				area = G.jokers
			})
			return true
		else
			return "noRoom"
		end
	else
		return "badKey"
	end
end

function spawn_planet(self, card, context, planetKey)
	if planetKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			SMODS.add_card({
				set = "Consumable",
				key = planetKey,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	elseif not planetKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			planetPool = get_current_pool("Planet", nil, nil, append)
			for key, value in pairs(planetPool) do
			  if value == "UNAVAILABLE" then
				planetPool[key] = nil
			  end
			end
			local randomPlanet = planetPool[math.random(#planetPool)]
			SMODS.add_card({
				set = "Consumable",
				key = randomPlanet,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	else
		return "badKey"
	end
end

function spawn_tarot(self, card, context, tarotKey)
	if tarotKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			SMODS.add_card({
				set = "Tarot",
				key = tarotKey,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	elseif not tarotKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			tarotPool = get_current_pool("Tarot", nil, nil, append)
			for key, value in pairs(tarotPool) do
			  if value == "UNAVAILABLE" then
				tarotPool[key] = nil
			  end
			end
			local randomTarot = tarotPool[math.random(#tarotPool)]
			SMODS.add_card({
				set = "Consumable",
				key = randomTarot,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	else
		return "badKey"
	end
end

function spawn_spectral(self, card, context, spectralKey)
	if spectralKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			SMODS.add_card({
				set = "Spectral",
				key = spectralKey,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	elseif not spectralKey then
		if #G.consumeables.cards < G.consumeables.config.card_limit then
			spectralPool = get_current_pool("Spectral", nil, nil, append)
			for key, value in pairs(spectralPool) do
			  if value == "UNAVAILABLE" then
				spectralPool[key] = nil
			  end
			end
			local randomSpectral = spectralPool[math.random(#spectralPool)]
			SMODS.add_card({
				set = "Consumable",
				key = randomSpectral,
				area = G.consumables
			})
			return true
		else
			return "noRoom"
		end
	else
		return "badKey"
	end
end