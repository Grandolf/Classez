minetest.register_tool("classes:staff_wood", {
	description = "Wooden Staff",
	inventory_image = "classes_staff_wood_wield.png",
	wield_image = "classes_staff_wood_wield.png",
	wield_scale = {x=1.5,y=5.5,z=1.5},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level=0,
		groupcaps={
			crumbly = {times={[1]=4.5, [2]=2.2, [3]=1.2}, uses=10, maxlevel=1},
		},
		damage_groups = {fleshy=3},
	}
})

minetest.register_craft({
	output = 'classes_weapons:staff_wood',
	recipe = {
		{'default:wood'},
		{'default:stick'},
		{'default:wood'},
	}
})

minetest.register_entity("classes:fireball", {
	textures = {"fireball.png"},
	velocity = 15,
	light_source = 200,
	on_step = function (self, pos, node, dtime)
				local pos = self.object:getpos()
					local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2) 
                for k, obj in pairs(objs) do
		obj:set_hp(obj:get_hp()-15)
                    if obj:is_player() then
                        return
                    else
                    obj:set_hp(obj:get_hp()-70)					
				    if obj:get_entity_name() ~= "classes:fireball" then
						if obj:get_hp()<=0 then 
							obj:remove()
						end
						self.object:remove() 
					end						
				end
            end

					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
--								if n ~= "classes:fireball" and n ~="hackersheep:hackersheep" and n ~="prohackersheep:prohackersheep"  then	
--									if   minetest.registered_nodes[n].groups.noobhackersheep then --[[or math.random(1, 100) <= 0]]
--										minetest.env:set_node(t, {name=""..n})
--									else 
--										minetest.env:set_node(t, {name=""..n})
--									end
--								else
if minetest.registered_nodes[n].groups.flammable or minetest.registered_nodes[n].groups.choppy or minetest.registered_nodes[n].groups.oddly_breakable_by_hand or minetest.registered_nodes[n].groups.cracky or minetest.registered_nodes[n].groups.crumbly or n =="default:desert_stone" then
									self.hit_node(self, pos, node)
									self.object:remove()
									return
								end
							end
						end
					end
	end,
	
	
	hit_node = function(self, pos, node)
	local pos = self.object:getpos()
--		for dx=-4,4 do
--			for dy=-4,4 do
--				for dz=-4,4 do
--					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local n = minetest.env:get_node(pos).name
--					if math.random(1, 50) <= 0 then
--						minetest.env:remove_node(p)
--					end
--					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) >=500 then
--										minetest.env:set_node(t, {name="air"})
--					end
					local objects = minetest.env:get_objects_inside_radius(pos, 10)
											for _,obj in ipairs(objects) do
												if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
													local obj_p = obj:getpos()
													local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
													local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
													local damage = ((80*0.5^dist)*2)+3
													obj:punch(obj, 1.0, {
													full_punch_interval=1.0,
													damage_groups={fleshy=damage},
													}, vec)
												end
										end

					minetest.add_particlespawner(
			10, --amount
			0.1, --time
			{x=pos.x-3, y=pos.y-3, z=pos.z-3}, --minpos
			{x=pos.x+3, y=pos.y+3, z=pos.z+3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=5,z=-0.5}, --minacc
			{x=0.5,y=5,z=0.5}, --maxacc
			0.1, --minexptime
			1, --maxexptime
			50, --minsize
			90, --maxsize
			false, --collisiondetection
			"flame_pillar.png" --texture
		)
                        
--				end
--			end
--		end
	end
})
minetest.register_craftitem("classes:firestaff", {
	description = "Staff of Fire",
	inventory_image = "firestaff.png",
	wield_scale = {x=2.5,y=5.5,z=1.5},
	stackable = false,
	on_use = function (itemstack, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "classes:fireball")
			local vec = {x=dir.x*6,y=dir.y*6,z=dir.z*6}
			obj:setvelocity(vec)
		return itemstack
	end,
	light_source = 15,
})
local addvectors = function (v1, v2)
	return {x=v1.x+v2.x, y=v1.y+v2.y, z=v1.z+v2.z}
