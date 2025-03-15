Warbox["shared"] = {
	settings_box = {
		size = {36, 36, 36},
		centers = {
			gm_construct = Vector(-760, 3180, 600)
		}
	}
}

function Warbox:GetCenter()
    return self["settings_box"]["centers"][game.GetMap()]
end