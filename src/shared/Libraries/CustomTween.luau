local tweenServ = game:GetService("TweenService")
local CustomTween = {}

function CustomTween.ScaleModel(model, startScale, endScale, duration)
	local scaleValue = Instance.new("NumberValue")
	scaleValue.Value = startScale

	local tween = tweenServ:Create(
		scaleValue,
		TweenInfo.new(
			duration,
			Enum.EasingStyle.Exponential,
			Enum.EasingDirection.Out
		),
		{Value = endScale}
	)
	
	local conn
	conn = scaleValue:GetPropertyChangedSignal("Value"):Connect(function()
		model:ScaleTo(scaleValue.Value)
		if scaleValue.Value == endScale then conn:Disconnect() end
	end)
	
	return tween
end

function CustomTween.TweenTransparency(basePart, targetTransparency, duration)
	local tween = tweenServ:Create(
		basePart,
		TweenInfo.new(
			duration,
			Enum.EasingStyle.Exponential,
			Enum.EasingDirection.Out
		),
		{Transparency = targetTransparency})
	
	return tween
end

return CustomTween
