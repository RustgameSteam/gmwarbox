include('shared.lua')

function SWEP:Holster()
	return true
end

function SWEP:DoDrawCrosshair(X, Y)
	draw.Circle(X, Y, 4, 8, Color(255,255,255))
	return true
end