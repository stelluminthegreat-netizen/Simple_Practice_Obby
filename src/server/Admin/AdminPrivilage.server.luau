local products = require(script.Parent.Parent.MonitaryHandler.Products)
local adminKillPlayer = game.ReplicatedStorage.Remotes.Events.AdminKillPlayer

adminKillPlayer.OnServerEvent:Connect(function(player)
    products[3590489186](nil, player)
end)