end
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
level1 = 1
level1w_drop = "classes:staff_wood"
level1f_drop = "classes:staff_wood"
level1a_drop = "classes:staff_wood"
level1t_drop = "classes:staff_wood"

level2 = 10
level2w_drop = "classes:apprentice_staff"
level2f_drop = ""
level2t_drop = ""
level2a_drop = ""

level3 = 50
level3w_drop = ""
level3f_drop = ""
level3t_drop = ""
level3a_drop = ""

level4 = 100
level4w_drop = ""
level4f_drop = ""
level4t_drop = ""
level4a_drop = ""

level5 = 500
level5w_drop = "classes:lightning"
level5f_drop = ""
level5t_drop = ""
level5a_drop = ""

level6 = 1000
level6w_drop = ""
level6f_drop = ""
level6t_drop = ""
level6a_drop = ""

level7 = 1500
level7w_drop = ""
level7f_drop = ""
level7t_drop = ""
level7a_drop = ""

level8 = 2000
level8w_drop = ""
level8f_drop = ""
level8t_drop = ""
level8a_drop = ""

level9 = 2500
level9w_drop = ""
level9f_drop = ""
level9t_drop = ""
level9a_drop = ""

level10 = 5000
level10w_drop = "classes:firestaff"
level10f_drop = ""
level10t_drop = ""
level10a_drop = ""

level11 = 10000
level11w_drop = "classes:apprentice"
level11f_drop = ""
level11a_drop = ""
level11t_drop = ""

level12 = 15000
level12w_drop = ""
level12f_drop = ""
level12t_drop = ""
level12a_drop = ""

level13 = 20000
level13w_drop = ""
level13f_drop = ""
level13t_drop = ""
level13a_drop = ""

level14 = 30000
level14w_drop = ""
level14f_drop = ""
level14t_drop = ""
level14a_drop = ""

level15 = 40000
level15w_drop = ""
level15f_drop = ""
level15t_drop = ""
level15a_drop = ""

level16 = 50000
level16w_drop = ""
level16f_drop = ""
level16t_drop = ""
level16a_drop = ""

level17 = 100000
level17w_drop = ""
level17f_drop = ""
level17t_drop = ""
level17a_drop = ""

level18 = 250000
level18w_drop = ""
level18f_drop = ""
level18t_drop = ""
level18a_drop = ""

level19 = 500000
level19w_drop = ""
level19f_drop = ""
level19t_drop = ""
level19a_drop = ""

level20 = 1000000
level20w_drop = ""
level20f_drop = ""
level20t_drop = ""
level20a_drop = ""


--add an experience orb if player digs node from xp group
minetest.register_on_dignode(function(pos, oldnode, digger)
	namer = oldnode.name
	see_if_mineral = minetest.get_item_group(namer, "xp")
	if see_if_mineral > 0 then
		minetest.env:add_entity(pos, "classes:orb")
	end
end)
--give a new player some xp
minetest.register_on_newplayer(function(player)
	file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_experience", "w")
	file:write("0")
	file:close()
end)
--set player's xp level to 0 if they die
--minetest.register_on_dieplayer(function(player)
--	file = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_experience", "w")
--	file:write("0")
--	file:close()
--end)

