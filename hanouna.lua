-- ╔══════════════════════════════════════════════════════╗
-- ║       ✡️  TEL-AVIV CLIENT  —  [BETA]                 ║
-- ║              By FocusOnTop  💜  2026                 ║
-- ╚══════════════════════════════════════════════════════╝

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name            = "✡️ Tel-Aviv Client ~ By Cyril Hanouna",
	LoadingTitle    = "Tel-Aviv [CLIENT]",
	LoadingSubtitle = "•  By FocusOnTop",
	Theme = {
		TextColor                     = Color3.fromRGB(220, 235, 255),
		Background                    = Color3.fromRGB(8,  12,  28),
		Topbar                        = Color3.fromRGB(12,  25,  70),
		Shadow                        = Color3.fromRGB(20,  60, 180),
		NotificationBackground        = Color3.fromRGB(10,  18,  50),
		NotificationActionsBackground = Color3.fromRGB(15,  35, 100),
		TabBackground                 = Color3.fromRGB(10,  20,  55),
		TabStroke                     = Color3.fromRGB(30,  80, 200),
		TabBackgroundSelected         = Color3.fromRGB(20,  60, 180),
		TabTextColor                  = Color3.fromRGB(140, 170, 240),
		SelectedTabTextColor          = Color3.fromRGB(255, 255, 255),
		ElementBackground             = Color3.fromRGB(12,  22,  60),
		ElementBackgroundHover        = Color3.fromRGB(20,  45, 120),
		SecondaryElementBackground    = Color3.fromRGB(14,  28,  75),
		ElementStroke                 = Color3.fromRGB(25,  70, 190),
		SecondaryElementStroke        = Color3.fromRGB(30,  80, 200),
		SliderBackground              = Color3.fromRGB(15,  40, 110),
		SliderProgress                = Color3.fromRGB(60, 130, 255),
		SliderStroke                  = Color3.fromRGB(40, 100, 220),
		ToggleBackground              = Color3.fromRGB(15,  38, 100),
		ToggleEnabled                 = Color3.fromRGB(50, 120, 255),
		ToggleDisabled                = Color3.fromRGB(20,  45, 110),
		ToggleEnabledStroke           = Color3.fromRGB(80, 160, 255),
		ToggleDisabledStroke          = Color3.fromRGB(25,  55, 130),
		ToggleEnabledOuterStroke      = Color3.fromRGB(60, 130, 240),
		ToggleDisabledOuterStroke     = Color3.fromRGB(20,  48, 115),
		DropdownSelected              = Color3.fromRGB(40, 100, 220),
		DropdownUnselected            = Color3.fromRGB(14,  30,  80),
		InputBackground               = Color3.fromRGB(10,  20,  55),
		InputStroke                   = Color3.fromRGB(30,  80, 200),
		PlaceholderColor              = Color3.fromRGB(100, 140, 220),
	},
	DisableRayfieldPrompts = false,
	DisableBuildWarnings   = false,
	ConfigurationSaving = {
		Enabled    = true,
		FolderName = "PurpleDrank",
		FileName   = "WarsConfig",
	},
	KeySystem = false,
})

-- ══════════════════════════════════════
--  SERVICES
-- ══════════════════════════════════════
local Players    = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS        = game:GetService("UserInputService")
local Lighting   = game:GetService("Lighting")
local LP         = Players.LocalPlayer

local function getChar() return LP.Character end
local function getHRP()  local c = getChar() return c and c:FindFirstChild("HumanoidRootPart") end
local function getHum()  local c = getChar() return c and c:FindFirstChildOfClass("Humanoid")  end
local function getCam()  return workspace.CurrentCamera end

local function notify(title, content, dur)
	Rayfield:Notify({ Title = title, Content = content, Duration = dur or 3 })
end

-- ══════════════════════════════════════════════════════════════
--  WATERMARK
-- ══════════════════════════════════════════════════════════════
task.spawn(function()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name            = "PurpleDrankWatermark"
	screenGui.ResetOnSpawn    = false
	screenGui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder    = 999
	local ok = pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
	if not ok then screenGui.Parent = LP:WaitForChild("PlayerGui") end

	local frame = Instance.new("Frame")
	frame.Size                   = UDim2.new(0, 320, 0, 58)
	frame.Position               = UDim2.new(0.5, -160, 0, 10)
	frame.BackgroundColor3       = Color3.fromRGB(5, 10, 30)
	frame.BackgroundTransparency = 0.15
	frame.BorderSizePixel        = 0
	frame.Parent                 = screenGui

	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local stroke = Instance.new("UIStroke")
	stroke.Thickness    = 2.5
	stroke.Transparency = 0
	stroke.Parent       = frame

	local grad = Instance.new("UIGradient")
	grad.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,  50, 180)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5,  10,  40)),
		ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,  50, 180)),
	})
	grad.Rotation = 90
	grad.Parent   = frame

	local icon = Instance.new("ImageLabel")
	icon.Size                   = UDim2.new(0, 46, 0, 46)
	icon.Position               = UDim2.new(0, 6, 0.5, -23)
	icon.BackgroundTransparency = 1
	icon.Image                  = "rbxassetid://107792284821516"
	icon.ImageColor3            = Color3.fromRGB(80, 150, 255)
	icon.ScaleType              = Enum.ScaleType.Fit
	icon.ZIndex                 = 3
	icon.Parent                 = frame

	local bar = Instance.new("Frame")
	bar.Size             = UDim2.new(0, 3, 0, 38)
	bar.Position         = UDim2.new(0, 56, 0.5, -19)
	bar.BackgroundColor3 = Color3.fromRGB(60, 130, 255)
	bar.BorderSizePixel  = 0
	bar.ZIndex           = 3
	bar.Parent           = frame
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local mainLabel = Instance.new("TextLabel")
	mainLabel.Size                   = UDim2.new(1, -70, 0, 32)
	mainLabel.Position               = UDim2.new(0, 65, 0, 4)
	mainLabel.BackgroundTransparency = 1
	mainLabel.Text                   = "TEL-AVIV CLIENT"
	mainLabel.TextColor3             = Color3.fromRGB(200, 220, 255)
	mainLabel.TextStrokeColor3       = Color3.fromRGB(0, 80, 255)
	mainLabel.TextStrokeTransparency = 0.2
	mainLabel.Font                   = Enum.Font.GothamBold
	mainLabel.TextSize               = 26
	mainLabel.TextXAlignment         = Enum.TextXAlignment.Left
	mainLabel.ZIndex                 = 4
	mainLabel.Parent                 = frame

	local subLabel = Instance.new("TextLabel")
	subLabel.Size                   = UDim2.new(1, -70, 0, 18)
	subLabel.Position               = UDim2.new(0, 65, 0, 36)
	subLabel.BackgroundTransparency = 1
	subLabel.Text                   = "by FocusOnTop  •  BETA"
	subLabel.TextColor3             = Color3.fromRGB(120, 170, 240)
	subLabel.TextStrokeTransparency = 1
	subLabel.Font                   = Enum.Font.Gotham
	subLabel.TextSize               = 13
	subLabel.TextXAlignment         = Enum.TextXAlignment.Left
	subLabel.ZIndex                 = 4
	subLabel.Parent                 = frame

	for i = 1, 3 do
		local dot = Instance.new("Frame")
		dot.Size             = UDim2.new(0, 6, 0, 6)
		dot.Position         = UDim2.new(1, -16, 0, 8 + (i-1) * 14)
		dot.BackgroundColor3 = Color3.fromRGB(60 + i*20, 130 + i*10, 255)
		dot.BorderSizePixel  = 0
		dot.ZIndex           = 4
		dot.Parent           = frame
		Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0)
	end

	task.spawn(function()
		local t = 0
		while frame and frame.Parent do
			t = (t + 0.008) % 1
			-- Zone bleu/blanc : hue 0.55 à 0.65
			local hue = 0.55 + math.abs(math.sin(t * math.pi)) * 0.1
			stroke.Color         = Color3.fromHSV(hue, 0.85, 1)
			icon.ImageColor3     = Color3.fromHSV(hue + 0.03, 0.6, 1)
			mainLabel.TextColor3 = Color3.fromHSV(hue + 0.01, 0.3, 1)
			bar.BackgroundColor3 = Color3.fromHSV(hue, 0.9, 1)
			task.wait(0.016)
		end
	end)

	task.spawn(function()
		local t = 0
		while frame and frame.Parent do
			t = t + 0.04
			local pulse = 1 + math.sin(t) * 0.012
			frame.Size     = UDim2.new(0, math.floor(320 * pulse), 0, 58)
			frame.Position = UDim2.new(0.5, -math.floor(160 * pulse), 0, 10)
			task.wait(0.016)
		end
	end)
