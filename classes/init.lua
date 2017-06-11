--dofile(minetest.get_modpath("classes").."/ac.lua")
--dofile(minetest.get_modpath("classes").."/admin.lua")
--dofile(minetest.get_modpath("classes").."/armorinit.lua")
dofile(minetest.get_modpath("classes").."/change-privs.lua")
--dofile(minetest.get_modpath("classes").."/armor.lua")
dofile(minetest.get_modpath("classes").."/wizard.lua")
dofile(minetest.get_modpath("classes").."/fighter.lua")
dofile(minetest.get_modpath("classes").."/experience.lua")

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
	output = 'classes:staff_wood',
	recipe = {
		{'default:wood'},
		{'default:stick'},
		{'default:wood'},
	}
})

minetest.register_craftitem("classes:wizardstuff", {
	inventory_image = "stuff.png"
})

minetest.register_craftitem("classes:fighterstuff", {
	inventory_image = "stuff.png"
})

minetest.register_craftitem("classes:daytheifstuff", {
	inventory_image = "stuff.png"
})

minetest.register_craftitem("classes:nighttheifstuff", {
	inventory_image = "stuff.png"
})



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




