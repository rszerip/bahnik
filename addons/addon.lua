local Library = {}

function Library:CreatePainel(Settings, callback)
		local fRequest, fStringFormat, fSpawn, fWait = request or http.request or http_request or syn.request, string.format, task.spawn, task.wait;
		
		local localPlayerId = game:GetService("Players").LocalPlayer.UserId;
		local rateLimit, rateLimitCountdown, errorWait = false, 0, false;
		
		local accountId = Settings.PlatoID;
		local allowPassThrough = Settings.allowPassThrough or false;
		local allowKeyRedeeming = Settings.allowKeyRedeeming or false;
		local useDataModel = Settings.useDataModel or true;
		
		local title = Settings.Title or "Untitled"
		
		local ScreenGui = Instance.new("ScreenGui")
		local StarterGui = game:GetService("StarterGui")
		
		local Frame = Instance.new("Frame")
		
		local TopBar = Instance.new("Frame")
		local TitleLabel = Instance.new("TextLabel")
		local GetKeyButton = Instance.new("TextButton")
		local LoginButton = Instance.new("TextButton")
		local InputBox = Instance.new("TextBox")
		local CloseButton = Instance.new("TextButton")
		
		ScreenGui.Parent = game:GetService("CoreGui")
		
		ScreenGui.ResetOnSpawn = false
		
		
		Frame.Parent = ScreenGui
		Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		Frame.BackgroundTransparency = 0.5
		Frame.Size = UDim2.new(0, 300, 0, 200)
		Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
		
		local uiCorner = Instance.new("UICorner")
		uiCorner.CornerRadius = UDim.new(0, 20)
		uiCorner.Parent = Frame
		
		TopBar.Parent = Frame
		TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
		TopBar.Size = UDim2.new(1, 0, 0, 30)
		
		local uiCorner2 = Instance.new("UICorner")
		uiCorner2.CornerRadius = UDim.new(0, 5)
		uiCorner2.Parent = TopBar
		
		TitleLabel.Parent = TopBar
		TitleLabel.Size = UDim2.new(1, 0, 1, 0)
		TitleLabel.BackgroundTransparency = 1
		TitleLabel.Font = Enum.Font.SourceSans
		TitleLabel.Text = title
		TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		TitleLabel.TextSize = 24
		TitleLabel.TextStrokeTransparency = 0.5
		
		GetKeyButton.Parent = Frame
		GetKeyButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		GetKeyButton.BackgroundTransparency = 0.5
		GetKeyButton.Size = UDim2.new(0, 100, 0, 50)
		GetKeyButton.Position = UDim2.new(1, -120, 0, 130)
		GetKeyButton.Font = Enum.Font.SourceSans
		GetKeyButton.Text = "Get Key"
		GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		GetKeyButton.TextSize = 24
		
		LoginButton.Parent = Frame
		LoginButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		LoginButton.BackgroundTransparency = 0.5
		LoginButton.Size = UDim2.new(0, 100, 0, 50)
		LoginButton.Position = UDim2.new(0, 20, 0, 130)
		LoginButton.Font = Enum.Font.SourceSans
		LoginButton.Text = "Login"
		LoginButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		LoginButton.TextSize = 24
		
		InputBox.Parent = Frame
		InputBox.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		InputBox.BackgroundTransparency = 0.5
		InputBox.BorderColor3 = Color3.fromRGB(255, 255, 255)
		InputBox.Size = UDim2.new(0, 260, 0, 50)
		InputBox.Position = UDim2.new(0, 20, 0, 50)
		InputBox.Font = Enum.Font.SourceSans
		InputBox.PlaceholderText = "Enter your key..."
		InputBox.Text = ""
		InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
		InputBox.TextSize = 24
		
		local uiCorner3 = Instance.new("UICorner")
		uiCorner3.CornerRadius = UDim.new(0, 8)
		uiCorner3.Parent = InputBox
		
		CloseButton.Parent = TopBar
		CloseButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		CloseButton.BackgroundTransparency = 1
		CloseButton.Size = UDim2.new(0, 30, 0, 30)
		CloseButton.Position = UDim2.new(1, -40, 0, 0)
		CloseButton.Font = Enum.Font.SourceSans
		CloseButton.Text = "X"
		CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		CloseButton.TextSize = 20
		
		local uiCorner5 = Instance.new("UICorner")
		uiCorner5.CornerRadius = UDim.new(0, 8)
		uiCorner5.Parent = GetKeyButton
		
		local uiCorner6 = Instance.new("UICorner")
		uiCorner6.CornerRadius = UDim.new(0, 8)
		uiCorner6.Parent = LoginButton
		
		local function onMessage(message)
				task.wait()
				StarterGui:SetCore("SendNotification", {
				    Title = "Sistema";
				    Text = message;
				    Duration = 0.8;
				    Button1 = "";
				})
		end;
		local function getLink()
				onMessage("Copied to Clipboard");
		    return fStringFormat("https://gateway.platoboost.com/a/%i?id=%i", accountId, localPlayerId);
		end;
		local function verify(key)
		    if errorWait or rateLimit then 
		        return false;
		    end;
		
		    onMessage("Checking key...");
		
		    if (useDataModel) then
		        local status, result = pcall(function() 
		            return game:HttpGetAsync(fStringFormat("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", accountId, localPlayerId, key));
		        end);
		        
		        if status then
		            if string.find(result, "true") then
		                return true;
		            elseif string.find(result, "false") then
		                if allowKeyRedeeming then
		                    local status1, result1 = pcall(function()
		                        return game:HttpPostAsync(fStringFormat("https://api-gateway.platoboost.com/v1/authenticators/redeem/%i/%i/%s", accountId, localPlayerId, key), {});
		                    end);
		
		                    if status1 then
		                        if string.find(result1, "true") then
		                            onMessage("Successfully redeemed key!");
		                            return true;
		                        end;
		                    end;
		                end;
		                
		                onMessage("Key is invalid!");
		                return false;
		            else
		                onMessage("Unexpected server response: "..tostring(result));
		                return false;
		            end;
		        else
		            onMessage("Error contacting the server: "..tostring(result));
		            return allowPassThrough;
		        end;
		    else
		        local status, result = pcall(function() 
		            return fRequest({
		                Url = fStringFormat("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", accountId, localPlayerId, key),
		                Method = "GET"
		            });
		        end);
		
		        if status then
		            if result.StatusCode == 200 then
		                if string.find(result.Body, "true") then
		                    return true;
		                else
		                    if (allowKeyRedeeming) then
		                        local status1, result1 = pcall(function() 
		                            return fRequest({
		                                Url = fStringFormat("https://api-gateway.platoboost.com/v1/authenticators/redeem/%i/%i/%s", accountId, localPlayerId, key),
		                                Method = "POST"
		                            });
		                        end);
		
		                        if status1 then
		                            if result1.StatusCode == 200 then
		                                if string.find(result1.Body, "true") then
		                                    onMessage("Successfully redeemed key!");
		                                    return true;
		                                end;
		                            else
		                                onMessage("Redeem key failed with status: "..tostring(result1.StatusCode));
		                            end;
		                        else
		                            onMessage("Error redeeming key: "..tostring(result1));
		                        end;
		                    end;
		                    
		                    return false;
		                end;
		            elseif result.StatusCode == 204 then
		                onMessage("Account wasn't found, check accountId");
		                return false;
		            elseif result.StatusCode == 429 then
		                if not rateLimit then 
		                    rateLimit = true;
		                    rateLimitCountdown = 10;
		                    fSpawn(function() 
		                        while rateLimit do
		                            onMessage(fStringFormat("You are being rate-limited, please slow down. Try again in %i second(s).", rateLimitCountdown));
		                            fWait(1);
		                            rateLimitCountdown = rateLimitCountdown - 1;
		                            if rateLimitCountdown < 0 then
		                                rateLimit = false;
		                                rateLimitCountdown = 0;
		                                onMessage("Rate limit is over, please try again.");
		                            end;
		                        end;
		                    end); 
		                end;
		            else
		                onMessage("Unexpected status code: "..tostring(result.StatusCode));
		                return allowPassThrough;
		            end;    
		        else
		            onMessage("Error contacting the server: "..tostring(result));
		            return allowPassThrough;
		        end;
		    end;
		end;
		
		CloseButton.MouseButton1Click:Connect(function()
		    ScreenGui:Destroy()
		end)
		
		LoginButton.MouseButton1Click:Connect(function()
		    local enteredKey = InputBox.Text
		    local success = verify(enteredKey);
		    
		    if success then
		        pcall(callback)
		        ScreenGui:Destroy()
		    end;
		end)
		
		GetKeyButton.MouseButton1Click:Connect(function()
		    setclipboard(tostring(getLink()));
		end)
		
		function autocheck()
		    local autokey = "check"
		    if (useDataModel) then
		        local status, result = pcall(function() 
		            return game:HttpGetAsync(string.format("https://api-gateway.platoboost.com/v1/public/whitelist/%i/%i?key=%s", accountId, localPlayerId, autokey))
		        end);
		        if status then
		            if string.find(result, "true") then
		            	pcall(callback)
		            	ScreenGui:Destroy()
		            end;
		        end;
		    end;
		end;
		
		fWait()
		autocheck()
