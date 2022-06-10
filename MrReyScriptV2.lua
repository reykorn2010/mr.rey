getgenv().autoKusogDagan = false;
getgenv().CheckDagan = false;
getgenv().theFlash = false;
getgenv().destroyMove = false;

local placeId = game.PlaceId

if placeId == 2753915549 then -- Blox Fruits
    BF = true
elseif placeId == 3475397644 then -- Dragon Adventures
    PDA = true 
else
    GNS = true
end
spawn(function()
    repeat wait() until game:IsLoaded()
end)

local KusogAmbag = game.Players.LocalPlayer.Character.Humanoid.JumpPower
local HipHeight = game.Players.LocalPlayer.Character.Humanoid.HipHeight

local UserName = game.Players.LocalPlayer.Name
local GameName2 = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/reykorn2010/mr.rey/main/UI-Source.lua"))()
local Window = Library.CreateLib("Mr.Rey Hub ", "DarkTheme")

local Main = Window:NewTab("Main Menu")
local WelcomeSection = Main:NewSection("Welcome "..UserName.."!")

local Ability = Window:NewTab("Ability Hacks")
local AbilitySection = Ability:NewSection("Change Character Ability")

local ESP = Window:NewTab("ESP Toggles")
local ESPSection = ESP:NewSection("ESP Toggles List")

local Controls = Window:NewTab("Controls")
local ControlsSection = Controls:NewSection("Controls - wala pay sulod")


--Main Content
WelcomeSection:NewLabel("Game Name: "..GameName2)
WelcomeSection:NewLabel("Game ID: "..game.PlaceId)


if PDA then
	repeat wait() until game:IsLoaded()

--Ability Content

    spawn(function()
        AbilitySection:NewToggle("Kusog Ambak", "Kusog ambak para dali ra maka kat-kat.. ", function(state)
            if state == true then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
                wait(0.5)
            elseif state == false then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = KusogAmbag
            end
        end)
    end)
    spawn(function()
        AbilitySection:NewToggle("Kusog Dagan", "Kusog dagan para dli ka ma apsan.. ", function(dagan)
            autoKusogDagan = dagan;

            while autoKusogDagan == true do
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 400
                wait(0.5)
            end 

        end)
    end)

--ESP Content 
    spawn(function()
        ESPSection:NewToggle("Makita Ngalan", "Makita ang ngalan sa mga player mag dependi ang color sa kalayon sa player", function(KitaNgalan)


            MobEsp = false
            MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
            MobNames = {""} --add the names of the mobs
            
            PlayerESP = true
            
            plr = game.Players.LocalPlayer
            getgenv().ngalanPlayer = KitaNgalan --set to false if you want to turn it off
            
    
            
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

--end PDA

if BF then
	repeat wait() until game:IsLoaded()
--Ability Content

    spawn(function()
        AbilitySection:NewToggle("Kusog Ambak", "Kusog ambak para dali ra maka kat-kat.. ", function(state)
            if state == true then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
                wait(0.5)
            elseif state == false then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = KusogAmbag
            end
        end)
    end)
    spawn(function()
        AbilitySection:NewToggle("Kusog Dagan", "Kusog dagan para dli ka ma apsan.. ", function(dagan)
            autoKusogDagan = dagan;
        
            if dagan == true then
                if destroyMove == false then
                    game.Players.LocalPlayer.Character.Movement:Destroy()
                    destroyMove = true
                end
                while dagan == true and autoKusogDagan == true do
                    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 400;   
                    wait(0.5);  
                    print(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)
                end
            elseif dagan == false then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32;
                wait(0.5)
                autoKusogDagan = false;
                print(game.Players.LocalPlayer.Character.Humanoid.WalkSpeed)
            end
        end)
    end)

--ESP Content 
    spawn(function()
        ESPSection:NewToggle("Makita Ngalan", "Makita ang ngalan sa mga player mag dependi ang color sa kalayon sa player", function(KitaNgalan)


            MobEsp = false
            MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
            MobNames = {""} --add the names of the mobs
            
            PlayerESP = true
            
            plr = game.Players.LocalPlayer
            getgenv().ngalanPlayer = KitaNgalan --set to false if you want to turn it off
            

            
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





if GNS then
	repeat wait() until game:IsLoaded()

--Ability Content

    spawn(function()
        AbilitySection:NewToggle("Kusog Ambak", "Kusog ambak para dali ra maka kat-kat.. ", function(state)
            if state == true then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 300
                wait(0.5)
            elseif state == false then
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = KusogAmbag
            end
        end)
    end)
    spawn(function()
        AbilitySection:NewToggle("Kusog Dagan", "Kusog dagan para dli ka ma apsan.. ", function(dagan)
            autoKusogDagan = dagan;

            while autoKusogDagan == true do
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 400
                wait(0.5)
            end 

            if autoKusogDagan == false then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 32
            end

        end)
    end)

--ESP Content 
    spawn(function()
        ESPSection:NewToggle("Makita Ngalan", "Makita ang ngalan sa mga player mag dependi ang color sa kalayon sa player", function(KitaNgalan)


            MobEsp = false
            MobLocations = {game:GetService("Workspace")} --add locations of the mobs in the workspace
            MobNames = {""} --add the names of the mobs
            
            PlayerESP = true
            
            plr = game.Players.LocalPlayer
            getgenv().ngalanPlayer = KitaNgalan --set to false if you want to turn it off
            
    
            
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

--end PDA







ControlsSection:NewButton("ButtonText", "ButtonInfo", function()
    print(frame.PlayerName.Text)
end)

ControlsSection:NewToggle("ToggleText", "ToggleInfo", function(state)
    if state then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end)

getgenv().Toggled = false

local toggle = ControlsSection:NewToggle("Toggle", "Info", function(state)
    getgenv().Toggled = state;
end)

game:GetService("RunService").RenderStepped:Connect(function()
	if getgenv().Toggled then
		toggle:UpdateToggle("Toggle On")
	else
		toggle:UpdateToggle("Toggle Off")
	end
end)



Section:NewTextBox("TextboxText", "TextboxInfo", function(txt)
	print(txt)
end)

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
	print("You just clicked the bind")
end)

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.F, function()
	Library:ToggleUI()
end)
Section:NewDropdown("DropdownText", "DropdownInf", {"Option 1", "Option 2", "Option 3"}, function(currentOption)
    print(currentOption)
end)

local oldList = {
  "2019",
  "2020"
}
local newList = {
  "2021",
  "2022"
}
local dropdown = Section:NewDropdown("Dropdown","Info", oldList, function()

end)
Section:NewButton("Update Dropdown", "Refreshes Dropdown", function()
  dropdown:Refresh(newList)
end)
Section:NewColorPicker("Color Text", "Color Info", Color3.fromRGB(0,0,0), function(color)
    print(color)
    -- Second argument is the default color
end)


