local GameID = game.PlaceId
local _ntf = function(message)
    task.wait()
    StarterGui:SetCore("SendNotification", {
        Title = "Sistema";
        Text = message;
        Duration = 0.8;
        Button1 = "";
    })
end

local gameActions = {
    [10260193230] = function()
        -- Meme Sea
        pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/swe7z/ordep-menu/main/release/memesea.lua", true))()
        end)
    end,
}

local action = gameActions[GameID]
if action then
    pcall(action)  -- Não precisa dos parênteses após `action`
else
    _ntf("Unsupported Game: " .. GameID)
end