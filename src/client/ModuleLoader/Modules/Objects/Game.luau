local self = {}

function self.initialize()
	
end

function self.start()
	shared.Task:Wait(24)
	shared.UI.new(game.ReplicatedStorage.UIs.OpenFold.OpenBtn, "Main")
end

return self
