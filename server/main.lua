ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('esx_sopletare:getItem')
AddEventHandler('esx_sopletare:getItem', function()

    local luck = math.random(1, 6)

    if luck == 1 then

        local items = { -- add whatever items you want here
            'fishing_lure',
            'bandage',
            'weed_pooch',
            'bread',
            'lotteryticket'
        }

        local player = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(#items)
        local itemfound = ESX.GetItemLabel(randomItems)

        player.addInventoryItem(randomItems, quantity)
        sendNotification(source, 'Du hittade ' .. quantity .. ' st ' .. itemfound, 'success', 2500)

    elseif luck == 4 then

        local weapons = { -- add whatever weapons you want here
            'WEAPON_KNIFE',
            'WEAPON_PISTOL'
        }

        local player = ESX.GetPlayerFromId(source)
        local randomWeapons = weapons[math.random(#weapons)]
        local quantity = math.random(#weapons)
        local weaponfound = ESX.GetWeaponLabel(randomWeapons)

        player.addWeapon(randomWeapons, quantity)
        sendNotification(source, 'Du hittade en ' .. weaponfound, 'success', 2500)
    else
        sendNotification(source, 'Du hittade ingenting, skaffa dig ett jobb kanske?', 'error', 2000)
    end
end)