local widgetInfo = DockWidgetPluginGuiInfo.new(
	Enum.InitialDockState.Float,
	true,   -- Widget will be initially enabled
	false,  -- Don't override the previous enabled state
	50,    -- Default width
	25,    -- Default height 
	50,    -- Minimum width 
	25     -- Minimum height
)

-- Create new widget GUI
local MainWidget = plugin:CreateDockWidgetPluginGui("TestWidget", widgetInfo)
MainWidget.Title = "FPS Plugin"

local Toolbar = plugin:CreateToolbar("Fps")

local Button = Toolbar:CreateButton("Fps","Made by Stonetr03 Studios","")
Button.ClickableWhenViewportHidden = true
Button.Click:Connect(function()
	MainWidget.Enabled = not MainWidget.Enabled
end)
MainWidget.Changed:Connect(function()
	Button:SetActive(MainWidget.Enabled)
end)
local FpsLabel = script.Parent.ScreenGui.TextLabel
FpsLabel.Parent = MainWidget


local Heartbeat = game:GetService("RunService").Heartbeat

local LastIteration, Start
local FrameUpdateTable = {}

local function HeartbeatUpdate()
	if MainWidget.Enabled == true then
		LastIteration = tick()
		for Index = #FrameUpdateTable, 1, -1 do
			FrameUpdateTable[Index + 1] = (FrameUpdateTable[Index] >= LastIteration - 1) and FrameUpdateTable[Index] or nil
		end

		FrameUpdateTable[1] = LastIteration
		local CurrentFPS = (tick() - Start >= 1 and #FrameUpdateTable) or (#FrameUpdateTable / (tick() - Start))
		CurrentFPS = math.floor(CurrentFPS )
		FpsLabel.Text = "Fps : " .. CurrentFPS
	end
end

Start = tick()
Heartbeat:Connect(HeartbeatUpdate)
