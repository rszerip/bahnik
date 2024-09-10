local collide
local player = game:GetService("Players").LocalPlayer

game:GetService('RunService').RenderStepped:Connect(function(Settings)
		task.wait()
    if Settings.noclip then
        collide = false
        for i,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = collide
            end
        end
    else
				if not collide then
        collide = true
        for i,v in pairs(player.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = collide
                break
            end
        end
    end
    end
end)
