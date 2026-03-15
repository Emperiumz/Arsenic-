local Arsenic = {}

local Modules = script.Modules
local Themes = script.Themes

local Window = require(Modules.Window)
local Tabs = require(Modules.Tabs)
local Elements = require(Modules.Elements)
local Animations = require(Modules.Animations)
local Config = require(Modules.Config)
local KeySystem = require(Modules.KeySystem)

Arsenic.Modules = {
    Window = Window,
    Tabs = Tabs,
    Elements = Elements,
    Animations = Animations,
    Config = Config,
    KeySystem = KeySystem
}

Arsenic.Themes = {
    Dark = require(Themes.Dark),
    Light = require(Themes.Light),
    Neon = require(Themes.Neon)
}

function Arsenic:CreateWindow(settings)
    return Window.new(settings, Arsenic)
end

return Arsenic
