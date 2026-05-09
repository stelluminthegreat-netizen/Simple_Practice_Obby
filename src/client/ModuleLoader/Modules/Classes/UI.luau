local functions = require(script.Parent.Parent.Data.UI_Functions)
local class = {}
class.__index = class

class.UIs = {}

function class.new(UI, parent)
	local self = setmetatable(UI:GetAttributes(), class)
	self.Player = game.Players.LocalPlayer
	self.UI = UI:Clone()
	self.Connections = {}
	self.Attributes = UI:GetAttributes()
	class.UIs[self.UI.Name] = self
	if parent ~= nil then self.UI.Parent = self.Player.PlayerGui:WaitForChild(parent) self:Initialize() end

	return self
end

function class:Initialize()
	print(self.UI, self.Parent)
	self.UI.Parent = self.Player.PlayerGui:FindFirstChild(self.Parent, true)
	for index, attribute in self do
		pcall(function()
			functions[attribute](self)
		end)
	end
end

function class:Destroy()
	class.UIs[self.UI.Name] = nil
	self.UI:Destroy()
	self.Player = nil

	for _, conn in self.Connections do
		conn:Disconnect()
	end
end

return class
