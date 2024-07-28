-- Load the UI library
local LibraryURL = "https://raw.githubusercontent.com/Midzefx/Midzefx/main/Daybreak.lua"
local success, Library = pcall(function() return loadstring(game:HttpGet(LibraryURL))() end)

if not success then
    warn("Failed to load library: ", Library)
    return
end

-- Create a window
local Window = Library:AddWindow("Daybreak", {
    main_color = Color3.fromRGB(41, 74, 122),
    min_size = Vector2.new(230, 190),
    can_resize = false,
})

local MainPage = Window:AddTab("Main")

-- Function to print debug information
local function debugPrint(message)
    print("[DEBUG]: " .. message)
end

-- Auto Skill Checks
MainPage:AddSwitch("Auto Skill Checks", function(Skill)
    debugPrint("Auto Skill Checks toggled: " .. tostring(Skill))
    local Skills = Skill
    while Skills do
        wait()
        pcall(function()
            -- Auto Perfect Skill Check
            local VirtualInputManager = game:GetService('VirtualInputManager')
            local playerGui = game.Players.LocalPlayer.PlayerGui
            if playerGui:FindFirstChild("HUD") and playerGui.HUD:FindFirstChild("Skillcheck").Visible == true and 
               playerGui.HUD.Skillcheck.Inner.Indicator.AbsolutePosition.Magnitude > 
               playerGui.HUD.Skillcheck.Inner.Safe.AbsolutePosition.Magnitude then
                VirtualInputManager:SendKeyEvent(true, "Space", false, game)
                VirtualInputManager:SendKeyEvent(false, "Space", false, game)
            end
        end)
    end
end)

-- ESP Generators
MainPage:AddSwitch("ESP Generators", function(Gen)
    debugPrint("ESP Generators toggled: " .. tostring(Gen))
    local Gens = Gen
    while Gens do
        wait()
        pcall(function()
            for _, v in pairs(game.Workspace:FindFirstChild("Map_Holder"):FindFirstChild("Game_Map"):FindFirstChild("Gens"):GetChildren()) do
                if v:FindFirstChild("GenAura") and not v.GenAura.Enabled then
                    v.GenAura.Enabled = true
                end
            end
        end)
    end
end)

-- ESP Players & Killer
MainPage:AddSwitch("ESP Plrs & Killer", function(See)
    debugPrint("ESP Plrs & Killer toggled: " .. tostring(See))
    local SeeYou = See
    while SeeYou do
        wait(3)
        pcall(function()
            -- Killer ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name ~= game.Players.LocalPlayer.Name and player.Character:FindFirstChild("Weapon") then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if (part:IsA("Part") or part:IsA("MeshPart")) and not part:FindFirstChild("BoxHandleAdornment") then
                            local ESP = Instance.new("BoxHandleAdornment")
                            ESP.Parent = part
                            ESP.Adornee = part
                            ESP.AlwaysOnTop = true
                            ESP.Transparency = 0.7
                            ESP.ZIndex = 0
                            ESP.Size = part.Size
                            ESP.Color3 = Color3.fromRGB(255, 0, 4)
                        end
                    end
                    if player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:FindFirstChild("BoxHandleAdornment") then
                        player.Character.HumanoidRootPart:FindFirstChild("BoxHandleAdornment"):Destroy()
                    end
                end
            end

            -- Survivor ESP
            for _, player in pairs(game.Players:GetPlayers()) do
                if player.Name ~= game.Players.LocalPlayer.Name and player.Character:FindFirstChild("Weapon") == nil and player.Character:FindFirstChild("survivorState") then
                    for _, part in pairs(player.Character:GetDescendants()) do
                        if (part:IsA("Part") or part:IsA("MeshPart")) and not part:FindFirstChild("BoxHandleAdornment") then
                            local ESP = Instance.new("BoxHandleAdornment")
                            ESP.Parent = part
                            ESP.Adornee = part
                            ESP.AlwaysOnTop = true
                            ESP.Transparency = 0.7
                            ESP.ZIndex = 0
                            ESP.Size = part.Size
                            ESP.Color3 = Color3.fromRGB(161, 196, 140)
                        end
                    end
                    if player.Character:FindFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:FindFirstChild("BoxHandleAdornment") then
                        player.Character.HumanoidRootPart:FindFirstChild("BoxHandleAdornment"):Destroy()
                    end
                end
            end
        end)
    end
end)

