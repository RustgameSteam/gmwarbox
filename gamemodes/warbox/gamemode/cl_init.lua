include("shared.lua")
print("\n\n| >>> 		      Загрука плагинов			<<< |\n|")

local root = GM.FolderName.."/gamemode/plugins"
local _, folders = file.Find(root.."/*", "LUA")
for k, v in pairs(folders)do
	local lPath = root.."/"..v
	local files, _ = file.Find(lPath.."/*", "LUA")
	for k1, v1 in pairs(files)do
		include(lPath.."/"..v1)
	end
end