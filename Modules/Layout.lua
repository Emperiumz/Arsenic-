local Layout = {}

function Layout.Vertical(parent,padding)

    local list = Instance.new("UIListLayout")
    list.Padding = UDim.new(0,padding or 6)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = parent

    local pad = Instance.new("UIPadding")
    pad.PaddingTop = UDim.new(0,6)
    pad.PaddingLeft = UDim.new(0,6)
    pad.PaddingRight = UDim.new(0,6)
    pad.Parent = parent

    return list
end

return Layout
