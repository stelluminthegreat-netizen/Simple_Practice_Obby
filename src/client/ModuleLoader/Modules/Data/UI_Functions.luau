local functions = {}

function functions.Open(UI_Obj)
    local UIs = game.ReplicatedStorage.UIs
    for _, attribute in UI_Obj do
        local ui = UIs:FindFirstChild(attribute, true)
        if not ui  then continue end
        shared.UI.new(ui)
    end
end

return functions