end)

-- ══════════════════════════════════════════════════════════════
--  FLY — Infinite Yield style
-- ══════════════════════════════════════════════════════════════
local FLYING     = false
local flySpeed   = 80
local realWalkSpeed = 16
local flyKeyDown = nil
local flyKeyUp   = nil

local CTRL = {F=0,B=0,L=0,R=0,U=0,D=0}

local function NOFLY()
	FLYING = false
	if flyKeyDown then flyKeyDown:Disconnect(); flyKeyDown = nil end
	if flyKeyUp   then flyKeyUp:Disconnect();   flyKeyUp   = nil end
	local hum = getHum()
	if hum then hum.PlatformStand = false end
	pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
	notify("✈️ Fly", "OFF 🛑", 2)
end

local function sFLY()
	local hrp = getHRP()
	if not hrp then notify("✈️", "Personnage introuvable !", 2) return end

	FLYING = true

	local BG = Instance.new("BodyGyro")
	local BV = Instance.new("BodyVelocity")
	BG.P         = 9e4
	BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	BG.CFrame    = hrp.CFrame
	BG.Parent    = hrp
	BV.Velocity  = Vector3.zero
	BV.MaxForce  = Vector3.new(9e9, 9e9, 9e9)
	BV.Parent    = hrp

	local lCTRL = {F=0,B=0,L=0,R=0}
	CTRL = {F=0,B=0,L=0,R=0,U=0,D=0}
	local SPEED = 0

	task.spawn(function()
		repeat task.wait()
			local cam = workspace.CurrentCamera
			local hum = getHum()
			if hum then hum.PlatformStand = true end

			if CTRL.F+CTRL.B ~= 0 or CTRL.L+CTRL.R ~= 0 or CTRL.U+CTRL.D ~= 0 then
				SPEED = flySpeed
			else
				SPEED = 0
			end

			if CTRL.F+CTRL.B ~= 0 or CTRL.L+CTRL.R ~= 0 or CTRL.U+CTRL.D ~= 0 then
				BV.Velocity = (
					(cam.CFrame.LookVector  * (CTRL.F + CTRL.B)) +
					((cam.CFrame * CFrame.new(CTRL.L + CTRL.R, (CTRL.F+CTRL.B+CTRL.U+CTRL.D)*0.2, 0)).Position - cam.CFrame.Position)
				) * SPEED
				lCTRL = {F=CTRL.F, B=CTRL.B, L=CTRL.L, R=CTRL.R}
			elseif SPEED == 0 then
				BV.Velocity = Vector3.zero
			end

			BG.CFrame = cam.CFrame
		until not FLYING
		CTRL = {F=0,B=0,L=0,R=0,U=0,D=0}
		SPEED = 0
		BG:Destroy()
		BV:Destroy()
		local hum2 = getHum()
		if hum2 then hum2.PlatformStand = false end
	end)

	flyKeyDown = UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.W     then CTRL.F =  flySpeed
		elseif input.KeyCode == Enum.KeyCode.S then CTRL.B = -flySpeed
		elseif input.KeyCode == Enum.KeyCode.A then CTRL.L = -flySpeed
		elseif input.KeyCode == Enum.KeyCode.D then CTRL.R =  flySpeed
		elseif input.KeyCode == Enum.KeyCode.E then CTRL.U =  flySpeed
		elseif input.KeyCode == Enum.KeyCode.Q then CTRL.D = -flySpeed
		end
	end)

	flyKeyUp = UIS.InputEnded:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.W     then CTRL.F = 0
		elseif input.KeyCode == Enum.KeyCode.S then CTRL.B = 0
		elseif input.KeyCode == Enum.KeyCode.A then CTRL.L = 0
		elseif input.KeyCode == Enum.KeyCode.D then CTRL.R = 0
		elseif input.KeyCode == Enum.KeyCode.E then CTRL.U = 0
		elseif input.KeyCode == Enum.KeyCode.Q then CTRL.D = 0
		end
	end)

	notify("✈️ Fly", "ON ✡️ — WASD | E = monter | Q = descendre", 2)
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		if FLYING then NOFLY() else sFLY() end
	end
end)

LP.CharacterAdded:Connect(function()
	NOFLY()
end)

-- ══════════════════════════════════════
--  PUSH / FLING
-- ══════════════════════════════════════
local function safeGetPing()
	local ok, v = pcall(function()
		return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()/1000
	end)
	return ok and v or 0.05
end

local function getTargetRoot(plr)
	if plr and plr.Character then return plr.Character:FindFirstChild("HumanoidRootPart") end
end

local function predTP(plr)
	local root = getTargetRoot(plr); local myRoot = getHRP()
	if not root or not myRoot then return end
	local vel = root.Velocity or Vector3.zero
	myRoot.CFrame = CFrame.new(root.Position + vel * safeGetPing() * 3.5 + Vector3.new(0,2,0))
end

local function findPushTool()
	for _, container in ipairs({ LP.Backpack, getChar() or {} }) do
		for _, v in pairs(container:GetChildren()) do
			if v:IsA("Tool") and v.Name:lower():find("push") then return v end
		end
	end
end

local function doServerPush(plr)
	pcall(function()
		local tool = findPushTool()
		if not tool or not plr.Character then return end
		tool.Parent = getChar()
		pcall(function() tool.PushTool:FireServer(plr.Character) end)
		task.wait(0.1); tool.Parent = LP.Backpack
	end)
end

