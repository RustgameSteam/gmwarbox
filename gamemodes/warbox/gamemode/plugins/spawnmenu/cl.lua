hook.Add("SpawnMenuOpen", "WB:SpawnMenuOpen:Disallow", function()
	return LocalPlayer():HasAccess("spawnmenu")
end)