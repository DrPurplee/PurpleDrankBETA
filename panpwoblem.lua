-- ╔══════════════════════════════════════════════════════╗
-- ║       ✡️  TEL-AVIV CLIENT  —  [BETA]                 ║
-- ║              By FocusOnTop  💜  2026                 ║
-- ╚══════════════════════════════════════════════════════╝

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- ══════════════════════════════════════
--  MUSIQUE AU LANCEMENT
-- ══════════════════════════════════════
local bgMusic = Instance.new("Sound")
bgMusic.SoundId              = "rbxassetid://1845924914"
bgMusic.Volume               = 0.5
bgMusic.Looped               = true
bgMusic.RollOffMaxDistance   = 0
bgMusic.Parent               = workspace
bgMusic:Play()

-- ══════════════════════════════════════
--  BYPASS ANTICHEAT AUTO
-- ══════════════════════════════════════
pcall(function()
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
end)

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
		FolderName = "TelAviv",
		FileName   = "ClientConfig",
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

-- ══════════════════════════════════════
--  NOTIF ANTI-SPAM
-- ══════════════════════════════════════
local notifCooldowns = {}
local function notify(title, content, dur, cooldown)
	cooldown = cooldown or 0
	if cooldown > 0 then
		local key = title
		local now = tick()
		if notifCooldowns[key] and (now - notifCooldowns[key]) < cooldown then return end
		notifCooldowns[key] = now
	end
	Rayfield:Notify({ Title = title, Content = content, Duration = dur or 3 })
end

-- ══════════════════════════════════════════════════════════════
--  SKIN LOCAL — FIX : chargement asynchrone propre
-- ══════════════════════════════════════════════════════════════
local skinTargetName  = "cutieinaria"
local skinTargetId    = nil
local skinAutoReapply = true
local skinLoaded      = false

local function applySkinById(id, char)
	if not id or not char then return false end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return false end
	local desc = nil
	local ok = pcall(function()
		desc = Players:GetHumanoidDescriptionFromUserId(id)
	end)
	if ok and desc then
		pcall(function() hum:ApplyDescription(desc) end)
		return true
	end
	return false
end

-- Chargement de l'ID en arrière-plan dès le démarrage
task.spawn(function()
	task.wait(2)
	local ok, id = pcall(function()
		return Players:GetUserIdFromNameAsync(skinTargetName)
	end)
	if ok and id then
		skinTargetId = id
		skinLoaded   = true
		-- Applique immédiatement sur le perso actuel
		local char = LP.Character or LP.CharacterAdded:Wait()
		task.wait(0.5)
		if applySkinById(skinTargetId, char) then
			notify("👤 Skin", "Skin de "..skinTargetName.." appliqué ✡️", 3)
		end
	else
		warn("[TelAviv] Skin : impossible de trouver "..skinTargetName)
		notify("👤 Skin", "Impossible de charger "..skinTargetName, 4)
	end
end)

-- Réapplication auto au respawn
LP.CharacterAdded:Connect(function(char)
	if skinAutoReapply and skinTargetId then
		task.wait(1)
		applySkinById(skinTargetId, char)
	end
end)

-- ══════════════════════════════════════
--  WATCH LIST
-- ══════════════════════════════════════
local WATCH_LIST = {}

local function isWatched(name)
	for _, n in ipairs(WATCH_LIST) do if n == name then return true end end
	return false
end

task.spawn(function()
	task.wait(2)
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LP and isWatched(plr.Name) then
			notify("⚠️ ALERTE SESSION", plr.Name.." est déjà dans la session ! 👀", 10)
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if isWatched(plr.Name) then notify("🚨 ALERTE", plr.Name.." vient de rejoindre ! 👀", 10) end
end)
Players.PlayerRemoving:Connect(function(plr)
	if isWatched(plr.Name) then notify("✅ PARTI", plr.Name.." a quitté la session.", 6) end
end)

-- ══════════════════════════════════════════════════════════════
--  WATERMARK
-- ══════════════════════════════════════════════════════════════
task.spawn(function()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name           = "TelAvivWatermark"
	screenGui.ResetOnSpawn   = false
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.DisplayOrder   = 999
	local ok = pcall(function() screenGui.Parent = game:GetService("CoreGui") end)
	if not ok then screenGui.Parent = LP:WaitForChild("PlayerGui") end

	local frame = Instance.new("Frame")
	frame.Size                   = UDim2.new(0, 420, 0, 72)
	frame.Position               = UDim2.new(0.5, -210, 0, 10)
	frame.BackgroundColor3       = Color3.fromRGB(5, 10, 30)
	frame.BackgroundTransparency = 0.1
	frame.BorderSizePixel        = 0
	frame.Parent                 = screenGui
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 14)

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 1.5; stroke.Color = Color3.fromRGB(30, 80, 200); stroke.Parent = frame

	local mainLabel = Instance.new("TextLabel")
	mainLabel.Size = UDim2.new(0, 270, 0, 40); mainLabel.Position = UDim2.new(0, 16, 0, 6)
	mainLabel.BackgroundTransparency = 1; mainLabel.Text = "TEL-AVIV CLIENT"
	mainLabel.TextColor3 = Color3.fromRGB(200, 220, 255); mainLabel.Font = Enum.Font.GothamBold
	mainLabel.TextSize = 30; mainLabel.TextXAlignment = Enum.TextXAlignment.Left
	mainLabel.ZIndex = 4; mainLabel.Parent = frame

	local subLabel = Instance.new("TextLabel")
	subLabel.Size = UDim2.new(0, 270, 0, 18); subLabel.Position = UDim2.new(0, 16, 0, 47)
	subLabel.BackgroundTransparency = 1; subLabel.Text = "by FocusOnTop  •  BETA"
	subLabel.TextColor3 = Color3.fromRGB(100, 150, 240); subLabel.Font = Enum.Font.Gotham
	subLabel.TextSize = 15; subLabel.TextXAlignment = Enum.TextXAlignment.Left
	subLabel.ZIndex = 4; subLabel.Parent = frame

	local bar = Instance.new("Frame")
	bar.Size = UDim2.new(0, 2, 0, 44); bar.Position = UDim2.new(0, 298, 0.5, -22)
	bar.BackgroundColor3 = Color3.fromRGB(60, 130, 255); bar.BorderSizePixel = 0
	bar.ZIndex = 3; bar.Parent = frame
	Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

	local icon = Instance.new("ImageLabel")
	icon.Size = UDim2.new(0, 56, 0, 56); icon.Position = UDim2.new(0, 310, 0.5, -28)
	icon.BackgroundTransparency = 1; icon.Image = "rbxassetid://107792284821516"
	icon.ImageColor3 = Color3.fromRGB(255, 255, 255); icon.ScaleType = Enum.ScaleType.Fit
	icon.ZIndex = 4; icon.Parent = frame
end)

-- ══════════════════════════════════════════════════════════════
--  PANEL JOUEURS — FIX FOLLOW : caméra Scriptée, pas de TP
-- ══════════════════════════════════════════════════════════════
local playerPanelGui = nil
local followConn     = nil
local followTarget   = nil
local specCamEnabled = false

local function stopFollow()
	if followConn then followConn:Disconnect(); followConn = nil end
	followTarget   = nil
	specCamEnabled = false
	-- Remet la caméra en mode normal
	pcall(function()
		local cam = getCam()
		cam.CameraType = Enum.CameraType.Custom
		cam.CameraSubject = LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") or nil
	end)
end

-- FIX : le follow ne TP plus — il passe juste la caméra en mode SPEC (Watch)
local function startFollow(plr)
	stopFollow()
	followTarget   = plr
	specCamEnabled = true
	notify("👁️ Spec", "SPEC ON → "..plr.Name.." ✡️", 3)

	followConn = RunService.RenderStepped:Connect(function()
		if not specCamEnabled or not followTarget then stopFollow(); return end
		local char = followTarget.Character
		if not char then return end
		local hrp = char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end
		local cam = getCam()
		-- Mode Watch : caméra orbitale fixée sur la cible
		cam.CameraType    = Enum.CameraType.Watch
		cam.CameraSubject = hrp
	end)
end

