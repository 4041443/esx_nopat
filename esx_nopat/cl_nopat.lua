function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.6, 0.6)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
	SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.018, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('noppajuttu:nopat')
AddEventHandler('noppajuttu:nopat', function()
	if not perse then
		perse = true
		RequestAnimDict('amb@code_human_in_car_mp_actions@fist_pump@std@rps@base')
		while not HasAnimDictLoaded('amb@code_human_in_car_mp_actions@fist_pump@std@rps@base') do
			Citizen.Wait(1)
		end
		TaskPlayAnim(GetPlayerPed(-1), 'amb@code_human_in_car_mp_actions@fist_pump@std@rps@base', 'idle_a', 1.0, -1.0, -1, 55, 1, 0, 0, 0)
		Citizen.Wait(1000)
		while not IsControlPressed(0, 73) do
			if not IsEntityPlayingAnim(GetPlayerPed(-1), 'amb@code_human_in_car_mp_actions@fist_pump@std@rps@base', 'idle_a', 3) then
				break
			end
			Wait(5)
		end
		Citizen.Wait(500)
		local numero = math.random(1,6).."   "..math.random(1,6)
		x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
		for id = 0, 255 do
			if NetworkIsPlayerActive( id ) then
				if GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
					distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
					if (distance < 10.0) then
						TriggerServerEvent('noppajuttu:arpa', GetPlayerServerId(id), numero)
					end
				end
			end
		end
		TriggerEvent('noppajuttu:numeronnaytto', -1, numero)
		Citizen.Wait(10000)
		perse = false
	end
end)

RegisterNetEvent('noppajuttu:numeronnaytto')
AddEventHandler('noppajuttu:numeronnaytto', function(heittaja, tulos)
	local playerIdx = GetPlayerFromServerId(heittaja)
	local ped = GetPlayerPed(playerIdx)
	for i=1,1500 do
		x3, y3, z3 = table.unpack( GetEntityCoords( GetPlayerPed( playerIdx ), true ) )
		DrawText3Ds(x3,y3,z3, tulos)
		Citizen.Wait(0)
	end
end)

RegisterCommand('nopat', function(source, args, rawCommand)
	TriggerServerEvent('noppajuttu:noppakomento')
end)