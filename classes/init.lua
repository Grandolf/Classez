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


