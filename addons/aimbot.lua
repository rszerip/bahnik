local Library = {}

local maxDistance = 500
local maxTransparency = 0.1

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Cam = game.Workspace.CurrentCamera

local FOVring = Drawing.new("Circle")
FOVring.Visible = false
FOVring.Thickness = 2
FOVring.Color = Color3.fromRGB(128, 0, 128)
FOVring.Filled = false
FOVring.Radius = 40
FOVring.Position = Cam.ViewportSize / 2

function Library:updateDrawings(Settings)
    local camViewportSize = Cam.ViewportSize
    FOVring.Position = camViewportSize / 2
    FOVring.Visible = Settings.AimbotShowFov
    FOVring.Radius = tonumber(Settings.AimbotFov)
end

function Library:lookAt(target)
    local lookVector = (target - Cam.CFrame.Position).unit
    local newCFrame = CFrame.new(Cam.CFrame.Position, Cam.CFrame.Position + lookVector)
    Cam.CFrame = newCFrame
end

function calculateTransparency(Settings, distance)
    local maxDistance = Settings.AimbotFov
    local transparency = (1 - (distance / maxDistance)) * maxTransparency
    return transparency
end

function isPlayerAlive(player)
    local character = player.Character
    if character and character:FindFirstChild("Humanoid") then
        return character.Humanoid.Health > 0
    end
    return false
end

function Library:getClosestPlayerInFOV(trg_part)
    local nearest = nil
    local last = math.huge
    local playerMousePos = Cam.ViewportSize / 2
    local localPlayer = Players.LocalPlayer

    for i = 1, #Players:GetPlayers() do
        local player = Players:GetPlayers()[i]
        if player and player ~= localPlayer and (not Settings.AimbotTeamCheck or player.Team ~= localPlayer.Team) then
            if isPlayerAlive(player) then
                local part = player.Character and player.Character:FindFirstChild(trg_part)
                if part then
                    local ePos, isVisible = Cam:WorldToViewportPoint(part.Position)
                    local distance = (Vector2.new(ePos.x, ePos.y) - playerMousePos).Magnitude

                    if distance < last and isVisible and distance < Settings.AimbotFov and distance < maxDistance then
                        last = distance
                        nearest = player
                    end
                end
            end
        end
    end

    return nearest
end

return Library
