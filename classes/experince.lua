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