local function buildPlayerPanel()
	if playerPanelGui and playerPanelGui.Parent then
		playerPanelGui:Destroy(); playerPanelGui = nil
		stopFollow(); return
	end

	local gui = Instance.new("ScreenGui")
	gui.Name = "TelAvivPlayerPanel"; gui.ResetOnSpawn = false; gui.DisplayOrder = 998
	local ok = pcall(function() gui.Parent = game:GetService("CoreGui") end)
	if not ok then gui.Parent = LP:WaitForChild("PlayerGui") end
	playerPanelGui = gui

	local main = Instance.new("Frame")
	main.Size = UDim2.new(0, 360, 0, 480); main.Position = UDim2.new(0.5, -180, 0.5, -240)
	main.BackgroundColor3 = Color3.fromRGB(5, 10, 30); main.BackgroundTransparency = 0.05
	main.BorderSizePixel = 0; main.Parent = gui
	Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
	local ms = Instance.new("UIStroke"); ms.Color = Color3.fromRGB(30, 80, 200); ms.Thickness = 1.5; ms.Parent = main

	local title = Instance.new("TextLabel")
	title.Size = UDim2.new(1, -40, 0, 36); title.Position = UDim2.new(0, 12, 0, 8)
	title.BackgroundTransparency = 1; title.Text = "👥 Joueurs en ligne"
	title.TextColor3 = Color3.fromRGB(200, 220, 255); title.Font = Enum.Font.GothamBold
	title.TextSize = 20; title.TextXAlignment = Enum.TextXAlignment.Left; title.Parent = main

	local closeBtn = Instance.new("TextButton")
	closeBtn.Size = UDim2.new(0, 30, 0, 30); closeBtn.Position = UDim2.new(1, -38, 0, 8)
	closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30); closeBtn.Text = "✕"
	closeBtn.TextColor3 = Color3.fromRGB(255,255,255); closeBtn.Font = Enum.Font.GothamBold
	closeBtn.TextSize = 16; closeBtn.BorderSizePixel = 0; closeBtn.Parent = main
	Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
	closeBtn.MouseButton1Click:Connect(function() stopFollow(); gui:Destroy(); playerPanelGui = nil end)

	local sep = Instance.new("Frame")
	sep.Size = UDim2.new(1, -24, 0, 1); sep.Position = UDim2.new(0, 12, 0, 48)
	sep.BackgroundColor3 = Color3.fromRGB(30, 80, 200); sep.BorderSizePixel = 0; sep.Parent = main

	local searchBox = Instance.new("TextBox")
	searchBox.Size = UDim2.new(1, -24, 0, 34); searchBox.Position = UDim2.new(0, 12, 0, 56)
	searchBox.BackgroundColor3 = Color3.fromRGB(10, 20, 55); searchBox.BorderSizePixel = 0
	searchBox.Text = ""; searchBox.PlaceholderText = "🔎  Rechercher un joueur..."
	searchBox.PlaceholderColor3 = Color3.fromRGB(100, 140, 220); searchBox.TextColor3 = Color3.fromRGB(220, 235, 255)
	searchBox.Font = Enum.Font.Gotham; searchBox.TextSize = 15; searchBox.ClearTextOnFocus = false
	searchBox.Parent = main
	Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 8)
	local sbs = Instance.new("UIStroke"); sbs.Color = Color3.fromRGB(30,80,200); sbs.Thickness = 1.2; sbs.Parent = searchBox

	local countLabel = Instance.new("TextLabel")
	countLabel.Size = UDim2.new(1, -24, 0, 18); countLabel.Position = UDim2.new(0, 12, 0, 94)
	countLabel.BackgroundTransparency = 1; countLabel.TextColor3 = Color3.fromRGB(100, 150, 240)
	countLabel.Font = Enum.Font.Gotham; countLabel.TextSize = 13
	countLabel.TextXAlignment = Enum.TextXAlignment.Left; countLabel.Parent = main

	local scroll = Instance.new("ScrollingFrame")
	scroll.Size = UDim2.new(1, -24, 1, -122); scroll.Position = UDim2.new(0, 12, 0, 114)
	scroll.BackgroundTransparency = 1; scroll.BorderSizePixel = 0
	scroll.ScrollBarThickness = 4; scroll.ScrollBarImageColor3 = Color3.fromRGB(60, 130, 255)
	scroll.CanvasSize = UDim2.new(0,0,0,0); scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
	scroll.Parent = main
	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0,6); listLayout.SortOrder = Enum.SortOrder.LayoutOrder; listLayout.Parent = scroll

	local playerCards = {}

	local function getPlayerStatus(plr)
		if plr == LP then return "C'est toi 👑" end
		local char = plr.Character
		if not char then return "⚠️ Pas de personnage" end
		local hum = char:FindFirstChildOfClass("Humanoid")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local myRoot = getHRP()
		local hp    = hum and math.floor(hum.Health) or 0
		local maxhp = hum and math.floor(hum.MaxHealth) or 100
		local dist  = "?"
		if myRoot and hrp then dist = math.floor((hrp.Position - myRoot.Position).Magnitude) end
		return "❤️ "..hp.."/"..maxhp.."   📍 "..dist.." st"
	end

	local function makeCard(plr)
		local card = Instance.new("Frame")
		card.Size = UDim2.new(1, 0, 0, 58); card.BackgroundColor3 = Color3.fromRGB(10, 20, 55)
		card.BackgroundTransparency = 0.2; card.BorderSizePixel = 0; card.Parent = scroll
		Instance.new("UICorner", card).CornerRadius = UDim.new(0, 8)
		local cs = Instance.new("UIStroke"); cs.Color = Color3.fromRGB(25,70,180); cs.Thickness = 1; cs.Parent = card

		local avatar = Instance.new("ImageLabel")
		avatar.Size = UDim2.new(0,42,0,42); avatar.Position = UDim2.new(0,8,0.5,-21)
		avatar.BackgroundColor3 = Color3.fromRGB(15,30,80); avatar.BorderSizePixel = 0
		avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId="..plr.UserId.."&width=48&height=48&format=png"
		avatar.Parent = card
		Instance.new("UICorner", avatar).CornerRadius = UDim.new(1, 0)

		local nameLabel = Instance.new("TextLabel")
		nameLabel.Size = UDim2.new(1,-110,0,22); nameLabel.Position = UDim2.new(0,58,0,8)
		nameLabel.BackgroundTransparency = 1; nameLabel.Text = "✡️ "..plr.Name
		nameLabel.TextColor3 = Color3.fromRGB(180,210,255); nameLabel.Font = Enum.Font.GothamBold
		nameLabel.TextSize = 15; nameLabel.TextXAlignment = Enum.TextXAlignment.Left
		nameLabel.TextTruncate = Enum.TextTruncate.AtEnd; nameLabel.Parent = card

		local statusLabel = Instance.new("TextLabel")
		statusLabel.Size = UDim2.new(1,-110,0,18); statusLabel.Position = UDim2.new(0,58,0,32)
		statusLabel.BackgroundTransparency = 1; statusLabel.Text = getPlayerStatus(plr)
		statusLabel.TextColor3 = Color3.fromRGB(100,150,230); statusLabel.Font = Enum.Font.Gotham
		statusLabel.TextSize = 12; statusLabel.TextXAlignment = Enum.TextXAlignment.Left; statusLabel.Parent = card

		task.spawn(function()
			while card and card.Parent do task.wait(1)
				if statusLabel and statusLabel.Parent then statusLabel.Text = getPlayerStatus(plr) end
			end
		end)

		-- FIX : bouton SPEC (👁️) — caméra Watch, PAS de TP
		local specBtn = Instance.new("TextButton")
		specBtn.Size = UDim2.new(0,36,0,36); specBtn.Position = UDim2.new(1,-88,0.5,-18)
		specBtn.BackgroundColor3 = Color3.fromRGB(20,60,180); specBtn.Text = "👁️"
		specBtn.TextSize = 18; specBtn.Font = Enum.Font.GothamBold
		specBtn.TextColor3 = Color3.fromRGB(255,255,255); specBtn.BorderSizePixel = 0; specBtn.Parent = card
		Instance.new("UICorner", specBtn).CornerRadius = UDim.new(0, 8)

		specBtn.MouseButton1Click:Connect(function()
			if followTarget == plr then
				stopFollow()
				specBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 180)
				notify("👁️ Spec", "SPEC OFF ✡️", 2)
			else
				-- Reset tous les boutons spec
				for _, c in pairs(playerCards) do
					if c.specBtn and c.specBtn.Parent then
						c.specBtn.BackgroundColor3 = Color3.fromRGB(20, 60, 180)
					end
				end
				startFollow(plr)
				specBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 100)
			end
		end)

		-- Bouton TP séparé (📡)
		local tpBtn = Instance.new("TextButton")
		tpBtn.Size = UDim2.new(0,36,0,36); tpBtn.Position = UDim2.new(1,-46,0.5,-18)
		tpBtn.BackgroundColor3 = Color3.fromRGB(20,60,180); tpBtn.Text = "📡"
		tpBtn.TextSize = 18; tpBtn.Font = Enum.Font.GothamBold
		tpBtn.TextColor3 = Color3.fromRGB(255,255,255); tpBtn.BorderSizePixel = 0; tpBtn.Parent = card
		Instance.new("UICorner", tpBtn).CornerRadius = UDim.new(0, 8)

		tpBtn.MouseButton1Click:Connect(function()
			local myRoot = getHRP()
			local tRoot  = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
			if myRoot and tRoot then
				myRoot.CFrame = tRoot.CFrame + Vector3.new(0, 3, 3)
				notify("📡 TP", "→ "..plr.Name.." ✡️", 2)
			else
				notify("❌", plr.Name.." introuvable !", 2)
			end
		end)

		return { card = card, name = plr.Name, specBtn = specBtn }
	end

	local function buildList(filter)
		filter = (filter or ""):lower()
		for _, entry in ipairs(playerCards) do
			if entry.card and entry.card.Parent then entry.card:Destroy() end
		end
		playerCards = {}
		local count = 0
		for _, plr in pairs(Players:GetPlayers()) do
			if filter == "" or plr.Name:lower():find(filter, 1, true) then
				local entry = makeCard(plr)
				table.insert(playerCards, entry)
				count = count + 1
			end
		end
		countLabel.Text = count.." joueur(s)  •  "..#Players:GetPlayers().." en session"
	end

	buildList("")
	searchBox:GetPropertyChangedSignal("Text"):Connect(function() buildList(searchBox.Text) end)

	-- Drag
	local dragging, dragStart, startPos = false, nil, nil
	main.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true; dragStart = input.Position; startPos = main.Position
		end
	end)
	main.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			local delta = input.Position - dragStart
			main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	Players.PlayerAdded:Connect(function() task.wait(1); buildList(searchBox.Text) end)
	Players.PlayerRemoving:Connect(function() task.wait(0.2); buildList(searchBox.Text) end)
