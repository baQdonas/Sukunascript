
-- Sukuna's Blade Script by baQdonas (معدل ومحسن)

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- إنشاء السلاح
local function giveSword()
    local sword = Instance.new("Tool")
    sword.Name = "Sukuna's Blade"
    sword.RequiresHandle = false
    sword.CanBeDropped = false
    sword.Parent = player.Backpack

    local canAttack = true

    -- عند التفعيل
    sword.Activated:Connect(function()
        if not canAttack then return end
        canAttack = false

        print("Sukuna's Blade Activated!")

        -- البحث عن أقرب هدف (مثل Dummy) ضمن مدى معين
        local closestEnemy
        local shortestDistance = 10 -- أقصى مدى للضرب

        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") and obj:FindFirstChild("Humanoid") and obj:FindFirstChild("HumanoidRootPart") then
                local distance = (obj.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude
                warn("Checking enemy:", obj.Name, " Distance:", distance)
                if distance < shortestDistance and obj.Name ~= player.Name then
                    closestEnemy = obj
                    shortestDistance = distance
                end
            end
        end

        -- تطبيق الضرر إذا وجد هدف
        if closestEnemy then
            closestEnemy.Humanoid:TakeDamage(15)
            print("Hit", closestEnemy.Name)
        else
            print("No enemy in range.")
        end

        wait(2) -- كولداون 2 ثانية
        canAttack = true
    end)
end

-- تنفيذ الدالة
giveSword()
