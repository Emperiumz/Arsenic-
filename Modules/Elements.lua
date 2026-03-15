local Elements = {}

function Elements.Toggle(parent,settings)

    local button = Instance.new("TextButton")
    button.Parent = parent
    button.Size = UDim2.new(1,0,0,30)
    button.Text = settings.Name

    local state = settings.Default or false

    button.MouseButton1Click:Connect(function()

        state = not state

        if settings.Callback then
            settings.Callback(state)
        end

    end)

end

function Elements.Slider(parent,settings)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,40)
    frame.Parent = parent

    local value = settings.Default or settings.Min

    if settings.Callback then
        settings.Callback(value)
    end

end

function Elements.Dropdown(parent,settings)

    local button = Instance.new("TextButton")
    button.Text = settings.Name
    button.Parent = parent

    for _,opt in ipairs(settings.Options) do

        local optBtn = Instance.new("TextButton")
        optBtn.Text = opt
        optBtn.Parent = parent

        optBtn.MouseButton1Click:Connect(function()

            if settings.Callback then
                settings.Callback(opt)
            end

        end)
    end

end

return Elements
