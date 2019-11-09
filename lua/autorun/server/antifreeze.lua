require("antifreeze")

timer.Create( "antifreeze", 1, 0, function()
	WatchDogPing()
end)