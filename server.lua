--------------------
--- Badssentials ---
--------------------

--@desc Sends a message to the client
--@param src The player you want to send the message to
--@param msg The message to send
function sendMsg(src, msg)
  TriggerClientEvent('chat:addMessage', src, {args = {Config.Prefix .. msg} });
end

--@desc Checks if a passed ID is an online player
--@param playerID The ID you want to check.
function IsPlayerOnline(playerID)
  for _, ID in pairs(GetPlayers()) do
    if tonumber(ID) == tonumber(playerID) then
      return true
    end
  end

  --Player not found
  return false
end

--export
function GetAOP()
  return currentAOP
end

--export
function GetPeaceTimeStatus()
  return peacetime
end

--Makes sure resource name is 'Badssentials' so any scripts using exports won't throw errors.
if GetCurrentResourceName() ~= "Badssentials" then
  print("[" .. GetCurrentResourceName() .. "] ^3WARNING: This resource needs to be named '^0Badssentials^3' in order for everything to function correctly! Please change this resource's name back to '^0Badssentials^3'!")
end

if Config.Misc.usingLegacyFuel and (GetResourceState("LegacyFuel") ~= 'started' or 'starting') then
  print("[" .. GetCurrentResourceName() .. "] ^3WARNING: `^0usingLegacyFuel = true^3` but LegacyFuel could not be found! Make sure LegacyFuel is installed, started, and named '^0LegacyFuel^3!")
end

RegisterCommand(Config.ScreenAffects.AnnounceCommand, function(source, args, raw) 
  local src = source;
  if IsPlayerAceAllowed(src, Config.ScreenAffects.AcePermission) then 
    -- Allowed to use /announce 
    if #args > 0 then 
      local ann = table.concat(args, " ");
      TriggerClientEvent('Badssentials:Announce', -1, ann);
    end
  end
end)

Citizen.CreateThread(function()
  while true do 
    Wait(1000);
    TriggerClientEvent('Badssentials:SetAOP', -1, currentAOP);
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);

    local time = format_time(os.time(), "%H:%M", "+05:00", "");
    local date = format_time(os.time(), "%m %d %Y", "local", "");
    local timeHour = split(time, ":")[1]
    local dateData = split(date, " ");

    TriggerClientEvent('Badssentials:SetMonth', -1, dateData[1])
    TriggerClientEvent('Badssentials:SetDay', -1, dateData[2])
    TriggerClientEvent('Badssentials:SetYear', -1, dateData[3])

    if tonumber(timeHour) > 12 then 
      local timeStr = tostring(tonumber(timeHour) - 12) .. ":" .. split(time, ":")[2]
      TriggerClientEvent('Badssentials:SetTime', -1, timeStr);
    end

    if timeHour == "00" then 
      local timeStr = "12" .. ":" .. split(time, ":")[2]
      TriggerClientEvent('Badssentials:SetTime', -1, timeStr);
    end 

    if timeHour ~= "00" and tonumber(timeHour) <= 12 then 
      TriggerClientEvent('Badssentials:SetTime', -1, time);
    end
  end
end)
peacetime = false;
currentAOP = Config.AOPSystem.DefaultAOP; -- By default 

--Sets Map Name on resource start
if Config.AOPSystem.SetMapNameAsAOP then
  Citizen.CreateThread(function()
    Wait(1500) 
    SetMapName(currentAOP)
  end)
end

RegisterCommand(Config.AOPSystem.AOPCommand, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, Config.AOPSystem.AOP_AcePermission) then 
    -- Allowed to use /aop <aop>
    if #args > 0 then 
      currentAOP = table.concat(args, " ");
      sendMsg(src, "You have set the AOP to: " .. currentAOP);
      TriggerClientEvent('Badssentials:SetAOP', -1, currentAOP);

      if Config.SetMapNameAsAOP then
        SetMapName(currentAOP)
      end

      if Config.AOPSystem.AOP_Announcement ~= nil then
        local aopAnnouncement = Config.AOPSystem.AOP_Announcement
        aopAnnouncement = aopAnnouncement:gsub("{NEW_AOP}", currentAOP)

        sendMsg(-1, aopAnnouncement)
      end
    else 
      -- Not enough arguments
      sendMsg(src, "^1ERROR: Proper usage: /" .. Config.AOPSystem.AOPCommand .. " <zone>");
    end
  else
    sendMsg(src, "^1ERROR: You do not have permission to change the AOP!");
  end
