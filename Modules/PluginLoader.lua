local PluginLoader = {}

PluginLoader.Plugins = {}

function PluginLoader:Register(name,plugin)

    self.Plugins[name] = plugin

end

function PluginLoader:LoadAll(window)

    for name,plugin in pairs(self.Plugins) do

        if plugin.Init then
            plugin:Init(window)
        end

    end

end

return PluginLoader
