local self = {}

function self.initialize()
	
end

function self.start()
	shared.Task:Wait(24)
	shared.UI.new(game.ReplicatedStorage.UIs.Open_Kill_Plr_Prompt.Open_Kill_Plr_Prompt, "Main")
end

return self