local function doPowerPush(plr)
	pcall(function()
		if not plr.Character then return end
		local targetRoot = getTargetRoot(plr); local myRoot = getHRP()
		if not targetRoot or not myRoot then return end
		local pushDir = (targetRoot.Position - myRoot.Position)
		if pushDir.Magnitude < 0.1 then pushDir = Vector3.new(0,1,0) end
		pushDir = pushDir.Unit
		local bv = Instance.new("BodyVelocity")
		bv.MaxForce = Vector3.new(1e9,1e9,1e9)
		bv.Velocity = pushDir * 400 + Vector3.new(0,150,0)
		bv.Parent   = targetRoot
		game:GetService("Debris"):AddItem(bv, 0.2)
		task.spawn(function()
			task.wait(0.05)
			pcall(function()
				targetRoot.Velocity = pushDir * 600 + Vector3.new(
					math.random(-100,100), 200, math.random(-100,100)
				)
			end)
		end)
	end)
end

local function doPush(plr)
	predTP(plr); task.wait(safeGetPing() + 0.03)
	doServerPush(plr); doPowerPush(plr)
end

-- ══════════════════════════════════════
--  AIMBOT
-- ══════════════════════════════════════
local aimbotEnabled   = false
local aimbotSmoothing = 0.3
local aimbotPart      = "Head"
local aimbotFOV       = 300
local aimbotConn      = nil

local function getClosestTarget()
	local cam = getCam()
	local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
	local best, bestD = nil, aimbotFOV
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LP and plr.Character then
			local part = plr.Character:FindFirstChild(aimbotPart) or plr.Character:FindFirstChild("HumanoidRootPart")
			local hum  = plr.Character:FindFirstChildOfClass("Humanoid")
			if part and hum and hum.Health > 0 then
				local sp, onScreen = cam:WorldToViewportPoint(part.Position)
				if onScreen then
					local d = (Vector2.new(sp.X,sp.Y) - center).Magnitude
					if d < bestD then bestD = d; best = plr end
				end
			end
		end
	end
	return best
end

local function runAimbot()
	if aimbotConn then aimbotConn:Disconnect(); aimbotConn = nil end
	aimbotConn = RunService.RenderStepped:Connect(function()
		if not aimbotEnabled then return end
		local target = getClosestTarget()
		if not target or not target.Character then return end
		local part = target.Character:FindFirstChild(aimbotPart) or target.Character:FindFirstChild("HumanoidRootPart")
		if not part then return end
		local cam = getCam(); local origin = cam.CFrame.Position
		local tCF = CFrame.new(origin, part.Position)
		cam.CFrame = aimbotSmoothing <= 0.01 and tCF or cam.CFrame:Lerp(tCF, 1 - aimbotSmoothing)
	end)
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.F then
		aimbotEnabled = not aimbotEnabled
		notify("🎯 Aimbot", aimbotEnabled and "ON ✡️" or "OFF 🛑", 2)
	end
end)
runAimbot()

-- ══════════════════════════════════════
--  ESP TRACKALL + STAFF DETECT
-- ══════════════════════════════════════
local trackHL       = {}
local trackBB       = {}
local trackDistC    = {}
local trackCharC    = {}
local trackOn       = false
local STAFFDetectOn = false
local playerSnapshots = {}

local function isSuspectedSTAFF(plr)
	if not plr.Character then return false end
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
	local hum = plr.Character:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return false end
	local snap = playerSnapshots[plr.Name]
	if not snap then
		playerSnapshots[plr.Name] = { lastPos = hrp.Position, lastHP = hum.Health, highSpeedFrames = 0, godmodFrames = 0, totalFrames = 0 }
		return false
	end
	snap.totalFrames = snap.totalFrames + 1
	local isSTAFF = false
	local dist = (hrp.Position - snap.lastPos).Magnitude
	if dist > 80 then snap.highSpeedFrames = snap.highSpeedFrames + 1
	else snap.highSpeedFrames = math.max(0, snap.highSpeedFrames - 1) end
	if snap.highSpeedFrames >= 5 then isSTAFF = true end
	if snap.lastHP < hum.MaxHealth * 0.5 and hum.Health == hum.MaxHealth then
		snap.godmodFrames = snap.godmodFrames + 1
	else snap.godmodFrames = math.max(0, snap.godmodFrames - 0.5) end
	if snap.godmodFrames >= 3 then isSTAFF = true end
	snap.lastPos = hrp.Position
	snap.lastHP  = hum.Health
	return isSTAFF
end

local function cleanTrack(plr)
	if trackHL[plr.Name]    then pcall(function() trackHL[plr.Name]:Destroy() end);       trackHL[plr.Name]    = nil end
	if trackBB[plr.Name]    then pcall(function() trackBB[plr.Name]:Destroy() end);       trackBB[plr.Name]    = nil end
	if trackDistC[plr.Name] then pcall(function() trackDistC[plr.Name]:Disconnect() end); trackDistC[plr.Name] = nil end
	if trackCharC[plr.Name] then pcall(function() trackCharC[plr.Name]:Disconnect() end); trackCharC[plr.Name] = nil end
end

