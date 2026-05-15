local remoteEvent = game.ReplicatedStorage.Remotes.Events.MinorTaskRequest


local handlers = {}


remoteEvent.OnClientEvent:Connect(function(func, ...)
    handlers[func](...)
end)

return handlers