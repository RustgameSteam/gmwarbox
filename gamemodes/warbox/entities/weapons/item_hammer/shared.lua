SWEP.Base 				= "weapon_base"
SWEP.PrintName			= "Молоток"
SWEP.Author				= "Rustgame"
SWEP.Instructions		= ""
SWEP.UseHands 			= true

SWEP.Spawnable 			= true
SWEP.AdminOnly 			= false

SWEP.Category			= "| Основное"

SWEP.HoldType 			= "melee"
SWEP.Slot				= 1
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.WorldModel			= "models/weapons/w_buzzhammer.mdl"
SWEP.ViewModel			= "models/Weapons/v_hammer/v_hammer.mdl"

SWEP.ViewModelFlip		= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "none"
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= 0
SWEP.Secondary.Automatic	= true
SWEP.Secondary.Ammo			= "none"

SWEP.Offset = {
	Pos = {Up = -5, Right = 1, Forward = 3, },
	Ang = {Up = 0, Right = 0, Forward = 90,}
}

function SWEP:Initialize()
	self:SetHoldType("melee")
end

function SWEP:PrimaryAttack()
	local Player = self:GetOwner()
	local trace = self.Owner:GetEyeTrace()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav",100, math.random(90,120))
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SetNextPrimaryFire(CurTime() + 0.22)
	if(trace.HitPos:Distance(self.Owner:GetShootPos()) <= 60)then
		if(trace.Hit)then
			self:SendWeaponAnim(ACT_VM_HITCENTER)
			util.Decal("Cross", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal)
			local FBullet = {Num = 1, Src = self.Owner:GetShootPos(), Dir = self.Owner:GetAimVector(), Spread = Vector(0, 0, 0), Tracer = 0, Force  = 0, Damage = 0}
			self.Owner:FireBullets(FBullet)
			local Box = trace.Entity
			if(Box:GetClass() == "box_normal")then
				if(SERVER)then
					local HP = Box:GetNWInt("Health", 0)
					HP = HP + 15
					if(HP > 255)then
						HP = 255
					end
					Box:SetNWInt("Health", HP)
				end
			elseif(Box:GetClass() == "box_metal")then
				if(SERVER)then
					local HP = Box:GetNWInt("Health", 0)
					HP = HP + 15
					if(HP > 510)then
						HP = 510
					end
					Box:SetNWInt("Health", HP)
				end
			end
		else
			self:SendWeaponAnim(ACT_VM_MISSCENTER)
		end
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
	end

	return false
end

function SWEP:SecondaryAttack()
	local Player = self:GetOwner()
	local trace = self.Owner:GetEyeTrace()
	self:EmitSound("weapons/iceaxe/iceaxe_swing1.wav",100, math.random(90,120))
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:SetNextSecondaryFire(CurTime() + 0.26)
	if(trace.HitPos:Distance(self.Owner:GetShootPos()) <= 60)then
		if(trace.Hit)then
			self:SendWeaponAnim(ACT_VM_HITCENTER)
			local Box = trace.Entity
			local FBullet = {Num = 1, Src = self.Owner:GetShootPos(), Dir = self.Owner:GetAimVector(), Spread = Vector(0, 0, 0), Tracer = 0, Force  = 0, Damage = 0}
			self.Owner:FireBullets(FBullet)
			if(Box:GetClass() == "box_normal")then
				if(SERVER)then
					local HP = Box:GetNWInt("Health", 0)
					HP = HP - 150
					if(HP <= 0)then
						self:EmitSound("physics/wood/wood_box_break"..math.random(1, 2)..".wav")
						Box:Remove()
					else
						Box:SetNWInt("Health", HP)
					end
				end
			elseif(Box:GetClass() == "box_metal")then
				if(SERVER)then
					local HP = Box:GetNWInt("Health", 0)
					HP = HP - 150
					if(HP <= 0)then
						self:EmitSound("physics/wood/wood_box_break"..math.random(1, 2)..".wav")
						Box:Remove()
					else
						Box:SetNWInt("Health", HP)
					end
				end
			end
		else
			self:SendWeaponAnim(ACT_VM_MISSCENTER)
		end
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
	end

	return false
end

function SWEP:DrawWorldModel( )
	local hand, offset, rotate
	local Player = self:GetOwner()
	if(IsValid(Player))then
		local boneIndex = Player:LookupBone( "ValveBiped.Bip01_R_Hand" )
		if(boneIndex)then
			local pos, ang = Player:GetBonePosition(boneIndex)
		  	pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
			ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
			ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
			ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
			self:SetRenderOrigin(pos)
			self:SetRenderAngles(ang)
			self:DrawModel()
		end
	else
		self:SetRenderOrigin(nil)
		self:SetRenderAngles(nil)
		self:DrawModel()
	end
end

function SWEP:OnRemove()
	return true 
end

function SWEP:Deploy()
	self.Owner:DrawViewModel(true)
	self.Weapon:SendWeaponAnim(ACT_VM_IDLE)
end