local function setupTrackChar(plr, char)
	if trackHL[plr.Name]    then pcall(function() trackHL[plr.Name]:Destroy() end);       trackHL[plr.Name]    = nil end
	if trackBB[plr.Name]    then pcall(function() trackBB[plr.Name]:Destroy() end);       trackBB[plr.Name]    = nil end
	if trackDistC[plr.Name] then pcall(function() trackDistC[plr.Name]:Disconnect() end); trackDistC[plr.Name] = nil end
	task.wait(0.6)
	if not char or not char.Parent then return end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then task.wait(1); hrp = char:FindFirstChild("HumanoidRootPart"); hum = char:FindFirstChildOfClass("Humanoid") end
	if not hrp or not hum then return end

	local hl = Instance.new("Highlight")
	hl.FillColor = Color3.fromRGB(30, 80, 220); hl.OutlineColor = Color3.fromRGB(120, 180, 255)
	hl.FillTransparency = 0.45; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	hl.Parent = char; trackHL[plr.Name] = hl

	local bb = Instance.new("BillboardGui")
	bb.Adornee = hrp; bb.Size = UDim2.new(0,210,0,75)
	bb.StudsOffset = Vector3.new(0,5,0); bb.AlwaysOnTop = true
	bb.Parent = hrp; trackBB[plr.Name] = bb

	local bgFrame = Instance.new("Frame")
	bgFrame.Size = UDim2.new(1,0,1,0); bgFrame.BackgroundColor3 = Color3.fromRGB(5,10,30)
	bgFrame.BackgroundTransparency = 0.4; bgFrame.BorderSizePixel = 0; bgFrame.Parent = bb
	Instance.new("UICorner", bgFrame).CornerRadius = UDim.new(0,6)
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(30,80,220); stroke.Thickness = 1.5; stroke.Parent = bgFrame

	local lSTAFF = Instance.new("TextLabel")
	lSTAFF.Size = UDim2.new(1,-6,0,18); lSTAFF.Position = UDim2.new(0,3,0,0)
	lSTAFF.BackgroundTransparency = 1; lSTAFF.Text = "⚠️ STAFF ⚠️"
	lSTAFF.TextColor3 = Color3.fromRGB(255,50,50); lSTAFF.TextStrokeTransparency = 0.1
	lSTAFF.TextScaled = true; lSTAFF.Font = Enum.Font.GothamBold
	lSTAFF.Visible = false; lSTAFF.Parent = bgFrame

	local lName = Instance.new("TextLabel")
	lName.Size = UDim2.new(1,-6,0,20); lName.Position = UDim2.new(0,3,0,20)
	lName.BackgroundTransparency = 1; lName.Text = "✡️ "..plr.Name
	lName.TextColor3 = Color3.fromRGB(130, 180, 255); lName.TextStrokeTransparency = 0.3
	lName.TextScaled = true; lName.Font = Enum.Font.GothamBold; lName.Parent = bgFrame

	local hpBg = Instance.new("Frame")
	hpBg.Size = UDim2.new(1,-6,0,8); hpBg.Position = UDim2.new(0,3,0,43)
	hpBg.BackgroundColor3 = Color3.fromRGB(10,20,60); hpBg.BackgroundTransparency = 0.2
	hpBg.BorderSizePixel = 0; hpBg.Parent = bgFrame
	Instance.new("UICorner",hpBg).CornerRadius = UDim.new(1,0)
	local hpBar = Instance.new("Frame")
	hpBar.Size = UDim2.new(1,0,1,0); hpBar.BackgroundColor3 = Color3.fromRGB(50, 120, 255)
	hpBar.BorderSizePixel = 0; hpBar.Parent = hpBg
	Instance.new("UICorner",hpBar).CornerRadius = UDim.new(1,0)

	local lHP = Instance.new("TextLabel")
	lHP.Size = UDim2.new(1,-6,0,14); lHP.Position = UDim2.new(0,3,0,53)
	lHP.BackgroundTransparency = 1; lHP.Text = "❤️ "..math.floor(hum.Health).." / "..math.floor(hum.MaxHealth)
	lHP.TextColor3 = Color3.fromRGB(200, 220, 255); lHP.TextScaled = true
	lHP.Font = Enum.Font.Gotham; lHP.Parent = bgFrame

	local lDist = Instance.new("TextLabel")
	lDist.Size = UDim2.new(1,-6,0,12); lDist.Position = UDim2.new(0,3,0,62)
	lDist.BackgroundTransparency = 1; lDist.Text = "📍 -- st"
	lDist.TextColor3 = Color3.fromRGB(150, 190, 255); lDist.TextScaled = true
	lDist.Font = Enum.Font.Gotham; lDist.Parent = bgFrame

	hum.HealthChanged:Connect(function(hp)
		if not hpBar or not hpBar.Parent then return end
		local ratio = math.clamp(hp / hum.MaxHealth, 0, 1)
		lHP.Text = "❤️ "..math.floor(hp).." / "..math.floor(hum.MaxHealth)
		hpBar.Size = UDim2.new(ratio,0,1,0)
		hpBar.BackgroundColor3 = Color3.fromRGB(math.floor(30+(1-ratio)*220), math.floor(ratio*80), math.floor(ratio*255))
	end)

	local frameCount = 0
	local dc = RunService.RenderStepped:Connect(function()
		if not hrp or not hrp.Parent or not lDist or not lDist.Parent then return end
		local myRoot = getHRP()
		if myRoot then
			local d = math.floor((hrp.Position - myRoot.Position).Magnitude)
			lDist.Text = "📍 "..d.." st"
			if d < 20 then lDist.TextColor3 = Color3.fromRGB(255,60,60)
			elseif d < 50 then lDist.TextColor3 = Color3.fromRGB(100,160,255)
			else lDist.TextColor3 = Color3.fromRGB(80,120,220) end
		end
		frameCount = frameCount + 1
		if STAFFDetectOn and frameCount % 15 == 0 then
			local isSTAFF = isSuspectedSTAFF(plr)
			if isSTAFF then
				if hl and hl.Parent then hl.FillColor = Color3.fromRGB(220,20,20); hl.OutlineColor = Color3.fromRGB(255,80,80) end
				stroke.Color = Color3.fromRGB(220,20,20); lSTAFF.Visible = true; lName.TextColor3 = Color3.fromRGB(255,80,80)
			else
				if hl and hl.Parent then hl.FillColor = Color3.fromRGB(30,80,220); hl.OutlineColor = Color3.fromRGB(120,180,255) end
				stroke.Color = Color3.fromRGB(30,80,220); lSTAFF.Visible = false; lName.TextColor3 = Color3.fromRGB(130,180,255)
			end
		end
	end)
	trackDistC[plr.Name] = dc
end

local function addTrack(plr)
	if plr == LP then return end
	cleanTrack(plr)
	if plr.Character then task.spawn(setupTrackChar, plr, plr.Character) end
	trackCharC[plr.Name] = plr.CharacterAdded:Connect(function(char)
		if trackOn then task.spawn(setupTrackChar, plr, char) end
	end)
end

task.spawn(function()
	while true do
		task.wait(2)
		if trackOn then
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LP and (not trackHL[plr.Name] or not trackHL[plr.Name].Parent) then
					if plr.Character then task.spawn(setupTrackChar, plr, plr.Character) end
				end
			end
		end
	end
end)

-- ══════════════════════════════════════
--  VÉHICULE
-- ══════════════════════════════════════
local detectedVehicle = nil
local vehicleFlyConn  = nil
local vehicleRGBConn  = nil
local vehicleSpeed    = 100

local function scanVehicles()
	local found = {}
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("VehicleSeat") or obj:IsA("Seat") then
			local model = obj:FindFirstAncestorOfClass("Model")
			if model and not table.find(found, model) then table.insert(found, model) end
		end
	end
	return found
end

local function detectVehicle()
	local hum = getHum()
	if hum and hum.SeatPart then
		local model = hum.SeatPart:FindFirstAncestorOfClass("Model")
		if model then detectedVehicle = model; return true end
	end
	local username = LP.Name:lower()
	for _, obj in pairs(workspace:GetDescendants()) do
		if obj:IsA("Model") and obj.Name:lower():find(username) then
			if obj:FindFirstChildOfClass("VehicleSeat") or obj:FindFirstChildOfClass("Seat") then
				detectedVehicle = obj; return true
			end
		end
	end
	local list = scanVehicles()
	if #list > 0 then detectedVehicle = list[1]; return true end
	return false
end

local function bindSeatDetect()
	local hum = getHum(); if not hum then return end
	hum:GetPropertyChangedSignal("SeatPart"):Connect(function()
		local seat = hum.SeatPart
		if seat then
			local model = seat:FindFirstAncestorOfClass("Model")
			if model then detectedVehicle = model; notify("🚗","'"..model.Name.."' verrouillé ! ✡️",2) end
		end
	end)
end

bindSeatDetect()
LP.CharacterAdded:Connect(function() task.wait(1); bindSeatDetect() end)

task.spawn(function()
	while task.wait(0.5) do
		if not detectedVehicle then
			if detectVehicle() then notify("🚗","'"..detectedVehicle.Name.."' détecté ! ✡️",3) end
		else
			if not detectedVehicle.Parent then detectedVehicle = nil end
		end
	end
end)

local function stopVehicleRGB()
	if vehicleRGBConn then vehicleRGBConn:Disconnect(); vehicleRGBConn = nil end
end

-- ══════════════════════════════════════
--  TABS UI
-- ══════════════════════════════════════

-- ── TAB 1 : PLAYER ────────────────────────────────────────────
local PlayerTab = Window:CreateTab("🟦 Player", 4483362458)

