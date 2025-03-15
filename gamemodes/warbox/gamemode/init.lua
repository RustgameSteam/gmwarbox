print("|\n| >>> 			Загрука плагинов			<<< |")
AddCSLuaFile("cl_init.lua")
include("shared.lua")
AddCSLuaFile("shared.lua")
print(string.rep("\n",10))

local root = "gamemodes/warbox/gamemode/plugins"
local _, folders = file.Find(root.."/*", "GAME")
for _, folder in SortedPairs(folders, false) do
	if folder == "." or folder == ".." then continue end

	for k, v in pairs({"sh", "sv", "cl"})do
		for _, File in SortedPairs(file.Find(root.."/"..folder.."/"..v..".lua", "GAME"), true)do
			local Len = file.Read(root.."/"..folder.."/"..File, "GAME")
			if(Len == nil or Len == "")then continue end
			print("| > "..root.."/"..folder.."/"..File)
			if(v == "sh" or v == "cl")then
				AddCSLuaFile(string.Replace(root, "gamemodes/", "").."/"..folder.."/"..File)
			end
			if(v == "sh" or v == "sv")then
				include(string.Replace(root, "gamemodes/", "").."/"..folder.."/"..File)
			end
		end
	end
end