ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

ESX["RegisterServerCallback"]("baz_dumpsters:getItem", function(source, cb)
    local player = ESX["GetPlayerFromId"](source)
    local luck = math["random"](1, 6)

    if player then
        if luck == 4 then
            local randomItem = Config["Items"][math["random"](#Config["Items"])]
            local quantity = math["random"](#Config["Items"])
            local itemLabel = ESX["GetItemLabel"](randomItem)

            if player["canCarryItem"](randomItem, quantity) then
                player["addInventoryItem"](randomItem, quantity)
                cb(true, itemLabel, quantity)
            else
                cb(false)
            end
        else
            if Config["EnableWeapons"] then -- disabled by default, enable in the config.
                if luck == 2 then
                    local randomWeapon = Config["Weapons"][math["random"](#Config["Weapons"])]
                    local ammunition = math["random"](#Config["Weapons"])
                    local weaponLabel = ESX["GetWeaponLabel"](randomWeapon)

                    if player["hasWeapon"](randomWeapon) then
                        cb(false)
                    else
                        player["addWeapon"](randomWeapon, ammunition)
                        cb(true, weaponLabel, 1)
                    end
                else
                    cb(false)
                end
            else
                cb(false)
            end
        end
    else
        cb(false)
    end
end)
