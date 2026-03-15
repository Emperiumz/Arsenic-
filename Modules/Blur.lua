local Lighting = game:GetService("Lighting")

local Blur = {}

function Blur.Enable()

    if Lighting:FindFirstChild("ArsenicBlur") then return end

    local b = Instance.new("BlurEffect")
    b.Size = 18
    b.Name = "ArsenicBlur"
    b.Parent = Lighting

end

function Blur.Disable()

    local b = Lighting:FindFirstChild("ArsenicBlur")

    if b then
        b:Destroy()
    end

end

return Blur
