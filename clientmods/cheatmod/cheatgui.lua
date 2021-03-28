cheatgui = {}

function cheatgui.cheatgui()
	minetest.show_formspec("cheatgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;5.25,2.2;oredetect;oredetect]" ..
		"button[5.25,0;5.25,2.2;tp;teleport]" ..
		"button[0,2.2;5.25,2.2;ignore;ignore]" ..
		"button[5.25,2.2;5.25,2.2;automatization;automatization]" ..
		"button[0,4.4;5.25,2.2;spam;spam]" ..
		"button[5.25,4.4;5.25,2.2;misc;misc]" ..
		"button[0,6.6;5.25,2.2;ctf;ctf]" ..
		"button[5.25,6.6;5.25,2.2;xp_farm;xp farm]" ..
		"button_exit[0,8.8;10.5,2.2;exit;Close]" ..
	"")
end

function cheatgui.on_formspec_input(formname, fields)
	if formname == "cheatgui" then
		if fields.oredetect then
			oredetect.gui()
		elseif fields.tp then
			tp.gui()
		elseif fields.ignore then
			ignore.gui()
		elseif fields.automatization then
			automatization.gui()
		elseif fields.spam then
			spam.gui()
		elseif fields.misc then
			misc.gui()
		elseif fields.ctf then
			ctf.gui()
		elseif fields.xp_farm then
			xp_farm.gui()
		end
		return true
	else
		return false
	end
end

function oredetect.gui()
	minetest.show_formspec("oredetectgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"label[2.2,0.5;Find]" ..
		"label[7.8,0.5;Dig]" ..
		"button[0,1;5.25,1;d;ores]" ..
		"button[5.25,1;5.25,1;dig_d;ores]" ..
		"button[0,2;5.25,1;ed;expensive_ores]" ..
		"button[5.25,2;5.25,1;dig_ed;expensive_ores]" ..
		"button[0,3;5.25,1;msd;multisraft_ores]" ..
		"button[5.25,3;5.25,1;dig_msd;multisraft_ores]" ..
		"button[0,4;5.25,1;dmsd;multisraft_ores + ores]" ..
		"button[5.25,4;5.25,1;dig_dmsd;multisraft_ores + ores]" ..
		"button[0,5;5.25,1;itbd;inside_the_box]" ..
		"button[0,6;5.25,1;chests;chests]" ..
		"button[5.25,5;5.25,2;dig_md;mithril]" ..
		"button[0,7.2;10.5,0.8;cl;Clean up huds]" ..
		"field[0,8;10.5,0.8;sr;radius;" .. oredetect.radius .. "]" ..
		"button_exit[5.25,9;5.25,2;;Close]" ..
		"button[0,9;5.25,2;back;<-]" ..
	"")
end

function oredetect.on_formspec_input(formname, fields)
	if formname == "oredetectgui" then
		if fields.d then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".d")
		elseif fields.dig_d then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dig_d")
		elseif fields.ed then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".ed")
		elseif fields.dig_ed then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dig_ed")
		elseif fields.msd then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".msd")
		elseif fields.dig_msd then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dig_msd")
		elseif fields.dmsd then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dmsd")
		elseif fields.dig_dmsd then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dig_dmsd")
		elseif fields.itbd then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".itbd")
		elseif fields.chests then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".chests")
		elseif fields.dig_md then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".dig_md")
		elseif fields.cl then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".cl")
		end
		if fields.sr then
			if tonumber(fields.sr) ~= nil then
				oredetect.radius = tonumber(fields.sr)
			end
		end
		if fields.back then
			main_cheatgui()
			return true
		end
		oredetect.gui()
		return true
	end
	return false
end


function tp.gui()
	minetest.show_formspec("tpform",
		"formspec_version[4]" ..
		"size[4,6]" ..
		"field[0.5,0.6;3,0.8;X;X;]" ..
		"field[0.5,2.2;3,0.8;Y;Y;]" ..
		"field[0.5,3.7;3,0.8;Z;Z;]" ..
		"button[0,4.5;2,1.5;back;<-]" ..
		"button_exit[2,4.5;2,1.5;exit;TP!]" ..
	"")