end

-- ══════════════════════════════════════════════════════════════
--  FLY
-- ══════════════════════════════════════════════════════════════
local FLYING        = false
local flySpeed      = 80
local realWalkSpeed = 16
local flyKeyDown    = nil
local flyKeyUp      = nil
local CTRL          = {F=0,B=0,L=0,R=0,U=0,D=0}

local function NOFLY()
	FLYING = false
	if flyKeyDown then flyKeyDown:Disconnect(); flyKeyDown = nil end
	if flyKeyUp   then flyKeyUp:Disconnect();   flyKeyUp   = nil end
	local hum = getHum()
	if hum then hum.PlatformStand = false; hum.WalkSpeed = realWalkSpeed end
	-- Remet CanCollide si on était en noclip-fly
	local char = getChar()
	if char then
		for _, p in pairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = true end
		end
	end
	notify("✈️ Fly", "OFF 🛑", 2)
end

local function sFLY()
	if FLYING then NOFLY() end
	local hrp = getHRP()
	if not hrp then notify("✈️", "Personnage introuvable !", 2) return end
	FLYING = true; CTRL = {F=0,B=0,L=0,R=0,U=0,D=0}

	local BG = Instance.new("BodyGyro")
	BG.P = 9e4; BG.MaxTorque = Vector3.new(9e9,9e9,9e9); BG.CFrame = hrp.CFrame; BG.Parent = hrp

	local BV = Instance.new("BodyVelocity")
	BV.Velocity = Vector3.zero; BV.MaxForce = Vector3.new(9e9,9e9,9e9); BV.Parent = hrp

	task.spawn(function()
		repeat
			task.wait()
			local cam = workspace.CurrentCamera
			local hum = getHum()
			if hum then
				hum.PlatformStand = true
				if hum.Health < hum.MaxHealth then hum.Health = hum.MaxHealth end
			end
			-- Noclip permanent pendant le vol
			local char = getChar()
			if char then
				for _, p in pairs(char:GetDescendants()) do
					if p:IsA("BasePart") then p.CanCollide = false end
				end
			end
			local dir = Vector3.zero
			if CTRL.F ~= 0 then dir +=  cam.CFrame.LookVector  end
			if CTRL.B ~= 0 then dir -=  cam.CFrame.LookVector  end
			if CTRL.L ~= 0 then dir -=  cam.CFrame.RightVector end
			if CTRL.R ~= 0 then dir +=  cam.CFrame.RightVector end
			if CTRL.U ~= 0 then dir +=  Vector3.new(0,1,0)     end
			if CTRL.D ~= 0 then dir -=  Vector3.new(0,1,0)     end
			BV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
			BG.CFrame = cam.CFrame
		until not FLYING
		CTRL = {F=0,B=0,L=0,R=0,U=0,D=0}
		pcall(function() BG:Destroy() end); pcall(function() BV:Destroy() end)
		local hum2 = getHum()
		if hum2 then hum2.PlatformStand = false; hum2.WalkSpeed = realWalkSpeed end
	end)

	flyKeyDown = UIS.InputBegan:Connect(function(i, g)
		if g then return end
		if i.KeyCode == Enum.KeyCode.W then CTRL.F=1 elseif i.KeyCode == Enum.KeyCode.S then CTRL.B=1
		elseif i.KeyCode == Enum.KeyCode.A then CTRL.L=1 elseif i.KeyCode == Enum.KeyCode.D then CTRL.R=1
		elseif i.KeyCode == Enum.KeyCode.E then CTRL.U=1 elseif i.KeyCode == Enum.KeyCode.Q then CTRL.D=1 end
	end)
	flyKeyUp = UIS.InputEnded:Connect(function(i, g)
		if g then return end
		if i.KeyCode == Enum.KeyCode.W then CTRL.F=0 elseif i.KeyCode == Enum.KeyCode.S then CTRL.B=0
		elseif i.KeyCode == Enum.KeyCode.A then CTRL.L=0 elseif i.KeyCode == Enum.KeyCode.D then CTRL.R=0
		elseif i.KeyCode == Enum.KeyCode.E then CTRL.U=0 elseif i.KeyCode == Enum.KeyCode.Q then CTRL.D=0 end
	end)
	notify("✈️ Fly", "ON ✡️ — WASD | E = monter | Q = descendre | Vitesse : "..flySpeed, 3)
end

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.LeftControl then
		if FLYING then NOFLY() else sFLY() end
	end
end)
LP.CharacterAdded:Connect(function() NOFLY() end)

-- ══════════════════════════════════════
--  PUSH / FLING
-- ══════════════════════════════════════
local function safeGetPing()
	local ok, v = pcall(function() return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()/1000 end)
	return ok and v or 0.05
end
local function getTargetRoot(plr) if plr and plr.Character then return plr.Character:FindFirstChild("HumanoidRootPart") end end
local function predTP(plr)
	local root = getTargetRoot(plr); local myRoot = getHRP()
	if not root or not myRoot then return end
	myRoot.CFrame = CFrame.new(root.Position + (root.Velocity or Vector3.zero) * safeGetPing() * 3.5 + Vector3.new(0,2,0))
end
local function findPushTool()
	for _, container in ipairs({ LP.Backpack, getChar() or {} }) do
		for _, v in pairs(container:GetChildren()) do if v:IsA("Tool") and v.Name:lower():find("push") then return v end end
	end
end
local function doServerPush(plr)
	pcall(function()
		local tool = findPushTool(); if not tool or not plr.Character then return end
		tool.Parent = getChar(); pcall(function() tool.PushTool:FireServer(plr.Character) end)
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
		bv.MaxForce = Vector3.new(1e9,1e9,1e9); bv.Velocity = pushDir * 400 + Vector3.new(0,150,0); bv.Parent = targetRoot
		game:GetService("Debris"):AddItem(bv, 0.2)
		task.spawn(function()
			task.wait(0.05)
			pcall(function() targetRoot.Velocity = pushDir * 600 + Vector3.new(math.random(-100,100), 200, math.random(-100,100)) end)
		end)
	end)
end
local function doPush(plr) predTP(plr); task.wait(safeGetPing() + 0.03); doServerPush(plr); doPowerPush(plr) end

