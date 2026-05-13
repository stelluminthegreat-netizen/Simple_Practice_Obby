local class = {}
class.__index = class
class.Characters = {}

function class.new(plr)
	local self = setmetatable({}, class)
	self:Initialize(plr)
	self.Connections = {}
	class.Characters[plr.Name] = self
	return self
end

function  class:Initialize(plr)
	self.Player = plr
	self.Character = plr.Character or plr.CharacterAdded:Wait()
	self.Died = shared.Event.new()
	self.Player.CharacterAdded:Connect(function(char)
		self.Character = char
	end)
end

function class:Kill()
	self.Died:Fire()
end




return class
