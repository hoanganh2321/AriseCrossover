--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local v0 = loadstring;
local v1 = loadstring([[
	local Env, upvalues = ...
	local new = newproxy(true)
	local mt = getmetatable(new)
	mt.__metatable = new
	mt.__environment = new
	mt.__index = function(t,k) return Env[k] or upvalues[k] end
	mt.__newindex = function(t,k,v)
		--if rawget(upvalues,k) then return rawset(upvalues,k,v) end
		Env[k] = v
	end
return setmetatable({},mt)
]], "");
local v2 = {};
local v3 = {};
v2[3] = game:GetService("Players");
v2[11] = game:GetService("ReplicatedStorage");
local v6 = game:GetService("TweenService");
local v7 = game:GetService("Workspace");
local v8 = v2[3].LocalPlayer;
local v9 = v8.Character or v8.CharacterAdded:Wait();
local v10 = v9:WaitForChild("HumanoidRootPart");
local v11 = v7:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client");
local v12 = v2[11]:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent");
local v13 = false;
local v14 = {};
local v15 = {};
local v16 = "";
local v17 = "Tween";
local v18 = "Default";
v8.CharacterAdded:Connect(function(v125)
	v9 = v125;
	v10 = v125:WaitForChild("HumanoidRootPart");
end);
local function v19()
	v2[143] = game.Players.LocalPlayer;
	if (v2[143] and v2[143].Character) then
		v2[160] = v2[143].Character:FindFirstChild("CharacterScripts");
		if v2[160] then
			v2[174] = v2[160]:FindFirstChild("FlyingFixer");
			if v2[174] then
				v2[174]:Destroy();
			end
			v2[190] = v2[160]:FindFirstChild("CharacterUpdater");
			if v2[190] then
				v2[190]:Destroy();
			end
		end
	end
end
local function v20(v128)
	v2[213] = v128:FindFirstChild("HealthBar");
	if (v2[213] and v2[213]:FindFirstChild("Main") and v2[213].Main:FindFirstChild("Bar")) then
		v2[241] = v2[213].Main.Bar:FindFirstChild("Amount");
		if (v2[241] and v2[241]:IsA("TextLabel") and (v2[241].ContentText == "0 HP")) then
			return true;
		end
	end
	return false;
end
local function v21()
	v2[282] = nil;
	v2[285] = math.huge;
	v2[291] = v10.Position;
	for v250, v251 in ipairs(v11:GetChildren()) do
		if (v251:IsA("Model") and v251:FindFirstChild("HumanoidRootPart")) then
			v2[323] = v251:FindFirstChild("HealthBar");
			if (v2[323] and v2[323]:FindFirstChild("Main") and v2[323].Main:FindFirstChild("Title")) then
				v2[351] = v2[323].Main.Title;
				if (v2[351] and v2[351]:IsA("TextLabel") and (v2[351].ContentText == v16) and not v14[v251.Name]) then
					v2[385] = v251.HumanoidRootPart.Position;
					v2[394] = (v2[291] - v2[385]).Magnitude;
					if (v2[394] < v2[285]) then
						v2[285] = v2[394];
						v2[282] = v251;
					end
				end
			end
		end
	end
	return v2[282];
end
local function v22()
	for v252, v253 in ipairs(v11:GetChildren()) do
		if (v253:IsA("Model") and v253:FindFirstChild("HumanoidRootPart") and not v15[v253.Name]) then
			return v253;
		end
	end
	return nil;
end
local function v23()
	v2[467] = {[1]={[1]={Event="ShowPets"},[2]="\t"}};
	v12:FireServer(unpack(v2[467]));
end
local function v24()
	v2[496], v2[497] = nil, math.huge;
	v2[504] = v10.Position;
	for v254, v255 in ipairs(v11:GetChildren()) do
		if (v255:IsA("Model") and v255:FindFirstChild("HumanoidRootPart") and not v14[v255.Name]) then
			v2[544] = (v2[504] - v255:GetPivot().Position).Magnitude;
			if (v2[544] < v2[497]) then
				v2[497] = v2[544];
				v2[496] = v255;
			end
		end
	end
	return v2[496];
end
local function v25(v141)
	if (not v141 or not v141:FindFirstChild("HumanoidRootPart")) then
		return;
	end
	v2[594] = v141.HumanoidRootPart;
	if (v17 == "Teleport") then
		v10.CFrame = v2[594].CFrame * CFrame.new(0, 0, 6);
	elseif (v17 == "Tween") then
		v2[633] = TweenInfo.new(0.5, Enum.EasingStyle.Linear);
		v2[648] = v6:Create(v10, v2[633], {CFrame=(v2[594].CFrame * CFrame.new(0, 0, 6))});
		v2[648]:Play();
	elseif (v17 == "Walk") then
		v10.Parent:MoveTo(v2[594].Position);
	end
end
local function v26()
	while v13 do
		v2[705] = v24();
		if (v2[705] and v2[705].Parent) then
			v19();
			v25(v2[705]);
			task.wait(0.5);
			v23();
			v12:FireServer({{PetPos={},AttackType="All",Event="Attack",Enemy=v2[705].Name},"\7"});
			while v13 and v2[705].Parent and not v20(v2[705]) do
				task.wait(0.1);
			end
			v14[v2[705].Name] = true;
		end
		task.wait(0.2);
	end
end
local function v27()
	while v13 do
		v2[805] = v22();
		if (v2[805] and v2[805].Parent) then
			v19();
			v25(v2[805]);
			task.wait(0.5);
			v23();
			v12:FireServer({{PetPos={},AttackType="All",Event="Attack",Enemy=v2[805].Name},"\7"});
			repeat
				task.wait();
			until not v2[805].Parent or v20(v2[805]) 
			v15[v2[805].Name] = true;
		end
		task.wait();
	end
end
local function v28()
	while v13 do
		v2[901] = v21();
		if (v2[901] and v2[901].Parent) then
			v19();
			v25(v2[901]);
			task.wait(0.5);
			v23();
			v12:FireServer({{PetPos={},AttackType="All",Event="Attack",Enemy=v2[901].Name},"\7"});
			while v13 and v2[901].Parent and not v20(v2[901]) do
				task.wait(0.1);
			end
			v14[v2[901].Name] = true;
		end
		task.wait(0.2);
	end