--Allow people to collect orbs
minetest.register_globalstep(function(dtime,player_name)
	for _,player in ipairs(minetest.get_connected_players()) do
		local pos = player:getpos()
		pos.y = pos.y+0.5
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 1)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "classes:orb" then
				--RIGHT HERE ADD IN THE CODE TO UPGRADE PLAYERS 
				object:setvelocity({x=0,y=0,z=0})
				object:get_luaentity().name = "STOP"
				minetest.sound_play("orb", {
					to_player = player:get_player_name(),
				})
				xp = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_experience", "r")
				experience = nil

				if xp == nil then
                    xp = io.open (minetest.get_worldpath().."/"..player:get_player_name().."_experience", "w")
                    xp:write("0")
                    xp:close()

                    xp = io.open (minetest.get_worldpath().."/"..player:get_player_name().."_experience", "r")
                    if xp ~= nil then
    				    experience = xp:read ("*l")
	    			    xp:close()
                    end
				end

				if experience ~= nil then
					new_xp = experience + 1
					xp_write = io.open(minetest.get_worldpath().."/"..player:get_player_name().."_experience", "w")
					xp_write:write(new_xp)
					xp_write:close()
					if new_xp == level1 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level1w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level1f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level1t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level1a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end

					if new_xp == level2 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level2w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level2f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level2t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level2a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end

					if new_xp == level3 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level3w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level3f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level3t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level3a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
	
					if new_xp == level4 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level4w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level4f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level4t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level4a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end	
					
					if new_xp == level5 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level5w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level5f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level5t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level5a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end	
										
					if new_xp == level6 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level6w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level6f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level6t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level6a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
										
					if new_xp == level7 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level7w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level7f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level7t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level7a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
										
					if new_xp == level8 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level8w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level8f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level8t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level8a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
								
					if new_xp == level9 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level9w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level9f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level9t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level9a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end	
										
					if new_xp == level10 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level10w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level10f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level10t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level10a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level11 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level11w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level11f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level11t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level11a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level12 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level12w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level12f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level12t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level12a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level13 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level13w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level13f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level13t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level13a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level14 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level14w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level14f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level14t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level14a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level9 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level14w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level14f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level14t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level14a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level15 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level15w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level15f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level15t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level15a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level16 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level17w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level17f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level17t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level17a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level18 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level18w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level18f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level18t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level18a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level19 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level19w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level19f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level19t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level19a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end
					if new_xp == level20 then
					if minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) then
						minetest.env:add_item(pos, level20w_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
						minetest.env:add_item(pos, level20f_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					if not minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) then
					if minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) then
						minetest.env:add_item(pos, level20t_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					end
					else if minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) then
						minetest.env:add_item(pos, level20a_drop)
						minetest.sound_play("level_up", {
							to_player = player:get_player_name(),
						})
					if not minetest.check_player_privs(player:get_player_name(),{GAMEarcher=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEthief=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEwizard=true}) 
					or minetest.check_player_privs(player:get_player_name(),{GAMEfighter=true}) 
					then
					minetest.get_modpath("classes")
					local path = minetest.get_modpath("classes")
					dofile(path .. "/init.lua")
					minetest.show_formspec(name, "race_selector", race_chooser)
						end
					end
				end
			end	
				end
				object:remove()
			end
		end
		for _,object in ipairs(minetest.env:get_objects_inside_radius(pos, 3)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "classes:orb" then
				if object:get_luaentity().collect then
					local pos1 = pos
					pos1.y = pos1.y+0.2
					local pos2 = object:getpos()
					local vec = {x=pos1.x-pos2.x, y=pos1.y-pos2.y, z=pos1.z-pos2.z}
					vec.x = vec.x*3
					vec.y = vec.y*3
					vec.z = vec.z*3
					object:setvelocity(vec)
				end
			end
		end
	end
end)

