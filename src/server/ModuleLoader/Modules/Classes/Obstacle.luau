local class = {}
class.__index = class
local functions = require(shared.ObstacleFunctions)

function class.new(model)
	local self = setmetatable(model:GetAttributes(), class)
	self.Model = model
	self.Connections = {}
	self.DamagingList = {}
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
