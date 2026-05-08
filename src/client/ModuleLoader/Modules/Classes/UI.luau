local functions = require(script.Parent.Parent.Data.UI_Functions)
local class = {}
class.__index = class

class.UIs = {}

function class.new(UI)
	local self = setmetatable(UI:GetAttributes(), class)
	self.Player = game.Players.LocalPlayer
	self.UI = UI:Clone()
	self.Connections = {}
	self:Initialize()
	class.UIs[self.UI.Name] = self

	return self
end

function class:Initialize()
	self.UI.Parent = self.Player.PlayerGui:FindFirstChild(self.Parent, true)
	for index, attribute in self do
		pcall(function()
			functions[attribute](self)
		end)
	end
end

function class:Destroy()
	self.UI:Destroy()
	self.Player = nil

	for _, conn in self.Connections do
		conn:Disconnect()
	end
end

return class
