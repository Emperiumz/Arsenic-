local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

function Window.new(settings, Arsenic)

    local self = setmetatable({}, Window)

    self.Settings = settings
    self.Ar = Arsenic

    local player = Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Parent = player.PlayerGui
    gui.ResetOnSpawn = false

    self.Gui = gui

    local icon = Instance.new("ImageButton")
    icon.Size = UDim2.new(0,50,0,50)
    icon.Position = UDim2.new(0,20,0.5,0)
    icon.BackgroundTransparency = 1
    icon.Image = settings.FIcon or ""
    icon.Parent = gui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,650,0,420)
    frame.Position = UDim2.new(.5,-325,.5,-210)
    frame.Visible = false
    frame.Parent = gui

    self.Main = frame
    self.Icon = icon

    icon.MouseButton1Click:Connect(function()
        frame.Visible = not frame.Visible
    end)

    return self
end

return Window
