hook.Add("HUDDrawTargetID","HUDPaintTarget", function() return false end)
--hook.Add("InitPostEntity", "RemoveChatBubble", function() hook.Remove("StartChat", "StartChatIndicator") hook.Remove("FinishChat", "EndChatIndicator") end)
local hidden = {"DarkRP_HUD", "DarkRP_Hungermod", "CHudHealth", "CHudBattery", "CHudAmmo", "CHudSecondaryAmmo", "CHudDamageIndicator", "CHudDeathNotice", "CHudVoiceStatus"}
hook.Add("HUDShouldDraw", "CHUD_Hide", function(name) if table.HasValue(hidden, name) then return false end end)
RunConsoleCommand("hud_deathnotice_time", 0)
WhoPlayerSpeaking = WhoPlayerSpeaking or {}
local WBCenter = Vector(-760, 3180, 600)
hook.Add("HUDPaint","WB:HUDPaint", function()
    draw.RoundedBox(0, 0, 0, ScrW(), 30, Color(0,0,0,200))
    local CurPos = WBCenter - LocalPlayer():GetPos()

    draw.DrawText("x["..math.Round(CurPos.x / 36).."] y["..math.Round(CurPos.y / 36).."] z["..math.abs(math.Round(CurPos.z / 36 / 3)).."]", "VGUI.Topbar.Text", 10, 6, Color(255,255,255), TEXT_ALIGN_LEFT)
end)

hook.Add("PlayerStartVoice", "SCP:TrackPlayerVoice", function(Player)
	if(!WhoPlayerSpeaking[Player])then
		WhoPlayerSpeaking[Player] = true
	end

	return true
end)

hook.Add("PlayerEndVoice", "SCP:TrackPlayerVoiceEnd", function(Player)
	if(WhoPlayerSpeaking[Player])then
		WhoPlayerSpeaking[Player] = nil
	end
end)

local DefaultVoice = Color(0, 0, 0)
local MidVoice = Color(255, 165, 0)
local HighVoice = Color(255, 0, 0)

local function GetVoiceColor(Terp)
	if(Terp < 0.5)then
		local r = DefaultVoice.r + (MidVoice.r - DefaultVoice.r) * (Terp * 2)
		local g = DefaultVoice.g + (MidVoice.g - DefaultVoice.g) * (Terp * 2)
		local b = DefaultVoice.b + (MidVoice.b - DefaultVoice.b) * (Terp * 2)
		return Color(r, g, b)
	else
		local r = MidVoice.r + (HighVoice.r - MidVoice.r) * ((Terp - 0.5) * 2)
		local g = MidVoice.g + (HighVoice.g - MidVoice.g) * ((Terp - 0.5) * 2)
		local b = MidVoice.b + (HighVoice.b - MidVoice.b) * ((Terp - 0.5) * 2)
		return Color(r, g, b, 170)
	end
end

hook.Add("HUDPaint", "WB:DrawVoiceChat", function()
	local X, Y = ScrW() - 30, ScrH() - nScrH(14)
	local Pos = 0
	local Limit = 27
	local PlayerPos = LocalPlayer():GetPos()
	for v, _ in pairs(WhoPlayerSpeaking)do
		if(IsValid(v))then
			local Name = v:Name() .. " [$." .. v:UserID() .. "]"
			local Width = draw.GetTextSize(Name, "VoiceChat.Text")
			draw.RoundedBox(4, X - Width - 15, Y - (Pos * 32), Width + 25, 30, GetVoiceColor(v:VoiceVolume()))
			draw.RoundedBox(4, X - Width - 15, Y - (Pos * 32), 5, 30, Color(53,53,53))
			
			draw.DrawText(Name, "VoiceChat.Text", X - Width, Y + 3 - (Pos * 32), Color(255,255,255), TEXT_ALIGN_LEFT)
			Pos = Pos + 1
		end
	end
end)