local Params = {
	RepoURL = "https://raw.githubusercontent.com/killerovandrej722-ops/Telega-Custom/refs/heads/main/",
	SSI = "decompworkspace",
}
local synsaveinstance = loadstring(game:HttpGet(Params.RepoURL .. Params.SSI .. ".luau", true), Params.SSI)()

local selected = {}

local COL_BG      = Color3.fromRGB(28, 28, 30)
local COL_PANEL   = Color3.fromRGB(36, 36, 38)
local COL_ROW     = Color3.fromRGB(42, 42, 45)
local COL_ROW_SEL = Color3.fromRGB(58, 58, 62)
local COL_TEXT    = Color3.fromRGB(235, 235, 235)
local COL_DIM     = Color3.fromRGB(150, 150, 150)
local COL_LINE    = Color3.fromRGB(52, 52, 55)

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local gui = Instance.new("ScreenGui")
gui.Name = "Decompile_" .. tostring(math.random(1e6, 9e6))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = (gethui and gethui()) or CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 460, 0, 560)
frame.Position = UDim2.new(0.5, -230, 0.5, -280)
frame.BackgroundColor3 = COL_BG
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = COL_LINE
stroke.Thickness = 1

-- drag
do
	local dragging = false
	local dragStart, startPos
	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	frame.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- ============ HEADER ============
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 38)
header.BackgroundColor3 = COL_PANEL
header.BorderSizePixel = 0
header.Parent = frame

local headerLine = Instance.new("Frame")
headerLine.Size = UDim2.new(1, 0, 0, 1)
headerLine.Position = UDim2.new(0, 0, 1, -1)
headerLine.BackgroundColor3 = COL_LINE
headerLine.BorderSizePixel = 0
headerLine.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Decompile"
title.TextColor3 = COL_TEXT
title.Font = Enum.Font.Code
title.TextSize = 14
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 38, 1, 0)
closeBtn.Position = UDim2.new(1, -38, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "x"
closeBtn.TextColor3 = COL_DIM
closeBtn.Font = Enum.Font.Code
closeBtn.TextSize = 15
closeBtn.Parent = header

closeBtn.MouseEnter:Connect(function()
	closeBtn.TextColor3 = Color3.fromRGB(230, 90, 90)
end)
closeBtn.MouseLeave:Connect(function()
	closeBtn.TextColor3 = COL_DIM
end)
closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- ============ SEARCH ============
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, -24, 0, 30)
searchBox.Position = UDim2.new(0, 12, 0, 48)
searchBox.BackgroundColor3 = COL_PANEL
searchBox.BorderSizePixel = 0
searchBox.Text = ""
searchBox.PlaceholderText = "search"
searchBox.PlaceholderColor3 = COL_DIM
searchBox.TextColor3 = COL_TEXT
searchBox.Font = Enum.Font.Code
searchBox.TextSize = 13
searchBox.TextXAlignment = Enum.TextXAlignment.Left
searchBox.ClearTextOnFocus = false
searchBox.Parent = frame
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 4)

Instance.new("UIPadding", searchBox).PaddingLeft = UDim.new(0, 10)

-- ============ LIST ============
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1, -24, 1, -140)
scroll.Position = UDim2.new(0, 12, 0, 88)
scroll.BackgroundTransparency = 1
scroll.BorderSizePixel = 0
scroll.ScrollBarThickness = 4
scroll.ScrollBarImageColor3 = COL_LINE
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 2)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = scroll

-- ============ FOOTER ============
local footerLine = Instance.new("Frame")
footerLine.Size = UDim2.new(1, -24, 0, 1)
footerLine.Position = UDim2.new(0, 12, 1, -52)
footerLine.BackgroundColor3 = COL_LINE
footerLine.BorderSizePixel = 0
footerLine.Parent = frame

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(1, -24, 0, 34)
startBtn.Position = UDim2.new(0, 12, 1, -44)
startBtn.BackgroundColor3 = COL_PANEL
startBtn.Text = "start"
startBtn.TextColor3 = COL_TEXT
startBtn.Font = Enum.Font.Code
startBtn.TextSize = 13
startBtn.AutoButtonColor = false
startBtn.Parent = frame
Instance.new("UICorner", startBtn).CornerRadius = UDim.new(0, 4)

startBtn.MouseEnter:Connect(function()
	startBtn.BackgroundColor3 = COL_ROW
end)
startBtn.MouseLeave:Connect(function()
	startBtn.BackgroundColor3 = COL_PANEL
end)

-- ============ ROWS ============
local rowCount = 0
local rows = {}

local function nextOrder()
	rowCount += 1
	return rowCount
end

