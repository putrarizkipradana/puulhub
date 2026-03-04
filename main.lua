-- [[ PUULHUB V5.1 - STABLE VERSION ]] --
-- Fitur: Auto-AFK ON, Speed, Jump, Shop Sidebar

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

-- Pastikan Window dibuat dengan benar
local Window = OrionLib:MakeWindow({
    Name = "PuulHub | Grow a Garden", 
    HidePremium = false, 
    SaveConfig = false, 
    IntroText = "PuulStore Loading...",
    IntroIcon = "rbxassetid://4483345998"
})

-- AUTO ANTI-AFK (Langsung Aktif)
local function StartAntiAfk()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end
StartAntiAfk()

-- TAB 1: UTAMA
local MainTab = Window:MakeTab({
	Name = "Utama",
	Icon = "rbxassetid://4483345998"
})

MainTab:AddParagraph("Status System", "Anti-AFK: OTOMATIS AKTIF")

-- TAB 2: KARAKTER
local CharTab = Window:MakeTab({
	Name = "Karakter",
	Icon = "rbxassetid://4483345998"
})

CharTab:AddSlider({
	Name = "WalkSpeed",
	Min = 16,
	Max = 300,
	Default = 16,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Speed",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

CharTab:AddSlider({
	Name = "JumpPower",
	Min = 50,
	Max = 300,
	Default = 50,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Power",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = Value
	end    
})

-- TAB 3: SHOP
local ShopTab = Window:MakeTab({
	Name = "Shop",
	Icon = "rbxassetid://4483345998"
})

ShopTab:AddButton({
	Name = "Copy Link Toko Eldorado",
	Callback = function()
		setclipboard("https://www.eldorado.gg/users/PuulStore")
		OrionLib:MakeNotification({
			Name = "PuulStore",
			Content = "Link disalin!",
			Time = 3
		})
	end    
})

-- WAJIB DI AKHIR SKRIP
OrionLib:Init()
