local class = {}
class.__index = class

function class.new(player)
	local self = setmetatable({}, class)
	self:Initialize(player)
	return self
end

function class:Initialize(player)
	self.Player = player
	self.Character = shared.Character.new(player)
end

return class
