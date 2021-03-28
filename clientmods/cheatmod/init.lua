spam =
{
	msg = "",
	timer = 0,
	freq = 5,
}

oredetect =
{
	radius = 30,
	huds = {},
}

ignore =
{
	pos = false,
	yaw = false,
	hp = false,
	breath = false,
	death_screen = false,
	spawn_particle = false,
	add_particle_spawner = false,
	set_sky = false,
	override_daynightratio = false,
	time_of_day = false,
}

automatization =
{
	enabled = false,
	punch = false,
	rc = false,
	activate = false,
	use = false,
	punchentities = false,
}

ctf =
{
	autoflag = false,
	autoheal = false,
	need_parse_sform = false,
	need_close_form = false,
}

tp = {}

misc = {}

no_debug_trash = true


local zoom = 0


local gc_timer = 0

lp = minetest.localplayer

main_cheatgui = nil


function dbgmsg(msg)
	if no_debug_trash then
		return
	end
	minetest.debug(msg)
end

function dbgprint(msg)
	if no_debug_trash then
		return
	end
	print(msg)
end


minetest.after(1,
	function()
		lp = minetest.localplayer
	end
)



local inside_the_box =
{
	"boxes:pedestal",
	"nodes:chest_with_boxes_nexus",
	"terminal:terminal",
	"doors:door_steel_a",
}

local inside_the_box_colors =
{
	0xff7800,
	0xf00,
	0xf7ff00,
	0x2cff00,
}


local chests =
{
	"tsm_chests:chest",
	"default:chest",
	"bones:bones",
	"bonusbox:chest",
	"digtron:inventory",
	"technic:iron_chest",
	"technic:copper_chest",
	"technic:gold_chest",
	"technic:mithril_chest",
	"technic:silver_chest",
}

local chests_colors =
{
	0xac6304,
	0xac6304,
	0xf00,
	0x777070,
	0xa6a6a6,
	0xc8750a,
	0xfafb7c,
	0x2c4df1,
	0xc8750a,
}



local expensive_ores = {
    "moreores:mineral_mithril",
    "default:stone_with_diamond",
    "default:stone_with_mese",
	"default:mese",
	"ethereal:etherium_ore",
}

local expensive_ores_colors = {
    0x2c4df1,
    0x9ee5ff,
    0xfdff00,
	0xfdff00,
	0xf4f276,
}



local ores = 
{
	"default:stone_with_coal",
	"default:stone_with_mese",
	"default:stone_with_diamond",
	"default:stone_with_iron",
	"default:stone_with_copper",
	"default:stone_with_gold",
    "default:stone_with_tin",
    "moreores:mineral_mithril",
    "moreores:mineral_silver",
    "technic:mineral_zinc",
    "technic:mineral_uranium",
    "technic:mineral_sulfur",
    "technic:mineral_lead",
    "technic:mineral_chromium",
    "ethereal:etherium_ore",
    "default:mese",
}

local ores_colores =
{
	0x000000,
	0xfdff00,
	0x9ee5ff,
	0x907217,
	0xffa700,
	0xfafb7c,
	0xffffff,
	0x2c4df1,
	0xd6d6cb,
	0xc5fffe,
	0x2fff00,
	0xfdff00,
	0xd2d2d2,
	0xffffff,
	0xDD0000,
	0xfdff00,
}



local multisraft_ores = 
{
	"default:stone_with_diamond",
	"default:stone_with_emerald",
	"default:glowstone",
	"default:stone_with_bluestone",
	"bonusbox:chest",
}
local multisraft_ores_colors = 
{
	0x9ee5ff,
	0x0be122,
	0xffe300,
	0x2c4df1,
	0xf00,
}



local function ores_dig(ore_arr)
	local ore_pos = {}
	local i = 1
	while i <= #ore_arr do
		ore_pos = minetest.find_node_near(lp:get_pos(), oredetect.radius, ore_arr[i], true)
		if ore_pos then
			minetest.dig_node(ore_pos)
			dbgmsg("digged " .. ore_arr[i] .. " at pos " .. minetest.pos_to_string(ore_pos))
		end
		i = i + 1
	end

