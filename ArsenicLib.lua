local Arsenic = {}

local Modules = script.Modules
local Themes = script.Themes

local Window = require(Modules.Window)
local Tabs = require(Modules.Tabs)
local Elements = require(Modules.Elements)
local Animations = require(Modules.Animations)
local Layout = require(Modules.Layout)
local Drag = require(Modules.Drag)
local Blur = require(Modules.Blur)
local Notifications = require(Modules.Notifications)
local Config = require(Modules.Config)
local KeySystem = require(Modules.KeySystem)
local Scaling = require(Modules.Scaling)
local Search = require(Modules.Search)
local PluginLoader = require(Modules.PluginLoader)

Arsenic.Modules = {
    Window = Window,
    Tabs = Tabs,
    Elements = Elements,
    Animations = Animations,
    Layout = Layout,
    Drag = Drag,
    Blur = Blur,
    Notifications = Notifications,
    Config = Config,
    KeySystem = KeySystem,
    Scaling = Scaling,
    Search = Search,
    PluginLoader = PluginLoader
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
