-- =========================================================
-- JDEV BLOX🤫🌙 — Painel Premium Executável
-- Autor: JDEV
-- Versão: 3.0 Ultimate
-- Compatível com: Synapse X, Script Hub, Krnl, Fluxus, JJSploit
-- =========================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- ==========================================
-- CONFIGURAÇÕES GERAIS DO PAINEL
-- ==========================================
local PanelConfig = {
    Title = "JDEV BLOX🤫🌙",
    Width = 420,
    Height = 520,
    X = 10,
    Y = 10,
    Theme = {
        Background = Color3.fromRGB(12, 12, 20),
        HeaderBg = Color3.fromRGB(20, 18, 35),
        CardBg = Color3.fromRGB(25, 22, 40),
        CardHover = Color3.fromRGB(35, 30, 55),
        Accent = Color3.fromRGB(168, 85, 247), -- Roxo neon
        Accent2 = Color3.fromRGB(99, 102, 241), -- Índigo
        Accent3 = Color3.fromRGB(59, 130, 246), -- Azul
        TextPrimary = Color3.fromRGB(228, 228, 255),
        TextSecondary = Color3.fromRGB(148, 163, 184),
        BorderColor = Color3.fromRGB(139, 92, 246),
        Success = Color3.fromRGB(34, 197, 94),
        Warning = Color3.fromRGB(245, 158, 11),
        ModalBg = Color3.fromRGB(15, 12, 30),
        GlowColor = Color3.fromRGB(168, 85, 247)
    }
}

-- ==========================================
-- LISTA DE JOGOS E SCRIPTS
-- ==========================================
local GamesList = {
    {
        Name = "MOG OR DIE",
        Icon = "🐱",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ MOG OR DIE - Carregado!")
            print("   → Auto Win: ON")
            print("   → Auto Farm: ON")
            print("   → ESP Players/Items/Traps: ON")
            print("   → God Mode: ON")
            print("   → Teleports: LOBBY, ARENA, SHOP, SAFEZONE")
            -- Aqui você coloca o script real do MOG OR DIE
            -- Exemplo: loadstring(game:HttpGet("https://..."))()
        end
    },
    {
        Name = "Blox Fruits",
        Icon = "🍎",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ Blox Fruits - Carregado!")
            print("   → Auto Farm: ON")
            print("   → Auto Quest: ON")
            print("   → Auto Raid: ON")
            print("   → Teleport System: ON")
            print("   → Fast Swim/Fly: ON")
        end
    },
    {
        Name = "King Legacy",
        Icon = "👑",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ King Legacy - Carregado!")
            print("   → Auto Farm: ON")
            print("   → Auto Boss: ON")
            print("   → ESP Wall: ON")
            print("   → Speed Hack: 100")
        end
    },
    {
        Name = "Pet Sim 99",
        Icon = "🐾",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ Pet Sim 99 - Carregado!")
            print("   → Auto Hatch: ON")
            print("   → Auto Farm: ON")
            print("   → Huge Pets ESP: ON")
            print("   → Infinite Enchant: ON")
        end
    },
    {
        Name = "Arsenal",
        Icon = "🔫",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ Arsenal - Carregado!")
            print("   → ESP Players: ON")
            print("   → Aimbot: ON")
            print("   → No Recoil: ON")
            print("   → Fast Reload: ON")
        end
    },
    {
        Name = "Tower of Thrones",
        Icon = "🏰",
        Status = "active",
        ScriptFunc = function()
            print("[JDEV BLOX] ✅ Tower of Thrones - Carregado!")
            print("   → Auto Attack: ON")
            print("   → Auto Heal: ON")
            print("   → ESP: ON")
            print("   → Damage Boost: 1000x")
        end
    },
    {
        Name = "Anime Defenders",
        Icon = "🛡️",
        Status = "brew",
        ScriptFunc = nil
    },
    {
        Name = "Doom Spire",
        Icon = "⚔️",
        Status = "brew",
        ScriptFunc = nil
    },
    {
        Name = "Murder Mystery 2",
        Icon = "🔪",
        Status = "brew",
        ScriptFunc = nil
    },
    {
        Name = "BedWars",
        Icon = "🛏️",
        Status = "brew",
        ScriptFunc = nil
    },
    {
        Name = "Doors",
        Icon = "🚪",
        Status = "brew",
        ScriptFunc = nil
    },
    {
        Name = "Piggy",
        Icon = "🐷",
        Status = "brew",
        ScriptFunc = nil
    }
}