end
local function v29()
	while damageEnabled do
		v2[1001] = v24();
		if v2[1001] then
			v2[1008] = {[1]={[1]={Event="PunchAttack",Enemy=v2[1001].Name},[2]="\4"}};
			v12:FireServer(unpack(v2[1008]));
		end
		task.wait(1);
	end
end
local v30 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
local v31 = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))();
local v32 = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))();
local v33 = v30:CreateWindow({Title="Etherbyte Hub | Arise Crossover",SubTitle="By Dantes PREMNIUM",TabWidth=140,Size=UDim2.fromOffset(450, 350),Acrylic=false,Theme="Darker",MinimizeKey=Enum.KeyCode.LeftControl});
local v34 = {Discord=v33:AddTab({Title="INFO",Icon=""}),Main=v33:AddTab({Title="Main",Icon=""}),tp=v33:AddTab({Title="Teleports",Icon=""}),mount=v33:AddTab({Title="Mount Location/farm",Icon=""}),dungeon=v33:AddTab({Title="Dungeon ",Icon=""}),pets=v33:AddTab({Title="Pets ",Icon=""}),Player=v33:AddTab({Title="Player",Icon=""}),misc=v33:AddTab({Title="misc",Icon=""}),Settings=v33:AddTab({Title="Settings",Icon="settings"})};
v34.Main:AddInput("Input", {Title="Enter Mob Name",Default="",Placeholder="Type Here",Callback=function(v144)
	v16 = v144;
	v14 = {};
	print("Selected Mob:", v16);
end});
v34.Main:AddToggle("FarmSelectedMob", {Title="Farm Selected Mob",Default=false,Callback=function(v145)
	v13 = v145;
	damageEnabled = v145;
	v14 = {};
	if v145 then
		task.spawn(v28);
	end
end});
v34.Main:AddToggle("TeleportMobs", {Title="Auto farm (nearest NPCs)",Default=false,Callback=function(v146)
	v13 = v146;
	if v146 then
		task.spawn(v26);
	end
end});
local v35 = v34.Main:AddDropdown("MovementMethod", {Title="Farming Method",Values={"Tween","Teleport"},Multi=false,Default=1,Callback=function(v147)
	v17 = v147;
end});
v34.Main:AddToggle("DamageMobs", {Title="Damage Mobs ENABLE THIS",Default=false,Callback=function(v148)
	damageEnabled = v148;
	if v148 then
		task.spawn(v29);
	end
end});
v34.dungeon:AddToggle("TeleportMobs", {Title="Auto farm Dungeon",Default=false,Callback=function(v149)
	v13 = v149;
	if v149 then
		task.spawn(v27);
	end
end});
v34.Main:AddButton({Title="Gamepass Shadow farm",Description="Dantes is best",Callback=function()
	v33:Dialog({Title="YAY",Content="join the dc",Buttons={{Title="YES",Callback=function()
		v2[1505] = game:GetService("Players").LocalPlayer.Settings;
		v2[1519] = v2[1505]:GetAttribute("AutoAttack");
		if (v2[1519] == false) then
			v2[1505]:SetAttribute("AutoAttack", true);
		end
		print("Confirmed the dialog.");
	end},{Title="No",Callback=function()
		print("Cancelled the dialog.");
	end}}});
end});
local function v36(v150)
	v2[1566] = {[1]={[1]={Event="ChangeSpawn",Spawn=v150},[2]="\n"}};
	v2[1584] = game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent");
	v2[1584]:FireServer(unpack(v2[1566]));
	task.wait(0.5);
	v2[1616] = game.Players.LocalPlayer;
	if (v2[1616].Character and v2[1616].Character.Parent) then
		v2[1639] = v2[1616].Character:FindFirstChildOfClass("Humanoid");
		if v2[1639] then
			v2[1639].Health = 0;
		end
	end
end
v34.tp:AddButton({Title="Brum Island",Description="Set spawn & reset",Callback=function()
	v36("OPWorld");
end});
v34.tp:AddButton({Title="Grass Village",Description="Set spawn & reset",Callback=function()
	v36("NarutoWorld");
end});
v34.tp:AddButton({Title="Solo City",Description="Set spawn & reset",Callback=function()
	v36("SoloWorld");
end});
v34.tp:AddButton({Title="Faceheal Town",Description="Set spawn & reset",Callback=function()
	v36("BleachWorld");
end});
v34.tp:AddButton({Title="Lucky island",Description="Set spawn & reset",Callback=function()
	v36("BCWorld");
end});
local v6 = game:GetService("TweenService");
local v6 = game:GetService("TweenService");
local v8 = game.Players.LocalPlayer;
local v9 = v8.Character or v8.CharacterAdded:Wait();
local v10 = v9:WaitForChild("HumanoidRootPart");
v8.CharacterAdded:Connect(function(v155)
	v9 = v155;
	v10 = v9:WaitForChild("HumanoidRootPart");
end);
local function v37(v156)
	if v10 then
		v2[1855] = TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false, 0);
		v2[1880] = {CFrame=v156};
		v2[1886] = v6:Create(v10, v2[1855], v2[1880]);
		v2[1886]:Play();
	end