end)

timersRev = {}
timersRes = {}

if Config.ReviveSystem.enable then
  
  AddEventHandler("txAdmin:events:healedPlayer", function(eventData)
    local id = eventData.id
    if id == -1 or id == "-1" then
      timersRes = {}
      timersRev = {}
    else
      timersRes[id] = nil
      timersRev[id] = nil
    end
  end)

  Citizen.CreateThread(function()
    while true do 
      Wait((1000)); -- Each second 
      for src, timer in pairs(timersRev) do 
        timersRev[src] = timer - 1;
        if (timersRev[src] <= 0) then 
          timersRev[src] = nil;
        end
      end
      for src, timer in pairs(timersRes) do 
        timersRes[src] = timer - 1;
        if (timersRes[src] <= 0) then 
          timersRes[src] = nil;
        end
      end
    end
  end)

  RegisterNetEvent("Badssentials:DeathTrigger")
  AddEventHandler("Badssentials:DeathTrigger", function()
    local src = source;
    if Config.ReviveSystem.EnablePEAIntergration[1] and exports["PoliceEMSActivity"]:IsPlayerOnDuty(src) then
      timersRev[src] = Config.ReviveSystem.EnablePEAIntergration[2]
      timersRes[src] = Config.ReviveSystem.EnablePEAIntergration[3]
    else
      timersRev[src] = Config.ReviveSystem.Revive_Delay;
      timersRes[src] = Config.ReviveSystem.Respawn_Delay;
    end
    
  end)

  RegisterCommand(Config.ReviveSystem.ReviveCommand, function(source, args, rawCommand)
    local src = source;
    if #args == 0 or tonumber(args[1]) == src then 
      -- Revive themselves
      if timersRev[src] ~= nil and timersRev[src] >= 0 then 
        -- They are dead and have a timer 
        if IsPlayerAceAllowed(src, Config.ReviveSystem.BypassReviveAcePermission) or IsPlayerInBypassArea(src) then 
          -- Can bypass reviving

          TriggerClientEvent('Badssentials:RevivePlayer', src);
        else 
          -- Cannot bypass reviving, send they need to wait and what their timer is at 
          local timeLeft = timersRev[src]
          if timeLeft >= 60 then
            timeLeft = math.ceil(timeLeft / 60) .. " minute(s)" 
          else
            timeLeft = timeLeft .. " seconds"
          end

          local errorMessage = Config.ReviveSystem.ReviveErrorMessage
          errorMessage = errorMessage:gsub("{REVIVE_TIME_LEFT}", timeLeft)

          sendMsg(src, errorMessage);
        end
      else 
        -- Their timer is expired or not valid 
        TriggerClientEvent('Badssentials:RevivePlayer', src); 
      end
    else 
      -- They are reviving someone else 
      if IsPlayerAceAllowed(src, Config.ReviveSystem.ReviveOthersAcePermission) then
        --Checks if arg is number
        if IsInt(args[1]) then 
          --checks if a player with ID is online
          if IsPlayerOnline(args[1]) then
            local reviveMessage = Config.ReviveSystem.ReviveOthersMessage
            reviveMessage = reviveMessage:gsub("{PLAYER_NAME}", GetPlayerName(src))

            local reviveOtherMessage = Config.ReviveSystem.ReviveOtherSuccessMessage
            reviveOtherMessage = reviveOtherMessage:gsub("{PLAYER_NAME}", GetPlayerName(tonumber(args[1])))

            TriggerClientEvent('Badssentials:RevivePlayer', tonumber(args[1]));

            sendMsg(src, reviveOtherMessage);
            sendMsg(tonumber(args[1]), reviveMessage);
          else
            --Player isn't online
            sendMsg(src, "^1ERROR: No player with that specified ID is online!");
          end
        else
          --Passed Arg is not integer
          sendMsg(src, "^1ERROR: You must specify a valid server ID!");
        end
      else --No permission
        sendMsg(src, '^1ERROR: You do not have permission to revive others!');
      end
    end
  end)
  RegisterCommand(Config.ReviveSystem.RespawnCommand, function(source, args, rawCommand)
    local src = source;
    if #args == 0 then 
      -- Respawn themselves
      if timersRes[src] ~= nil and timersRes[src] >= 0 then 
        -- They are dead and have a timer 
        if IsPlayerAceAllowed(src, Config.ReviveSystem.BypassRespawnAcePermission) or IsPlayerInBypassArea(src) then 
          -- Can bypass reviving
          TriggerClientEvent('Badssentials:RespawnPlayer', src);
        else 
          -- Cannot bypass reviving, send they need to wait and what their timer is at 
          local timeLeft = timersRes[src]
          if timeLeft >= 60 then
            timeLeft = math.ceil(timeLeft / 60) .. " minute(s)" 
          else
            timeLeft = timeLeft .. " seconds"
          end

          local errorMessage = Config.ReviveSystem.RespawnErrorMessage
          errorMessage = errorMessage:gsub("{RESPAWN_TIME_LEFT}", timeLeft)

          sendMsg(src, errorMessage);
        end
      else 
        -- Their timer is expired or not valid 
        TriggerClientEvent('Badssentials:RespawnPlayer', src); 
      end
    end 
  end)
