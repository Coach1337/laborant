ESX = nil

local PlayerData = {}
etap = 0
IsChecking = false 
IsCloseToPed = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if not IsChecking then
            if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
                if etap == 0 then
                    local player = PlayerPedId()
                    local playerCoords = GetEntityCoords(player)
                    local distance = #(playerCoords - vector3(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z))
                    if distance < Config.PedRespawnDistance then
                        local ped = GetHashKey("s_m_m_doctor_01")

                        RequestModel("s_m_m_doctor_01")

                        while not HasModelLoaded("s_m_m_doctor_01") do
                        Citizen.Wait(100)
                        end

                        pedd = CreatePed(4, ped, Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z -0.95, Config.PedCoords.Heading, true, true)
                        SetEntityInvincible(pedd, true)
                        FreezeEntityPosition(pedd, true)
                        SetBlockingOfNonTemporaryEvents(pedd, true)
                        SetPedCombatAttributes(pedd, 46, true)
                        SetPedFleeAttributes(pedd, 0, 0)
                        SetPedRelationshipGroupHash(pedd, GetHashKey("CIVFEMALE"))
                        etap = 1
                    end
                elseif etap == 1 then
                    local player = PlayerPedId()
                    local playerCoords = GetEntityCoords(player)
                    local distance = #(playerCoords - vector3(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z))
                    if distance < 1.5 then
                        ESX.ShowHelpNotification("Wciśnij ~INPUT_PICKUP~ żeby porozmawiać z laborantem")
                        if IsControlJustPressed(0, 38) then
                            IsChecking = true
                            if IsCloseToPed then
                                ESX.TriggerServerCallback('WeedCount', function(weed)
                                    if IsCloseToPed then
                                        if weed > 0 then
                                            ESX.ShowNotification("Hmm... wygląda to jak zioło, które paliłem wczoraj ze starym. Pozwól, że to sprawdzę!")
                                            Citizen.Wait(Config.ProcessTime)
                                            ESX.ShowNotification("Tak jak myślałem! Marihuana, aż ~y~"..weed.." ~w~gram")
                                            Citizen.Wait(3000)
                                        end
                                    else
                                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                    end
                                    ESX.TriggerServerCallback('CokeCount', function(coke)
                                        if IsCloseToPed then
                                            if coke > 0 then
                                                ESX.ShowNotification("Nareszcie coś białego... jak się okaże, że to znowu mąka to rzucam tą robotę!")
                                                Citizen.Wait(Config.ProcessTime)
                                                ESX.ShowNotification("Lepiej na to popatrz, bo taki widok nie zdarza się często! Aż ~y~"..coke.." ~w~Czyściutka kokaina!")
                                                Citizen.Wait(3000)
                                            end
                                        else
                                            ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                        end
                                        ESX.TriggerServerCallback('MethCount', function(meth)
                                            if IsCloseToPed then
                                                if meth > 0 then
                                                    ESX.ShowNotification("Skąd wy to macie? Z wypadku samochodowego? Czekaj chwile, sprawdzę czy to przypadkiem nie jest meta.")
                                                    Citizen.Wait(Config.ProcessTime)
                                                    ESX.ShowNotification("Czyli jednak, wygląda jak szkło, ale jest to metaamfetamina! Mamy tu aż ~y~"..meth.." ~w~gram")
                                                    Citizen.Wait(3000)
                                                end
                                            else
                                                ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                            end
                                            ESX.TriggerServerCallback('OpiumCount', function(opium)
                                                if IsCloseToPed then
                                                    if opium > 0 then
                                                        ESX.ShowNotification("Jezus jak to koszmarnie wygląda, co wy mi tu przynosicie! Z resztą zaraz to sprawdzę, bo wygląda mi to na opium!")
                                                        Citizen.Wait(Config.ProcessTime)
                                                        ESX.ShowNotification("Moja intuicja znów mnie nie myliła. Jak powiedziałem tak jest, mamy tu opium, a co najważniejsze aż ~y~"..opium.." ~w~gram!")
                                                        Citizen.Wait(3000)
                                                    end
                                                else
                                                    ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                                end
                                                ESX.TriggerServerCallback('BlackMoneyCount', function(blackmoney)
                                                    if IsCloseToPed then
                                                        if blackmoney > 0 then
                                                            ESX.ShowNotification("Ale sporo gotówki! To wypłata dla mnie czy jak? Taki żarcik haha, daj mi chwilę i sprawdzę dla ciebie te pieniądze!")
                                                            Citizen.Wait(Config.ProcessTime)
                                                            ESX.ShowNotification("Mam wynik. Pieniądze są nieopodatkowane i jeszcze jest ich aż ~y~"..blackmoney.."~w~!")
                                                            Citizen.Wait(3000)
                                                            IsChecking = false
                                                        end
                                                    else
                                                        ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                                        IsChecking = false
                                                    end
                                                end)
                                            end)
                                        end)
                                    end)
                                end)
                            else
                                ESX.ShowNotification("~r~Gdzie uciekasz kowboju? Wróć tutaj, bo nie zdążyłem wszystkiego sprawdzić!")
                                break
                            end
                        end
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.PedCoords.x, Config.PedCoords.y, Config.PedCoords.z))
        if distance > 1.5 then
            IsCloseToPed = false
        else
            IsCloseToPed = true
        end
    end
end)