-- ══════════════════════════════════════
--  AIMBOT
-- ══════════════════════════════════════
local aimbotEnabled   = false
local aimbotSmoothing = 0.3
local aimbotPart      = "Head"
local aimbotFOV       = 300
local aimbotConn      = nil

local function getClosestTarget()
	local cam = getCam(); local center = Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)
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
		local target = getClosestTarget(); if not target or not target.Character then return end
		local part = target.Character:FindFirstChild(aimbotPart) or target.Character:FindFirstChild("HumanoidRootPart")
		if not part then return end
		local cam = getCam(); local tCF = CFrame.new(cam.CFrame.Position, part.Position)
		cam.CFrame = aimbotSmoothing <= 0.01 and tCF or cam.CFrame:Lerp(tCF, 1 - aimbotSmoothing)
	end)
end
UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.F then aimbotEnabled = not aimbotEnabled; notify("🎯 Aimbot", aimbotEnabled and "ON ✡️" or "OFF 🛑", 2) end
end)
runAimbot()

-- ══════════════════════════════════════
--  ESP TRACKALL + STAFF DETECT
-- ══════════════════════════════════════
local trackHL = {}; local trackBB = {}; local trackDistC = {}; local trackCharC = {}
local trackOn = false; local STAFFDetectOn = false; local playerSnapshots = {}
local espMaxDistance = 1000

local function isSuspectedSTAFF(plr)
	if not plr.Character then return false end
	local hrp = plr.Character:FindFirstChild("HumanoidRootPart"); local hum = plr.Character:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return false end
	local snap = playerSnapshots[plr.Name]
	if not snap then playerSnapshots[plr.Name] = {lastPos=hrp.Position,lastHP=hum.Health,highSpeedFrames=0,godmodFrames=0,totalFrames=0}; return false end
	snap.totalFrames = snap.totalFrames + 1
	local isSTAFF = false
	local dist = (hrp.Position - snap.lastPos).Magnitude
	if dist > 80 then snap.highSpeedFrames = snap.highSpeedFrames + 1 else snap.highSpeedFrames = math.max(0, snap.highSpeedFrames - 1) end
	if snap.highSpeedFrames >= 5 then isSTAFF = true end
	if snap.lastHP < hum.MaxHealth * 0.5 and hum.Health == hum.MaxHealth then snap.godmodFrames = snap.godmodFrames + 1 else snap.godmodFrames = math.max(0, snap.godmodFrames - 0.5) end
	if snap.godmodFrames >= 3 then isSTAFF = true end
	snap.lastPos = hrp.Position; snap.lastHP = hum.Health
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
	local hrp = char:FindFirstChild("HumanoidRootPart"); local hum = char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then task.wait(1); hrp = char:FindFirstChild("HumanoidRootPart"); hum = char:FindFirstChildOfClass("Humanoid") end
	if not hrp or not hum then return end

	local hl = Instance.new("Highlight")
	hl.FillColor = Color3.fromRGB(30,80,220); hl.OutlineColor = Color3.fromRGB(120,180,255)
	hl.FillTransparency = 0.45; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; hl.Parent = char; trackHL[plr.Name] = hl

	local bb = Instance.new("BillboardGui")
	bb.Adornee = hrp; bb.Size = UDim2.new(0,210,0,75); bb.StudsOffset = Vector3.new(0,5,0)
	bb.AlwaysOnTop = true; bb.Parent = hrp; trackBB[plr.Name] = bb

	local bgFrame = Instance.new("Frame")
	bgFrame.Size = UDim2.new(1,0,1,0); bgFrame.BackgroundColor3 = Color3.fromRGB(5,10,30)
	bgFrame.BackgroundTransparency = 0.4; bgFrame.BorderSizePixel = 0; bgFrame.Parent = bb
	Instance.new("UICorner", bgFrame).CornerRadius = UDim.new(0,6)
	local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(30,80,220); stroke.Thickness = 1.5; stroke.Parent = bgFrame

	local lSTAFF = Instance.new("TextLabel")
	lSTAFF.Size = UDim2.new(1,-6,0,18); lSTAFF.Position = UDim2.new(0,3,0,0); lSTAFF.BackgroundTransparency = 1
	lSTAFF.Text = "⚠️ STAFF ⚠️"; lSTAFF.TextColor3 = Color3.fromRGB(255,50,50); lSTAFF.TextStrokeTransparency = 0.1
	lSTAFF.TextScaled = true; lSTAFF.Font = Enum.Font.GothamBold; lSTAFF.Visible = false; lSTAFF.Parent = bgFrame

	local lName = Instance.new("TextLabel")
	lName.Size = UDim2.new(1,-6,0,20); lName.Position = UDim2.new(0,3,0,20); lName.BackgroundTransparency = 1
	lName.Text = "✡️ "..plr.Name; lName.TextColor3 = Color3.fromRGB(130,180,255); lName.TextStrokeTransparency = 0.3
	lName.TextScaled = true; lName.Font = Enum.Font.GothamBold; lName.Parent = bgFrame

	local hpBg = Instance.new("Frame")
	hpBg.Size = UDim2.new(1,-6,0,8); hpBg.Position = UDim2.new(0,3,0,43)
	hpBg.BackgroundColor3 = Color3.fromRGB(10,20,60); hpBg.BackgroundTransparency = 0.2; hpBg.BorderSizePixel = 0; hpBg.Parent = bgFrame
	Instance.new("UICorner",hpBg).CornerRadius = UDim.new(1,0)
	local hpBar = Instance.new("Frame")
	hpBar.Size = UDim2.new(1,0,1,0); hpBar.BackgroundColor3 = Color3.fromRGB(50,120,255); hpBar.BorderSizePixel = 0; hpBar.Parent = hpBg
	Instance.new("UICorner",hpBar).CornerRadius = UDim.new(1,0)

	local lHP = Instance.new("TextLabel")
	lHP.Size = UDim2.new(1,-6,0,14); lHP.Position = UDim2.new(0,3,0,53); lHP.BackgroundTransparency = 1
	lHP.Text = "❤️ "..math.floor(hum.Health).." / "..math.floor(hum.MaxHealth); lHP.TextColor3 = Color3.fromRGB(200,220,255)
	lHP.TextScaled = true; lHP.Font = Enum.Font.Gotham; lHP.Parent = bgFrame

	local lDist = Instance.new("TextLabel")
	lDist.Size = UDim2.new(1,-6,0,12); lDist.Position = UDim2.new(0,3,0,62); lDist.BackgroundTransparency = 1
	lDist.Text = "📍 -- st"; lDist.TextColor3 = Color3.fromRGB(150,190,255); lDist.TextScaled = true; lDist.Font = Enum.Font.Gotham; lDist.Parent = bgFrame

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
			local tooFar = (d > espMaxDistance)
			if bb and bb.Parent then bb.Enabled = not tooFar end
			if hl and hl.Parent then hl.Enabled = not tooFar end
			if d < 20 then lDist.TextColor3 = Color3.fromRGB(255,60,60) elseif d < 50 then lDist.TextColor3 = Color3.fromRGB(100,160,255) else lDist.TextColor3 = Color3.fromRGB(80,120,220) end
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
	trackCharC[plr.Name] = plr.CharacterAdded:Connect(function(char) if trackOn then task.spawn(setupTrackChar, plr, char) end end)
end

