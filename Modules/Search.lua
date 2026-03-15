local Search = {}

function Search.Create(parent,container)

    local box = Instance.new("TextBox")
    box.PlaceholderText = "Search..."
    box.Size = UDim2.new(1,0,0,28)
    box.Parent = parent

    box:GetPropertyChangedSignal("Text"):Connect(function()

        local query = box.Text:lower()

        for _,element in pairs(container:GetChildren()) do

            if element:IsA("Frame") or element:IsA("TextButton") then

                local name = element.Name:lower()

                if query == "" then
                    element.Visible = true
                else
                    element.Visible = name:find(query) ~= nil
                end

            end

        end

    end)

end

return Search
