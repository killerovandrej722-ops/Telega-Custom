local Params = {
	RepoURL = "https://raw.githubusercontent.com/killerovandrej722-ops/Telega-Custom/refs/heads/main/",
	SSI = "decompworkspace",
}
local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local selected = {}

local COL_BG = Color3.fromRGB(20, 20, 25)
local COL_FRAME = Color3.fromRGB(30, 30, 35)
local COL_ROW = Color3.fromRGB(40, 40, 45)
local COL_ROW_SEL = Color3.fromRGB(0, 120, 80)
local COL_ROW_CHILD = Color3.fromRGB(35, 35, 40)
local COL_TEXT = Color3.fromRGB(255, 255, 255)
local COL_ACCENT = Color3.fromRGB(80, 140, 255)
local COL_CLOSE = Color3.fromRGB(200, 50, 50)
local COL_START = Color3.fromRGB(0, 160, 60)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local gui = Instance.new("ScreenGui")
gui.Name = "DecompGUI_" .. tostring(math.random(1e6, 9e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = (gethui and gethui()) or CoreGui

local aspect = Instance.new("UIAspectRatioConstraint")
aspect.AspectRatio = 0.75
aspect.Parent = gui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 520, 0, 640)
frame.Position = UDim2.new(0.5, -260, 0.5, -320)
frame.BackgroundColor3 = COL_FRAME
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 10)

local outlineGrad = Instance.new("UIGradient")
outlineGrad.Color = ColorSequence.new(COL_ACCENT, Color3.fromRGB(40, 40, 50))
outlineGrad.Parent = frame

local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 46)
header.Position = UDim2.new(0, 0, 0, 0)
header.BackgroundColor3 = COL_BG
header.BorderSizePixel = 0
header.Parent = frame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 10)

local headerCornerFix = Instance.new("Frame")
headerCornerFix.Size = UDim2.new(1, 0, 0, 10)
headerCornerFix.Position = UDim2.new(0, 0, 0, 36)
headerCornerFix.BackgroundColor3 = COL_BG
headerCornerFix.BorderSizePixel = 0
headerCornerFix.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 200, 1, 0)
title.Position = UDim2.new(0, 16, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Decompile"
title.TextColor3 = COL_TEXT
title.Font = Enum.Font.Gotham
title.TextSize = 20
title.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.ExtraBold)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local titleStroke = Instance.new("UIStroke", title)
titleStroke.Thickness = 0.5
titleStroke.Transparency = 0.5

local closeBtn = Instance.new("ImageButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Image = ""
closeBtn.Parent = header
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local closeTxt = Instance.new("TextLabel")
closeTxt.Size = UDim2.new(1, 0, 1, 0)
closeTxt.BackgroundTransparency = 1
closeTxt.Text = "X"
closeTxt.TextColor3 = COL_TEXT
closeTxt.Font = Enum.Font.SourceSansBold
closeTxt.TextSize = 16
closeTxt.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

local searchFrame = Instance.new("Frame")
searchFrame.Size = UDim2.new(1, -20, 0, 34)
searchFrame.Position = UDim2.new(0, 10, 0, 52)
searchFrame.BackgroundColor3 = COL_BG
searchFrame.BorderSizePixel = 0
searchFrame.Parent = frame
Instance.new("UICorner", searchFrame).CornerRadius = UDim.new(0, 6)

local searchStroke = Instance.new("UIStroke", searchFrame)
searchStroke.Color = COL_ACCENT
searchStroke.Thickness = 1
searchStroke.Transparency = 0.7

local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -12, 1, -4)
searchBox.Position = UDim2.new(0, 6, 0, 2)
searchBox.BackgroundTransparency = 1
searchBox.Text = ""
searchBox.PlaceholderText = "Search..."
searchBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
searchBox.TextColor3 = COL_TEXT
searchBox.Font = Enum.Font.Gotham
searchBox.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold)
searchBox.TextSize = 14
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = searchFrame

local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -20, 1, -150)
scroll.Position = UDim2.new(0, 10, 0, 94)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 6
scroll.ScrollBarImageColor3 = COL_ACCENT
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 4)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

local padding = Instance.new("UIPadding", scroll)
padding.PaddingTop = UDim.new(0, 2)
padding.PaddingBottom = UDim.new(0, 2)

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0, 240, 0, 40)
startBtn.Position = UDim2.new(0.5, -120, 1, -50)
startBtn.BackgroundColor3 = COL_START
startBtn.Text = "START"
startBtn.TextColor3 = COL_TEXT
startBtn.Font = Enum.Font.GothamBold
startBtn.TextSize = 16
startBtn.AutoButtonColor = true
startBtn.Parent = frame
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 8)

local startStroke = Instance.new("UIStroke", startBtn)
startStroke.Color = Color3.fromRGB(0, 200, 80)
startStroke.Thickness = 1.5
startStroke.Transparency = 0.4

local rowCount = 0
local function nextOrder()
	rowCount += 1
	return rowCount
end

