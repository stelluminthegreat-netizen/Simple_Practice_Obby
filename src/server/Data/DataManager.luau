task.wait(0.25)
local Players = shared.Player.Players
local dataManager = {}

dataManager.profiles = {}

function  dataManager.UpdateLeaderstats(plrName, statsName, changes)
	local player = Players[plrName].Player
	local stats = player.leaderstats[statsName]
	changes(player, stats)
end
return dataManager
