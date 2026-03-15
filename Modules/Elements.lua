local UserInputService = game:GetService("UserInputService")

local Elements = {}

function Elements.Toggle(parent,settings)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,32)
    frame.Parent = parent

    local button = Instance.new("TextButton")
    button.Text = settings.Name
    button.Size = UDim2.new(1,0,1,0)
    button.Parent = frame

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

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1,0,0,6)
    bar.Position = UDim2.new(0,0,.5,0)
    bar.Parent = frame

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new(0,0,1,0)
    fill.Parent = bar

    local dragging = false

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)

        if dragging then

            local percent =
                (input.Position.X - bar.AbsolutePosition.X)
                / bar.AbsoluteSize.X

            percent = math.clamp(percent,0,1)

            fill.Size = UDim2.new(percent,0,1,0)

            local value =
                settings.Min +
                (settings.Max-settings.Min)*percent

            if settings.Callback then
                settings.Callback(value)
            end

        end

    end)

end

function Elements.Dropdown(parent,settings)

    local button = Instance.new("TextButton")
    button.Text = settings.Name
    button.Parent = parent

    local container = Instance.new("Frame")
    container.Visible = false
    container.Parent = parent

    for _,option in ipairs(settings.Options) do

        local opt = Instance.new("TextButton")
        opt.Text = option
        opt.Parent = container

        opt.MouseButton1Click:Connect(function()

            container.Visible = false

            if settings.Callback then
                settings.Callback(option)
            end

        end)

    end

    button.MouseButton1Click:Connect(function()
        container.Visible = not container.Visible
    end)

end

function Elements.Keybind(parent,settings)

    local button = Instance.new("TextButton")
    button.Text = settings.Name.." [None]"
    button.Parent = parent

    local binding = nil

    button.MouseButton1Click:Connect(function()

        button.Text = "Press Key..."

        local input = UserInputService.InputBegan:Wait()

        binding = input.KeyCode

        button.Text = settings.Name.." ["..binding.Name.."]"

    end)

    UserInputService.InputBegan:Connect(function(input)

        if input.KeyCode == binding then

            if settings.Callback then
                settings.Callback()
            end

        end

    end)

end

return Elements
