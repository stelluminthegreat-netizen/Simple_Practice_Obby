local dataManager = {}
dataManager.Profiles = {}
local updatePlayerData = game.ReplicatedStorage.Remotes.Events.UpdatePlayerData

function dataManager.RequestData(plr)
    updatePlayerData:FireServer(plr)
    dataManager.ReceiveData()
end

function dataManager.ReceiveData()
    updatePlayerData.OnClientEvent:Connect(function(plr, data)
        dataManager.Profiles[plr] = data  
    end)
end

return dataManager