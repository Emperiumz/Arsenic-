--// Arsenic UI Library
--// Single File Implementation

local Arsenic = {}

local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--------------------------------------------------
-- THEMES
--------------------------------------------------

local Themes = {

Dark = {
BG = Color3.fromRGB(18,18,18),
Accent = Color3.fromRGB(255,60,60),
Text = Color3.fromRGB(255,255,255)
},

Blue = {
BG = Color3.fromRGB(20,25,35),
Accent = Color3.fromRGB(0,170,255),
Text = Color3.fromRGB(255,255,255)
},

Light = {
BG = Color3.fromRGB(235,235,235),
Accent = Color3.fromRGB(0,120,255),
Text = Color3.fromRGB(0,0,0)
}

}

--------------------------------------------------
-- WINDOW CREATION
--------------------------------------------------

function Arsenic:CreateWindow(config)

local Theme = Themes[config.Theme or "Dark"]

--------------------------------------------------
-- GUI ROOT
--------------------------------------------------

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ArsenicUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

--------------------------------------------------
-- BLUR
--------------------------------------------------

local Blur = Instance.new("BlurEffect")
Blur.Size = 0
Blur.Parent = Lighting

--------------------------------------------------
-- FLOATING ICON
--------------------------------------------------

local Icon = Instance.new("ImageButton")
Icon.Size = UDim2.new(0,50,0,50)
Icon.Position = UDim2.new(0,20,0.5,0)
Icon.BackgroundColor3 = Theme.BG
Icon.Image = config.FIcon or "rbxassetid://0"
Icon.Parent = ScreenGui

Instance.new("UICorner",Icon).CornerRadius = UDim.new(1,0)

--------------------------------------------------
-- ICON DRAGGING
--------------------------------------------------

local dragging = false
local dragStart
local startPos

Icon.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
dragStart = input.Position
startPos = Icon.Position
end

end)

Icon.InputEnded:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end

end)

UIS.InputChanged:Connect(function(input)

if dragging then

local delta = input.Position - dragStart

Icon.Position = UDim2.new(
startPos.X.Scale,
startPos.X.Offset + delta.X,
startPos.Y.Scale,
startPos.Y.Offset + delta.Y
)

end

end)

--------------------------------------------------
-- MAIN WINDOW
--------------------------------------------------

local Window = Instance.new("Frame")
Window.Size = UDim2.new(0,620,0,430)
Window.Position = UDim2.new(.5,-310,.5,-215)
Window.BackgroundColor3 = Theme.BG
Window.Visible = false
Window.Parent = ScreenGui

Instance.new("UICorner",Window).CornerRadius = UDim.new(0,10)

--------------------------------------------------
-- TITLE
--------------------------------------------------

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,35)
Title.Text = config.Name or "Arsenic//"
Title.TextColor3 = Theme.Text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.BackgroundTransparency = 1
Title.Parent = Window

--------------------------------------------------
-- DESCRIPTION
--------------------------------------------------

local Desc = Instance.new("TextLabel")
Desc.Position = UDim2.new(0,0,0,35)
Desc.Size = UDim2.new(1,0,0,20)
Desc.Text = config.Description or ""
Desc.TextColor3 = Theme.Text
Desc.BackgroundTransparency = 1
Desc.TextSize = 13
Desc.Parent = Window

--------------------------------------------------
-- WINDOW DRAG
--------------------------------------------------

local dragWin = false
local start
local startPosWin

Title.InputBegan:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragWin = true
start = input.Position
startPosWin = Window.Position
end

end)

UIS.InputEnded:Connect(function(input)

if input.UserInputType == Enum.UserInputType.MouseButton1 then
dragWin = false
end

end)

UIS.InputChanged:Connect(function(input)

if dragWin then

local delta = input.Position - start

Window.Position = UDim2.new(
startPosWin.X.Scale,
startPosWin.X.Offset + delta.X,
startPosWin.Y.Scale,
startPosWin.Y.Offset + delta.Y
)

end

end)

--------------------------------------------------
-- CONTENT
--------------------------------------------------

local Content = Instance.new("Frame")
Content.Position = UDim2.new(0,10,0,65)
Content.Size = UDim2.new(1,-20,1,-75)
Content.BackgroundTransparency = 1
Content.Parent = Window

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0,8)
Layout.Parent = Content

--------------------------------------------------
-- OPEN WINDOW
--------------------------------------------------

Icon.MouseButton1Click:Connect(function()

Window.Visible = not Window.Visible

TweenService:Create(
Blur,
TweenInfo.new(.25),
{Size = Window.Visible and 18 or 0}
):Play()

end)

--------------------------------------------------
-- KEY SYSTEM
--------------------------------------------------

