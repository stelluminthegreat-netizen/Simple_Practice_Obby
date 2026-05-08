local functions = require(script.Parent.Parent.Data.UI_Functions)
local class = {}
class.__index = class

function class.new(UI)
	local self = setmetatable(UI:GetAttributes(), class)
	self.Player = game.Players.LocalPlayer
	self.UI = UI:Clone()
	self.UI.Parent = self.Player.PlayerGui:WaitForChild("Main")
	self.Connections = {}
	self:Initialize()

	return self
end

function class:Initialize()
	for index, attribute in self do
		pcall(function()
			functions[attribute](self)
		end)
	end
end

return class