end
local v38 = {{Name="Location 1",CFrame=CFrame.new(-6161.25781, 140.639832, 5512.9668, -0.41691944, -8.074827e-8, 0.908943415, -2.9445218e-7, 1, -4.6223523e-8, -0.908943415, -2.8691184e-7, -0.41691944)},{Name="Location 2",CFrame=CFrame.new(-5868.44141, 132.70488, 362.519379, 0.836233854, -7.472738e-8, -0.548372984, 2.5959548e-7, 1, 2.5959548e-7, 0.548372984, -3.5943768e-7, 0.836233854)},{Name="Location 3",CFrame=CFrame.new(-5430.81006, 107.441559, -5502.25244, 0.8239398, -3.6099786e-7, -0.566677332, 2.5959545e-7, 1, -2.595954e-7, 0.566677332, 6.6784125e-8, 0.8239398)},{Name="Location 4",CFrame=CFrame.new(-702.243225, 133.344467, -3538.11646, 0.978662074, 0.000114096198, -0.205476329, -0.000112703143, 1, 0.000018483444, 0.205476329, 0.000005068782, 0.978662074)},{Name="Location 5",CFrame=CFrame.new(450.001709, 117.564827, 3435.4292, -0.999887109, -1.20864e-12, 0.0150266131, -1.1249246e-12, 1, 5.5795928e-12, -0.0150266131, 5.562059e-12, -0.999887109)},{Name="Location 6",CFrame=CFrame.new(3230.96826, 135.41008, 36.1600113, -0.534268856, -0.00004752067, 0.845314622, -0.00007483047, 1, 0.000008921036, -0.845314622, -0.000058489055, -0.534268856)},{Name="Location 7",CFrame=CFrame.new(4325.36523, 118.995422, -4819.78857, -0.257801384, 3.9885583e-7, -0.966197908, -5.630396e-7, 1, 5.6304015e-7, 0.966197908, 6.8916023e-7, -0.257801384)}};
for v157, v158 in ipairs(v38) do
	v34.mount:AddButton({Title=v158.Name,Callback=function()
		v37(v158.CFrame);
	end});
end
local v39 = false;
local v40 = false;
local v11 = v7:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client");
local function v41()
	while v39 do
		task.wait(0.3);
		for v324, v325 in ipairs(v11:GetChildren()) do
			if v325:IsA("Model") then
				v2[2206] = v325:FindFirstChild("HumanoidRootPart");
				v2[2214] = v2[2206] and v2[2206]:FindFirstChild("DestroyPrompt");
				if v2[2214] then
					v2[2214]:SetAttribute("MaxActivationDistance", 100000);
					fireproximityprompt(v2[2214]);
				end
			end
		end
	end
end
local v11 = v7:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client");
local function v42()
	while v40 do
		task.wait(0.3);
		for v326, v327 in ipairs(v11:GetChildren()) do
			if v327:IsA("Model") then
				v2[2289] = v327:FindFirstChild("HumanoidRootPart");
				v2[2297] = v2[2289] and v2[2289]:FindFirstChild("ArisePrompt");
				if v2[2297] then
					v2[2297]:SetAttribute("MaxActivationDistance", 100000);
					fireproximityprompt(v2[2297]);
				end
			end
		end
	end
end
v34.Main:AddToggle("AutoDestroy", {Title="Auto Destroy",Default=false,Callback=function(v159)
	v39 = v159;
	if v159 then
		task.spawn(v41);
	end
end});
v34.Main:AddToggle("AutoArise", {Title="Auto Arise",Default=false,Callback=function(v160)
	v40 = v160;
	if v160 then
		task.spawn(v42);
	end
end});
v34.dungeon:AddToggle("AutoDestroy", {Title="Auto Destroy",Default=false,Callback=function(v161)
	v39 = v161;
	if v161 then
		task.spawn(v41);
	end
end});
v34.dungeon:AddToggle("AutoArise", {Title="Auto Arise",Default=false,Callback=function(v162)
	v40 = v162;
	if v162 then
		task.spawn(v42);
	end
end});
local v6 = game:GetService("TweenService");
local v43 = game:GetService("Players");
local v44 = game:GetService("ReplicatedStorage");
local v45 = game:GetService("Workspace");
local v8 = v43.LocalPlayer;
local v9 = v8.Character or v8.CharacterAdded:Wait();
local v10 = v9:WaitForChild("HumanoidRootPart");
local v46 = v45:WaitForChild("__Main"):WaitForChild("__Dungeon");
local v47 = false;
local function v48()
	print("[DEBUG] Attempting to create dungeon...");
	v2[2542] = {[1]={[1]={Event="DungeonAction",Action="Create"},[2]="\n"}};
	v44:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[2542]));
	print("[DEBUG] Create Dungeon event fired!");
end
local function v49()
	v2[2587] = v46:FindFirstChild("Dungeon");
	if v2[2587] then
		v2[2598] = v2[2587]:GetAttribute("ID");
		if v2[2598] then
			print("[DEBUG] Starting dungeon with ID:", v2[2598]);
			v2[2613] = {[1]={[1]={Dungeon=v2[2598],Event="DungeonAction",Action="Start"},[2]="\n"}};
			v44:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[2613]));
			print("[DEBUG] Start Dungeon event fired!");
		else
			print("[ERROR] Dungeon ID is missing!");
		end
	else
		print("[ERROR] Dungeon instance not found!");
	end
end
local function v50(v165)
	if (v165 and v165:IsA("Part")) then
		print("[DEBUG] Teleporting to:", v165.Name);
		v2[2687] = v8.Character and v8.Character:FindFirstChild("CharacterScripts") and v8.Character.CharacterScripts:FindFirstChild("FlyingFixer");
		if v2[2687] then
			v2[2687]:Destroy();
		else
			print("blablabla bleble");
		end
		v2[2728] = v8.Character and v8.Character:FindFirstChild("CharacterScripts") and v8.Character.CharacterScripts:FindFirstChild("CharacterUpdater");
		if v2[2728] then
			v2[2728]:Destroy();
			print("discord");
		else
			print("Cid");
		end
		v10.CFrame = v165.CFrame;
		print("[DEBUG] Teleport completed to:", v165.Name);
		task.wait(2);
		v48();
		task.wait(1);
		v49();
	else
		print("[ERROR] Invalid teleport target!");
	end
end
local function v51()
	while v47 do
		print("[DEBUG] Searching for dungeon objects...");
		v2[2824] = false;
		for v333, v334 in ipairs(v46:GetChildren()) do
			if v334:IsA("Part") then
				v2[2824] = true;
				v50(v334);
				task.wait(1);
			end
		end
		if not v2[2824] then
			print("[WARNING] No valid dungeon objects found!");
		end
		task.wait(0.5);
	end