task.spawn(function()
	while true do task.wait(2)
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
local detectedVehicle = nil; local vehicleFlyConn = nil; local vehicleSpeed = 100

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
			if obj:FindFirstChildOfClass("VehicleSeat") or obj:FindFirstChildOfClass("Seat") then detectedVehicle = obj; return true end
		end
	end
	local list = scanVehicles(); if #list > 0 then detectedVehicle = list[1]; return true end
	return false
end
local function bindSeatDetect()
	local hum = getHum(); if not hum then return end
	hum:GetPropertyChangedSignal("SeatPart"):Connect(function()
		local seat = hum.SeatPart
		if seat then local model = seat:FindFirstAncestorOfClass("Model"); if model then detectedVehicle = model; notify("🚗","'"..model.Name.."' verrouillé ! ✡️",2) end end
	end)
end
bindSeatDetect()
LP.CharacterAdded:Connect(function() task.wait(1); bindSeatDetect() end)
task.spawn(function()
	while task.wait(0.5) do
		if not detectedVehicle then if detectVehicle() then notify("🚗","'"..detectedVehicle.Name.."' détecté ! ✡️",3) end
		else if not detectedVehicle.Parent then detectedVehicle = nil end end
	end
end)

-- ══════════════════════════════════════
--  TABS UI
-- ══════════════════════════════════════

-- ── TAB 1 : PLAYER ────────────────────────────────────────────
local PlayerTab = Window:CreateTab("🟦 Player", 4483362458)
PlayerTab:CreateSection("Vitesses")
PlayerTab:CreateSlider({ Name = "Walk Speed", Range = {0,999}, Increment = 1, Suffix = " st/s", CurrentValue = 16, Flag = "WalkSpeed",
	Callback = function(v) realWalkSpeed = v; local h = getHum(); if h and not FLYING then h.WalkSpeed = v end end })
PlayerTab:CreateSlider({ Name = "Jump Power", Range = {0,500}, Increment = 5, Suffix = " pow", CurrentValue = 50, Flag = "JumpPower",
	Callback = function(v) local h = getHum(); if h then h.UseJumpPower = true; h.JumpPower = v end end })
PlayerTab:CreateSlider({ Name = "✈️ Fly Speed", Range = {10,500}, Increment = 5, Suffix = " st/s", CurrentValue = 80, Flag = "FlySpeed",
	Callback = function(v) flySpeed = v; notify("✈️ Fly Speed", v.." st/s ✡️", 1, 0.8) end })

PlayerTab:CreateSection("✈️ Fly")
PlayerTab:CreateLabel("💡 CTRL Gauche = Toggle ON/OFF")
PlayerTab:CreateLabel("💡 WASD = direction | E = monter | Q = descendre")
PlayerTab:CreateButton({ Name = "✈️ Activer",    Callback = function() sFLY()  end })
PlayerTab:CreateButton({ Name = "🛑 Désactiver", Callback = function() NOFLY() end })

PlayerTab:CreateSection("Extras")
local ijConn = nil
PlayerTab:CreateToggle({ Name = "🚀 Infinite Jump", CurrentValue = false, Flag = "IJ",
	Callback = function(v)
		if ijConn then ijConn:Disconnect(); ijConn = nil end
		if v then ijConn = UIS.JumpRequest:Connect(function() local h = getHum(); if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end) end
		notify("🚀 Infinite Jump", v and "ON ✡️" or "OFF", 2)
	end })
local ncConn = nil
PlayerTab:CreateToggle({ Name = "👻 Noclip", CurrentValue = false, Flag = "NC",
	Callback = function(v)
		if ncConn then ncConn:Disconnect(); ncConn = nil end
		if v then ncConn = RunService.Stepped:Connect(function() local c = getChar(); if c then for _, p in pairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end end) end
		notify("👻 Noclip", v and "ON ✡️" or "OFF", 2)
	end })
PlayerTab:CreateButton({ Name = "🔄 Reset Stats",
	Callback = function()
		local h = getHum(); if h then h.WalkSpeed = 16; h.JumpPower = 50; h.UseJumpPower = true end
		realWalkSpeed = 16; notify("🔄 Reset","Stats remises à défaut",2)
	end })

-- ── TAB 2 : JOUEURS ───────────────────────────────────────────
local JoueursTab = Window:CreateTab("👥 Joueurs", 4483362458)
JoueursTab:CreateSection("🔍 Panel Joueurs")
JoueursTab:CreateLabel("💡 👁️ = SPEC caméra (pas de TP)   📡 = TP sur le joueur")
JoueursTab:CreateButton({ Name = "👥 Ouvrir / Fermer le Panel", Callback = function() buildPlayerPanel() end })
JoueursTab:CreateButton({ Name = "📷 Stopper le SPEC",
	Callback = function() stopFollow(); notify("📷 Spec","OFF — caméra normale ✡️",2) end })

JoueursTab:CreateSection("🔔 Watch List — Alertes")
JoueursTab:CreateLabel("💡 Notif auto quand un joueur surveillé rejoint / quitte")
JoueursTab:CreateButton({ Name = "📋 Voir la liste",
	Callback = function()
		local list = #WATCH_LIST > 0 and table.concat(WATCH_LIST, "  |  ") or "Aucun"
		notify("👁️ Watch List", list, 5)
	end })
JoueursTab:CreateInput({ Name = "➕ Ajouter à la Watch List", PlaceholderText = "Pseudo exact...", RemoveTextAfterFocusLost = false, Flag = "WatchAdd",
	Callback = function(text)
		if text == "" then return end
		for _, n in ipairs(WATCH_LIST) do if n == text then notify("⚠️","Déjà dans la liste !",2); return end end
		table.insert(WATCH_LIST, text); notify("✅ Ajouté", text.." surveillé ✡️", 3)
	end })
JoueursTab:CreateInput({ Name = "➖ Retirer de la Watch List", PlaceholderText = "Pseudo exact...", RemoveTextAfterFocusLost = false, Flag = "WatchRemove",
	Callback = function(text)
		for i, n in ipairs(WATCH_LIST) do if n == text then table.remove(WATCH_LIST, i); notify("🗑️ Retiré", text.." retiré.", 3); return end end
		notify("❌","Pas dans la liste !",2)
	end })
JoueursTab:CreateButton({ Name = "🔍 Scan — Sont-ils présents ?",
	Callback = function()
		local found = {}
		for _, name in ipairs(WATCH_LIST) do for _, plr in pairs(Players:GetPlayers()) do if plr.Name == name then table.insert(found, name) end end end
		if #found == 0 then notify("🔍 Scan","Aucun joueur surveillé présent.",4) else notify("🚨 PRÉSENTS !", table.concat(found,"  |  "), 8) end
	end })

-- ── TAB 3 : SKIN ──────────────────────────────────────────────
local SkinTab = Window:CreateTab("👤 Skin", 4483362458)
SkinTab:CreateSection("👤 Skin Local")
SkinTab:CreateLabel("💡 Skin de cutieinaria appliqué auto au lancement")
SkinTab:CreateLabel("💡 Local seulement — les autres voient ton vrai skin")
SkinTab:CreateToggle({ Name = "🔄 Auto-réappliquer au respawn", CurrentValue = true, Flag = "SkinAutoReapply",
	Callback = function(v) skinAutoReapply = v; notify("👤 Skin", v and "Réapplication ON ✡️" or "Réapplication OFF", 2) end })
SkinTab:CreateButton({ Name = "👤 Réappliquer maintenant",
	Callback = function()
		if not skinTargetId then notify("❌","UserId pas encore chargé, patiente 2-3s...",3) return end
		local char = LP.Character; if not char then notify("❌","Personnage introuvable !",2) return end
		if applySkinById(skinTargetId, char) then notify("👤 Skin","Réappliqué ✡️",2)
		else notify("❌","Description introuvable !",2) end
	end })
SkinTab:CreateInput({ Name = "🔁 Changer de cible (pseudo)", PlaceholderText = "Pseudo Roblox...", RemoveTextAfterFocusLost = false, Flag = "SkinTarget",
	Callback = function(text)
		if text == "" then return end
		task.spawn(function()
			local newId = nil
			local ok = pcall(function() newId = Players:GetUserIdFromNameAsync(text) end)
			if not ok or not newId then notify("❌", text.." introuvable !",3); return end
			skinTargetId   = newId
			skinTargetName = text
			local char = LP.Character
			if char and applySkinById(skinTargetId, char) then
				notify("👤 Skin", "Skin de "..text.." appliqué ✡️",3)
			end
		end)
	end })
SkinTab:CreateButton({ Name = "🔄 Reset — Mon vrai skin",
	Callback = function()
		local char = LP.Character; if not char then return end
		local hum = char:FindFirstChildOfClass("Humanoid"); if not hum then return end
		local desc = nil
		pcall(function() desc = Players:GetHumanoidDescriptionFromUserId(LP.UserId) end)
		if desc then pcall(function() hum:ApplyDescription(desc) end); notify("🔄 Reset","Ton vrai skin restauré ✡️",2) end
	end })

-- ── TAB 4 : AIMBOT ────────────────────────────────────────────
local AimbotTab = Window:CreateTab("🎯 Aimbot", 4483362458)
AimbotTab:CreateSection("🎯 Aimbot — Gunfight Mode")
AimbotTab:CreateLabel("💡 F = ON/OFF rapide")
AimbotTab:CreateToggle({ Name = "🎯 Aimbot ON/OFF", CurrentValue = false, Flag = "AimbotToggle",
	Callback = function(v) aimbotEnabled = v; notify("🎯 Aimbot", v and "ON ✡️" or "OFF 🛑", 2) end })
AimbotTab:CreateSlider({ Name = "🔭 FOV détection", Range = {50,800}, Increment = 10, Suffix = " px", CurrentValue = 300, Flag = "AimbotFOV",
	Callback = function(v) aimbotFOV = v end })
AimbotTab:CreateSlider({ Name = "🌊 Smoothing", Range = {0,90}, Increment = 5, Suffix = "%", CurrentValue = 30, Flag = "AimbotSmooth",
	Callback = function(v) aimbotSmoothing = v / 100 end })
AimbotTab:CreateSection("🎯 Partie visée")
AimbotTab:CreateDropdown({ Name = "Partie du corps", Options = {"Head","HumanoidRootPart","UpperTorso","LowerTorso"}, CurrentOption = {"Head"}, Flag = "AimbotPart",
	Callback = function(sel) aimbotPart = sel[1] or "Head"; notify("🎯","Vise : "..aimbotPart.." ✡️",2) end })
AimbotTab:CreateLabel("💡 Smoothing 0% = snap | 50%+ = fluide")

-- ── TAB 5 : COMBAT ────────────────────────────────────────────
local CombatTab = Window:CreateTab("⚔️ Combat", 4483362458)
local targetedPlayer = nil; local pushAuraActive = false
local touchFlingActive = false; local voidProtEnabled = false

local function setVoidProtection(bool)
	if bool then workspace.FallenPartsDestroyHeight = 0/0 else workspace.FallenPartsDestroyHeight = -500 end
end

-- FIX TouchFling + Fly : si on fly, on désactive le fling au sol pour éviter le bug de disparition
local touchFlingConn = nil

CombatTab:CreateSection("🎯 Cibler")
CombatTab:CreateInput({ Name = "Nom du joueur", PlaceholderText = "@pseudo...", RemoveTextAfterFocusLost = false, Flag = "TargetInput",
	Callback = function(text)
		for _, plr in pairs(Players:GetPlayers()) do
			if plr ~= LP and plr.Name:lower():find(text:lower()) then targetedPlayer = plr; notify("🎯 Target","Ciblé : "..plr.Name.." ✡️",3); return end
		end
		notify("🎯 Target","Joueur introuvable !",2)
	end })
CombatTab:CreateButton({ Name = "👥 Joueurs en ligne",
	Callback = function()
		local t = {}; for _, p in pairs(Players:GetPlayers()) do if p ~= LP then t[#t+1] = p.Name end end
		notify("👥 Online", #t > 0 and table.concat(t,"  |  ") or "Personne !",7)
	end })
CombatTab:CreateButton({ Name = "❌ Effacer cible", Callback = function() targetedPlayer = nil; notify("🎯","Cible effacée",2) end })

CombatTab:CreateSection("🎮 Actions cible")
CombatTab:CreateButton({ Name = "👊 Push PUISSANT",
	Callback = function()
		if not targetedPlayer then notify("❌","Aucune cible !",2) return end
		doPush(targetedPlayer); notify("👊 Push","→ "..targetedPlayer.Name.." 💥",2)
	end })
CombatTab:CreateButton({ Name = "📡 TP sur la cible",
	Callback = function()
		if not targetedPlayer then notify("❌","Aucune cible !",2) return end
		local r = getTargetRoot(targetedPlayer); local m = getHRP()
		if r and m then m.CFrame = r.CFrame + Vector3.new(0,3,0); notify("📡","→ "..targetedPlayer.Name,2) end
	end })

CombatTab:CreateSection("🌀 Auras")
CombatTab:CreateToggle({ Name = "👊 Push Aura", CurrentValue = false, Flag = "PushAura",
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
									local savedPos = myRoot.CFrame; predTP(plr); task.wait(safeGetPing()+0.03)
									doServerPush(plr); doPowerPush(plr); task.wait(0.05); myRoot.CFrame = savedPos
								end
							end
						end
					end); task.wait(0.35)
				end
			end)
		else notify("👊 Push Aura","OFF",2) end
	end })

-- FIX : TouchFling ne lance plus de vélocité vers le bas si on est en train de fly
-- Il check FLYING avant d'appliquer la vélocité négative
CombatTab:CreateToggle({ Name = "👆 Touch Fling", CurrentValue = false, Flag = "TouchFling",
	Callback = function(v)
		touchFlingActive = v
		if v then
			notify("👆 Touch Fling","ON ✡️")
			setVoidProtection(true)
			task.spawn(function()
				while touchFlingActive do
					if not FLYING then  -- ← FIX : seulement si on est PAS en train de fly
						pcall(function()
							local myRoot = getHRP()
							if myRoot then
								local RV = myRoot.Velocity
								myRoot.Velocity = Vector3.new(math.random(-150,150), -25000, math.random(-150,150))
								RunService.RenderStepped:Wait()
								myRoot.Velocity = RV
							end
						end)
					end
					RunService.Heartbeat:Wait()
				end
				if not voidProtEnabled then setVoidProtection(false) end
			end)
		else
			touchFlingActive = false
			if not voidProtEnabled then setVoidProtection(false) end
			notify("👆 Touch Fling","OFF",2)
		end
	end })

CombatTab:CreateToggle({ Name = "🛡️ Void Protection", CurrentValue = false, Flag = "VoidProt",
	Callback = function(v) voidProtEnabled = v; setVoidProtection(v); notify("🛡️ Void Prot", v and "ON ✡️" or "OFF",2) end })

CombatTab:CreateSection("🔧 Outils")
CombatTab:CreateButton({ Name = "🖱️ Click-Target Tool",
	Callback = function()
		local tool = Instance.new("Tool"); tool.Name = "ClickTarget"; tool.RequiresHandle = false
		local mouse = LP:GetMouse()
		tool.Activated:Connect(function()
			local hit = mouse.Target; if not hit then return end
			local p = Players:GetPlayerFromCharacter(hit.Parent) or Players:GetPlayerFromCharacter(hit.Parent.Parent)
			if p and p ~= LP then targetedPlayer = p; notify("🎯 Target","Ciblé : "..p.Name.." ✡️",3) end
		end)
		tool.Parent = LP.Backpack; notify("🖱️ Click-Target","Dans ton backpack ✡️")
	end })
CombatTab:CreateButton({ Name = "👊 Modded Push Tool",
	Callback = function()
		local tool = Instance.new("Tool"); tool.Name = "ModdedPush"; tool.RequiresHandle = false
		local mouse = LP:GetMouse()
		tool.Activated:Connect(function()
			local hit = mouse.Target; if not hit then return end
			local p = Players:GetPlayerFromCharacter(hit.Parent) or Players:GetPlayerFromCharacter(hit.Parent.Parent)
			if p and p ~= LP then doPush(p) end
		end)
		tool.Parent = LP.Backpack; notify("👊 Modded Push","Dans ton backpack ✡️")
	end })

-- ── TAB 6 : VÉHICULE ──────────────────────────────────────────
local VehTab = Window:CreateTab("🚗 Véhicule", 4483362458)
VehTab:CreateSection("📡 TP Véhicule au clic")
VehTab:CreateLabel("💡 Active → clic gauche = voiture TP là")
local vehTPEnabled = false; local vehTPConn = nil
VehTab:CreateToggle({ Name = "📡 TP Véhicule au clic", CurrentValue = false, Flag = "VehTP",
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
				if not detectedVehicle or not detectedVehicle.Parent then notify("❌","Véhicule disparu !",2); vehTPEnabled = false; return end
				local mouse = LP:GetMouse(); local cam = getCam()
				local origin = cam.CFrame.Position; local target = mouse.Hit.Position; local dir = (target - origin)
				if dir.Magnitude < 0.5 then return end
				local params = RaycastParams.new(); params.FilterType = Enum.RaycastFilterType.Exclude
				local excl = {detectedVehicle}; if getChar() then table.insert(excl, getChar()) end
				params.FilterDescendantsInstances = excl
				local result = workspace:Raycast(origin, dir.Unit * 2000, params); local hitPos = result and result.Position or target
				if detectedVehicle.PrimaryPart then
					detectedVehicle:SetPrimaryPartCFrame(CFrame.new(hitPos + Vector3.new(0,4,0)))
				else
					local root = nil
					for _, p in pairs(detectedVehicle:GetDescendants()) do if p:IsA("BasePart") and not p.Anchored then root = p; break end end
					if root then
						local offset = (hitPos + Vector3.new(0,4,0)) - root.Position
						for _, p in pairs(detectedVehicle:GetDescendants()) do if p:IsA("BasePart") then p.CFrame = p.CFrame + offset end end
					end
				end
				notify("📡","Téléporté ! ✡️",1)
			end)
		else notify("📡 Veh TP","OFF",2) end
	end })

