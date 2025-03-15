AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/warbox/boxs/1x1x1/b.mdl")
	
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:PhysicsInit(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	if(IsValid(phys))then
		phys:Wake()
		phys:EnableMotion(false)
	end

	self:SetNWInt("Health", 255)
end

function ENT:OnTakeDamage(DMGInfo)
	local Damage = DMGInfo:GetDamage()
	local Health = self:GetNWInt("Health", 0)
	Health = Health - math.Round(Damage)
	if(Health <= 0)then
		self:EmitSound("physics/wood/wood_box_break"..math.random(1, 2)..".wav")
		self:Remove()
	else
		self:SetNWInt("Health", Health)
	end
end