end


RegisterCommand(Config.Misc.Peacetime, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, Config.Misc.PeacetimeAcePermission) then
    peacetime = not peacetime;
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);
    if peacetime then 
      sendMsg(src, "You have set PeaceTime to ^2ON"); 
    else 
      sendMsg(src, "You have set PeaceTime to ^1OFF");
    end
  end
end)
RegisterCommand(Config.Misc.PT, function(source, args, rawCommand)
  local src = source;
  if IsPlayerAceAllowed(src, Config.Misc.PeacetimeAcePermission) then
    peacetime = not peacetime;
    TriggerClientEvent('Badssentials:SetPT', -1, peacetime);
    if peacetime then 
      sendMsg(src, "You have set PeaceTime to ^2ON"); 
    else 
      sendMsg(src, "You have set PeaceTime to ^1OFF");
    end
  end
end)
function split(source, sep)
    local result, i = {}, 1
    while true do
        local a, b = source:find(sep)
        if not a then break end
        local candidat = source:sub(1, a - 1)
        if candidat ~= "" then 
            result[i] = candidat
        end i=i+1
        source = source:sub(b + 1)
    end
    if source ~= "" then 
        result[i] = source
    end
    return result
end
function format_time(timestamp, format, tzoffset, tzname)
   if tzoffset == "local" then  -- calculate local time zone (for the server)
      local now = os.time()
      local local_t = os.date("*t", now)
      local utc_t = os.date("!*t", now)
      local delta = (local_t.hour - utc_t.hour)*60 + (local_t.min - utc_t.min)
      local h, m = math.modf( delta / 60)
      tzoffset = string.format("%+.4d", 100 * h + 60 * m)
   end
   tzoffset = tzoffset or "GMT"
   format = format:gsub("%%z", tzname or tzoffset)
   if tzoffset == "GMT" then
      tzoffset = "+0000"
   end
   tzoffset = tzoffset:gsub(":", "")

   local sign = 1
   if tzoffset:sub(1,1) == "-" then
      sign = -1
      tzoffset = tzoffset:sub(2)
   elseif tzoffset:sub(1,1) == "+" then
      tzoffset = tzoffset:sub(2)
   end
   tzoffset = sign * (tonumber(tzoffset:sub(1,2))*60 + tonumber(tzoffset:sub(3,4)))*60

   return os.date(format, timestamp + tzoffset)
end