PlayerTab:CreateSection("Vitesses")
PlayerTab:CreateSlider({
	Name = "Walk Speed", Range = {0,999}, Increment = 1,
	Suffix = " st/s", CurrentValue = 16, Flag = "WalkSpeed",
	Callback = function(v)
		realWalkSpeed = v
		local h = getHum()
		if h and not FLYING then h.WalkSpeed = v end
	end,
})
PlayerTab:CreateSlider({
	Name = "Jump Power", Range = {0,500}, Increment = 5,
	Suffix = " pow", CurrentValue = 50, Flag = "JumpPower",
	Callback = function(v)
		local h = getHum()
		if h then h.UseJumpPower = true; h.JumpPower = v end
	end,
})
PlayerTab:CreateSlider({
	Name = "Fly Speed", Range = {10,500}, Increment = 5,
	Suffix = " st/s", CurrentValue = 80, Flag = "FlySpeed",
	Callback = function(v) flySpeed = v end,
})

PlayerTab:CreateSection("✈️ Fly")
PlayerTab:CreateLabel("💡 CTRL Gauche = Toggle ON/OFF")
PlayerTab:CreateLabel("💡 WASD = direction | E = monter | Q = descendre")
PlayerTab:CreateButton({ Name = "✈️ Activer",    Callback = function() sFLY() end })
PlayerTab:CreateButton({ Name = "🛑 Désactiver", Callback = function() NOFLY() end })

PlayerTab:CreateSection("Extras")
local ijConn = nil
PlayerTab:CreateToggle({
	Name = "🚀 Infinite Jump", CurrentValue = false, Flag = "IJ",
	Callback = function(v)
		if ijConn then ijConn:Disconnect(); ijConn = nil end
		if v then
			ijConn = UIS.JumpRequest:Connect(function()
				local h = getHum()
				if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end
			end)
		end
		notify("🚀 Infinite Jump", v and "ON ✡️" or "OFF", 2)
	end,
})
local ncConn = nil
PlayerTab:CreateToggle({
	Name = "👻 Noclip", CurrentValue = false, Flag = "NC",
	Callback = function(v)
		if ncConn then ncConn:Disconnect(); ncConn = nil end
		if v then
			ncConn = RunService.Stepped:Connect(function()
				local c = getChar()
				if c then
					for _, p in pairs(c:GetDescendants()) do
						if p:IsA("BasePart") then p.CanCollide = false end
					end
				end
			end)
		end
		notify("👻 Noclip", v and "ON ✡️" or "OFF", 2)
	end,
})
PlayerTab:CreateButton({
	Name = "🔄 Reset Stats",
	Callback = function()
		local h = getHum()
		if h then h.WalkSpeed = 16; h.JumpPower = 50; h.UseJumpPower = true end
		realWalkSpeed = 16
		notify("🔄 Reset","Stats remises à défaut",2)
	end,
})

-- ── TAB 2 : AIMBOT ────────────────────────────────────────────
local AimbotTab = Window:CreateTab("🎯 Aimbot", 4483362458)
AimbotTab:CreateSection("🎯 Aimbot — Gunfight Mode")
AimbotTab:CreateLabel("💡 F = ON/OFF rapide")
AimbotTab:CreateToggle({
	Name = "🎯 Aimbot ON/OFF", CurrentValue = false, Flag = "AimbotToggle",
	Callback = function(v) aimbotEnabled = v; notify("🎯 Aimbot", v and "ON ✡️" or "OFF 🛑", 2) end,
})
AimbotTab:CreateSlider({
	Name = "🔭 FOV détection", Range = {50,800}, Increment = 10,
	Suffix = " px", CurrentValue = 300, Flag = "AimbotFOV",
	Callback = function(v) aimbotFOV = v end,
})
AimbotTab:CreateSlider({
	Name = "🌊 Smoothing", Range = {0,90}, Increment = 5,
	Suffix = "%", CurrentValue = 30, Flag = "AimbotSmooth",
	Callback = function(v) aimbotSmoothing = v / 100 end,
})
AimbotTab:CreateSection("🎯 Partie visée")
AimbotTab:CreateDropdown({
	Name = "Partie du corps",
	Options = {"Head","HumanoidRootPart","UpperTorso","LowerTorso"},
	CurrentOption = {"Head"}, Flag = "AimbotPart",
	Callback = function(sel) aimbotPart = sel[1] or "Head"; notify("🎯","Vise : "..aimbotPart.." ✡️",2) end,
})
AimbotTab:CreateLabel("💡 Smoothing 0% = snap | 50%+ = fluide")

-- ── TAB 3 : COMBAT ────────────────────────────────────────────
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local targetedPlayer   = nil
local pushAuraActive   = false
local touchFlingActive = false
local voidProtEnabled  = false

local function setVoidProtection(bool)
	if bool then workspace.FallenPartsDestroyHeight = 0/0
	else workspace.FallenPartsDestroyHeight = -500 end
end

