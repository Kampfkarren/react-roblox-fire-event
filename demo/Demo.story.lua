-- One day, when jest and Lune are there, make this a .spec
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local React = require(ReplicatedStorage.DevPackages.React)
local ReactRoblox = require(ReplicatedStorage.DevPackages.ReactRoblox)
local fireEvent = require(ReplicatedStorage.DevPackages.fireEvent)

local e = React.createElement

local function Story()
	local clickCount, setClickCount = React.useState(0)

	return e("TextButton", {
		Size = UDim2.fromScale(1, 1),
		Text = tostring(clickCount),
		TextScaled = true,

		[React.Event.Activated] = function()
			setClickCount(function(currentCount)
				return currentCount + 1
			end)
		end,
	})
end

return function(target)
	-- Legacy root to avoid async render
	local root = ReactRoblox.createLegacyRoot(target)
	root:render(e(Story))

	local button = target:FindFirstChildWhichIsA("TextButton")
	assert(button ~= nil, "Can't find mounted TextButton")

	local loopTask = task.spawn(function()
		while true do
			fireEvent(button, "Activated")
			task.wait(0.1)
		end
	end)

	return function()
		task.cancel(loopTask)
		root:unmount()
	end
end
