local Library = {}

function Library:applyEffect(Settings)
    local localPlayer = game:GetService('Players').LocalPlayer
    local visible_var
    if not localPlayer then return end
    
    local localPlayerTeam = localPlayer.Team
    
    for _, player in ipairs(game:GetService('Players'):GetPlayers()) do
        if player ~= localPlayer and (not Settings.HitboxTeamCheck or player.Team ~= localPlayerTeam) then
            local character = player.Character
            if character then
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    if HitboxVisible then visible_var = 0.8 else visible_var = 1 end
                    humanoidRootPart.Size = Vector3.new(Settings.HitboxSize, Settings.HitboxSize, Settings.HitboxSize)
                    humanoidRootPart.Transparency = visible_var
                    humanoidRootPart.BrickColor = BrickColor.new("White")
                    humanoidRootPart.Material = Enum.Material.Neon
                    humanoidRootPart.CanCollide = false
                end
            end
        end
    end
end

function Library:removeEffect()
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

return Library