CombatTab:CreateSection("🎯 Cibler")
CombatTab:CreateInput({
	Name = "Nom du joueur", PlaceholderText = "@pseudo...",
	RemoveTextAfterFocusLost = false, Flag = "TargetInput",
	Callback = function(text)
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LP and plr.Name:lower():find(text:lower()) then
				targetedPlayer = plr; notify("🎯 Target","Ciblé : "..plr.Name.." ✡️",3); return
			end
		end
		notify("🎯 Target","Joueur introuvable !",2)
	end,
})
CombatTab:CreateButton({
	Name = "👥 Joueurs en ligne",
	Callback = function()
		local t = {}
		for _, p in pairs(Players:GetPlayers()) do if p ~= LP then t[#t+1] = p.Name end end
		notify("👥 Online", #t > 0 and table.concat(t,"  |  ") or "Personne !",7)
	end,
})
CombatTab:CreateButton({
	Name = "❌ Effacer cible",
	Callback = function() targetedPlayer = nil; notify("🎯","Cible effacée",2) end,
})
CombatTab:CreateSection("🎮 Actions cible")
CombatTab:CreateButton({
	Name = "👊 Push PUISSANT",
	Callback = function()
		if not targetedPlayer then notify("❌","Aucune cible !",2) return end
		doPush(targetedPlayer); notify("👊 Push","→ "..targetedPlayer.Name.." 💥",2)
	end,
})
CombatTab:CreateButton({
	Name = "📡 TP sur la cible",
	Callback = function()
		if not targetedPlayer then notify("❌","Aucune cible !",2) return end
		local r = getTargetRoot(targetedPlayer); local m = getHRP()
		if r and m then m.CFrame = r.CFrame + Vector3.new(0,3,0); notify("📡","→ "..targetedPlayer.Name,2) end
	end,
})
CombatTab:CreateSection("🌀 Auras")
CombatTab:CreateToggle({
	Name = "👊 Push Aura", CurrentValue = false, Flag = "PushAura",
	Callback = function(v)
		pushAuraActive = v
		if v then
			notify("👊 Push Aura","ON ✡️")
			task.spawn(function()
				while pushAuraActive do
					pcall(function()
						for _, plr in pairs(Players:GetPlayers()) do
							if plr ~= LP and plr.Character then
								local myRoot = getHRP(); local tRoot = getTargetRoot(plr)
								if myRoot and tRoot then
									local savedPos = myRoot.CFrame
									predTP(plr); task.wait(safeGetPing()+0.03)
									doServerPush(plr); doPowerPush(plr)
									task.wait(0.05); myRoot.CFrame = savedPos
								end
							end
						end
					end)
					task.wait(0.35)
				end
			end)
		else notify("👊 Push Aura","OFF",2) end
	end,
})
CombatTab:CreateToggle({
	Name = "👆 Touch Fling", CurrentValue = false, Flag = "TouchFling",
	Callback = function(v)
		touchFlingActive = v
		if v then
			notify("👆 Touch Fling","ON ✡️"); setVoidProtection(true)
			task.spawn(function()
				while touchFlingActive do
					pcall(function()
						local myRoot = getHRP()
						if myRoot then
							local RV = myRoot.Velocity
							myRoot.Velocity = Vector3.new(math.random(-150,150),-25000,math.random(-150,150))
							RunService.RenderStepped:Wait()
							myRoot.Velocity = RV
						end
					end)
					RunService.Heartbeat:Wait()
				end
				if not voidProtEnabled then setVoidProtection(false) end
			end)
		else
			touchFlingActive = false
			if not voidProtEnabled then setVoidProtection(false) end
			notify("👆 Touch Fling","OFF",2)
		end
	end,
})
CombatTab:CreateToggle({
	Name = "🛡️ Void Protection", CurrentValue = false, Flag = "VoidProt",
	Callback = function(v)
		voidProtEnabled = v; setVoidProtection(v)
		notify("🛡️ Void Prot", v and "ON ✡️" or "OFF",2)
	end,
})
CombatTab:CreateSection("🔧 Outils")
CombatTab:CreateButton({
	Name = "🖱️ Click-Target Tool",
	Callback = function()
		local tool = Instance.new("Tool")
		tool.Name = "ClickTarget"; tool.RequiresHandle = false
		local mouse = LP:GetMouse()
		tool.Activated:Connect(function()
			local hit = mouse.Target; if not hit then return end
			local p = Players:GetPlayerFromCharacter(hit.Parent) or Players:GetPlayerFromCharacter(hit.Parent.Parent)
			if p and p ~= LP then targetedPlayer = p; notify("🎯 Target","Ciblé : "..p.Name.." ✡️",3) end
		end)
		tool.Parent = LP.Backpack; notify("🖱️ Click-Target","Dans ton backpack ✡️")
	end,
})
CombatTab:CreateButton({
	Name = "👊 Modded Push Tool",
	Callback = function()
		local tool = Instance.new("Tool")
		tool.Name = "ModdedPush"; tool.RequiresHandle = false
		local mouse = LP:GetMouse()
		tool.Activated:Connect(function()
			local hit = mouse.Target; if not hit then return end
			local p = Players:GetPlayerFromCharacter(hit.Parent) or Players:GetPlayerFromCharacter(hit.Parent.Parent)
			if p and p ~= LP then doPush(p) end
		end)
		tool.Parent = LP.Backpack; notify("👊 Modded Push","Dans ton backpack ✡️")
	end,
})

-- ── TAB 4 : VÉHICULE ──────────────────────────────────────────
local VehTab = Window:CreateTab("🚗 Véhicule", 4483362458)
VehTab:CreateSection("📡 TP Véhicule au clic")
VehTab:CreateLabel("💡 Active → clic gauche = voiture TP là")
local vehTPEnabled = false
local vehTPConn    = nil
VehTab:CreateToggle({
	Name = "📡 TP Véhicule au clic", CurrentValue = false, Flag = "VehTP",
	Callback = function(v)
		vehTPEnabled = v
		if vehTPConn then vehTPConn:Disconnect(); vehTPConn = nil end
		if v then
			if not detectedVehicle or not detectedVehicle.Parent then
				if not detectVehicle() then notify("❌","Aucun véhicule !",3); vehTPEnabled = false; return end
			end
			notify("📡 Veh TP","ON ✡️")
			vehTPConn = UIS.InputBegan:Connect(function(input, gpe)
				if gpe or not vehTPEnabled then return end
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
				if not detectedVehicle or not detectedVehicle.Parent then
					notify("❌","Véhicule disparu !",2); vehTPEnabled = false; return
				end
				local mouse = LP:GetMouse(); local cam = getCam()
				local origin = cam.CFrame.Position; local target = mouse.Hit.Position
				local dir = (target - origin)
				if dir.Magnitude < 0.5 then return end
				local params = RaycastParams.new()
				params.FilterType = Enum.RaycastFilterType.Exclude
				local excl = {detectedVehicle}
				if getChar() then table.insert(excl, getChar()) end
				params.FilterDescendantsInstances = excl
				local result = workspace:Raycast(origin, dir.Unit * 2000, params)
				local hitPos = result and result.Position or target
				if detectedVehicle.PrimaryPart then
					detectedVehicle:SetPrimaryPartCFrame(CFrame.new(hitPos + Vector3.new(0,4,0)))
				else
					local root = nil
					for _, p in pairs(detectedVehicle:GetDescendants()) do
						if p:IsA("BasePart") and not p.Anchored then root = p; break end
					end
					if root then
						local offset = (hitPos + Vector3.new(0,4,0)) - root.Position
						for _, p in pairs(detectedVehicle:GetDescendants()) do
							if p:IsA("BasePart") then p.CFrame = p.CFrame + offset end
						end
					end
				end
				notify("📡","Téléporté ! ✡️",1)
			end)
		else notify("📡 Veh TP","OFF",2) end
	end,
})

VehTab:CreateSection("🏎️ Vitesse & Fly")
local vehFlyEnabled = false
local vehFlyKeyDown = nil
local vehFlyKeyUp   = nil

VehTab:CreateSlider({
	Name = "🚀 Veh Fly Speed", Range = {10,500}, Increment = 10,
	Suffix = " st/s", CurrentValue = 100, Flag = "VehFlySpeed",
	Callback = function(v)
		vehicleSpeed = v
		if detectedVehicle then
			for _, obj in pairs(detectedVehicle:GetDescendants()) do
				if obj:IsA("VehicleSeat") then obj.MaxSpeed = v end
			end
		end
	end,
})

VehTab:CreateToggle({
	Name = "✈️ Vehicle Fly", CurrentValue = false, Flag = "VehicleFly",
	Callback = function(v)
		if v then
			local hrp = getHRP(); if not hrp then notify("❌","Personnage introuvable !",2) return end
			local VCTRL = {F=0,B=0,L=0,R=0,U=0,D=0}
			vehFlyEnabled = true
			local vBV = Instance.new("BodyVelocity")
			vBV.MaxForce = Vector3.new(9e9,9e9,9e9); vBV.Velocity = Vector3.zero; vBV.Parent = hrp
			local vBGy = Instance.new("BodyGyro")
			vBGy.MaxTorque = Vector3.new(0,9e9,0); vBGy.P = 9e4; vBGy.D = 1000
			vBGy.CFrame = CFrame.new(hrp.Position); vBGy.Parent = hrp
			vehicleFlyConn = RunService.Heartbeat:Connect(function()
				if not vehFlyEnabled then return end
				local h = getHRP(); if not h then return end
				local cam = getCam(); local dir = Vector3.zero
				if VCTRL.F ~= 0 then dir += cam.CFrame.LookVector  end
				if VCTRL.B ~= 0 then dir -= cam.CFrame.LookVector  end
				if VCTRL.L ~= 0 then dir -= cam.CFrame.RightVector end
				if VCTRL.R ~= 0 then dir += cam.CFrame.RightVector end
				if VCTRL.U ~= 0 then dir += Vector3.new(0,1,0)     end
				if VCTRL.D ~= 0 then dir -= Vector3.new(0,1,0)     end
				if dir.Magnitude > 0 then dir = dir.Unit end
				vBV.Velocity = dir * vehicleSpeed
				h.Velocity = vBV.Velocity
				local flat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				if flat.Magnitude > 0.01 then vBGy.CFrame = CFrame.new(Vector3.zero, flat) end
			end)
			vehFlyKeyDown = UIS.InputBegan:Connect(function(inp, gpe)
				if gpe then return end
				if inp.KeyCode == Enum.KeyCode.W     then VCTRL.F = 1
				elseif inp.KeyCode == Enum.KeyCode.S then VCTRL.B = 1
				elseif inp.KeyCode == Enum.KeyCode.A then VCTRL.L = 1
				elseif inp.KeyCode == Enum.KeyCode.D then VCTRL.R = 1
				elseif inp.KeyCode == Enum.KeyCode.E then VCTRL.U = 1
				elseif inp.KeyCode == Enum.KeyCode.Q then VCTRL.D = 1
				end
			end)
			vehFlyKeyUp = UIS.InputEnded:Connect(function(inp, gpe)
				if gpe then return end
				if inp.KeyCode == Enum.KeyCode.W     then VCTRL.F = 0
				elseif inp.KeyCode == Enum.KeyCode.S then VCTRL.B = 0
				elseif inp.KeyCode == Enum.KeyCode.A then VCTRL.L = 0
				elseif inp.KeyCode == Enum.KeyCode.D then VCTRL.R = 0
				elseif inp.KeyCode == Enum.KeyCode.E then VCTRL.U = 0
				elseif inp.KeyCode == Enum.KeyCode.Q then VCTRL.D = 0
				end
			end)
			notify("✈️ Veh Fly","ON ✡️ — WASD | E = monter | Q = descendre",3)
		else
			vehFlyEnabled = false
			if vehicleFlyConn then vehicleFlyConn:Disconnect(); vehicleFlyConn = nil end
			if vehFlyKeyDown  then vehFlyKeyDown:Disconnect();  vehFlyKeyDown  = nil end
			if vehFlyKeyUp    then vehFlyKeyUp:Disconnect();    vehFlyKeyUp    = nil end
			local hrp = getHRP()
			if hrp then
				for _, c in pairs(hrp:GetChildren()) do
					if c:IsA("BodyVelocity") or c:IsA("BodyGyro") then c:Destroy() end
				end
			end
			notify("✈️ Vehicle Fly","OFF",2)
		end
	end,
})

-- ── TAB 5 : TÉLÉPORT ──────────────────────────────────────────
local TpTab = Window:CreateTab("📡 Téléport", 4483362458)
TpTab:CreateSection("📡 TP Clic")
local tpClicEnabled = false
local tpClicConn    = nil
TpTab:CreateToggle({
	Name = "📡 TP Clic ON/OFF", CurrentValue = false, Flag = "TpClic",
	Callback = function(v)
		tpClicEnabled = v
		if tpClicConn then tpClicConn:Disconnect(); tpClicConn = nil end
		if v then
			notify("📡 TP Clic","ON ✡️")
			tpClicConn = UIS.InputBegan:Connect(function(input, gpe)
				if gpe or not tpClicEnabled then return end
				if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
				local mouse = LP:GetMouse(); local m = getHRP()
				if m then m.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0)); notify("📡","✡️",1) end
			end)
		else notify("📡 TP Clic","OFF",2) end
	end,
})
TpTab:CreateSection("Destinations")
TpTab:CreateButton({
	Name = "🏠 TP au Spawn",
	Callback = function()
		local m = getHRP(); local s = workspace:FindFirstChildOfClass("SpawnLocation")
		if m and s then m.CFrame = s.CFrame + Vector3.new(0,5,0); notify("🏠","✡️",2)
		else notify("🏠","Introuvable !",2) end
	end,
})
TpTab:CreateSection("TP → Joueur")
local function makeTPBtn(plr)
	TpTab:CreateButton({
		Name = "✡️ TP → "..plr.Name,
		Callback = function()
			local m = getHRP(); local r = getTargetRoot(plr)
			if m and r then m.CFrame = r.CFrame + Vector3.new(0,3,3); notify("📡","→ "..plr.Name,2)
			else notify("❌",plr.Name.." introuvable !",2) end
		end,
	})
