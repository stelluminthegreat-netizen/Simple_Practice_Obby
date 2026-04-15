for index, descendant in script.Parent.Modules:GetDescendants() do
	if descendant.ClassName == "ModuleScript" then shared[descendant.Name] = require(descendant) end
end

for index, module in shared do if type(module.initialize) == "function" then module.initialize() end end
for index, module in shared do if type(module.start) == "function" then task.defer(module.start) end end