VehTab:CreateSection("🏎️ Vitesse & Fly")
local vehFlyEnabled = false; local vehFlyKeyDown = nil; local vehFlyKeyUp = nil
VehTab:CreateSlider({ Name = "🚀 Veh Fly Speed", Range = {10,500}, Increment = 10, Suffix = " st/s", CurrentValue = 100, Flag = "VehFlySpeed",
	Callback = function(v)
		vehicleSpeed = v
		if detectedVehicle then for _, obj in pairs(detectedVehicle:GetDescendants()) do if obj:IsA("VehicleSeat") then obj.MaxSpeed = v end end end
	end })
VehTab:CreateToggle({ Name = "✈️ Vehicle Fly", CurrentValue = false, Flag = "VehicleFly",
	Callback = function(v)
		if v then
			local hrp = getHRP(); if not hrp then notify("❌","Personnage introuvable !",2) return end
			local VCTRL = {F=0,B=0,L=0,R=0,U=0,D=0}; vehFlyEnabled = true
			local vBV = Instance.new("BodyVelocity"); vBV.MaxForce = Vector3.new(9e9,9e9,9e9); vBV.Velocity = Vector3.zero; vBV.Parent = hrp
			local vBGy = Instance.new("BodyGyro"); vBGy.MaxTorque = Vector3.new(0,9e9,0); vBGy.P = 9e4; vBGy.D = 1000; vBGy.CFrame = CFrame.new(hrp.Position); vBGy.Parent = hrp
			vehicleFlyConn = RunService.Heartbeat:Connect(function()
				if not vehFlyEnabled then return end
				local h = getHRP(); if not h then return end
				local cam = getCam(); local dir = Vector3.zero
				if VCTRL.F ~= 0 then dir += cam.CFrame.LookVector end; if VCTRL.B ~= 0 then dir -= cam.CFrame.LookVector end
				if VCTRL.L ~= 0 then dir -= cam.CFrame.RightVector end; if VCTRL.R ~= 0 then dir += cam.CFrame.RightVector end
				if VCTRL.U ~= 0 then dir += Vector3.new(0,1,0) end; if VCTRL.D ~= 0 then dir -= Vector3.new(0,1,0) end
				if dir.Magnitude > 0 then dir = dir.Unit end; vBV.Velocity = dir * vehicleSpeed; h.Velocity = vBV.Velocity
				local flat = Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
				if flat.Magnitude > 0.01 then vBGy.CFrame = CFrame.new(Vector3.zero, flat) end
			end)
			vehFlyKeyDown = UIS.InputBegan:Connect(function(inp, gpe)
				if gpe then return end
				if inp.KeyCode == Enum.KeyCode.W then VCTRL.F=1 elseif inp.KeyCode == Enum.KeyCode.S then VCTRL.B=1
				elseif inp.KeyCode == Enum.KeyCode.A then VCTRL.L=1 elseif inp.KeyCode == Enum.KeyCode.D then VCTRL.R=1
				elseif inp.KeyCode == Enum.KeyCode.E then VCTRL.U=1 elseif inp.KeyCode == Enum.KeyCode.Q then VCTRL.D=1 end
			end)
			vehFlyKeyUp = UIS.InputEnded:Connect(function(inp, gpe)
				if gpe then return end
				if inp.KeyCode == Enum.KeyCode.W then VCTRL.F=0 elseif inp.KeyCode == Enum.KeyCode.S then VCTRL.B=0
				elseif inp.KeyCode == Enum.KeyCode.A then VCTRL.L=0 elseif inp.KeyCode == Enum.KeyCode.D then VCTRL.R=0
				elseif inp.KeyCode == Enum.KeyCode.E then VCTRL.U=0 elseif inp.KeyCode == Enum.KeyCode.Q then VCTRL.D=0 end
			end)
			notify("✈️ Veh Fly","ON ✡️ — WASD | E = monter | Q = descendre",3)
		else
			vehFlyEnabled = false
			if vehicleFlyConn then vehicleFlyConn:Disconnect(); vehicleFlyConn = nil end
			if vehFlyKeyDown  then vehFlyKeyDown:Disconnect();  vehFlyKeyDown  = nil end
			if vehFlyKeyUp    then vehFlyKeyUp:Disconnect();    vehFlyKeyUp    = nil end
			local hrp = getHRP(); if hrp then for _, c in pairs(hrp:GetChildren()) do if c:IsA("BodyVelocity") or c:IsA("BodyGyro") then c:Destroy() end end end
			notify("✈️ Vehicle Fly","OFF",2)
		end
	end })

