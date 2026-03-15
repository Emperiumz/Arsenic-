local KeySystem = {}

function KeySystem:Create(settings)

    local gui = Instance.new("ScreenGui")
    gui.Parent = game.Players.LocalPlayer.PlayerGui

    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0,200,0,40)
    box.Parent = gui

    local button = Instance.new("TextButton")
    button.Text = "Submit"
    button.Parent = gui

    button.MouseButton1Click:Connect(function()

        if box.Text == settings.Key then
            gui:Destroy()
            settings.Callback(true)
        else
            box.Text = "Invalid"
        end

    end)

end

return KeySystem