end



minetest.register_chatcommand("dig_d", {
	params = "",
	description = "digs ore from the 'ores' array",
	func = function()
		ores_dig(ores)
		return true
	end,
})

minetest.register_chatcommand("dig_ed", {
	params = "",
	description = "digs ore from the 'expensive_ores' array",
	func = function()
		ores_dig(expensive_ores)
		return true
	end,
})

minetest.register_chatcommand("dig_msd", {
	params = "",
	description = "digs ore from the 'multisraft_ores' array",
	func = function()
		ores_dig(multisraft_ores)
		return true
	end,
})

minetest.register_chatcommand("dig_dmsd", {
	params = "",
	description = "digs ore from the 'multisraft_ores' and 'ores' arrays",
	func = function()
		ores_dig(multisraft_ores)
		ores_dig(ores)
		return true
	end,
})

minetest.register_chatcommand("dig_md", {
	params = "",
	description = "digs mithril",
	func = function()
		ores_dig({"moreores:mineral_mithril"})
		return true
	end,
})



function oredetect.search(ore, color)
	local ore_pos = minetest.find_node_near(lp:get_pos(), oredetect.radius, ore, true)
	if ore_pos then
		dbgmsg(ore .. " found in pos " .. minetest.pos_to_string(ore_pos))
		if oredetect.huds[ore] then
			lp:hud_remove(oredetect.huds[ore])
			dbgmsg("removed" .. oredetect.huds[ore])
			oredetect.huds[ore] = nil
		end
		oredetect.huds[ore] = lp:hud_add({
			hud_elem_type = "waypoint",
			number = color,
			name = ore,
			text = ore,
			world_pos = ore_pos
		})
	else
		dbgmsg(ore .. " not found")
		if oredetect.huds[ore] then
			lp:hud_remove(oredetect.huds[ore])
			dbgmsg("removed" .. oredetect.huds[ore])
			oredetect.huds[ore] = nil
		end
	end
end



