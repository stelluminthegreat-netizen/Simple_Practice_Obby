local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local self = {}

function self.initialize()
	
end

function self.start()
	local remoteEvent = game.ReplicatedStorage.Remotes.Events.MinorTaskRequest
    remoteEvent.OnClientEvent:Connect(function(func, ...)
        if not func then warn("No function received.") return end
        if not self[func] then warn("Function does not exist.") return end
        self[func](...)
    end)
end

-- FUNCTIONS

function self.PlaySound(soundName)
    local sound = game.ReplicatedStorage.Audios[soundName]:Clone()
    sound.Parent = SoundService
    sound:Play()
    sound.Completed:Wait()
    sound:Destroy()
end



return self