end
v34.dungeon:AddToggle("TeleportToDungeon", {Title="Teleport to Dungeon",Default=false,Callback=function(v166)
	v47 = v166;
	print("[DEBUG] Teleporting toggled:", v166);
	if v166 then
		task.spawn(v51);
	end
end});
local v52 = v34.dungeon:AddToggle("AutoDetectDungeon", {Title="Auto Detect Dungeon (KEEP THIS ON)",Default=true});
local v43 = game:GetService("Players");
local v44 = game:GetService("ReplicatedStorage");
local v8 = v43.LocalPlayer;
local v53 = {["Grass Village"]="NarutoWorld",["BRUM ISLAND"]="OPWorld",["Leveling City"]="SoloWorld",["FACEHEAL TOWN"]="BleachWorld",Lucky="BCWorld"};
local function v36(v167)
	v2[2975] = {[1]={[1]={Event="ChangeSpawn",Spawn=v167},[2]="\n"}};
	v2[2993] = v44:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent");
	v2[2993]:FireServer(unpack(v2[2975]));
	task.wait(0.5);
	if v8.Character then
		v8.Character:BreakJoints();
	end
end
local function v54()
	v8.PlayerGui.Warn.ChildAdded:Connect(function(v264)
		if (v264:IsA("Frame") and v52.Value) then
			print("Dungeon detected!");
			for v437, v438 in ipairs(v264:GetChildren()) do
				if v438:IsA("TextLabel") then
					for v474, v475 in pairs(v53) do
						if string.find(string.lower(v438.Text), string.lower(v474)) then
							v13 = false;
							print("Detected village:", v474);
							v36(v475);
							return;
						end
					end
				end
			end
		end
	end);
end
v52:OnChanged(function(v170)
	if v170 then
		v54();
	end
end);
v54();
local function v55()
	v14 = {};
	print("AutoFarm has been reset!");
end
task.spawn(function()
	while true do
		task.wait(120);
		v55();
	end
end);
local v56 = {"E","D","C","B","A","S","SS"};
local v57 = v34.pets:AddDropdown("ChooseRankToSell", {Title="Choose Rank to Sell",Values=v56,Multi=true,Default={}});
local v58 = v34.pets:AddDropdown("ChoosePetsToKeep", {Title="Pets to Not Delete",Values={},Multi=true,Default={}});
v34.pets:AddButton({Title="Refresh Keep Pets List",Callback=function()
	updateKeepPetsDropdown();
end});
local function v59(v171, v172)
	v2[3277] = game:GetService("Players").LocalPlayer;
	v2[3288] = v2[3277].leaderstats.Inventory:FindFirstChild("Pets");
	if not v2[3288] then
		return {};
	end
	v2[3308] = {};
	v2[3311] = {};
	v2[3314] = {};
	for v265, v266 in ipairs(v2[3288]:GetChildren()) do
		v2[3328] = v266:GetAttribute("Rank");
		v2[3336] = v266.Name;
		if (v2[3328] and v56[v2[3328]] and v171[v56[v2[3328]]]) then
			v2[3308][v56[v2[3328]]] = v2[3308][v56[v2[3328]]] or {};
			table.insert(v2[3308][v56[v2[3328]]], v2[3336]);
		end
	end
	for v270, v271 in pairs(v2[3308]) do
		table.sort(v271);
		v2[3397] = false;
		for v335, v336 in ipairs(v271) do
			if v172[v336] then
				if not v2[3314][v336] then
					v2[3314][v336] = true;
					v2[3397] = true;
				else
					table.insert(v2[3311], v336);
				end
			elseif not v2[3397] then
				v2[3397] = true;
			else
				table.insert(v2[3311], v336);
			end
		end
	end
	return v2[3311];
end
local function v60()
	v2[3463] = v57.Value;
	v2[3469] = v58.Value;
	v2[3475] = v59(v2[3463], v2[3469]);
	if (#v2[3475] > 0) then
		v2[3487] = {[1]={[1]={Event="SellPet",Pets=v2[3475]},[2]="\t"}};
		game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[3487]));
	end
end
function updateKeepPetsDropdown()
	v2[3532] = game:GetService("Players").LocalPlayer;
	v2[3543] = v2[3532].leaderstats.Inventory:FindFirstChild("Pets");
	if not v2[3543] then
		return;
	end
	v2[3562] = {};
	for v273, v274 in ipairs(v2[3543]:GetChildren()) do
		if not table.find(v2[3562], v274.Name) then
			table.insert(v2[3562], v274.Name);
		end
	end
	v58:SetValues(v2[3562]);
end
local function v61()
	while true do
		v60();
		wait(1);
	end
end
spawn(v61);
updateKeepPetsDropdown();
v57:OnChanged(updateKeepPetsDropdown);
v58:OnChanged(updateKeepPetsDropdown);
local v62 = game:GetService("VirtualUser");
local v63 = game:GetService("Players").LocalPlayer;
local v64;
local v65 = v34.Player:AddToggle("AntiAfk", {Title="Anti AFK",Default=false,Callback=function(v188)
	if v188 then
		print("Anti AFK Enabled");
		if not v64 then
			v64 = v63.Idled:Connect(function()
				v62:Button2Down(Vector2.new(0, 0), v7.CurrentCamera.CFrame);
				task.wait(1);
				v62:Button2Up(Vector2.new(0, 0), v7.CurrentCamera.CFrame);
			end);
		end
	else
		print("Anti AFK Disabled");
		if v64 then
			v64:Disconnect();
			v64 = nil;
		end
	end
end});
local function v66()
	v2[3769] = {};
	v2[3772] = {};
	v2[3775] = game:GetService("Players").LocalPlayer.leaderstats.Inventory.Weapons:GetChildren();
	print("Fetching weapons...");
	for v275, v276 in ipairs(v2[3775]) do
		v2[3809] = v276:GetAttribute("Name");
		if v2[3809] then
			print("Found Weapon:", v2[3809]);
			if not v2[3772][v2[3809]] then
				table.insert(v2[3769], v2[3809]);
				v2[3772][v2[3809]] = true;
			end
		end
	end
	return v2[3769];