local function createRow(instance, depth, parentFrame)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 32)
	container.AutomaticSize = Enum.AutomaticSize.Y
	container.BackgroundTransparency = 1
	container.LayoutOrder = nextOrder()
	container.Parent = parentFrame

	local vlayout = Instance.new("UIListLayout")
	vlayout.SortOrder = Enum.SortOrder.LayoutOrder
	vlayout.Padding = UDim.new(0, 2)
	vlayout.Parent = container

	local rowFrame = Instance.new("Frame")
	rowFrame.Size = UDim2.new(1, 0, 0, 30)
	rowFrame.BackgroundColor3 = COL_ROW
	rowFrame.BorderSizePixel = 0
	rowFrame.LayoutOrder = 1
	rowFrame.Parent = container
	Instance.new("UICorner", rowFrame).CornerRadius = UDim.new(0, 6)

	local arrow = Instance.new("TextButton")
	arrow.Size = UDim2.new(0, 24, 0, 24)
	arrow.Position = UDim2.new(0, depth * 18 + 4, 0, 3)
	arrow.BackgroundTransparency = 1
	arrow.Text = ""
	arrow.TextColor3 = COL_TEXT
	arrow.Font = Enum.Font.SourceSansBold
	arrow.TextSize = 16
	arrow.Parent = rowFrame

	local enableBtn = Instance.new("TextButton")
	enableBtn.Size = UDim2.new(0, 22, 0, 22)
	enableBtn.Position = UDim2.new(0, depth * 18 + 28, 0, 4)
	enableBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
	enableBtn.Text = ""
	enableBtn.TextColor3 = COL_TEXT
	enableBtn.Font = Enum.Font.SourceSansBold
	enableBtn.TextSize = 14
	enableBtn.Parent = rowFrame
	Instance.new("UICorner", enableBtn).CornerRadius = UDim.new(0, 4)

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -depth * 18 - 56, 1, 0)
	nameLabel.Position = UDim2.new(0, depth * 18 + 54, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.Text = instance.Name .. "  [" .. instance.ClassName .. "]"
	nameLabel.TextColor3 = COL_TEXT
	nameLabel.Font = Enum.Font.Gotham
	nameLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy)
	nameLabel.TextSize = 14
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
	nameLabel.Parent = rowFrame

	local nameStroke = Instance.new("UIStroke", nameLabel)
	nameStroke.Thickness = 0.3
	nameStroke.Transparency = 0.7

	enableBtn.MouseButton1Click:Connect(function()
		if selected[instance] then
			selected[instance] = nil
			enableBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
			enableBtn.Text = ""
			rowFrame.BackgroundColor3 = COL_ROW
		else
			selected[instance] = true
			enableBtn.BackgroundColor3 = COL_ROW_SEL
			enableBtn.Text = "✓"
			rowFrame.BackgroundColor3 = Color3.fromRGB(25, 60, 45)
		end
	end)

	local function applySearch(query)
		local matches = query == "" or string.find(string.lower(instance.Name), string.lower(query), 1, true) ~= nil
			or string.find(string.lower(instance.ClassName), string.lower(query), 1, true) ~= nil
		container.Visible = matches
	end

	local childrenFrame = Instance.new("Frame")
	childrenFrame.Size = UDim2.new(1, 0, 0, 0)
	childrenFrame.AutomaticSize = Enum.AutomaticSize.Y
	childrenFrame.BackgroundTransparency = 1
	childrenFrame.LayoutOrder = 2
	childrenFrame.Visible = false
	childrenFrame.Parent = container

	local clayout = Instance.new("UIListLayout")
	clayout.SortOrder = Enum.SortOrder.LayoutOrder
	clayout.Padding = UDim.new(0, 3)
	clayout.Parent = childrenFrame

	local children = instance:GetChildren()
	local expanded = false
	local loaded = false

	if #children > 0 then
		arrow.Text = "►"
	else
		arrow.Text = ""
		arrow.Active = false
	end

	arrow.MouseButton1Click:Connect(function()
		if #children == 0 then return end
		if expanded then
			expanded = false
			childrenFrame.Visible = false
			arrow.Text = "►"
		else
			expanded = true
			childrenFrame.Visible = true
			arrow.Text = "▼"
			if not loaded then
				loaded = true
				for i, child in children do
					createRow(child, depth + 1, childrenFrame)
					if i % 100 == 0 then
						task.wait()
					end
				end
			end
		end
	end)

	return container, applySearch
end

local searchFilters = {}
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local query = searchBox.Text
	for _, fn in searchFilters do
		fn(query)
	end
end)

local roots = {
	game:GetService("Workspace"),
	game:GetService("ReplicatedStorage"),
	game:GetService("StarterPlayer"),
	game:GetService("StarterGui"),
	game:GetService("Lighting"),
	game:GetService("SoundService"),
	game:GetService("ReplicatedFirst"),
}

local lp = Players.LocalPlayer
local pg = lp and lp:FindFirstChild("PlayerGui")
if pg then
	table.insert(roots, pg)
end

for _, root in roots do
	local container, applySearch = createRow(root, 0, scroll)
	if applySearch then
		table.insert(searchFilters, applySearch)
	end
end

startBtn.MouseButton1Click:Connect(function()
	local list = {}
	for inst in selected do
		table.insert(list, inst)
	end
	if #list == 0 then
		return warn("Nothing selected!")
	end
	gui:Destroy()
	synsaveinstance({
		mode = "custom",
		ExtraInstances = list,
		IsModel = false,
		SafeMode = true,
		Decompile = true,
		IsolateLocalPlayer = true,
	})
end)
