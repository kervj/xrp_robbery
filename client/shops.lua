ESX = exports['es_extended']:getSharedObject()

shops = {}
peds = {}
local isRobbing = false
local robberyBreaked = false
local npc
local vaultCoords
local name
local robberyType 
local robbingTime
local canFinishHeist = false

--[[

    [V] -- Spawnowanie pedów podczas rozpoczynania napadu
    [V] -- Sprawdzanie ilości lspd na służbie
    [V] -- Cooldown na placówkę (chyba)
    [] -- 

    [???] -- Pedy powinny móc uciec po zakończonym napadzie (albo czas, albo przerwanie, albo zakończenie)


]]--

-- coś


-- EVENTY

AddEventHandler('onClientResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, v in pairs(Config.heists.shops) do 
            shops[v.name] = {
                name = v.name,
                vault = v.vault,
                npcSpawn = v.npcSpawn,
                robberyType = v.robberyType,
                robbingTime = v.robbingTime
            }

            shopBlip = AddBlipForCoord(shops[v.name].vault)
            SetBlipSprite(shopBlip, 108)
            SetBlipDisplay(shopBlip, 4)
            SetBlipScale(shopBlip, 1.0)
            SetBlipColour(shopBlip, 4)
            SetBlipAsShortRange(shopBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString('Napad na sejf')
            EndTextCommandSetBlipName(shopBlip)

            exports.ox_target:addBoxZone({
                coords = shops[v.name].vault,
                size = vec3(2, 2, 2),
                rotation = 45,
                debug = true,
                options = {
                    {
                        name = shops[v.name].name,
                        icon = 'fa-solid fa-cube',
                        label = 'Napad na sejf ('..shops[v.name].name..')',
                        onSelect = function(data)
                            npc = shops[v.name].npcSpawn
                            name = shops[v.name].name
                            vaultCoords = shops[v.name].vault
                            robberyType = shops[v.name].robberyType 
                            robbingTime = shops[v.name].robbingTime                           
                            TriggerEvent('xrp_robbery:startShopHeist', npc, name, vaultCoords, robberyType, robbingTime)                            
                        end,
                    },
                    {
                        name = 'Odbiór sianka' ..shops[v.name].name,
                        icon = 'fa-solid fa-cube',
                        label = 'Odbiór sianka',     
                        canInteract = function(entity, distance, coords, name, bone)
                            if canFinishHeist == true then
                                return true
                            else
                                return false
                            end
                        end,
                        onSelect = function(data)
                            finished()
                        end
                    }
                }
            })

        end
    end
    -- print(json.encode(shops))
    RequestModel(-508849828)
	while not HasModelLoaded(-508849828) do
		Wait(1)
	end 
end)

RegisterNetEvent('xrp_robbery:startShopHeist', function(npc, name, vaultCoords, robberyType, robbingTime)
    local weaponHash = GetSelectedPedWeapon(GetPlayerPed(-1))
    local weaponCategory = GetWeapontypeGroup(weaponHash)
    local policecount = 0

    if weaponCategory == GetHashKey("GROUP_UNARMED") then
        ESX.ShowNotification("Nie wyglądasz na groźnego złodziejaszka.", 'info', 3000)
        return
    else
        ESX.TriggerServerCallback('xrp_playerlist:getPlayers', function(players)
            local policecount = 0
            for k, v in pairs(players) do
                if v.job == "police" then
                    policecount = policecount + 1
                end
            end
        end)
        if policecount >= Config.requiredCops.shop then
            ESX.TriggerServerCallback('xrp_robbery:checkCooldown', function(cb, time)
                if cb == true then
                    ESX.TriggerServerCallback('xrp_robbery:checkShopTime', function(cb, time)
                        if cb == true then                            
                            -- createPed(name)               
                            isRobbing = true             
                            robberyStarted(name, robbingTime, vaultCoords)
                        end
                    end)                         
                end
            end)                    
        else                
            ESX.ShowNotification("Brak funkcjonariuszy na służbie.", "info", 3000)
        end       
    end
end)

-- FUNKCJE

function createPed(name)
    for _, v in pairs(shops) do 
        if name == v.name then
            random = math.random(1,#v.npcSpawn)
            for i = 1, random, 1 do                
                hostage = CreatePed(4, -508849828, v.npcSpawn[i].x, v.npcSpawn[i].y, v.npcSpawn[i].z - 1, 0, true, true)
                peds[i] = hostage
                SetBlockingOfNonTemporaryEvents(hostage, true)
                SetPedCanPlayAmbientAnims(hostage, true)
                FreezeEntityPosition(hostage, true)
                TaskPlayAnim(hostage,"random@arrests@busted","idle_a", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
                print(v.npcSpawn[i])
            end
        end
    end
    -- Citizen.Wait(1)
    -- SetBlockingOfNonTemporaryEvents(hostage, false)
    -- ClearPedTasksImmediately(hostage)
    -- FreezeEntityPosition(hostage, false)
end

function deletePeds()
    for id, ped in pairs(peds) do
        if DoesEntityExist(ped) then
            DeletePed(ped)
            peds[id] = nil
        end
    end
end

function robberyStarted(name, robbingTime, vaultCoords)  

    TriggerServerEvent('esx_outlawalert:robberyInProgress', vaultCoords, name)

    ESX.ShowNotification('Rozpocząłeś napad na "'..name..'"' , "info", 3000) 
    local attempts = 0
    isRobbing = false
    robberyBreaked = false
    -- local success = exports['minigame_door']:StartDoor()
   
    while success ~= true do     
        Citizen.Wait(2000)    
        success = exports['cocorp_hack1']:StartHack1(20, 90, false)
        if success then
            isRobbing = true 
            ESX.ShowNotification("Hack udany, gratulacje!")
        else
            attempts = attempts + 1
            print(attempts, "attempts")            
            if attempts == 3 then
                ESX.ShowNotification("No już kurwa za dużo razy próbujesz, bez kitu")
                robberyBreaked = true
                TriggerServerEvent("xrp_robbery:storeCompleted", robberyBreaked, name)
                break
            end
            ESX.ShowNotification("Hack Ci się nie udał byczku, ale bez zmartwień masz jeszcze kilka prób")
        end
    end
    
    -- if success then
    --     ESX.ShowNotification("Hack udany!", "info", 3000)
    --     isRobbing = true
    -- else
    --     ESX.ShowNotification("Hack nie udany! XD", "info", 3000)
    --     -- isRobbing = true
    --     attempts = attempts + 1 
    -- end

    while isRobbing == true and robbingTime ~= 0 do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - vaultCoords) > 7 then
            ESX.ShowNotification("Zaraz przerwiesz sobie napad... Zawróć się do tego sejfu gościu")
            if #(pos - vaultCoords) > 9 then
                ESX.ShowNotification("Napad został przerwany")
                robberyBreaked = true
                robbingTime = 0
                isRobbing = false
                TriggerServerEvent("xrp_robbery:storeCompleted", robberyBreaked, name)            
                break
            end
        end
        robbingTime = robbingTime - 1
        if (robbingTime % 10) == 0 and robbingTime ~= 0 then
            ESX.ShowNotification("Pozostały czas do otwarcia sejfu: "..robbingTime.. " sekund", info, 3000)
        end
        if robbingTime <= 0 then
            ESX.ShowNotification("Sprawdź sejf, powinieneś móc wyciągnąc sianko.")
            robberyBreaked = false
            robbingTime = 0
            isRobbing = false
            canFinishHeist = true
            -- secondHack(name,vaultCoords)
            -- TriggerServerEvent("xrp_robbery:storeCompleted", robberyBreaked, name)
            break
        end
    end
    
end

function finished()
    if canFinishHeist == true then
        TriggerServerEvent("xrp_robbery:storeCompleted", robberyBreaked, name)
        canFinishHeist = false
    else
        ESX.ShowNotification("Nie oszukuj mi tu kurwa")
    end
end