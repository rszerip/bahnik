local GameID = game.PlaceId
local StarterGui = game:GetService("StarterGui")
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
        _ntf("Script loading...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/swe7z/ordep-menu/main/release/memesea.lua", true))() 
    end,
    [11445923563] = function() 
        _ntf("Script loading...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/swe7z/ordep-menu/main/release/onefruit.lua", true))() 
    end,
    [13155198714] = function() 
        _ntf("Script loading...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/swe7z/ordep-menu/main/release/onefruit.lua", true))() 
    end
}

local action = gameActions[GameID]
if action then
    task.wait()
    action()
else
    _ntf("Unsupported Game: " .. GameID)
end