end
for _, p in pairs(Players:GetPlayers()) do if p ~= LP then makeTPBtn(p) end end
TpTab:CreateButton({
	Name = "🔄 Refresh",
	Callback = function()
		for _, p in pairs(Players:GetPlayers()) do if p ~= LP then makeTPBtn(p) end end
		notify("🔄","Mis à jour !",2)
	end,
})
Players.PlayerAdded:Connect(function(p) task.wait(1); if p ~= LP then makeTPBtn(p) end end)

-- ── TAB 6 : ANIMATIONS ────────────────────────────────────────
local AnimTab = Window:CreateTab("🕺 Animations", 4483362458)
AnimTab:CreateSection("🎭 Animations")
AnimTab:CreateButton({
	Name = "💦 BranlaxLeChibrax",
	Callback = function()
		loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
		notify("💦","BranlaxLeChibrax ajouté !",2)
	end,
})
local ANIMS = {
	{"🤖 Robot Dance","507766388"},{"🕺 Floss","5915693312"},
	{"💃 Samba","507776879"},{"👋 Wave","507770239"},
	{"😂 Laugh","507770818"},{"👍 Cheer","507770677"},
	{"😴 Sleep","507771019"},{"🎸 Air Guitar","182453160"},
	{"🕶️ Too Cool","507769051"},{"🦁 Roar","507761307"},
}
local currentAnim = nil
local function playAnim(id)
	local hum = getHum(); if not hum then return end
	if currentAnim then pcall(function() currentAnim:Stop() end); currentAnim = nil end
	local anim = Instance.new("Animation"); anim.AnimationId = "rbxassetid://"..id
	local animator = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator",3)
	if animator then
		local track = animator:LoadAnimation(anim)
		track.Priority = Enum.AnimationPriority.Action; track:Play()
		currentAnim = track; notify("🕺","✡️",2)
	end
end
for _, a in ipairs(ANIMS) do
	local d = a
	AnimTab:CreateButton({ Name = d[1], Callback = function() playAnim(d[2]) end })
end
AnimTab:CreateButton({
	Name = "⏹️ Stop",
	Callback = function()
		if currentAnim then pcall(function() currentAnim:Stop() end); currentAnim = nil; notify("⏹️","Arrêtée",2)
		else notify("⏹️","Aucune anim",2) end
	end,
})
AnimTab:CreateInput({
	Name = "ID Custom", PlaceholderText = "507766388",
	RemoveTextAfterFocusLost = false, Flag = "CustomAnim",
	Callback = function(id) if id and id ~= "" then playAnim(id) end end,
})

