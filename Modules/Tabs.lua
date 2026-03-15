local Tabs = {}
Tabs.__index = Tabs

function Tabs.new(window,name)

    local self = setmetatable({},Tabs)

    local button = Instance.new("TextButton")
    button.Text = name
    button.Parent = window.Main

    local page = Instance.new("Frame")
    page.Visible = false
    page.Parent = window.Main

    self.Button = button
    self.Page = page

    button.MouseButton1Click:Connect(function()

        for _,v in pairs(window.Main:GetChildren()) do
            if v:IsA("Frame") then
                v.Visible = false
            end
        end

        page.Visible = true
    end)

    return self
end

return Tabs
