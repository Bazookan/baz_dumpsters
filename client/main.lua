ESX = nil
searching = false
cachedDumpsters = {}

Citizen["CreateThread"](function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen["CreateThread"](function()
    while true do
        local sleepThread = 750
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        if searching then DisableControls() end -- Prevent cancel the animation and walk away
        for i = 1, #Config["Dumpsters"] do
            local entity = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(Config["Dumpsters"][i]), false, false, false)

            if DoesEntityExist(entity) then
                sleepThread = 5
                
                if IsControlJustReleased(0, 38) then
                    if not cachedDumpsters[entity] then
                        Search(entity)
                    else
                        ESX.ShowNotification(Strings["Searched"])
                    end
                end

                DrawText3D(GetEntityCoords(entity) + vector3(0.0, 0.0, 1.5), Strings["Search"])
                break
            end
        end

        Citizen.Wait(sleepThread)
    end
end)

DrawText3D = function(coords, text)
    SetDrawOrigin(coords)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 45, 45, 45, 150)
    ClearDrawOrigin()
end

Search = function(entity)
    searching = true
    cachedDumpsters[entity] = true
    TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_SHOPPING_CART", 0, true)
    exports["t0sic_loadingbar"]:StartDelayedFunction(Strings["Searching"], Config["SearchTime"], function()
        ESX.TriggerServerCallback("baz_dumpstersearch:getItem", function(found, object, quantity)
            if found then
                ESX.ShowNotification(Strings["Found"] .. quantity .. "x " .. object)
            else
                ESX.ShowNotification(Strings["Nothing"])
            end
        end)

        searching = false
        ClearPedTasks(PlayerPedId())
    end)
end

DisableControls = function()
    DisableControlAction(0, 73) -- X (Handsup)
    DisableControlAction(0, 323) -- X (Reset)
    DisableControlAction(0, 288) -- F1 (Phone)
    DisableControlAction(0, 289) -- F2 (Inventory)
    DisableControlAction(0, 170) -- F3 (Menu)
    DisableControlAction(0, 166) -- F5 (Menu)
    DisableControlAction(0, 167) -- F6 (Menu)
end