end

function Library:CreateMinimize(Settings, callback)
	local ScreenGui = Instance.new("ScreenGui")
	local Minimize = Instance.new("ImageButton")
	
	local iconID = Settings.icon
	local _Parent = Settings.parent or ScreenGui
	
	ScreenGui.Parent = game:GetService("CoreGui")
	ScreenGui.ResetOnSpawn = false
	
	local sizeScale = 0.12
	local squareSize = math.min(workspace.CurrentCamera.ViewportSize.X, workspace.CurrentCamera.ViewportSize.Y) * sizeScale
	
	Minimize.Parent = _Parent
	Minimize.Size = UDim2.new(0, squareSize, 0, squareSize)
	Minimize.Position = UDim2.new(0, 73, 0, 50)
	Minimize.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Minimize.BackgroundTransparency = 0
	Minimize.Image = ""
	Minimize.ScaleType = Enum.ScaleType.Fit
	
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 10)
	Corner.Parent = Minimize
	
	local dragging = false
	local dragInput
	local dragStart
	local startPos
	local isMoved = false
	
	if iconID ~= "" then
	    Minimize.Image = "rbxassetid://" .. iconID
	else
	    Minimize.Image = ""
	end
	
	local function update(input)
	    local delta = input.Position - dragStart
	    Minimize.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	Minimize.InputBegan:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
	        dragging = true
	        dragStart = input.Position
	        startPos = Minimize.Position
	        isMoved = false
	
	        input.Changed:Connect(function()
	            if input.UserInputState == Enum.UserInputState.End then
	                dragging = false
	            end
	        end)
	    end
	end)
	
	Minimize.InputChanged:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	        dragInput = input
	    end
	end)
	
	game:GetService("UserInputService").InputChanged:Connect(function(input)
	    if input == dragInput and dragging then
	        isMoved = true
	        update(input)
	    end
	end)
	
	Minimize.MouseButton1Click:Connect(function()
	    if not isMoved then
	    	pcall(callback)
	    end
	end)
end

return Library
