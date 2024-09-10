print("Cliplib Loaded")

_G.noclip = nil
local collide = nil
local runservice = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer

runservice.Stepped:Connect(function()
    if _G.noclip == true then
        collide = false
        for i,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = collide
            end
        end
    else
        collide = true
        for i,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = collide
                break
            end
        end
    end
end)