getgenv().autoKusogDagan = false;
getgenv().CheckDagan = false;
getgenv().theFlash = false;
getgenv().GameName = ''
getgenv().destroyMove = false;


local KusogAmbag = game.Players.LocalPlayer.Character.Humanoid.JumpPower
local HipHeight = game.Players.LocalPlayer.Character.Humanoid.HipHeight

local placeId = game.PlaceId
if placeId == 2753915549 then
    BF = true
    GameName = "Blox Fruits"  
elseif placeId == 3475397644 then
    PDA = true 
    GameName = "Dragon Adventures"   
else
    GameName = "Mr.Rey Script"
    YBA = true
    print("\n game not support")
end
spawn(function()
    repeat wait() until game:IsLoaded()
end)

local ui = loadstring(game:HttpGet("https://pastebin.com/raw/zQWg2eeL"))()

-- UI:Init(parent)
-- Init:AddTab(title)
-- AddTab:AddSection(title)
-- AddSection:AddButton(text, callback)
-- AddSection:AddSlider(text, default, callback)
-- AddSection:AddKeybind(text, default, callback)
-- AddSection:AddToggle(text, default, callback)

local mainUI = ui:Init(game:GetService("CoreGui"))
local homeTab = mainUI:AddTab(GameName)



if PDA then
	repeat wait() until game:IsLoaded()

    local Tab1 = homeTab:AddSection("Main")
    local Tab2 = homeTab:AddSection("ESP Toggles")
    
    
    -- Main tab1
    
  
    
    spawn(function()
        local upHIgh = Tab1:AddToggle("Kusog Ambak", false, 
            function(Ambak)
                
                if Ambak == true then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200
                    wait(3)
                elseif Ambak == false then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = KusogAmbag
                end
            end
        )
    end)
    
    spawn(function()
        local onSpeed = Tab1:AddToggle("Kusog dagan", false, 
            function(dagan)
                autoKusogDagan = dagan;
                while autoKusogDagan == true do
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 300
                    wait(0.5)
                end 
            end
        )
    end)
    
    spawn(function()
        local GodSpeed = Tab1:AddToggle("The Flash", false, 
            function(dagan)
                theFlash = dagan;
                while theFlash == true do
                    autoKusogDagan = false;
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 2000
                    wait(0.5)
                end 
            end
        )
    end)
    
    
    -- Main tab2
    
    spawn(function()
        local ngalan = Tab2:AddToggle("Makita Ngalan", false, 
        function(value)
    
            MobEsp = false
            MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
            MobNames = {""} --add the names of the mobs
            
            PlayerESP = true
            
            plr = game.Players.LocalPlayer
            getgenv().ngalanPlayer = value --set to false if you want to turn it off
            
    
            
            names = {}
            function isin(obj,tbl)
                for a = 1,#tbl do
                    if obj == tbl[a] then
                        return true
                    end
                end
                return false
            end
            function test1(D)
                local d = tonumber(string.sub(D,1,string.find(D,".",1,true) + 1))
                return d
            end
            function Label(Part,Distance)
                local MainName = Part.Parent.Name
                local check = Part:FindFirstChild(MainName .. " Tracker")
                if check then
                    destroyed = false
                    while not destroyed do
                        for i = 1,#names do
                            if names[i] == MainName then
                                table.remove(names,i)
                                destroyed = true
                                break
                            end
                        end
                        destroyed = true
                    end
                    check:Destroy()
                end
                local Gui = Instance.new("BillboardGui")
                local Text = Instance.new("TextLabel")
                if Distance ~= nil then
                    local assa,D = pcall(test1,Distance)
                    if D ~= nil and D then
                        D = tonumber(D)
                        table.insert(names,MainName)
                        Gui.Name = MainName.." Tracker"
                        Gui.Parent = Part
                        Gui.Adornee = Part
                        Gui.ExtentsOffsetWorldSpace = Vector3.new(0,3,0)
                        Gui.MaxDistance = 2500
                        Gui.Size = UDim2.new(0,200,0,50)
                        Gui.AlwaysOnTop = true
                        Text.Parent = Gui
                        Text.TextWrapped = true
                        Text.BackgroundTransparency = 1
                        Text.TextSize = 16
                        Text.Size = UDim2.new(0, 200, 0, 50)
                        Text.Font = Enum.Font.Legacy
                        if D ~= nil and D < 30 then
                            Text.TextColor3 = Color3.fromRGB(33, 231, 40)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 100 then
                            Text.TextColor3 = Color3.fromRGB(228, 231, 34)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 500 then
                            Text.TextColor3 = Color3.fromRGB(255, 140, 46)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 2500 then
                            Text.TextColor3 = Color3.fromRGB(255, 0, 0)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        end
                    end
                end
            end
            
            function Root()
                plr = game.Players:FindFirstChild(game.Players.LocalPlayer.Name)
                if plr then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        return root
                    else
                        for i = 1,#names do
                            local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
                            if check then
                                table.remove(names,i)
                                check:Destroy()
                                break
                            end
                        end
                        game:GetService('RunService').Stepped:wait()
                        Root()
                    end
                end
            end
            
            while ngalanPlayer do
                game:GetService('RunService').Stepped:wait()
                plr = game.Players.LocalPlayer
                if MobEsp then
                    for iter = 1,#MobLocations do
                        local check = MobLocations[iter]:FindFirstChildOfClass("Model")
                        local check2 = MobLocations[iter]:FindFirstChildOfClass("Part")
                        if check or check2 then
                            for i,v in pairs(MobLocations[iter]:GetChildren()) do
                                if v.ClassName == "Model" or v.ClassName == "Part" and isin(v.Name,MobNames) == true then
                                    local placed = false
                                    for a,b in pairs(v:GetChildren()) do
                                        if b.Name == "Head" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.Name == "UpperTorso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.Name == "Torso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            repeat wait() until game.Players.LocalPlayer.Character ~= nil
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if PlayerESP then
                    for z,d in pairs(game.Players:GetChildren()) do
                        if d.Character ~= nil and d ~= plr then
                            local prt = d.Character:FindFirstChildOfClass("Part")
                            if prt then
                                local placed = false
                                for j,g in pairs(d.Character:GetChildren()) do
                                    if g.Name == "Head" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    elseif g.Name == "UpperTorso" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    elseif g.Name == "Torso" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            while #names > 0 do
                game:GetService('RunService').Stepped:wait()
                for i = 1,#names do
                    local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
                    if check then
                        table.remove(names,i)
                        check:Destroy()
                        break
                    end
                end
            end

        end)
    end)   

 