-- ── TAB 7 : TÉLÉPORT ──────────────────────────────────────────
local TpTab = Window:CreateTab("📡 Téléport", 4483362458)
TpTab:CreateSection("📡 TP Clic")
local tpClicEnabled = false; local tpClicConn = nil
TpTab:CreateToggle({ Name = "📡 TP Clic ON/OFF", CurrentValue = false, Flag = "TpClic",
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
	end })
TpTab:CreateSection("Destinations")
TpTab:CreateButton({ Name = "🏠 TP au Spawn",
	Callback = function()
		local m = getHRP(); local s = workspace:FindFirstChildOfClass("SpawnLocation")
		if m and s then m.CFrame = s.CFrame + Vector3.new(0,5,0); notify("🏠","✡️",2) else notify("🏠","Introuvable !",2) end
	end })
TpTab:CreateSection("TP → Joueur")
local function makeTPBtn(plr)
	TpTab:CreateButton({ Name = "✡️ TP → "..plr.Name,
		Callback = function()
			local m = getHRP(); local r = getTargetRoot(plr)
			if m and r then m.CFrame = r.CFrame + Vector3.new(0,3,3); notify("📡","→ "..plr.Name,2) else notify("❌",plr.Name.." introuvable !",2) end
		end })
end
for _, p in pairs(Players:GetPlayers()) do if p ~= LP then makeTPBtn(p) end end
TpTab:CreateButton({ Name = "🔄 Refresh",
	Callback = function() for _, p in pairs(Players:GetPlayers()) do if p ~= LP then makeTPBtn(p) end end; notify("🔄","Mis à jour !",2) end })
Players.PlayerAdded:Connect(function(p) task.wait(1); if p ~= LP then makeTPBtn(p) end end)

-- ── TAB 8 : ANIMATIONS ────────────────────────────────────────
local AnimTab = Window:CreateTab("🕺 Animations", 4483362458)
AnimTab:CreateSection("🎭 Animations")
AnimTab:CreateButton({ Name = "💦 BranlaxLeChibrax",
	Callback = function() loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))(); notify("💦","BranlaxLeChibrax ajouté !",2) end })
local ANIMS = {{"🤖 Robot Dance","507766388"},{"🕺 Floss","5915693312"},{"💃 Samba","507776879"},{"👋 Wave","507770239"},
	{"😂 Laugh","507770818"},{"👍 Cheer","507770677"},{"😴 Sleep","507771019"},{"🎸 Air Guitar","182453160"},
	{"🕶️ Too Cool","507769051"},{"🦁 Roar","507761307"}}
local currentAnim = nil
local function playAnim(id)
	local hum = getHum(); if not hum then return end
	if currentAnim then pcall(function() currentAnim:Stop() end); currentAnim = nil end
	local anim = Instance.new("Animation"); anim.AnimationId = "rbxassetid://"..id
	local animator = hum:FindFirstChildOfClass("Animator") or hum:WaitForChild("Animator",3)
	if animator then
		local track = animator:LoadAnimation(anim); track.Priority = Enum.AnimationPriority.Action; track:Play()
		currentAnim = track; notify("🕺","✡️",2)
	end
end
for _, a in ipairs(ANIMS) do local d = a; AnimTab:CreateButton({ Name = d[1], Callback = function() playAnim(d[2]) end }) end
AnimTab:CreateButton({ Name = "⏹️ Stop",
	Callback = function()
		if currentAnim then pcall(function() currentAnim:Stop() end); currentAnim = nil; notify("⏹️","Arrêtée",2) else notify("⏹️","Aucune anim",2) end
	end })
AnimTab:CreateInput({ Name = "ID Custom", PlaceholderText = "507766388", RemoveTextAfterFocusLost = false, Flag = "CustomAnim",
	Callback = function(id) if id and id ~= "" then playAnim(id) end end })