minetest.register_entity("classes:orb", {
	physical = true,
	timer = 0,
	textures = {"orb.png"},
	visual_size = {x=0.3, y=0.3},
	collisionbox = {-0.17,-0.17,-0.17,0.17,0.17,0.17},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=1, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
	end,
	collect = true,
	on_step = function(self, dtime)
		self.timer = self.timer + dtime
		if (self.timer > 300) then
			self.object:remove()
		end
		local p = self.object:getpos()
		local nn = minetest.env:get_node(p).name
		noder = minetest.env:get_node(p).name
		p.y = p.y - 0.3
		local nn = minetest.env:get_node(p).name
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			if self.physical_state then
				self.object:setvelocity({x=0, y=0, z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = false
				self.object:set_properties({
					physical = false
				})
			end
		else
			if not self.physical_state then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end
		end
	end,
})



























minetest.register_entity("classes:magicmissile", {
	textures = {"magicmissile.png"},
	velocity = 15,
	light_source = 200,
	on_step = function (self, pos, node, dtime)
				local pos = self.object:getpos()
					local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2) 
                for k, obj in pairs(objs) do
		obj:set_hp(obj:get_hp()-5)
                    if obj:is_player() then
                        return
                    else
                    obj:set_hp(obj:get_hp()-10)					
				    if obj:get_entity_name() ~= "classes:magicmissile" then
						if obj:get_hp()<=0 then 
							obj:remove()
						end
						self.object:remove() 
					end						
				end
            end

					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
--								if n ~= "classes:fireball" and n ~="hackersheep:hackersheep" and n ~="prohackersheep:prohackersheep"  then	
--									if   minetest.registered_nodes[n].groups.noobhackersheep then --[[or math.random(1, 100) <= 0]]
--										minetest.env:set_node(t, {name=""..n})
--									else 
--										minetest.env:set_node(t, {name=""..n})
--									end
--								else
if minetest.registered_nodes[n].groups.flammable or minetest.registered_nodes[n].groups.choppy or minetest.registered_nodes[n].groups.oddly_breakable_by_hand or minetest.registered_nodes[n].groups.cracky or minetest.registered_nodes[n].groups.crumbly or n =="default:desert_stone" then
									self.hit_node(self, pos, node)
									self.object:remove()
									return
								end
							end
						end
					end
	end,
	
	
	hit_node = function(self, pos, node)
	local pos = self.object:getpos()
--		for dx=-4,4 do
--			for dy=-4,4 do
--				for dz=-4,4 do
--					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local n = minetest.env:get_node(pos).name
--					if math.random(1, 50) <= 0 then
--						minetest.env:remove_node(p)
--					end
--					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) >=500 then
--										minetest.env:set_node(t, {name="air"})
--					end
					local objects = minetest.env:get_objects_inside_radius(pos, 2)
											for _,obj in ipairs(objects) do
												if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
													local obj_p = obj:getpos()
													local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
													local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
													local damage = (10*0.5^dist)*1
													obj:punch(obj, 1.0, {
													full_punch_interval=1.0,
													damage_groups={fleshy=damage},
													}, vec)
												end
										end

					minetest.add_particlespawner(
			2, --amount
			0.1, --time
			{x=pos.x-3, y=pos.y-3, z=pos.z-3}, --minpos
			{x=pos.x+3, y=pos.y+3, z=pos.z+3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=5,z=-0.5}, --minacc
			{x=0.5,y=5,z=0.5}, --maxacc
			0.1, --minexptime
			1, --maxexptime
			50, --minsize
			90, --maxsize
			false, --collisiondetection
			"magicmissileburst.png" --texture
		)
                        
--				end
--			end
--		end
	end
})
minetest.register_craftitem("classes:apprentice_staff", {
	description = "Staff of the Apprenti",
	inventory_image = "apprentice.png",
	wield_scale = {x=2.5,y=5.5,z=1.5},
	stackable = false,
	on_use = function (itemstack, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "classes:magicmissile")
			local vec = {x=dir.x*8,y=dir.y*8,z=dir.z*8}
			obj:setvelocity(vec)
		return itemstack
	end,
	light_source = 15,
})
local addvectors = function (v1, v2)
	return {x=v1.x+v2.x, y=v1.y+v2.y, z=v1.z+v2.z}
end


