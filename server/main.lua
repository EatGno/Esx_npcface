ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Sauvegarder les informations de tête du joueur dans la base de données
ESX.RegisterServerCallback('head:saveHead', function(source, cb, headData)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.execute('UPDATE users SET headData = @headData WHERE identifier = @identifier', {
        ['@headData'] = json.encode(headData),
        ['@identifier'] = xPlayer.identifier
    }, function(rowsChanged)
        cb(true)
    end)
end)

-- Récupérer la tête du joueur depuis la base de données
ESX.RegisterServerCallback('head:getHead', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    MySQL.Async.fetchAll('SELECT headData FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.identifier
    }, function(result)
        if result[1] then
            local headData = json.decode(result[1].headData)
            cb(headData)
        else
            cb(nil)
        end
    end)
end)