end
local v67 = v66();
local v68 = v34.misc:AddDropdown("WeaponDropdown", {Title="Select Weapon to Upgrade",Description="Choose a weapon to upgrade",Values=v67,Multi=false,Default=""});
local v69 = v34.misc:AddDropdown("LevelDropdown", {Title="Select Upgrade Level",Description="Choose the level for upgrade",Values={"2","3","4","5","6","7"},Multi=false,Default="2"});
local v70 = v34.misc:AddToggle("AutoUpgradeToggle", {Title="Auto Upgrade Weapon",Default=false});
local function v71()
	while v70.Value do
		v2[3953] = v68.Value;
		v2[3959] = tonumber(v69.Value) or 2;
		if (v2[3953] and (v2[3953] ~= "")) then
			v2[3976] = {[1]={[1]={Type=v2[3953],BuyType="Gems",Weapons={},Event="UpgradeWeapon",Level=v2[3959]},[2]="\n"}};
			game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[3976]));
			task.wait(0.1);
		else
			v30:Notify({Title="Error",Content="Please select a weapon before upgrading.",Duration=5});
			print("ERROR: No weapon selected!");
			break;
		end
	end
end
v70:OnChanged(function(v192)
	if v192 then
		task.spawn(v71);
	end
end);
local v72 = game:GetService("TeleportService");
local v43 = game:GetService("Players");
local v6 = game:GetService("TweenService");
local v63 = v43.LocalPlayer;
local v73 = v63.Character or v63.CharacterAdded:Wait();
local v74 = v7:FindFirstChild("__Extra") and v7.__Extra:FindFirstChild("__Appear");
local v38 = {{Name="Location 1",CFrame=CFrame.new(-6161.25781, 140.639832, 5512.9668)},{Name="Location 2",CFrame=CFrame.new(-5868.44141, 132.70488, 362.519379)},{Name="Location 3",CFrame=CFrame.new(-5430.81006, 107.441559, -5502.25244)},{Name="Location 4",CFrame=CFrame.new(-702.243225, 133.344467, -3538.11646)},{Name="Location 5",CFrame=CFrame.new(450.001709, 117.564827, 3435.4292)},{Name="Location 6",CFrame=CFrame.new(3230.96826, 135.41008, 36.1600113)},{Name="Location 7",CFrame=CFrame.new(4325.36523, 118.995422, -4819.78857)}};
local v75 = game.PlaceId;
local v76 = {};
local v77 = "";
local v78 = os.date("!*t").hour;
local v79 = pcall(function()
	v76 = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"));
end);
if not v79 then
	table.insert(v76, v78);
	writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(v76));
end
function TPReturner()
	v2[4328] = nil;
	if (v77 == "") then
		v2[4328] = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. v75 .. "/servers/Public?sortOrder=Asc&limit=100"));
	else
		v2[4328] = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. v75 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. v77));
	end
	local v194 = "";
	if (v2[4328].nextPageCursor and (v2[4328].nextPageCursor ~= "null") and (v2[4328].nextPageCursor ~= nil)) then
		v77 = v2[4328].nextPageCursor;
	end
	local v195 = 0;
	for v281, v282 in pairs(v2[4328].data) do
		v2[4423] = true;
		v194 = tostring(v282.id);
		if (tonumber(v282.maxPlayers) > tonumber(v282.playing)) then
			for v439, v440 in pairs(v76) do
				if (v195 ~= 0) then
					if (v194 == tostring(v440)) then
						v2[4423] = false;
					end
				elseif (tonumber(v78) ~= tonumber(v440)) then
					v2[4483] = pcall(function()
						delfile("NotSameServers.json");
						v76 = {};
						table.insert(v76, v78);
					end);
				end
				v195 = v195 + 1;
			end
			if v2[4423] then
				table.insert(v76, v194);
				wait();
				pcall(function()
					writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(v76));
					wait();
					game:GetService("TeleportService"):TeleportToPlaceInstance(v75, v194, v43.LocalPlayer);
				end);
				wait(4);
				break;
			end
		end
	end
end
local function v80()
	return v74 and (#v74:GetChildren() > 0);
end
local function v81(v196)
	if (not v73 or not v73:FindFirstChild("HumanoidRootPart")) then
		return;
	end
	v2[4598] = v73.HumanoidRootPart;
	v2[4604] = v6:Create(v2[4598], TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame=v196});
	v2[4604]:Play();
	v2[4604].Completed:Wait();
end
local function v82()
	if not v74 then
		return;
	end
	for v284, v285 in ipairs(v74:GetChildren()) do
		for v341, v342 in ipairs(v285:GetDescendants()) do
			if v342:IsA("ProximityPrompt") then
				fireproximityprompt(v342);
			end
		end
	end
end
local v83 = false;
local function v84()
	v2[4702] = {};
	for v286, v287 in ipairs(v63.leaderstats.Inventory.Mounts:GetChildren()) do
		table.insert(v2[4702], v287.Name:sub(1, 4));
	end
	for v288, v289 in ipairs(v74:GetChildren()) do
		v2[4752] = v289.Name:sub(1, 4);
		for v343, v344 in ipairs(v2[4702]) do
			if (v2[4752] == v344) then
				v30:Notify({Title="Mount Detected!",Content="Matching mount found! Server hopping...",Duration=5});
				TPReturner();
				return;
			end
		end
	end
	for v291, v292 in ipairs(v74:GetChildren()) do
		v2[4805] = v292:GetPivot();
		v81(v2[4805]);
		if v83 then
			task.wait(15);
		end
		v82();
	end
end
local function v85()
	for v294, v295 in ipairs(v38) do
		v81(v295.CFrame);
		task.wait(3);
		if v80() then
			v84();
			v30:Notify({Title="Mount Collected!",Content="Server hopping...",Duration=5});
			TPReturner();
			return;
		end
	end
	TPReturner();
end
local v86 = v34.mount:AddToggle("AutoTeleport", {Title="Auto Find Mount (serverHop)",Default=false});
v86:OnChanged(function(v201)
	if v201 then
		v85();
	end
end);
local v87 = v34.mount:AddToggle("DelayBeforeFire", {Title="Wait 15s ENABLE THIS IF U GET KICKED",Default=false});
v87:OnChanged(function(v202)
	v83 = v202;
end);
local function v88()
	v2[4944] = {};
	v2[4947] = {};
	v2[4950] = game:GetService("Players").LocalPlayer.leaderstats.Inventory.Pets:GetChildren();
	print("Fetching pets...");
	for v296, v297 in ipairs(v2[4950]) do
		v2[4984] = v297:GetAttribute("Name");
		if v2[4984] then
			print("Found Pet:", v2[4984]);
			if not v2[4947][v2[4984]] then
				table.insert(v2[4944], v2[4984]);
				v2[4947][v2[4984]] = true;
			end
		end
	end
	return v2[4944];
