-- Intro com letras animadas, espaçadas, sem stroke e com gradiente fake
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Camera = workspace.CurrentCamera

-- Blur Effect
local blur = Instance.new("BlurEffect")
blur.Size = 24
blur.Parent = Lighting

-- Som do Kaneki Ken
local sound = Instance.new("Sound")
sound.SoundId = "rbxassetid://123427955645512"
sound.Volume = 3
sound.PlayOnRemove = true
sound.Parent = SoundService
sound:Destroy()

-- Tela da intro
local introGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
introGui.IgnoreGuiInset = true
introGui.ResetOnSpawn = false
introGui.Name = "IntroGui"

local container = Instance.new("Frame", introGui)
container.Size = UDim2.new(1, 0, 1, 0)
container.BackgroundTransparency = 1

-- Texto
local text = "Emperor Hub"
local spacing = 55 -- MUITO espaço entre letras
local startX = (Camera.ViewportSize.X / 2) - (#text * spacing / 2)

-- Gradiente falso com tons de vermelho/escuro
local gradientColors = {
	Color3.fromRGB(200, 0, 0),
	Color3.fromRGB(180, 0, 0),
	Color3.fromRGB(160, 0, 0),
	Color3.fromRGB(140, 0, 0),
	Color3.fromRGB(120, 0, 0),
	Color3.fromRGB(100, 0, 0),
	Color3.fromRGB(120, 0, 0),
	Color3.fromRGB(140, 0, 0),
	Color3.fromRGB(160, 0, 0),
	Color3.fromRGB(180, 0, 0),
	Color3.fromRGB(200, 0, 0),
}

for i = 1, #text do
	local char = text:sub(i, i)
	local label = Instance.new("TextLabel")
	label.Parent = container
	label.Size = UDim2.new(0, 50, 0, 100)
	label.Position = UDim2.new(0, startX + (i - 1) * spacing, 0.6, -20) -- mais pra baixo
	label.AnchorPoint = Vector2.new(0, 0.5)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.LuckiestGuy
	label.TextSize = 72
	label.TextColor3 = gradientColors[i] or Color3.fromRGB(200, 0, 0)
	label.Text = char
	label.TextTransparency = 1

	-- Animação Tween (mais lenta)
	delay(i * 0.08, function()
		TweenService:Create(label, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
			TextTransparency = 0
		}):Play()
	end)
end

wait(4)

-- Fade out
for _, label in pairs(container:GetChildren()) do
	if label:IsA("TextLabel") then
		TweenService:Create(label, TweenInfo.new(0.6), {
			TextTransparency = 1
		}):Play()
	end
end

wait(0.7)
introGui:Destroy()
blur:Destroy()

----- Emperor Hub aqui --------

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove UI antiga
local oldGui = PlayerGui:FindFirstChild("soyguhMOD")
if oldGui then oldGui:Destroy() end

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "soyguhMOD"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- Função de arrastar
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
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
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local screenSize = workspace.CurrentCamera.ViewportSize
            local newX = startPos.X.Scale + delta.X / screenSize.X
            local newY = startPos.Y.Scale + delta.Y / screenSize.Y

            local frameSize = frame.Size
            local maxX = 1 - frameSize.X.Scale
            local maxY = 1 - frameSize.Y.Scale

            newX = math.clamp(newX, 0, maxX)
            newY = math.clamp(newY, 0, maxY)

            frame.Position = UDim2.new(newX, 0, newY, 0)
        end
    end)
end

-- UI Principal
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.new(0,0,0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)

local wallpaper = Instance.new("ImageLabel")
wallpaper.Parent = mainFrame
wallpaper.Size = UDim2.new(1, -10, 1, -10)
wallpaper.Position = UDim2.new(0, 5, 0, 5)
wallpaper.BackgroundTransparency = 1
wallpaper.Image = "rbxassetid://110536188881147"
wallpaper.ImageTransparency = 0.5
wallpaper.ScaleType = Enum.ScaleType.Fit
Instance.new("UICorner", wallpaper).CornerRadius = UDim.new(0, 15)

