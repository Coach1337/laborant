ESX = nil
local IsChecking = false 
local IsCloseToPed = false
local PedCoords = vector3(444.87, -984.11, 30.69)
local loaded = false
local pedd = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getShlilkoozakaredObjlilkoozakect', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
    loaded = true
end)

Citizen.CreateThread(function()
    while not loaded do
        Citizen.Wait(100)
    end
    local ped = GetHashKey("s_m_m_doctor_01")
    RequestModel("s_m_m_doctor_01")
    while not HasModelLoaded("s_m_m_doctor_01") do
        Citizen.Wait(100)
    end

    pedd = CreatePed(26, ped, PedCoords - vector3(0, 0, 0.95), Config.PedHeading, false, false)
    SetEntityInvincible(pedd, true)
    FreezeEntityPosition(pedd, true)
    SetBlockingOfNonTemporaryEvents(pedd, true)
    SetPedCombatAttributes(pedd, 46, true)
    SetPedFleeAttributes(pedd, 0, 0)
    SetPedRelationshipGroupHash(pedd, GetHashKey("CIVFEMALE"))
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if not IsChecking then
            if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'police' then
                local player = PlayerPedId()
                local playerCoords = GetEntityCoords(player)
                local letSleep, close = false, false
                local distance = #(playerCoords - PedCoords)
                if distance < 1.5 then
                    close = true
                    ESX.ShowHelpNotification("Wciśnij ~INPUT_CONTEXT~ żeby porozmawiać z ~y~laborantem")
                    if IsControlJustPressed(0, 51) then
                        IsChecking = true
                        talkToPed()
                    end
                else
                    letSleep = true
                end

                if letSleep and not close then
                    Citizen.Wait(200)
                end
            else
                Citizen.Wait(200)
            end
        else
            Citizen.Wait(200)
        end
    end
end)

function talkToPed()
    if IsCloseToPed then
        ESX.TriggerServerCallback('getAllCount', function(data)
            if data then
                if data.weed > 0 then
                    ESX.ShowNotification("Hmm... wygląda to jak zioło, które paliłem wczoraj ze starym. Pozwól, że to sprawdzę!")
                    Citizen.Wait(Config.ProcessTime)
                    if IsCloseToPed then
                        ESX.ShowNotification("Tak jak myślałem! Marihuana, aż ~y~"..data.weed.." ~w~gram")
                        Citizen.Wait(3000)
                    else
                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                        IsChecking = false
                        return
                    end
                end
                if data.coke > 0 then
                    ESX.ShowNotification("Nareszcie coś białego... jak się okaże, że to znowu mąka to rzucam tą robotę!")
                    Citizen.Wait(Config.ProcessTime)
                    if IsCloseToPed then
                        ESX.ShowNotification("Lepiej na to popatrz, bo taki widok nie zdarza się często! Aż ~y~"..data.coke.." ~w~Czyściutka kokaina!")
                        Citizen.Wait(3000)
                    else
                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                        IsChecking = false
                        return
                    end
                end
                if data.meth > 0 then
                    ESX.ShowNotification("Skąd wy to macie? Z wypadku samochodowego? Czekaj chwile, sprawdzę czy to przypadkiem nie jest meta.")
                    Citizen.Wait(Config.ProcessTime)
                    if IsCloseToPed then
                        ESX.ShowNotification("Czyli jednak, wygląda jak szkło, ale jest to metaamfetamina! Mamy tu aż ~y~"..data.meth.." ~w~gram")
                        Citizen.Wait(3000)
                    else
                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                        IsChecking = false
                        return
                    end
                end
                if data.opium > 0 then
                    ESX.ShowNotification("Jezus jak to koszmarnie wygląda, co wy mi tu przynosicie! Z resztą zaraz to sprawdzę, bo wygląda mi to na opium!")
                    Citizen.Wait(Config.ProcessTime)
                    if IsCloseToPed then
                        ESX.ShowNotification("Moja intuicja znów mnie nie myliła. Jak powiedziałem tak jest, mamy tu opium, a co najważniejsze aż ~y~"..data.opium.." ~w~gram!")
                        Citizen.Wait(3000)
                    else
                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                        IsChecking = false
                    end
                end
                if data.blackMoney > 0 then
                    ESX.ShowNotification("Ale sporo gotówki! To wypłata dla mnie czy jak? Taki żarcik haha, daj mi chwilę i sprawdzę dla ciebie te pieniądze!")
                    Citizen.Wait(Config.ProcessTime)
                    if IsCloseToPed then
                        ESX.ShowNotification("Mam wynik. Pieniądze są nieopodatkowane i jeszcze jest ich aż "..data.blackMoney.."~y~$~w~!")
                        Citizen.Wait(3000)
                        IsChecking = false
                    else
                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                        IsChecking = false
                        return
                    end
                end
            end
        end)
    else
        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        distance = #(GetEntityCoords(PlayerPedId()) - PedCoords)
        if distance > 1.5 then
            IsCloseToPed = false
        else
            IsCloseToPed = true
        end
    end
end)