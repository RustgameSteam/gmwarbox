hook.Add("PlayerGiveSWEP", "WB:PlayerGiveSWEP:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnEffect", "WB:PlayerSpawnEffect:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnNPC", "WB:PlayerSpawnNPC:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnObject", "WB:PlayerSpawnObject:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnProp", "WB:PlayerSpawnProp:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnRagdoll", "WB:PlayerSpawnRagdoll:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnSENT", "WB:PlayerSpawnSENT:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnSWEP", "WB:PlayerSpawnSWEP:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)

hook.Add("PlayerSpawnVehicle", "WB:PlayerSpawnVehicle:Deny", function(Player)
	return Player:HasAccess("spawnmenu")
end)