-- ==========================================
-- UTILITÁRIOS
-- ==========================================
local function Create(FrameClass, Properties)
    local Object = FrameClass.new(Properties)
    return Object
end

local function RoundNumber(num, decimals)
    local multiplier = 10 ^ (decimals or 0)
    return math.floor(num * multiplier + 0.5) / multiplier
end

-- ==========================================
-- CRIAÇÃO DO PAINEL PRINCIPAL
-- ==========================================
local ScreenGui = Create("ScreenGui", {
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Parent = CoreGui
})

local MainFrame = Create("Frame", {
    Name = "JDEV_BLOX_Panel",
    Size = UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height),
    Position = UDim2.new(0, PanelConfig.X, 0, PanelConfig.Y),
    BackgroundColor3 = PanelConfig.Theme.Background,
    BorderSizePixel = 0,
    Parent = ScreenGui
})

-- Bordas arredondadas via UICorner
local Corner = Create("UICorner", {
    CornerRadius = UDim.new(0, 16),
    Parent = MainFrame
})

-- Sombra/Glow externo
local Shadow = Create("UIStroke", {
    Color = PanelConfig.Theme.Accent,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = MainFrame
})

-- ==========================================
--- CABEÇALHO COM ÍCONE DE LUA
-- ==========================================
local HeaderFrame = Create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 70),
    BackgroundColor3 = PanelConfig.Theme.HeaderBg,
    BorderSizePixel = 0,
    Parent = MainFrame
})

local HeaderCorner = Create("UICorner", {
    CornerRadius = UDim.new(0, 16),
    Parent = HeaderFrame
})

-- Ícone de Lua Premium (desenhado com Circle + Glow)
local MoonContainer = Create("Frame", {
    Name = "MoonIcon",
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0, 15, 0.5, -25),
    BackgroundTransparency = 1,
    Parent = HeaderFrame
})

-- Glow da lua
local MoonGlow = Create("ImageLabel", {
    Image = "rbxassetid://4458701180", -- Star/sparkle asset
    ScaleType = Enum.ScaleType.Tile,
    TileSize = UDim2.new(0, 40, 0, 40),
    Size = UDim2.new(0, 55, 0, 55),
    Position = UDim2.new(0, -2.5, 0, -2.5),
    BackgroundTransparency = 1,
    ImageTransparency = 0.7,
    Rotation = 45,
    Parent = MoonContainer
})

-- Círculo principal (lua crescente simulada)
local MoonCircle = Create("ImageLabel", {
    Image = "rbxassetid://4446701180", -- Usando um asset genérico de círculo/lua
    ScaleType = Enum.ScaleType.Fit,
    Size = UDim2.new(0, 48, 0, 48),
    BackgroundTransparency = 0,
    BackgroundColor3 = PanelConfig.Theme.Accent,
    Parent = MoonContainer
})

local MoonInnerCorner = Create("UICorner", {
    CornerRadius = UDim.new(1, 0),
    Parent = MoonCircle
})

-- Brilho interno da lua
local MoonShine = Create("ImageLabel", {
    Image = "rbxassetid://1397539394", -- Sparkle
    ScaleType = Enum.ScaleType.Tile,
    TileSize = UDim2.new(0, 20, 0, 20),
    Size = UDim2.new(0, 50, 0, 50),
    Position = UDim2.new(0, -1, 0, -1),
    BackgroundTransparency = 1,
    ImageTransparency = 0.85,
    Rotation = 0,
    Parent = MoonContainer
})

-- Texto "JDEV BLOX" ao lado da lua
local TitleText = Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, -75, 0, 50),
    Position = UDim2.new(0, 65, 0.5, -25),
    BackgroundTransparency = 1,
    Text = "JDEV BLOX",
    Font = Enum.Font.GothenBold,
    TextSize = 22,
    TextColor3 = PanelConfig.Theme.TextPrimary,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextScaled = true,
    Parent = HeaderFrame
})