minetest.register_entity("classes:lightning", {
	textures = {"lightningball.png"},
	velocity = 15,
	light_source = 200,
	on_step = function (self, pos, node, dtime)
				local pos = self.object:getpos()
					local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2) 
                for k, obj in pairs(objs) do
		obj:set_hp(obj:get_hp()-10)
                    if obj:is_player() then
                        return
                    else
                    obj:set_hp(obj:get_hp()-20)					
				    if obj:get_entity_name() ~= "classes:lightning" then
						if obj:get_hp()<=0 then 
							obj:remove()
						end
						self.object:remove() 
					end						
				end
            end

					for dx=-1,1 do
						for dy=-1,1 do
							for dz=-1,1 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
--								if n ~= "classes:fireball" and n ~="hackersheep:hackersheep" and n ~="prohackersheep:prohackersheep"  then	
--									if   minetest.registered_nodes[n].groups.noobhackersheep then --[[or math.random(1, 100) <= 0]]
--										minetest.env:set_node(t, {name=""..n})
--									else 
--										minetest.env:set_node(t, {name=""..n})
--									end
--								else
if minetest.registered_nodes[n].groups.flammable or minetest.registered_nodes[n].groups.choppy or minetest.registered_nodes[n].groups.oddly_breakable_by_hand or minetest.registered_nodes[n].groups.cracky or minetest.registered_nodes[n].groups.crumbly or n =="default:desert_stone" then
									self.hit_node(self, pos, node)
									self.object:remove()
									return
								end
							end
						end
					end
	end,
	
	
	hit_node = function(self, pos, node)
	local pos = self.object:getpos()
--		for dx=-4,4 do
--			for dy=-4,4 do
--				for dz=-4,4 do
--					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
--					local n = minetest.env:get_node(pos).name
--					if math.random(1, 50) <= 0 then
--						minetest.env:remove_node(p)
--					end
--					if minetest.registered_nodes[n].groups.flammable or math.random(1, 100) >=500 then
--										minetest.env:set_node(t, {name="air"})
--					end
					local objects = minetest.env:get_objects_inside_radius(pos, 4)
											for _,obj in ipairs(objects) do
												if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
													local obj_p = obj:getpos()
													local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
													local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
													local damage = (80*0.5^dist)*2
													obj:punch(obj, 1.0, {
													full_punch_interval=1.0,
													damage_groups={fleshy=damage},
													}, vec)
												end
										end

					minetest.add_particlespawner(
			4, --amount
			0.1, --time
			{x=pos.x-3, y=pos.y-3, z=pos.z-3}, --minpos
			{x=pos.x+3, y=pos.y+3, z=pos.z+3}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.0,y=0,z=-0.0}, --minacc
			{x=0.1,y=-1,z=0.1}, --maxacc
			0.1, --minexptime
			1, --maxexptime
			300, --minsize
			350, --maxsize
			false, --collisiondetection
			"lightningbolt.png" --texture
		)
                        
--				end
--			end
--		end
	end
})
minetest.register_craftitem("classes:lightning_staff", {
	description = "Staff of the Vengeful Skies",
	inventory_image = "lightningstaff.png",
	wield_scale = {x=2.5,y=5.5,z=1.5},
	stackable = false,
	on_use = function (itemstack, placer, pointed_thing)
			local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			local obj = minetest.env:add_entity({x=playerpos.x+0+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+0+dir.z}, "classes:lightning")
			local vec = {x=dir.x*12,y=dir.y*12,z=dir.z*12}
			obj:setvelocity(vec)
		return itemstack
	end,
	light_source = 15,
})
local addvectors = function (v1, v2)
	return {x=v1.x+v2.x, y=v1.y+v2.y, z=v1.z+v2.z}
end
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
--...............................................................................................................................--
classes = {}

minetest.register_privilege("GAMEwizard", {
	description = "Wizards, masters of the arcane arts, are a formidible class, and extremly powerful, however they pay for that by not haveing any special heavy armor",
	give_to_singleplayer = false,
})

