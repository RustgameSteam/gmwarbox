util.AddNetworkString("Warbox:CreateBox:ToXYZ")

net.Receive("Warbox:CreateBox:ToXYZ", function(Len, Player)
	local Weapon = Player:GetActiveWeapon()
	if(Weapon:GetClass() ~= "item_hammer")then return end
	local ParentBox = net.ReadEntity()
	local Action = net.ReadString()

	local ParentPos = ParentBox:GetPos()

	if(Action == "up")then
		ParentPos = ParentPos + Vector(0,0,36)
	elseif(Action == "down")then
		ParentPos = ParentPos + Vector(0,0,-36)
	elseif(Action == "forward")then
		ParentPos = ParentPos + Vector(0,-36,0)
	elseif(Action == "back")then
		ParentPos = ParentPos + Vector(0,36,0)
	elseif(Action == "left")then
		ParentPos = ParentPos + Vector(36,0,0)
	elseif(Action == "right")then
		ParentPos = ParentPos + Vector(-36,0,0)
	end

	local IsAllowCreate = true
	for k, v in pairs(ents.FindInSphere(ParentPos, 16.5))do
		print(v)
		if(v:IsPlayer() or v:GetClass() == "box_normal" or v:GetClass() == "box_metal")then
			IsAllowCreate = false
			break
		end
	end

	if(!IsAllowCreate)then
		chat.AddText(Player, Color(0, 153, 204), "[",Color(255, 153, 0), "#",Color(0, 153, 204), "] ",Color(255, 255, 255), "Что то мешает!")
	else
		local Box = ents.Create("box_normal")
		Box:SetPos(ParentPos)
		Box:Spawn()

		Player:SetAnimation(PLAYER_ATTACK1)
		Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	end

	--for k, v in pairs(ents.FindInBox(, boxMaxs))
end)