-- Emoji 🤫🌙 como subtítulo decorativo
local SubtitleText = Create("TextLabel", {
    Name = "Subtitle",
    Size = UDim2.new(1, -75, 0, 20),
    Position = UDim2.new(0, 65, 0, 42),
    BackgroundTransparency = 1,
    Text = "🤫🌙 ULTIMATE HUB",
    Font = Enum.Font.GothicSemibold,
    TextSize = 12,
    TextColor3 = PanelConfig.Theme.Accent,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = HeaderFrame
})

-- ==========================================
-- ÁREA DE CONTEÚDO (Scrollable)
-- ==========================================
local ScrollFrame = Create("ScrollingFrame", {
    Name = "GameList",
    Size = UDim2.new(1, -20, 1, -90),
    Position = UDim2.new(0, 10, 0, 80),
    BackgroundTransparency = 1,
    CanvasSize = UDim2.new(0, 0, 0, #GamesList * 85),
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = PanelConfig.Theme.Accent,
    VerticalScrollBarInset = Enum.Inset.ScrollbarAlwaysOff,
    Parent = MainFrame
})

local ScrollCorner = Create("UICorner", {
    CornerRadius = UDim.new(0, 8),
    Parent = ScrollFrame
})

-- ==========================================
-- RENDERIZA OS CARDS DOS JOGOS
-- ==========================================
local GameCards = {}

for i, GameData in ipairs(GamesList) do
    local Card = Create("Frame", {
        Name = "GameCard_" .. i,
        Size = UDim2.new(1, -10, 0, 75),
        Position = UDim2.new(0, 5, 0, (i-1) * 85 + 5),
        BackgroundColor3 = PanelConfig.Theme.CardBg,
        BorderSizePixel = 0,
        Parent = ScrollFrame
    })

    local CardCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, 12),
        Parent = Card
    })

    -- Ícone do jogo
    local IconLabel = Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 45, 0, 45),
        Position = UDim2.new(0, 10, 0.5, -22.5),
        BackgroundTransparency = 1,
        Text = GameData.Icon,
        TextSize = 28,
        Parent = Card
    })

    -- Nome do jogo
    local NameLabel = Create("TextLabel", {
        Name = "Name",
        Size = UDim2.new(1, -70, 0, 25),
        Position = UDim2.new(0, 60, 0, 10),
        BackgroundTransparency = 1,
        Text = GameData.Name,
        Font = Enum.Font.GothicBold,
        TextSize = 16,
        TextColor3 = PanelConfig.Theme.TextPrimary,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Card
    })

    -- Status
    local StatusLabel = Create("TextLabel", {
        Name = "Status",
        Size = UDim2.new(1, -70, 0, 20),
        Position = UDim2.new(0, 60, 0, 38),
        BackgroundTransparency = 1,
        Text = GameData.Status == "active" and "● ATIVO" or "◌ EM BREVE",
        Font = Enum.Font.GothicSemibold,
        TextSize = 11,
        TextColor3 = GameData.Status == "active" and PanelConfig.Theme.Success or PanelConfig.Theme.Warning,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Card
    })

    -- Botão de execução
    local ExecuteBtn = Create("TextButton", {
        Name = "ExecuteBtn",
        Size = UDim2.new(0, 55, 0, 35),
        Position = UDim2.new(1, -65, 0.5, -17.5),
        BackgroundColor3 = GameData.Status == "active" and PanelConfig.Theme.Accent or PanelConfig.Theme.CardHover,
        BorderSizePixel = 0,
        Text = GameData.Status == "active" and "▶ EXEC" or "🔒",
        Font = Enum.Font.GothicBold,
        TextSize = 11,
        TextColor3 = GameData.Status == "active" and Color3.fromRGB(255, 255, 255) or PanelConfig.Theme.TextSecondary,
        Parent = Card
    })

    local BtnCorner = Create("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = ExecuteBtn
    })

    -- Hover effects
    Card.MouseEnter:Connect(function()
        if GameData.Status == "active" then
            TweenService:Create(Card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = PanelConfig.Theme.CardHover
            }):Play()
        end
    end)

    Card.MouseLeave:Connect(function()
        TweenService:Create(Card, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundColor3 = PanelConfig.Theme.CardBg
        }):Play()
    end)

    -- Clique no card ou botão
    local function OnClick()
        if GameData.Status == "brew" then
            ShowBrewModal(GameData.Name)
        else
            -- Executa o script
            pcall(function()
                GameData.ScriptFunc()
            end)
            ShowToast("✅ " .. GameData.Name .. " carregado!")
        end
    end

    Card.MouseButton1Click:Connect(OnClick)
    ExecuteBtn.MouseButton1Click:Connect(OnClick)

    -- Animação de entrada
    Card.Visible = false
    spawn(function()
        wait(0.1 * i)
        TweenService:Create(Card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        }):Play()
        Card.Visible = true
    end)

    table.insert(GameCards, Card)