minetest.register_chatcommand("d", {
	params = "",
	description = "finds ores from the 'ores' array",
	func = function()
		local i = 1
		while i <= #ores do
			oredetect.search(ores[i], ores_colores[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("itbd", {
	params = "",
	description = "finds ores from the 'ores' array",
	func = function()
		local i = 1
		while i <= #inside_the_box do
			oredetect.search(inside_the_box[i], inside_the_box_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("ed", {
	params = "",
	description = "finds ores from the 'expensive_ores' array",
	func = function()
		local i = 1
		while i <= #expensive_ores do
			oredetect.search(expensive_ores[i], expensive_ores_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("chests", {
	params = "",
	description = "finds chests from the 'chests' array",
	func = function()
		local i = 1
		while i <= #chests do
			oredetect.search(chests[i], chests_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("msd", {
	params = "",
	description = "finds ores from the 'multisraft_ores' array",
	func = function()
		local i = 1
		while i <= #multisraft_ores do
			oredetect.search(multisraft_ores[i], multisraft_ores_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("dmsd", {
	params = "",
	description = "finds ores from the 'multisraft_ores' and 'ores' arrays",
	func = function()
		local i = 1
		while i <= #multisraft_ores do
			oredetect.search(multisraft_ores[i], multisraft_ores_colors[i])
			i = i + 1
		end
		i = 1
		while i <= #ores do
			oredetect.search(ores[i], ores_colores[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("md", {
	params = "",
	description = "finds mithril",
	func = function()
		oredetect.search("moreores:mineral_mithril", 0x2c4df1)
		return true
	end,
})



function oredetect.cleanuphuds(names_array)
	local i = 1
	while i <= #names_array do
		if oredetect.huds[names_array[i]] then
			lp:hud_remove(oredetect.huds[names_array[i]])
			oredetect.huds[names_array[i]] = nil
		end
		i = i + 1
	end
end
local function ores_dig(ore_arr)
	local ore_pos = {}
	local i = 1
	while i <= #ore_arr do
		ore_pos = minetest.find_node_near(lp:get_pos(), oredetect.radius, ore_arr[i], true)
		if ore_pos then
			minetest.dig_node(ore_pos)
			dbgmsg("digged " .. ore_arr[i] .. " at pos " .. minetest.pos_to_string(ore_pos))
		end
		i = i + 1
	end

end



minetest.register_chatcommand("dig_d", {
	params = "",
	description = "digs ore from the 'ores' array",
	func = function()
		ores_dig(ores)
		return true
	end,
})

minetest.register_chatcommand("dig_ed", {
	params = "",
	description = "digs ore from the 'expensive_ores' array",
	func = function()
		ores_dig(expensive_ores)
		return true
	end,
})

minetest.register_chatcommand("dig_msd", {
	params = "",
	description = "digs ore from the 'multisraft_ores' array",
	func = function()
		ores_dig(multisraft_ores)
		return true
	end,
})

minetest.register_chatcommand("dig_dmsd", {
	params = "",
	description = "digs ore from the 'multisraft_ores' and 'ores' arrays",
	func = function()
		ores_dig(multisraft_ores)
		ores_dig(ores)
		return true
	end,
})

minetest.register_chatcommand("dig_md", {
	params = "",
	description = "digs mithril",
	func = function()
		ores_dig({"moreores:mineral_mithril"})
		return true
	end,
})



function oredetect.search(ore, color)
	local ore_pos = minetest.find_node_near(lp:get_pos(), oredetect.radius, ore, true)
	if ore_pos then
		dbgmsg(ore .. " found in pos " .. minetest.pos_to_string(ore_pos))
		if oredetect.huds[ore] then
			lp:hud_remove(oredetect.huds[ore])
			dbgmsg("removed" .. oredetect.huds[ore])
			oredetect.huds[ore] = nil
		end
		oredetect.huds[ore] = lp:hud_add({
			hud_elem_type = "waypoint",
			number = color,
			name = ore,
			text = ore,
			world_pos = ore_pos
		})
	else
		dbgmsg(ore .. " not found")
		if oredetect.huds[ore] then
			lp:hud_remove(oredetect.huds[ore])
			dbgmsg("removed" .. oredetect.huds[ore])
			oredetect.huds[ore] = nil
		end
	end
end



minetest.register_chatcommand("d", {
	params = "",
	description = "finds ores from the 'ores' array",
	func = function()
		local i = 1
		while i <= #ores do
			oredetect.search(ores[i], ores_colores[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("itbd", {
	params = "",
	description = "finds ores from the 'ores' array",
	func = function()
		local i = 1
		while i <= #inside_the_box do
			oredetect.search(inside_the_box[i], inside_the_box_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("ed", {
	params = "",
	description = "finds ores from the 'expensive_ores' array",
	func = function()
		local i = 1
		while i <= #expensive_ores do
			oredetect.search(expensive_ores[i], expensive_ores_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("chests", {
	params = "",
	description = "finds chests from the 'chests' array",
	func = function()
		local i = 1
		while i <= #chests do
			oredetect.search(chests[i], chests_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("msd", {
	params = "",
	description = "finds ores from the 'multisraft_ores' array",
	func = function()
		local i = 1
		while i <= #multisraft_ores do
			oredetect.search(multisraft_ores[i], multisraft_ores_colors[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("dmsd", {
	params = "",
	description = "finds ores from the 'multisraft_ores' and 'ores' arrays",
	func = function()
		local i = 1
		while i <= #multisraft_ores do
			oredetect.search(multisraft_ores[i], multisraft_ores_colors[i])
			i = i + 1
		end
		i = 1
		while i <= #ores do
			oredetect.search(ores[i], ores_colores[i])
			i = i + 1
		end
		return true
	end,
})

minetest.register_chatcommand("md", {
	params = "",
	description = "finds mithril",
	func = function()
		oredetect.search("moreores:mineral_mithril", 0x2c4df1) 
		return true
	end,
})



function oredetect.cleanuphuds(names_array)
	local i = 1
	while i <= #names_array do
		if oredetect.huds[names_array[i]] then
			lp:hud_remove(oredetect.huds[names_array[i]])
			oredetect.huds[names_array[i]] = nil
		end
		i = i + 1
	end
end

minetest.register_chatcommand("cl", {
	params = "",
	description = "removes all oredetect`s HUD",
	func = function()
		oredetect.cleanuphuds(ores)
		oredetect.cleanuphuds(expensive_ores)
		oredetect.cleanuphuds(multisraft_ores)
		oredetect.cleanuphuds(chests)
		oredetect.cleanuphuds(inside_the_box)
		return true
	end,
})



minetest.register_chatcommand("wb", {
    params = "",
    description = "shows the formspec of the workbench",
    func = function()
        minetest.show_formspec("wb", "size[9,9]" .. "list[current_player;craft;2,0.5;3,3;]" .. "list[current_player;craftpreview;7,1.5;1,1;]" .. "list[current_player;main;0,5;9,5;]")
    end,
})


minetest.register_chatcommand("sr", {
    params = "",
    description = "sets the oredetect`s radius",
    func = function()
		minetest.show_formspec("srform", 
			"formspec_version[3]" .. 
			"size[3,3]" .. 
			"field[0.5,0.5;2,0.8;radius;radius;" .. oredetect.radius .. "]" .. 
			"button_exit[0.7,2;1.5,0.8;exit;set!]")        
	end,
})

minetest.register_chatcommand("sz", {
    params = "",
    description = "sets zoom",
    func = function()
		minetest.show_formspec("zoomform",
                "formspec_version[3]" .. 
                "size[3,3]" ..
                "field[0.5,0.5;2,0.8;zoom;zoom;" .. zoom .. "]" ..
                "button_exit[0.7,2;1.5,0.8;exit;set!]")
    end,
})

function ctf.unlock_players_props()
	local players = minetest.get_player_names()
	local i = 1
	if players ~= nil then
		while i <= #players do
			minetest.get_cao_by_name(players[i]):ignore_props(false)
			i = i + 1
		end
	end
end
function ctf.parse_sform()
	local players = minetest.get_player_names()
	local sform = minetest.localplayer:get_formspec()
	if sform == nil or sform == "" or sform:find(minetest.localplayer:get_name()) == nil then
		dbgmsg("form get error")
		return
	else
		local i = 1
		while i <= #players do
			local namepos = sform:find(players[i])
			if namepos ~= nil then
				local anotheri = 1
				local sform_symbol = ""
				while sform_symbol ~= "#" do
					anotheri = anotheri + 1
					sform_symbol = sform:sub(namepos  - anotheri, namepos - anotheri)
				end
				local cao = minetest.get_cao_by_name(players[i])
				cao:ignore_props(true)
				if sform:sub(namepos - anotheri + 1, namepos - anotheri + 1) == "4" then
					cao:set_nametag_attributes(
					{
						color = 0x4466FF,
						text = cao:get_entity_name(),
					})
				elseif sform:sub(namepos - anotheri + 1, namepos - anotheri + 1) == "F" then
					cao:set_nametag_attributes(
					{
						color = 0xFF4444,
						text = cao:get_entity_name(),
					})
				else
					cao:set_nametag_attributes(
					{
						color = 0x00ff1c,
						text = cao:get_entity_name(),
					})
				end
			else
				dbgprint(players[i] .. " : " .. "nil pos in string")
			end
			i = i + 1
		end
		ctf.need_parse_sform = false
		ctf.need_close_form = not minetest.close_formspec()
	end
	if ctf.need_close_form then
		ctf.need_close_form = not minetest.close_formspec()
	end
end


minetest.register_on_formspec_input(function(formname, fields)
	if formname == "srform" then
		if tonumber(fields.radius) ~= nil then
			oredetect.radius = tonumber(fields.radius)
		else
			print("invalid radius")
		end
		return true
	end
	if formname == "zoomform" then
		if tonumber(fields.zoom) ~= nil then
			zoom = tonumber(fields.zoom)
			lp:set_zoom(zoom)
			minetest.set_ignore_zoom(true)
		else
			print("invalid zoom")
		end
		return true
	end
	return false
end)



minetest.register_globalstep(function(dtime)
	if automatization.punchentities then
		local objects_in_radius = minetest.get_cao_inside_radius(lp:get_pos(), oredetect.radius)
		for Count = 1, #objects_in_radius do
			if not objects_in_radius[Count]:is_LocalPlayer() then
				objects_in_radius[Count]:punch()
			end
		end
	end

	if ctf.autoflag then
		local flagpos = minetest.find_node_near(lp:get_pos(), 10, "ctf_flag:flag", true)
		if flagpos == nil then
			return
		end
		minetest.dig_node(flagpos)
		dbgprint("flag activated")
	end

	if automatization.enable then
		if automatization.rc then
			lp:right_click()
		end
		if automatization.punch then
			lp:punch()
		end
		if automatization.use then
			lp:use_on()
		end
		if automatization.activate then
			lp:activate()
		end
	end

	spam.timer = spam.timer + dtime
	if spam.timer >= spam.freq then
		if spam.msg and spam.msg ~= "" then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, spam.msg)
		end
		spam.timer = 0
	end

	gc_timer = gc_timer + dtime
	if gc_timer >= 60 then
		collectgarbage()
		gc_timer = 0
	end

	if ctf.need_parse_sform == true then
		ctf.parse_sform()
	end

end)


minetest.register_chatcommand("ignore_pos", {
    params = "",
    description = "switches ignoring the pos sent from the server",
    func = function()
		ignore.pos = not ignore.pos
		minetest.localplayer:set_ignore_serversend_pos(ignore.pos)
	end,
})

minetest.register_chatcommand("ignore_yaw", {
    params = "",
    description = "switches ignoring the yaw and pitch sent from the server",
    func = function()
		ignore.yaw = not ignore.yaw
		minetest.localplayer:set_ignore_serversend_yaw_and_pitch(ignore.yaw)
	end,
})

minetest.register_chatcommand("ignore_hp", {
    params = "",
    description = "switches ignoring the hp sent from the server",
    func = function()
		ignore.hp = not ignore.hp
		minetest.set_ignore_hp(ignore.hp)
	end,
})

minetest.register_chatcommand("ignore_breath", {
    params = "",
    description = "switches ignoring the breath sent from the server",
    func = function()
		ignore.breath = not ignore.breath
		minetest.set_ignore_breath(ignore.breath)
	end,
})

minetest.register_chatcommand("ignore_add_ps", {
    params = "",
    description = "switches ignoring add_particle_spawner sent from the server",
    func = function()
		ignore.add_particle_spawner = not ignore.add_particle_spawner
		minetest.set_ignore_add_particle_spawner(ignore.add_particle_spawner)
	end,
})

minetest.register_chatcommand("ignore_sp", {
    params = "",
    description = "switches ignoring spawn_particle sent from the server",
    func = function()
		ignore.spawn_particle = not ignore.spawn_particle
		minetest.set_ignore_spawn_particle(ignore.spawn_particle)
	end,
})

minetest.register_chatcommand("ignore_ds", {
    params = "",
    description = "switches ignoring the death_screen sent from the server",
    func = function()
		ignore.death_screen = not ignore.death_screen
		minetest.set_ignore_death_screen(ignore.death_screen)
	end,
})

minetest.register_chatcommand("ignore_setsky", {
    params = "",
    description = "switches ignoring set_sky sent from the server",
    func = function()
		ignore.set_sky = not ignore.set_sky
		minetest.set_ignore_set_sky(ignore.set_sky)
	end,
})

minetest.register_chatcommand("ctf", {
    params = "",
    description = "toggles autopunching flag in the CTF",
    func = function()
		ctf.autoflag = not ctf.autoflag
	end,
})

minetest.register_chatcommand("automatization.punchentities", {
	description = "toggles autopunch entities around",
    params = "",
    func = function()
		automatization.punchentities = not automatization.punchentities
	end,
})

minetest.register_chatcommand("ctf_autoheal", {
    description = "switches autouse on itself ctf_bandages(selfhealing)",
    params = "",
    func = function()
		ctf.autoheal = not ctf.autoheal
	end,
})

minetest.register_chatcommand("tod", {
    description = "sets the time of day",
    params = "<time_of_day>",
    func = function(param)
		param = tonumber(param)
		if param ~= nil and param >= 0 and param <= 1 then
			dbgmsg("timeof day was: " .. minetest.get_timeofday())
			minetest.set_timeofday(param)
			ignore.time_of_day = true
			minetest.set_ignore_timeofday(ignore.time_of_day)
			dbgmsg("timeof day now: " .. minetest.get_timeofday())
		else
			print("invalid timeofday")
		end
	end,
})

minetest.register_chatcommand("respawn", {
    params = "",
    description = "respawns the localplayer",
    func = function()
		lp:respawn()
	end,
})

minetest.register_chatcommand("punch", {
    description = "punches the localplayer",
    params = "",
    func = function()
		lp:punch()
	end,
})

minetest.register_chatcommand("right_click", {
	description = "right_click the localplayer",
	params = "",
    func = function()
		lp:right_click()
	end,
})

minetest.register_chatcommand("activate", {
	description = "activates the localplayer",
    params = "",
    func = function()
		lp:activate()
	end,
})

minetest.register_chatcommand("use_on", {
	description = "uses wielded item on the localplayer",
    params = "",
    func = function()
		lp:use_on()
	end,
})

minetest.register_chatcommand("set_hp", {
	description = "sets the localplayer`s hp",
    params = "<hp>",
    func = function(param)
		if not param ~= nil then
			lp:set_hp(tonumber(param))
			dbgmsg("hp seted to" .. param)
		else
			print("invalid hp")
		end
	end,
})

minetest.register_chatcommand("spammsg", {
    params = "<msg>",
    description = "sets the spam.msg",
    func = function(param)
		if param ~= nil then
			spam.msg = param
		else
			spam.msg = ""
		end
		dbgmsg("spammsg now: " .. spam.msg) 
	end,
})

minetest.register_chatcommand("set_spamf", {
    params = "<spam_frequency>",
    description = "sets the frequency of spam",
    func = function(param)
		if not param ~= nil then
			spam.freq = tonumber(param)
		end
		dbgmsg("spamfreq now: " .. spam.freq)
	end,
})

minetest.register_chatcommand("set_breath", {
    params = "<breth>",
    description = "sets the localplayer`s breath",
    func = function(param)
		if not param ~= nil then
			lp:set_breath(tonumber(param))
			dbgmsg("breath seted to" .. param)
		end
	end,
})

minetest.register_chatcommand("automatization", {
    description = "switches the automatization*`s status",
    params = "",
    func = function()
		automatization.enabled = not automatization.enabled
	end,
})

minetest.register_chatcommand("automatization.rc", {
    params = "",
    description = "switches the automatization.rightclick`s status",
    func = function()
		automatization.rc = not automatization.rc
	end,
})

minetest.register_chatcommand("automatization.punch", {
    params = "",
    description = "switches the automatization.punch`s status",
    func = function()
		automatization.punch = not automatization.punch
	end,
})

minetest.register_chatcommand("automatization.use", {
    description = "switches the automatization.use`s status",
    params = "",
    func = function()
		automatization.use = not automatization.use
	end,
})

minetest.register_chatcommand("automatization.activate", {
    params = "",
    description = "switches the automatization.activate`s status",
    func = function()
		automatization.activate = not automatization.activate
	end,
})

minetest.register_chatcommand("ndt", {
    params = "",
    description = "switches showing debug text",
    func = function()
		no_debug_trash = not no_debug_trash
	end,
})

minetest.register_chatcommand("ctf_nc", {
    description = "colorizes nametags in ctf",
    params = "",
    func = function()
		ctf.unlock_players_props()
		minetest.send_chat_message("/s")
		ctf.need_parse_sform = true
	end,
})

minetest.register_on_hp_modification(function(hp)
	if ctf.autoheal then
		if lp:get_wielded_item():get_name() == "ctf_bandages:bandage" and lp:get_hp() < 15 then
			lp:use_on()
		end
	end
end)

minetest.register_chatcommand("ni", {
    description = "interact with nodes",
    params = "<d|p|a|u> <x+|x-|y+|y-|z+|z-> <number_of_blocks>",
    func = function(param)
		local action = param:sub(1, 1) 
		local direction =  param:sub(3, 4)
		local number_of_blocks = tonumber(param:sub(6, #param))
		if direction ~= nil and action ~= nil and number_of_blocks ~= nil and number_of_blocks > 0 then
			local i = 0
			local pos = lp:get_pos()
			local tmppos = pos
			number_of_blocks = number_of_blocks + 1
			if action == "d" then
				action = minetest.dig_node
			elseif action == "p" then
				action = minetest.place_node
			elseif action == "a" then
				action = minetest.activate_node
			elseif action == "u" then
				action = minetest.use_on
			else
				action = minetest.dig_node
				print("invalid action. digging.")
			end
			if direction == "x+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.x = tmppos.x + i
					i = i + 1
				end
			elseif direction == "x-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.x = tmppos.x - i
					i = i + 1
				end
			elseif direction == "y+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + i
					i = i + 1
				end
			elseif direction == "y-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y - i
					i = i + 1
				end
			elseif direction == "z+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.z = tmppos.z + i
					i = i + 1
				end
			elseif direction == "z-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.z = tmppos.z - i
					i = i + 1
				end
			else
				print("invalid direction")
			end
		else
			print("invalid param")
		end
	end,
})

minetest.register_chatcommand("tni", {
    description = "interact with nodes(tunnel)",
    params = "<d|p|a|u> <x+|x-|y+|y-|z+|z-> <number_of_blocks>",
    func = function(param)
		local action = param:sub(1, 1) 
		local direction =  param:sub(3, 4)
		local number_of_blocks = tonumber(param:sub(6, #param))
		if direction ~= nil and action ~= nil and number_of_blocks ~= nil and number_of_blocks > 0 then
			local i = 0
			local pos = lp:get_pos()
			local tmppos = pos
			number_of_blocks = number_of_blocks + 1
			if action == "d" then
				action = minetest.dig_node
			elseif action == "p" then
				action = minetest.place_node
			elseif action == "a" then
				action = minetest.activate_node
			elseif action == "u" then
				action = minetest.use_on
			else
				action = minetest.dig_node
				print("invalid action. digging.")
			end
			if direction == "x+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + 1
					action(tmppos)
					tmppos.y = tmppos.y - 1
					tmppos.x = tmppos.x + i
					i = i + 1
				end
			elseif direction == "x-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + 1
					action(tmppos)
					tmppos.y = tmppos.y - 1
					tmppos.x = tmppos.x - i
					i = i + 1
				end
			elseif direction == "y+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + i
					i = i + 1
				end
			elseif direction == "y-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y - i
					i = i + 1
				end
			elseif direction == "z+" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + 1
					action(tmppos)
					tmppos.y = tmppos.y - 1
					tmppos.z = tmppos.z + i
					i = i + 1
				end
			elseif direction == "z-" then
				while i <= number_of_blocks do
					action(tmppos)
					tmppos.y = tmppos.y + 1
					action(tmppos)
					tmppos.y = tmppos.y - 1
					tmppos.z = tmppos.z - i
					i = i + 1
				end
			else
				print("invalid direction")
			end
		else
			print("invalid param")
		end
	end,
})

minetest.register_chatcommand("dmg", {
	description = "damages the localplayer",
    params = "<dmg>",
    func = function(param)
		if not param ~= nil then
			minetest.send_damage(tonumber(param))
			dbgmsg("localplayer damaged: " .. param)
		else
			print("invalid dmg")
		end
	end,
})


dofile(minetest.get_modpath(minetest.get_current_modname()) .. "xp_farm.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()) .. "cheatgui.lua")