local innerFrame = Instance.new("Frame")
innerFrame.Parent = mainFrame
innerFrame.Size = UDim2.new(1, -10, 1, -10)
innerFrame.Position = UDim2.new(0, 5, 0, 5)
innerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
innerFrame.BackgroundTransparency = 0.7
innerFrame.BorderSizePixel = 0
Instance.new("UICorner", innerFrame).CornerRadius = UDim.new(0, 15)

-- Logo pequena no canto
local logo = Instance.new("ImageLabel")
logo.Parent = innerFrame
logo.Size = UDim2.new(0, 30, 0, 30)
logo.Position = UDim2.new(0, 10, 0, 5)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://110536188881147"
logo.ScaleType = Enum.ScaleType.Fit

-- Título
local title = Instance.new("TextLabel")
title.Parent = innerFrame
title.Size = UDim2.new(1, -50, 0, 30)
title.Position = UDim2.new(0, 45, 0, 5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Text = "Emperor Hub"
title.TextXAlignment = Enum.TextXAlignment.Left

-- Tabs
local tabButtons = Instance.new("Frame")
tabButtons.Parent = innerFrame
tabButtons.Size = UDim2.new(1, -20, 0, 35)
tabButtons.Position = UDim2.new(0, 10, 0, 45)
tabButtons.BackgroundTransparency = 1

local stylesTabButton = Instance.new("TextButton")
stylesTabButton.Parent = tabButtons
stylesTabButton.Size = UDim2.new(0.5, -5, 1, 0)
stylesTabButton.Position = UDim2.new(0, 0, 0, 0)
stylesTabButton.Text = "Estilos"
stylesTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
stylesTabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
stylesTabButton.Font = Enum.Font.GothamBold
stylesTabButton.TextSize = 18
Instance.new("UICorner", stylesTabButton).CornerRadius = UDim.new(0, 15)

local vulnTabButton = stylesTabButton:Clone()
vulnTabButton.Parent = tabButtons
vulnTabButton.Position = UDim2.new(0.5, 5, 0, 0)
vulnTabButton.Text = "Jogador"

-- Styles Tab
local stylesTab = Instance.new("Frame")
stylesTab.Parent = innerFrame
stylesTab.Size = UDim2.new(1, -20, 1, -90)
stylesTab.Position = UDim2.new(0, 10, 0, 85)
stylesTab.BackgroundTransparency = 1

-- Função criar botão externo
local function createExternalStyleButton(parent, name, key, scriptUrl, bgColor, textColor, posY, rgb)
    local btn = Instance.new("TextButton")
    btn.Parent = parent
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = bgColor
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 15)

    if rgb then
        local hue = 0
        RunService.Heartbeat:Connect(function(dt)
            hue = (hue + dt * 60) % 360
            local color = Color3.fromHSV(hue / 360, 1, 1)
            btn.BackgroundColor3 = color
        end)
    end

    btn.MouseButton1Click:Connect(function()
        setclipboard(key)
        loadstring(game:HttpGet(scriptUrl))()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Emperor Hub",
            Text = "Key copiada para área de transferência!",
            Duration = 3
        })
    end)
end

createExternalStyleButton(stylesTab, "Noel Noa", "BESTNOELUPD",
    "https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/NoelNoaV1",
    Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255), 0, true)

createExternalStyleButton(stylesTab, "NEL Rin V2", "Nelrinv2upd",
    "https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/NelRinV2",
    Color3.fromRGB(255,255,255), Color3.fromRGB(0,100,0), 50, false)

createExternalStyleButton(stylesTab, "REO's Custom", "BESTCHANGER",
    "https://raw.githubusercontent.com/stylemakeritosh/Menu/refs/heads/main/Stylechanger",
    Color3.fromRGB(100,100,255), Color3.fromRGB(255,255,255), 100, false)

-- VULN Tab
local vulnTab = Instance.new("Frame")
vulnTab.Parent = innerFrame
vulnTab.Size = stylesTab.Size
vulnTab.Position = stylesTab.Position
vulnTab.BackgroundTransparency = 1
vulnTab.Visible = false

