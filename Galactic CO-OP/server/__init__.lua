local SetTimeout = require "common/timer".SetTimeout
local levelData = require "common/levelData"
local kitList = require "common/kit_list".Kits

-- ***************  CONFIG  *************** --


	-- BALANCING SETTINGS --
	
-- The maximum number of enemy bots that can spawn
-- Suggested bot counts: Co-Op XL - 32, Co-Op - 20
-- (Adjustable with a command at runtime)
local maxEnemyBotCount = 20

-- The method used for bot balancing
-- default -- (RECCOMENDED) is a method that uses botRatio and some other calculations to try to adjust the proper bot count for both teams depending on the player amount. It will reach maxEnemyBotCount, once the server reaches maxPlayerCount.
-- simple -- Always keeps the enemy bot amount to the amount defined in maxEnemyBotCount, and strictly follows the botRatio for team ratios
-- old -- Uses the old balancing method (from V0.6 and older). It's very outdated; strictly follows botRatio while dynamically adjusting the bot counts for both teams. The amount of enemy bots will reach maxEnemyBotCount once the player count achieves maxPlayerCount. The modern equivalent is now called "deafult"
-- identical -- Always balances both teams to maxEnemyBotCount. Does NOT use botRatio.
-- nil -- Turns off balancing, not spawning any bots
-- (Adjustable with a command at runtime) W.I.P
local teamBalancingMethod = "default"

-- The ratio of bots between teams, the way it's used is decided by the Team Balancing Method
-- Do not change unless you know what you're doing
local botRatio = (5/8)

-- A value used by team balancing; the amount of players at which enemy bots reach the max amount (on default team balancing)
-- Set it to your Kyber Server's Max Player Count if you don't know what to do
local maxPlayerCount = 8

-- Makes the player team alternate between 1 and 2, instead of being picked radomly
-- This prevents one side being played multiple times in a row 
local alternatingTeams = false


	-- BOT SETTINGS --

-- W.I.P Disable bots from picking heroes on the player team
local disableFriendlyHeroes = false -- THIS FEATURE IS BROKEM, FEEL FREE TO INVESTIGATE IT YOURSELF

-- A value in percents, that determines the probability that a bot will pick a hero, if it can afford it. (eg. 100 = 100%, 25 = 25%)
-- Setting this value to 0 will disable bots from being able to pick heroes at all.
local heroSpawnPercentage = 25

-- Rewarding bots for killing players
-- The amount of extra battlepoints that a bot will be granted upon defeating a real player.
local playerKillReward = 1500

-- Determines the aim noise of the bots, basically "bot difficulty"
-- Easy: 12, Medium: 9, Hard: 6, Knight: 3, Master: 1, Aimbot: 0
-- Setting this value to nil will disable the Bot AimNoiseScale Fix, reenabling the Bot Personalities built into IOI, making bots have a diffrent Aim Noise Scale through the entire lenght of the match, that cannot be adjusted by hosts/plugins
-- (Adjustable with a command at runtime)
local aimNoiseScale = 4

-- Determines how long it will take a bot to turn around (turning speed)
-- The higher the value, the faster bots rotate
-- The deafult value in IOI is 0.25
local aimLapTime = 3.5

-- Determines the reaction time of bots (in seconds)
-- The deafult value in IOI is 0.25
local reactionTime = 0.25

-- A value in percentage that defines how much worse the friendly bot's aim is
-- Setting this value to 0 will make friendly bots have the exact same noise scale as enemy bots
local worseFriendlyAimPercentage = 50

-- The amount of time it take a bot to respawn (in seconds)
-- The deafult in BF+ is 9
local respawnTime = 15

-- The amount (in seconds) that bots spawn quicker in per player
-- Setting it to 0 wil disable the feature
local decreaseRespawnTimePerPlayer = 0


	-- GAME START SETTINGS --

-- Determines if the game starts automatically or not
local gameAutoStart = true

-- Determines if the game should always start, even with no players online
local alwaysAutoStart = true

-- A value in seconds that determines how fast the game should start
-- I do not reccomend values below 25
local gameStartDelay = 45

-- Determines if the plugin will message the players in chat about the game starting
local gameStartMessage = true




-- ***************  CODE  *************** --



local PlayerTeam = nil -- The variable that stores the team that players are going to be balanced to. (1 = Lightside, 2 = Darkside)
local currentFactionsTable = nil
local customGunList = nil -- impossible with the current release of Kyber

local gameRunning = false
local messageShown = false
local startTimeoutRunning = false


	-- BASIC FUNCTIONS -- 


-- A simple function that returns the enemy team ID
function EnemyTeam()
	if PlayerTeam == 1 then
		return 2
	end
	if PlayerTeam == 2 then
		return 1
	end
