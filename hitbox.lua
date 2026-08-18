-- Modern Category Container GUI + Hitbox & Touch Fling
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Eski GUI kalıntısını temizle
if CoreGui:FindFirstChild("ModernClientGui") then
    CoreGui.ModernClientGui:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernClientGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Ana Arka Plan / Taşıyıcı Çerçeve
local MainContainer = Instance.new("Frame")
MainContainer.Name = "MainContainer"
MainContainer.Size = UDim2.new(0, 580, 0, 360)
MainContainer.Position = UDim2.new(0.5, -290, 0.5, -180)
MainContainer.BackgroundColor3 = Color3.fromRGB(12, 12, 15)
MainContainer.BackgroundTransparency = 0.1
MainContainer.BorderSizePixel = 0
MainContainer.Active = true
MainContainer.Draggable = true
MainContainer.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainContainer

-- Kategori Sekmesi Oluşturucu
local function createCategory(name, positionX, width)
    local CategoryFrame = Instance.new("ScrollingFrame")
    CategoryFrame.Name = name .. "Category"
    CategoryFrame.Size = UDim2.new(0, width or 170, 1, -20)
    CategoryFrame.Position = UDim2.new(0, positionX, 0, 10)
    CategoryFrame.BackgroundTransparency = 1
    CategoryFrame.BorderSizePixel = 0
    CategoryFrame.CanvasSize = UDim2.new(0, 0, 1.5, 0)
    CategoryFrame.ScrollBarThickness = 2
    CategoryFrame.Parent = MainContainer

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 30)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = name
    TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 215)
    TitleLabel.TextSize = 13
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Parent = CategoryFrame

    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout.Padding = UDim.new(0, 6)
    UIListLayout.Parent = CategoryFrame

    local UIPadding = Instance.new("UIPadding")
    UIPadding.PaddingTop = UDim.new(0, 35)
    UIPadding.PaddingLeft = UDim.new(0, 5)
    UIPadding.PaddingRight = UDim.new(0, 5)
    UIPadding.Parent = CategoryFrame

    return CategoryFrame
end

-- Sekmeler
local combatCol = createCategory("Combat / Hitbox", 15, 180)
local utilityCol = createCategory("Utility / Fling", 205, 180)
local settingsCol = createCategory("Settings", 395, 170)

-- Hitbox Toggle Butonu
local HitboxToggle = Instance.new("TextButton")
HitboxToggle.Size = UDim2.new(1, 0, 0, 35)
HitboxToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
HitboxToggle.Text = "  HitBoxes: OFF"
HitboxToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
HitboxToggle.TextSize = 12
HitboxToggle.Font = Enum.Font.GothamMedium
HitboxToggle.TextXAlignment = Enum.TextXAlignment.Left
HitboxToggle.AutoButtonColor = false
HitboxToggle.Parent = combatCol

local HBCorner = Instance.new("UICorner")
HBCorner.CornerRadius = UDim.new(0, 6)
HBCorner.Parent = HitboxToggle

-- Hitbox Slider Alanı
local SliderContainer = Instance.new("Frame")
SliderContainer.Size = UDim2.new(1, 0, 0, 50)
SliderContainer.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
SliderContainer.BorderSizePixel = 0
SliderContainer.Parent = combatCol

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = SliderContainer

local ValueLabel = Instance.new("TextLabel")
ValueLabel.Size = UDim2.new(1, -10, 0, 20)
ValueLabel.Position = UDim2.new(0, 5, 0, 5)
ValueLabel.BackgroundTransparency = 1
ValueLabel.Text = "Hitbox Size: 2"
ValueLabel.TextColor3 = Color3.fromRGB(170, 170, 185)
ValueLabel.TextSize = 11
ValueLabel.Font = Enum.Font.Gotham
ValueLabel.TextXAlignment = Enum.TextXAlignment.Left
ValueLabel.Parent = SliderContainer

local SliderBar = Instance.new("TextButton")
SliderBar.Size = UDim2.new(1, -16, 0, 6)
SliderBar.Position = UDim2.new(0, 8, 0, 32)
SliderBar.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
SliderBar.Text = ""
SliderBar.AutoButtonColor = false
SliderBar.Parent = SliderContainer

local SliderBarCorner = Instance.new("UICorner")
SliderBarCorner.CornerRadius = UDim.new(0, 3)
SliderBarCorner.Parent = SliderBar

local SliderFill = Instance.new("Frame")
SliderFill.Size = UDim2.new(0.01, 0, 1, 0)
SliderFill.BackgroundColor3 = Color3.fromRGB(110, 80, 255)
SliderFill.BorderSizePixel = 0
SliderFill.Parent = SliderBar

local SliderFillCorner = Instance.new("UICorner")
SliderFillCorner.CornerRadius = UDim.new(0, 3)
SliderFillCorner.Parent = SliderFill

-- Touch Fling Toggle Butonu
local FlingToggle = Instance.new("TextButton")
FlingToggle.Size = UDim2.new(1, 0, 0, 35)
FlingToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
FlingToggle.Text = "  Touch Fling: OFF"
FlingToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
FlingToggle.TextSize = 12
FlingToggle.Font = Enum.Font.GothamMedium
FlingToggle.TextXAlignment = Enum.TextXAlignment.Left
FlingToggle.AutoButtonColor = false
FlingToggle.Parent = utilityCol

local FlingCorner = Instance.new("UICorner")
FlingCorner.CornerRadius = UDim.new(0, 6)
FlingCorner.Parent = FlingToggle

