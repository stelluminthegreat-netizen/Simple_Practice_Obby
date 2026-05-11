local functions = {}

function functions.UpdateKillPlrTarget(plr, targetName)
    print(plr, targetName)
    plr.KillPlayerTarget.Value = targetName
end

return functions