--- STEAMODDED HEADER
--- MOD_NAME: Bullseye Jokers
--- MOD_ID: bullseye
--- MOD_AUTHOR: [skpacman]
--- MOD_DESCRIPTION: Adds Bullseye and Double Bullseye Jokers
--- BADGE_COLOUR: c20000
--- DISPLAY_NAME: Bullseye Jokers
--- PREFIX: bullseye
--- VERSION: 0.6.1
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-0812d]

----------------------------------------------
------------MOD CODE--------------------------

SMODS.load_file("functions.lua")()

SMODS.Atlas {
	key = "bullseye",
	path = "bullseye.png",
	px = 71,
	py = 95
}

SMODS.Joker({
	key = 'single',
	loc_txt = {
		name = 'Bullseye',
		text = {
			"Hit the target, Win a Prize!",
			"{s:0.6,c:gray}(Round Score & Blind Score Requirement MUST MATCH EXACTLY){}",
			"{s:0.6,c:gray}Single Bullseye gives $50, a random tag, a random voucher, a random negative joker, or a random negative planet.{}",
			"{s:0.6,c:gray}Double Bullseye gives $100 AND a random tag, a random voucher, a random negative joker, or a random negative planet.{}",
		}
	},
	config = {
		d_size = 0,
		extra = {
			hcount = 0,
			loc_texts = {"", "", nil},
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.d_size,
				card.ability.extra.hand_count,
				card.ability.extra.loc_texts,
			}
		}
	end,
	rarity = 2,
	atlas = 'bullseye',
	pos = { x = 0, y = 0 },
	cost = 5,
	unlocked = true,
	discovered = false,
	eternal_compat = true,
	perishable_compat = true,
	blueprint_compat = false,
	calculate = function(self, card, context)
		local singlePrizes = {"dollars","voucher","tag","planet","joker","tarot","spectral"}
		local doublePrizes = {"voucher","tag","planet","joker","tarot","spectral"}
		if context.joker_main and not context.end_of_round and context.cardarea == G.jokers then card.ability.extra.hcount = card.ability.extra.hcount + 1 end
		if context.end_of_round and context.cardarea == G.jokers then
			if G.GAME.blind.chips == G.GAME.chips then
				if card.ability.extra.hcount >= 2 then
					local randomSingle = singlePrizes[math.random(#singlePrizes)]
					card.ability.extra.hcount = 0
					if randomSingle == "voucher" then
						local spawned_tag = spawn_tag(self, card, context, "tag_voucher")
						if spawned_tag == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Voucher!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Voucher but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Voucher but something went wrong..." }
							}
						end
					elseif randomSingle == "dollars" then
						return {
							message = "Bullseye!",
							extra = { message = "You Won $50!" },
							dollars = 50;
						}
					elseif randomSingle == "tag" then
						local spawned_tag = spawn_tag(self, card, context, nil)
						if spawned_tag == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tag!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tag but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tag but something went wrong..." }
							}
						end
					elseif randomSingle == "planet" then
						local spawned_planet = spawn_planet(self, card, context, nil)
						if spawned_planet == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Planet Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Planet Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Planet Card but something went wrong..." }
							}
						end
					elseif randomSingle == "joker" then
						local spawned_joker = spawn_joker(self, card, context, nil)
						if spawned_joker == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Joker Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Joker Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Joker Card but something went wrong..." }
							}
						end
					elseif randomSingle == "tarot" then
						local spawned_tarot = spawn_tarot(self, card, context, nil)
						if spawned_tarot == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tarot Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tarot Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Tarot Card but something went wrong..." }
							}
						end
					elseif randomSingle == "spectral" then
						local spawned_spectral = spawn_spectral(self, card, context, nil)
						if spawned_spectral == true then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Spectral Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Spectral Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								message = "Bullseye!",
								extra = { message = "You Won a Random Spectral Card but something went wrong..." }
							}
						end
					end
				elseif card.ability.extra.hcount == 1 then
					local randomDouble = doublePrizes[math.random(#doublePrizes)]
					card.ability.extra.hcount = 0
					if randomDouble == "voucher" then
						local spawned_tag = spawn_tag(self, card, context, "tag_voucher")
						if spawned_tag == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Voucher!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Voucher but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Voucher but something went wrong..." }
							}
						end
					elseif randomDouble == "tag" then
						local spawned_tag = spawn_tag(self, card, context, nil)
						if spawned_tag == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tag!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tag but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tag but something went wrong..." }
							}
						end
					elseif randomDouble == "planet" then
						local spawned_planet = spawn_planet(self, card, context, nil)
						if spawned_planet == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Planet Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Planet Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Planet Card but something went wrong..." }
							}
						end
					elseif randomDouble == "joker" then
						local spawned_joker = spawn_joker(self, card, context, nil)
						if spawned_joker == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Joker Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Joker Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Joker Card but something went wrong..." }
							}
						end
					elseif randomDouble == "tarot" then
						local spawned_tarot = spawn_tarot(self, card, context, nil)
						if spawned_tarot == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tarot Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tarot Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Tarot Card but something went wrong..." }
							}
						end
					elseif randomDouble == "spectral" then
						local spawned_spectral = spawn_spectral(self, card, context, nil)
						if spawned_spectral == true then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Spectral Card!" }
							}
						elseif spawned_tag == "noRoom" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Spectral Card but there was no room!" }
							}
						elseif spawned_tag == "badKey" then
							return {
								dollars = 100,
								message = "Bullseye!",
								extra = { message = "You Won $100 AND a Random Spectral Card but something went wrong..." }
							}
						end
					end
				end
			end 
		end
		if context.end_of_round and context.cardarea == G.jokers then card.ability.extra.hcount = 0 end
	end
})

----------------------------------------------
------------MOD CODE END----------------------