-- Unload Butonu
local UnloadButton = Instance.new("TextButton")
UnloadButton.Size = UDim2.new(1, 0, 0, 35)
UnloadButton.BackgroundColor3 = Color3.fromRGB(45, 20, 25)
UnloadButton.Text = "  Unload Script"
UnloadButton.TextColor3 = Color3.fromRGB(255, 100, 100)
UnloadButton.TextSize = 12
UnloadButton.Font = Enum.Font.GothamMedium
UnloadButton.TextXAlignment = Enum.TextXAlignment.Left
UnloadButton.AutoButtonColor = false
UnloadButton.Parent = settingsCol

local UnloadCorner = Instance.new("UICorner")
UnloadCorner.CornerRadius = UDim.new(0, 6)
UnloadCorner.Parent = UnloadButton

-- Bilgi Notu
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, 0, 0, 30)
InfoLabel.BackgroundTransparency = 1
InfoLabel.Text = "[RightShift] Menu Toggle"
InfoLabel.TextColor3 = Color3.fromRGB(90, 90, 105)
InfoLabel.TextSize = 10
InfoLabel.Font = Enum.Font.Gotham
InfoLabel.TextXAlignment = Enum.TextXAlignment.Left
InfoLabel.Parent = settingsCol

-- --- SCRIPT MANTIKLARI ---

local hbEnabled = false
local hitboxSize = 2
local originalSizes = {}

local flingEnabled = false
local flingThread = nil

if not ReplicatedStorage:FindFirstChild("juisdfj0i32i0eidsuf0iok") then
    local detection = Instance.new("Decal")
    detection.Name = "juisdfj0i32i0eidsuf0iok"
    detection.Parent = ReplicatedStorage
end

-- Hitbox Döngüsü
local hbConnection = RunService.RenderStepped:Connect(function()
    if hbEnabled then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if hrp and humanoid and humanoid.Health > 0 then
                    if not originalSizes[player] then
                        originalSizes[player] = hrp.Size
                    end
                    hrp.Size = Vector3.new(hitboxSize, hitboxSize, hitboxSize)
                    hrp.Transparency = 0.65
                    hrp.CanCollide = false
                    hrp.CustomPhysicalProperties = PhysicalProperties.new(0.7, 0.3, 0.5, 1, 1)
                end
            end
        end
    end
end)

-- Hitbox Toggle İşlevi
HitboxToggle.MouseButton1Click:Connect(function()
    hbEnabled = not hbEnabled
    if hbEnabled then
        HitboxToggle.Text = "  HitBoxes: ON"
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
        HitboxToggle.TextColor3 = Color3.fromRGB(15, 15, 20)
    else
        HitboxToggle.Text = "  HitBoxes: OFF"
        HitboxToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        HitboxToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
        
        for player, size in pairs(originalSizes) do
            if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.Size = size
                player.Character.HumanoidRootPart.Transparency = 1
                player.Character.HumanoidRootPart.CustomPhysicalProperties = nil
            end
        end
        originalSizes = {}
    end
end)

-- Slider Kontrolü (1 - 100)
local dragging = false
SliderBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mousePos = UserInputService:GetMouseLocation()
        local relativeX = math.clamp((mousePos.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(relativeX, 0, 1, 0)
        
        hitboxSize = math.floor(1 + (relativeX * 99))
        ValueLabel.Text = "Hitbox Size: " .. hitboxSize
    end
end)

-- Touch Fling Mantığı
local function flingLoop()
    local lp = Players.LocalPlayer
    local c, hrp, vel, movel = nil, nil, nil, 0.1

    while flingEnabled do
        RunService.Heartbeat:Wait()
        c = lp.Character
        hrp = c and c:FindFirstChild("HumanoidRootPart")

        if hrp then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= lp and player.Character then
                    local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if targetHrp then
                        local distance = (hrp.Position - targetHrp.Position).Magnitude
                        if distance <= (hitboxSize / 1.5) then
                            vel = hrp.Velocity
                            hrp.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)
                            RunService.RenderStepped:Wait()
                            hrp.Velocity = vel
                            RunService.Stepped:Wait()
                            hrp.Velocity = vel + Vector3.new(0, movel, 0)
                            movel = -movel
                            break
                        end
                    end
                end
            end
        end
    end
end

-- Fling Toggle İşlevi
FlingToggle.MouseButton1Click:Connect(function()
    flingEnabled = not flingEnabled
    if flingEnabled then
        FlingToggle.Text = "  Touch Fling: ON"
        FlingToggle.BackgroundColor3 = Color3.fromRGB(240, 240, 245)
        FlingToggle.TextColor3 = Color3.fromRGB(15, 15, 20)
        
        flingThread = coroutine.create(flingLoop)
        coroutine.resume(flingThread)
    else
        FlingToggle.Text = "  Touch Fling: OFF"
        FlingToggle.BackgroundColor3 = Color3.fromRGB(22, 22, 28)
        FlingToggle.TextColor3 = Color3.fromRGB(150, 150, 165)
    end
end)

-- Sağ Shift ile Arayüz Gizleme/Gösterme
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.RightShift then
        MainContainer.Visible = not MainContainer.Visible
    end
end)

-- Unload Butonu İşlevi
UnloadButton.MouseButton1Click:Connect(function()
    hbEnabled = false
    flingEnabled = false
    if hbConnection then hbConnection:Disconnect() end
    
    for player, size in pairs(originalSizes) do
        if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            player.Character.HumanoidRootPart.Size = size
            player.Character.HumanoidRootPart.Transparency = 1
            player.Character.HumanoidRootPart.CustomPhysicalProperties = nil
        end
    end
    
    ScreenGui:Destroy()
end)
