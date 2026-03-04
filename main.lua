-- [[ PUULHUB V4 - GROW A GARDEN SPECIAL ]] --
-- Optimized for Mobile & Bypass Basics

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "PuulHub | Grow a Garden Edition",
   LoadingTitle = "Menyiapkan Script...",
   LoadingSubtitle = "oleh PuulStore",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false 
})

local Tab = Window:CreateTab("Movement", 4483362458)

-- Fitur WalkSpeed dengan sistem Auto-Refresh (Bypass)
local targetSpeed = 16
Tab:CreateSlider({
   Name = "Kecepatan Lari (Safe Speed: 20-50)",
   Range = {16, 300},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Callback = function(Value)
      targetSpeed = Value
   end,
})

-- Loop untuk memastikan Speed tetap aktif (Berdasarkan logika skrip yang kamu kirim)
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.WalkSpeed ~= targetSpeed then
                hum.WalkSpeed = targetSpeed
            end
        end)
    end
end)

-- Fitur Anti-AFK (Penting untuk nunggu tanaman tumbuh)
local AfkTab = Window:CreateTab("Utility", 4483362458)
AfkTab:CreateToggle({
   Name = "Anti-Kick (Anti-AFK)",
   CurrentValue = false,
   Callback = function(Value)
      _G.AntiAfk = Value
      while _G.AntiAfk do
         local vu = game:GetService("VirtualUser")
         vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         task.wait(1)
         vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
         task.wait(60)
      end
   end,
})

Rayfield:Notify({
   Title = "PuulHub Loaded!",
   Content = "Gunakan speed dengan bijak agar tidak terdeteksi pemain lain.",
   Duration = 5,
})
