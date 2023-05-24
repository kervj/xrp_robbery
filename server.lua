ESX = exports['es_extended']:getSharedObject()
local lastShopheist
local lastHeist
--[[

    [V] - Sprawdzanie ilości lspd na służbie
    [V] - Sprawdzanie wymaganych itemów do rozpoczęcia napadu
    [V] - Wypłacanie wygranej
    [V] - Sprawdzanie global cd i zwykłego cd na napady
    [V] - Respienie pedów 
    [V] - Triggerowanie gierek
    [V] - Zabezpieczenie przed odpalaniem w tym samym momencie
]]--

shops ={}

AddEventHandler('onResourceStart', function(resourceName)    
    if resourceName == GetCurrentResourceName() then
        for _, v in pairs(Config.heists.shops) do 
            shops[v.name] = {
                name = v.name,
                vault = v.vault,
                npcSpawn = v.npcSpawn,
                reward = v.reward
            }
        end
    end
end)

ESX.RegisterServerCallback('xrp_robbery:checkShopTime', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentTime = os.time()

    if lastShopheist == nil or currentTime - lastShopheist > Config.cooldowns.shopCd then
        lastShopheist = currentTime
        cb(true)
    else
        local time = currentTime - lastShopheist
        cb(false, time)
        TriggerClientEvent('esx:showNotification', source, 'Ktoś niedawno przeprowadził rabunek na ten punkt.')
    end
end)

ESX.RegisterServerCallback('xrp_robbery:checkCooldown', function(source, cb, time)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentTime = os.time()
    if lastHeist == nil or currentTime - lastHeist > Config.cooldowns.globalCd then
        lastHeist = currentTime
        cb(true)
    else
        local time = currentTime - lastHeist
        local elapsedTime = math.floor((Config.cooldowns.globalCd - time ) / 60) -- MINUTY
        TriggerClientEvent('esx:showNotification', source, 'Ktoś niedawno przeprowadził rabunek na ten, lub podobny punkt.')
        TriggerClientEvent('esx:showNotification', source, 'Następny napad będzie możliwy za około: '..elapsedTime..' minut.')
        
        cb(false, time)
    end
end)


RegisterNetEvent('xrp_robbery:storeCompleted', function(robberyBreaked, name)
    local xPlayer = ESX.GetPlayerFromId(source)
    local currentTime = os.time()

    print(robberyBreaked, "robberyBreakead")

    if robberyBreaked then
        lastHeist = currentTime
        TriggerclientEvent("esx:showNotification", source, "Napad został przerwany, uciekaj!")
    else
        for _,v in pairs(shops) do
            if name == shops[v.name]["name"] then
                name = shops[v.name]["name"]
                reward = shops[v.name]["reward"]
            end
        end
        rwrd = math.random(reward[1], reward[2])
        reward = math.ceil(rwrd)
        exports.ox_inventory:AddItem(source, "money", reward)
        TriggerClientEvent('esx:showNotification', source, "Otrzymałeś gotówkę za napad w wysokości "..reward..", pozdro.")
        lastHeist = currentTime
    end        
end)


--[[
    exports['xrp_log']:log('ChooseCharOwner', 
    'Postać: '..xPlayer.name ..' została załadowana'..
    '\n'..GetPlayerIdentifierByType(playerId, 'steam')..
    '\n'..GetPlayerIdentifierByType(playerId, 'license')..
    '\n'..GetPlayerIdentifierByType(playerId, 'license2')..
    '\n'..GetPlayerIdentifierByType(playerId, 'discord')..
    '\n'..GetPlayerIdentifierByType(playerId, 'ip'), 
    GetCurrentResourceName())
]]--