local CreditsPage = Window:AddTab("CREDITS")

CreditsPage:AddLabel("UI Library Creator: 0xSingularity")
CreditsPage:AddLabel("Script Creators Discord: .terebi")

MainPage:Show()

-- Survivor Speed (LEGIT)
MainPage:AddSwitch("Survivor Speed (LEGIT)", function(Boost)
    debugPrint("Survivor Speed (LEGIT) toggled: " .. tostring(Boost))
    local Boosting = Boost
    while Boosting do
        wait()
        pcall(function()
            local player = game.Players.LocalPlayer
            if player.Character:FindFirstChild("myCharString") and player.Character.Humanoid.WalkSpeed > 18 and player.Character.Humanoid.WalkSpeed < 21 then
                player.Character.Humanoid.WalkSpeed = 21.25
            end
        end)
    end
end)

-- Killer Speed (LEGIT)
MainPage:AddSwitch("Killer Speed (LEGIT)", function(Boost2)
    debugPrint("Killer Speed (LEGIT) toggled: " .. tostring(Boost2))
    local Boosting2 = Boost2
    while Boosting2 do
        wait()
        pcall(function()
            local player = game.Players.LocalPlayer
            if player.Character:FindFirstChild("Weapon") and player.Character.Humanoid.WalkSpeed > 18 and player.Character.Humanoid.WalkSpeed < 21 then
                player.Character.Humanoid.WalkSpeed = 20
            end
        end)
    end
end)

-- Daytime & No Fog
MainPage:AddSwitch("Daytime & No Fog", function(Light)
    debugPrint("Daytime & No Fog toggled: " .. tostring(Light))
    local Lighting = Light
    while Lighting do
        wait()
        pcall(function()
            local atmosphere = game.Lighting:FindFirstChild("Atmosphere")
            if atmosphere then
                if atmosphere.Density ~= 0 then
                    atmosphere.Density = 0
                end
                if atmosphere.Glare ~= 0 then
                    atmosphere.Glare = 0
                end
                if atmosphere.Haze ~= 0 then
                    atmosphere.Haze = 0
                end
            end
            local bloom = game.Lighting:FindFirstChild("Bloom")
            if bloom and bloom.Enabled then
                bloom.Enabled = false
            end
            local dof = game.Lighting:FindFirstChild("GameDOF")
            if dof and dof.Enabled then
                dof.Enabled = false
            end
            if game.Lighting.ClockTime ~= 12 then
                game.Lighting.TimeOfDay = "12:00:00"
            end
        end)
    end
end)

-- Blocked Remotes
local BlockedRemotes = {
    "ReportGoogleAnalyticsEvent",
}

-- Event Types to Intercept
local Events = {
    Fire = true, 
    Invoke = true, 
    FireServer = true, 
    InvokeServer = true,
}

-- Metatable Manipulation for Blocking Remotes
local gameMeta = getrawmetatable(game)
local pseudoEnv = {
    ["__index"] = gameMeta.__index,
    ["__namecall"] = gameMeta.__namecall,
}
setreadonly(gameMeta, false)
gameMeta.__index, gameMeta.__namecall = newcclosure(function(self, index, ...)
    if Events[index] then
        for _, remote in pairs(BlockedRemotes) do
            if remote == self.Name and not checkcaller() then 
                return nil 
            end
        end
    end
    return pseudoEnv.__index(self, index, ...)
end)
setreadonly(gameMeta, true)