end

-- Moves a specified player to the correct team, credits to Geeknasty: https://github.com/Geeknasty
function MovePlayerToCorrectTeam(player)
    if player.isBot or not player.team then return end

    if player.team ~= PlayerTeam then
        player:SetTeam(PlayerTeam)
    end
end

-- Moves all online players to the correct team, credits to Geeknasty: https://github.com/Geeknasty
function MoveAllPlayersToCorrectTeam()
    local players = PlayerManager.GetPlayers()
    for _, player in ipairs(players) do
        MovePlayerToCorrectTeam(player, PlayerTeam)
    end
end

-- A function that disables the default team balancing
function DisableTeamBalancing()
	Console.Execute("Kyber.DisableTeamBalancing true")
    Console.Execute("Whiteshark.AutoBalanceTeamsOnNeutral false")
end

-- A simple function that counts up and returns the current number of online human players
function GetPlayerCount()
	local count = 0
	for _, player in ipairs(PlayerManager.GetPlayers()) do
		if not player.isBot then
			count = count + 1
		end
	end
	return count
end

-- Spawns a specified amount of bots on the specified team
function FillBots(team, amount)
	-- I had to use a variable, because of how Lua Syntax works
	local variable = ("ForceFillGameplayBotsTeam" .. team)
	Console.GetSettings("AutoPlayers")[variable] = amount
	
	-- Why use GetSettings instead of Execute?
	-- Mainly because it doesn't spam the logs
end

	-- START GAME FUNCTIONS --


-- The actual function for starting the game, called internally by the start game logic (StartGame())
function _StartGame()
	Console.Execute("Kyber.StartGame")
	gameRunning = true
	startTimeoutRunning = false
end

-- WAY too complicated GameStart logic
function StartGame(forced)
	-- Starting the game when the config allows it to
	-- I will not bother to explain this, investigate at the risk of your own sanity
	if gameAutoStart then
		startTimeoutRunning = true
		if alwaysAutoStart then
			if forced then
				return
			end
			SetTimeout(function()
			_StartGame()
			end, gameStartDelay)
		else
			SetTimeout(function()
			playerCount = GetPlayerCount()
			if (playerCount > 0 or forced) and not gameRunning and not startTimeoutRunning then
				_StartGame()
			end
			if playerCount == 0 and not forced then
				messageShown = false
			end
			end, gameStartDelay)
		end
	end
	
	-- Messaging in chat when the config allows it
	if gameStartMessage and not gameRunning and not messageShown then
		Console.Execute(string.format("Kyber.Broadcast **KYBER:** Starting game in " .. gameStartDelay .. " seconds."))
		messageShown = true
	end
end


-- Choosing the team that the players are in (randomly).
function ChoosePlayerTeam(levelName)
	-- Making Geonosis clone-only, because bots can't enter AT-TEs (making the Darkside unplayable)
	if levelName == "S5_1/Levels/MP/Geonosis_01/Geonosis_01" then
		PlayerTeam = 1
	else
		-- Choosing the correct method for choosing teams
		if alternatingTeams then -- If teams need to alternate (diffrent team each round)
			if PlayerTeam == 1 then
				PlayerTeam = 2
			elseif PlayerTeam == 2 then
				PlayerTeam = 1
			end
		else -- If teams don't need to alternate
			PlayerTeam = math.random(1, 2) -- Randomizing the player team
		end
	end
end


	-- BOT FUNCTIONS --


-- Applies bot settings, including Hero Spawn Percentage and Aim Noise Scale
-- Gets called on Level:Loaded and during some Custom Console Commands
function BotSettings()
	Console.GetSettings("AutoPlayers").HeroSpawnProbability_Gameplay = (heroSpawnPercentage / 100)
	Console.GetSettings("AutoPlayers").AimLapTime = aimLapTime
	Console.GetSettings("AutoPlayers").LofReactionTimeS = reactionTime
	Console.GetSettings("AutoPlayers").RespawnDelay = (respawnTime - 3) -- Subtracting 3 because GA has an extra 3 seconds on top of RespawnDelay
	
	CalculateBotAim()
end

-- Calculates the Aim Inaccuracy for bots
function CalculateBotAim()
	-- Okay so the way this works is that AimNoiseScaleTeam1 and AimNoiseScaleTeam2 act as a multiplier on top of AimNoiseScale
	-- So all I did is set AimNoiseScale to my desired number, and then applied the worseFriendlyAimPercentage on top of that as a modifier
	
	-- Applying the Aim Noise Scale
	Console.GetSettings("AutoPlayers").AimNoiseScale = aimNoiseScale 
	
	-- Applying a modifier of x1 to the Player Team, making the player team just have the normal AimNoiseScale.
	local variable = ("AimNoiseScaleTeam" .. EnemyTeam())
	Console.GetSettings("AutoPlayers")[variable] = 1
	
	-- Applies worseFriendlyAimPercentage onto the Aim Noise Scale for the enemy tean
	variable = ("AimNoiseScaleTeam" .. PlayerTeam)
	Console.GetSettings("AutoPlayers")[variable] = ((worseFriendlyAimPercentage / 100) + 1) -- deviding by 100, because the config value is in percents while Kyber accepts fractions
