--- STEAMODDED HEADER
--- MOD_NAME: Bullseye Jokers
--- MOD_ID: bullseye
--- MOD_AUTHOR: [skpacman]
--- MOD_DESCRIPTION: Adds Bullseye and Double Bullseye Jokers
--- BADGE_COLOUR: c20000
--- DISPLAY_NAME: Bullseye Jokers
--- PREFIX: bullseye
--- VERSION: 0.7.0
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
			"{s:0.6,c:gray}(Round Score MUST MATCH Blind Score Requirement EXACTLY){}",
		}
	},
	config = {
		d_size = 0,
		extra = {
			hcount = 0,  -- This tracks the hand count
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
		-- Increase hand count during the round if conditions are met
		if context.joker_main and not context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.hcount = card.ability.extra.hcount + 1 
		end

		-- Process end-of-round prize if in the jokers area and blind chips match chips
		if context.end_of_round and context.cardarea == G.jokers then
			if G.GAME.blind.chips == G.GAME.chips then
				-- Helper to handle prize spawning, logging, and message formatting
				local function processPrize(prize, isSingle)
					local spawnFn, param, baseMsg
					if prize == "voucher" then
						spawnFn = spawn_tag; param = "tag_voucher"
						baseMsg = isSingle and "You Won a Random Voucher!" or "You Won $100 AND a Random Voucher!"
					elseif prize == "tag" then
						spawnFn = spawn_tag; param = nil
						baseMsg = isSingle and "You Won a Random Tag!" or "You Won $100 AND a Random Tag!"
					elseif prize == "planet" then
						spawnFn = spawn_planet; param = nil
						baseMsg = isSingle and "You Won a Random Planet Card!" or "You Won $100 AND a Random Planet Card!"
					elseif prize == "joker" then
						spawnFn = spawn_joker; param = nil
						baseMsg = isSingle and "You Won a Random Joker Card!" or "You Won $100 AND a Random Joker Card!"
					elseif prize == "tarot" then
						spawnFn = spawn_tarot; param = nil
						baseMsg = isSingle and "You Won a Random Tarot Card!" or "You Won $100 AND a Random Tarot Card!"
					elseif prize == "spectral" then
						spawnFn = spawn_spectral; param = nil
						baseMsg = isSingle and "You Won a Random Spectral Card!" or "You Won $100 AND a Random Spectral Card!"
					end

					-- Log the prize award attempt
					print(string.format("[Bullseye] Prize: %s %s", (isSingle and "Single" or "Double"), prize))
					
					local result = spawnFn(self, card, context, param)
					if result == true then
						local res = { message = "Bullseye!", extra = { message = baseMsg } }
						if not isSingle then res.dollars = 100 end
						return res
					elseif result == "noRoom" then
						-- Log noRoom detection
						print(string.format("[Bullseye] Prize: %s %s - no room", (isSingle and "Single" or "Double"), prize))
						local noRoomMsg = baseMsg:gsub("!", " but there was no room!")
						local res = { message = "Bullseye!", extra = { message = noRoomMsg } }
						if not isSingle then res.dollars = 100 end
						return res
					end
				end

				-- Process based on hand count
				if card.ability.extra.hcount >= 2 then
					local singlePrizes = {"dollars", "voucher", "tag", "planet", "joker", "tarot", "spectral"}
					local prize = singlePrizes[math.random(#singlePrizes)]
					card.ability.extra.hcount = 0
					if prize == "dollars" then
						-- Log dollars prize
						print("[Bullseye] Prize: Single dollars")
						return { dollars = 50, message = "Bullseye!", extra = { message = "You Won $50!" } }
					else
						return processPrize(prize, true)
					end
				elseif card.ability.extra.hcount == 1 then
					local doublePrizes = {"voucher", "tag", "planet", "joker", "tarot", "spectral"}
					local prize = doublePrizes[math.random(#doublePrizes)]
					card.ability.extra.hcount = 0
					return processPrize(prize, false)
				end
			end 
			-- Reset hand count at end-of-round
			card.ability.extra.hcount = 0
		end
	end
})

----------------------------------------------
------------MOD CODE END----------------------