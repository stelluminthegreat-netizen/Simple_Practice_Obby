local dataManager = {}
local remoteFunction = game.ReplicatedStorage.Remotes.Functions.PlayerDataBridge

function dataManager.RequestData(plr)
    local data = remoteFunction:InvokeServer()
    dataManager.StoreData(plr, data)
end

function dataManager.StoreData(plr, data)
    dataManager[plr] = data
end

return dataManager