local HttpService = game:GetService("HttpService")

local Config = {}

function Config:Save(name,data)

    local encoded = HttpService:JSONEncode(data)

    writefile("Arsenic/"..name..".json",encoded)

end

function Config:Load(name)

    if isfile("Arsenic/"..name..".json") then

        local data = readfile("Arsenic/"..name..".json")
        return HttpService:JSONDecode(data)

    end

end

return Config
