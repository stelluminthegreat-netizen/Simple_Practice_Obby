local self = {}

function self.initialize()
	
end

function self.start()
	local remoteEvent = game.ReplicatedStorage.Remotes.Events.MinorTaskRequest
    remoteEvent.OnClientEvent:Connect(function(func, ...)
        self[func](...)
    end)
end

return self
