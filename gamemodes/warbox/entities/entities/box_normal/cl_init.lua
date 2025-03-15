include("shared.lua")

function ENT:Draw()
	self:DrawModel()
	self:SetColor(Color(255, self:GetNWInt("Health", 0), self:GetNWInt("Health", 0)))
	local Weapon = LocalPlayer():GetActiveWeapon()
	if(Weapon:GetClass() ~= "item_hammer")then return end
	-- Left
	if(WGUI.Entity3D2D(self, Vector(17, -14, 14), Angle(0, 90, 90), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("left")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end

	-- Right
	if(WGUI.Entity3D2D(self, Vector(-17, 14, 14), Angle(180, 90, -90), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("right")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end

	-- UP
	if(WGUI.Entity3D2D(self, Vector(-14, -14, 17), Angle(0, 90, 0), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("up")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end

	-- Down
	if(WGUI.Entity3D2D(self, Vector(14, -14, -17), Angle(0, 90, 180), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("down")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end

	--Back
	if(WGUI.Entity3D2D(self, Vector(-14, 17, 14), Angle(90, 90, 0), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("back")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end

	--Forward
	if(WGUI.Entity3D2D(self, Vector(14, -17, 14), Angle(90, 90, 180), 0.1, 90, 70))then
		local IsHover = WGUI.IsHovering(20, 20, 240, 240)
		draw.RoundedBox(0, 20, 20, 240, 240, Color(0,0,0, IsHover and 160 or 100))
		draw.DrawLine(100, 100, 180, 180, Color(255, 153, 51, IsHover and 255 or 200))
		surface.DrawLine(120, 140, 160, 140)
		surface.DrawLine(140, 120, 140, 160)
		if(IsHover)then
			if(WGUI.IsPressed())then
				net.Start("Warbox:CreateBox:ToXYZ")
					net.WriteEntity(self)
					net.WriteString("forward")
				net.SendToServer()
				Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
			end
		end
		WGUI.End3D2D()
	end
end