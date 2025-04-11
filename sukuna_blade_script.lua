-- Sukuna's Blade Script by baQdonas

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

        -- اختبار فقط: طباعة رسالة
        print("Sukuna's Blade Activated!")

        -- مثال تأثير: إنقاص حياة العدو أمام اللاعب (dummy)
        local target = character:FindFirstChild("Humanoid")
        if target then
            target:TakeDamage(10)
        end

        wait(2) -- كولداون ٢ ثانية
        canAttack = true
    end)
end

-- تنفيذ الدالة
giveSword()