-- ── TAB 9 : TRACKALL ──────────────────────────────────────────
local ESPTab = Window:CreateTab("👁️ TrackAll", 4483362458)
ESPTab:CreateSection("ESP Pro")
ESPTab:CreateLabel("💡 Wallhack • HP bar • Distance • Auto-respawn")
ESPTab:CreateToggle({ Name = "👁️ TrackAll ON/OFF", CurrentValue = false, Flag = "TrackAll",
	Callback = function(v)
		trackOn = v
		if v then for _, p in pairs(Players:GetPlayers()) do addTrack(p) end; notify("👁️ TrackAll","ON ✡️")
		else for _, p in pairs(Players:GetPlayers()) do cleanTrack(p) end; notify("👁️ TrackAll","OFF",2) end
	end })
ESPTab:CreateSlider({ Name = "📏 Distance d'affichage ESP", Range = {10,5000}, Increment = 10, Suffix = " st", CurrentValue = 1000, Flag = "ESPMaxDist",
	Callback = function(v)
		espMaxDistance = v
		notify("📏 ESP Distance", "Affiche jusqu'à "..v.." st ✡️", 1, 0.8)
	end })
ESPTab:CreateButton({ Name = "🔄 Refresh manuel",
	Callback = function()
		if not trackOn then notify("❌","Active TrackAll d'abord !",2) return end
		for _, p in pairs(Players:GetPlayers()) do cleanTrack(p) end; task.wait(0.3)
		for _, p in pairs(Players:GetPlayers()) do addTrack(p) end; notify("🔄","Rafraîchi ✡️",2)
	end })
ESPTab:CreateSection("🚨 STAFF Detect")
ESPTab:CreateLabel("💡 Analyse : Speed/Fly • Godmode")
ESPTab:CreateLabel("💡 STAFF = ESP rouge + label ⚠️ STAFF")
ESPTab:CreateToggle({ Name = "🚨 STAFF Detect ON/OFF", CurrentValue = false, Flag = "STAFFDetect",
	Callback = function(v)
		STAFFDetectOn = v
		if v then
			if not trackOn then trackOn = true; for _, p in pairs(Players:GetPlayers()) do addTrack(p) end; notify("👁️ TrackAll","Activé automatiquement ✡️",2) end
			playerSnapshots = {}; notify("🚨 STAFF Detect","ON ✡️",3)
		else
			notify("🚨 STAFF Detect","OFF",2)
			for _, plr in pairs(Players:GetPlayers()) do
				if plr ~= LP and trackHL[plr.Name] and trackHL[plr.Name].Parent then
					trackHL[plr.Name].FillColor = Color3.fromRGB(30,80,220); trackHL[plr.Name].OutlineColor = Color3.fromRGB(120,180,255)
				end
			end
			playerSnapshots = {}
		end
	end })
ESPTab:CreateButton({ Name = "🔍 Scan manuel — STAFFs",
	Callback = function()
		local found = {}; for _, plr in pairs(Players:GetPlayers()) do if plr ~= LP and isSuspectedSTAFF(plr) then table.insert(found, plr.Name) end end
		if #found == 0 then notify("🔍 Scan","Aucun STAFF détecté ✡️",3) else notify("🚨 STAFFs",table.concat(found,"  |  "),7) end
	end })
Players.PlayerAdded:Connect(function(p) task.wait(1); if trackOn then addTrack(p) end end)
Players.PlayerRemoving:Connect(function(p) cleanTrack(p); playerSnapshots[p.Name] = nil end)

-- ── TAB 10 : VISUAL ───────────────────────────────────────────
local VisualTab = Window:CreateTab("✨ Visual", 4483362458)
VisualTab:CreateSection("Lighting")
VisualTab:CreateToggle({ Name = "🌫️ Remove Fog", CurrentValue = false, Flag = "NoFog",
	Callback = function(v) Lighting.FogEnd = v and 1e6 or 1000; Lighting.FogStart = v and 1e6 or 0 end })
VisualTab:CreateToggle({ Name = "☀️ Fullbright", CurrentValue = false, Flag = "Fullbright",
	Callback = function(v)
		Lighting.Brightness = v and 10 or 1; Lighting.ClockTime = v and 14 or 12
		Lighting.Ambient = v and Color3.fromRGB(255,255,255) or Color3.fromRGB(70,70,70)
	end })
VisualTab:CreateSlider({ Name = "🔭 FOV", Range = {60,120}, Increment = 1, Suffix = "°", CurrentValue = 70, Flag = "FOV",
	Callback = function(v) getCam().FieldOfView = v end })

-- ── TAB 11 : SCRIPTS ──────────────────────────────────────────
local ScriptsTab = Window:CreateTab("📜 Scripts", 4483362458)
ScriptsTab:CreateSection("🧪 Scripts externes")
ScriptsTab:CreateButton({ Name = "▶️ SystemBroken",
	Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/GZSSF/script3/95a45577475502cfbf546ae9ca8fc4f00b61eb83/script3"))(); notify("📜","SystemBroken exécuté !",2) end })
ScriptsTab:CreateButton({ Name = "▶️ Infinite Yield",
	Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))(); notify("📜","Infinite Yield exécuté !",2) end })
ScriptsTab:CreateButton({ Name = "▶️ BypassAntiCheat (manuel)",
	Callback = function()
		pcall(function()
			local old
			old = hookmetamethod(game, "__namecall", function(self, ...)
				local method = getnamecallmethod(); local args = {...}
				if method == "InvokeServer" then
					for _, v in ipairs(args) do if typeof(v) == "string" and string.find(v:lower(), "added blacklisted") then warn("Blocked call:", v); return nil end end
					return old(self, unpack(args))
				end
				return old(self, ...)
			end)
		end)
		notify("📜","Bypass anticheat re-exécuté !",2)
	end })

-- ── TAB 12 : MISC ─────────────────────────────────────────────
local MiscTab = Window:CreateTab("⚙️ Misc", 4483362458)
MiscTab:CreateSection("🎵 Musique")
MiscTab:CreateToggle({ Name = "🎵 Musique ON/OFF", CurrentValue = true, Flag = "MusicToggle",
	Callback = function(v)
		if v then bgMusic:Play(); notify("🎵 Musique","ON ✡️ 🎶",2) else bgMusic:Stop(); notify("🎵 Musique","OFF 🛑",2) end
	end })
MiscTab:CreateSlider({ Name = "🔊 Volume", Range = {0,100}, Increment = 5, Suffix = "%", CurrentValue = 50, Flag = "MusicVolume",
	Callback = function(v) bgMusic.Volume = v / 100; notify("🔊 Volume", v.."% ✡️", 1, 0.6) end })

MiscTab:CreateSection("Utilitaire")
local afkConn = nil
MiscTab:CreateToggle({ Name = "💤 Anti-AFK", CurrentValue = true, Flag = "AntiAFK",
	Callback = function(v)
		if afkConn then afkConn:Disconnect(); afkConn = nil end
		if v then
			local VU = game:GetService("VirtualUser")
			afkConn = LP.Idled:Connect(function() VU:Button2Down(Vector2.zero, getCam().CFrame); task.wait(1); VU:Button2Up(Vector2.zero, getCam().CFrame) end)
		end
		notify("💤 Anti-AFK", v and "ON ✡️" or "OFF",2)
	end })
MiscTab:CreateButton({ Name = "🔄 Rejoin",
	Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end })

-- ── TAB 13 : CRÉDITS ──────────────────────────────────────────
local CreditsTab = Window:CreateTab("✡️ Crédits", 4483362458)
CreditsTab:CreateSection("Dev")
CreditsTab:CreateLabel("👑 FocusOnTop"); CreditsTab:CreateLabel("💬 DISCORD SOON")
CreditsTab:CreateSection("Build")
CreditsTab:CreateLabel("✡️ Tel-Aviv — Script")
CreditsTab:CreateLabel("🟦 Fly • Aimbot • ESP • STAFF • Véhicule • Joueurs • Skin")

-- ══════════════════════════════════════
--  INIT
-- ══════════════════════════════════════
do
	local VU = game:GetService("VirtualUser")
	afkConn = LP.Idled:Connect(function() VU:Button2Down(Vector2.zero, getCam().CFrame); task.wait(1); VU:Button2Up(Vector2.zero, getCam().CFrame) end)
end

notify("✡️ Tel-Aviv","CLIENT chargé ! — By FocusOnTop",5)
