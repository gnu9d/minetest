xp_farm = {}

xp_farm.farm_by_craft = false
xp_farm.farm_by_pd = false

xp_farm.timer = 0
xp_farm.freq = 5

xp_farm.placed = false


function xp_farm.interact_in_radius(pos, radius, action)
	local targetpos = {x=pos.x, y=pos.y, z=pos.z}
	
	targetpos.x = targetpos.x + radius
	targetpos.y = targetpos.y + radius
	targetpos.z = targetpos.z + radius
	
	pos.x = pos.x - radius
	pos.y = pos.y - radius
	pos.z = pos.z - radius
	
	local tmppos = {x=pos.x, y=pos.y, z=pos.z}
	
	while tmppos.x <= targetpos.x do	
		tmppos.x = tmppos.x + 1
		while tmppos.y <= targetpos.y do
			tmppos.y = tmppos.y + 1
			while tmppos.z <= targetpos.z do
				tmppos.z = tmppos.z + 1
				action(tmppos)
			end
			tmppos.z = pos.z
		end
		tmppos.y = pos.y
	end
	
end


minetest.register_chatcommand("farm_pd", {
    description = "switches farm xp by placing+digging",
    params = "",
    func = function()
		xp_farm.farm_by_pd = not xp_farm.farm_by_pd
	end,
})

minetest.register_chatcommand("farm_craft", {
    description = "switches farm xp by crafting(protection block -> protection logo -> protection block)",
    params = "",
    func = function()
		print("put protection block/logo in the craft inventoty")
		xp_farm.farm_by_craft = not xp_farm.farm_by_craft
	end,
})

function xp_farm.craftstep()
	local lpinv = minetest.get_inventory({
		type="player",
		name=minetest.localplayer:get_name(),
	})
	lpinv:craft(0)
	lpinv:move("craftresult", 1, 0, lpinv, "craft", 5)
	
end

function xp_farm.digplacestep()
	switch(xp_farm.placed, { 
        [true] = function()
			xp_farm.interact_in_radius(minetest.localplayer:get_pos(), 2, minetest.dig_node)
			xp_farm.placed = false
		end,
		[false] = function()
			xp_farm.interact_in_radius(minetest.localplayer:get_pos(), 2, minetest.place_node)
			xp_farm.placed = true
		end,
		["default"] = function()
			xp_farm.placed = false
		end
	})
end

minetest.register_globalstep(
	function(dtime)
		
		xp_farm.timer = xp_farm.timer + dtime
	
		if xp_farm.timer >= xp_farm.freq then
			if xp_farm.farm_by_craft then
				xp_farm.craftstep()
			end
		
			if xp_farm.farm_by_pd then
				xp_farm.digplacestep()
			end
			xp_farm.timer = 0
		end
		
	end
)

minetest.register_chatcommand("farmf", {
    params = "<farm_frequency>",
    description = "sets the frequency of farm",
    func = function(param)
		if not param ~= nil then
			xp_farm.freq = tonumber(param)
		end
	end,
})

function xp_farm.gui()
	minetest.show_formspec("xp",
		"formspec_version[4]" ..
		"size[10.5,11]" ..
		"button[0,0;5.25,6;fbc;Farm XP\nby craft\n(" .. minetest.enabled_string_colorized(xp_farm.farm_by_craft) .. ")]" ..
		"button[5.25,0;5.25,6;fpd;Farm XP\nby place/dig\n(" .. minetest.enabled_string_colorized(xp_farm.farm_by_pd) .. ")]" ..
		"field[0,6;11,3;farmf;Farm frequency;" .. xp_farm.freq .. "]" ..
		"button_exit[5.25,9;5.25,2;;Close]" ..
		"button[0,9;5.25,2;back;<-]" ..
	"")
end

function xp_farm.on_formspec_input(formname, fields)
	if formname == "xp" then
		if fields.fbc then
			xp_farm.farm_by_craft = not xp_farm.farm_by_craft
		elseif fields.fpd then
			xp_farm.farm_by_pd = not xp_farm.farm_by_pd
		elseif fields.back then
			main_cheatgui()
			return true
		elseif fields.farmf ~= nil and tonumber(fields.farmf) ~= 0 and tonumber(fields.farmf) ~= nil then
			xp_farm.freq = tonumber(fields.farmf)
		end
		xp_farm.gui()
		return true
	else
		return false
	end
end

minetest.register_on_formspec_input(xp_farm.on_formspec_input)

minetest.register_chatcommand("farmgui", {
    params = "",
    description = "XP farm gui",
    func = function(param)
		xp_farm.gui()
	end,
})
