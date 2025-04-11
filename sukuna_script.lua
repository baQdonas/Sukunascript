
-- Sukuna OP Script with Cooldowns

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Debris = game:GetService("Debris")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Sukuna's Blade
local function giveSword()
    local sword = Instance.new("Tool")
    sword.Name = "Sukuna's Blade"
    sword.RequiresHandle = false
    sword.CanBeDropped = false

    local dmg = 100
    local canAttack = true

    sword.Activated:Connect(function()
        if not canAttack then return end
        canAttack = false

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, enemy in ipairs(Players:GetPlayers()) do
                if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("Humanoid") and enemy.Character:FindFirstChild("HumanoidRootPart") then
                    local dist = (enemy.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                    if dist < 20 then
                        enemy.Character.Humanoid:TakeDamage(dmg)
                    end
                end
            end
        end

        task.delay(4, function()
            canAttack = true
        end)
    end)

    sword.Parent = player.Backpack
end

-- Flame Arrow (Z)
local canShootArrow = true
local function fireArrow()
    if not canShootArrow then return end
    canShootArrow = false

    local fireball = Instance.new("Part", workspace)
    fireball.Shape = Enum.PartType.Ball
    fireball.Size = Vector3.new(2, 2, 2)
    fireball.BrickColor = BrickColor.new("Bright orange")
    fireball.Material = Enum.Material.Neon
    fireball.Position = character.Head.Position + character.Head.CFrame.lookVector * 5
    fireball.Anchored = false

    local bodyVelocity = Instance.new("BodyVelocity", fireball)
    bodyVelocity.Velocity = character.Head.CFrame.lookVector * 100
    bodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)

    fireball.Touched:Connect(function(hit)
        if hit and hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
            hit.Parent.Humanoid:TakeDamage(75)
            fireball:Destroy()
        end
    end)

    Debris:AddItem(fireball, 5)

    task.delay(4, function()
        canShootArrow = true
    end)
end

-- Domain Expansion (X)
local canUseDomain = true
local function domainExpansion()
    if not canUseDomain then return end
    canUseDomain = false

    local dome = Instance.new("Part", workspace)
    dome.Size = Vector3.new(100, 1, 100)
    dome.Position = character.HumanoidRootPart.Position
    dome.Anchored = true
    dome.BrickColor = BrickColor.new("Really red")
    dome.Transparency = 0.5
    dome.Material = Enum.Material.ForceField
    dome.Name = "DomainExpansion"

    for _, enemy in ipairs(Players:GetPlayers()) do
        if enemy ~= player and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (enemy.Character.HumanoidRootPart.Position - dome.Position).Magnitude
            if dist <= 50 then
                enemy.Character.Humanoid:TakeDamage(150)
            end
        end
    end

    Debris:AddItem(dome, 5)

    task.delay(4, function()
        canUseDomain = true
    end)
end

-- Activate abilities
giveSword()

-- Keybinds
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end

    if input.KeyCode == Enum.KeyCode.Z then
        fireArrow()
    elseif input.KeyCode == Enum.KeyCode.X then
        domainExpansion()
    end
end)