end
local v89 = false;
local function v90()
	v2[5031] = game:GetService("Players").LocalPlayer;
	v2[5042] = v2[5031].leaderstats.Inventory.Pets;
	v2[5054] = v2[5031].leaderstats.Values:GetAttribute("MaxEquipPets") or 1;
	v2[5070] = {};
	v2[5073] = {};
	for v299, v300 in ipairs(v2[5042]:GetChildren()) do
		v2[5087] = v300:GetAttribute("Rank");
		if (v2[5087] and (typeof(v2[5087]) == "number")) then
			table.insert(v2[5073], {name=v300.Name,rank=v2[5087]});
		end
	end
	table.sort(v2[5073], function(v302, v303)
		return v302.rank > v303.rank;
	end);
	v2[5140] = 0;
	for v304, v305 in ipairs(v2[5073]) do
		if (v2[5140] < v2[5054]) then
			table.insert(v2[5070], v305.name);
			v2[5140] = v2[5140] + 1;
		else
			break;
		end
	end
	if (#v2[5070] > 0) then
		game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer({{Event="EquipBest",Pets=v2[5070]},"\n"});
	end
end
local v91 = v34.pets:AddToggle("AutoEquip", {Title="Auto Equip Best Pets",Default=false});
v91:OnChanged(function(v214)
	v89 = v214;
	if v214 then
		v30:Notify({Title="Auto Equip",Content="Enabled. Equipping every 2 minutes.",Duration=5});
		task.spawn(function()
			while v89 do
				v90();
				wait(120);
			end
		end);
	else
		v30:Notify({Title="Auto Equip",Content="Disabled.",Duration=5});
	end
end);
v34.Player:AddButton({Title="Boost FPS",Description="Lowers graphics",Callback=function()
	local v215 = {Enabled=false};
	local function v216()
		for v345, v346 in pairs(game:GetDescendants()) do
			if (v346:IsA("ParticleEmitter") or v346:IsA("Smoke") or v346:IsA("Fire") or v346:IsA("Sparkles")) then
				v346.Enabled = not v215.Enabled;
			end
			if (v346:IsA("PostEffect") or v346:IsA("BloomEffect") or v346:IsA("BlurEffect") or v346:IsA("SunRaysEffect")) then
				v346.Enabled = not v215.Enabled;
			end
		end
	end
	local function v217()
		v2[5424] = game:GetService("Lighting");
		if v215.Enabled then
			v2[5424].GlobalShadows = false;
			v2[5424].FogEnd = 9000000000;
			v2[5424].Brightness = 2;
			settings().Rendering.QualityLevel = 1;
			settings().Physics.PhysicsEnvironmentalThrottle = 1;
			settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01;
			settings().Physics.AllowSleep = true;
			settings().Physics.ForceCSGv2 = false;
			settings().Physics.DisableCSGv2 = true;
			settings().Rendering.EagerBulkExecution = true;
			game:GetService("StarterGui"):SetCore("TopbarEnabled", false);
			settings().Network.IncomingReplicationLag = 0;
			settings().Rendering.MaxPartCount = 100000;
		else
			v2[5424].GlobalShadows = true;
			v2[5424].FogEnd = 100000;
			v2[5424].Brightness = 3;
			settings().Rendering.QualityLevel = 7;
			settings().Physics.PhysicsEnvironmentalThrottle = 0;
			settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04;
			settings().Physics.AllowSleep = false;
			settings().Physics.ForceCSGv2 = true;
			settings().Physics.DisableCSGv2 = false;
			settings().Rendering.EagerBulkExecution = false;
			game:GetService("StarterGui"):SetCore("TopbarEnabled", true);
			settings().Network.IncomingReplicationLag = 1;
			settings().Rendering.MaxPartCount = 500000;
		end
	end
	local function v218()
		for v347, v348 in pairs(game:GetDescendants()) do
			if v348:IsA("BasePart") then
				v348.CastShadow = not v215.Enabled;
				v348.Reflectance = (v215.Enabled and 0) or v348.Reflectance;
				v348.Material = (v215.Enabled and Enum.Material.SmoothPlastic) or v348.Material;
			end
			if (v348:IsA("Decal") or v348:IsA("Texture")) then
				v348.Transparency = (v215.Enabled and 1) or 0;
			end
			if v348:IsA("MeshPart") then
				v348.RenderFidelity = (v215.Enabled and Enum.RenderFidelity.Performance) or Enum.RenderFidelity.Precise;
			end
		end
		game:GetService("Debris"):SetAutoCleanupEnabled(true);
	end
	local function v219()
		if v215.Enabled then
			game:GetService("Debris"):AddItem(Instance.new("Model"), 0);
			settings().Physics.ThrottleAdjustTime = 2;
			game:GetService("RunService"):Set3dRenderingEnabled(false);
		else
			game:GetService("RunService"):Set3dRenderingEnabled(true);
		end
	end
	local function v220()
		v215.Enabled = not v215.Enabled;
		v216();
		v217();
		v218();
		v219();
		print("FPS Booster: " .. ((v215.Enabled and "ON") or "OFF"));
	end
	game:GetService("UserInputService").InputBegan:Connect(function(v308)
		if (v308.KeyCode == Enum.KeyCode.RightControl) then
			v220();
		end
	end);
	v220();
	game:GetService("RunService").Heartbeat:Connect(function()
		if v215.Enabled then
			v219();
		end
	end);
end});
local v6 = game:GetService("TweenService");
local v43 = game:GetService("Players");
local v8 = v43.LocalPlayer;
local v9 = v8.Character or v8.CharacterAdded:Wait();
local v10 = v9:WaitForChild("HumanoidRootPart");
local v92 = CFrame.new(3648.76318, 223.552261, 2637.36719, 0.846323907, 7.72368e-18, -0.532668591, -1.1046205e-17, 1, -3.0506537e-18, 0.532668591, 8.465807e-18, 0.846323907);
local function v93()
	v10.CFrame = v92;
end
local v43 = game:GetService("Players");
local v63 = v43.LocalPlayer;
local v94 = 16;
local v95 = 50;
local v96 = false;
local v97 = false;
local function v98()
	if (v63.Character and v63.Character:FindFirstChild("Humanoid")) then
		v2[6323] = v63.Character.Humanoid;
		v2[6323].WalkSpeed = (v96 and v94) or 16;
		v2[6323].JumpPower = (v97 and v95) or 50;
	end
end
local v99 = v34.Player:AddInput("SpeedInput", {Title="Speed",Default=tostring(v94),Placeholder="Enter speed",Numeric=true,Finished=true,Callback=function(v222)
	v94 = tonumber(v222) or 16;
	v98();
end});
local v100 = v34.Player:AddInput("JumpInput", {Title="Jump Power",Default=tostring(v95),Placeholder="Enter jump power",Numeric=true,Finished=true,Callback=function(v223)
	v95 = tonumber(v223) or 50;
	v98();
end});
local v101 = v34.Player:AddToggle("SpeedToggle", {Title="Enable Speed",Default=false});
v101:OnChanged(function(v224)
	v96 = v224;
	v98();
end);
local v102 = v34.Player:AddToggle("JumpToggle", {Title="Enable Jump Power",Default=false});
v102:OnChanged(function(v225)
	v97 = v225;
	v98();
end);
v63.CharacterAdded:Connect(function()
	task.wait(1);
	v98();
end);
v98();
local v8 = game.Players.LocalPlayer;
local function v103(v226)
	if (v8 and v8.Character and v8.Character:FindFirstChild("HumanoidRootPart")) then
		v2[6566] = v8.Character.HumanoidRootPart;
		v2[6575] = game:GetService("TweenService");
		v2[6583] = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
		v2[6605] = v2[6575]:Create(v2[6566], v2[6583], {CFrame=v226});
		v2[6605]:Play();
	end
end
v34.tp:AddButton({Title="Tween to Dedu island",Description="Smoothly moves your character",Callback=function()
	v103(CFrame.new(3859.06299, 60.1228409, 3081.9458, -0.987112403, 6.462064e-7, -0.160028473, 5.633191e-7, 1, 5.633194e-7, 0.160028473, 4.659125e-7, -0.987112403));
end});
local v104 = v34.Player:AddToggle("NoClipToggle", {Title="Enable NoClip",Default=false});
local v105 = false;
v104:OnChanged(function(v227)
	v105 = v227;
	if v105 then
		task.spawn(function()
			while v105 do
				for v459, v460 in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v460:IsA("BasePart") then
						v460.CanCollide = false;
					end
				end
				task.wait();
			end
		end);
	else
		for v420, v421 in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
			if v421:IsA("BasePart") then
				v421.CanCollide = true;
			end
		end
	end
end);
v34.Player:AddButton({Title="Server Hop",Description="Switches to a different server",Callback=function()
	local v228 = game.PlaceId;
	local v229 = {};
	local v230 = "";
	local v231 = os.date("!*t").hour;
	local v232 = pcall(function()
		v229 = game:GetService("HttpService"):JSONDecode(readfile("NotSameServers.json"));
	end);
	if not v232 then
		table.insert(v229, v231);
		writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(v229));
	end
	local function v233()
		v2[6886] = nil;
		if (v230 == "") then
			v2[6886] = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. v228 .. "/servers/Public?sortOrder=Asc&limit=100"));
		else
			v2[6886] = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. v228 .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. v230));
		end
		for v358, v359 in pairs(v2[6886].data) do
			if (tonumber(v359.maxPlayers) > tonumber(v359.playing)) then
				v2[6963] = tostring(v359.id);
				v2[6971] = true;
				for v462, v463 in pairs(v229) do
					if (v2[6963] == tostring(v463)) then
						v2[6971] = false;
						break;
					end
				end
				if v2[6971] then
					table.insert(v229, v2[6963]);
					writefile("NotSameServers.json", game:GetService("HttpService"):JSONEncode(v229));
					game:GetService("TeleportService"):TeleportToPlaceInstance(v228, v2[6963], game.Players.LocalPlayer);
					return;
				end
			end
		end
	end
	v233();
