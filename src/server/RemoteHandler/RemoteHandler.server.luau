local functions = require(script.Parent.RemoteFunctions)

-- REMOTE EVENTS
local UpdateKillPlrTarget = game.ReplicatedStorage.Remotes.Events.UpdateKillPlrTarget






-- REMOVE EVENT HANDLERS
UpdateKillPlrTarget.OnServerEvent:Connect(function(player, targetName)
    print("Called")
    functions.UpdateKillPlrTarget(player, targetName)
end)