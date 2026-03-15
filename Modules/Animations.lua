local TweenService = game:GetService("TweenService")

local Animations = {}

function Animations.Tween(object, props, time, style, direction)

    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            time or 0.25,
            style or Enum.EasingStyle.Quad,
            direction or Enum.EasingDirection.Out
        ),
        props
    )

    tween:Play()
    return tween
end

function Animations.Fade(object, target)
    Animations.Tween(object,{
        BackgroundTransparency = target
    },0.25)
end

return Animations