end

function tp.on_formspec_input(formname, fields)
	if formname == "tpform" then
		if fields.X ~= nil and fields.Y ~= nil and fields.Z ~= nil and minetest.string_to_pos("(" .. fields.X .. "," .. fields.Y .. "," .. fields.Z .. ")") ~= nil then
			lp:set_pos(minetest.string_to_pos("(" .. fields.X .. "," .. fields.Y .. "," .. fields.Z .. ")"))
		else
			print("inalid pos")
		end
		if fields.back then
			main_cheatgui()
			return true
		end
		return true
	else
		return false
	end
end

function ignore.gui()
	minetest.show_formspec("ignoregui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;5.25,1.83;pos;pos(" .. minetest.enabled_string_colorized(ignore.pos) .. ")]" ..
		"button[5.25,0;5.25,1.83;yaw;yaw(" .. minetest.enabled_string_colorized(ignore.yaw) .. ")]" ..
		"button[0,1.83;5.25,1.83;hp;hp(" .. minetest.enabled_string_colorized(ignore.hp) .. ")]" ..
		"button[5.25,1.83;5.25,1.83;breath;breath(" .. minetest.enabled_string_colorized(ignore.breath) .. ")]" ..
		"button[0,3.66;5.25,1.83;death_screen;death_screen\n(" .. minetest.enabled_string_colorized(ignore.death_screen) .. ")]" ..
		"button[5.25,3.66;5.25,1.83;spawn_particle;spawn_particle\n(" .. minetest.enabled_string_colorized(ignore.spawn_particle) .. ")]" ..
		"button[0,5.49;5.25,1.83;add_particle_spawner;add_particle_spawner\n(" .. minetest.enabled_string_colorized(ignore.add_particle_spawner) .. ")]" ..
		"button[5.25,5.49;5.25,1.83;set_sky;set_sky\n(" .. minetest.enabled_string_colorized(ignore.set_sky) .. ")]" ..
		"button[0,7.32;5.25,1.83;override_daynightratio;override_daynightratio\n(" .. minetest.enabled_string_colorized(ignore.override_daynightratio) .. ")]" ..
		"button[5.25,7.32;5.25,1.83;time_of_day;time_of_day\n(" .. minetest.enabled_string_colorized(ignore.time_of_day) .. ")]" ..
		"button[0,9.15;5.25,1.9;back;<-]" ..
		"button_exit[5.25,9.15;5.25,1.9;;Close]" ..
	"")
end

function ignore.on_formspec_input(formname, fields)
	if formname == "ignoregui" then
		if fields.pos then
			ignore.pos = not ignore.pos
			lp:set_ignore_serversend_pos(ignore.pos)
		elseif fields.yaw then
			ignore.yaw = not ignore.yaw
			lp:set_ignore_serversend_yaw_and_pitch(ignore.yaw)
		elseif fields.hp then
			ignore.hp = not ignore.hp
			minetest.set_ignore_hp(ignore.hp)
		elseif fields.breath then
			ignore.breath = not ignore.breath
			minetest.set_ignore_breath(ignore.breath)
		elseif fields.death_screen then
			ignore.death_screen = not ignore.death_screen
			minetest.set_ignore_death_screen(ignore.death_screen)
		elseif fields.spawn_particle then
			ignore.spawn_particle = not ignore.spawn_particle
			minetest.set_ignore_spawn_particle(ignore.spawn_particle)
		elseif fields.add_particle_spawner then
			ignore.add_particle_spawner = not ignore.add_particle_spawner
			minetest.set_ignore_add_particle_spawner(ignore.add_particle_spawner)
		elseif fields.set_sky then
			ignore.set_sky = not ignore.set_sky
			minetest.set_ignore_set_sky(ignore.set_sky)
		elseif fields.override_daynightratio then
			ignore.override_daynightratio = not ignore.override_daynightratio
			minetest.set_ignore_override_daynightratio(ignore.override_daynightratio)
		elseif fields.time_of_day then
			ignore.time_of_day = not ignore.time_of_day
			minetest.set_ignore_timeofday(ignore.time_of_day)
		elseif fields.back then
			main_cheatgui()
			return true
		end
		ignore.gui()
		return true
	else
		return false
	end
