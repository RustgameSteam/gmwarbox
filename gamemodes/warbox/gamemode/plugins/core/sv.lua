Warbox["server"] = {
	fields = {
		default = {
			{"plate", 4, 0, 20, 1},
			{"plate", 4, 0, -20, 1},
		}
	},
	zones = {
		--[[
			{
				team1 = {Player(1), Player(2)},
				team2 = {Player(3), Player(4)},
				type = "default"
			}
		]]
	}
}

function Warbox:CreateBox(XYZ)
	local Box = ents.Create("box_normal")
	Box:SetPos(XYZ)
	Box:Spawn()

	Box:SetHealth(255)
end

function Warbox:Recreate(Type)
	for k, v in pairs(ents.FindByClass("box_normal"))do
		v:Remove()
	end

	local WBServer = self["server"]
	local WBShared = self["shared"]
	local Center = WBShared["settings_box"]["centers"][game.GetMap()]
	local Size = WBShared["settings_box"]["size"]
	
	for k, v in pairs(WBServer["fields"][Type])do
		if(v[1] == "plate")then
			local lCenter = Center + Vector(Size[1] * v[3], Size[2] * v[4], Size[3] * v[5])
			for x = -v[2], v[2] do
				for y = -v[2], v[2] do
					self:CreateBox(lCenter + Vector(Size[1] * x, Size[2] * y, Size[3] * v[3]))
				end
			end
		else
			self:CreateBox(Center + Vector(Size[1] * v[1], Size[2] * v[2], Size[3] * v[3]))
		end
	end

	print("| > Шаблон ["..Type.."] воссоздан!")
end

hook.Add("InitPostEntity", "WB:InitPostEntity:Recreate", function()
	Warbox:Recreate("default")
end)

concommand.Add("recreate", function()
	Warbox:Recreate("default")
end)