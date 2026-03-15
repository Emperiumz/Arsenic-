local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local Notifications = {}

function Notifications:Create()

    local holder = Instance.new("ScreenGui")
    holder.Name = "ArsenicNotifications"
    holder.ResetOnSpawn = false
    holder.Parent = Players.LocalPlayer.PlayerGui

    local frame = Instance.new("Frame")
    frame.AnchorPoint = Vector2.new(1,1)
    frame.Position = UDim2.new(1,-10,1,-10)
    frame.Size = UDim2.new(0,260,0,400)
    frame.BackgroundTransparency = 1
    frame.Parent = holder

    local list = Instance.new("UIListLayout")
    list.Parent = frame
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Padding = UDim.new(0,6)

    self.Container = frame
end

function Notifications:Notify(title,text)

    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1,0,0,40)
    notif.BackgroundColor3 = Color3.fromRGB(25,25,25)
    notif.Parent = self.Container

    local label = Instance.new("TextLabel")
    label.Text = title.." - "..text
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1,1,1)
    label.Parent = notif

    TweenService:Create(
        notif,
        TweenInfo.new(.3),
        {BackgroundTransparency = 0}
    ):Play()

    task.delay(4,function()
        notif:Destroy()
    end)

end

return Notifications
