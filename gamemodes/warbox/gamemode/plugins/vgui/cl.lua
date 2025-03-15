function VGUI(Title, Width, Height, Center)
	local FRAME = vgui.Create("DFrame")
	FRAME:SetTitle("")
	FRAME:SetSize(nScrW(Width), nScrH(Height))
	FRAME:MakePopup()
	if(Center)then
		FRAME:Center()
	end

	local CLOSE = vgui.Create("DButton", FRAME)
	CLOSE:SetText("")
	CLOSE:SetPos(FRAME:GetWide() - 60, 4)
	CLOSE:SetSize(60, 20)
	CLOSE.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(204, 0, 0))
		draw.DrawText("X", "VGUI.Button.Close", w / 2, 1, Color(255,255,255), TEXT_ALIGN_CENTER)
	end
	CLOSE.DoClick = function()
		FRAME:Close()
	end

	function FRAME:ShowClose(bShow)
		if(bShow)then
			CLOSE:Show()
		else
			CLOSE:Hide()
		end
	end

	FRAME:ShowCloseButton(false)
	FRAME.Paint = function(self, w, h)
		draw.RoundedBox(2, 0, 0, w, h, Color(128, 128, 128))
		if(Title ~= nil)then
			draw.RoundedBox(2, 0, 0, w, 4, Color(166, 166, 166))
			draw.RoundedBox(0, 0, 4, w - 60, 20, Color(115, 115, 115))
			draw.DrawText(Title, "VGUI.Title", 10, 2, Color(255,255,255), TEXT_ALIGN_LEFT)
			surface.SetDrawColor(200, 200, 200)
			surface.DrawLine(0, 24, w, 24)
		end
	end

	local PANEL = vgui.Create("DPanel", FRAME)
	PANEL:SetPos(0, 25)
	PANEL:SetSize(FRAME:GetWide(), FRAME:GetTall() - 25)
	PANEL.Paint = function()

	end

	function PANEL:ReScroll(Element, Size, Main, Grid, Up, Down)
		local EL = Element:GetVBar()
		EL:SetSize(Size)
		EL.Paint = function() draw.RoundedBox(0, 0, 0, EL:GetWide(), EL:GetTall(), Main) end
		EL.btnGrip.Paint = function() draw.RoundedBox(0, 0, 0, EL.btnGrip:GetWide(), EL.btnGrip:GetTall(), Grid) end
		EL.btnUp.Paint = function() draw.RoundedBox(0, 0, 0, EL.btnUp:GetWide(), EL.btnUp:GetTall(), Up) end
		EL.btnDown.Paint = function() draw.RoundedBox(0, 0, 0, EL.btnDown:GetWide(), EL.btnDown:GetTall(), Down) end
	end

	return FRAME, PANEL
end