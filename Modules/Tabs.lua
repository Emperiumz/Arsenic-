local Layout = require(script.Parent.Layout)

local Tabs = {}
Tabs.__index = Tabs

function Tabs.new(window,name,icon)

    local self = setmetatable({},Tabs)

    local button = Instance.new("ImageButton")
    button.Size = UDim2.new(1,0,0,36)
    button.BackgroundTransparency = 1
    button.Image = icon or ""
    button.Parent = window.TabBar

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1,0,1,0)
    page.Visible = false
    page.BackgroundTransparency = 1
    page.Parent = window.Pages

    Layout.Vertical(page)

    button.MouseEnter:Connect(function()
        button.ImageColor3 = Color3.fromRGB(0,170,255)
    end)

    button.MouseLeave:Connect(function()
        button.ImageColor3 = Color3.new(1,1,1)
    end)

    button.MouseButton1Click:Connect(function()

        for _,v in pairs(window.Pages:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end

        page.Visible = true

    end)

    self.Page = page
    self.Window = window

    return self

end

function Tabs:CreateSection(name)

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,120)
    frame.Name = name
    frame.BackgroundTransparency = 1
    frame.Parent = self.Page

    local label = Instance.new("TextLabel")
    label.Text = name
    label.Size = UDim2.new(1,0,0,20)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = frame

    Layout.Vertical(frame)

    return frame

end

return Tabs
