local functions = {}

function functions.Open(UI_Obj)
    local UIs = game.ReplicatedStorage.UIs
    local UI = UI_Obj.UI

    UI.MouseButton1Click:Connect(function()
         for _, attribute in UI_Obj do
            local ui = UIs:FindFirstChild(attribute, true)
            if not ui  then continue end
            shared.UI.new(ui)
        end
    end)
end

return functions