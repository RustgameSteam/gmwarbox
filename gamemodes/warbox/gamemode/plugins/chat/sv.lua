util.AddNetworkString("CHAT:SendDefaultTextFromServer")
chat = {}
function chat.AddText(Player, ...)
	local Args = {...}
	net.Start("CHAT:SendDefaultTextFromServer")
		net.WriteTable(Args)
	net.Send(Player)
end