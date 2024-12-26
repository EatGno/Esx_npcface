ESX = nil
local playerPed = PlayerPedId()

Citizen.CreateThread(function()
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    while ESX == nil do
        Citizen.Wait(100)
    end
end)

-- Fonction pour appliquer la tête du joueur au modèle
RegisterNetEvent('head:setPlayerHead')
AddEventHandler('head:setPlayerHead', function(model)
    local playerPed = PlayerPedId()

    -- Vérifier si le modèle existe
    RequestModel(model)
    while not HasModelLoaded(model) do
        Citizen.Wait(500)
    end

    SetPlayerModel(PlayerId(), model)  -- Appliquer le modèle du joueur
    SetModelAsNoLongerNeeded(model)    -- Libérer le modèle pour éviter les fuites de mémoire

    -- Charger et appliquer la tête du joueur
    TriggerServerEvent('head:getHead', function(headData)
        if headData then
            -- Appliquez ici la tête en fonction de la structure de `headData`
            -- Exemple : Appliquer les propriétés de la tête
            -- Vous devrez ici gérer les aspects du visage comme la couleur des yeux, des cheveux, etc.
            -- L'idée est d'extraire les données du `headData` et de les appliquer ici.
            SetEntityHeadshot(playerPed, headData)
        end
    end)
end)

-- Sauvegarder la tête du joueur
RegisterCommand('saveHead', function()
    local headData = { -- Exemple d'extraction de la tête
        model = GetEntityModel(playerPed),
        headshot = GetEntityHeadshot(playerPed),  -- Cette fonction est fictive, à remplacer par la bonne fonction
    }

    -- Sauvegarder la tête dans la base de données
    TriggerServerEvent('head:saveHead', headData)
end, false)