minetest.register_privilege("GAMEmale", {
	description = "A male player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEfemale", {
	description = "A female player",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEfighter", {
	description = "useing their heavy arms and armor, this class dominates the frontline battlefield",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEarcher", {
	description = "masters of the bow, at higher levels can fire as many as 3 arrows at once!",
	give_to_singleplayer = false,
})
minetest.register_privilege("GAMEthief", {
	description = "Thieves are not particularly strong, but instead rely on speed, stealth, and their resourcfulness",
	give_to_singleplayer = false,
})
--minetest.register_privilege("GAMEorc", {
--	description = "An orc player",
--	give_to_singleplayer = false,
--})
--minetest.register_privilege("GAMEhobbit", {
--	description = "A hobbit player",
--	give_to_singleplayer = false,
--})

dofile(minetest.get_modpath("classes").."/change-privs.lua")
--dofile(minetest.get_modpath("classes").."/allies.lua")

local race_chooser = "size[8,6]"..
	"background[8,6;1,1;gui_formbg.png;true]"..
	"tablecolumns[color;text]"..
	"tableoptions[background=#00000000;highlight=#00000000;border=false]"..
	"table[0,0;6,0.5;race_message;#A52A2A,Please select the race you wish to be:;1]"..
	"image[0.25,1.4;0.75,0.75;wizard.png]"..
	"button_exit[1,1.5;2,0.5;wizard;Wizard]"..
	"image[4.75,1.4;0.75,0.75;archer.png]"..
	"button_exit[5.5,1.5;2,0.5;archer;Archer]"..
	"image[0.25,2.4;0.75,0.75;fighter.png]"..
	"button_exit[1,2.5;2,0.5;fighter;Fighter]"..
	"image[4.75,2.4;0.75,0.75;theif.png]"..
	"button_exit[5.5,2.5;2,0.5;theif;Theif]"..
--	"image[0.25,3.4;0.75,0.75;hobbit.png]"..
--	"button_exit[1,3.5;2,0.5;hobbit;Hobbit]"..
	"dropdown[5.5,3.4;2;gender;Male,Female;1]"

local fly_stuff = "button[1,4.75;2,0.5;fast;Fast]" ..
	"button[3,4.75;2,0.5;fly;Fly]" ..
	"button[5,4.75;2,0.5;noclip;Noclip]" ..
	"button[2.5,5.5;3,0.5;fast_fly_noclip;Fast, Fly & Noclip]"

chance = 0

local function regen_chance()
	chance = math.random(1, 6)
end

local function give_stuff_fighter(player)
	regen_chance()
	if chance >= 1 then
		player:get_inventory():add_item('main', 'classes:staff_wood')
	end
end
local function give_stuff_archer(player)
	regen_chance()
	if chance >= 1 then
		player:get_inventory():add_item('main', 'classes:staff_wood')
	end
end

local function give_stuff_man(player)
	regen_chance()
	if chance >= 1 then
		player:get_inventory():add_item('main', 'classes:staff_wood')
	end
end

local function give_stuff_thief(player)
	regen_chance()
	if chance >= 1 then
		player:get_inventory():add_item('main', 'classes:staff_wood')
	end
end

--local function give_stuff_hobbit(player)
--	regen_chance()
--	if chance >= 1 then
--		player:get_inventory():add_item('main', 'default:pick_stone')
--	end
--end

local function give_stuff_wizard(player)
	regen_chance()
	if chance >= 1 then
		player:get_inventory():add_item('main', 'classes:staff_wood')
	end
end

minetest.register_on_newplayer(function(player)
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if minetest.get_player_privs(name).GAMEwizard then
		give_stuff_wizard(player)
	end
end)

--minetest.register_on_joinplayer(function(player)
--	local name = player:get_player_name()
--	local privs = minetest.get_player_privs(name)
--	if minetest.get_player_privs(name).GAMEwizard then
--		multiskin[name].skin = "wizard_skin.png"
--	elseif minetest.get_player_privs(name).GAMEmale then
--		if minetest.get_player_privs(name).GAMEfighter then
--			multiskin[name].skin = "fighter_skin.png"
--		elseif minetest.get_player_privs(name).GAMEarcher then
--			multiskin[name].skin = "archer_skin.png"
--		elseif minetest.get_player_privs(name).GAMEtheif then
--			multiskin[name].skin = "theif_skin.png"
--		elseif minetest.get_player_privs(name).GAMEorc then
--			multiskin[name].skin = "orc_skin.png"
--		elseif minetest.get_player_privs(name).GAMEhobbit then
--			multiskin[name].skin = "hobbit_skin.png"
--		end
--	elseif minetest.get_player_privs(name).GAMEfemale then
--		if minetest.get_player_privs(name).GAMEfighter then
--			multiskin[name].skin = "fighter_skinf.png"
--		elseif minetest.get_player_privs(name).GAMEarcher then
--			multiskin[name].skin = "archer_skinf.png"
--		elseif minetest.get_player_privs(name).GAMEtheif then
--			multiskin[name].skin = "theif_skinf.png"
--		elseif minetest.get_player_privs(name).GAMEwizard then
--			multiskin[name].skin = "wizard_skinf.png"
--		elseif minetest.get_player_privs(name).GAMEhobbit then
--			multiskin[name].skin = "hobbit_skinf.png"
--		end
--	else
--		minetest.after(1, function()
--			if minetest.is_singleplayer() then
--				minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
--			else
--				minetest.show_formspec(name, "race_selector", race_chooser)
--			end
--		end)
--	end
--end)

local function player_race_stuff(class, text, mf, func, name, privs, player)
	minetest.chat_send_player(name, "You are now a member of the class " .. text ..", go forth into the world.")
	privs["GAME" .. class] = true
	privs["GAME" .. mf] = true
	minetest.set_player_privs(name, privs)
	func(player)
--	if mf == "male" or race == "fighter" or race == "wizard" then
--		default.player_set_textures(player, {class .. "_skin.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
--		multiskin[name].skin = class .. "_skin.png"
--	elseif mf == "female" then
--		default.player_set_textures(player, {class .. "_skinf.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"})
--		multiskin[name].skin = class .. "_skinf.png"
--	end
--	minetest.log("action", name.. " chose to be a " .. class)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "race_selector" then return end
	local name = player:get_player_name()
	local privs = minetest.get_player_privs(name)
	if fields.gender == "Male" then
		if fields.fighter then
			player_race_stuff("fighter", "fighters", "male", give_stuff_fighter, name, privs, player)
		elseif fields.archer then
			player_race_stuff("archer", "archers", "male", give_stuff_archer, name, privs, player)
		elseif fields.wizard then
			player_race_stuff("wizard", "wizards", "male", give_stuff_wizard, name, privs, player)
		elseif fields.theif then
			player_race_stuff("thief", "thieves", "male", give_stuff_thief, name, privs, player)
		elseif fields.hobbit then
			player_race_stuff("hobbit", "hobbits", "male", give_stuff_hobbit, name, privs, player)
		end
	elseif fields.gender == "Female" then
		if fields.fighter then
			player_race_stuff("fighter", "fighters", "female", give_stuff_fighter, name, privs, player)
		elseif fields.archer then
			player_race_stuff("archer", "archers", "female", give_stuff_archer, name, privs, player)
		elseif fields.wizard then
			player_race_stuff("wizard", "wizards", "female", give_stuff_wizard, name, privs, player)
		elseif fields.theif then
			player_race_stuff("thief", "thieves", "female", give_stuff_thief, name, privs, player)
		elseif fields.hobbit then
			player_race_stuff("hobbit", "hobbits", "female", give_stuff_hobbit, name, privs, player)
		end
	end
--	if fields.fast then
--		privs.fast = true
--		minetest.set_player_privs(name, privs)
--		return
--	elseif fields.fly then
--		privs.fly = true
--		minetest.set_player_privs(name, privs)
--		return
--	elseif fields.noclip then
--		privs.noclip = true
--		minetest.set_player_privs(name, privs)
--		return
--	elseif fields.fast_fly_noclip then
--		privs.fly, privs.fast, privs.noclip = true, true, true
--		minetest.set_player_privs(name, privs)
--		return
--	end
end)

minetest.register_chatcommand("class", {
	params = "<name>",
	description = "print out privileges of player",
	func = function(name, param)
		param = (param ~= "" and param or name)
		if minetest.check_player_privs(param, {GAMEwizard = true}) then
			return true, "Class of " .. param .. ": Wizard"
		elseif minetest.check_player_privs(param, {GAMEfighter = true}) then
			return true, "Class of " .. param .. ": Fighter"
		elseif minetest.check_player_privs(param, {GAMEarcher = true}) then
			return true, "Class of " .. param .. ": Archer"
		elseif minetest.check_player_privs(param, {GAMEtheif = true}) then
			return true, "Class of " .. param .. ": Thief"
--		elseif minetest.check_player_privs(param, {GAMEorc = true}) then
--			return true, "Race of " .. param .. ": Orc"
--		elseif minetest.check_player_privs(param, {GAMEhobbit = true}) then
--			return true, "Race of " .. param .. ": Hobbit"
		elseif minetest.check_player_privs(param, {shout = true}) ~= nil then
			if param == name then
				if minetest.is_singleplayer() then
					minetest.show_formspec(name, "race_selector", race_chooser .. fly_stuff)
				else
					minetest.show_formspec(name, "race_selector", race_chooser)
				end
			else
				return true, param .. " has not chosen a class!"
			end
		else
			return true, param .. " does not exist!"
		end
	end,
})