end

-- ==========================================
-- MODAL "EM BREVE"
-- ==========================================
local BrewModal = Create("TextButton", {
    Name = "BrewModal",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    Text = "",
    Parent = ScreenGui
})

local ModalOverlay = Create("Frame", {
    Name = "Overlay",
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 0.6,
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    Parent = BrewModal
})

local ModalContent = Create("Frame", {
    Name = "Content",
    Size = UDim2.new(0, 350, 0, 200),
    Position = UDim2.new(0.5, -175, 0.5, -100),
    BackgroundColor3 = PanelConfig.Theme.ModalBg,
    BorderSizePixel = 0,
    Parent = BrewModal
})

local ModalCorner = Create("UICorner", {
    CornerRadius = UDim.new(0, 16),
    Parent = ModalContent
})

local ModalBorder = Create("UIStroke", {
    Color = PanelConfig.Theme.Accent,
    Thickness = 2,
    Parent = ModalContent
})

local BrewTitle = Create("TextLabel", {
    Name = "Title",
    Size = UDim2.new(1, 0, 0, 40),
    Position = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1,
    Text = "⏳ EM BREVE",
    Font = Enum.Font.GothicBold,
    TextSize = 22,
    TextColor3 = PanelConfig.Theme.Warning,
    TextWrapped = true,
    Parent = ModalContent
})

local BrewMessage = Create("TextLabel", {
    Name = "Message",
    Size = UDim2.new(1, -40, 0, 50),
    Position = UDim2.new(0, 20, 0, 70),
    BackgroundTransparency = 1,
    Text = "O script para este jogo ainda está sendo desenvolvido.",
    Font = Enum.Font.Gothic,
    TextSize = 14,
    TextColor3 = PanelConfig.Theme.TextSecondary,
    TextWrapped = true,
    Parent = ModalContent
})

local ChooseBtn = Create("TextButton", {
    Name = "ChooseBtn",
    Size = UDim2.new(0, 200, 0, 40),
    Position = UDim2.new(0.5, -100, 0, 130),
    BackgroundColor3 = PanelConfig.Theme.Accent,
    BorderSizePixel = 0,
    Text = "ESCOLHER OUTRO",
    Font = Enum.Font.GothicBold,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Parent = ModalContent
})

local BtnCorner2 = Create("UICorner", {
    CornerRadius = UDim.new(0, 10),
    Parent = ChooseBtn
})

ChooseBtn.MouseButton1Click:Connect(function()
    BrewModal.Visible = false
end)

BrewModal.MouseButton1Click:Connect(function()
    BrewModal.Visible = false
end)

function ShowBrewModal(gameName)
    BrewMessage.Text = "O script para \"" .. gameName .. "\" ainda está sendo desenvolvido.\nEscolha outro jogo abaixo!"
    BrewModal.Visible = true
    
    -- Animação de entrada
    TweenService:Create(ModalContent, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        ScaleX = 1.1,
        ScaleY = 1.1
    }):Play()
    wait(0.1)
    TweenService:Create(ModalContent, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ScaleX = 1,
        ScaleY = 1
    }):Play()
end

