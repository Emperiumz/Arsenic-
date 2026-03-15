local Scaling = {}

function Scaling.Apply(root)

    local scale = Instance.new("UIScale")
    scale.Parent = root

    local function update()

        local viewport = workspace.CurrentCamera.ViewportSize
        local base = 1920

        scale.Scale = math.clamp(viewport.X/base,0.7,1.2)

    end

    update()

    workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(update)

end

return Scaling
