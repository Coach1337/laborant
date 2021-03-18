ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('WeedCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local weedcount = xPlayer.getInventoryItem('weed').count
    cb(weedcount)
end)

ESX.RegisterServerCallback('CokeCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local cokecount = xPlayer.getInventoryItem('coke').count
    cb(cokecount)
end)

ESX.RegisterServerCallback('MethCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local methcount = xPlayer.getInventoryItem('meth').count
    cb(methcount)
end)

ESX.RegisterServerCallback('OpiumCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local opiumcount = xPlayer.getInventoryItem('opium').count
    cb(opiumcount)
end)

ESX.RegisterServerCallback('BlackMoneyCount', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local balckmoneycount = xPlayer.getAccount('black_money').money
    cb(balckmoneycount)
end)