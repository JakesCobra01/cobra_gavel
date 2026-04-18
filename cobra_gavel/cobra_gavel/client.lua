-- Initialize Config
local Config = Config or {}

local hasPlayerLoaded = false
CreateThread(function()
    Wait(10000)
    hasPlayerLoaded = true
end)

-- Client event to handle gavel sounds
RegisterNetEvent('TLG_gavel:play_gavel_sound', function(soundFile, soundVolume)
    if hasPlayerLoaded then
        SendNUIMessage({
            transactionType = 'playSound',
            transactionFile = soundFile,
            transactionVolume = soundVolume
        })
    end
end)

-- Set qb-target BoxZone
exports['qb-target']:AddBoxZone("GavelZone", Config.gavelLocation, 1, 1, {
    name = "Gavel",
    heading = 45,
    debugPoly = false,
    minZ = Config.gavelLocation.z - 1,
    maxZ = Config.gavelLocation.z + 1
}, {
    options = {
        {
            -- groups = "judge", -- ADD PROPER JOB NAME
            name = "Gavel",
            event = "TLG_gavel:play_gavel_sound_server",
            icon = "fa-solid fa-gavel",
            label = "Gavel - one time",
            soundType = "one"
        },
        {
            -- groups = "judge", -- ADD PROPER JOB NAME
            name = "Gavel",
            event = "TLG_gavel:play_gavel_sound_server",
            icon = "fa-solid fa-gavel",
            label = "Gavel - three times",
            soundType = "three"
        }
    }
})

-- EventHandler for clicking inside of the BoxZone
AddEventHandler("TLG_gavel:play_gavel_sound_server", function(targetData)
    TriggerServerEvent('TLG_gavel:play_gavel_sound', targetData.soundType)
end)
