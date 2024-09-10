print("Hitboxlib Loaded")

_G.HitboxSize = 15
_G.isEnabled = false
_G.IsTeamCheckEnabled = false
_G.NumberInvs = 1
local deployApply = false

local function applyEffect()
    local deployApply = true
    local localPlayer = game:GetService('Players').LocalPlayer
    if not localPlayer then return end
    
    local localPlayerTeam = localPlayer.Team
    
    for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
        if player ~= localPlayer and (not _G.IsTeamCheckEnabled or player.Team ~= localPlayerTeam) then
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    humanoidRootPart.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    humanoidRootPart.Transparency = _G.NumberInvs
                    humanoidRootPart.BrickColor = BrickColor.new("White")
                    humanoidRootPart.Material = Enum.Material.Neon
                    humanoidRootPart.CanCollide = false
                end
            end
        end
    end
end

local function removeEffect()
    local deployApply = false
    for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
        local character = player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                humanoidRootPart.Size = Vector3.new(2, 2, 1)
                humanoidRootPart.Transparency = _G.NumberInvs
                humanoidRootPart.CanCollide = true
            end
        end
    end
end

game:GetService('RunService').RenderStepped:Connect(function()
    while wait() do
        if _G.isEnabled then
            applyEffect()
        else
            if deployApply then
              removeEffect()
            else
              return nil;
            end
        end
    end
end)