local MetaPlayers = FindMetaTable("Player")

RAdmin = {
	groups = {
		admin = {
			access = {
				"adminmenu",
				"spawnmenu"
			}
		},
		uranium = {
			access = {
				"extramenu",
				"emojimenu"
			}
		},
		premium = {
			access = {
				"emojimenu"
			}
		},
		user = {
			access = {

			}
		}
	},
	prefix = {
		admin = {Color(102, 102, 255), "Администратор"},
		uranium = {Color(0, 204, 153), "Uranium"},
		premium = {Color(0, 153, 204), "Premium"},
		user = {Color(102, 153, 153), "Игрок"}
	}
}

function MetaPlayers:GetGroup()
	return self:GetUserGroup()
end

function MetaPlayers:HasAccess(Type)
	return table.HasValue(RAdmin["groups"][self:GetGroup()]["access"], Type)
end

function MetaPlayers:GetPrefix()
	return RAdmin["prefix"][self:GetGroup()]
end