end

-- This function chooses the correct Team Balancing Method and spawns the correct amount of bots accordingly.
function BalanceBots()
	local playerCount = GetPlayerCount()
	
	-- Deafult balancing method
	if teamBalancingMethod == "default" then
		if playerCount <= maxPlayerCount then
			local desiredFriendlyBotCount = math.floor(math.floor((maxEnemyBotCount * botRatio) + 0.5) - ((maxPlayerCount - playerCount) * 0.5))
			
			FillBots(PlayerTeam, (desiredFriendlyBotCount - playerCount))
			FillBots(EnemyTeam(), math.min(maxEnemyBotCount - (maxPlayerCount - playerCount), maxEnemyBotCount))
		else
			FillBots(PlayerTeam, (math.floor((maxEnemyBotCount * botRatio) + 0.5) - playerCount))
			FillBots(EnemyTeam(), enemyBotCount)
		end
		
	-- Simpler but outdated balancing method, uses maxEnemyBotCount and maxPlayerCount, while strictly following botRatio
	elseif teamBalancingMethod == "old" then
		if playerCount <= maxPlayerCount then
			FillBots(EnemyTeam(), (maxEnemyBotCount - (maxPlayerCount - playerCount)))
			FillBots(PlayerTeam, ((math.floor((maxEnemyBotCount * botRatio) + 0.5)) - (maxPlayerCount - playerCount)))
		else
			FillBots(PlayerTeam, (math.floor((maxEnemyBotCount * botRatio) + 0.5) - playerCount))
			FillBots(EnemyTeam(), enemyBotCount)
		end
		
	-- Even simpler balancing method; strictly follows both maxEnemyBotCount and botRatio
	elseif teamBalancingMethod == "simple" then
		FillBots(EnemyTeam(), maxEnemyBotCount)
		FillBots(PlayerTeam, (math.floor((maxEnemyBotCount * botRatio) + 0.5) - (maxPlayerCount - playerCount)))
		
	-- Identical Team balancing method; doesn't use botRatio, strictly follows maxEnemyBotCount for both teams
	elseif teamBalancingMethod == "identical" then
		FillBots(EnemyTeam(), maxEnemyBotCount)
		FillBots(PlayerTeam, maxEnemyBotCount - playerCount)
	end
	
	-- You can learn more about the diffrent balancing methods in the config found at the beggening of this file.
end


	-- WEAPON LOADOUT / GUN LIST FUNCTIONS --
	-- Sadly, because of the current limitations of Kyber, I am not able to modify the weapons of Bots. --
	-- If one day Kyber devs decide to make SetWeapon for for Autoplayers (bots), this part of the code will actually start to function --
	-- For now, it's just useless... --


function GetFactions(levelName)
	for eraIndex, mapGroup in ipairs(levelData.Maps) do
		for _, mapName in ipairs(mapGroup) do
			if mapName == levelName then
				return levelData.Factions[eraIndex]
			end
		end
	end
	print("GetFactions: no match found for level '" .. tostring(levelName) .. "'. Check common/levelData.lua.")
	return nil
end