-- ── TAB 7 : TRACKALL ──────────────────────────────────────────
local ESPTab = Window:CreateTab("👁️ TrackAll", 4483362458)
ESPTab:CreateSection("ESP Pro")
ESPTab:CreateLabel("💡 Wallhack • HP bar • Distance • Auto-respawn")
ESPTab:CreateToggle({
	Name = "👁️ TrackAll ON/OFF", CurrentValue = false, Flag = "TrackAll",
	Callback = function(v)
		trackOn = v
		if v then
			for _, p in pairs(Players:GetPlayers()) do addTrack(p) end
			notify("👁️ TrackAll","ON ✡️")
		else
			for _, p in pairs(Players:GetPlayers()) do cleanTrack(p) end
			notify("👁️ TrackAll","OFF",2)
		end
	end,
})
ESPTab:CreateButton({
	Name = "🔄 Refresh manuel",
	Callback = function()
		if not trackOn then notify("❌","Active TrackAll d'abord !",2) return end
		for _, p in pairs(Players:GetPlayers()) do cleanTrack(p) end
		task.wait(0.3)
		for _, p in pairs(Players:GetPlayers()) do addTrack(p) end
		notify("🔄","Rafraîchi ✡️",2)
	end,
})
ESPTab:CreateSection("🚨 STAFF Detect")
ESPTab:CreateLabel("💡 Analyse : Speed/Fly • Godmode")
ESPTab:CreateLabel("💡 STAFF = ESP rouge + label ⚠️ STAFF")
ESPTab:CreateToggle({
	Name = "🚨 STAFF Detect ON/OFF", CurrentValue = false, Flag = "STAFFDetect",
	Callback = function(v)
		STAFFDetectOn = v
		if v then
			if not trackOn then
				trackOn = true
				for _, p in pairs(Players:GetPlayers()) do addTrack(p) end
				notify("👁️ TrackAll","Activé automatiquement ✡️",2)
			end
			playerSnapshots = {}
			notify("🚨 STAFF Detect","ON ✡️",3)
		else
			notify("🚨 STAFF Detect","OFF",2)
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LP and trackHL[plr.Name] and trackHL[plr.Name].Parent then
					trackHL[plr.Name].FillColor    = Color3.fromRGB(30,80,220)
					trackHL[plr.Name].OutlineColor = Color3.fromRGB(120,180,255)
				end
			end
			playerSnapshots = {}
		end
	end,
})
ESPTab:CreateButton({
	Name = "🔍 Scan manuel — STAFFs",
	Callback = function()
		local found = {}
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LP and isSuspectedSTAFF(plr) then table.insert(found, plr.Name) end
		end
		if #found == 0 then notify("🔍 Scan","Aucun STAFF détecté ✡️",3)
		else notify("🚨 STAFFs",table.concat(found,"  |  "),7) end
	end,
})
Players.PlayerAdded:Connect(function(p) task.wait(1); if trackOn then addTrack(p) end end)
Players.PlayerRemoving:Connect(function(p) cleanTrack(p); playerSnapshots[p.Name] = nil end)

-- ── TAB 8 : VISUAL ────────────────────────────────────────────
local VisualTab = Window:CreateTab("✨ Visual", 4483362458)
VisualTab:CreateSection("Lighting")
VisualTab:CreateToggle({
	Name = "🌫️ Remove Fog", CurrentValue = false, Flag = "NoFog",
	Callback = function(v) Lighting.FogEnd = v and 1e6 or 1000; Lighting.FogStart = v and 1e6 or 0 end,
})
VisualTab:CreateToggle({
	Name = "☀️ Fullbright", CurrentValue = false, Flag = "Fullbright",
	Callback = function(v)
		Lighting.Brightness = v and 10 or 1; Lighting.ClockTime = v and 14 or 12
		Lighting.Ambient = v and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70)
	end,
})
VisualTab:CreateSlider({
	Name = "🔭 FOV", Range = {60,120}, Increment = 1,
	Suffix = "°", CurrentValue = 70, Flag = "FOV",
	Callback = function(v) getCam().FieldOfView = v end,
})

-- ── TAB 9 : SCRIPTS ───────────────────────────────────────────
local ScriptsTab = Window:CreateTab("📜 Scripts", 4483362458)
ScriptsTab:CreateSection("🧪 Scripts externes")
ScriptsTab:CreateButton({
	Name = "▶️ SystemBroken",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/GZSSF/script3/95a45577475502cfbf546ae9ca8fc4f00b61eb83/script3"))()
		notify("📜","SystemBroken exécuté !",2)
	end,
})
ScriptsTab:CreateButton({
	Name = "▶️ Infinite Yield",
	Callback = function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		notify("📜","Infinite Yield exécuté !",2)
	end,
})
ScriptsTab:CreateButton({
	Name = "▶️ BypassAntiCheat",
	Callback = function()
		local old
		old = hookmetamethod(game, "__namecall", function(self, ...)
			local method = getnamecallmethod()
			local args = {...}
			if method == "InvokeServer" then
				for _, v in ipairs(args) do
					if typeof(v) == "string" and string.find(v:lower(), "added blacklisted") then
						warn("Blocked call:", v)
						return nil
					end
				end
				return old(self, unpack(args))
			end
			return old(self, ...)
		end)
		notify("📜","Bypass anticheat exécuté !",2)
	end,
})

-- ── TAB 10 : MISC ─────────────────────────────────────────────
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
MiscTab:CreateSection("Utilitaire")
local afkConn = nil
MiscTab:CreateToggle({
	Name = "💤 Anti-AFK", CurrentValue = true, Flag = "AntiAFK",
	Callback = function(v)
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if v then
			local VU = game:GetService("VirtualUser")
			afkConn = LP.Idled:Connect(function()
				VU:Button2Down(Vector2.zero, getCam().CFrame)
				task.wait(1)
				VU:Button2Up(Vector2.zero, getCam().CFrame)
			end)
		end
		notify("💤 Anti-AFK", v and "ON ✡️" or "OFF",2)
	end,
})
MiscTab:CreateButton({
	Name = "🔄 Rejoin",
	Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end,
})

-- ── TAB 11 : CRÉDITS ──────────────────────────────────────────
local CreditsTab = Window:CreateTab("✡️ Crédits", 4483362458)
CreditsTab:CreateSection("Dev")
CreditsTab:CreateLabel("👑 FocusOnTop")
CreditsTab:CreateLabel("💬 DISCORD SOON")
CreditsTab:CreateSection("Build")
CreditsTab:CreateLabel("✡️ Tel-Aviv — Script")
CreditsTab:CreateLabel("🟦 Fly • Aimbot • ESP • STAFF Detect • Véhicule")

-- ══════════════════════════════════════
--  INIT
-- ══════════════════════════════════════
do
	local VU = game:GetService("VirtualUser")
	afkConn = LP.Idled:Connect(function()
		VU:Button2Down(Vector2.zero, getCam().CFrame)
		task.wait(1)
		VU:Button2Up(Vector2.zero, getCam().CFrame)
	end)
end

notify("✡️ Tel-Aviv","CLIENT chargé ! — By FocusOnTop",5)
