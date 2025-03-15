print("[CLIENT] Создание массива [Clients]")
function nScrW(W)return ScrW() / 100 * W end
function nScrH(H)return ScrH() / 100 * H end
Warbox["clients"] = {
	fonts = {
		{"VGUI.Title", "Tahoma", 20, 600, false},
		{"VGUI.Button.Close", "Tahoma", 16, 600, false},
		{"VGUI.Topbar.Text", "Courier New", 16, 600, false},
		{"VoiceChat.Text", "Open Sans SemiBold", nScrH(2.2), 200, false},
	}
}

local metaEntities = FindMetaTable("Entity")
PlayerLEyePos = nil
CurSin = (math.sin(CurTime()) + 1) / 2
hook.Add("RenderScene", "SCP:PlayerLEyePos",function(POS)
	CurSin = (math.sin(CurTime()) + 1) / 2
	PlayerLEyePos = POS
end)

print("[CLIENT] Загрузка пользовательских шрифтов...")
for k, v in pairs(Warbox["clients"]["fonts"])do
	print("| "..v[1])
	surface.CreateFont(v[1],{font=v[2], size = v[3], weight = v[4], antialias = true, shadow = v[5], italic = false, extended = true})
end

function GetCustomFont(Key, Player)
	local Data = rSCP[Key]["customfonts"]["s"..Player:SteamID64()] or nil
	return (Data ~= nil) and Data.."." or ""
end

function SplitText(Text, Size)
	local Array = {}

	for i = 1, utf8.len(Text), Size do
		table.insert(Array, utf8.sub(Text, i, i + Size - 1))
	end

	return Array
end

function GetCutText(Text, Int)
	if(utf8.len(Text) > Int)then
		return utf8.sub(Text, 1, Int).."..."
	else
		return Text
	end
end

function GetDateFromSecs(inputNumber)
	local minutes = math.floor(inputNumber / 60)
	local seconds = inputNumber % 60
	return string.format("%02d:%02d", minutes, seconds)
end

function draw.Circle( x, y, radius, seg, color )
	local cir = {}
	table.insert( cir, { x = x, y = y, u = 0.5, v = 0.5 } )
	for i = 0, seg do
		local a = math.rad( ( i / seg ) * -360 )
		table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	end

	local a = math.rad( 0 )
	table.insert( cir, { x = x + math.sin( a ) * radius, y = y + math.cos( a ) * radius, u = math.sin( a ) / 2 + 0.5, v = math.cos( a ) / 2 + 0.5 } )
	surface.SetDrawColor( color.r, color.g, color.b, color.a or 0)
	draw.NoTexture()
	surface.DrawPoly( cir )
end

function draw.DrawLine(x1,y1,x2,y2,Color)
	surface.SetDrawColor(Color.r, Color.g, Color.b, Color.a or 255)
	surface.DrawLine(x1, y1, x2, y1)
	surface.DrawLine(x2, y1, x2, y2)
	surface.DrawLine(x2, y2, x1, y2)
	surface.DrawLine(x1, y2, x1, y1)
end

function draw.GetTextSize(Text, Font)
	surface.SetFont(Font)
	local w, h = surface.GetTextSize(Text)
	return w
end

function draw.InFOV(x, y, rad)
	local cx, cy = ScrW() / 2, ScrH() / 2
	local x1, y1, x2, y2 = x + rad, y + rad, x - rad, y - rad
	return (x1 > cx and y1 > cy and x2 < cx and y2 < cy)
end

function draw.DrawMaterial(fMaterial, x, y, w, h, fColor)
	surface.SetDrawColor(fColor.r, fColor.g, fColor.b, fColor.a)
	surface.SetMaterial(Material(fMaterial, "noclamp smooth"))
	surface.DrawTexturedRect(x, y, w, h)
end

function draw.SinRand()
	return (math.sin(CurTime()) + 1) / 2
end

local PANEL = {}
PANEL.IsPointer = false
PANEL.HoverColor = Color(0,0,0,0)
function PANEL:DoHover(FromColor, ToColor)
	self.HoverColor = FromColor
	function self:OnCursorEntered()self:SetCursor("hand")self.HoverColor = ToColor end
	function self:OnCursorExited()self:SetCursor("arrow")self.HoverColor = FromColor end
end
derma.DefineControl("DButtonEx", "Модифицированная версия", PANEL, "DButton")

function metaEntities:EntityDrawText(Name, Font, ppPos)
	local PlayersAngle = LocalPlayer():GetAngles()
	local lAng = Angle(0, PlayersAngle.y - 180, 0)
	local lPos = self:GetPos()
	lPos = lPos + (lAng:Up() * ppPos[1])
	lPos = lPos + (lAng:Forward() * ppPos[2])
	lPos = lPos + (lAng:Right() * ppPos[3])
	lAng:RotateAroundAxis(lAng:Right(), -90)
	lAng:RotateAroundAxis(lAng:Up(), 90)
	
	local Distance = LocalPlayer():GetPos():Distance(self:GetPos())

	if Distance < 300 then 
		cam.Start3D2D(lPos, lAng, 0.1)
		draw.RoundedBox(4, -(draw.GetTextSize(Name, Font)+60)/2, -28, draw.GetTextSize(Name, Font)+60, 57, Color(0,0,0,300-Distance))
		draw.SimpleText(Name, Font, 0,0, Color(255,255,255, 300-Distance), 1,1)
		cam.End3D2D()
	end
end