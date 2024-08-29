local GameID = game.PlaceId
local init_ntf = function(message)
                task.wait(0.1)
                StarterGui:SetCore("SendNotification", {
                    Title = "Sistema";
                    Text = message;
                    Duration = 0.8;
                    Button1 = "";
                })
end;


local gameActions = {
    [10260193230] = pcall(function()
        -- Meme Sea
        loadstring(game:HttpGet("https://raw.githubusercontent.com/swe7z/ordep-menu/main/release/memesea.lua", true))()
    end),
}

local action = gameActions[GameID]
if action then
    action()
else
    init_ntf("Unsupported Game: " .. GameID)
end