end});
v34.dungeon:AddToggle("AutoBuyDungeonTicket", {Title="Auto Buy Dungeon Ticket",Default=false,Callback=function(v234)
	buyTicketEnabled = v234;
	print("[DEBUG] Auto Buy Dungeon Ticket toggled:", v234);
	if v234 then
		task.spawn(function()
			while buyTicketEnabled do
				v2[7081] = {[1]={[1]={Type="Gems",Event="DungeonAction",Action="BuyTicket"},[2]="\n"}};
				game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[7081]));
				task.wait(5);
			end
		end);
	end
end});
local v106 = game:GetService("Players").LocalPlayer;
local v107 = v106.Character or v106.CharacterAdded:Wait();
local v108 = v107:WaitForChild("HumanoidRootPart");
local v109 = v7:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client");
local v110 = game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent");
local v111 = false;
local v112 = {};
local function v113(v235)
	v2[7215] = v235:FindFirstChild("HealthBar");
	if (v2[7215] and v2[7215]:FindFirstChild("Main") and v2[7215].Main:FindFirstChild("Bar")) then
		v2[7243] = v2[7215].Main.Bar:FindFirstChild("Amount");
		if (v2[7243] and v2[7243]:IsA("TextLabel") and (v2[7243].ContentText == "0 HP")) then
			return true;
		end
	end
	return false;
end
local function v114()
	v2[7284], v2[7285], v2[7286] = nil, nil, nil;
	v2[7291], v2[7292], v2[7293] = math.huge, math.huge, math.huge;
	v2[7307] = v106.Character and v106.Character:GetPivot().Position;
	if not v2[7307] then
		return nil;
	end
	for v310, v311 in ipairs(v109:GetChildren()) do
		if (v311:IsA("Model") and v311:FindFirstChild("HumanoidRootPart")) then
			v2[7357] = v311:GetAttribute("ID");
			if not v112[v311.Name] then
				v2[7374] = (v2[7307] - v311:GetPivot().Position).Magnitude;
				if ((v2[7357] == "JJ2") and (v2[7374] < v2[7291])) then
					v2[7291] = v2[7374];
					v2[7284] = v311;
				elseif ((v2[7357] == "JJ3") and (v2[7374] < v2[7292])) then
					v2[7292] = v2[7374];
					v2[7285] = v311;
				elseif ((v2[7357] == "JJ4") and (v2[7374] < v2[7293])) then
					v2[7293] = v2[7374];
					v2[7286] = v311;
				end
			end
		end
	end
	return v2[7284] or v2[7285] or v2[7286];
