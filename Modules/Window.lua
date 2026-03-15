local Players = game:GetService("Players")

local Drag = require(script.Parent.Drag)
local Blur = require(script.Parent.Blur)
local Scaling = require(script.Parent.Scaling)

local Window = {}
Window.__index = Window

function Window.new(settings,Arsenic)

    local self = setmetatable({},Window)

    local player = Players.LocalPlayer

    local gui = Instance.new("ScreenGui")
    gui.Name = "ArsenicUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    local icon = Instance.new("ImageButton")
    icon.Size = UDim2.new(0,50,0,50)
    icon.Position = UDim2.new(0,20,0.5,0)
    icon.BackgroundTransparency = 1
    icon.Image = settings.FIcon or ""
    icon.Parent = gui

    Drag.Make(icon)

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0,650,0,420)
    main.Position = UDim2.new(.5,-325,.5,-210)
    main.BackgroundColor3 = Arsenic.Themes[settings.Theme or "Dark"].Background
    main.Visible = false
    main.Parent = gui

    Drag.Make(main)

    Scaling.Apply(main)

    icon.MouseButton1Click:Connect(function()

        main.Visible = not main.Visible

        if main.Visible then
            Blur.Enable()
        else
            Blur.Disable()
        end

    end)

    local tabBar = Instance.new("Frame")
    tabBar.Size = UDim2.new(0,120,1,0)
    tabBar.BackgroundTransparency = 1
    tabBar.Parent = main

    local pageContainer = Instance.new("Frame")
    pageContainer.Position = UDim2.new(0,120,0,0)
    pageContainer.Size = UDim2.new(1,-120,1,0)
    pageContainer.BackgroundTransparency = 1
    pageContainer.Parent = main

    self.Gui = gui
    self.Main = main
    self.TabBar = tabBar
    self.Pages = pageContainer
    self.Ar = Arsenic

    return self

end

function Window:CreateTab(name,icon)
    return self.Ar.Modules.Tabs.new(self,name,icon)
end

return Window
