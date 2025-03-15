net.Receive("CHAT:SendDefaultTextFromServer", function()
	local Args = net.ReadTable()
	chat.AddText(unpack(Args))
end)