function _RollWeapon(readyWeaponsTable)
    local roll = math.random(1, 1000)
    local weaponRarity = nil

    if roll <= 979 then
        weaponRarity = 1
    elseif roll <= 999 then
        weaponRarity = 2
    else
        weaponRarity = 3
    end
	
	local rolledWeapon = readyWeaponsTable[weaponRarity][math.random(#readyWeaponsTable[weaponRarity])]
	print("		" .. rolledWeapon)
    return rolledWeapon
end
function ChooseWeapon(serverPlayerObject)
	local gunList = require("common/" .. customGunList)
	local faction = currentFactionsTable[serverPlayerObject.team]
	local weaponsTable = gunList[faction]
	
	
	for i, classTable in ipairs(kitList) do -- classTable is a table with 4 weapon tables for each class
		for _, kitName in ipairs(classTable) do
			if serverPlayerObject.activeKit.name == kitName then
				serverPlayerObject:SetWeapon(_RollWeapon(weaponsTable[i]))
				break
			end
		end
	end
end


	-- EVENT LISTENERS --


-- This event fires every time a new map is loaded
EventManager.Listen("Level:Loaded", function(levelName, gameModeId)
	gameRunning = false
	messageShown = false
	startTimeoutRunning = false
	
	DisableTeamBalancing()
	ChoosePlayerTeam(levelName)
	currentFactionsTable = GetFactions(levelName)
	
	-- Setting bot settings
	SetTimeout(function()
		BotSettings()
	end, (gameStartDelay + 20))	
	
	-- Moving all players to the correct team
	SetTimeout(function()
		MoveAllPlayersToCorrectTeam()
	end, (gameStartDelay / 2) )	
	-- Running it twice to ensure that everyone is on the correct team (sometimes it fails)
	SetTimeout(function()
		MoveAllPlayersToCorrectTeam()
	end, (gameStartDelay * 2) )	
	
	-- Spawning in bots
	SetTimeout(function()
	BalanceBots()
	end, gameStartDelay + 2) -- Spawning them right as the game starts, so they can't run out of the spawn before normal players
	
	StartGame() -- Running game start logic
end)

-- This event fires whenever a player joins the server
EventManager.Listen("ServerPlayer:Joined", function(player)
	SetTimeout(function()
		MovePlayerToCorrectTeam(player) -- Moving the player to the correct team (with a 5 second delay for safety reasons)
	end, 5.0)
	if gameRunning then
		BalanceBots() -- Balancing bots to the correct amount (adapting to the new player count)
	end
	StartGame(true) -- Starting the game
end)

-- This event fires when a player leaves the game
EventManager.Listen("ServerPlayer:Disconnect", function(player)
	if gameRunning then
		BalanceBots() -- Balancing bots when a player leaves
	end
end)

-- This event fires when a player spanws
EventManager.Listen("ServerPlayer:Spawned", function(player)
	if player.isBot then
		CalculateBotAim() -- Setting the bot difficulty (IOI V7 Fix)
		if customGunList then -- Applying the custom gun list (like I mentioned before, this feature doesn't work with the current release of Kyber)
			ChooseWeapon(player)
		end
	end
end)

-- This event fires whenever a player or bot dies
EventManager.Listen("ServerPlayer:Killed", function(victim, killer, killerWeaponName)
    if playerKillReward ~= 0 and (killer and victim) and (killer.isBot and not victim.isBot) then -- Granting a bot extra battlepoints for killing a player, if playerKillReward is set to a value other than 0
		killer:GiveBattlepoints(playerKillReward)
	end
	
	-- THIS FEATURE IS BROKEN
	if disableFriendlyHeroes and victim.isBot and victim.team == PlayerTeam and victim.battlepoints >= 4000 then
		victim:SetBattlepoints(2000) -- Setting the bot's Battlepoints to 2000 after they die if disableFriendlyHeroes, to prevent them from buying a hero. -- Setting it to that number, so they can still afford most reinforcements -- Keep in mind that the bots only use the Battlepoint system on Mophead's IOI mod.
	end
	
end)




	-- CUSTOM CONSOLE COMMANDS --


Console.Register("Galactic", "EnemyBotCount", "Changes the max enemy bot amount.", {}, function(self, args)
	local count = tonumber(args)
	
	if count == nil then
		return
	end
	
	maxEnemyBotCount = count
	
	BalanceBots()
end)

Console.Register("Galactic", "AimNoiseScale", "Changes the aim noise scale of Autoplayers.", {}, function(self, args)
	local scale = tonumber(args)
	
	if scale == nil then
		return
	end
	
	aimNoiseScale = scale
	CalculateBotAim()
end)

Console.Register("Galactic", "PlayerTeam", "Changes the team that players are in.", {}, function(self, args)
	local number = tonumber(args)
	
	if number > 2 or number < 1 then
		return
	end
	PlayerTeam = number
	
	MoveAllPlayersToCorrectTeam()
	BalanceBots()
	
	Console.Execute(string.format("Kyber.Broadcast **KYBER:** Changing player team to " .. number))
end)

Console.Register("Galactic", "HeroSpawnPercentage", "Lets you change the Hero Spawn Percentage. Values from 0 to 1.", {}, function(self, args)
	local number = tonumber(args)
	
	if number > 1 then
		number = 1
	end
	
	heroSpawnPercentage = number * 100
	
	-- Running it twice to avoid problems (for some reason the setting doesn't work if loaded too early (at least at Level:Loaded)
	BotSettings()
	SetTimeout(function()
		BotSettings()
	end, 60.0)	
end)

Console.Register("Galactic", "WorseFriendlyAimNoise", "Changes the aim noise scale of friendly Autoplayers.", {}, function(self, args)
	local scale = tonumber(args)
	
	if scale == nil then
		return
	end
	
	worseFriendlyAimPercentage = scale
	CalculateBotAim()
end)