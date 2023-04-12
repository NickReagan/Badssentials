-- @desc calculate xy distance between two vectors
-- @param vector1 the first vector
-- @param vector2 the second vector
function DistanceCalc (vector1, vector2)
    local dx = vector1.x - vector2.x
    local dy = vector1.y - vector2.y

    local r = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))

    return math.floor(r)
end

-- @desc Check if value is an integer
-- @param number the variable you want to check 
function IsInt(number)
    if number == tostring(tonumber(number)) then
        return true
    else
        return false
    end
end

function IsPlayerInBypassArea(player)
    local PlayerPos = GetEntityCoords(GetPlayerPed(player))
    for name, i in pairs(Config.ReviveSystem.BypassLocations) do
        if Config.ReviveSystem.enableBypassLocations and DistanceCalc(PlayerPos, vector3(i.x, i.y, i.z)) <= i.radius then
            return true
        end
    end
    return false
  end