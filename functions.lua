-- @desc calculate xy distance between two vectors
-- @param vector1 the first vector
-- @param vector2 the second vector
function DistanceCalc (vector1, vector2)
    local dx = vector1.x - vector2.x
    local dy = vector1.y - vector2.y

    local r = math.sqrt(math.pow(dx, 2) + math.pow(dy, 2))

    return math.floor(r)
end

function round(num, numDecimalPlaces)
  if numDecimalPlaces and numDecimalPlaces>0 then
    local mult = 10^numDecimalPlaces
    return math.floor(num * mult + 0.5) / mult
  end
  return math.floor(num + 0.5)
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

local postals = Postals;

function getPostalCoords(postal)
	for _, v in pairs(postals) do 
		if v.code == postal then 
			return {x=v.x, y=v.y};
		end
	end
	return nil;
end

-- @desc Find the nearest postal code to a given vector3 position
-- @param vec3 the vector3 position to check
-- @return postal, postalDist the nearest postal code and its distance from the given position
function NearestPostal(vec3)
    local pos = vec3
    local X, Y = table.unpack(pos)
    local ndm = -1 -- nearest distance magnitude
    local ni = -1 -- nearest index
    for i, p in ipairs(postals) do
        local dm = (X - p.x) ^ 2 + (Y - p.y) ^ 2 -- distance magnitude
        if ndm == -1 or dm < ndm then
            ni = i
            ndm = dm
        end
    end

    --setting the nearest
    if ni ~= -1 then
        local nd = math.sqrt(ndm) -- nearest distance
        nearest = {i = ni, d = nd}
    end
    postal = postals[nearest.i].code;
    postalDist = round(nearest.d, 2);

    return postal, postalDist
end

exports('NearestPostal', NearestPostal)
