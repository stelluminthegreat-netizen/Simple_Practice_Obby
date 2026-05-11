task.wait(0.25)
local Players = shared.Player.Players
local dataManager = {}

dataManager.profiles = {}

function  dataManager.UpdateLeaderstats(plrName, statsName, changes)
	local player = Players[plrName].Player
	local stats = player.leaderstats[statsName]
	changes(player, stats)
end

function dataManager.RespondToDataRequest()
	local remoteEvent = game.ReplicatedStorage.Remotes.Events.UpdatePlayerData
	remoteEvent.OnServerEvent:Connect(function(plr)
		dataManager.UpdatePlayerData(plr)
	end)
end

function dataManager.UpdatePlayerData(plr)
	local remoteEvent = game.ReplicatedStorage.Remotes.Events.UpdatePlayerData
	remoteEvent:FireClient(plr, plr, dataManager.profiles[plr].Data)
end

return dataManager