end
local function v115()
	v2[7454] = {[1]={[1]={Event="ShowPets"},[2]="\t"}};
	game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[7454]));
end
local function v116()
	while v111 do
		v2[7501] = v114();
		while v111 and v2[7501] do
			if not v2[7501].Parent then
				break;
			end
			v2[7518] = v2[7501]:FindFirstChild("HumanoidRootPart");
			v2[7526] = v106.Character and v106.Character:FindFirstChild("HumanoidRootPart");
			if (v2[7518] and v2[7526]) then
				v2[7526].CFrame = v2[7518].CFrame * CFrame.new(0, 0, 6);
				task.wait(0.5);
				v115();
				v110:FireServer({{PetPos={},AttackType="All",Event="Attack",Enemy=v2[7501].Name},"\7"});
				while v111 and v2[7501].Parent do
					if v113(v2[7501]) then
						v112[v2[7501].Name] = true;
						break;
					end
					task.wait(0.1);
					v2[7638] = v114();
					if (v2[7638] and (v2[7638]:GetAttribute("ID") == "JJ2") and (v2[7638] ~= v2[7501])) then
						break;
					elseif (v2[7638] and (v2[7638]:GetAttribute("ID") == "JJ3") and (v2[7501]:GetAttribute("ID") == "JJ4")) then
						break;
					end
				end
			end
			v2[7501] = v114();
		end
		task.wait(0.2);
	end
end
v34.Main:AddToggle("AutoFarmToggle", {Title="auto Jeju farm",Default=false,Callback=function(v246)
	v111 = v246;
	if v246 then
		task.spawn(v116);
	end
end});
local v43 = game:GetService("Players");
local v44 = game:GetService("ReplicatedStorage");
local v63 = v43.LocalPlayer;
local v117 = v63:FindFirstChild("leaderstats") and v63.leaderstats:FindFirstChild("Inventory");
local v118 = 1;
local v119 = false;
local v35 = v34.misc:AddDropdown("WeaponLevel", {Title="Select Weapon Level",Values={"1","2","4","5","6","7"},Multi=false,Default="1"});
v35:OnChanged(function(v247)
	v118 = tonumber(v247);
end);
local v91 = v34.misc:AddToggle("AutoSell", {Title="Auto-Sell Weapons",Default=false});
v91:OnChanged(function(v248)
	v119 = v248;
end);
local function v120()
	if (not v117 or not v119) then
		return;
	end
	for v313, v314 in ipairs(v117.Weapons:GetChildren()) do
		v2[7887] = v314:GetAttribute("Level");
		if (v2[7887] == v118) then
			v2[7900] = {[1]={[1]={Action="Sell",Event="WeaponAction",Name=v314.Name},[2]="\n"}};
			v44:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[7900]));
		end
	end
end
task.spawn(function()
	while task.wait(0.5) do
		if v119 then
			v120();
		end
	end
end);
local v121 = v34.dungeon:AddToggle("AutoEnterDungeon", {Title="Auto Enter Guild Dungeon",Default=false});
local function v122()
	while v121.Value do
		v2[7992] = {[1]={[1]={Event="DungeonAction",Action="TestEnter"},[2]="\n"}};
		game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(v2[7992]));
		task.wait(0.5);
	end
end
v121:OnChanged(function(v249)
	if v249 then
		task.spawn(v122);
	end
end);
v34.Discord:AddParagraph({Title="🎉 Welcome to Kazona Hub",Content=" Xin Chào Các Friend Đây Là Script Free Tôi Làm Chơi Chơi Mong Ae Góp Ý"});
v34.Discord:AddButton({Title="Copy Discord Link",Description="Copies the Discord invite link to clipboard",Callback=function()
	setclipboard("https://discord.gg/W77Vj2HNBA");
	v30:Notify({Title="Copied!",Content="Discord link copied to clipboard.",Duration=3});
end});
v31:SetLibrary(v30);
v32:SetLibrary(v30);
v32:SetFolder("KazonaScriptHub");
v31:SetFolder("KazonaScriptHub/AriseCrossover");
v32:BuildInterfaceSection(v34.Settings);
v31:BuildConfigSection(v34.Settings);
v33:SelectTab(1);
v30:Notify({Title="Kazona Hub",Content="Script Loaded!",Duration=3});
v31:LoadAutoloadConfig();
repeat
	task.wait(0.25);
until game:IsLoaded() 
getgenv().Image = "rbxassetid://90870073103155";
getgenv().ToggleUI = "LeftControl";
task.spawn(function()
	if (not getgenv().LoadedMobileUI == true) then
		getgenv().LoadedMobileUI = true;
		v2[8242] = Instance.new("ScreenGui");
		v2[8250] = Instance.new("ImageButton");
		v2[8258] = Instance.new("UICorner");
		v2[8242].Name = "OpenUI";
		v2[8242].Parent = game:GetService("CoreGui");
		v2[8242].ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
		v2[8250].Parent = v2[8242];
		v2[8250].BackgroundColor3 = Color3.fromRGB(105, 105, 105);
		v2[8250].BackgroundTransparency = 0.8;
		v2[8250].Position = UDim2.new(0.9, 0, 0.1, 0);
		v2[8250].Size = UDim2.new(0, 50, 0, 50);
		v2[8250].Image = getgenv().Image;
		v2[8250].Draggable = true;
		v2[8250].Transparency = 1;
		v2[8258].CornerRadius = UDim.new(0, 200);
		v2[8258].Parent = v2[8250];
		v2[8250].MouseButton1Click:Connect(function()
			game:GetService("VirtualInputManager"):SendKeyEvent(true, getgenv().ToggleUI, false, game);
		end);
	end
end);