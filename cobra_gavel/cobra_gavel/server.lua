-- Initialize Config
local Config = Config or {}

-- Server event to handle gavel sounds
RegisterNetEvent('TLG_gavel:play_gavel_sound', function(soundType)
    local soundFile
    if soundType == "one" then
        soundFile = Config.soundFileOne
    elseif soundType == "three" then
        soundFile = Config.soundFileThree
    end

    for _, value in ipairs(NearbyPlayers()) do
        TriggerClientEvent('TLG_gavel:play_gavel_sound', value.id, soundFile, Config.soundVolume)
    end
end)

function NearbyPlayers()
    local nearbyPlayers = lib.getNearbyPlayers(Config.gavelLocation, Config.maxDistance) -- Example distance
    return nearbyPlayers
end