-- Inf Stamina
local infStamina = false
local infStaminaConnection = nil

local infStaminaBtn = Instance.new("TextButton")
infStaminaBtn.Parent = vulnTab
infStaminaBtn.Size = UDim2.new(1, 0, 0, 40)
infStaminaBtn.Position = UDim2.new(0, 0, 0, 0)
infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
infStaminaBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
infStaminaBtn.Font = Enum.Font.GothamBold
infStaminaBtn.TextSize = 20
infStaminaBtn.Text = "Inf Stamina [OFF]"
Instance.new("UICorner", infStaminaBtn).CornerRadius = UDim.new(0, 15)

infStaminaBtn.MouseButton1Click:Connect(function()
    infStamina = not infStamina
    if infStamina then
        infStaminaBtn.Text = "Inf Stamina [ON]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        infStaminaConnection = RunService.Heartbeat:Connect(function()
            pcall(function()
                local stamina = LocalPlayer.PlayerStats:FindFirstChild("Stamina")
                if stamina and stamina:IsA("NumberValue") then
                    stamina.Value = 100
                end
            end)
        end)
    else
        infStaminaBtn.Text = "Inf Stamina [OFF]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if infStaminaConnection then
            infStaminaConnection:Disconnect()
            infStaminaConnection = nil
        end
    end
end)

-- No Cooldown
local noCooldownBtn = Instance.new("TextButton")
noCooldownBtn.Parent = vulnTab
noCooldownBtn.Size = UDim2.new(1, 0, 0, 40)
noCooldownBtn.Position = UDim2.new(0, 0, 0, 50)
noCooldownBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
noCooldownBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
noCooldownBtn.Font = Enum.Font.GothamBold
noCooldownBtn.TextSize = 20
noCooldownBtn.Text = "No Cooldown"
Instance.new("UICorner", noCooldownBtn).CornerRadius = UDim.new(0, 15)

noCooldownBtn.MouseButton1Click:Connect(function()
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            for key,value in pairs(v) do
                if tostring(key):lower():find("cooldown") then
                    if typeof(value) == "number" and value > 0 then
                        v[key] = 0
                    end
                    if typeof(value) == "function" then
                        v[key] = function(...) return 0 end
                    end
                end
            end
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Emperor Hub",
        Text = "Cooldown de Skills Desativado 😈!",
        Duration = 3
    })
end)

-- Sistema de abas
stylesTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = true
    vulnTab.Visible = false
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

vulnTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = false
    vulnTab.Visible = true
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

-- Toggle UI
local toggleFrame = Instance.new("Frame")
toggleFrame.Name = "ToggleFrame"
toggleFrame.Size = UDim2.new(0, 60, 0, 28)
toggleFrame.Position = UDim2.new(0, 20, 0, 20)
toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
toggleFrame.BorderSizePixel = 0
toggleFrame.Parent = screenGui
toggleFrame.Active = true
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 14)

local switchBtn = Instance.new("Frame")
switchBtn.Parent = toggleFrame
switchBtn.Size = UDim2.new(1, 0, 1, 0)
switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Instance.new("UICorner", switchBtn).CornerRadius = UDim.new(0, 14)

local toggleCircle = Instance.new("Frame")
toggleCircle.Parent = switchBtn
toggleCircle.Size = UDim2.new(0, 26, 0, 26)
toggleCircle.Position = UDim2.new(0, 2, 0, 1)
toggleCircle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(0, 13)

local uiVisible = true
local function updateToggle()
    if uiVisible then
        switchBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleCircle:TweenPosition(UDim2.new(1, -28, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame.Visible = true
    else
        switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleCircle:TweenPosition(UDim2.new(0, 2, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        mainFrame.Visible = false
    end
end

switchBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        uiVisible = not uiVisible
        updateToggle()
    end
end)

-- Ativa Drag
makeDraggable(mainFrame)
makeDraggable(toggleFrame)

updateToggle()