end

function automatization.gui()
	minetest.show_formspec("automatizationgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;10.5,2.2;enabled;" .. minetest.enabled_string_colorized(automatization.enabled) .. "]" ..
		"button[0,2.2;5.25,2.2;punch;punch(" .. minetest.enabled_string_colorized(automatization.punch) .. ")]" ..
		"button[5.25,2.2;5.25,2.2;rc;rightclick(" .. minetest.enabled_string_colorized(automatization.rc) .. ")]" ..
		"button[0,4.4;5.25,2.2;activate;activate(" .. minetest.enabled_string_colorized(automatization.activate) .. ")]" ..
		"button[5.25,4.4;5.25,2.2;use;use(" .. minetest.enabled_string_colorized(automatization.use) .. ")]" ..
		"button[0,6.6;10.5,2.2;punchentities;punch entities(" .. minetest.enabled_string_colorized(automatization.punchentities) .. ")]" ..
		"button[0,8.8;5.25,2.2;back;<-]" ..
		"button_exit[5.25,8.8;5.25,2.2;exit;Close]" ..
	"")
end

function automatization.on_formspec_input(formname, fields)
	if formname == "automatizationgui" then
		if fields.enabled then
			automatization.enabled = not automatization.enabled
		elseif fields.punch then
			automatization.punch = not automatization.punch
		elseif fields.rc then
			automatization.rc = not automatization.rc
		elseif fields.activate then
			automatization.activate = not automatization.activate
		elseif fields.use then
			automatization.use = not automatization.use
		elseif fields.punchentities then
			automatization.punchentities = not automatization.punchentities
		elseif fields.back then
			main_cheatgui()
			return true
		end
		automatization.gui()
		return true
	else
		return false
	end
end

function spam.gui()
	minetest.show_formspec("spamgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;10.5,3;clear;Clear]" ..		
		"field[0,3;10.5,3;msg;Text;" .. minetest.formspec_escape(spam.msg) .."]" ..
		"field[0,6;10.5,3;freq;Frequency;" .. minetest.formspec_escape(spam.freq) .. "]" ..
		"button[0,9;5.25,2;back;<-]" ..
		"button_exit[5.25,9;5.25,2;exit;Close]" ..
	"")
end

function spam.on_formspec_input(formname, fields)
	if formname == "spamgui" then
		if fields.msg then
			spam.msg = fields.msg
		end
		if fields.clear then
			spam.msg = ""
		end
		if fields.freq then
			local freq = tonumber(fields.freq)
			if freq ~= nil then
				spam.freq = freq
			end
		end
		if fields.back then
			main_cheatgui()
			return true
		end
		spam.gui()
		return true
	else
		return false
	end
end

function ctf.gui()
	minetest.show_formspec("ctfgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;10.5,2.75;autoflag;autoflag(" .. minetest.enabled_string_colorized(ctf.autoflag) .. ")]" ..
		"button[0,2.75;10.5,2.75;autoheal;autoheal(" .. minetest.enabled_string_colorized(ctf.autoheal) .. ")]" ..
		"button[0,5.5;10.5,2.75;nc;colorize nametags]" ..
		"button[0,8.25;5.25,2.75;back;<-]" ..
		"button_exit[5.25,8.25;5.25,2.75;exit;Close]" ..
	"")
end

function ctf.on_formspec_input(formname, fields)
	if formname == "ctfgui" then
		if fields.autoflag then
			ctf.autoflag = not ctf.autoflag
		elseif fields.autoheal then
			ctf.autoheal = not ctf.autoheal
		elseif fields.nc then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".ctf_nc")
		elseif fields.back then
			main_cheatgui()
			return true
		end
		ctf.gui()
		return true
	else
		return false
	end
end