end



if BF then
	repeat wait() until game:IsLoaded()

    local Tab1 = homeTab:AddSection("Main")
    local Tab2 = homeTab:AddSection("ESP Toggles")
    
    
    
    
    -- Main tab1
    
  
    
    spawn(function()
        local upHIgh = Tab1:AddToggle("Kusog Ambak", false, 
            function(Ambak)
                
                if Ambak == true then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 200
                    wait(0.5)
                    print('Ambak: ', Ambak)
                elseif Ambak == false then
                    game.Players.LocalPlayer.Character.Humanoid.JumpPower = KusogAmbag
                    print('Ambak: ', Ambak)
                end
            end
        )
    end)
    
    spawn(function()
        local onSpeed = Tab1:AddToggle("Kusog dagan", false, 
            function(dagan)

                autoKusogDagan = dagan;


          
                if dagan == true then
                    if destroyMove == false then
                        game.Players.LocalPlayer.Character.Movement:Destroy()
                        destroyMove = true
                    end
                    while dagan == true and autoKusogDagan == true do
                        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 310;
                        print('dagan: ', dagan, game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)     
                        wait(0.5);  
                    end
                    
                    
                elseif dagan == false then
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32;
                    print('dagan: ', dagan, game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)
                    wait(0.5)
                    autoKusogDagan = false;
                end

            end
        )
     
    end)

    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
        destroyMove = false
    end)
    


    spawn(function()
        local lutaw = Tab1:AddToggle("Lutaw Lutaw", false, 
            function(lutaw2)
                print("Lupad ",HipHeight)
                if lutaw2 then
                    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 100
                    wait(0.5)      
                else
                    game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2.708526372909546
                end
                
            end
 
        )
    end)

  
    
    -- Main tab2
    
    spawn(function()
        local ngalan = Tab2:AddToggle("Makita Ngalan", false, 
        function(value)
    
            MobEsp = false
            MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
            MobNames = {""} --add the names of the mobs
            
            PlayerESP = true
            
            plr = game.Players.LocalPlayer
            getgenv().ngalanPlayer = value --set to false if you want to turn it off
            
    
            
            names = {}
            function isin(obj,tbl)
                for a = 1,#tbl do
                    if obj == tbl[a] then
                        return true
                    end
                end
                return false
            end
            function test1(D)
                local d = tonumber(string.sub(D,1,string.find(D,".",1,true) + 1))
                return d
            end
            function Label(Part,Distance)
                local MainName = Part.Parent.Name
                local check = Part:FindFirstChild(MainName .. " Tracker")
                if check then
                    destroyed = false
                    while not destroyed do
                        for i = 1,#names do
                            if names[i] == MainName then
                                table.remove(names,i)
                                destroyed = true
                                break
                            end
                        end
                        destroyed = true
                    end
                    check:Destroy()
                end
                local Gui = Instance.new("BillboardGui")
                local Text = Instance.new("TextLabel")
                if Distance ~= nil then
                    local assa,D = pcall(test1,Distance)
                    if D ~= nil and D then
                        D = tonumber(D)
                        table.insert(names,MainName)
                        Gui.Name = MainName.." Tracker"
                        Gui.Parent = Part
                        Gui.Adornee = Part
                        Gui.ExtentsOffsetWorldSpace = Vector3.new(0,3,0)
                        Gui.MaxDistance = 2500
                        Gui.Size = UDim2.new(0,200,0,50)
                        Gui.AlwaysOnTop = true
                        Text.Parent = Gui
                        Text.TextWrapped = true
                        Text.BackgroundTransparency = 1
                        Text.TextSize = 16
                        Text.Size = UDim2.new(0, 200, 0, 50)
                        Text.Font = Enum.Font.Legacy
                        if D ~= nil and D < 30 then
                            Text.TextColor3 = Color3.fromRGB(33, 231, 40)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 100 then
                            Text.TextColor3 = Color3.fromRGB(228, 231, 34)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 500 then
                            Text.TextColor3 = Color3.fromRGB(255, 140, 46)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        elseif D ~= nil and D < 2500 then
                            Text.TextColor3 = Color3.fromRGB(255, 0, 0)
                            Text.Text = Part.Parent.Name .. "\n Dist: " .. D
                        end
                    end
                end
            end
            
            function Root()
                plr = game.Players:FindFirstChild(game.Players.LocalPlayer.Name)
                if plr then
                    local root = plr.Character:FindFirstChild("HumanoidRootPart")
                    if root then
                        return root
                    else
                        for i = 1,#names do
                            local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
                            if check then
                                table.remove(names,i)
                                check:Destroy()
                                break
                            end
                        end
                        game:GetService('RunService').Stepped:wait()
                        Root()
                    end
                end
            end
            
            while ngalanPlayer do
                game:GetService('RunService').Stepped:wait()
                plr = game.Players.LocalPlayer
                if MobEsp then
                    for iter = 1,#MobLocations do
                        local check = MobLocations[iter]:FindFirstChildOfClass("Model")
                        local check2 = MobLocations[iter]:FindFirstChildOfClass("Part")
                        if check or check2 then
                            for i,v in pairs(MobLocations[iter]:GetChildren()) do
                                if v.ClassName == "Model" or v.ClassName == "Part" and isin(v.Name,MobNames) == true then
                                    local placed = false
                                    for a,b in pairs(v:GetChildren()) do
                                        if b.Name == "Head" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.Name == "UpperTorso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.Name == "Torso" and b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        elseif b.ClassName == "Part" and not placed and isin(v.Name,MobNames) == true then
                                            placed = true
                                            repeat wait() until game.Players.LocalPlayer.Character ~= nil
                                            Label(b,(Root().Position - b.Position).Magnitude)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if PlayerESP then
                    for z,d in pairs(game.Players:GetChildren()) do
                        if d.Character ~= nil and d ~= plr then
                            local prt = d.Character:FindFirstChildOfClass("Part")
                            if prt then
                                local placed = false
                                for j,g in pairs(d.Character:GetChildren()) do
                                    if g.Name == "Head" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    elseif g.Name == "UpperTorso" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    elseif g.Name == "Torso" and not placed then
                                        placed = true
                                        Label(g,(Root().Position - g.Position).Magnitude)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            while #names > 0 do
                game:GetService('RunService').Stepped:wait()
                for i = 1,#names do
                    local check = game.Workspace:FindFirstChild(names[i] .. " Tracker",true)
                    if check then
                        table.remove(names,i)
                        check:Destroy()
                        break
                    end
                end
            end

        end)
    end)   

 
end
