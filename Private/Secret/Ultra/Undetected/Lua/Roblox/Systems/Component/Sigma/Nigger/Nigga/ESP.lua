local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local LocalPlayer = Players.LocalPlayer

-- ESP SETTINGS (connect these to your GUI toggles)

local ESPEnabled = false
local BoxESP = false
local HealthESP = false
local NameESP = false
local DistanceESP = false
local LineESP = false
local LevelESP = false

-- ESP CACHE
local ESPContainer = {}

-- TEAM COLOR
local function getTeamColor(player)

	if player.Team then
		if player.Team.Name == "Pirates" then
			return Color3.fromRGB(255,0,0)
		elseif player.Team.Name == "Marines" then
			return Color3.fromRGB(0,120,255)
		end
	end

	return Color3.fromRGB(255,255,255)

end

-- CREATE ESP
local function createESP(player)

	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Filled = false
	box.Visible = false

	local name = Drawing.new("Text")
	name.Size = 13
	name.Center = true
	name.Outline = true
	name.Visible = false

	local distance = Drawing.new("Text")
	distance.Size = 13
	distance.Center = true
	distance.Outline = true
	distance.Visible = false

	local line = Drawing.new("Line")
	line.Thickness = 1
	line.Visible = false

	local health = Drawing.new("Line")
	health.Thickness = 3
	health.Visible = false

	local level = Drawing.new("Text")
	level.Size = 13
	level.Center = true
	level.Outline = true
	level.Visible = false

	ESPContainer[player] = {
		box = box,
		name = name,
		distance = distance,
		line = line,
		health = health,
		level = level
	}

end

-- PLAYER ADD
for _,player in pairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		createESP(player)
	end
end

Players.PlayerAdded:Connect(function(player)
	if player ~= LocalPlayer then
		createESP(player)
	end
end)

Players.PlayerRemoving:Connect(function(player)

	if ESPContainer[player] then

		for _,object in pairs(ESPContainer[player]) do
			object:Remove()
		end

		ESPContainer[player] = nil

	end

end)

-- MAIN ESP LOOP
RunService.RenderStepped:Connect(function()

	for player,esp in pairs(ESPContainer) do

		local character = player.Character
		local root = character and character:FindFirstChild("HumanoidRootPart")
		local humanoid = character and character:FindFirstChild("Humanoid")

		if ESPEnabled and root and humanoid and humanoid.Health > 0 then

			local pos, visible = Camera:WorldToViewportPoint(root.Position)

			if visible then

				local distance = (LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
				local size = math.clamp(3000 / distance, 2, 300)

				local color = getTeamColor(player)

				-- BOX
				if BoxESP then
					esp.box.Visible = true
					esp.box.Size = Vector2.new(size, size * 1.5)
					esp.box.Position = Vector2.new(pos.X - size/2, pos.Y - size/2)
					esp.box.Color = color
				else
					esp.box.Visible = false
				end

				-- NAME
				if NameESP then
					esp.name.Visible = true
					esp.name.Text = player.Name
					esp.name.Position = Vector2.new(pos.X, pos.Y - size)
					esp.name.Color = color
				else
					esp.name.Visible = false
				end

				-- DISTANCE
				if DistanceESP then
					esp.distance.Visible = true
					esp.distance.Text = math.floor(distance).."m"
					esp.distance.Position = Vector2.new(pos.X, pos.Y + size)
					esp.distance.Color = color
				else
					esp.distance.Visible = false
				end

				-- LINE
				if LineESP then
					esp.line.Visible = true
					esp.line.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
					esp.line.To = Vector2.new(pos.X, pos.Y)
					esp.line.Color = color
				else
					esp.line.Visible = false
				end

				-- HEALTH
				if HealthESP then

					local healthPercent = humanoid.Health / humanoid.MaxHealth

					esp.health.Visible = true
					esp.health.From = Vector2.new(pos.X - size/2 - 6, pos.Y + size/2)
					esp.health.To = Vector2.new(pos.X - size/2 - 6, pos.Y + size/2 - (size * healthPercent))
					esp.health.Color = Color3.fromRGB(0,255,0)

				else
					esp.health.Visible = false
				end

				-- LEVEL
				if LevelESP then

					local data = player:FindFirstChild("Data")
					local level = data and data:FindFirstChild("Level")

					if level then
						esp.level.Visible = true
						esp.level.Text = "Lv "..level.Value
						esp.level.Position = Vector2.new(pos.X, pos.Y - size - 15)
						esp.level.Color = color
					end

				else
					esp.level.Visible = false
				end

			else

				for _,object in pairs(esp) do
					object.Visible = false
				end

			end

		else

			for _,object in pairs(esp) do
				object.Visible = false
			end

		end

	end

end)