function misc.gui()
	minetest.show_formspec("miscgui",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;5.25,1.375;activate;activate]" ..
		"button[5.25,0;5.25,1.375;use_on;use]" ..
		"button[0,1.375;5.25,1.375;punch;punch]" ..
		"button[5.25,1.375;5.25,1.375;rc;right click]" ..
		"button[0,2.75;5.25,1.375;ndt;debug trash" .. minetest.enabled_string_colorized(no_debug_trash) .. "]" ..
		"button[5.25,2.75;5.25,1.375;respawn;respawn]" ..
		"field[0,4.125;5.25,1.375;hp;hp;" .. lp:get_hp() .. "]" ..
		"field[5.25,4.125;5.25,1.375;breath;breath;" .. lp:get_breath() .. "]" ..
		"field[0,5.5;5.25,1.375;tod;time of day;" .. minetest.get_timeofday() .. "]" ..
		"field[5.25,5.5;5.25,1.375;dmg;damage;0]" ..
		"field[0,6.875;10.5,1.375;ni;nodes interact;<d|p|a|u> <x+|x-|y+|y-|z+|z-> <number_of_blocks>]" ..
		"field[0,8.25;10.5,1.375;tni;Tunnel nodes interact;<d|p|a|u> <x+|x-|y+|y-|z+|z-> <number_of_blocks>]" ..
		"button[0,9.625;5.25,1.375;back;<-]" ..
		"button_exit[5.25,9.625;5.25,1.375;exit;Close]" ..
	"")
end

function misc.on_formspec_input(formname, fields)
	if formname == "miscgui" then
		if fields.activate then
			lp:activate()
		end
		if fields.use_on then
			lp:use_on()
		end
		if fields.punch then
			lp:punch()
		end
		if fields.rc then
			lp:right_click()
		end
		if fields.ndt then
			no_debug_trash = not no_debug_trash
		end
		if fields.respawn then
			lp:respawn()
		end
		if fields.hp then
			local hp = tonumber(fields.hp)
			if hp ~= nil then
				lp:set_hp(hp)
			end
		end
		if fields.breath then
			local breath = tonumber(fields.breath)
			if breath ~= nil then
				lp:set_breath(breath)
			end
		end
		if fields.tod then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".tod " .. fields.tod)
		end
		if fields.dmg then
			local dmg = tonumber(fields.dmg)
			if dmg ~= nil then
				minetest.send_damage(dmg)
			end
		end
		if fields.ni then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".ni " .. fields.ni)
		end
		if fields.tni then
			minetest.run_callbacks(minetest.registered_on_sending_chat_message, 5, ".tni " .. fields.tni)
		end
		if fields.back then
			main_cheatgui()
			return true
		end
		misc.gui()
		return true
	else
		return false
	end
end

minetest.register_on_formspec_input(cheatgui.on_formspec_input)
minetest.register_on_formspec_input(oredetect.on_formspec_input)
minetest.register_on_formspec_input(tp.on_formspec_input)
minetest.register_on_formspec_input(ignore.on_formspec_input)
minetest.register_on_formspec_input(automatization.on_formspec_input)
minetest.register_on_formspec_input(spam.on_formspec_input)
minetest.register_on_formspec_input(ctf.on_formspec_input)
minetest.register_on_formspec_input(misc.on_formspec_input)

minetest.register_chatcommand("cheatgui", {
	description = "Open Cheatgui",
    params = "",
    func = function()
		cheatgui.cheatgui()
	end,
})

minetest.register_chatcommand("oredetectgui", {
	description = "Open oredetect gui",
    params = "",
    func = oredetect.gui,
})

minetest.register_chatcommand("tp", {
    params = "",
    description = "shows the teleportation formspec",
    func = tp.gui,
})

minetest.register_chatcommand("ignoregui", {
	description = "Open ignore gui",
	func = ignore.gui,
})

minetest.register_chatcommand("automatizationgui", {
	description = "Open automatization gui",
	params = "",
	func = automatization.gui,
})

minetest.register_chatcommand("spamgui", {
	description = "Open spam gui",
	params = "",
	func = spam.gui,
})

minetest.register_chatcommand("ctfgui", {
	description = "Open ctf gui",
	params = "",
	func = ctf.gui,
})

minetest.register_chatcommand("miscgui", {
	description = "Open misc gui",
	params = "",
	func = misc.gui,
})

main_cheatgui = cheatgui.cheatgui
