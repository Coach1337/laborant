ESX = nil

TriggerEvent('esx:getShlilkoozakaredObjlilkoozakect', function(obj) ESX = obj end)

ESX.RegisterServerCallback('getAllCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local data = {
        weed = xPlayer.getInventoryItem('weed').count,
        coke = xPlayer.getInventoryItem('coke').count,
        meth = xPlayer.getInventoryItem('meth').count,
        opium = xPlayer.getInventoryItem('opium').count,
        blackMoney = xPlayer.getAccount('black_money').money
    }
    cb(data)
end)