if config.Key_System then

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.new(0,300,0,150)
KeyFrame.Position = UDim2.new(.5,-150,.5,-75)
KeyFrame.BackgroundColor3 = Theme.BG
KeyFrame.Parent = ScreenGui

Instance.new("UICorner",KeyFrame)

local Box = Instance.new("TextBox")
Box.PlaceholderText = "Enter Key"
Box.Size = UDim2.new(1,-20,0,40)
Box.Position = UDim2.new(0,10,0,40)
Box.Parent = KeyFrame

local Submit = Instance.new("TextButton")
Submit.Text = "Submit"
Submit.Size = UDim2.new(1,-20,0,40)
Submit.Position = UDim2.new(0,10,0,90)
Submit.Parent = KeyFrame

Submit.MouseButton1Click:Connect(function()

if Box.Text == config.Key then
KeyFrame:Destroy()
Window.Visible = true
else
Box.Text = "Invalid Key"
end

end)

else
Window.Visible = true
end

--------------------------------------------------
-- LIBRARY API
--------------------------------------------------

local Library = {}

--------------------------------------------------
-- SECTION
--------------------------------------------------

function Library:CreateSection(text)

local Section = Instance.new("TextLabel")
Section.Size = UDim2.new(1,0,0,25)
Section.Text = text
Section.TextColor3 = Theme.Accent
Section.BackgroundTransparency = 1
Section.Font = Enum.Font.GothamBold
Section.TextXAlignment = Enum.TextXAlignment.Left
Section.Parent = Content

end

--------------------------------------------------
-- TOGGLE
--------------------------------------------------

function Library:CreateToggle(text,default,callback)

local Toggle = Instance.new("TextButton")
Toggle.Size = UDim2.new(1,0,0,35)
Toggle.Text = text
Toggle.TextColor3 = Theme.Text
Toggle.BackgroundColor3 = Theme.BG
Toggle.Parent = Content

Instance.new("UICorner",Toggle)

local state = default

Toggle.MouseButton1Click:Connect(function()

state = not state
callback(state)

end)

end

--------------------------------------------------
-- SLIDER
--------------------------------------------------

function Library:CreateSlider(text,min,max,default,callback)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(1,0,0,40)
Frame.BackgroundTransparency = 1
Frame.Parent = Content

local Label = Instance.new("TextLabel")
Label.Text = text.." : "..default
Label.Size = UDim2.new(1,0,0,20)
Label.TextColor3 = Theme.Text
Label.BackgroundTransparency = 1
Label.Parent = Frame

local Bar = Instance.new("Frame")
Bar.Size = UDim2.new(1,0,0,10)
Bar.Position = UDim2.new(0,0,0,25)
Bar.BackgroundColor3 = Theme.BG
Bar.Parent = Frame

Instance.new("UICorner",Bar)

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new(default/max,0,1,0)
Fill.BackgroundColor3 = Theme.Accent
Fill.Parent = Bar

local dragging = false

Bar.InputBegan:Connect(function(i)

if i.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = true
end

end)

UIS.InputEnded:Connect(function(i)

if i.UserInputType == Enum.UserInputType.MouseButton1 then
dragging = false
end

end)

UIS.InputChanged:Connect(function(i)

if dragging then

local pos = math.clamp(
(i.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X,
0,
1
)

Fill.Size = UDim2.new(pos,0,1,0)

local value = math.floor(min + (max-min)*pos)

Label.Text = text.." : "..value

callback(value)

end

end)

end

--------------------------------------------------
-- DROPDOWN
--------------------------------------------------

function Library:CreateDropdown(text,list,callback)

local Button = Instance.new("TextButton")
Button.Size = UDim2.new(1,0,0,35)
Button.Text = text
Button.TextColor3 = Theme.Text
Button.BackgroundColor3 = Theme.BG
Button.Parent = Content

Instance.new("UICorner",Button)

Button.MouseButton1Click:Connect(function()

local choice = list[math.random(1,#list)]
callback(choice)

end)

end

--------------------------------------------------
-- NOTIFICATION
--------------------------------------------------

function Library:Notify(text)

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,250,0,50)
Frame.Position = UDim2.new(1,-260,1,-60)
Frame.BackgroundColor3 = Theme.BG
Frame.Parent = ScreenGui

Instance.new("UICorner",Frame)

local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1,0,1,0)
Label.Text = text
Label.TextColor3 = Theme.Text
Label.BackgroundTransparency = 1
Label.Parent = Frame

TweenService:Create(Frame,TweenInfo.new(.4),
{Position = UDim2.new(1,-260,1,-120)}):Play()

task.wait(3)

TweenService:Create(Frame,TweenInfo.new(.4),
{Position = UDim2.new(1,-260,1,-60)}):Play()

task.wait(.4)
Frame:Destroy()

end

return Library

end

return Arsenic