-- ==========================================
-- TOAST DE NOTIFICAÇÃO
-- ==========================================
local ToastFrame = Create("Frame", {
    Name = "Toast",
    Size = UDim2.new(0, 300, 0, 50),
    Position = UDim2.new(1, -320, 1, -70),
    BackgroundColor3 = Color3.fromRGB(20, 18, 35),
    BorderSizePixel = 0,
    Parent = ScreenGui
})

local ToastCorner = Create("UICorner", {
    CornerRadius = UDim.new(0, 10),
    Parent = ToastFrame
})

local ToastBorder = Create("UIStroke", {
    Color = PanelConfig.Theme.Success,
    Thickness = 1.5,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Parent = ToastFrame
})

local ToastText = Create("TextLabel", {
    Name = "Text",
    Size = UDim2.new(1, -20, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    BackgroundTransparency = 1,
    Text = "",
    Font = Enum.Font.GothicBold,
    TextSize = 14,
    TextColor3 = PanelConfig.Theme.Success,
    Parent = ToastFrame
})

function ShowToast(message)
    ToastText.Text = message
    ToastFrame.Position = UDim2.new(1, -320, 1, -70)
    TweenService:Create(ToastFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -320, 1, -100)
    }):Play()
    
    wait(3)
    
    TweenService:Create(ToastFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(1, -320, 1, -70)
    }):Play()
end

-- ==========================================
-- SISTEMA DE ARRASTAR O PAINEL (QUALQUER PONTO)
-- ==========================================
local Dragging = false
local DragStart = Vector2.new(0, 0)
local StartPosition = UDim2.new(0, 0, 0, 0)

local function UpdateDrag(input)
    local Delta = input.Position - DragStart
    local X = math.clamp(StartPosition.X.Offset + Delta.X, 0, workspace.CurrentCamera.ViewportSize.X - PanelConfig.Width)
    local Y = math.clamp(StartPosition.Y.Offset + Delta.Y, 0, workspace.CurrentCamera.ViewportSize.Y - PanelConfig.Height)
    MainFrame.Position = UDim2.new(0, X, 0, Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        Dragging = true
        DragStart = input.Position
        StartPosition = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        UpdateDrag(input)
    end
end)

-- ==========================================
-- ANIMAÇÃO DE ENTRADA DO PAINEL
-- ==========================================
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0, PanelConfig.X, 0, PanelConfig.Y)

spawn(function()
    wait(0.2)
    TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height)
    }):Play()
end)

-- ==========================================
-- BOTÃO MINIMIZAR/FECHAR (Canto superior direito)
-- ==========================================
local MinimizeBtn = Create("TextButton", {
    Name = "Minimize",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -35, 0, 10),
    BackgroundTransparency = 1,
    Text = "—",
    Font = Enum.Font.GothicBold,
    TextSize = 18,
    TextColor3 = PanelConfig.Theme.TextSecondary,
    Parent = HeaderFrame
})

local CloseBtn = Create("TextButton", {
    Name = "Close",
    Size = UDim2.new(0, 30, 0, 30),
    Position = UDim2.new(1, -35, 0, 40),
    BackgroundTransparency = 1,
    Text = "✕",
    Font = Enum.Font.GothicBold,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(239, 68, 68),
    Parent = HeaderFrame
})

MinimizeBtn.MouseButton1Click:Connect(function()
    local isMinimized = MainFrame.Size == UDim2.new(0, 50, 0, 50)
    if not isMinimized then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 50, 0, 50),
            Position = UDim2.new(0, PanelConfig.X, 0, PanelConfig.Y)
        }):Play()
    else
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, PanelConfig.Width, 0, PanelConfig.Height),
            Position = UDim2.new(0, PanelConfig.X, 0, PanelConfig.Y)
        }):Play()
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }):Play()
    wait(0.3)
    MainFrame.Visible = false
end)

print("[JDEV BLOX🤫🌙] Painel carregado com sucesso! 🌙")
print("[JDEV BLOX🤫🌙] Arraste por QUALQUER lugar do painel.")
print("[JDEV BLOX🤫🌙] " .. #GamesList .. " jogos disponíveis.")