local function createRow(instance, depth, parentFrame, parentRow)
	local container = Instance.new("Frame")
	container.Size = UDim2.new(1, 0, 0, 26)
	container.AutomaticSize = Enum.AutomaticSize.Y
	container.BackgroundTransparency = 1
	container.LayoutOrder = nextOrder()
	container.Parent = parentFrame

	local vlayout = Instance.new("UIListLayout")
	vlayout.SortOrder = Enum.SortOrder.LayoutOrder
	vlayout.Padding = UDim.new(0, 2)
	vlayout.Parent = container

	local rowFrame = Instance.new("TextButton")
	rowFrame.Size = UDim2.new(1, 0, 0, 24)
	rowFrame.BackgroundColor3 = COL_ROW
	rowFrame.BorderSizePixel = 0
	rowFrame.AutoButtonColor = false
	rowFrame.Text = ""
	rowFrame.LayoutOrder = 1
	rowFrame.Parent = container
	Instance.new("UICorner", rowFrame).CornerRadius = UDim.new(0, 3)

	local leftPad = depth * 16

	local arrow = Instance.new("TextLabel")
	arrow.Size = UDim2.new(0, 16, 1, 0)
	arrow.Position = UDim2.new(0, leftPad + 6, 0, 0)
	arrow.BackgroundTransparency = 1
	arrow.Text = ""
	arrow.TextColor3 = COL_DIM
	arrow.Font = Enum.Font.Code
	arrow.TextSize = 12
	arrow.Parent = rowFrame

	local check = Instance.new("TextLabel")
	check.Size = UDim2.new(0, 16, 1, 0)
	check.Position = UDim2.new(0, leftPad + 22, 0, 0)
	check.BackgroundTransparency = 1
	check.Text = ""
	check.TextColor3 = COL_TEXT
	check.Font = Enum.Font.Code
	check.TextSize = 12
	check.Parent = rowFrame

	local nameLabel = Instance.new("TextLabel")
	nameLabel.Size = UDim2.new(1, -leftPad - 42, 1, 0)
	nameLabel.Position = UDim2.new(0, leftPad + 40, 0, 0)
	nameLabel.BackgroundTransparency = 1
	nameLabel.RichText = true
	nameLabel.TextXAlignment = Enum.TextXAlignment.Left
	nameLabel.TextTruncate = Enum.TextTruncate.AtEnd
	nameLabel.Font = Enum.Font.Code
	nameLabel.TextSize = 12
	nameLabel.TextColor3 = COL_TEXT
	nameLabel.Parent = rowFrame

	-- класс в скобках, только если отличается от имени (нет дублей "Workspace Workspace")
	local cls = instance.ClassName
	local name = instance.Name
	if cls ~= name then
		nameLabel.Text = '<font color="rgb(150,150,150)">[' .. cls .. "]</font> " .. name
	else
		nameLabel.Text = name
	end

	local row = {
		instance = instance,
		container = container,
		parentRow = parentRow,
		selfMatch = false,
		childMatch = false,
		userExpanded = false,
	}
	table.insert(rows, row)

	rowFrame.MouseEnter:Connect(function()
		if not selected[instance] then
			rowFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 53)
		end
	end)
	rowFrame.MouseLeave:Connect(function()
		if not selected[instance] then
			rowFrame.BackgroundColor3 = COL_ROW
		end
	end)

	rowFrame.MouseButton1Click:Connect(function()
		if selected[instance] then
			selected[instance] = nil
			check.Text = ""
			rowFrame.BackgroundColor3 = COL_ROW
		else
			selected[instance] = true
			check.Text = "+"
			rowFrame.BackgroundColor3 = COL_ROW_SEL
		end
	end)

	-- children
	local childrenFrame = Instance.new("Frame")
	childrenFrame.Size = UDim2.new(1, 0, 0, 0)
	childrenFrame.AutomaticSize = Enum.AutomaticSize.Y
	childrenFrame.BackgroundTransparency = 1
	childrenFrame.LayoutOrder = 2
	childrenFrame.Visible = false
	childrenFrame.Parent = container
	row.childrenFrame = childrenFrame

	local clayout = Instance.new("UIListLayout")
	clayout.SortOrder = Enum.SortOrder.LayoutOrder
	clayout.Padding = UDim.new(0, 2)
	clayout.Parent = childrenFrame

	local hasChildren = #instance:GetChildren() > 0
	if hasChildren then
		arrow.Text = ">"
	end

	local arrowBtn = Instance.new("TextButton")
	arrowBtn.Size = UDim2.new(0, 40, 1, 0)
	arrowBtn.Position = UDim2.new(0, leftPad, 0, 0)
	arrowBtn.BackgroundTransparency = 1
	arrowBtn.Text = ""
	arrowBtn.Parent = rowFrame
	row.arrow = arrow
	row.hasChildren = hasChildren

	arrowBtn.MouseButton1Click:Connect(function()
		if not hasChildren then return end
		row.userExpanded = not row.userExpanded
		childrenFrame.Visible = row.userExpanded
		arrow.Text = row.userExpanded and "v" or ">"
	end)

	return row
end

-- ============ BUILD TREE (eager, чтобы поиск работал вглубь) ============
local function buildChildren(row, instance, depth)
	local i = 0
	for _, child in instance:GetChildren() do
		i += 1
		local childRow = createRow(child, depth + 1, row.childrenFrame, row)
		buildChildren(childRow, child, depth + 1)
		if i % 100 == 0 then
			task.wait()
		end
	end
	if #instance:GetChildren() > 0 then
		row.arrow.Text = ">"
		row.hasChildren = true
	end
end

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

task.spawn(function()
	for _, root in roots do
		local row = createRow(root, 0, scroll, nil)
		buildChildren(row, root, 0)
		task.wait()
	end
end)

-- ============ SEARCH ============
local function refreshSearch(query)
	local q = string.lower(query)

	-- проход 1: метим совпадения по имени/классу
	for _, r in rows do
		r.childMatch = false
		if q == "" then
			r.selfMatch = false
		else
			local n = string.lower(r.instance.Name)
			local c = string.lower(r.instance.ClassName)
			r.selfMatch = string.find(n, q, 1, true) ~= nil or string.find(c, q, 1, true) ~= nil
		end
	end

	-- проход 2: снизу вверх раскрываем родителей совпадений
	for i = #rows, 1, -1 do
		local r = rows[i]
		local vis
		if q == "" then
			vis = true
			r.childrenFrame.Visible = r.userExpanded
		else
			vis = r.selfMatch or r.childMatch
			r.childrenFrame.Visible = vis
			r.arrow.Text = r.hasChildren and "v" or ""
		end
		r.container.Visible = vis
		if vis and r.parentRow then
			r.parentRow.childMatch = true
		end
	end
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	refreshSearch(searchBox.Text)
end)

-- ============ START ============
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
